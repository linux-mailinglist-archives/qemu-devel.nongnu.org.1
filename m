Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A4C7093FD
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:47:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwh3-0000AS-Dq; Fri, 19 May 2023 05:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwgz-00009a-P1
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwgx-0008Rk-VX
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:33 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J4mKNT015301; Fri, 19 May 2023 02:46:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=gKRydWLyO6rRjilcS0ihsVSMD6klFbAP/dH/wGgCwfQ=;
 b=Y9YQ8Ar/9EgAS8iyxcwyWATLKu4V6y/2PYPr1wINHH6IDrpqje9ogpJVZRmBA6h2D/Qf
 31MW1Xsrd+53HJRNwyR+QwgMzx4AtZJFVFiXHsAUek/LDez6aWhfXVbgt++WPEo8SdzV
 +jQTMvxbcUjXc7toYYKklOe6ZoleyZgkeQhcNBQlPCdFlo5nu5xvY/4QIULQUjsyTBel
 QatVSnALPArrq323GpqgGLP0gswFUnpEor1If5rmhTCP6GAAMJi4zi3Y1SiuQSco70tP
 xh1H+RBXraf92YxtBXgaHFk2eA/3ctHfEK+YuFUc1ilyMr1WoH9nDTWrGW+Ux0XkzTHR mw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmvtrdagp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT8l5cLwh6/93RDdgAhIjNn2kFGelbGKK8noy/0XcNZYo3tV2cjePpOhDqTdt22Yj7ZhQjmwJi6hswmP1/bDFKu0Vwu2Xa98W/md/ABGu7Uxo4LEo6eumemBXzKYdRXrjN+fIOV21ltwzg3wKIOzpRPnpV5IcmM9UAiRNZYyPNJH3fu/HcNseCYVsDT0u7Hq996hFNttggtR9bdSksqFG/Hi6pXKVedDb3MmfeQY73O9DALg9HzoFB+UqlflcY0iY1LC5KFbvH7rbKLizfHmb5Kz4UPhTgMjcyBq3Sag0OhcycqA/sqOM4nChQUOWRH3iJx5iRMU4VrTMHqO0QJrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKRydWLyO6rRjilcS0ihsVSMD6klFbAP/dH/wGgCwfQ=;
 b=IddTfFwUUVuQBN4wrz5K2J/cfnWWlIGQNcV2Boqb6l6T8U2NYKGt+1DRoj/9rKO14RA69Bt7lwCKq+8zvrHou2FZlLbtlGJA3wxkEkJhhi1t5qQo/8AQFqauw2dfNi/4jHLwc3arWPxNssKpbSbNlpAHfJusEePjRwQ0SzElXU4cLLbLg7nKSvx01Yr2nmOu29LNvgZtVHZyKs1cYTIgK92X5d0cFxoTD6lVNGTVN+gfbrn+UxIPVXhjzVekJ1ZU4ZQkeWtoRVaYRa0ANabb7sJEH6rmRzdeR9AlWQbGLbHIiuIbFPkxOwZ98U/9uEI5OLO/cpQ74dPPOwMbK0tPjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKRydWLyO6rRjilcS0ihsVSMD6klFbAP/dH/wGgCwfQ=;
 b=j2NfgpJ1NPVJHCrbdAl8Ovtnyyv/aAc1h+rcsJQmj7yj9hOzKLKkwlFs/ETdakXwJK+ww+3EMUDR1Q/nU8zwCgAklBpqqT+qbZeUeVegXBSg3mRPsMvbd6Az0O5Cjg3ZlO72v/eDpF6v2la1QTtri8F/JnRE2HUk9+CfKP0xzCRxoN7e3UQFiVrDhW/1Lwbh2ugy+WI0IMKtaXqZSKPg+8ASu5qJakHjE++1nYpXm+2vipsBkkSPAtWA9OruBHjIYMRezzJd/RO7oHP4nLWFq4FAVOwD8fzNWjoVl5iADCFwRZ7kfGbG0OUo8L3tDGquXDoEw5iyf472XOaP6IfNRg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB7912.namprd02.prod.outlook.com (2603:10b6:8:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:46:29 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:46:29 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 4/9] migration: convert rdma backend to accept
 MigrateAddress struct
Date: Fri, 19 May 2023 09:46:12 +0000
Message-Id: <20230519094617.7078-5-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230519094617.7078-1-het.gala@nutanix.com>
References: <20230519094617.7078-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DM8PR02MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: b8290fc6-d742-4c14-2431-08db584deb57
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kx5Mm9xgV90EZZWbYAF5qUogL11DtPuOFcZK+JECa9UDI5bY7IoxRzKDymLL/Qx7mtccbV0duzapjtis6goys949nsD/F6ON9SqRVWIPqMYmJsfm/CusEmPxIn9U4kDEW4jisS5WhF06X9cNGjxF4mI9ZiWaptrQkRcd7cpEZ5rd74EZ40Sxb4PfHOdz72sclMvJs6gnXGkv2Mh390DFSydtLbkIQBqziVwznV0rryLOTVZDdYvzsp2Kee8PBBuOx6/kR9T7vmRSfy5ipSF5jQuYqmPclJxTar9Ve2juGQc/hqTUPN/Pe8vIEiMrsriJrWfYUX4uFXznvfXqE9TL4idG+fAug13Qa0mhHKHmjK0USqjH4bse3ZSIAyQdOhgy/iDEgXwbCkRdifwordvV/umlgmhd6KU9ZpqrURLGHfeX5Z1fCvGpPn11z4I7LCGVmAHCpoun4xPr4t/jsHc0KVG2KzqXSGULCKroxIDoMy8eqmf4JGyQQXvLRSDiQbkvTkYzcuprTMHN6wtjpkqeJ21uNZiixh+1WY6ZYfrgposLe/VEoR5yNJtPF4ZN0vtqUrMf09sha12F/UTp/p13XkfcOeWOYS+gvtghUuWaVvAooNKJU4tfcrXxi4OgVB+G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(8676002)(8936002)(5660300002)(316002)(41300700001)(66476007)(38350700002)(4326008)(38100700002)(6916009)(86362001)(66556008)(66946007)(83380400001)(107886003)(6512007)(6506007)(1076003)(26005)(2906002)(186003)(52116002)(6486002)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yfQMRsAAmjDGwSa3fudAkouO4LXuhcs4a/cquSckCVkS/VGUMAuX9Erq2F3W?=
 =?us-ascii?Q?6aCfTmrx+gd0QbF74R4VT775vfHofnRL6y6T6ZDLJSZRnMbNUuwtKM7ACYFh?=
 =?us-ascii?Q?IH7Ce9LUjFTYK8jI4YTO7qvL2Bs8GuTtBBhk/nR86TaONk5su0c4qYeFumi2?=
 =?us-ascii?Q?xA313xSc3FMz2HcHrOPbMbwiZ69R2ucHDJdJau6dMfGxPplw7T3i9tkC/F35?=
 =?us-ascii?Q?RYrcbaPlKhucBi3LE1kDsapzGaV7RGZou2USLBVS6r6vebejCjODNikD0jlZ?=
 =?us-ascii?Q?SorPGxF0SOeqBlJObZ/VyEj/y8oK9PxlzS2wcDRA0BfiV1Lyx1Q4m/Adlp7w?=
 =?us-ascii?Q?E7wRATJXOqOgh7X7t06bW5gskDBAl/5r9Ip6mQQeOrVSMy+mpywQvyg/CEBy?=
 =?us-ascii?Q?9HpmhjqdekzjDlqkmaWy2y1H9yCV8NXvs65+8SE9i8zVwGFwAjXtb0eHEGcS?=
 =?us-ascii?Q?N1osDaiJ7zGol/k2Z4YjzrjG5P+Ma/MdW17iYim5FdC5fRGPYaeUTtptmKCw?=
 =?us-ascii?Q?cvdaWiiyqwa1mR2/iQdDdCJAwSvJzayS8tV32eSJH82Y2RzGd15i+gVmatsK?=
 =?us-ascii?Q?IK4FHr2GnEPIK0rHqN6Vr6RzUPc+QrxPz9DeP81CoaWq8TK6GCxQYRksMWCh?=
 =?us-ascii?Q?I61epVml/GaW6cbXCCb0yVfol7CnRfH7DoYAS4Td5n384VLj7AjcFU62Mc+0?=
 =?us-ascii?Q?j81NIfJoVi1AGIcjK95nbOh4bhlpDPzGZtlEWrW/LkGnvoX0HhomEwT79cJS?=
 =?us-ascii?Q?Cf+puwJskxSJsQbf09pjyT/gkgfht/NMC1ZF2XU+CgIA9EfOQhZgNIJLkMNP?=
 =?us-ascii?Q?sOYHN3Yns77pEYSNpnxfWBc+bVjhz4KG9G+eliZdE5D5m+9z+2dCLgT/GDBQ?=
 =?us-ascii?Q?f63jtwH9UbCLQQsHA916Jp0ZWw96ecHC/Pr4p1YHhwAfWPqhtO+Le9QC4mmu?=
 =?us-ascii?Q?o1E/R1ZB2C/2t1G0kKt4zYV5+UI8IX9sIozZNomzQAIjxwB3g6pLZ3Pt8w7f?=
 =?us-ascii?Q?riOTgbdbjGkZkw5FmKsGynrTTbd8ps5FmV6+5Nclh/r5mQNkbB4UvgPMnLBG?=
 =?us-ascii?Q?ZninAOTcjv6QQpb2jfwJ5beiBnU+SMrkcBzRA7+a7kmvT7oeFEuRyAwxLEyq?=
 =?us-ascii?Q?ty58BogJr8QBkIQum+87E07tKGxs5SDQqNNQbFaz9Cy0K8pTJBtP+V5WBBWm?=
 =?us-ascii?Q?u8Um6ZaADovk20lcv81oRlnSK5vobfJPD1w0FwAgRKy/6BMKaQAlKd2yItg4?=
 =?us-ascii?Q?Ie/7ZkqaZqG3hvnotf7DqeS1587O0isono41reXEhL0Cs25bs58owxWRvPp5?=
 =?us-ascii?Q?YSiKcSyAuG5wvHuZE3pXF1JxbH93bz4VHLFlR1sMFALeKgcVcFu4a5zERZvZ?=
 =?us-ascii?Q?XBlpl0NWXeqYSvrDemW987nEY3VUet7dkdtZ4cw1WoEhP00vc/+knjWlYWe7?=
 =?us-ascii?Q?py1lZVs+HzVqiyqre2OuLb+Q5Mla8p8jmG8At11enpYpShP4vK9ah0dDkujD?=
 =?us-ascii?Q?YAq13VmUGZVLO37eB2DkjYkMEZJWX1xr5nkCi5YZJ+x34VsM8ZYC/6emmiaX?=
 =?us-ascii?Q?+SWdJ9QYsSP2+Ats81TSRj0RAYciUJkDMl0cNmuW+TDWLRp458RowAQ65AWb?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8290fc6-d742-4c14-2431-08db584deb57
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:46:28.9330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSfD87pkDAtwaShVuYgQxjLhHDdk749PwPeYNHrpK6rSZfV5+0H4bpcmg3BskAmqCN3Q7OpkAzK8vSxYr0jkNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7912
X-Proofpoint-GUID: EQYXz6ejXF0nT3_0qtdVaX877f1qpehJ
X-Proofpoint-ORIG-GUID: EQYXz6ejXF0nT3_0qtdVaX877f1qpehJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
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
index 3724de7edd..b7c72fafc9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -488,8 +488,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (strstart(uri, "rdma:", &p)) {
-        rdma_start_incoming_migration(p, errp);
+    } else if (channel->transport == MIGRATE_TRANSPORT_RDMA) {
+        rdma_start_incoming_migration(&channel->u.rdma, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_incoming_migration(p, errp);
@@ -1716,8 +1716,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
-    } else if (strstart(uri, "rdma:", &p)) {
-        rdma_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATE_TRANSPORT_RDMA) {
+        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_outgoing_migration(s, p, &local_err);
diff --git a/migration/rdma.c b/migration/rdma.c
index 2e4dcff1c9..966a21151c 100644
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


