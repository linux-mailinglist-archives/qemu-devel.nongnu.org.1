Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCCE714CCE
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:17:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eax-0004Ac-Oe; Mon, 29 May 2023 11:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3eaq-00048k-D7; Mon, 29 May 2023 11:15:34 -0400
Received: from mail-dbaeur03on20705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::705]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3eao-0003O3-GE; Mon, 29 May 2023 11:15:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXvBWo0+m2WBeiyFH0nerKm+b/CF14CLdmOm9Qj2BcJUQumz0sPepRTbhp1zLQq9Ll3QNN8xgjX1HlCR2KoRBEul4XyaIkyMdDgvQZLXJgp2nMFnR+7wkBHOL0WGVH77BIscLsxIlFhYVAXgP6xqmpUc0GYD0WG8YjT5VoG6j/QqwCB/96xamG3kWvLIUKt6/Tv1pSb8mBDmhn8QXCDkP1GRQvG+l21E2czw+fl3fiXgAdYh+WqSsbSmT8VMZEh5GoL5cTsuHsa/KTwqdTGR5MJMB37c25ShQUjW24FN//H7RETkDMw5NZAqj+NJWaMGXEHQL7jKyDVtkigdcrd/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SRHt3tGMMReKpGwUTGS1ssKn3Nd0gDkK+rK5fsxfeo=;
 b=U8Js3s9VhRL4+nYnQAOrh8Vg4jxrXNhKvaeI3L/PxM8zQQ/z5ZnTmYYANtZkBMSwajpK4UjUFbBEOO/6yPQXCNlf5U24azQFvQtyNpp03AKfQMlSBr3onKScTLW+1EBIhDVJ0U+I9Rnvt42HUhUKjw7uxb3dIlDFMaVvSOL5r6K7pT2c3pXpBMoqwVbS8XlUqyOA6L7K8HA0f37PJmQhaNSfHJmF0Tns1cLVCXxpPEFVblTjQSIBfKxsPSIqRO6KsMdOvRmGFqvGWH5FZLAr5fWAJJT/SH5HTnz9cOnMo554mpHzBtL8ruUCkccxXBurrNnbMNQbNpiakV45yDYmHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SRHt3tGMMReKpGwUTGS1ssKn3Nd0gDkK+rK5fsxfeo=;
 b=QZp2Q9osSgbTKtMeNaLK8CxJHbfXptOqW/DdI9NQHLW7w77FkU3Nknnjcv75b9J0VylMa89kEXg4xXS6GEY5HHVASaq7ZhD3KzuuiqLMQCs4BHUituGFnFCwShiAli2uIqTNn/d4KbqEUdaa2AJQZmFGRL4k/a7AArH7l6XdxLwVMIjvl2Zr2ncr00eQOEdqynmNqePSkoYlVlhN/0JbXWSQlHndklQ960fyDGMRMD02HUXm4xKdikX9DoqqQSYNOFCU6xMndsPRjoCtiwx1tQvGeaQ8YxbZpVcDJjhAuIg9WVCBluR5eWtbgRWjDhuU/BgcTWgc0v/Td5RAS9aHnw==
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
Subject: [PATCH v5 4/5] parallels: Replace fprintf by qemu_log in check
Date: Mon, 29 May 2023 17:15:02 +0200
Message-Id: <20230529151503.34006-5-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c9d5f6bc-e52b-4ae0-0b9f-08db60578007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FW5cn3spsZVAU1Mqt6WuUkta0UjzJxXVF3EPxCrbrMT/0O1KHVpk+v+L30v5yQ5CzAdSRGKz8r6eJWBjKnT1zyAOQq3bOEY/IaZFN9n7c5Iyw4nHm1H/4MPYcqagCWEHrRdixCK8uAxRoLr+f35lcXIkl8tp3RuDUAyTZpwClHTGjnpNPeajvfTResLq/ZmYuJeY3LBA3FV/snp9mhkRQ574UImhtENnKOgqjmPFCNMOon0A6AVMD835mJJfA9sBJJnQEjCN2eu1BofaSanXq1wxyj35241lUxGXFvb1s2+5KzfigN0oc80aOkgZRe1QIJWMGVFL4I70gzayFg9VMKjyPatjnw719ko26nRUExE+qoopV4u8CMJlRz8FCqj06W14Pz3jknQAHVjxIcznXy27VnmGkgn9MpxrYbcWGY/zQbM7v4xCJDErOB6PxG0jc0Dc/SGVhlGz1d8A76ed1JZBtRt8UiZTmt8WbN/54oAxIVZoxJNIt8xtxHw1UGpjk33QiIQj2zEzSDH+OodDk6uNq9ZlbztRuCdv3JJW4x9NZcd4Jst4q4AOZbyZn8vhGXwBNdhjcmaP2eWzCVvGxnINfp7HCqj1cqE34r6qZwhoE+pSOGJG71RIrrjqNklt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(366004)(396003)(346002)(376002)(451199021)(6666004)(52116002)(6486002)(2616005)(83380400001)(6506007)(6512007)(36756003)(38350700002)(38100700002)(86362001)(1076003)(186003)(26005)(2906002)(4326008)(316002)(66556008)(66476007)(66946007)(6916009)(8936002)(8676002)(44832011)(5660300002)(41300700001)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7NsktsYH99Sp0yJ8fqi+lKFzhlHtajTwlewZYqW6WuJKD36AF2jNAO3zxZE4?=
 =?us-ascii?Q?XKGqWdU/QdfajuWtA5QV8zL8JUsJN9rxUSNe3WwyFdWP5cEyPbK7FhbRireO?=
 =?us-ascii?Q?jGtnbNS4U9rp60LHiA8+2eMz4sVNQNXTJ5Y89PT0KXCXtqoihzLA04K3LYTR?=
 =?us-ascii?Q?z7k7JftRRaIvB4GACY7gqacDmjEBGL1eqzV9Mt5+0b+SS0HaYB8jTV/WWKM2?=
 =?us-ascii?Q?eCPpjxbSDqU4cUJGg29m7RmX/7GtE2b4lgAoDYLkgMD3I4Llg4LXi3DY0Ncw?=
 =?us-ascii?Q?2oM1qqCKFR76L20GZkoHIG+el42+GHvXhWGNnTGOVbtWqHeNaimORyfr84pj?=
 =?us-ascii?Q?zQxn5o10LB+Xu6jyvbqowRrfkJSg9PN4fUCVROrDKilb9R0Gd/R0VVQg8rd5?=
 =?us-ascii?Q?1bkqVDAUtgxvvd9P6KYZQgfsJJWw7QQIHnDYbrXvQ6rF/SjwuuFotcG5kuqz?=
 =?us-ascii?Q?QTDY4z5tGx7iGEn/SvaiPvCle1gMQtFhNOeZ7LyFYBrWSkG3Qm2m5BO/VBHq?=
 =?us-ascii?Q?jWd8GhrkDPAOUlbd6Q/XA+BcPYPqaP6Ou+D2gJOyV/w7j1sbQXC8vZadmUXI?=
 =?us-ascii?Q?uPn6sT5VA/vId15uzRDKCI0upJYYdiUTSusr6n6QTRca/Z9sGOAkw0+gFVBH?=
 =?us-ascii?Q?9EnjA10o9k6G3L+yCUtSa54GZtFDrXVLOL7sx3jBaMkURHdoJb8LEB2BPy/F?=
 =?us-ascii?Q?/Q4pMtKGb8cqEKmi/l1cC4tqbk9AwSowZGWXTIql+8h4pL/J8OxGG2376MlV?=
 =?us-ascii?Q?gxopOzTW8nQfS4upujGbAt7wYZVLoe/XDmd8l3uDiTn4UFtrZZYPRNhvRqGR?=
 =?us-ascii?Q?OKR2S72BTHmU3KkdUhA0+p1tWByl60/NiJY6PRKUzHSHRy4zWlyCPZTTPMBT?=
 =?us-ascii?Q?Ui3+aSBksRh985j+aLCjzxHZcgjRxG851x61oFdNVLqefPmZoxLdydziQgpW?=
 =?us-ascii?Q?76oIe6Q/S5463Gy3a+xZM6v2AAYsyPkHKr2udwnbuccO8Lz+ci8Oqg0xIxvG?=
 =?us-ascii?Q?N7pzm4oDC1SLjUeVjEKOfMTOBJdHeysWn65kcvxSXxzYBCzzkuUbBykgKMv2?=
 =?us-ascii?Q?8w30P+nrcR9VSAtUHkJXWRG6VAAp1cU5NqK3NHqVnGhjDLhf0KDcsAReBZia?=
 =?us-ascii?Q?gjNsAjMNpYm6pOhrhFnnpk/fu9GLfRravEUbqB2PSad/emJhT+UN/XWoeaBx?=
 =?us-ascii?Q?m/HjupzsaAE0XsXtC6RsUVyJ1Kb/KxiMImU+pL57lCBfrtRfDA43XD1ibpsa?=
 =?us-ascii?Q?qhqom2GSNeYDVA25IW62OaiakiVRMo77aiXhraU9KRE+o+5L9oY6UtOoDGnx?=
 =?us-ascii?Q?I2xrF3JWbiCH7NcAMz7sv2agiwGbZAWWxKJPK8aBXXYEcicr2T+hg4iXACr0?=
 =?us-ascii?Q?b0k6yjrK3RWhu5sI27i6k3KhprZ9gpSFIZ2ezTiHehh+XIlUlKUyU1uu9DYS?=
 =?us-ascii?Q?vBpQWi+MgUecrOeAf3h/twNz8eYnwE91NKwtQ8CBGuJqCwwNBqTJ0Dcd4SCA?=
 =?us-ascii?Q?N/6LjnJwZis5SiqJOwHDZF4gTOVw5k+asnLXm4uwQ0Mk83ervXEsFUmXsyqI?=
 =?us-ascii?Q?B2Rv0nyIkdIeGXDbKQ+vY8WAEpcnHMOtwzG6lNKZ/fZdfJEBe4yQEniP8ZUB?=
 =?us-ascii?Q?s5Ihfwi1e08okefpl685eZE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d5f6bc-e52b-4ae0-0b9f-08db60578007
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 15:15:13.0337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBWaag/QexruH7V8f2ZV228xxIM6oD1AFpNervW34EYJCQ6kQEqDaHc1hF0MEoNVxprJ4zLvLgLPyIuXSAJvqWu5SLPJkq7d7Z7CG5+TT9c=
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

If the check is called during normal work, tracking of the check must be
present in VM logs to have some clues if something going wrong with user's
data.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 9fa1f93973..d64e8007d5 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -42,6 +42,7 @@
 #include "qemu/bswap.h"
 #include "qemu/bitmap.h"
 #include "qemu/memalign.h"
+#include "qemu/log-for-trace.h"
 #include "migration/blocker.h"
 #include "parallels.h"
 
@@ -436,8 +437,8 @@ static void parallels_check_unclean(BlockDriverState *bs,
         return;
     }
 
-    fprintf(stderr, "%s image was not closed correctly\n",
-            fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");
+    qemu_log("%s image was not closed correctly\n",
+             fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");
     res->corruptions++;
     if (fix & BDRV_FIX_ERRORS) {
         /* parallels_close will do the job right */
@@ -464,8 +465,8 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     for (i = 0; i < s->bat_size; i++) {
         off = bat2sect(s, i) << BDRV_SECTOR_BITS;
         if (off + s->cluster_size > size) {
-            fprintf(stderr, "%s cluster %u is outside image\n",
-                    fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
+            qemu_log("%s cluster %u is outside image\n",
+                     fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
             res->corruptions++;
             if (fix & BDRV_FIX_ERRORS) {
                 parallels_set_bat_entry(s, i, 0);
@@ -551,8 +552,8 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
 
     count = DIV_ROUND_UP(leak_size, s->cluster_size);
     res->leaks += count;
-    fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
-            fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak_size);
+    qemu_log("%s space leaked at the end of the image %" PRId64 "\n",
+             fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak_size);
 
     if (fix & BDRV_FIX_LEAKS) {
         res->leaks_fixed += count;
@@ -603,9 +604,8 @@ static int parallels_check_duplicate(BlockDriverState *bs,
         cluster_index = host_cluster_index(s, off);
         if (test_bit(cluster_index, bitmap)) {
             /* this cluster duplicates another one */
-            fprintf(stderr,
-                    "%s duplicate offset in BAT entry %u\n",
-                    *fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
+            qemu_log("%s duplicate offset in BAT entry %u\n",
+                     *fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
 
             res->corruptions++;
 
-- 
2.34.1


