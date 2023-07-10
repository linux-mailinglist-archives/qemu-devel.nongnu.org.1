Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB72174D572
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:30:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq0F-0008Nb-DI; Mon, 10 Jul 2023 08:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq0A-0008L2-Gt
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq07-0000lv-Fr
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:26 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ABqv48006326; Mon, 10 Jul 2023 05:28:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=c8R3QiEWHMRTZBiyRNVpI+goxXTbEG8dMUo7C7j7v
 xM=; b=1G70x9QsF0MWE0zF8NDlME4xV975goS5iUoz0lXxotFo4rJlH4OgxDpqZ
 YSqTD/SnxMRCD9tQfQgixDrkSYdNgepKqaLS1uzn09hlrulhWAIB4aerk5nf/XWz
 QfyJ2VpWRLrNX+DDccn+EodUlGGaeso3d80o6uxAx/ADdw+2crwwn21UTqtYu/kR
 OScdkOqcsrTq7Uq4nhBLNnwlXsnPeYFRsTKbPu0wK0jK5bPC4JjCzPYHv1lGGBQD
 zYGof1dBHlYvl1kOzrlb7yaifolQHQFNULzm9vuhtn9++H3znvKR0K1IIyaW0PbF
 oQ2NE8UjLO7jJBMbTQER9xgvtNNOQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rq7butu5x-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 05:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZBDZni+/+mWkSbUsdhzHOkyfv+XSabBtt1SCUvv9wE9+edjuYlnsOlEtNzzwFaPo797zgJonJUXxcL1sNZJ/NEVrT76AOcDxCDExdpTr/SZ1QtU8tHO+5QClAJ7+7fmArhVaieOji1bIuu7hMOBdeylCrbNRqO++IL07yRdYIfoijEZDpyV3kue8KjozzCu/OKtGGz1FUm8eqcdyT2F0A9tS+VkJugxr5Uc/ADYZQa3SZt1oNeyxqPdmbgZLZQGTfBBCK5hvyjdsvRGN5nM72I0aiebViAiGV+JQWkeoyYNlpjRswbzFMqQgqQIMNnOCafQthwgYdS2jfmaZkHxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8R3QiEWHMRTZBiyRNVpI+goxXTbEG8dMUo7C7j7vxM=;
 b=EP+72Lxy4mahuC4OuJBjcHTt6bA0UEE88aS9lSPlprKdmYUlpkjgtV41Z5HAPhpSVY+8cT89xakEKb3sAydRTL434sqgQyXFug1PjasstJT/BOqkCJCh5YbR99Cq1UOg1oltbo04M98BacqtDQuqJdsTTiRkHrMY6LbfNSZjBmoYLrQxdOUZM8TgO6WcSIJkZHNRp9KYwbNK4odWK+JN7td59naL28KMkUmFFqfz89YNAoNnKCTDl68SBPMcQUUBfu4RBDefDcMX6nHQWKAma022Fmk6GA4mQjXIep+dA6uMrWgjae9EBQ2m9+dFo2FKG9GtYwlQJYOBb7P25VOpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8R3QiEWHMRTZBiyRNVpI+goxXTbEG8dMUo7C7j7vxM=;
 b=DEddv7bW2Uy9H14jfgg0KF2Id+738xdEInMI5dM3p8yyL0M6XCFtDCf/tSqeB+vRqQ+2UVJPcWaVAJRdK2r8kGwK8JSs1euVgts7UOFuYFZ3EEVZoNM77jz5wzCT7Nc8PdOo3hjPMRK2HGl7EX6OaosrLFMFOt7JZT+BxCU5FZ98ietbnLS/AZW36M151LcV3/XXWb5Nwp0p27QbP8xmmj0G4dsN7ZJ3/yelM7KuYLhQtENF54aQ1pWQHo1yDkDynDdQ1sdZTdj5yYt2WB8ufhAHTEfckIH4nAqWUCKhVl7wTx7kAUALnzbTvDqK22u2vg9IwCNBLFSm0zVi9uavEA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CYYPR02MB9688.namprd02.prod.outlook.com (2603:10b6:930:c3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Mon, 10 Jul
 2023 12:28:18 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.017; Mon, 10 Jul 2023
 12:28:18 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 6/9] migration: modified migration QAPIs to accept
 'channels' argument for migration
Date: Mon, 10 Jul 2023 12:27:47 +0000
Message-Id: <20230710122750.69194-7-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37cf8901-d086-4e47-d72e-08db81412455
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/uULkH15+sQ0mzZuimYIVXFPC6ZhOuEGF3cqKdmu/3wqADDRsFkQ0FmunYnDXgO9ydXFgokjbAJeQBYq6Sls3fyiFeGD3Fs2UAEE3NDDQpIAizPfboX2JrSsSIGixo/NiRHf0OHML+o5Gmaln7TOxCjOFC150RrKyAEGMWGEkB7UdfFOc1PQzkZT2MH/yXxXP/CFxxsWUuOXCwv8HPx9w5cMwP7evOyPxzr8T7wCGf1gqKfHfZjUyX7jEJkA7z1h/ZRqDB7mgy64dKEiunC37n72j/b5uoBNyXW+0W7mGzL0Wz3ng4Qzzuv/FhdIiStFfFh0Bs4FOZZInkWdhddCQ4Jp6WcZO6rMPF/qr4WiqVwSwvP46ygby3ISCPYRGMtoAKDlPBD6D0nSntZ1GjiTncClbWypmIsE9N1t1VGe3wjOzIN2mhS4Z+pmIHTZvac785XtywYXtSw1mqfxbdhtIYGmraxYGEuIvln9DyHJuSQxViptvykneKm3c2/Qk89Yijkfw1f/8zMBsVipMsdtAXz6nsyXPnr+hhO1NGVz+tIANxVV8tUS8blKF7Bhdi8bCft94MvRPjiY8mvfU+rWVMp5cqA53DhvmgBY6741F1wot9V8gg2rRfY2W6idHB1j4yd+kLxv4SIT/GURhyFiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(66946007)(66476007)(4326008)(66556008)(6916009)(186003)(2616005)(86362001)(26005)(1076003)(6506007)(107886003)(38350700002)(83380400001)(38100700002)(478600001)(52116002)(6512007)(6666004)(6486002)(2906002)(41300700001)(36756003)(8936002)(44832011)(8676002)(5660300002)(316002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?icAXQCBOYFB8Wrptpg2vDkMs00F3jFK/NBjRy3b/ol2DT6KpjdzD7408hBQ/?=
 =?us-ascii?Q?whyTRVWaQ9HuwAbttGNUfxmaMvBP++QtFehO88UjEVlxijpAHVhvDvQLZD86?=
 =?us-ascii?Q?rQBdt/1GLne0emc6voCfw3qggp+JdPeUjN5NBjX/BWnDvvESli35DEq3CBOv?=
 =?us-ascii?Q?JkNGrHSc4Jo92HO5ExoRd41GJbO5MDQZ6FIdxK1bfVPf7/vUBKOMKs0ogwe+?=
 =?us-ascii?Q?o8Mf+yoD5ecxjgGvtZ9h2pCbsNDyjdFGZy592o/Bf0hpHNtxRFYa9u/sAW5L?=
 =?us-ascii?Q?cL2C0u5aY2oBOU7mEaiQTrp16wADvn2bZpRamLlr3KTL4EMBSB1TGb7Eq55L?=
 =?us-ascii?Q?GIbHcQ2l7GRAzDfJ0AqJAm3+J1L47sEWZdOz3sqeglAke48zzHrl1ESro/J2?=
 =?us-ascii?Q?tWeY70A7g+1ZcaLb+s7q63ecOYq0sSv9aP1ohM+8Q3lyuX7sEHNaVJJRNM+1?=
 =?us-ascii?Q?B83mSjUQ4vS0u36TjT3OzL1sfeuIKyhI8sxGjKcjf85zTvJ/bMApglxbgjvp?=
 =?us-ascii?Q?sTt5lLgN1IsQfZo2Ka60vD9R6YtQ2dIw/4H5ReUdHj2KMQ8oBS+4avPW5JfZ?=
 =?us-ascii?Q?Sfs4nO1xBlOaWa9cHrM9yvErCNdRrxLHM2i5GNuihPoi4cys2L1x8k83pusX?=
 =?us-ascii?Q?PPjG9nahCqBvqRNbOnG8x9bBEMf8d7PH0QYFy/8DFIkoyvLiEYidO9Gq/zFM?=
 =?us-ascii?Q?BdeZmGxocxA13guONq+Hdjjxm/FpEZX0y1p/ed+vc46u4VYf4Dxe/Bo7AUSa?=
 =?us-ascii?Q?p4Hax9g+IlNbsLd31yZmCeP+IkQnaIfXgMdsgPzoY0D4f1R94CN4JABtF7DO?=
 =?us-ascii?Q?W9ou/GQkrU4AReDyk27bL5NOy6pC1L3792CAH6k4uTwKfzXqm7eDh39g12iT?=
 =?us-ascii?Q?kTdSYrcRJF6q53SoJ9EoM0eapfCu2xrk26TzN3QDZuO2WudjXRKHcaWmLgmc?=
 =?us-ascii?Q?oM9wcUyczrKAlmrfPk4pZKjxlM3s2kTH0bqeAeqjc/0itSfgC9yP13Q/36r2?=
 =?us-ascii?Q?N2PET8K6FV5pPgS9tkPM1aaxy+OlCA80s3TNran2dtvvWPzYkoEkjYPliEvn?=
 =?us-ascii?Q?be4ITE+DdAmKlshbH7g5CMzjCEnKKSCAa3IOx20+4k64gLm1rzmIm7GnTbQe?=
 =?us-ascii?Q?ilaBfh4fP8Hnf4Zcy3FQCMfN34yyOopiQ/EQRlwOHF8xtm6OzCBh/kxZwwUf?=
 =?us-ascii?Q?v1ZHXiQwoYG3qB4xuTcVshirF4TWQYd+7icWZj37ZfVdX+6tRNYiEDwQmEUy?=
 =?us-ascii?Q?1zscYlROQOo4YieoW80oB9k7g+/pwhn4SgX+yRAcVbvZqM0u+NVmtp2hQFSx?=
 =?us-ascii?Q?c2eNNeAPu7YXuEMtDvvRIRwz4sDVOHDLN48u4B0XDeTQmr24m6cD4OglKE9e?=
 =?us-ascii?Q?paMy71hCqOj/WzJ9PCfAK7NDX/N3LwUu8mP/BAlNpjzyw1h67Q9hzFRLJNOt?=
 =?us-ascii?Q?ZWd8CTLo0TjloqncYXeD9vmZu+sR79V5ziuQmvSsL83dZxJjWAp/VI8kCulw?=
 =?us-ascii?Q?ItuQn0XHpa1sEqaqDU/bq64Kz7s43oB+eEKy0qsQ1WV+CkA7q15Vno4+zzr6?=
 =?us-ascii?Q?06uI8jePXrTYbRK6S/ogN7IZtioTwrwy3OpSdlDVJTlM/ay3Qvb00ncHtgON?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cf8901-d086-4e47-d72e-08db81412455
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 12:28:18.7103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hq3zAuuXGxM2CutvTKyAgIPaDQqdGE4ZteuGPO7rBaUq1KFLZcRZnevM/+p6SFhxMZWz5rLUTfdJWu8qNFRaaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9688
X-Proofpoint-GUID: R_d4tdUWS6l976tTS5QMLlmEC8vBQj_w
X-Proofpoint-ORIG-GUID: R_d4tdUWS6l976tTS5QMLlmEC8vBQj_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_09,2023-07-06_02,2023-05-22_02
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

MigrateChannelList allows to connect accross multiple interfaces. Added
MigrateChannelList struct as argument to migration QAPIs.

Future patchset series plans to include multiple MigrateChannels
for multiple interfaces to be connected. That is the reason,
'MigrateChannelList'
is the preferred choice of argument over 'MigrateChannel' and making
migration QAPIs future proof.

For current patchset series, have limited the size of the list to single
element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration-hmp-cmds.c |  16 +++--
 migration/migration.c          |  34 ++++++++--
 qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 4 files changed, 147 insertions(+), 14 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 9885d7c9f7..5f04598202 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -423,10 +423,12 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
 
-    qmp_migrate_incoming(uri, &err);
-
-    hmp_handle_error(mon, err);
+    QAPI_LIST_PREPEND(caps, channel);
+    qmp_migrate_incoming(uri, false, caps, &err);
+    qapi_free_MigrationChannelList(caps);
 }
 
 void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
@@ -704,9 +706,13 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
 
-    qmp_migrate(uri, !!blk, blk, !!inc, inc,
-                false, false, true, resume, &err);
+    QAPI_LIST_PREPEND(caps, channel);
+    qmp_migrate(uri, false, caps, !!blk, blk, !!inc, inc,
+                 false, false, true, resume, &err);
+    qapi_free_MigrationChannelList(caps);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 52e2ec3502..65272ef739 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -465,10 +465,22 @@ static bool migrate_uri_parse(const char *uri,
     return true;
 }
 
-static void qemu_start_incoming_migration(const char *uri, Error **errp)
+static void qemu_start_incoming_migration(const char *uri, bool has_channels,
+                                          MigrationChannelList *channels,
+                                          Error **errp)
 {
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate-incoming' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
@@ -1496,7 +1508,8 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
-void qmp_migrate_incoming(const char *uri, Error **errp)
+void qmp_migrate_incoming(const char *uri, bool has_channels,
+                          MigrationChannelList *channels, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
@@ -1514,7 +1527,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         return;
     }
 
-    qemu_start_incoming_migration(uri, &local_err);
+    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
 
     if (local_err) {
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1550,7 +1563,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
-    qemu_start_incoming_migration(uri, errp);
+    qemu_start_incoming_migration(uri, false, NULL, errp);
 }
 
 void qmp_migrate_pause(Error **errp)
@@ -1684,7 +1697,8 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     return true;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
+void qmp_migrate(const char *uri, bool has_channels,
+                 MigrationChannelList *channels, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
@@ -1693,6 +1707,16 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index b583642c2d..239affdc34 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1458,6 +1458,34 @@
     'exec': 'MigrationExecCommand',
     'rdma': 'InetSocketAddress' } }
 
+##
+# @MigrationChannelType:
+#
+# The migration channel-type request options.
+#
+# @main: Main outbound migration channel.
+#
+# Since 8.1
+##
+{ 'enum': 'MigrationChannelType',
+  'data': [ 'main' ] }
+
+##
+# @MigrationChannel:
+#
+# Migration stream channel parameters.
+#
+# @channel-type: Channel type for transfering packet information.
+#
+# @addr: Migration endpoint configuration on destination interface.
+#
+# Since 8.1
+##
+{ 'struct': 'MigrationChannel',
+  'data': {
+      'channel-type': 'MigrationChannelType',
+      'addr': 'MigrationAddress' } }
+
 ##
 # @migrate:
 #
@@ -1465,6 +1493,9 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
+# @channels: list of migration stream channels with each stream
+#     in the list connected to a destination interface endpoint.
+#
 # @blk: do block migration (full disk copy)
 #
 # @inc: incremental disk copy migration
@@ -1489,14 +1520,50 @@
 # 3. The user Monitor's "detach" argument is invalid in QMP and should
 #    not be used
 #
+# 4. The uri argument should have the Uniform Resource Identifier of
+#    default destination VM. This connection will be bound to default
+#    network.
+#
+# 5. For now, number of migration streams is restricted to one, i.e
+#    number of items in 'channels' list is just 1.
+#
+# 6. The 'uri' and 'channels' arguments are mutually exclusive;
+#    exactly one of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
 # <- { "return": {} }
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "socket",
+#                                    "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
-           '*detach': 'bool', '*resume': 'bool' } }
+  'data': {'*uri': 'str', '*channels': [ 'MigrationChannel' ],
+           '*blk': 'bool', '*inc': 'bool', '*detach': 'bool',
+           '*resume': 'bool' } }
 
 ##
 # @migrate-incoming:
@@ -1507,6 +1574,9 @@
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
 #
+# @channels: list of migration stream channels with each stream
+#     in the list connected to a destination interface endpoint.
+#
 # Returns: nothing on success
 #
 # Since: 2.3
@@ -1522,13 +1592,46 @@
 #
 # 3. The uri format is the same as for -incoming
 #
+# 5. For now, number of migration streams is restricted to one, i.e
+#    number of items in 'channels' list is just 1.
+#
+# 4. The 'uri' and 'channels' arguments are mutually exclusive;
+#    exactly one of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate-incoming",
 #      "arguments": { "uri": "tcp::4446" } }
 # <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "socket",
+#                                    "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
 ##
-{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
+{ 'command': 'migrate-incoming',
+             'data': {'*uri': 'str',
+                      '*channels': [ 'MigrationChannel' ] } }
 
 ##
 # @xen-save-devices-state:
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..d811f3f878 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2651,7 +2651,7 @@ void qmp_x_exit_preconfig(Error **errp)
     if (incoming) {
         Error *local_err = NULL;
         if (strcmp(incoming, "defer") != 0) {
-            qmp_migrate_incoming(incoming, &local_err);
+            qmp_migrate_incoming(incoming, false, NULL, &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.22.3


