import Web3 from 'web3';
import { Contract } from 'web3-eth-contract';
import { tradeOfferAddress } from './constants';
import tradeOffer from './contracts/tradeOffer';

export default class Wrapper {
    web3: Web3;
    chainId: number;
    account: string;
    wrapperOptions: any;    
    Contract: tradeOffer;

    constructor(web3: Web3, chainId: number, account: string, options = {}) {
        this.web3 = web3;
        this.chainId = chainId;
        this.account = account;

        this.wrapperOptions = {
            web3,
            chainId,
            account,
            ...options
        };

        this.Contract = new tradeOffer(this.wrapperOptions, tradeOfferAddress.Contract[this.chainId]);
    }

    export async function makeOffer(
        contractAddress: string,
        signer: ethers.Signer,
        offerAmounts: Array<number>,
        wantedAmounts: Array<number>
      ): Promise<number> {
        const contract = new Contract(contractAddress, tradeOfferABI, signer);
      
        try {
          const transaction = await contract.makeOffer(
            offerAmounts,
            wantedAmounts
          );
      
          await transaction.wait();
      
          // Get the latest offer ID
          const offerCounter = await contract.offerCounter();
          return offerCounter.toNumber() - 1;
        } catch (error) {
          console.error("Error making offer:", error);
          throw error;
        }
      }
      
      export async function acceptOffer(
        contractAddress: string,
        signer: ethers.Signer,
        offerId: number
      ): Promise<void> {
        const contract = new Contract(contractAddress, tradeOfferABI, signer);
      
        try {
          const transaction = await contract.acceptOffer(offerId);
          await transaction.wait();
        } catch (error) {
          console.error("Error accepting offer:", error);
          throw error;
        }
      }
      
      export async function withdrawOffer(
        contractAddress: string,
        signer: ethers.Signer,
        offerId: number
      ): Promise<void> {
        const contract = new Contract(contractAddress, tradeOfferABI, signer);
      
        try {
          const transaction = await contract.withdraw(offerId);
          await transaction.wait();
        } catch (error) {
          console.error("Error withdrawing offer:", error);
          throw error;
        }
      }
      
      export async function getContractAssets(
        contractAddress: string
      ): Promise<Array<number>> {
        const contract = new Contract(contractAddress, tradeOfferABI);
      
        try {
          const [balance1, balance2, balance3, balance4, balance5] =
            await contract.getContractAssets();
          return [balance1.toNumber(), balance2.toNumber(), balance3.toNumber(), balance4.toNumber(), balance5.toNumber()];
        } catch (error) {
          console.error("Error getting contract assets:", error);
          throw error;
        }
      }
      
      export async function getOffer(
        contractAddress: string,
        offerId: number
      ): Promise<[number, number, number, number, number, number, number, number, number, number]> {
        const contract = new Contract(contractAddress, tradeOfferABI);
      
        try {
          const offer = await contract.getOffer(offerId);
          return offer.map((value: ethers.BigNumber) => value.toNumber());
        } catch (error) {
          console.error("Error getting offer:", error);
          throw error;
        }
      }
      
      export async function getOfferString(
        contractAddress: string,
        offerId: number
      ): Promise<string> {
        const contract = new Contract(contractAddress, tradeOfferABI);
      
        try {
          const offerString = await contract.getOfferString(offerId);
          return offerString;
        } catch (error) {
          console.error("Error getting offer string:", error);
          throw error;
        }
      }
