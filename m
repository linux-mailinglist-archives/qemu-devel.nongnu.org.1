Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE681F669
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuN-0008Kc-Tq; Thu, 28 Dec 2023 04:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuE-0008EM-D8; Thu, 28 Dec 2023 04:42:23 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuC-0008HI-SL; Thu, 28 Dec 2023 04:42:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQdSDIroAWW7i85ARHJHgm67k8l64/CS2fIZ/47E5Oygj5/nOPvhKkwca/KCdpeB9iTCqK0CO/c3inEqgTf+KYdnVEx4VDUByHuT2sczzI8uHyGyoandN/SYJmDEyZd5LbxY3azkSCaHSYk8l2UDcL4UTk3kn2uq/4Rll24wsbhql1GOJFJIJ35W3NnwTNVt0Cw3gk04U8fkY9DXR3OOt+ElIR5AR+6U8rc5bh15npA3ySXM8lwd4zXqeQSHOtGkl27FIRz89pdPsfF4UjsyaCgtDodLijnRC/eaj+H15uM5sMWFn3aDkcpBpAkbLazefAeeYU5WaeDkIU/SWVQDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZh0tPQajn5ZVC76nM9sowYGAr0ImIhqFCdVs8qjAjI=;
 b=MkY3cjkDt/krKaEFuIy4i/acEiV89q20DRvhuZk7LnGUQwtOilOuuwOjQ0wn8fOjVzdQJdN2tlxQiQo3iUrHaAR655cvjg1+ftpYj4vj1IqZmbp9GIC3Ou3DACwaqCK6FwqJXyprZg1QfMRaYos2z8eEmuCp6KwRj8De2UEF4nbd+HH7WDOm1EKq90Vil/FHegRrB9bFY7BjXSDPq/HXq56shAN8+MNdf5UiPiHItRe7SvjQmcGD0thQb4lVLOCt+pH7dnds3MKCeB/f31+X6pUTkJOOqppgtTIPJH+lNDbJWTJ962j5RciXetKcEY8GTv9wf2RKGvCKpw1CVGI4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZh0tPQajn5ZVC76nM9sowYGAr0ImIhqFCdVs8qjAjI=;
 b=DX2m3OtuUX4hNeSznkvqGQquEiWfKWzEqprWHEQUVpz9DR3Op32zkgFeCqqKRkksjv+ZL/zvU8u2ICmcEsK6HeXpmZj5vnxqxg6bu4ZZ1D2Wde6K9LgZvFXAzlpUc7QG987/6hCXXmkse+5tGE8WBJ6hrdIO9DNgPFkWvzLP6w2FQHGVlL2QU2PVTHl14FfDfz3xkjBogkYtjXaDoMw3pc6adtjgK802C05fqrBgWiBTFeVVK0ojC+CS4v/Znmvd9KbS02ADqxtJUKkYyOpw6V2rBN78jpI2zH1S5WcustUCSk+lHQmAFogMPKn97qXVM3enofB0qOcXkdk97bDHsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:06 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:05 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 16/21] parallels: Truncate images on the last used cluster
Date: Thu, 28 Dec 2023 10:41:48 +0100
Message-Id: <20231228094153.370291-16-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
References: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: b06bdc05-2f40-4b8e-8141-08dc07894085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x43434HhDgFPuJqDhUy9RRYFnEbvHnaMFBogFXMvJW67wwtKGHy1hW38ti0ji4jcOSYXHda/dCPutRF8Kz7gR/iNQNZJSBIZV3dm1mK8V0DP67t7BMiQttSKXcH8+DmxRkMLC8wbeMlDcxA+MJrvE2G2wJxtYlJjJaB/lywZuPqK85ioTkASrCahcP68UeRmVEcBbqShG9/cZrgUtdKVSl0VAIFJu4Z9yqp5SlxSqyK58e3eMFArVjXtex0hie3IJ16zo6syHrY7to7YpUijMoCFtWgsHayP0Fh7RZwChYxFVQFAZcOAAzUUgvkn4wAg1sJAX88yLq+tfls2dIspNC2p5uTsXe/N3eZEIWafBezzbQ0mYEsEKUVjnqAJwRxxZ2y+42f/6DfDIJSU9pv+GiyUHaKISiUNVZrLXjZFhGja35fs0n+HugaOc7l2XRWrLn0p3DDz8HyjYy5Gie/JOkRzyFkBmBU3AEtNQPq8uQnCPeWRZmA7unydZEOIVLXYjqhkhyaDt74CM4k9yzXHXrzIpTmNT7ENNPWekd8zgG2pwCQvcgjsWpYm5wxYbBpMXTwyNsw2Aaaw0XZ5r5e3FHvfCvteATaCsfSwRlMqpbMYXruS0nM7AAVuNkdGfpPS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v2+1UI3oEGzLKNLiGC4uIL74SOCTXlFXvPfBobErSzl+pd9Q+QRViIrzB9se?=
 =?us-ascii?Q?z4zagDWFdaWbmjfmk9IuqM4dcYu/qlFVhuq7pcFiopwWrN+BKukV9SZpWR45?=
 =?us-ascii?Q?pp+eai6lwK55K6txYdzVXUIfecCnTG8zbHRoHpuyYWq09+gkceGo0ipPtcXD?=
 =?us-ascii?Q?hPIG7Gq6JhTfRu5Y+KHXichlAEsQAMz4NeKPvWM56wJYIJx1R+8SGfhtvuOG?=
 =?us-ascii?Q?AjB7QPL7aBQ/ywuhh7gkYledgaB7tLO11S6WS6iXO8TDRyO6UmPDoUHqsBRb?=
 =?us-ascii?Q?AjBRgjnEoKtjmg7T086z4j3gNoelBstEVG0NV+YzlCrVkxryVsp9xB+ZCWZy?=
 =?us-ascii?Q?l1J1NguEjGQCWWMX/iYNEeR8KemseSk7JeOSdaSifDB64SfV87Xn5al9R7b+?=
 =?us-ascii?Q?6ZFynbnKU/10UgjK1UVHnZVcfGRNAPtLlLBuCh5hqycvUWAKOtGQ1t30Utqo?=
 =?us-ascii?Q?p/Aep9hz/v3Bf3kMqp3UeS2w3+ajfuTRkTKRRK59wuZOa4GHWKJFh+s6o34I?=
 =?us-ascii?Q?uF3ZaOuIt2j9WAUEEPUQL9vWRvciefFvyjrU9hAl6dmHSZ+0/NKNssPFztP/?=
 =?us-ascii?Q?lVJG/Rx1nk2W01M2TAqz3VOMd2bTsX0jjdjGhME7D8UFv/MDcP/6C5SQ55Fd?=
 =?us-ascii?Q?UYJSZPBEuO5JuJgD5apS0yZbuvdvAKddIVB0Km0yCyGyesREKYmHUA6w2jV0?=
 =?us-ascii?Q?qWsuVd+eqQ/ye5oi71iT9Ag4yLHOkuNhTlo9KBsDCqAgy5yY09ZvZ9SWjYgx?=
 =?us-ascii?Q?88X9kxJBBmByx54+VZormogCF3MyJr2ICsZNEwePD17pQR8oTbCupCCMgdz1?=
 =?us-ascii?Q?bNoHYnPltIizlhib2fzwW9e7XIL8+IXll6zDRSelgCh4KaaAcZ7nDsRD0vqR?=
 =?us-ascii?Q?mpKC8XYOFhZz5pXNpGV2ywBpbK4dFhAG3/v3RNC3G/YGsoLIhfYnUeCVW+x4?=
 =?us-ascii?Q?puRDq+nHzUqcaCVLIuNKr7v5EqeifwkDECvd391baVSfwsn/3FH7VJDySt8g?=
 =?us-ascii?Q?mJTDjdl1ez91qpfyYWKwV1uYem20fS/j7sEC+uo7GL3LfuY7HRHrZuluAdkb?=
 =?us-ascii?Q?3I34YZ6JRU7Ow6GtmPGn3cntoYGBb5h7yF0fpAnsgy6tExevtN2ETVhcsu+b?=
 =?us-ascii?Q?iIa7se2RfzeeUmwzXpQTB3oyipvUutLe9qOsHpwUfVk3pHZWgfb51bcFCmWM?=
 =?us-ascii?Q?hnA9rJp5t/SID32ic7i6zdxBnRidGivT5A2D8Ppi14sg/G76kZ0iZ3kh7Yir?=
 =?us-ascii?Q?dSUjO6i/UnbPvf5RtJY8HcENgoh4Eo4joaIAQkWzBMPKDWTJmwrsf/8lPCn9?=
 =?us-ascii?Q?u/yXTrfTq7JBxK4Cy56k4NFjVL6500Z3yPq++wcCTgpIHoM8V/57TL3OBr5d?=
 =?us-ascii?Q?MVSgU3xvqdfY1sN0bK2P6Ax8kLCBX7jSGFLQWejg4+Kyb+MkImq+l1mJaOD1?=
 =?us-ascii?Q?Sbpr2BNEq/xOu8pBYrxqw/hotkveT9zhX2hhS1/mkKEmbz7vjXl2IJ5TtU8a?=
 =?us-ascii?Q?3JHl5SpzoW9QrHyxG1+z8pxHDd3GavADCBXuAaKK0z4B9TpRl7Sd+TlezumX?=
 =?us-ascii?Q?b5bvJi5ajhgB1N9v3cIswh++W6P4XK+wEhiWSgDtaR1v0TuGN7rjA2uw0eyh?=
 =?us-ascii?Q?evtnZUPQjZC0Y/JbfUDcWEk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06bdc05-2f40-4b8e-8141-08dc07894085
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:05.5178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzXiANlSjw8yJHValutr/osJSsXpBre2VhXUe8PSTPnB8qQ+BIXg+kcNzv0E3sM+Lwi6RGJfgRI4lPp3aZI+P4LWHYikC0ZS/9f4c8h4V20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

On an image closing there can be unused clusters in the end of the image.
Truncate these clusters and update data_end field.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index fb7bc5e555..136865d53e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1454,6 +1454,23 @@ fail:
     return ret;
 }
 
+static int GRAPH_RDLOCK parallels_truncate_unused_clusters(BlockDriverState *bs)
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
 static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
@@ -1471,8 +1488,7 @@ static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
-                        true, PREALLOC_MODE_OFF, 0, NULL);
+    ret = parallels_truncate_unused_clusters(bs);
     if (ret < 0) {
         error_report("Failed to truncate image: %s", strerror(-ret));
     }
-- 
2.40.1


