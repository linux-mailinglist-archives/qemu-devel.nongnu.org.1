Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D4C72BB11
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 10:45:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8dAU-00061D-RX; Mon, 12 Jun 2023 04:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1q8dAT-00060q-H8
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:44:53 -0400
Received: from mail-tycjpn01on20711.outbound.protection.outlook.com
 ([2a01:111:f403:7010::711]
 helo=JPN01-TYC-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1q8dAR-0007iY-Rs
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:44:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0zwkarMEhPYUHijJ0g5y7exBTaYC+crSXA4PWn8mzXTdNbvl8Kofuq+miriWLlEzz0BYIELMcYnjRN227WM80y7KIqkj6r3ZQM8rCkiCgFY97afLVVLe8jy4UquqUeTNMafGJJ38w6vrzlp3uBzqokm6OqmVoxBe7HA8ckEXcDggoGhzp31BdXZJCHXOnNF/ffw4CqFtjwXkQjDEps3XAXm600OFrar9s+hNUlWR1UGYgwV5hRcJ87PIhJNUuOl5A0awEKPMJk79gmq+v0AGB6FKE2M05nLjaLipzSA+2NwmAJbJllbENkvMNZDElBFlp0ZvPSA+4SYu8wPhIWX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3xt1SExKKDJ0/Z4Ip7uAaq0v/q+71QexqvdT/gf4Q8=;
 b=Nlsh1p+mqsuHg5QaY5LQV7n63+2GTmGomygqb41TisernelCWgyCXcy0vFE/T7eUtCnLqh9010jHRlauFISNou4HDQuVAyp8VMTrdLjL/zRUM9+OKQV04KbbTt0xbtdLXTWcabbfq0yFXhoUKMv7hP7OzyUsrrygGucLdI00ZzRRPplM9RiaO/k7gQvdEmTwVXItIhck9HtviGcQnJ8pK/XkmuZpo1ftyIpojnzvOj1h4iT7PPcl/Dktm27CiuIWb69s9uL3K2Gu+gPQBAZKuzGnU5y9sxwSxKqrFop1r/Ydi6R8tNNlUyl3A7i7mq+m93m9MuZP5trZDQQiJCESMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3xt1SExKKDJ0/Z4Ip7uAaq0v/q+71QexqvdT/gf4Q8=;
 b=JYREHPXtkzUsNrp04obo/ZYtGHGCsWoYBRYDIV0kKyDNYb0bfLqI32Z9Z7Gxa+A9zTsxnE9cqGcXgM42e8evoH/+RfMnyfhHQskqVZmVlXJn4Elw2+8Hva45oJ5Dtq+6jyJYYCWFRUgfLIQa3YDzDkGrU9ojA5rXs3uTEIcxzEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYWP286MB2652.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Mon, 12 Jun 2023 08:44:47 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a0fc:750e:507b:2606]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a0fc:750e:507b:2606%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 08:44:47 +0000
Date: Mon, 12 Jun 2023 16:44:40 +0800
From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
To: Gerd Hoffmann <kraxel@redhat.com>,
	"Canokeys.org" <contact@canokeys.org>
Cc: qemu-devel@nongnu.org, tlaurion <insurgo@riseup.net>
Subject: [PATCH 2/2] docs/system/devices/canokey: update implementations and
 web console
Message-ID: <ZIba+AVgTb/Sutdc@Sun>
References: <ZIbY8nBXQbv2qZJ8@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIbY8nBXQbv2qZJ8@Sun>
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|TYWP286MB2652:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b13be3e-82d9-409d-9452-08db6b2146e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OL7r5m8rd3SIemMr6cyo0BiEbb5/hX9emAvuFaOfj2p+VM+fknzXANF8Uvl3JmlxKzXIYi+OtLc2q+nVciz09slZt9WuoOfBefxiQax2ZttF7CdrQmzqiMqlR8BYaapKYyzLULAQ6akJ90plz4v73dnmvJKpiQRE4kEqSrQOAL6xT9rCrb4RreOsq6LTgvIMlRQiuy1/NbKL4LRdpK6Hjj6mP8Ot1mGc6l/J6NHh1UrN+TtaWhg2Ph6bBID5Zk4M4xfIFoGqkHaIVudoQGJpqlf6x+5gS7yuNRGFs99HFSqjne/FYr26J6Q8TTj67eynRUxAJVJPiJ5mze+YZOa4QGpUpx7W1s/A+wEJiY/8oAMZldvYJubbHPiKiRWjwEmL9j12+6KPsieRnm1mA5FSuUufFbw9YhsrpyEy8Ar6m77xFG5XwbWxnD+nNF4KumC3QYMuofZR8SwXKuTR/jxFbAe1uvsWHYXXfFlzOMJdnc0srEB4l/kt71LEz9WYmF1YY7UsQWgBHToFmhS1kmoM5hyjTRHOtMMJ04IVNSrKQQMRlMetQOU1Nw66yXHSaUworZ6f0nWWHVYEVAFOfmjsyMRApdh6aNa6IOfNbIiILdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(346002)(39830400003)(136003)(396003)(376002)(366004)(451199021)(786003)(316002)(6486002)(41300700001)(83380400001)(86362001)(33716001)(186003)(9686003)(6512007)(6506007)(41320700001)(2906002)(38100700002)(5660300002)(8936002)(8676002)(66946007)(66556008)(110136005)(6666004)(478600001)(4326008)(66476007)(49092004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7LOykN0H0xaC2hvX/gPecVGybPCWoQmi4fVvYk8s7Q7aVDJEemnstjJSO3Mh?=
 =?us-ascii?Q?46/mtMakqEWIOKq3HqpZ79InKjkOUGmaIG5mi/HQKBWlLG5hHwBEQjcStMZe?=
 =?us-ascii?Q?QnjP+CwwIf/oUJskgSA5pC23oOgpQsAvXtzJL3PgbYwtisWeYlY5qn88qpDD?=
 =?us-ascii?Q?ZSvA3T0cPYO68rce41/o1Vn8cSLY9KWOaJPEPAOoXjmv1W7qL3vfFARCZWav?=
 =?us-ascii?Q?12qZiyumsUIDHOGDmgojZOrN9lPbhO6LgH00xHxDizkAvYq/6qV6An+GkALS?=
 =?us-ascii?Q?EFAKdYqsRDz/1ghjpJYLdN5EPDAhtY6avsWkmjdQ6NVkJwarfqSe7jjpWL8J?=
 =?us-ascii?Q?kgQt3lFsPHs1KbsZ4fk2dndcnLjdzE9BQKaoPzrtm6fVa7nbkRVw2MpBPIk3?=
 =?us-ascii?Q?EgubtTixej/h+DiegPzXfPqpbG9irO69UzeivxAtVAl4O4vhHh5SiUZQrrg5?=
 =?us-ascii?Q?6tKtieVbyiJsNB/rEs/RjEksONn4moc28b0UXKKAJfRjePZgkKshgmnUAS6m?=
 =?us-ascii?Q?whfKHMFHJ5DdcRz70A/PYB6dIpx0K1zfnlC0th20vNm3fAf17+GVfn2ZCJy/?=
 =?us-ascii?Q?xKYk9lv2TS3U7X1etJL4wvcF8+u8o371nQkiZKWe4VOZFcTE8WiF6XJIdvrN?=
 =?us-ascii?Q?ugJtzd6qsj4pD5gDq1yDnVeeTl84Fej3sgWq1hyPZtVuyQaYQ9iYjYd9FvfM?=
 =?us-ascii?Q?7/jIBM7I8WWpvntN0wzH2kuhdRLuZeNbBiNCYTuYh0jAc8+lDP86I+te1EB2?=
 =?us-ascii?Q?xCSAfwQ5Jq6e4dLCHKuIr9nz9jynUS4jpaZI5/lPRdwT2oEkhKCRee2ugljQ?=
 =?us-ascii?Q?agHjacKyvaybC3xLED951//+dFYz0FvNSOWOdCMOYgJGoGUNfWCI5J329kzh?=
 =?us-ascii?Q?Fy48HJ06H+yVmmTSJ3UIGebgEEPXXLIwbSPxT64rJH4APoHdqxe2JUtH77Yz?=
 =?us-ascii?Q?WSzxedwVzl7ChJx2cwq3hk0jt5lPGHenM1xpitv71Sfz+zn1oUsN3wtJjyfJ?=
 =?us-ascii?Q?LVS09elM3U4txJRzq8qvs/a11ih4ndmAWbLLNbPv77jH8T02YGxq6tSLgEf1?=
 =?us-ascii?Q?cLjfLiQS+Il3Sua4jS+9vh2VJHzAQ8WZJQjsO9+KABxH5RwC7nNPaEMd+3PU?=
 =?us-ascii?Q?7/XNmRYRI/or9Y6jRizXVIgCyQOmJa6LD2xp/EU/7yzBkfhaj+TvyhHsyiGV?=
 =?us-ascii?Q?FguEahpsjISOvZAcZrOmZb43Wr/Npxgdj/K2+VwyBIUAHykideMfNdc+yQUm?=
 =?us-ascii?Q?THuQOUa7JdEGINdf2M8xZObLdLebl0gKa4TC+zslvRsg6VSrEVSKvALNx9Om?=
 =?us-ascii?Q?eBmKLOZSJ6q2vXVNZvJOe0pSMA/+0TnAJmNklyIS2zekNKWG5QjgbMIwgRSM?=
 =?us-ascii?Q?LWSyA+gfdbDQDnifeJYVb1vUNnMjOhjskcEcRl1wynn7MpfnwAFxHnaG69Tx?=
 =?us-ascii?Q?fSrzimAKRfkAiw8GnP5iBfiCw1P/0m5WH5bficWG85Z8AdU/1REw5u4O0J49?=
 =?us-ascii?Q?RnX0Ym6iU1EiNLB8qWb4SwDNzqURwjsgWpN21aiaHYNBDsBJpu7qUC4Ob2cP?=
 =?us-ascii?Q?UGU7JDCQHPZpg58o870hLQ4ja9QAWSW8bw08bIzK?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b13be3e-82d9-409d-9452-08db6b2146e7
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 08:44:47.1926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN3jo6Pe48AiZ/vW1aJNk9n7SWzin690rhruyGEyBq2/2SibjDh0QbuXbApih+E4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2652
Received-SPF: pass client-ip=2a01:111:f403:7010::711;
 envelope-from=i@zenithal.me;
 helo=JPN01-TYC-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

An nRF52 implementation and a new web console was introduced.

The old web console is hosted in a different URL now.

Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
---
 docs/system/devices/canokey.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/canokey.rst b/docs/system/devices/canokey.rst
index 5492e6792c..9b8f404fe8 100644
--- a/docs/system/devices/canokey.rst
+++ b/docs/system/devices/canokey.rst
@@ -18,6 +18,7 @@ including both hardware implementions and virtual cards:
 
 * CanoKey STM32 [4]_
 * CanoKey Pigeon [5]_
+* CanoKey nRF52 [6]_
 * (virt-card) CanoKey USB/IP
 * (virt-card) CanoKey FunctionFS
 
@@ -100,7 +101,7 @@ and find CanoKey QEMU there:
     $ lsusb
     Bus 001 Device 002: ID 20a0:42d4 Clay Logic CanoKey QEMU
 
-You may setup the key as guided in [6]_. The console for the key is at [7]_.
+You may setup the key as guided in [7]_. The console for the key is at [8]_ or [9]_.
 
 Debugging
 =========
@@ -154,5 +155,7 @@ References
 .. [3] `<https://github.com/canokeys/canokey-core>`_
 .. [4] `<https://github.com/canokeys/canokey-stm32>`_
 .. [5] `<https://github.com/canokeys/canokey-pigeon>`_
-.. [6] `<https://docs.canokeys.org/>`_
-.. [7] `<https://console.canokeys.org/>`_
+.. [6] `<https://github.com/canokeys/canokey-nrf52>`_
+.. [7] `<https://docs.canokeys.org/>`_
+.. [8] `<https://console.canokeys.org/>`_
+.. [9] `<https://console-legacy.canokeys.org/>`_
-- 
2.37.2


