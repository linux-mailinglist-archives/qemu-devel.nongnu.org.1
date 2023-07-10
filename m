Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E8874D56C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq0F-0008Np-Il; Mon, 10 Jul 2023 08:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq0A-0008Kl-9M
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq07-0000mY-Kw
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:26 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36A6feiH020935; Mon, 10 Jul 2023 05:28:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=eBYDmSFyjVdAWMWu1a/acT5Xh74HYc/DSUxT3GLns
 p0=; b=TUF7P+u6YLoMPvV1m4jecJQxZZtshBJlmqgxoBfPDspJ99SAMeCVWL1dj
 EqW2DQMxTeUK8u0RX/wqXwmFlYEOAqm05NFJxiWzCs1xH3owS2WhzQEj6RBUucJv
 piIJKVyDKxfg7OJhOKqzI8QN5aQ/OA1MGCSWBgUmLMZUKuhZJOU+cgEDEL5/+DSL
 DrV+B7+a7G+C8V5QoZq7jQiI1+//vMQ0N1F84xfcDOycYyaZGG+8tgvgiGbCLDGA
 gzL2UstABm3WVvX6qYu2Mc/tgkTWnhvjT9PIsvRUyiKfXe/zMo3wzCFsn76CHsBm
 uqL6M6i53pTW7uv0+5FC1ks0UTOsA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rq7awaxxh-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 05:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VESmJMXifc7OT8359LduVNZpEmJX/sp93r7pKDIlH2alw8v91vZuIv+/3pEhNFYwWvu9Jg1pDJmVet09IjkEt52A1BFGNvwceZFZ9bkhCK6uJ+QYcPtb9UEib5SDxT8yJvsY/aWyWAvoNBR3kOAqTDDxpG3BOQt0gGnN9JB0SsQSulqodEPlrd8pFExX4W++d6A5/BToh3huPHD2aR4nC5nxBVFFKmBP8CXw0xSeBCxbLTM3nmwa0nQm+lADabIn/0BA3Wnv6VhT70uuZGbqW3Lt3Jk4kd97YBBqSKMPDQHVB1mmXqZZdaxPleJC7iHJfUtAh0GYvy112KJmIkOHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBYDmSFyjVdAWMWu1a/acT5Xh74HYc/DSUxT3GLnsp0=;
 b=QAEOgkPDCEAlUQOFriAHRGt6nBvgVeQnCk2uOBR494lII+2w77nNJrb1XI9qNZwOfbOOFHtLgpZ9e8sG23gey1gH33rLESfbS6VmUOIR2OM4/oM1QgkRx/1oTS9XIZlx/oY37loBrBpIJ5mCWbfC/PEggj7iSnKx0LPVDfDYfuleWwjMkZXrOhWlVLvVbxxxfmT4m3gbzLBg4aL84yJQH4nJBcPO4DypSa4mUgv/XZJxJDILt2MJP7nMxqwtrsf6wNufPRlKYAAo0uR5LkM4Oifiiq+1L9WIeXatoYWRAVqy9cbM1ujiJ03hw/K+Ao9uETJ/ZY6QMWrbzmBfcNT/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBYDmSFyjVdAWMWu1a/acT5Xh74HYc/DSUxT3GLnsp0=;
 b=WMuUzcyGvZdX8REELTz+fJrJYVv9Uu8M9SYu074eiqJobjPMmW+KsgPBvoRq9TQEGh3uIKg/1dgKHhpDU6UPCXWX8wYh2c1aGjR22vULYhERmL061m2A9Ks+JgmD3hsBqbXWft8W7by1vTZecztkbn0/R/KZcHB19wcCqInlswAaj1jObuzMiue+4tz4ATCbsUXZ9YyTd65XwfifJ0rAHFzjU7TyqU799L6n99yhwp1cBEvWMMgqvvb3Gocs14fEtOBGr1tSFD5DnPnccToGp0ef+gGz+WpzTZoFdR1aPzUd0x+6DQK9XLez89dybp5bzFIH27oxykr+T2yRq8zfnA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MW6PR02MB9934.namprd02.prod.outlook.com (2603:10b6:303:23d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13; Mon, 10 Jul
 2023 12:28:15 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.017; Mon, 10 Jul 2023
 12:28:15 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 4/9] migration: convert rdma backend to accept
 MigrateAddress struct
Date: Mon, 10 Jul 2023 12:27:45 +0000
Message-Id: <20230710122750.69194-5-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230710122750.69194-1-het.gala@nutanix.com>
References: <20230710122750.69194-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::25) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MW6PR02MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: 9328efef-298f-4688-d484-08db81412220
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/2cGJOD6BfWqyDq3RQmzXe6TXx2dEXG1jJSCok+qS4wzK7auDA4/5j0xRHPmj/+mq4LVJGrwVl7bhXunXEEXmwCpGWrcrJucCHBX9sWhReTtQq5c4+7k462fdXi+oaHyTJiHjSz4OgSMm94K1FRt6CwRmduh+yz40lgvIU09fQy2zYsUb3n8IKiHyIETpz3fTkcpNe9mGjJ9tmyNzEOZgk/do++ft2Pz0glgBg5KCkVDdnMq+uUDeR5Vaf6FyirZn2pUC2gK8jK7FSyDfqbYsdL/I/FszKd9tDphFY9afP9XS0Gtmw1RH1WJy4kczOUwL8x2wv2jigNG/c7ufx2g7JsC8QsxTaYOvtjOdTnH83n4DRKC7HtwlkjKX49UGpzgw9uEhtNWKQY8fLt2zc7aHwWTJFbzqNWmhrIZLbSiDOurvdgoOZRr3yYhpyZo6SIwET3TEQM7zdKa3xrXBfdWToP6I8ZKUTeC1UOxYahwmQqLrSaOUYjkGbN8VJpPqkybbJ2ZSIIoNMIKZrYODceDoNw5qwCXNG56ho295K91S8zNjKPyiBprbwr6GuOKkMrCdb6oUEkoiyT9ARM4+VNuxBx4zlQWwvfzTfKO0BG5sX0UHRAUkSp7UbijBklvZUe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(38350700002)(5660300002)(66476007)(8936002)(8676002)(44832011)(83380400001)(38100700002)(66946007)(66556008)(36756003)(2906002)(478600001)(6916009)(86362001)(4326008)(41300700001)(316002)(6666004)(6512007)(6486002)(1076003)(52116002)(186003)(6506007)(107886003)(26005)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kbk1SkJQWyxkYFZxDkuQ2ojS/SDHvZkmMFphZdHqVyL3yd9KoDdDgUef9Fq7?=
 =?us-ascii?Q?5hkS96NeBFrQbk5NmErSMutwoB3C7xmuspvZzKQJeluTwps+UB/4PipxKd4M?=
 =?us-ascii?Q?ceL8RZKL6VBN/4/cKEG254l6RCC9yrqrk/1ejpPx6rfiVa5SEuKlEOS+mpKp?=
 =?us-ascii?Q?gka6OvDqCJJiY2Id1WP2krzFmEIdRJZPqrMjKNyCfvod7zUWDO7Tkf7MOYlw?=
 =?us-ascii?Q?bF+jSXQuRQ0E2NzE7xP6wLpp0A5AbStLOdQ1LGP5oYJ+eGHc0zPEga/ktZS+?=
 =?us-ascii?Q?FTruznsaPnf2V4mIy4IoH5Rc/C1ApSDw8m2tPkXWKMBzlZXSobP7Kj3kpXID?=
 =?us-ascii?Q?6Jiaq3ifPzcPaOFQ1lieZNXQYiCxbFwj9hfa+JBFdj6M6tiwNhcfqOLXa2I2?=
 =?us-ascii?Q?BXnzbkTUBl2zZiUz51d4ZIEEL56AimBxCrYc85n+oKExUZVBuKus0dk9sNok?=
 =?us-ascii?Q?8v0Frq8lr8IwnL3i6Iz2axBZ01RtMaklvFfdXD5slUHwyA74vKhPd0I7f1ld?=
 =?us-ascii?Q?TXYrOHMIP1QeMi3WyAptvgZ3tRsg/k89NWDBKBHFe9zthsb28WA6r8lrQBbJ?=
 =?us-ascii?Q?c52M+jkWIoAz3VlI8MBwzmFyu/0xpruCWtFKbCrPThsQxwXgoVDwTN6wySRn?=
 =?us-ascii?Q?ql6kW57SDhei/O+KiVNzs6YCc9SGVsbbGFBifvIcIkSwYiLt5RKtkShLDCWY?=
 =?us-ascii?Q?vi91xJcpEhGsa2bb8GgOKD7NydfaVCw75fkcLrLejz0rsHmAofozAgXxKE7h?=
 =?us-ascii?Q?UMN1EOqH8Wmc5E/XC8+90q721R3710lI3onIz6UIKvnljK5ZJBw/Rd4OjPIM?=
 =?us-ascii?Q?vYTN5/ZdgzTZ84AJSGOo+Fcu3MyfHIWKUFzEVqWvS7QdMeW49+9j5i3dRKHF?=
 =?us-ascii?Q?TgAhxcq4xEfFQnE1wN9ucDk099ycQh5anPjRsn04czLmQxvHA5s3fZ4SXw5H?=
 =?us-ascii?Q?vWzvqUQ8vcTGYEA87PpvwAU6+S2Xcnn7u5bnDZuswAH3iGVPn7wAxJrSERXd?=
 =?us-ascii?Q?Gbi7s8rq3PKckPQOdXJkreBn3QE4LaUjnlbekxzw85OhUahVaIvMgz3zLnTX?=
 =?us-ascii?Q?gjjW6bafJL/WmHSK9EBNYlYMLu/Mc4ryFs0jn4MT8UES0jlV4L6jDkhF0bSK?=
 =?us-ascii?Q?OZovMU/AkvibHc0DLohPpVmGNerU/79xw5ICUM+v4C0oubBqiQsQYijU0nHl?=
 =?us-ascii?Q?NtN3LOp7FNevgY405si8Z4Mc4iMMt8/nMSDWnXCBAkAdToIoRGrIRmbA9/CX?=
 =?us-ascii?Q?c+C5F+fwRH2E1PJCBHRBmAAbCBqMbgmmjePe1PG4UZCd80eFCuWk+vsMR91K?=
 =?us-ascii?Q?wFkouU2p5XT9nrHO1iMdw+x/EGm0DN8BWsX1584Mpkvl3XSym0/3SOShvFV/?=
 =?us-ascii?Q?frLWxm1Bdi5ULvmhGuJ4x658SOpEuhvH1NdHJGZ2skN9nggzlL4oNauMN7gE?=
 =?us-ascii?Q?8uj31lw7GpG0t26g1A9/NIRXWxFtPNU72iLg0VEKfDGzkXxllwnHLHtL9lrm?=
 =?us-ascii?Q?3g+LKDeGmKhiZeWvN+HDZJiJNLruFE1ufwh3dLvcQis0K1vm/fEZSVxjMx/I?=
 =?us-ascii?Q?zduw4iTdbB4gk1FOYrxKdE0HpTYmpZ9YkPqMYtJB1Xf5jojjdNbmZxjgEgG2?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9328efef-298f-4688-d484-08db81412220
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 12:28:14.9627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWya4MRT+514w6bT4RmlR5HQ30Mzg1HttUzacTjAOCkIg4BUUPsOVIJGxzBZeWO0MYZlVfesxri+pPMo2CFoBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9934
X-Proofpoint-GUID: 51Z782DymDH851dW8hBidvTLBmnCkWK8
X-Proofpoint-ORIG-GUID: 51Z782DymDH851dW8hBidvTLBmnCkWK8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RDMA based transport backend for 'migrate'/'migrate-incoming' QAPIs
accept new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for RDMA connection into well defined InetSocketAddress struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c |  8 ++++----
 migration/rdma.c      | 34 ++++++++++++----------------------
 migration/rdma.h      |  6 ++++--
 3 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8108d4248f..2f5bd5df6b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -490,8 +490,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (strstart(uri, "rdma:", &p)) {
-        rdma_start_incoming_migration(p, errp);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&channel->u.rdma, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_incoming_migration(p, errp);
@@ -1727,8 +1727,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
-    } else if (strstart(uri, "rdma:", &p)) {
-        rdma_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_outgoing_migration(s, p, &local_err);
diff --git a/migration/rdma.c b/migration/rdma.c
index dd1c039e6c..4d64fae492 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -319,7 +319,6 @@ typedef struct RDMALocalBlocks {
 typedef struct RDMAContext {
     char *host;
     int port;
-    char *host_port;
 
     RDMAWorkRequestData wr_data[RDMA_WRID_MAX];
 
@@ -2455,9 +2454,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
         rdma->channel = NULL;
     }
     g_free(rdma->host);
-    g_free(rdma->host_port);
     rdma->host = NULL;
-    rdma->host_port = NULL;
 }
 
 
@@ -2739,28 +2736,17 @@ static void qemu_rdma_return_path_dest_init(RDMAContext *rdma_return_path,
     rdma_return_path->is_return_path = true;
 }
 
-static void *qemu_rdma_data_init(const char *host_port, Error **errp)
+static void *qemu_rdma_data_init(InetSocketAddress *saddr, Error **errp)
 {
     RDMAContext *rdma = NULL;
-    InetSocketAddress *addr;
 
-    if (host_port) {
+    if (saddr) {
         rdma = g_new0(RDMAContext, 1);
         rdma->current_index = -1;
         rdma->current_chunk = -1;
 
-        addr = g_new(InetSocketAddress, 1);
-        if (!inet_parse(addr, host_port, NULL)) {
-            rdma->port = atoi(addr->port);
-            rdma->host = g_strdup(addr->host);
-            rdma->host_port = g_strdup(host_port);
-        } else {
-            ERROR(errp, "bad RDMA migration address '%s'", host_port);
-            g_free(rdma);
-            rdma = NULL;
-        }
-
-        qapi_free_InetSocketAddress(addr);
+        rdma->host = g_strdup(saddr->host);
+        rdma->port = atoi(saddr->port);
     }
 
     return rdma;
@@ -3359,6 +3345,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
                                             .private_data_len = sizeof(cap),
                                          };
     RDMAContext *rdma_return_path = NULL;
+    g_autoptr(InetSocketAddress) isock = g_new0(InetSocketAddress, 1);
     struct rdma_cm_event *cm_event;
     struct ibv_context *verbs;
     int ret = -EINVAL;
@@ -3374,13 +3361,16 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         goto err_rdma_dest_wait;
     }
 
+    isock->host = rdma->host;
+    isock->port = g_strdup_printf("%d", rdma->port);
+
     /*
      * initialize the RDMAContext for return path for postcopy after first
      * connection request reached.
      */
     if ((migrate_postcopy() || migrate_return_path())
         && !rdma->is_return_path) {
-        rdma_return_path = qemu_rdma_data_init(rdma->host_port, NULL);
+        rdma_return_path = qemu_rdma_data_init(isock, NULL);
         if (rdma_return_path == NULL) {
             rdma_ack_cm_event(cm_event);
             goto err_rdma_dest_wait;
@@ -4113,7 +4103,8 @@ static void rdma_accept_incoming_migration(void *opaque)
     }
 }
 
-void rdma_start_incoming_migration(const char *host_port, Error **errp)
+void rdma_start_incoming_migration(InetSocketAddress *host_port,
+                                   Error **errp)
 {
     int ret;
     RDMAContext *rdma;
@@ -4159,13 +4150,12 @@ err:
     error_propagate(errp, local_err);
     if (rdma) {
         g_free(rdma->host);
-        g_free(rdma->host_port);
     }
     g_free(rdma);
 }
 
 void rdma_start_outgoing_migration(void *opaque,
-                            const char *host_port, Error **errp)
+                            InetSocketAddress *host_port, Error **errp)
 {
     MigrationState *s = opaque;
     RDMAContext *rdma_return_path = NULL;
diff --git a/migration/rdma.h b/migration/rdma.h
index de2ba09dc5..ee89296555 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -14,12 +14,14 @@
  *
  */
 
+#include "qemu/sockets.h"
+
 #ifndef QEMU_MIGRATION_RDMA_H
 #define QEMU_MIGRATION_RDMA_H
 
-void rdma_start_outgoing_migration(void *opaque, const char *host_port,
+void rdma_start_outgoing_migration(void *opaque, InetSocketAddress *host_port,
                                    Error **errp);
 
-void rdma_start_incoming_migration(const char *host_port, Error **errp);
+void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
 
 #endif
-- 
2.22.3


