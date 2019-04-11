import Vue from "vue";
import Router from "vue-router";
import bak from "@/components/bak";
import create1 from "@/components/create1";
import create2 from "@/components/create2";
import page1 from "@/components/page1";
import page2 from "@/components/page2";
import page3 from "@/components/page3";
import page4 from "@/components/page4";
import page5 from "@/components/page5";
import page6 from "@/components/page6";
import page7 from "@/components/page7";
import page8 from "@/components/page8";
import page9 from "@/components/page9";
import detail from "@/components/detail";
import register from "@/components/register";
import blocklist from "@/components/blocklist";
import transactionlist from "@/components/transactionlist";
import accountlist from "@/components/accountlist";
import ipfslist from "@/components/ipfslist";

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: "/create1",
      name: "create1",
      component: create1
    },
    {
      path: "/create2",
      name: "create2",
      component: create2
    },
    {
      path: "/",
      name: "page1",
      component: page1
    },
    {
      path: "/page2",
      name: "page2",
      component: page2
    },
    {
      path: "/page3",
      name: "page3",
      component: page3
    },
    {
      path: "/page4",
      name: "page4",
      component: page4
    },
    {
      path: "/page5",
      name: "page5",
      component: page5
    },
    {
      path: "/page6",
      name: "page6",
      component: page6
    },
    {
      path: "/page7",
      name: "page7",
      component: page7
    },
    {
      path: "/page8",
      name: "page8",
      component: page8
    },
    {
      path: "/page9",
      name: "page9",
      component: page9
    },
    {
      path: "/detail",
      name: "detail",
      component: detail
    },
    {
      path: "/register",
      name: "register",
      component: register
    },
    {
      path: "/bak",
      name: "bak",
      component: bak
    },
    {
      path: "/blocklist",
      name: "blocklist",
      component: blocklist
    },
    {
      path: "/transactionlist",
      name: "transactionlist",
      component: transactionlist
    },
    {
      path: "/accountlist",
      name: "accountlist",
      component: accountlist
    },
    {
      path: "/ipfslist",
      name: "ipfslist",
      component: ipfslist
    }
  ]
});
