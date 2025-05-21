// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { parseEther } from "viem";

const ContactModule: any = buildModule("ContactBook", (m) => {
  const Contact = m.contract("ContactBook", []);

  return { Contact };
});

export default ContactModule;
