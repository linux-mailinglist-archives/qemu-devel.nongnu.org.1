Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9574D576
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:30:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq0G-0008Og-6Z; Mon, 10 Jul 2023 08:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq0B-0008MB-Gd
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq09-0000mz-1P
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:27 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36A6eI9h010705; Mon, 10 Jul 2023 05:28:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=13KBLY4cvT9N5ctwx7N6zjPTg1P8+XMUjbKBLHc82
 qQ=; b=HYMcwoGZrmieH+463hqomXwvUy4GqgvEoPQcgZ1eKYgTB8ssvaSzm++Q1
 hiw1yRRhf4m9mifmCXNjHwxqHgHKv1bgMPQgsA6C69qw6gTrxnCJLFAy3qG2DZyo
 2fpa4zMkK5VK0wmhm1sDrbJJpDbY0AR81ggAD1j0LxB4GPQemyfeI96FewCOUe8s
 pDHoPgkuBW3OjrSNKYMas/6fEm275PvkwNOPfCQX3SNxn7XuviZ8fUeKBiIeQWeH
 XWtJDS4tu9OgVG/H6kePCLp6GfhC+4rK1hbvYCaxzpn3hp0jvGteZX1AQFXv6yUc
 SMwRhRccDIfV2CfZOkfuHuKASE7HA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rq74ctydn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 05:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T995MzSPhhXlzpkkhQOYvSJcumCmDkkLAu+4WCCjuS++Veiwk/01a4ppaE9aAMgz2VdkaijGzAsCg7m7pmRhZvjg9n9HBlUU6wLEgqssmCUE+EEkXrc87ErISt6X1V2+JpGYenriAOsLNL3KLk8V+0ILwAkbNa17PfgPFowBChCFLYMbSJpw9Ux8gwvlg328jPfNC5leBlYFWrbYL3eNsUue/HscXTkCWvMCw/m0nN9hq0H6kOXZkdLw0jyrFBL42o1N61GLodyZ1YRGMAliS5lgj3627LhngxTQ6mgFoZYNs+VF+J1aF3MZw2dOJWF8Zhp2M5ccgbaq9DeUGRvZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13KBLY4cvT9N5ctwx7N6zjPTg1P8+XMUjbKBLHc82qQ=;
 b=lOF2WMhA/ceyXms8AeoS+3RpKqP8EgI9DZbr35EVfgVHNIdQ4e3dW8/WJN2FFqD0rlzG43bdHvPdV7r1UCW8dvSkO/8fCOih0Aln/8y+44RpZkbnGbzsxd+atvZ6adObzJT1j+38x/4p35K+BuGEoUqdP+p1yPjXMqpTPVl+5Tx54e6OcAqKY2jXzlzf2a0wUS9ZcTy1EIJaz8hz6HuTdnDflfsx1l/Imvl/AfEX8Gfb8+Q8GDsDJNDDfyRKQ5og1N88x71eEmXi17GCMmZ2gFg7SJ1g8t03XHQrKfDJHirXX3VlgteW6p025vDT35v7Sfo1LXpPRdc6sDKYUy9TNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13KBLY4cvT9N5ctwx7N6zjPTg1P8+XMUjbKBLHc82qQ=;
 b=xYiYaOkWwnsQUtwsVO7cVNtkTc5EIzXQtZKeWgpCHnwOvmaL4q0sEmV/FF6nb4C5nbve/6diQpYejNLEYEx3XXKkQu7pQlNHF3HYE9MOyaGc9APgwwwA4HO/xKxOa6aKq4mS6LBZXnNXNTtvExdmqWiWdV684PokjB+v4jjJSCdEjeMPvRWEdisMsd1pvurq5RG1Au3n3PzUn7OTc48qfbAZZ9EL6WRupH9kcq/xNc3zxNUCDLtzwKlv3cwbANt+PJKuJ8sv9rqml2XFnvsuOuB/BvuT6pA6c0GPC3GHR0ISNTsb+LZr74nxKwduKtvSaeBI5b8d3rIdrvuJPdnoAw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CYYPR02MB9688.namprd02.prod.outlook.com (2603:10b6:930:c3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Mon, 10 Jul
 2023 12:28:22 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.017; Mon, 10 Jul 2023
 12:28:22 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 8/9] migration: Introduced MigrateChannelList struct to
 migration code flow.
Date: Mon, 10 Jul 2023 12:27:49 +0000
Message-Id: <20230710122750.69194-9-het.gala@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CYYPR02MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0d4431-fd45-4103-b4ed-08db81412664
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hoea9DsKE2GvSsVt74xpb4ZN+oYOESLjuBa//u/4VirMc8DyOvz7n6MzKUL2O3sE3pgdGofTqfx6jmxU5ryEafMggUMvXxcH3EauJ763PzVKfvrr6f0LGBdnowFoC/Wjzx1GRTgeZMoWTRHJXsZR8p5MPkatY7dVwFbhG7axM6I8XEdYo43FDyiI/zkFUJYztZ/3F+93nxaVZpoFH6+TH0z8qxjWrfYks/uNTzrQAoISXtstLxfe6nLvv9C0sZ0zyENCTcHZLaDvlwXbnsICTm0P3vP1E+n0oqMv6tmHm3mlFOG8ayVqrGifoeulOE+en80zGOdcDYPp8xZJiXp65cE6IWIDZ99bJbdnN34YS21BUuLYHgDTKDUX/1oabVaF2cfPC+TrI3GYGLk2bK5t+ymCC7XfSlYl9lLeacCUiKt5+4qy5plea6WigNiZQzwnXTbsAryoQ2XAUnNCrdq8bDj+bVG/yph67Io2AkJGlmiz0vWq/d3Hdllf9U8gGS7GAE5ryhWwLZVuEXZHgoBJ4R4eKJrfzdPipztHfnDWbEu2pvrR/RXiQWuVnXilHT2RvaFMBupsWZBltVXcyV1fmIWIYNbDc2W4Ju2IDNJ8aUtqGZwGT/RRLq6KMvK6fvgp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(66946007)(66476007)(4326008)(66556008)(6916009)(186003)(2616005)(86362001)(26005)(1076003)(6506007)(107886003)(38350700002)(83380400001)(38100700002)(478600001)(52116002)(6512007)(6666004)(6486002)(2906002)(41300700001)(36756003)(8936002)(44832011)(8676002)(5660300002)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B908BAPO6RUuG2pHIETuto9k3pTOGOQs6d+4L+kFWsY2rB2hAc7hWnZRm1OW?=
 =?us-ascii?Q?n/y8XcT0ZkSN7WjK9lJZKAIdG1oLpGsA8OXG1auASRfuJkHMdbUXPg8R7OIF?=
 =?us-ascii?Q?Ry7tpUi45NEHiGmoqjB1KQ55ew3U+5RzRNBIqe1ZNlkIc1AcsJ7YMuCwNkHm?=
 =?us-ascii?Q?8D4EkKMgRgzaAj3ti0RS7es7m0es34/YNZQ3PlDE0KhlxulhrmlF2WQviT9X?=
 =?us-ascii?Q?3Ehpzu4IfKdYBjCtVlA5C/XmN1pb/S3ibBrkgu2jBbiiLCJU1CA1Gz97+7tm?=
 =?us-ascii?Q?qmdStKY+CT9tIsFuPZmOY82ldFjgCOZDEGmb8YbbhMmLw+Jl+K1BGE0omHJF?=
 =?us-ascii?Q?YrgAzYhZUFO/OILqpSjeCxc6e36OOfpF+b38JVoiFbyqHl1bBEJJPRTgVOmm?=
 =?us-ascii?Q?iT9DvkvU3ldeiKkw3YD5xawDEARNMXCvlNBZeVFaAc43ZlHAYP+tBZbkPFPz?=
 =?us-ascii?Q?4tps42kpQ8SWcFfTBA5s2Rf/bvKLetjGY0VGKMTQR+KWiAOjNu9AMLxJg1a3?=
 =?us-ascii?Q?gI28kg5GgcC68YlBdxRLJW45Zv2b7WFL6DQzHebJsy3N3iS/ubjadEt5Nk+s?=
 =?us-ascii?Q?zkrQ4lpzCrUrSPOipTjf6Ofa5/hOBwTftH13FuDyWrR7/nrO8XX2FdR5eDs7?=
 =?us-ascii?Q?GNyrySmItGojm13MKD5eir1yGzHmOEW/QfGVBJ9fPJiCw5qfcVQRExJuZOxr?=
 =?us-ascii?Q?DzmBzdklq+NI0hUXqYPc9iVpdMCs/4kFtgXj3ntLudN/SoGVyuFQS7x7NWB2?=
 =?us-ascii?Q?SqinCrDSfVSyH9oH/i2un1OPj5qWsU/bWpMOGujTvw2AHIgp89j+5avP2b9c?=
 =?us-ascii?Q?K0CgE2bdGbx8hZoMDEUbJllXnlnHuFI1AzF58xkHAYHEL2MXOfS7IP+/bvgD?=
 =?us-ascii?Q?+tMS8eB3N2I9kha1wr56Kmvx5gOebN1JNM/a2kxiTQGSrDBp7gY3ROoWXXXx?=
 =?us-ascii?Q?zmiaCNdmg9aqprBKQb5Hha8DpgSUMWyMeFPhCBXrzX+Zduqy+P5HohceCo5U?=
 =?us-ascii?Q?1eOHzXI5oGOpTRRN01E7knyw+/28SzUlerdKf/FeGnUTtEVS/OwfjVfl9wcT?=
 =?us-ascii?Q?9NRtlKR6BvjEObX5MsED+G7MNKeyNaPrKGcdJZb/18TNRHBrfBqI2uIoL3DH?=
 =?us-ascii?Q?PyiXDeFcFUxYcdOwk2270HN+h5sU6wAZeJQpzZPyaCW6yCH1KP/YqLSdRb4V?=
 =?us-ascii?Q?tkvEfia0UU47NzkEMaMze7Qh6mAoyazYYAG03dBN2vs+eKOd+L1K1XWKJ9YV?=
 =?us-ascii?Q?0jtTJpxD56d78NW0vGmCXFCHyGbPTdnWciFUAet3BKNKhHGHLWjqkMRlNJdB?=
 =?us-ascii?Q?ZkDhzg7Dirz8xoHYYdGll1m52jIBVPySLjsCYeGEEZAllM8s0eR0tZV6TIMo?=
 =?us-ascii?Q?yb7JzoxluXFfXEE8kwHU42jaTx9DoGGvwf+RQry795K3zjsy8MT9Swm2z7qL?=
 =?us-ascii?Q?sQLYLsybwf9VMxIEnbbesDNYKbh9tKkSEv1WqzTBhZjonU0sh9ktBchIDrVD?=
 =?us-ascii?Q?hVSHn/4vSt6jL+mken0ofpfJ9GbprX56Zl9fvD1qtbMwLAONv0Q/R4gns0kG?=
 =?us-ascii?Q?wQlF9Ld1w2fgKEd3q/0ceNO7GtV8Crg2t7ErvJJfMSIH8wTJUtulJxw7AIIX?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0d4431-fd45-4103-b4ed-08db81412664
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 12:28:22.1245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mSs0Qw7kJVWHZ6iAGEINCjjQ2LxE2qTtQjsXtEu9f05sy/D6375iDYHVDD8BmrYe0X+HpgeCHRFJVV6y5zdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9688
X-Proofpoint-GUID: NX_CwaTRL2H2UNC_MNDU6OU5B5rwJpqY
X-Proofpoint-ORIG-GUID: NX_CwaTRL2H2UNC_MNDU6OU5B5rwJpqY
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

Integrated MigrateChannelList with all transport backends (socket, exec
and rdma) for both source and destination migration code flow.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 77 ++++++++++++++++++++++++++++---------------
 migration/socket.c    |  5 ++-
 2 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 62894952ca..43c7e4b525 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -426,9 +426,10 @@ void migrate_add_address(SocketAddress *address)
 }
 
 static bool migrate_uri_parse(const char *uri,
-                              MigrationAddress **channel,
+                              MigrationChannel **channel,
                               Error **errp)
 {
+    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
     SocketAddress *saddr = &addr->u.socket;
     InetSocketAddress *isock = &addr->u.rdma;
@@ -464,7 +465,9 @@ static bool migrate_uri_parse(const char *uri,
         return false;
     }
 
-    *channel = addr;
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = addr;
+    *channel = val;
     return true;
 }
 
@@ -472,7 +475,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
 
     /*
      * Having preliminary checks for uri and channel
@@ -482,20 +486,29 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                    "exclusive; exactly one of the two should be present in "
                    "'migrate-incoming' qmp command ");
         return;
-    }
-
-    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
-        return;
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+        addr = channel->addr;
+    } else {
+        /* caller uses the old URI syntax */
+        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -504,11 +517,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_incoming_migration(&channel->u.rdma, errp);
-#endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_incoming_migration(channel->u.exec.args, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&addr->u.rdma, errp);
+ #endif
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(addr->u.exec.args, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1708,7 +1721,8 @@ void qmp_migrate(const char *uri, bool has_channels,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
 
     /*
      * Having preliminary checks for uri and channel
@@ -1718,14 +1732,23 @@ void qmp_migrate(const char *uri, bool has_channels,
                    "exclusive; exactly one of the two should be present in "
                    "'migrate' qmp command ");
         return;
-    }
-
-    if (!migrate_uri_parse(uri, &channel, errp)) {
-        return;
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+        addr = channel->addr;
+    } else {
+        /* caller uses the old URI syntax */
+        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
@@ -1742,8 +1765,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -1752,11 +1775,11 @@ void qmp_migrate(const char *uri, bool has_channels,
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
 #endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
     } else {
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
diff --git a/migration/socket.c b/migration/socket.c
index 8e7430b266..98e3ea1514 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -28,6 +28,8 @@
 #include "trace.h"
 #include "postcopy-ram.h"
 #include "options.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-sockets.h"
 
 struct SocketOutgoingArgs {
     SocketAddress *saddr;
@@ -114,12 +116,13 @@ void socket_start_outgoing_migration(MigrationState *s,
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
+    SocketAddress *addr = QAPI_CLONE(SocketAddress, saddr);
 
     data->s = s;
 
     /* in case previous migration leaked it */
     qapi_free_SocketAddress(outgoing_args.saddr);
-    outgoing_args.saddr = saddr;
+    outgoing_args.saddr = addr;
 
     if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         data->hostname = g_strdup(saddr->u.inet.host);
-- 
2.22.3


