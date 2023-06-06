Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A2F723F25
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:18:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tjr-0001fB-A4; Tue, 06 Jun 2023 06:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjg-0001b4-Ct
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjc-0006Pu-Qy
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3567Q9jl006542; Tue, 6 Jun 2023 03:16:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=Z+YSCSLNvriNipDs+Q9mgqdY6J7YLicGclF8K0VLml0=;
 b=QEfVg6t+ba67a3K18LG+b1uBpKGqg7B1f3xQwo+pH81J/UI3zFgD0pT5cipWP2FANy+w
 iL/1FUZ9A2E8iQiYzxkyaIYLPnQZynejcd8zVZbDDUk6+3F/L51MR+ERCmxNMD46Pk8L
 MJ1spEmU/1s85AXdqEqVsmIMc557FTo3ZEmrBSlph1xKGadPqb3R9+DbUgq+mBpQ9xdX
 8Ad6qrsBLwelx0noQS1fNhFJuxieNHPPyjqU/Dp3Zf+OXuNcR7r/8px1fTL/HioAZkkb
 648Vc18FDB7k/A74hED10pI1oDI4dYrVU3SoeNweUE+oMygpFEqeDjdxkpLYZZJ+QNLC Qw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r04ucwdmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 03:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5Ipt/oX23wlDQfpVQxK/2FX72D0Bg7/io0Q7blEzBRTXk/ZqewIOSxk+IX09AyS+NueT5uYUIbCZVm9MHOqAnQuVV10Ug3KKX5T49QLR6h2Fdj3vQZ0fG6Cf6MVF/yzBYqr6FVlgbYkG/jFv20Ni7uyqqood7cf0OvzRGkVXyr+4oz8rMuQwU0flRnP/RMCo5eXGuzwi4enEewbBjF15Osy8bFNzzuSGhKOPWJ9p85F4QOsT3Fpb/Eohbe6FMWQhWGcqmxCO7Ilb4CwCHjYi/SGusdyy26RY7K5r1C3GLOWGm8zmjUjYNmG4385kIrm7FArceeqQKoYVncIPyFfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+YSCSLNvriNipDs+Q9mgqdY6J7YLicGclF8K0VLml0=;
 b=iFroxMpRs264i/lNxE0VyMQkAcUme7gZ7lCNx8un9hbQE2VgVLBKAhxX4AYlbkMtYJB3A6UPKh90Q1jDzsd3izJsnxVZghvsJThShf2hQBjOVc3JkGFzOxGfFuSYgPkoN/1pKWaPN9h2IhC2LiWAjOsIcQvlh8cjPBHcc/ig6Lcm2hJWBCQWZEjkJKouqO5Jh0RNpGVgClcJnKIsucQk5grv1L/PAV7YsdG0zvhDAy2ux+0YJnZJ/gQ+HiQF4EVP7HuuOM353wdw10zevsPFmqrlxrCMwexG1UWATPFmyY1cbCFH5h+zbOUfvhBKAMV+zJTqaln/XEYG0bVKgK1XdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+YSCSLNvriNipDs+Q9mgqdY6J7YLicGclF8K0VLml0=;
 b=TJd6eZTcfUHZhgxggBT9FRXuG0L0hiDDwHVJWvHOJiYmVg6UEY0AgRUu6khHIeavD2YEeeQCwrhxF5eOgs2Nhj3i1FFFDQ+kEYxR6euir2pU6sII+evDetjKl0DAYJzTdS0SmxPkkPHknTx0YhLV4imilPL0UuHhsoYjx3fauop/znNkgCDyt5hxTKKejq2B/2BY/Jkb493hYVxyKDwRoOMssGu0Lv5GAsZ7BYYdZPeKQ7j/Soo0tQuaG89bb9cnp0T4kVYXFP3N8d/7nC4ywEO/bdAfXMK2SB/+E0f3Df00/WjP0g2+rajbLdb9iFCiGk7rjr19S/05lO0EtCA8fQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by PH0PR02MB7797.namprd02.prod.outlook.com (2603:10b6:510:4c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:16:10 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:16:10 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 4/9] migration: convert rdma backend to accept
 MigrateAddress struct
Date: Tue,  6 Jun 2023 10:15:52 +0000
Message-Id: <20230606101557.202060-5-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230606101557.202060-1-het.gala@nutanix.com>
References: <20230606101557.202060-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|PH0PR02MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9aed9f-f221-4c89-5210-08db66770c9f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lT3g4xynPwKQxxl10TcIttkLKqb8bl2qfyBDy1ZrfOcgUVESZU8eyR0A17zr7HcOBgdtDzAjWqSWj+wDjpsaXOw6+3jGHlQHQQR7yob0tlsxn1EYnpPZrosz1l14IEi+HSrm+XSsLhQgwuWSKRIMB16/lnf6L/DXewTeJbHaI6LUv2vdEQvk0k2G6uw569r/PD2KZcd6EOQ3ECDrzupRi/iCH8PnGKdngBz7Sv7XcnZjMWHBUendJrNbufAxrLrtrfjMoeOWaVTovZ4hw6quexGGgGgCu7erZwb6awMQmw4zfKOSNmuhFG33YXDfGQyCqFJQ0HyEgFUwuGYHIEQmcow0F2c7v/aLaXh3F/2E89pOgGO9WDRWn2hC7rMdAQKTE0NEGILucLJXFJEzFzV2Q8GEr0HywdeMYhpHH1+XMose3PE/nwfTmRSr9DGSYctNCx0gCSlTJ8oIpRzb8uhEqKHjJKYXWshuT/qI/M82iMVPX/SvK3L8REpy9pTGZjp/ng/uRmYxXLTbdT+nylQBIs3eEegJ+jjzEmkbP4bs4c28jyFxgqY71dWVZBt2v0/YCVfAx70cSS22xYyhW+yXbkp+Znrt+A2ny3noxhtrR92qOm//A9VbLW2w0Kw33j/d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(478600001)(6916009)(8676002)(8936002)(4326008)(38350700002)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(2616005)(83380400001)(6486002)(6666004)(52116002)(1076003)(26005)(6512007)(6506007)(107886003)(86362001)(44832011)(5660300002)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VI2Ntp1eN39bXIJJFqoWN4cgVkaNHq7DkATbfs1zDTd9hPcBBnr7mE1clrqJ?=
 =?us-ascii?Q?GW5k6nv3qMSN7+HGOG57ResADUsG2iiiBt8TJAdvb0Emfy3lec87fDgwBebK?=
 =?us-ascii?Q?1gymv7r5vafvxKTK06yx6PzJ3aMMh8aF1JIP8gKx7zvanJju4P9IkYWHPw/+?=
 =?us-ascii?Q?s3s+ADo+1oOw/1RnGE1FWd1Xbuj13m6ndH4fOj20hdZFBsnbjc9O119bcoGd?=
 =?us-ascii?Q?Vboim5EL9bU2aobFJ3d6L9PWQ37cpHtB03GRpQKRbrPXj78sedYgqHtSFz1J?=
 =?us-ascii?Q?dPChA3bprQsqI30WwUfLDeerjSJ3UvibExv1y2p/aDfFF/1IDZk95feEOYGr?=
 =?us-ascii?Q?BxBRVUFUBR/1dMRLUM+bd8SiwgRLAuKQiyKCd2DUT9QVMIQOQ6X/IiY/XWyA?=
 =?us-ascii?Q?QrhIgdybC/cfdbVbJk1KLxrLBCvSJop1cjLQPnNJDXAIX7nEfH6lW5uTKMfB?=
 =?us-ascii?Q?X0poUlZWB9OlloQ/hV2IDVSeB2TVhuSHSODzJpUfI17PDT2Bu+r30M6Mjzfi?=
 =?us-ascii?Q?GDNxJRuiUFYlpDNeChcM4yZerQVb5Y9MsCrdRUKMzTm3N9HiTaNzw6RVlzfB?=
 =?us-ascii?Q?U/x77eyE7vb+Uq3TrIjCVo5zegz5c21RYGQN4iK2u3UraaKE51dzXVN0oOPq?=
 =?us-ascii?Q?LOnaNlRSd8tCmvievnJSZO5/4fKp6RdzeqUscYg024idNU6blFy5jxauCreI?=
 =?us-ascii?Q?+IY/7nnuE0T5xRq+ECRPdgtExogqozLoStHJTuiVxeoA/BKTldp+6ZSKf2O5?=
 =?us-ascii?Q?gqq5uLgAoDBAQWHvvPB94EOvijcQ8eo/zwobZd5Z9vWM2AOLKQ499J0QX5md?=
 =?us-ascii?Q?Z3uYSBVNXvYVC91YWW74sgECrzCepSdfF1EujbJVw7EV4xV9H++7uivxZz9k?=
 =?us-ascii?Q?pnvGPgQIH1fOgeMElyETjI7IMS6HV4mjeWnU8IGHYJZhzNOkCRlgBPZo2G2r?=
 =?us-ascii?Q?3dTefwehtxMsJeFnOEkU0GCwmgZlNw2HpnJM9XebG8uGRD4Wn+/QXZdKZ3Hn?=
 =?us-ascii?Q?9dlde3e+bzDAC/JPKOH8hsfm6OiS91RWofSKg4QuXpln1aQaO9BZKlSfsvG6?=
 =?us-ascii?Q?hhok7yJ4Urs/Aschb0OPtxLx3vYKlDVtIbdE2jn6qiZkaL9Bt6JSgL2lHVuw?=
 =?us-ascii?Q?GOwXmjKVTMHbcFhOPF4Hw0yKeb7yOJ9ypVFE6yzrQXfRUQVhqNWlIZcsL6St?=
 =?us-ascii?Q?dvoleqERNStz+hT34B3WvDCsnpncu91zt64NXlc6YPd0i83I8uJsRpZnp7j/?=
 =?us-ascii?Q?2YyQSJSYbUwWsckIom7wTLZyGfQU2K+6SsweJHRZlww/ZmDO6cO3uH9bRby2?=
 =?us-ascii?Q?C2mUEhahTDi2mRmgdGtcc98NKYq8p5wxanXI4qKsJgCkSKXByR1LUY2mg/2p?=
 =?us-ascii?Q?IeAs4k5RXWc0o+IAbPsyoYf3SRFh1mQ0aF+xIqVFtyldp6MbIr3I93H+M8Gy?=
 =?us-ascii?Q?LEnu5lvxHqAML7wfcpwMqcYTJb6RFZK2agP+GtvwJzgXlLKOU27g2eAhVAYG?=
 =?us-ascii?Q?NocQ0RMHe0uhnbLIXVaVSsnUweuFklo0vvtgGXKz5sLi6uDZc2XOiiCM4hgy?=
 =?us-ascii?Q?TP+Fm64+UpcPeA2y8dAYceWKFRQORkXqm5HhLg1TIrb2w/yScFyrTTXKNAlk?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9aed9f-f221-4c89-5210-08db66770c9f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:16:10.3463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3OdquQH5CT9CXWo/VFzXINwWNlZ1QD7CbwDtkN2zWOCVxub2iFnIIuixzxotyjgcn+F5LyVCjTwllzdYUs2CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7797
X-Proofpoint-ORIG-GUID: qva_lWwDkrz31l4wb1SlmgX2pHueiJcG
X-Proofpoint-GUID: qva_lWwDkrz31l4wb1SlmgX2pHueiJcG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_06,2023-06-06_01,2023-05-22_02
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
index 0554536b7f..ff020656fb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -489,8 +489,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
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
@@ -1717,8 +1717,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
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


