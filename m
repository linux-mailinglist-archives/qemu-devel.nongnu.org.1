Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D85B714CCF
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:17:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eb0-0004CP-HO; Mon, 29 May 2023 11:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3eas-00049O-JE; Mon, 29 May 2023 11:15:36 -0400
Received: from mail-dbaeur03on20705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::705]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3ear-0003O3-1d; Mon, 29 May 2023 11:15:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmW7cUTP4RTWzdh2fQC6JHX6EcM/U47D8hfO43iB3ejDAA//hI+M1KuIE97SRD2fgWTZmg/FuUmwVIuH4MzjC0juL3Zgpar8UoRA/ydQKYNAAHTtCoC9Ejbco5cJdIswgu/+9iF2QqnZa0tOL4tNw7YBo5eS19doJhpknTTVk9qgH0L3Q9+kQee9Ht5sZluZQwzyQ6W8lke6BotkiYl3JOPlmlQWdvYdAJ1QzDXaEUYT1q8/RFZzaoYB/cY2lbcqcNRl56PTmXS/bd70i0lNTOvBMuADY+o4h7Z4CmgQrRQWif7T1XnFlGjE3Y9HXseQrSocO0Ls3JkQ4b7hI3BHew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydCkkdXq49ezaM/UTeKBcbJgEmjvmlkPL6d5TleG+40=;
 b=IdRiwwHBoga39OLMFP7FOvkatcS1TWuj0sSMRL1V0m457AB5Ms2sfGkvYvfkpxWUbWJyGHYf+rsv0XrJmIlcSJ46309kRtLO3Al8xwVubwklw3nkqtEp7rW8bzFsYqs4T9kDieqrVequdyu9/+gLlJMj895cqvC59MPSV18GkBlCRhANP5Nm3fjaPPAFKYGK1G+bH0kE518A29gN5WE1kf5NfESSAW0JuoYBZhvL9bJHFogKoWNYM7/+hOl+Cm4ihxAnxKVOxKQyiR07x6jA9QxKJlgzmX2SXCoFBtIvoOrzdpMdBgM33ImWg82+tA3+jI9vq7nMOvgAFXJ4hWVebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydCkkdXq49ezaM/UTeKBcbJgEmjvmlkPL6d5TleG+40=;
 b=TBsh9RyxqiRkpcH1eH/F2TVWWt0zyZslf2Eise7GfD3bp9tJIwK44oxHz90yIIu/ZibPmac7tkp4ldIGaECHaC0IdMtH9tV+2tyfpBbJRjHXVRVDsAmrWrjkZyUka4w251bLiuBM6W4a3k7CaHM+5tRv4hRmPD1uVvMe7KAF8zprRr+P+z5vn9GxLUMfu+mby2Xbvzbft7vgTBuwJzvjC8oEw06ytmkQt14Ns3HHjRtFz1rsMjHW1ga2mSAwL9SrsLVT4tc4xVRhkuBV8ygpfIFlU5xnnwWuWsuIvJhXVrY5C9sFLtY7AskjtHB6myvtV9IyhUQExm+VajtWK/daPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAXPR08MB6382.eurprd08.prod.outlook.com (2603:10a6:102:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 15:15:13 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 15:15:13 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 5/5] parallels: Image repairing in parallels_open()
Date: Mon, 29 May 2023 17:15:03 +0200
Message-Id: <20230529151503.34006-6-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::8) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAXPR08MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: d08c89da-e3de-4463-1521-08db60578058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++2pIJkdHx47HAKUkTJ52OBOzuaDh3XuvTLb4tDoO2g8OTPFOH3xr1BpjqfxhmJCC0dcpbJTZoRguGZ4QNmLTD/FxbDuuMgTwq85s9S42xWY8oPeSMiSN+NXieEvO+6k9O18NFMozgZlhmQf8n1g+y0e+H0XUIw4KmzMp3rzy9ma4Q3epuYhlfai17DdpBKZcyqN/JBfC2uvAMRDfuA3BvkoVhQatdJnPSKpw9BybxwFfiaUAidGeSmTyjJiL2zn3jTD7puP8o64b0qHHBAvqU8u7qEAYwIuTbdYrMvvipabJwlElmS3nDBWdOyqQZfu5Ydc9SyDm8PWki1Wq0FX4kfWsCv+m3Kt6QsC33UDh0gPfDqxPiIKm1YBMYIYSVfjoYFhT4Ngm7LTWLJIWswAJmWTpiF5CJeeVY5DoAaoNkNlDpql81ZIJuv/RdNswAfc8H+nzeAYG6FvWypz0slD9nhLIswlf/CPD/g5YZVO5gXuymvTXnKvSwrLUmfzjGvfLtrDuGgAKTAgqos22ADmcICglPV/o7aGlPQ6gfUiySpaCtvP3aM1QGWu40nsKLb1z0/eUNnBTFrHX+cLIVNvqjoCctVlBE5PBbip0J22n1zg/x7FO7jsOrLD+aKNj9yA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(366004)(396003)(346002)(376002)(451199021)(6666004)(52116002)(6486002)(2616005)(83380400001)(6506007)(6512007)(36756003)(38350700002)(38100700002)(86362001)(1076003)(186003)(26005)(2906002)(4326008)(316002)(66556008)(66476007)(66946007)(6916009)(8936002)(8676002)(44832011)(5660300002)(41300700001)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IF1c9ZK9/94sOQ976tef4HAANkPfZkRyFJmy/njKT/FbyilJfybgocLBqppv?=
 =?us-ascii?Q?N0ByCdBLBdWRFfK9eADJOcgNCAFDE1SnIBkTwGnI9KrFzwP0eAA/7xEpv6qp?=
 =?us-ascii?Q?2VsLYCoxsiHC0Av4Zy5CGNfHOXQ0Mqykj0CZGCd46W1V+4MwSqJvCJa/U794?=
 =?us-ascii?Q?FqSJVMH7cyijRZJjtXaJaFf+42NBHaYzi9gJjgCvuXewrHZ5doFF7WIvTyOC?=
 =?us-ascii?Q?KFlhDIW5pA2l6RmUMHtDYzI/8vtr4zl3FXld/RxhGMbbtJv/4pBJ/SOdeNMN?=
 =?us-ascii?Q?rDgN/2mrx3k4e9T+ULCMvT5rOn4CJswSffy4eio/W+fjEmPwR1imJEVu7x/I?=
 =?us-ascii?Q?EysIp6SUblGmVpo/YefWBpt4EPpGg9iUxKO0R7l2Ckhhyjlv6EwYvNIfGMdI?=
 =?us-ascii?Q?sn3Jj3gj9i65CFkYg2iWOimulTsWbnhrvE3MLylpeYG6OluLlOYSq4qlv5bQ?=
 =?us-ascii?Q?gC47sJwnXLG27wJqLCdlrhKWHlmzU9cOpp1m4mCjvHCxdoEavgE+EQMKlKAu?=
 =?us-ascii?Q?7RnigyIatc3mm2HT2By1V0Sb/FgYW7cUMsNPdYWNZCpq7CFWqMROW99w72qj?=
 =?us-ascii?Q?5hS3va9LZl3aHwKbapOVT0fhTZJ8A9n4nM2ZNHkc4N2upjgtLzZBjRBhNX2f?=
 =?us-ascii?Q?gpw+5v/WZNVLoV2aCF0PzLAhFISzXpjkXiS9v0UaIeHyh+MCMro6lBV9DzdZ?=
 =?us-ascii?Q?vXQg3PBZcslSuACGUg99EC7a6Rx7y63bDINEkMbYIbdpk18lCrR+hu1FqJn2?=
 =?us-ascii?Q?473UIcy3hFIkrM6PlNAn6F6Zs1v/HOS5Y8fRxEVaB0WyY6B1dixuOtmkZmk+?=
 =?us-ascii?Q?hV4C/rbQ9lgbeB6749K5kKE9o5OuwJJKqmyCuwcIZ4COzX2V0h9YrKYFBau1?=
 =?us-ascii?Q?NqxlTy/4IojEelzJO1Ua7Z/a+VUTyWEbCI4gz/IFAe7Av/g4Yargn5uS4/ey?=
 =?us-ascii?Q?M67kxodEZoKsk7ABpI5/lpesHf5UbxagzIogLEg1G4M5O9vMlFOdMPFqXcyH?=
 =?us-ascii?Q?m83VIi+uljTiFxyknmmcmZ4Uyb5q3qBwSayHecfx8myHpm1vsYDdOP4g6MDb?=
 =?us-ascii?Q?lRRXVfLCuoWQcxXbVd59IrVuxSyXsR9JDzXeRAzOVok2Od4wbbL1y76/V0nt?=
 =?us-ascii?Q?Q0bhG/nNiguHs14TJL12dOEIW8e4Zk6y42ZINJTskmJioAKFIO0erwhJmS6m?=
 =?us-ascii?Q?TYGyug0Vpqque0Bs4qgcxKwt0zRlab92IDE3KsgK1ronFM2uGm1mlkC8kA5z?=
 =?us-ascii?Q?cMdOhYjJqZCdPG6efNvkCabIgLFgaQLmuMk9vFbVdLCL9qYZizqugTZP+MX5?=
 =?us-ascii?Q?Whmy5rWIIjnYs1gfHQ3GT4DAHTqGSvi2pV7P2yg4Orq9gr1ocANIHIQ+kxJu?=
 =?us-ascii?Q?pnLMvNUOF/4SsHUcWTlBbnbaI2H7d6ZAnyk8ZpQZQKcxLNOxiZWhcezmCIA7?=
 =?us-ascii?Q?ClQQpjaZXd18+ktykJEEU+j012mpOmB6dk2Eu0pwOsQAzoeuuLWW5QNNU9dj?=
 =?us-ascii?Q?W1WJszCkfcp70EOpwVLFrwBrWgdbYXC69i8JXao27hDzAGthajJJBKKVjYUr?=
 =?us-ascii?Q?m6VZCNLNOyhSmyb9Vy6QzxPz19eJdFxFRANbU4zjc+e37FwVrSgvuq+cpwhU?=
 =?us-ascii?Q?zrvJaQ2P0dnJToZ049Km0Kg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08c89da-e3de-4463-1521-08db60578058
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 15:15:13.6175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09cXS0FEHGvM/U/11bjk2Cza4b7Adh8V4encCLDEzb9zZKSWvCPJ/YypgJwTqIuSBdMgMQqKqg4H/yaNRdjLPcdaRjEi6oQJzGGGrzCF9D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6382
Received-SPF: pass client-ip=2a01:111:f400:fe1a::705;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Repair an image at opening if the image is unclean or out-of-image
corruption was detected.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 65 +++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index d64e8007d5..7bbd5cb112 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -962,7 +962,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVParallelsState *s = bs->opaque;
     ParallelsHeader ph;
     int ret, size, i;
-    int64_t file_nb_sectors;
+    int64_t file_nb_sectors, sector;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
     char *buf;
@@ -1039,35 +1039,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
     s->bat_bitmap = (uint32_t *)(s->header + 1);
 
-    for (i = 0; i < s->bat_size; i++) {
-        int64_t off = bat2sect(s, i);
-        if (off >= file_nb_sectors) {
-            if (flags & BDRV_O_CHECK) {
-                continue;
-            }
-            error_setg(errp, "parallels: Offset %" PRIi64 " in BAT[%d] entry "
-                       "is larger than file size (%" PRIi64 ")",
-                       off << BDRV_SECTOR_BITS, i,
-                       file_nb_sectors << BDRV_SECTOR_BITS);
-            ret = -EINVAL;
-            goto fail;
-        }
-        if (off >= s->data_end) {
-            s->data_end = off + s->tracks;
-        }
-    }
-
-    if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
-        /* Image was not closed correctly. The check is mandatory */
-        s->header_unclean = true;
-        if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_CHECK)) {
-            error_setg(errp, "parallels: Image was not closed correctly; "
-                       "cannot be opened read/write");
-            ret = -EACCES;
-            goto fail;
-        }
-    }
-
     opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
     if (!opts) {
         goto fail_options;
@@ -1130,6 +1101,40 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
     qemu_co_mutex_init(&s->lock);
+
+    if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
+        s->header_unclean = true;
+    }
+
+    for (i = 0; i < s->bat_size; i++) {
+        sector = bat2sect(s, i);
+        if (sector + s->tracks > s->data_end) {
+            s->data_end = sector + s->tracks;
+        }
+    }
+
+    /*
+     * We don't repair the image here if it's opened for checks. Also we don't
+     * want to change inactive images and can't change readonly images.
+     */
+    if ((flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) || !(flags & BDRV_O_RDWR)) {
+        return 0;
+    }
+
+    /*
+     * Repair the image if it's dirty or
+     * out-of-image corruption was detected.
+     */
+    if (s->data_end > file_nb_sectors || s->header_unclean) {
+        BdrvCheckResult res;
+        ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
+        if (ret < 0) {
+            error_free(s->migration_blocker);
+            error_setg_errno(errp, -ret, "Could not repair corrupted image");
+            goto fail;
+        }
+    }
+
     return 0;
 
 fail_format:
-- 
2.34.1


