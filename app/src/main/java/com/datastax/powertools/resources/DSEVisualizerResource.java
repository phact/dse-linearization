package com.datastax.powertools.resources;

import com.codahale.metrics.annotation.Timed;
import com.datastax.driver.core.LocalDate;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.dse.DseSession;
import com.datastax.driver.mapping.MappingManager;
import com.datastax.driver.mapping.Result;
import com.datastax.driver.mapping.annotations.Accessor;
import com.datastax.driver.mapping.annotations.Column;
import com.datastax.driver.mapping.annotations.Query;
import com.datastax.driver.mapping.annotations.Table;
import com.datastax.powertools.DSEVisualizerConfig;
import com.datastax.powertools.managed.Dse;
import com.fasterxml.jackson.annotation.JsonProperty;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 * Created by sebastianestevez on 6/1/18.
 */
@Path("/v0/dse-visualizer")
public class DSEVisualizerResource {
    private final Dse dse;
    private final DseSession session;
    private final DSEVisualizerConfig config;

    private static final String ALL_EVENTS = "select * from dsbank.ledger;";
    private PreparedStatement allEvents;

    @Accessor
    public interface LedgerAccessor {
        @Query(ALL_EVENTS)
        Result<LedgerEvent> getAll();
    }

    @Table(keyspace = "dsbank", name = "ledger",
            readConsistency = "QUORUM",
            writeConsistency = "QUORUM")
    public static class LedgerEvent implements Serializable {

        @Column(name = "accountid")
        @JsonProperty
        private String accountId;

        @Column(name = "from_accountid")
        @JsonProperty
        private String fromAccountID;

        @JsonProperty
        @Column(name = "first_name")
        private String firstName;

        @JsonProperty
        @Column(name = "last_name")
        private String lastName;

        @JsonProperty
        @Column(name = "company_name")
        private String companyName;


        @JsonProperty
        @Column(name = "transactionid")
        private String transactionId;

        @JsonProperty
        @Column(name = "balance_snapshot")
        private double balanceSnapshot;

        @JsonProperty
        @Column(name = "amount")
        private double amount;

        @JsonProperty
        @Column(name = "create_date")
        private LocalDate create_date;

        @Column(name = "lat")
        @JsonProperty
        private float lat;

        @Column(name = "lon")
        @JsonProperty
        private float lon;

        @Column(name = "to_lat")
        @JsonProperty
        private float toLat;

        @Column(name = "to_lon")
        @JsonProperty
        private float toLon;
    }

    public DSEVisualizerResource(Dse dse, DSEVisualizerConfig config) {
        this.dse = dse;
        this.config = config;
        this.session = dse.getSession();

        allEvents = session.prepare(ALL_EVENTS);
    }

    @GET
    @Timed
    @Path("/fullLedger")
    @Produces(MediaType.APPLICATION_JSON)
    public List<LedgerEvent> getAllEvents() {
        try {
            String query =  ALL_EVENTS;

            MappingManager manager = new MappingManager(session);

            LedgerAccessor veMapper= manager.createAccessor(LedgerAccessor.class);

            Result<LedgerEvent> result = veMapper.getAll();

            List<LedgerEvent> output = result.all();

            return output;

        }catch (Exception e){
            System.out.println(e.toString());
            e.printStackTrace();
            return null;
        }
    }
}
