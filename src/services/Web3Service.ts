import Router from "next/router";
import { ethers } from "ethers";
import KolumnArtifact from "../abis/KolumnKontract.json";

declare let window: any;
const address = KolumnArtifact.networks[5777].address;

export const Web3Service = {
  //Add Event Listners and check for Metamask
  init: async () => {
    if (typeof window.ethereum !== "undefined") {
      window.ethereum.on("accountsChanged", () => {
        Router.reload();
      });
      window.ethereum.on("disconnect", () => {
        console.log("Disconnected");
        Router.reload();
      });
      window.ethereum.on("connect", () => {
        console.log("Connected!");
      });
      window.ethereum.on("chainChanged", () => {
        Router.reload();
      });
    } else {
      throw Error("Metamask Not Found");
    }
  },
  //Connect to Metamask
  connect: async () => {
    await window.ethereum.request({ method: "eth_requestAccounts" });
  },
  //Check if user is connected to metamask or not
  isConnected: async () => {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    try {
      await signer.getAddress();
      return true;
    } catch {
      return false;
    }
  },
};
