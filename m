Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B93767CFA20
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:00:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSca-0005qU-Ry; Thu, 19 Oct 2023 08:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScZ-0005q6-7i; Thu, 19 Oct 2023 08:59:27 -0400
Received: from mail-db8eur05on20725.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::725]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScX-0002g2-OA; Thu, 19 Oct 2023 08:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXu8PTWkohr5phi+gYID5ornXd9sUMCo1CHFxkQd4a3L6LWiJVFnMB1PVRVFzav0Zh6qviTeMbeNlLryM8xrMCrd9Mt5NDvpZSlc676Ipd8PoUAKkexICqe/BqsM6HanWnWDgFb3F8v1zrPZ66EqbrtlfZRcSKQTCu8Rzbmtd+4rrjEFVJS7cc6rhP1mUnjMc3B0Casq46eN1ZyiZuZ1d5kjuFTR3bv6/1WmeBk4om+rm1q/sKwhoonHuzPN+FC1OQH6itAeS1EfoWSCpOpOuNv83Iu4xVM4wVBk4iTApKOMiMQZdWW8FVMC3mTwDZT7CaX4v97pFwqGbWTyoMQafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Q1znhGGtbgAyMPyI3UZCaCwbYtbnuY38EmVBd6olw4=;
 b=L4QSNnTnZf5J+/jC3ROKXyLc3bbdjwLZ0TpfoEr+op7yQzbBclp9i7F1ShzUi84GsSksjvJSwBoXIHCa4A2nVUYg37FpxAwEOz5WMnxgjcqBe6TC4koJJlHfy2PGPuk8OBXPfUK46qtOX5TY9Oo+CA+DcflhPF9E66HnatyoMcuwq102LXyjhyiIRUFgZxKobB7Xgmf0ovoG0E1rwWCLBGhKld8FPBasOaVMgNUjd7mjpKksGqpXyc0GrYcIDdc4u2gvp6I1RNzpYKT2SLy1Yq+9tpXiPRpwcJzojbj0HJbBTkJf57NmtNyPNkcXPTiScifYrzs5RJwQFqHa8y/gOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q1znhGGtbgAyMPyI3UZCaCwbYtbnuY38EmVBd6olw4=;
 b=ITJGOOS6dMDvDV5crRDq1zcAIdwTJKOehbrjoKX6HqaLN9TTts7i/eOLSOxF+7yHSGC8TlOlzSoUPpOSGIvaDMBUmPNWzvtcnvW8+G9VSDJuu1UGc6YNwQg5uMrBLZoIvAym4JE5ixtZAGjjxtrkJOjY1AunnVwe/CThxm+RfNjkIYvqucEyJZriUfxTSihRaKE4dAOV/CXGHOJEPbUfpIhNwmTQx1i/pY6pCMrkBVueuUdZojWjKTX+O/8kaoiEyQPZsW0xY8zgBgHLhbdhWg+ldIvM02g8X4CkCMrarg5CUEsP1uZ0FTSZysfSK3/rKUnQWje2aOX21qidpvdaEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:16 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:16 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 15/20] parallels: Truncate images on the last used cluster
Date: Thu, 19 Oct 2023 14:58:49 +0200
Message-Id: <20231019125854.390385-16-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|DBBPR08MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0123c1-f8e2-4292-ffb3-08dbd0a33319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MLeK8oMbGwNUdd4Oy/dvM0acHaLoEflyc0TnHKx7HJ2MT8g5rcrC+CiwV6LDrIBerJYnP760RR9GH4HYY3+Tb2D3uIhihvq6M/H9n5YByTAMEPCEeVg4P2kORxsqdJgdy8xjyUlh22rkQ+bLZ3chSJQP7kgvl3YeWpP064dYEOYIsoAk1iRITrsYv6YAK7mqVp0WSHJ44TxAkPUSEjYAMoKClsgHp2b9olJRhfbpOlRUw2R4T2Qgjlc/sZBabB0RB5sDi7LIy1UbgwaV2oS9hYdub/rpEYPEko+Fvf2xECpR63FiMiSZk0HlyIVxwa3lDmRlEbFf8fyUik8Fm16A40RFbdZ0RvY9Z0HA8C7NmHle4Ho9Mi9n+qT9OTNXAMEXpKJdDV8CGc0D9DdrDrjOfvuIc98aKw5bZJGO+PGi/HIn2WIsGoZflwI3LPIN+ZFsVqxsGfr3E24uy5uJWEtO+nuItWarE7Mb6yAQdKlakqQ4N4OlvQsnuvgJzaLiyzBy5S0M7Otp05sT+PAsNhyTHg9xupj1oVTgUSzzUoKuxnG0Az33WyRc7whB5vjzPA5r42/RYHUyo4gsOXUOqBuTM3nJPIZngw7CgBf384ZH72N994nEbsR7ZrP4T3Z8Plt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KpjTzAeKX8DL4AGtYfyYnrYcNsZZwQlcaIpcvJaAnjXA6mwYCm0yyOj6T+1n?=
 =?us-ascii?Q?5UCaBv7XkK+zz8x9VsZ9NebV6AfPpoklGC8FA5BMSS16WZlCB/vNn2x62qA2?=
 =?us-ascii?Q?e9ei0L4DcjysYErFbZAMNo2TfyvCE521in0BC8Rm3Nheu+4J7ArP5VHPonXp?=
 =?us-ascii?Q?8bskVFmjOpUDcGElsNm1UJxjU9LK6h3/vqsp2tWDliOKPKdCPtMBBVjsaW5o?=
 =?us-ascii?Q?Ixci5icsqn03TNp0JrTYE2GeuPC9q1/BYer4ORO+3uszSOGKNoO5q7h/84Qm?=
 =?us-ascii?Q?mva+uSX6z843TR8vU7NXkF9lgICyqwxqOmOf8EfYZBP/0bbNl2Lfg9RNBmQx?=
 =?us-ascii?Q?PK5uuEjCWLgK0JLuigklfTkP1uqMhf9ehF8DGQRP3hrlBxUtpOtnOPZu70X/?=
 =?us-ascii?Q?x7REsRoR/CE2sSkJfmY3nAM0AAqppwdrEhXBv+h4paaiVmo+a4fig8oTaTvK?=
 =?us-ascii?Q?en0L2Q3NjLsTdAoTjTCuMhbxBkmAuDtMgko4FaP+MjnEx151hhzA5CtHlbHS?=
 =?us-ascii?Q?4hmVPnI+nZZrmprQrqeBBqGSR3HOY2lABzV1eS89Gvnc3gpvYOBIMk/UWfgX?=
 =?us-ascii?Q?OgU9z2+7espqJTfi7TzDiNuQUlU/GsdN0G0fxGcG+P/C1I0aaaF/sezvds17?=
 =?us-ascii?Q?nf3P3bJJ9FRmlKvgIIk9qjt6/tM3OE3QZSKCPQd/ncMcn4l8p0yr8FxenAFG?=
 =?us-ascii?Q?CBY0z6zUka2NMFTML2ktnoLyaEa95HFItPMlIu23N0ag9vgnsfmC3qgnRRjJ?=
 =?us-ascii?Q?mH2EC1N2ofBx7ypLHed2nMHwjM8wOuqoelFmIX150YHlPH1ZPhHSGoZG0wWY?=
 =?us-ascii?Q?Bf5PyBSCoLqV7isK/xP1ePpzTNoihntYXa1wElYj/fIyDSrpCBlt/lqiAyzC?=
 =?us-ascii?Q?lH0P8mnQE4jdZJuM5BgDT9g/XTZlPtXGeQ34TtQMxbIKbM4qx6vcwxYcWmIv?=
 =?us-ascii?Q?qvQ9B4nKsjMxuoUNz2ZfymPH6sh5Kz3d/vJFGjRjx2U1SNi/sv2L0Km5cSKi?=
 =?us-ascii?Q?vcy3OEwU2aAyBA72sVtNrPvNiRqeCeTqGogMuHiis+OYyJ6/wSP3PXJpOJzP?=
 =?us-ascii?Q?f92D5rQnhW5DhgyXmReirmZ5VvXmKD9RxG4ZmkLezd5w12AVaFmh1rLeNtPe?=
 =?us-ascii?Q?alWN4XmGL1cVS6KdLXCbqHmRgT7c2FCXbL2/206raZW46LG+rvCszp3/bOkz?=
 =?us-ascii?Q?Vm2bYUhBGaDjeJeWidC4b+0r9iiu1OBp+Ug8jJ5UGrrEcr5A+Tu4uDXgXZhv?=
 =?us-ascii?Q?JCDoDpwJ66UepAX+BPvmUCgbASsR9wZmbyjr6u0EI5kB3UTHCn+kpztsM/r/?=
 =?us-ascii?Q?aQ+A0Gg1hRJhbyEDrr1mEEAuDGSzb/u5WE5EmyrbyFlLcjgwdBwnDwklRC+m?=
 =?us-ascii?Q?aQ3TBKc0RmOL/bS5Q2vRa/rwJxqKNfvbgqjz+qvjmlh6uozPbC1OeXJu1ELc?=
 =?us-ascii?Q?TN3m9TqIthlQqdDW8cc9MaR9t8JV5PahLF87WiaH9gRGtnfo5b3o2szW9UDw?=
 =?us-ascii?Q?8Y1nrNDiHd/ecI2h1NT7Hevq9tSjrduPfKg+SmIi+u0uBbcGjQyoeB6TGrGs?=
 =?us-ascii?Q?t5GSd8dxQt6AAlEmN8mbcUvxeHO33B+SlqA5dJrq7LUDyLLcvdc8sA8pSimk?=
 =?us-ascii?Q?PHIAKgkvQygd8G0EoRxi4x4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0123c1-f8e2-4292-ffb3-08dbd0a33319
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:16.0384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQoIoIZmlIO8HEUjr1yzrunGi0XzV/GII5QEAXhEDWo3BPRrlhW5R3+15Nt3q3zsja4d9WEzNldcPLo2KW0wrkqhlgOv/cB/bZvZ0jvgG/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:7e1a::725;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On an image closing there can be unused clusters in the end of the image.
Truncate these clusters and update data_end field.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 2d54459087..c7db2a9562 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1458,6 +1458,23 @@ fail:
     return ret;
 }
 
+static int parallels_truncate_unused_clusters(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint64_t end_off = 0;
+    if (s->used_bmap_size > 0) {
+        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
+        if (end_off == s->used_bmap_size) {
+            end_off = 0;
+        } else {
+            end_off = (end_off + 1) * s->cluster_size;
+        }
+    }
+    end_off += s->data_start * BDRV_SECTOR_SIZE;
+    s->data_end = end_off / BDRV_SECTOR_SIZE;
+    return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
+}
+
 static int parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
@@ -1475,8 +1492,7 @@ static int parallels_inactivate(BlockDriverState *bs)
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
-                        true, PREALLOC_MODE_OFF, 0, NULL);
+    ret = parallels_truncate_unused_clusters(bs);
     if (ret < 0) {
         error_report("Failed to truncate image: %s", strerror(-ret));
     }
-- 
2.34.1


