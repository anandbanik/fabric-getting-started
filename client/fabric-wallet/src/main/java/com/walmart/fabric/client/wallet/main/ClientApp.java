package com.walmart.fabric.client.wallet.main;


import java.nio.file.Path;
import java.nio.file.Paths;

import org.hyperledger.fabric.gateway.Contract;
import org.hyperledger.fabric.gateway.Gateway;
import org.hyperledger.fabric.gateway.Network;
import org.hyperledger.fabric.gateway.Wallet;
import org.hyperledger.fabric.gateway.Wallets;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ClientApp {
	
	Logger logger = LoggerFactory.getLogger(ClientApp.class);

	static {
		System.setProperty("org.hyperledger.fabric.sdk.service_discovery.as_localhost", "true");
	}

	public static void main(String[] args) {
		ClientApp clientApp = new ClientApp();
		clientApp.queryCars();
	}

	public void queryCars() {
		try {

			// Load a file system based wallet for managing identities.
			Path walletPath = Paths.get("wallet");
			Wallet wallet = Wallets.newFileSystemWallet(walletPath);
			// load a CCP
			Path networkConfigPath = Paths.get("..","..", "test-network", "organizations", "peerOrganizations",
					"org1.example.com", "connection-org1.yaml");

			Gateway.Builder builder = Gateway.createBuilder();
			builder.identity(wallet, "clientUser").networkConfig(networkConfigPath).discovery(true);

			// create a gateway connection
			try (Gateway gateway = builder.connect()) {

				// get the network and contract
				Network network = gateway.getNetwork("mychannel");
				Contract contract = network.getContract("fabcar");
				
				//contract.

				byte[] result;

				
				
				/*
				 * result = contract.evaluateTransaction("queryAllCars"); logger.info(new
				 * String(result));
				 * 
				 * 
				 * 
				 * 
				 * 
				 * contract.submitTransaction("createCar", "CAR11", "Audi", "Q5", "Blue",
				 * "Anand");
				 * 
				 * result = contract.evaluateTransaction("queryCar", "CAR11"); logger.info(new
				 * String(result));
				 * 
				 * contract.submitTransaction("changeCarOwner", "CAR11", "Abanik");
				 * 
				 * 
				 * 
				 * 
				 * result = contract.evaluateTransaction("queryCar", "CAR11"); logger.info(new
				 * String(result));
				 * 
				 * 
				 * result = contract.evaluateTransaction("queryCarsByColor", "Blue");
				 * logger.info("By Color: "+new String(result));
				 */
				  
				  result = contract.evaluateTransaction("queryCarsByCompositeKey", "Punto");
				  logger.info("By Model: "+new String(result));
				 
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

}
