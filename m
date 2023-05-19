Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B1709403
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwhh-0000S8-L1; Fri, 19 May 2023 05:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwh7-0000C8-Po
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwh5-0008Sq-Gk
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:41 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J8qln1011300; Fri, 19 May 2023 02:46:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=ISIUxtMRlIOIJp0TeuSX/VCex3O11KEXuVzJp63I/jM=;
 b=LoTOsL+ooTgaEQjvk1Hph/gICQQ/tEhn8oiZk4q+Z5+xv29pDlbk9AlEpMGqfrfbE8fw
 1kRJ9c5PoIAIQJrIc8zjXEqSZby5BD4gCQcSPRMOGxmyn7N1VXt9rl2IRBErS91GHb6U
 sdpa36nNb7OUYXy2tZNAmah3wWWbyuEuWUb6n06I6HcXxbEzbHXu0UxIUox8+/zSsnwC
 +pgfbRatMA32KuJih1r+9QA6WOGpVxAkrwYrgOc9pn5peHDVPvKSp7BGVymh9b+x/DRr
 jOoMUVq2ZE2vB0Svm+riwkXwH0rEroxke6hDC/d0un3MdNJbX7nU40snMuxXf38NKzni Sw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw97vjca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDZxl6JoDepuG9C3Qq4oGww9zbFnokk9p2qnMHNiJq0HSZb9brV9yFAcciKGcC9ZV7Olo4w6A6GmIyGJmZ4JjndEkIoSncXz/bq6s67UtPQ502FB26uZkLR1i4nOAhrDPjk88Wrla+Ht91G3mBKk6fxtOpajPcWLjqQgxzcg6ppRXIfo1KhdI6rmtNTvFnqC6BlmCwvqV2JgbfSWEnJrcsZ5Ess3UlbuMCQsIPoX4Ti+5fEpIKK17c9wbIdGTnY6HdtOlIaE6BuZTGkxyWVq+juc28n9nMjtc0zA8fb2yPgRlavV4BFZJ5VRIQvzZU4kC0S1PP+LeLdT/ZNgHS6hzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISIUxtMRlIOIJp0TeuSX/VCex3O11KEXuVzJp63I/jM=;
 b=CGS90I9e2ps5om89uf+N/WlcvZW8yp5o4V92zjPWh6vkmSTjrunHRSoGgwVl4ObD+nPws2Q4GhKiObsFAV76g6wCP08nKmleYwKn+WdC9a9nuRJ25WTav+ORgoznOh1tr9ztrIVm6MRXJdQD0RuRM6lKkcaRicCnF7vd1jIUWQHScuw+eQcTBNSv8aE40/HJk5AE7JXBN4gOb8WyxX3Dnvl0rqwHbJxcGXjaFXU8jngiFboJSClqIy8zWfEVFRTwP+cuxoUXcofunss6xHBkbWlRm7OvTGDWk2Q/bZzpDlk0IFezXxnck+eOTiDruHbpzU/qLgqQgJfqhNoJ5XiRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISIUxtMRlIOIJp0TeuSX/VCex3O11KEXuVzJp63I/jM=;
 b=puPS4O6BVYFGRVyPLCpK7oFz6w/SNliMI/EGljjM2nYl1Iar/KK7Uwhn2vgM52o+84D7U6zpDy+7rFkkAMc2K91YncFSb8K6DInrYQPFIqLhvJzZKPagCPVgcbm9w0dzzys75op7k+6FrKDRXOdiP+YSOBpTM1ZP7NgklH9wi90GDX8v7hvNyu1LscEzncZNTQDxzjupHgbQRthk6/TmM6v5F4Wn2jxCHT91LnY1CGMeMemlPczTWuDr99LjXS3IKcRf9NSNvSoPs1Kox145jIVur4E2+85540eQdRKImaINk08oOTewGrEdGCgkCWID78YfkaKYFhbmdvmRlP8+DQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB7912.namprd02.prod.outlook.com (2603:10b6:8:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:46:35 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:46:35 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 8/9] migration: Introduced MigrateChannelList struct to
 migration code flow.
Date: Fri, 19 May 2023 09:46:16 +0000
Message-Id: <20230519094617.7078-9-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: a6777e47-c924-4671-f95a-08db584def0b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VimLdLSfFyjb6wEQPKAoVHNL3bmGIx1t0dfe2zLK9CUFhpo+XY9fu2Um94MwseEMrPo2j/cAovhpCZRYBzWk2k1MhHA3grEm7woOjgiOLuODWBVxagtSckeTGvmGV5JFFTRsw/PiU1D1rrGpte3TCsFtmatkimGfF4DY1kI2hlUavmXCvGf7GmBpxzN+lELZ6OC+pPYnwYdrYSXOzdErPAE6/hJYWA17lKOPL3xSh8XBykfCb3m7gzNM7QCyj2RJM9K+LLJXFav3h0u5/jSS9+zAFKCz0eiacAFqH/9gytAsUsnD36AOL/w3NDbIFHpspUVzuZgogoidVDlh3di085kVKgV3UzM5KW1YSRH5Gv8eZR5yu78LhSwKQWHH4iTqImMmDemp+0HsqyizyTPHTAMHgnkBS25psn7x/oDCelshbqwslZjBt0IMtkajrDl92hl1OTReeOgmHwjJUoLmeG5ejb0zbsPvpQeXGd/woh+bDxyOzHizclkTv1JO/2oxpuhdBUQFMFdRtOo0EW9DIe2QyVCmJFkBLVruCOYstDPIhsnosYUWQal4IPVsgUF67e1/KpbDXXG158fFqrDhQu8BNlUbjxfVlI9Ty5EUKiBboxzT2U8FzffXDAHzHA0Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(8676002)(8936002)(5660300002)(316002)(41300700001)(66476007)(38350700002)(4326008)(38100700002)(6916009)(86362001)(66556008)(66946007)(83380400001)(107886003)(6512007)(6506007)(1076003)(26005)(2906002)(186003)(52116002)(6486002)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ihqXE5maWL7PSZjIs/DA7uWYQfO5mrwwuMZiCVCXNE/CN4tvKnMxJfS8XW23?=
 =?us-ascii?Q?FiFi+Io0OM+EO1tQGkeCwvNhmJEsc+4Lbw+ydxqLAzydcJ+U8WRgMU0mBHtS?=
 =?us-ascii?Q?/z7tsffegXkcm/uuXRvxs96ErmHgpuarXeFpu1B/5XB5w1NRBH7QlCMx1W83?=
 =?us-ascii?Q?nnuDtOARWYzgdyZvjTucOwfNgBdrV6EK08MmUAQSRiOFzdA1dq8CCCMgYOOx?=
 =?us-ascii?Q?mRjP6GJDcC7URK/cOPytGqi1weiQ3j9sJOFset9IaOp9hefVPOKE6HjEGi4C?=
 =?us-ascii?Q?V47MmuEmoxO4GUALpk+KOwamgJz5CYjP5lj3RVQtQg3tjjtMJJxUBNv3dofY?=
 =?us-ascii?Q?xioo6TErcSSvtcXWvXM1ZR/MPTspAG3flA6SHZzF9k49LlddW9xRWdAFtoGF?=
 =?us-ascii?Q?XefGedplhUwCTL/fm+Dp5Lm/Xjqu1FW2/MrFy6HWZQDKQU2cJJFb/vbvxs2n?=
 =?us-ascii?Q?Bk86ym9codjqLk6w2Hgn8NYDnVYMI77qcEUajGcca7nEsUl3YEmEXdo0p56q?=
 =?us-ascii?Q?leaG7vhJJI5ewrNo4SDSYGWKbswT0DMBoV8t7yNUv0c2hZpLtGEGVK9YDuDR?=
 =?us-ascii?Q?mETQ9g37WvsPlWcAG/md9YhNmP85m9upxN9nZYUklqsuSKd8waj2JKYunH84?=
 =?us-ascii?Q?4803jpQkpOcNGPgwjMKevIjs6hv5UZbzIGDVKzOn4Jr0D+3Mr6aAomaRLkl2?=
 =?us-ascii?Q?1CvbPIJZCtwz6XTa0bmXxOBk2HB7sCl/ML7vYP3rJ0LMp3WghzWqyTIocp7X?=
 =?us-ascii?Q?I+r6a1O8DJdOgI2BiO6JzkfE7FNaCNLlNPE4RV7WwYaSVjaINalnT9Bqije3?=
 =?us-ascii?Q?KRCcJJJZ/gFrg0B4phBmzrvWULq5Qowe8j+5Pv2mjHOETLXazvk8T56m1aLZ?=
 =?us-ascii?Q?jE25FsFtxQQ//UuaLg6K8WWWq7WkDgBnJ5g+3IMJps90koRNWfHNg3iqdTkA?=
 =?us-ascii?Q?8LY3rV890j/j4k+NcWwKtmDix6hAnZUDBYp7YrmvLmMbMWvSw7EQMuSYZx3l?=
 =?us-ascii?Q?hC09OgPVdMi3FHaTY9GRcr0k2mbZ+SRDyt+vCXL29mVsi0bSVl5WYULuY5EW?=
 =?us-ascii?Q?IhXwRp39M2uY5cFUc1sniBeJZ6AJ3X7zGncTMk0rgfjDRwwkFqXnwwWdd0ys?=
 =?us-ascii?Q?vdyvWwO+iZuEfzaJ+TZU3B8YFM1aHbozTVffcyxe9sxIcDF26qJf8yndxisQ?=
 =?us-ascii?Q?02hwjiXhX+0V6qBD+RVzahYlOyJqRVreKjSBRZn8YJdtBFJdhWx8goNCHBDt?=
 =?us-ascii?Q?NzpGn8ixcPTiFE2ukfC8Fa/xH3eMzQXAdMPXN9Ea1UZRv/ww1Fgci/hHRi05?=
 =?us-ascii?Q?cue9VOSXe2Wb7+KaQ2gBvisHA7Mfbqn7MyTZDjmAYZaobbxjSlyTMTQVWsOi?=
 =?us-ascii?Q?1zFSGSRf91FsKIDX8kVSziuUggl3CPtffh8MnSgMY0kazd8OT5rmWWA7jHdq?=
 =?us-ascii?Q?Jmmyoz8vPSsHJ5yLU4ovIM2PPXrlKyOpf5DoRMcXH2gWYE4zRYrvhZL43q4b?=
 =?us-ascii?Q?zcreD6184Iz5XH0EW+OIamPM0NysL1Sk8Vz1+gNwkjL9r3MZH7Hpqtg32C/X?=
 =?us-ascii?Q?AdxaKGFZY+H3AAB3MecJXZdG5RxkbxTgGxUMY45O?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6777e47-c924-4671-f95a-08db584def0b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:46:35.5109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nwysd1q03YXIq0Znx0ckWv3IeyXm4W5Z57sSrXhnemRFLlNMxajgPJ/m/NOXUV/Os41jYXl632KP/bD7BIYWNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7912
X-Proofpoint-GUID: xgmAJLvsx14-6ltS9YDJkbkL3ww_g6Nf
X-Proofpoint-ORIG-GUID: xgmAJLvsx14-6ltS9YDJkbkL3ww_g6Nf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_06,2023-05-17_02,2023-02-09_01
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

Integrated MigrateChannelList with all transport backends (socket, exec
and rdma) for both source and destination migration code flow.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 75 ++++++++++++++++++++++++++++---------------
 migration/socket.c    |  5 ++-
 2 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8afdea4f91..57085753f4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -424,9 +424,10 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
-static bool migrate_uri_parse(const char *uri, MigrateAddress **channel,
+static bool migrate_uri_parse(const char *uri, MigrateChannel **channel,
                               Error **errp)
 {
+    g_autoptr(MigrateChannel) val = g_new0(MigrateChannel, 1);
     g_autoptr(MigrateAddress) addrs = g_new0(MigrateAddress, 1);
     SocketAddress *saddr = &addrs->u.socket;
     InetSocketAddress *isock = &addrs->u.rdma;
@@ -462,7 +463,9 @@ static bool migrate_uri_parse(const char *uri, MigrateAddress **channel,
         return false;
     }
 
-    *channel = addrs;
+    val->channeltype = MIGRATE_CHANNEL_TYPE_MAIN;
+    val->addr = addrs;
+    *channel = val;
     return true;
 }
 
@@ -470,7 +473,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrateChannelList *channels,
                                           Error **errp)
 {
-    g_autoptr(MigrateAddress) channel = g_new0(MigrateAddress, 1);
+    g_autoptr(MigrateChannel) channel = g_new0(MigrateChannel, 1);
+    g_autoptr(MigrateAddress) addrs;
 
     /*
      * Having preliminary checks for uri and channel
@@ -480,20 +484,29 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
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
+        addrs = channel->addr;
+    } else {
+        /* caller uses the old URI syntax */
+        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addrs, errp)) {
         return;
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (channel->transport == MIGRATE_TRANSPORT_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addrs->transport == MIGRATE_TRANSPORT_SOCKET) {
+        SocketAddress *saddr = &addrs->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -502,11 +515,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATE_TRANSPORT_RDMA) {
-        rdma_start_incoming_migration(&channel->u.rdma, errp);
+    } else if (addrs->transport == MIGRATE_TRANSPORT_RDMA) {
+        rdma_start_incoming_migration(&addrs->u.rdma, errp);
 #endif
-    } else if (channel->transport == MIGRATE_TRANSPORT_EXEC) {
-        exec_start_incoming_migration(channel->u.exec.args, errp);
+    } else if (addrs->transport == MIGRATE_TRANSPORT_EXEC) {
+        exec_start_incoming_migration(addrs->u.exec.args, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1698,7 +1711,8 @@ void qmp_migrate(const char *uri, bool has_channels,
 {
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    g_autoptr(MigrateAddress) channel = g_new0(MigrateAddress, 1);
+    g_autoptr(MigrateChannel) channel = g_new0(MigrateChannel, 1);
+    g_autoptr(MigrateAddress) addrs;
 
     /*
      * Having preliminary checks for uri and channel
@@ -1708,14 +1722,23 @@ void qmp_migrate(const char *uri, bool has_channels,
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
+        addrs = channel->addr;
+    } else {
+        /* caller uses the old URI syntax */
+        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addrs, errp)) {
         return;
     }
 
@@ -1731,8 +1754,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
-    if (channel->transport == MIGRATE_TRANSPORT_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addrs->transport == MIGRATE_TRANSPORT_SOCKET) {
+        SocketAddress *saddr = &addrs->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -1741,11 +1764,11 @@ void qmp_migrate(const char *uri, bool has_channels,
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATE_TRANSPORT_RDMA) {
-        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
+    } else if (addrs->transport == MIGRATE_TRANSPORT_RDMA) {
+        rdma_start_outgoing_migration(s, &addrs->u.rdma, &local_err);
 #endif
-    } else if (channel->transport == MIGRATE_TRANSPORT_EXEC) {
-        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
+    } else if (addrs->transport == MIGRATE_TRANSPORT_EXEC) {
+        exec_start_outgoing_migration(s, addrs->u.exec.args, &local_err);
     } else {
         if (!(has_resume && resume)) {
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


