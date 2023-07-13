Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F752751F5A
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 12:58:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJu14-0002Uj-ON; Thu, 13 Jul 2023 06:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0t-0002TW-9i
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0n-0003b2-R6
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:31 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DAkHNw017603; Thu, 13 Jul 2023 03:57:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=eBYDmSFyjVdAWMWu1a/acT5Xh74HYc/DSUxT3GLns
 p0=; b=hk24Yz1BK/Q9dKdjcqsPnFsbAmD69vRbkisIKSpLGZf2mFtV8bJ5qWypz
 0SYGw0+zPIepAOJw9UZYuUYelJrbC6CHO8Wh+0Aeg2QXu2nwLsELsuABKd4SPBuG
 6W4fHvn0NhU/BPA8gUtW20owLY18NpkNyfres2CI9b20eB6C6muj05C0eOiCECLI
 rtDGv7cnq+fQzAvUyI1sko97wrOp+EyiE7LtlgZ6gVYp3UtyQoInTTgOrEHGv+YB
 qt2xRvllTfUOj7Jv0Aa1bcL1jolG55o22lme/Ux8ntzrtEfW2ifj32xAtlZ8SHFd
 TpvXZa2WRcxd4cWwx8Hy/QHaUKcfA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rsyb3hrjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 03:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZqJbT83VNncb5fejAaIsTFqG0D57vOhiFOgz2zxZHA7zDcfX0Eute74tzopnPv2IpJwUUCe0guBkMB7TSUqtOG3MJdPU/9i2cVwj1FRwThv2VoLoOaYpr+AmBiG9Gju9AIiAPPKv9bYRVQH2bqNBxNTrp/PuGcrxXlVUSRr2kyj0In9eNHtUVs7tyDsiwFVyIFJSnkvIPXW7islsaQBiEvFBzDcuV36n911Xy7T/W2A6WXesSY/SEbmfPI2eEJ0RELwE0rb5WiASWaOAAmPKiP3kPKlFxiCk4Sg5ude51NgR9lyeLbM78JcrXa/5S9f7wKok7PJCSKV8dWuXrCTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBYDmSFyjVdAWMWu1a/acT5Xh74HYc/DSUxT3GLnsp0=;
 b=P4pxbRsLOPVdYgjj6NfFIQSyE2jOyh/BlyDMO1FNNrrP/xrAjQHadngBXhi/LkG16vUoYiZVicuUTfFpamfoY7PjregKMnchGC6jiZUA9JCirnRBgEghiZcaV6m+HssVKuh0FMvx2BAKqjGHQ+x2XP393gdvBi3P450DjS2mKe9E+5/gu5pDWY6QuNsXCx83p8R7S3JbTuVzSOFgnToJEnR5/rfDz60EgsK6zDE9fKR2+z3BidYYHaZT2iAv7mnS/ZF5lMu7aJGZ+581WZfQP5ynnZ+JqCFmLxsxUhxN8lGgYLy4kLuw17oY7Pc5GNJVsO6bunHJ6/zR92fs3jlUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBYDmSFyjVdAWMWu1a/acT5Xh74HYc/DSUxT3GLnsp0=;
 b=X79WyeYOHRXG4xVcRWFUemOWNkzE8G/NZNh3xtwYbMQeCaZhTTFTAPHh2YyEcHxtZvKNHQqXM5ajDe3PFLJQjAlwICQ12CbTJ56qBixpn8SwtdSe17NYVg6dyEaFYlvlFPDDtClo9OFDIov8umXhfMa8M0lGt1kid+7E1MRw8N+ch6WQvKpY7ntKpQ3PH9JjW1Jal0jE4nWQotf3XF2DaDLBbNklZh0XgD6xJvLtfi4gzUwdsJKJoVP8xUsbvLoP3U49pCBLOgx+7S/Cdi0SuAn1KKhlKt4F+X3GJUHbeZByETgMKqaoUIKnn5CC9IFXVGRVEBb5mnVadyILASsiSA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH0PR02MB7946.namprd02.prod.outlook.com (2603:10b6:610:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:57:25 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:57:25 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v8 4/9] migration: convert rdma backend to accept
 MigrateAddress
Date: Thu, 13 Jul 2023 10:57:08 +0000
Message-Id: <20230713105713.236883-5-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230713105713.236883-1-het.gala@nutanix.com>
References: <20230713105713.236883-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::28) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CH0PR02MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: b93b780a-7273-49db-d771-08db838ff11c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31ii7IkpDHMZMuBGVlZAkvMIgQAwdfWv9lse2NUyG8IML94Zq90kcpZqfeikV6tn8s3ZlP7a7jjsFrSMgAxlYaTwwiGaMHPs2X9pFUphf8xRKVigFoGA3we6XC9vIQ/8JozuR95/l3JqfWHf9xpMpUuDz3Bak/EESS6JCMAqAe3a2IrtPqDQMdVC7hxBeg3082ET65aKbnZwqtq7Je2j1KHSPR4lPfyC4o5gZeQgVfE5FveV/AtqeslN9xyrsKEigdbeMG++Nd1LS3VYlWhYKysfeYJ435JpXF8QX2BzOpzvmror2YHJClzjQxbuJYjAM6c3nWcY3j2lYmy/rjnqqQdLF2nz3Vuq7qbttXvGrFIx56xDkh8k+EYwGe8QRiDaWWW1q6UWAfvC25vvEuPDZaAIDmJGBNLsLfZq6WomZWcNIoxUnAA1j4MtMsBL6NNHHIrAmYZ6gGIOC0pujBv4RIL0MzqdOZca9WfVJXEdQ6ZxOcAREtf273PXsRWauxxbNU50T0kmDUyOBfeWZixFn1M9VNOVNIMgl/bFOrxmeRN2Buogcu3gRLwNlLEMOsAZRo9rSeLNIGrAcOrY2rZ12KitRwFrjgpGt1xdPnllmOHo7Zp0VsRyuZyZYjpI8LuF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8936002)(66556008)(8676002)(4326008)(41300700001)(316002)(66476007)(2906002)(6916009)(66946007)(6666004)(6486002)(6512007)(52116002)(1076003)(6506007)(26005)(186003)(107886003)(83380400001)(2616005)(36756003)(86362001)(38350700002)(38100700002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eo2l+poRDDU110c5oplN8gZlgaE9rNIaqHCsEdYE0Zlk1UMP1mTTZMzKhPnS?=
 =?us-ascii?Q?JQ6oEhP9eF2PxNsKKN6+XiCwNgzBhY8nynqkwzBULISoN1B9FIjk2xWuM4TQ?=
 =?us-ascii?Q?hCD+1WeFTX2qCaABzmysttJlkNQ9vjAb7n8RekRlPrAYCR/yYy81SSrsI+lj?=
 =?us-ascii?Q?zRrgOyKv3wBwI+TJeQoE4HBMLDnT6F65FWdeTV3A1Tlanb/sJ06G9t+3aVVf?=
 =?us-ascii?Q?Km4H6fOjzchsGM5B0a7ycZrRAz7ixH0IfrG5Nq7STQkK8V2z9xz3jIvtC6md?=
 =?us-ascii?Q?DKViIjiG95Ws765ltieTVvVQuFA67mWOqk1LX7zUr1Yd93UMZdhXa0NmWiSM?=
 =?us-ascii?Q?RKuWihX8FeQTMl2Uh/uVt293K/yRUq7hmS9K71k9TbceuTJNLryOensIEBVr?=
 =?us-ascii?Q?qQULUz7h1gpUhuIDNQ95GirbJgpRp0jwUBaFm4NmmwLVI+OM6wbTFX66L4Yz?=
 =?us-ascii?Q?A3i5Gc3JVY3/9DD1Fid8diti1XxfuM26EejqgmtXFx47qtuZWAOztl0Ki3YE?=
 =?us-ascii?Q?rH+JiGjoONPYnJl9/Oiehc46QOu2sve2ekbLh8nhkGczr+PjhONLH7lJ4KWn?=
 =?us-ascii?Q?T5Qwgz3LCTnRQaWorzcP35ewCRyhoeXAGLW1ucUSTuKEPsQ5Fub9In9SqL01?=
 =?us-ascii?Q?Ddp+ITzdsWD5vaWLJ6EEqv/hy5b5vdPcG2z4IgD1gsT3y2M/5F2PJfNIuVeM?=
 =?us-ascii?Q?s1JeHfIu6QrTCWTRSdiYaSr4BVNowmhb+c+WpHv4Uk98z5ZIUg/hQAjcc9GD?=
 =?us-ascii?Q?WT+EC1xFlfqjd3B103XYrg5Nd0TucG0wYRZem2Sno/tDTWKzqIX4H30Ci/Xy?=
 =?us-ascii?Q?105WbgcuUEsxCDR8C4jIgi9agOQdCEyBVE68TwJ83Z6yW0eu0F9mItoyu0vm?=
 =?us-ascii?Q?ccGSgaRD2uxR+WwwSWJeITozngui7EbcJxlIha27Fb28SYGHcq9CZPdOTNvy?=
 =?us-ascii?Q?zGXclg1CpGNqjYhbojhG5tyGM6XZkXVKUbo5XKuGHhvHowjnCluhc5+26kWP?=
 =?us-ascii?Q?Ocw8NUEDYkiq61hTFTyxpJXaZpOL7es/xpGO0qH8bvJRiQ8hE6j2k/e4StYh?=
 =?us-ascii?Q?Ay99I+nnNkmtV1MPR1yN+0BOs6gzLM08wx8xjWlRo0owhvlQB77oRCacHftD?=
 =?us-ascii?Q?hpaiSHgiUpKQgVRLqRcEZYN9RnYmEujZzb612wROgw5lyP8tq8+ZrSucYKPS?=
 =?us-ascii?Q?sdmUuqKKBssoN0STLLyNGQ+TvvT9Hp5hQ3prhhsJBDA4QnVLVOzTO63Ky8Nk?=
 =?us-ascii?Q?UmssF5xzUKIQE6kZ9pu5ssbOExHcuNFZVh+RB5It1oDnMK/EcEuaIOTebhA4?=
 =?us-ascii?Q?hno6DXENSMf/6BoWW+1FRplMI/5foA5KneQBodYdNo2Rl0TzXiBvj9J5SQ5+?=
 =?us-ascii?Q?Y5QxEyN0yAqRDTZ3ARGKMh4myqs5yHjnwpOxBb2mlzVOYaBzBxodWzDaCKrF?=
 =?us-ascii?Q?MwOZFzGxdyvIjMXmHYg/fQBgEZET2fzH52yzcIkXCBzCLWQ3s/8+d8bhbUgM?=
 =?us-ascii?Q?PCtLsG/mscJmzTSBlCf4/qhZp5uJf5euEtJqN9UNLLSAZb79hOPwpxER+wG7?=
 =?us-ascii?Q?wkJ1BDDnJiSKcZ0h65QYpl4mPA2HJa9l5FcpwEXHq3CIujEUcPFqBNt4uf8T?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93b780a-7273-49db-d771-08db838ff11c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:57:25.3570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8RU3WCgTyjDyL7F/VpcFF43RVrn3i0i1LcKn4hfwnBcuLGxcMr8vly2XgLh4QUsB7rvklSYB+ETzPTj2xh+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7946
X-Proofpoint-ORIG-GUID: PwYlsVZ-5wF9uXtdMuYf9kniOt2WZj3s
X-Proofpoint-GUID: PwYlsVZ-5wF9uXtdMuYf9kniOt2WZj3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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


