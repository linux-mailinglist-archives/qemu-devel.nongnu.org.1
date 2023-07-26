Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D67AF763A95
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:14:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfND-00048A-Bg; Wed, 26 Jul 2023 10:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfM5-0003VY-2Z
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:19:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfM2-0001DQ-5k
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:19:08 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36QBXhfN001667; Wed, 26 Jul 2023 07:19:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=XNzGBqA4MBlWjw8uZrEUnsjB0DC3N0RcobDGFvrH5
 mk=; b=yi9LexROwDxFV6cHzaoGFsLq3mqJqp941NfXZyQ2UYlUA95XMg91jznWB
 rXHCUM78DAqcm13Ei9sDCewW2umJxP91reOaG/rUw2684L/0e5Fp+deeNuZD+uYs
 xkA+sK8z2NboTicnYvpWDc6BR+Exih2zqYwJjZ/r4qWcDbCvtaiQmPd77y8qYwkW
 O1GGm+rFKuTXqfOcGsjb8MkY6CkTvyJo4zZx3+u9XT7NI+PL+EOszcE678eQlPI/
 PnTa7Uo9n+cMr3EzAPaMrbB0aXv0ppVjm7d7JY983pZDNe66EG2wqz7LWbncwdDv
 uhs85Ta55/rXRCC5RR0SKpGCO77JA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0envfyep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WysQ5GETmReGQjlDS/BVRMb7SPG3THQNKZihusFZ4OtrUY5TPUr+jCkuYiL0LDXd8P9lP4MzDlhh8m53W5cZ0ClerkchecJpuZSIsr1X1Z38ug5vzjQcJVCWtZ1k8p3PVlBinTf4BxJXeBcq7Wtcsxw3YOikn7G2zx9VMHstDC4Dxv3AgbnxfRS/lpq5B+D9TP33Q/U8Xz6Ywr3MOlZHwtpGK1XgBe6CIh0hcopVvbP8WSZ2AjuWM29PwDfTrU7UCZEM3yhdmr3cpuduK/TJntsg4U6/xJgDh3Th8cQvRsnFfUEJ3umUQx8VcDWG3hmB8jFKYRD627mUWfr2GwITLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNzGBqA4MBlWjw8uZrEUnsjB0DC3N0RcobDGFvrH5mk=;
 b=eg92r8RGxzGjToLVgps/2fjpEP6TdEEiy2OoeDMU5qBmXKoap5AyQJ/MZ8Zj2gQEOZWMFlAW0wpF1Tk+B5TEKP2ExJKlPsE/URGBE+WfUfl9OMMxAHuLk/xy4BV7HBO00IqpyVvMonohHwvbPdEBiWUE45ZdrlId/3oqzGmRVzxbjMnC39V28cliMOgs2J8QMwxO+0KeujhKe76h3J7hlD9PhhGRJAiyUhHv1ZJjtyHdpELUzQdDiGBAGvZFIlfilDvl/pwpkCW9A4WQgKEKIkD7aTkkSNJohtzFwjbb1BhMb0t/bpEQBi3SAIdrMDqwb321jmSH+sjDhMhWNpByBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNzGBqA4MBlWjw8uZrEUnsjB0DC3N0RcobDGFvrH5mk=;
 b=FiZKC6RjQpJpirR/AaI92M8Sj7yJbyTNHr1sZuTeZEnxeMxCJtj8U+Pyo52qht+SNgzaEaboK8QPctmY6HcYRIju+QezRImqIc1epqgLZ+cOyafSDmSITPdtaow4iyzlsuO6bX42tRmypUztOos8eNzUdLGCK6KiR6qUmP8wMnV/eg0rxhiaXfYX8GUkhOMU2u9+7P3NE1v8EBXW7VQV/kT0D1F7u4SXVjkR0BG6JNc8SNweREwl1by7ANdiAM2XbC7oaJRQ1byygKiaI0gcZaK8rNvQl61Jg/S57bHogHn5+wM3kO7G6Pl5y8QF6IEud1xveoZGCGdkf/WU+SEWEw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB6861.namprd02.prod.outlook.com (2603:10b6:208:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Wed, 26 Jul
 2023 14:18:54 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:18:54 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v10 08/10] migration: Implement MigrateChannelList to qmp
 migration flow.
Date: Wed, 26 Jul 2023 14:18:31 +0000
Message-Id: <20230726141833.50252-9-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230726141833.50252-1-het.gala@nutanix.com>
References: <20230726141833.50252-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::37) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MN2PR02MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e72812a-5b3d-4096-8596-08db8de33e27
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y43uL7g95ueIFxrJYBcd2K64RlVQuVtjew/CgC+0/2UkUIpDGLm1nXaMpg/yo5UnANW7ynV4inrkRKHOhRT0qdddO7saYhAayadqM22ahkzwZ00vNNkbd2FmnDtxoVEsyE4Xj6fUsjlYYl0Qhpt+7QqVKPNOJjhmPOGaZ0XyyN2LE7idlxUtyMIt3QkWwvwR6AYZlWb1dMNbfepP7edyGIYg+ZSNfK8/VOMgrVw1yMks6iJcCuRUahsxK/lxM9QGPElcJFDjYSIJ2mI/LpwbX2gg+zlbdmBEoRSMElNBzafaGQt2Nl5Uh3F+Uzq9ix4mPwXYOM+zVtX6hvvlET/BT6gQZ1G7KWMVH5aeMd+ZRGc0l28SHBThNnp6gK/gEa1UgKMhmShniYGkVXffe0E4e+mmts/JxFNwNe4tBftx79Op/IhO2h9nV0N9BjhK2jYl7ICt2ouB8vHP5dGftsySyQTe3RhOjAcUT/7Vgp0RFu/GABW9dH6x8V0EgIzb58NOwOSvHSWksF+YpvDuCO9985tpOklXtuYoUT5mhROzR/jCONQbAb5fKSqQjLDjgPOMpybYG5wTK/kCffvCSqZsQkqYQMmVsSLlmZxQ+GehumUU5HRrB7V+yndULwrGwmMP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(1076003)(26005)(38100700002)(86362001)(38350700002)(6506007)(36756003)(186003)(2906002)(44832011)(8676002)(8936002)(5660300002)(2616005)(83380400001)(41300700001)(107886003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6512007)(6666004)(478600001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8nioRwSzHZ9HQThLTkSTUQidKXcILXo77x3VsH0e9f3IlyHvGumZ4YABQF0d?=
 =?us-ascii?Q?NR8DfrYUB5f0N8rxbrThAyqyP99gX0nepjtB6pt6KpGrXeZ625r6v37MRvqj?=
 =?us-ascii?Q?pXqKvDO14O1M7/72GPpWpU5s8k3pmfm8SyD76rU7LdNCp+Dm7bjYUFl1Pn2L?=
 =?us-ascii?Q?fyvzVtB8nglLHVZYpn8aOijq37JiQ+hpqtH/hktRbqSq80fXTteZOpw0R+mA?=
 =?us-ascii?Q?WjA1zzXMHaPwWR6u97qH95/8QPA65Km3p/OSBKsWH+pEqStKpJQQ4fjkf1AJ?=
 =?us-ascii?Q?x4NPK8RYaZcYk0LxlG7GwTdPdM7ZCOoy5FEp4h11VDECDxlygwOoK20+GEp1?=
 =?us-ascii?Q?gnEGKwP63RACzGfZ4XNa0C2tZ88QO4Foe+w/Wr+xzRdoLeBmyN0XULAUBE93?=
 =?us-ascii?Q?OuhAv9nZNFMUO20Fd1gOKYUsCMPEBmiaNrFtrldlmhF9QaVwCrasqsbybzx7?=
 =?us-ascii?Q?okI9tSZVcUMn1X3DaUbaOSqWDc6ES/P/qb8JGCCAjTu2om/1FgvUaSJWMbZv?=
 =?us-ascii?Q?QkVisfjgRAcE8aRYP1/OO+sFZ+icnpQ/EADf0ZrKySaophPKntUGxrCy4J9A?=
 =?us-ascii?Q?nEHIQsYJb+ob0D7UukjcAz3uiFT+Jbl1Ny0mbDQKYyAFz94dD0iaFEEp/xeG?=
 =?us-ascii?Q?21zhjFUSY5FPBJY/PvCDJXR8iFLpzWIGIITq7LFt3rtvH+UoSlrsbZU5nNMR?=
 =?us-ascii?Q?S2MJaTC8IFONWAD+cB2GOOtdKosSITRajdVbuCNi0XVitOdkd0dOuNaxBhuR?=
 =?us-ascii?Q?dSitZT3xTcHiOZa1JQN+Wjjq6/9522IGEHB+O+lD0Dy7Qf0/GpZdpbgTHA2y?=
 =?us-ascii?Q?ExQAPEW/gocnFuVmg9CCIg6yezqiNFlQgLOarQTFrdzQvjeSGaoOsywfzuTQ?=
 =?us-ascii?Q?xJf3LPjZVDWfIozCPcXvHy85I8cHUk9SQPRPDJoZi7GUQVuz37EflCyRF/Kg?=
 =?us-ascii?Q?CfK72KvTQbDPABJSlp9sgoj5u909fEz2q3Dak4GSOiV+VibaQ7scaS3Lw07F?=
 =?us-ascii?Q?MOgkC6MKoy3/Um0Nv3rve+LwDMLCs5WTU1odU8zBVbHPjPJO5/z1Qo62oB2H?=
 =?us-ascii?Q?a3Kjm2xqos6uQ7iBeBZQe9vy9VNgzMdnDv5TluRvcP8uddoTZOTuhUwLSA0L?=
 =?us-ascii?Q?fQqImqo2dh8zjegFZ1u2sChq2CqP/90SOG1zx2XDe1mPvFqNulI22DkhGcXX?=
 =?us-ascii?Q?NmseIDbG0zu1WM3X2jaGdsQbvB+h/p9HIEzzxXlwkMYtUxBFWy/ES3dl8mun?=
 =?us-ascii?Q?zU21q1RL6IWHJ2/Rj0LtUXr0PZmY5g1MdPSUgjImviSvkf9l+d23NddqhOH0?=
 =?us-ascii?Q?Ri5q5NU3qUyFZ1LIFsENTn0Pdyp7M764GpIRRNzwt8HuevTIJOBcgRsrWApr?=
 =?us-ascii?Q?EjfowN9BO/xSQwTy8vNfLkD8YdmTdlCFMfNdR+9GjhE2IGdkQpRo0teLQv/y?=
 =?us-ascii?Q?wOScLDR/bxwpJxeBR+hxl4HpCgJgFnpA9mJ6Jg7DV6JOpQ+yTzIVS7Hk8Uu8?=
 =?us-ascii?Q?lA0mBRbTmv9Yq+B8VwIJPufy11dc9q693KBMRFFrcWgqI+db4pddIL72MfIE?=
 =?us-ascii?Q?lhBD26Kf/wsu+eW6Ex1AZRgcbr42FOOQAVN4dvfkr41Cm+dO8h8SWaJdMXup?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e72812a-5b3d-4096-8596-08db8de33e27
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:18:54.4856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJRKnFV7OfnMZGPa+Fi0950pWnpQ0jCgI6Yinpg0b+o4KT/+YaMI8BzVo9+S4ZsTaYoj5PefeqSIa5B4O479Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6861
X-Proofpoint-GUID: QLN4scOTokjqeeJcb8QvDOla7CsNncRU
X-Proofpoint-ORIG-GUID: QLN4scOTokjqeeJcb8QvDOla7CsNncRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
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

Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for qmp migration.

For current series, limit the size of MigrateChannelList
to single element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 95 +++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 43 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5720c8ed4c..d54ecbb00d 100644
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
@@ -465,7 +466,9 @@ static bool migrate_uri_parse(const char *uri,
         return false;
     }
 
-    *channel = addr;
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = addr;
+    *channel = val;
     return true;
 }
 
@@ -473,41 +476,44 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, "'channels' argument should not be set yet.");
-        return;
-    }
-
     if (uri && has_channels) {
         error_setg(errp, "'uri' and 'channels' arguments are mutually "
                    "exclusive; exactly one of the two should be present in "
                    "'migrate-incoming' qmp command ");
         return;
-    }
-
-    if (!uri && !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
+    } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate-incoming' qmp command ");
         return;
     }
-
-    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
-        return;
-    }
+    addr = channel->addr;
 
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
@@ -516,11 +522,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
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
@@ -1720,35 +1726,38 @@ void qmp_migrate(const char *uri, bool has_channels,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, "'channels' argument should not be set yet.");
-        return;
-    }
-
     if (uri && has_channels) {
         error_setg(errp, "'uri' and 'channels' arguments are mutually "
                    "exclusive; exactly one of the two should be present in "
                    "'migrate' qmp command ");
         return;
-    }
-
-    if (!uri && !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
+    } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate' qmp command ");
         return;
     }
-
-    if (!migrate_uri_parse(uri, &channel, errp)) {
-        return;
-    }
+    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
@@ -1765,8 +1774,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -1775,11 +1784,11 @@ void qmp_migrate(const char *uri, bool has_channels,
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
-- 
2.22.3


