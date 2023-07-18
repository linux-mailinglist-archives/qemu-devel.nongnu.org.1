Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C79C4757980
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:46:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiCO-00023S-Aa; Tue, 18 Jul 2023 06:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCM-00022j-GS; Tue, 18 Jul 2023 06:44:54 -0400
Received: from mail-db3eur04on0704.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::704]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCK-0001yi-VW; Tue, 18 Jul 2023 06:44:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjD3GUCRZyvgkRaLfCRNIBm1cp7KqQsX25DwBrO6IukRentG6gBFWWR/w//1ORphml0mNDut3mrdKew9r+qzCQ2SHrllrASaYHLpYhV19ry/UjpaapJtPsmWDoMJFqt5ZM6myaI3n/Pw4+MKJICE+RlyiXgn3/jdpfmXvgG0xyog2BJzBXmsSUFvPu6S50oMFSqQKp8W4uKLrDZIlmqEVQD5Pm5p15iS/rVycFO4yvOkjjIr8mr0osVMUhwqDSPvjof8MNw2vL4DcrD3UuF/9H2qAN3QLzx6fXS2PYa2FV5YaHlTDlFQy3lUSac7dVlWOTg2XsX+IXdm4kdqJ3p/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK0ARQSPIAnqN6nVWlZhSv85vZIbJ7/VvJTcEBVsdGc=;
 b=h6/S46CkMt3GQ7wpBXz3zwTcR2GhOdD5XWX+QIIteEm+r8X84vgvnoOow50QCP2TEjO0sGJvnIg3KVpGY+R/PxIt1fS4HPzvlryOHLoPSVXZy5qDqQZUtL7rurC9hls2+8xBd5dwkUPYBJvWX8tzdkp7sMQwEfFw//KIEN6I3c6mugYm1E5jrXClJPvcNEptiHQZntZesiMGbk3kRQFrdIIi1jXV6Ex+Z75ixQuGjCtbEzcD/fe99ja7z2mpjyJe3W7v/Ej+GIbMGkJkk0UwGeB9q0z64hqbD/cr4/FchBDi0blIy5RY6QD/GaXmt9zIjbMUuN3KXz0pRCz2RRlnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK0ARQSPIAnqN6nVWlZhSv85vZIbJ7/VvJTcEBVsdGc=;
 b=f3UCveLOPrGXHS1KS+jyr4GXdOgVIz0FRPW943PAumNj0Y3lBwSkwpzfqT6XBWRuSZ/XP9OdJW4bbxL5R0jnBrFZbOgRdSjHBrTlh+MYUNFrGctH/lkKsC18HmYYri2UG2nJjme924kK92NpvHXeRb+rE4BSvKU2rHIR/JNTFDRNFHfZXcEcqylVmsaXe2gqQvZXqG0aU8k8tAUzxmWYoKqfKFOpzBl2gGjtA5JYmtmA42QMUCJmnnQPtElWNOt3s/BeSM/sCw4Sq4wJ+tyG8XXV6PDOhb2tea780eeYC2rFNZLqLaiOFN5vRUE7f+Me5v3vDhNd65xAf+UcHxKJyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by GVXPR08MB7894.eurprd08.prod.outlook.com (2603:10a6:150::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Tue, 18 Jul 2023 10:44:44 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:44:44 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v8 09/10] parallels: Add data_off check
Date: Tue, 18 Jul 2023 12:44:31 +0200
Message-Id: <20230718104432.1130469-10-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
References: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:803:14::14) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|GVXPR08MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4443c8-cee1-418c-f7b0-08db877bff92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBPCU3aT442MEH2p+ob5Phha6Jrl1zB/8OfpxvsnkJRUsyXYUrYTpwbfxf5UfuDtFadIcyp3DHO4+TO+69vvlJzi7PSZkMg9XeHREexjfjFsE5VxbSXOKI1AT2UFKfUeZGEUjrKOAw5yEdeYeCTbOZOSbk+n1YD+wKWcHgMKcZv3grizRlIOt8x5xj0a9ycpW91MmbE4t/Xw+huZ2idrwsUWJjWxb4BazTOe5BpAeqJvJq+l0DcHVWzPUCljeIuzusKvuAqjGcKwa4poSyz953hhtROQgXBlTI3wqObw2sPR4MtYQuTsa9xwwVKqt6UY2uOAlm5qjZ6KsC2fu6mbJndL4rwaKVeTgyXJGnjPXrMA1l0FJyK1Siz+qXFWYIM78YxzT1eIUA4kR9wuR7zmy7Pj2A2tFNwqez+RLmmkaa1Mu7KhWTnfJaPnkdAVHditN/f/bKtTk+x/0vphcTxxHIKTbSlFdwRkCEwpB8clbJkTnieIoHJ2vM/70GJs3l4HdvpepoCv3aTLWJtBCgbqssK61QbwytMaoxXRekY72ADja7guknapUhQtQIaEER8q97yJEIb1QEsIv/wCrOji++HeqJdVcUT01e5v9EsQ8q9J3JjyZhlgi2GbUZCh5J+c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(39850400004)(346002)(396003)(451199021)(86362001)(2906002)(36756003)(44832011)(6512007)(2616005)(186003)(83380400001)(26005)(6506007)(1076003)(38100700002)(6486002)(52116002)(6666004)(38350700002)(66556008)(5660300002)(6916009)(478600001)(316002)(66476007)(66946007)(4326008)(41300700001)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IIkiwBgEBksI+YQwcp94pkrH4DyN3lEsPhVmv6KB4MrJuD7l0itofXGClSaW?=
 =?us-ascii?Q?zFe7z9HPNK8mih8LAPrZ60Ezo3pJaph27f3dYQgr/HiNYHfWN2t6OWsOhOU7?=
 =?us-ascii?Q?uk1BsZk9dYa3ajjPbeAT918dteQq8VQaxqhiaR9O5BTV4yWa16HZn2xL9I9X?=
 =?us-ascii?Q?6c1SZmRkxJmSetASZZhOsY9NaSohnKlN1/0QogwSDmIjYoWEni5Dc5arFgs/?=
 =?us-ascii?Q?RdvOU5kCormhAK+kORrdrdfwyYpiaixP/KLtee/a5r+zzK/gnOYhpX9mRswV?=
 =?us-ascii?Q?KhQQLJete85A1v703D/yLyH71YZgoKOdsfgzMVA1xT3h1C5Am/km9+4tqqjw?=
 =?us-ascii?Q?Yex24WCw7NrVmB/zZckuEOja7b8ga3WysUdlg/3rLlr4+cIWGeaW4Szs6EGR?=
 =?us-ascii?Q?7D7rEsjrfjrrUrby/XnL4S8I3epzEBVTkzET1n1N5azOtWSESZaT4/TJHYsL?=
 =?us-ascii?Q?Qvtdxx+GI6gsq+XVhQhNlrFStXNh3T5XfHEHp7knaLu42Pw5wCZEQtZp+3A+?=
 =?us-ascii?Q?bzQl6c/Kv6uSvfimoD3NGFbs8DzaZ+9pGvOOqIhg2DdI0jbPsC2NracW5jMi?=
 =?us-ascii?Q?QFQQmumoa2hsAnlFFvnVNE7bC6hCalfoBhYBR4W1XJox+FcCrNDBVkotXCDs?=
 =?us-ascii?Q?3MdiHR4U4DnzgF2CBc6w4DcPjVypOifSuzzdkUXSkqtuB6HNCjVVt9GZOV/0?=
 =?us-ascii?Q?v5KjjS17ER85S/eaERAj8UMSXko816POLhhCqlWCwK9tjx9SUToQbOCRNA/j?=
 =?us-ascii?Q?ZI6AXFqW0F/0mEanb068t7IUYOekq1EDcxbyCBUhgsANKdUWZHXSNemTr6wn?=
 =?us-ascii?Q?NueuHcPTGIH555K/GSVMRaK8h+rDFhg9K4md5yuIWnRUTTPkjwuN3n95rn3h?=
 =?us-ascii?Q?zat/P41zzNkHJkf6U67FRSfUaRHf9qw/GrNduvH83uL6frtOJFLDqNiXY7Wi?=
 =?us-ascii?Q?XDGr9Hr4/rT2BSJ8mOuyaELAI2IvHmviicrjO4AGfypWOzKDq1+rt8LR4H5e?=
 =?us-ascii?Q?Xi3at3eCrBRY7LN0istn7cNH8QxOoAz+u19dKDQGcYxw04TaGXHIaBH8GbRE?=
 =?us-ascii?Q?ofHxJBHw86hRpbd2AyuS1d4ii30AH5CRjChS9chBizHYLQUqJa5AkOEZ0o34?=
 =?us-ascii?Q?ynrxwF9niyHE0cvjhJIQnRAi9YYzKGaGa0LY03A75OZVMacuzESoGYd4x3v8?=
 =?us-ascii?Q?3Xiec9OynltJIKtjMzo3u+x/2il8hAVU8YgqwhPyPcMBDlGGAFtdKds1OwgR?=
 =?us-ascii?Q?cl2CKtcmNVRLARe7BqmIYEEaePv4pf/qY1YRpzgwHeuNKcZRXRMecP9z4AR0?=
 =?us-ascii?Q?bpR+v6f3UbJgW1pt18Gx1SrjjUQFfyfCNqm+1icpE5QQWfFjKKC98h0LcelO?=
 =?us-ascii?Q?WRzuRcMKooIywOf/DeNaXpE83lTgnD2GPdh2Il1unNE/v1+WBkGVZnG9kHrV?=
 =?us-ascii?Q?y5vOxIMOqYa/Nra+qMS5C+LaKSOXLuQ/XlZ8h5kgRNbkcqTTAsfFg0LnFI32?=
 =?us-ascii?Q?yRZyZ8e25fZFcHQBF5EGn/UlvuAXaW1JP+DWkbvd6SSD7RlI2waW0d4FpInN?=
 =?us-ascii?Q?NIEhvP+JeuUDk8upX3vAd8DMNQHS3X3EZM2weCkF+GqyhoSO0BH1WdA5c6Ig?=
 =?us-ascii?Q?mM2xSnq3T5BwY6SAt6xSkmk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4443c8-cee1-418c-f7b0-08db877bff92
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:44:44.2528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqcflEiPGb7qRu5oiydUlyy7ZzI5U3/1CJDzv/RqU8Tq+LyzgBKO/GDYeueOQ427l9dkCyzHIu72skseBLZMilee0rr7hpbbvNRFnJKgRjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7894
Received-SPF: pass client-ip=2a01:111:f400:fe0c::704;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

data_off field of the parallels image header can be corrupted. Check if
this field greater than the header + BAT size and less than file size.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 3414807089..103acb7b40 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -450,6 +450,81 @@ static void parallels_check_unclean(BlockDriverState *bs,
     }
 }
 
+/*
+ * Returns true if data_off is correct, otherwise false. In both cases
+ * correct_offset is set to the proper value.
+ */
+static bool parallels_test_data_off(BDRVParallelsState *s,
+                                    int64_t file_nb_sectors,
+                                    uint32_t *correct_offset)
+{
+    uint32_t data_off, min_off;
+    bool old_magic;
+
+    /*
+     * There are two slightly different image formats: with "WithoutFreeSpace"
+     * or "WithouFreSpacExt" magic words. Call the first one as "old magic".
+     * In such images data_off field can be zero. In this case the offset is
+     * calculated as the end of BAT table plus some padding to ensure sector
+     * size alignment.
+     */
+    old_magic = !memcmp(s->header->magic, HEADER_MAGIC, 16);
+
+    min_off = DIV_ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
+    if (!old_magic) {
+        min_off = ROUND_UP(min_off, s->cluster_size / BDRV_SECTOR_SIZE);
+    }
+
+    if (correct_offset) {
+        *correct_offset = min_off;
+    }
+
+    data_off = le32_to_cpu(s->header->data_off);
+    if (data_off == 0 && old_magic) {
+        return true;
+    }
+
+    if (data_off < min_off || data_off > file_nb_sectors) {
+        return false;
+    }
+
+    if (correct_offset) {
+        *correct_offset = data_off;
+    }
+
+    return true;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+parallels_check_data_off(BlockDriverState *bs, BdrvCheckResult *res,
+                         BdrvCheckMode fix)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t file_size;
+    uint32_t data_off;
+
+    file_size = bdrv_co_nb_sectors(bs->file->bs);
+    if (file_size < 0) {
+        res->check_errors++;
+        return file_size;
+    }
+
+    if (parallels_test_data_off(s, file_size, &data_off)) {
+        return 0;
+    }
+
+    res->corruptions++;
+    if (fix & BDRV_FIX_ERRORS) {
+        s->header->data_off = cpu_to_le32(data_off);
+        res->corruptions_fixed++;
+    }
+
+    fprintf(stderr, "%s data_off field has incorrect value\n",
+            fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");
+
+    return 0;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
                               BdrvCheckMode fix)
@@ -713,6 +788,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
     WITH_QEMU_LOCK_GUARD(&s->lock) {
         parallels_check_unclean(bs, res, fix);
 
+        ret = parallels_check_data_off(bs, res, fix);
+        if (ret < 0) {
+            return ret;
+        }
+
         ret = parallels_check_outside_image(bs, res, fix);
         if (ret < 0) {
             return ret;
-- 
2.34.1


