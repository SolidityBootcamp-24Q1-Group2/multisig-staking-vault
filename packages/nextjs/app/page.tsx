"use client";

import React, { useState } from "react";
import Link from "next/link";
import type { NextPage } from "next";
import { BugAntIcon, MagnifyingGlassIcon } from "@heroicons/react/24/outline";
import { IntegerInput } from "~~/components/scaffold-eth";
import deployedContracts from "../contracts/deployedContracts";


interface StakeStrategy {
  apy: number;
  id: string;
}

const stakeStrategies: StakeStrategy[] = [
  {
    apy: 20,
    id: "1",
  },
  {
    apy: 15,
    id: "2",
  },
  {
    apy: 10,
    id: "3",
  },
];

const Home: NextPage = () => {
  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="flex-grow bg-base-300 w-full mt-16 px-8 py-12">
          <div className="flex justify-center items-center gap-12 flex-col sm:flex-row">
            <Vault strategy={stakeStrategies[0]}></Vault>
            <Vault strategy={stakeStrategies[1]}></Vault>
            <Vault strategy={stakeStrategies[2]}></Vault>
          </div>
        </div>
        <div className="flex-grow bg-base-300 w-full mt-16 px-8 py-12">
          <div className="flex justify-center items-center gap-12 flex-col sm:flex-row">
            <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
              <BugAntIcon className="h-8 w-8 fill-secondary" />
              <p>
                Tinker with your smart contract using the{" "}
                <Link href="/debug" passHref className="link">
                  Debug Contracts
                </Link>{" "}
                tab.
              </p>
            </div>
            <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
              <MagnifyingGlassIcon className="h-8 w-8 fill-secondary" />
              <p>
                Explore your local transactions with the{" "}
                <Link href="/blockexplorer" passHref className="link">
                  Block Explorer
                </Link>{" "}
                tab.
              </p>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};


function Vault(params: {strategy: StakeStrategy}) {
  const { strategy: { apy } } = params;
  const [vaultAmount, setVaultAmount]= useState<string | bigint>("");
  //const { data: dataStake, isLoading: isLoadingStake, isError: isErrorStake, isSuccess: isSuccessStake, write: writeStake } = useContractWrite({
  //  address: deployedContracts[11155111].Staking.address,
  //  abi: deployedContracts[11155111].Staking.abi,
  //  functionName: 'stake',
  //  args: [vaultAmount],
  //})

  //const { data: dataUnstake, isLoading: isLoadingUnstake, isError: isErrorUnstake, isSuccess: isSuccessUnstake, write: writeUnstake } = useContractWrite({
  //  address: deployedContracts[11155111].Staking.address,
  //  abi: deployedContracts[11155111].Staking.abi,
  //  functionName: 'unstake',
  //  args: [vaultAmount],
  //})

  return (
    <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
    <h1>Strategy {apy}</h1>
    <p> Vault {apy}% APY</p>
    <IntegerInput
      value={vaultAmount}
      onChange={e => setVaultAmount(e)}
      name="deposit"
      placeholder="Deposit Amount"
    />

    <div className="flex flex-row" >
      <button
        className="btn btn-active btn-neutral flex-grow mt-4 mr-2"
        //disabled={"0"}
        type="button"
        //disabled={isLoadingStake}
        onClick={() => {
          //writeStake({
          //  args: [vaultAmount],
          //})
        }}
      >
        Stake
      </button>

      <button
        className="btn btn-active btn-neutral flex-grow mt-4"
        //disabled={isLoadingUnstake}
        type="button"
        onClick={() => {
          //writeUnstake({
          //  args: [vaultAmount],
          //})
        }}
      >
        Withdraw
      </button>
    </div>

  </div>
  )
}
export default Home;
