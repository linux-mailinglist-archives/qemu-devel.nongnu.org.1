Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6252757984
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiCR-00025a-7M; Tue, 18 Jul 2023 06:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCO-00023q-7j; Tue, 18 Jul 2023 06:44:56 -0400
Received: from mail-db3eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::703]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCM-0001xm-Nb; Tue, 18 Jul 2023 06:44:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXylxg4hqUg1H921QdMVxaf4GsirNeWI7TKRrobNn7tkqAue1BsG1k2rJ1tWs+AvO6zswMUVXbUBWXeoTaDp1Moe6lYfVwCGYeNTskJdExsBucr2DcnRQ2I25fViD8uTz6d5Ow6FK0dl11M9vSLl6aUryJLDbnY41m5nx7PJS0ICeppF50XN45xz3f0GYAbj08ULdWFQQ16ZlvYbG9FakHIlL44+0QbPuS/stxF5GmOMf+XjfrdQxLFsEoaYrPLoibGfAHunsrbGG7Myd7JAKUi+Z2rZoM851pZqPICYnJguF9Nol3dHKzYPmEjv7AhRseGo96xMen6LL6Hz4dnqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4bt11CVpXe4XbaBgahYT86Tad2GhoirQubK102zvgY=;
 b=DTlV4HRC8JrPPzJyoKrukdDVPfzId3oFRMly+Cprx6LpuC+LT5ZTstQQKT1spFlzybKc1T+fMeJ+02rMiG15kGkO8185b/i9tS9TIP2kMCZwErUADsM/leEkSYvF78BBl6KR2aP2183g5FN4eZMW0cCjDNK8FpjH8MsrqZ/JqTtyBxrsW5+R2eJX802yDZjubLzFkJAq2ZxIVtGc6LzSjv5ACbRaPQVbabN5ZzgiK/DQdDFZOljUORVKwEvubGxDX1R0BZjntDbbl7PKmzK5bLp8wmcbdpXkXi2H0HdBr55H6kLu0xg+7AWHQBZgtf+eHLU30/nSmorI9SU//sJdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4bt11CVpXe4XbaBgahYT86Tad2GhoirQubK102zvgY=;
 b=fxv2PP96YS3nblL9HZ2omcdal7e/a1hSCotFSRdPdP8KDL1NPp9LzZsrmX6lhY/76dCNj8VoLHfiLMSL9xW0OpicrYTTS/kaIBixB3uJlSkbXdmO+qQ6awAc1SLzB+kccFwOjrVKGKn96NIW80aMXbC4sSMqy9+YUCiTnjDn0K67XFwjt30r5A/vCtEHKu/xxVw4rQXqV98nPeebiJlSpo070CPtkPdfkWdmq6ZHuWO390Zl5aTByV6Yye9Ur5dsCoG7gGd2IterHdI1xDbV3QMC9wE1lj1i6xaT4H11WvIIsNt1k4Bs9+bl5C1bsRUKZ+5rrskGmst3t+Wa4LuEtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAWPR08MB9784.eurprd08.prod.outlook.com (2603:10a6:102:2ea::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 10:44:41 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:44:41 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v8 04/10] parallels: Add "explicit" argument to
 parallels_check_leak()
Date: Tue, 18 Jul 2023 12:44:26 +0200
Message-Id: <20230718104432.1130469-5-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAWPR08MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: f791a539-8182-4043-31cd-08db877bfdf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZF8bC4lkm49G+BeXR1406ksQrhuT1PfKnZvm5ehvLu5sypxTYxPFaf8Zzgkr35KpSZhKS4fkVAmRwZBT6gDNDCNx1FwDA8fJiVlWOT1YrXTiahLjVoLxuYf+/JFmKBGCg6rNf8R3vnlXuG8IVvinjC7+NBS5Ve5lX7WDpV8kEAAk81LjWo1B2CWxxSiP7UZ1j0lJKL599Sn0JYO91mJswETGKZZkNyaICvxfcwTf0/PQVFezO+V8QLJ40DH3wu5MUZ4cZ7hDpLIWBWStHQPd+ELasV9gaYxg7nFAOcoBpgE83s53DT3uJr6zOXcGSP1CHsMf0a5YWBHpQ8te+E9gKBr6St54XK3qK08QpnCELhWsM9uA+9qAXbEaDAFCTsbZnD4N4JnHgq8rch0yFtIV/rVomQQYQgpl6VVQpuuLY/okh1GGCx1wrOJd6Z2GJ/+3IuYDMQuLxe9nSxusE/0oB9pkO83cdYzuSKAq+UciroWVo/ipGs76UOPtMmfE2DOmdwW9ztTm+6fu1U4OkyznY+It4aXAqPTGLhSTsk4aY0nKKOLHuJiCNoXJa2hWkE4Av4U+z9jC8AJIWVreAmcp7LDOgNPqNoL8mDHcMiLl5cioBGNYvquE1BrNk4qdSr5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199021)(478600001)(52116002)(6486002)(6666004)(1076003)(83380400001)(2616005)(36756003)(86362001)(2906002)(44832011)(186003)(26005)(6506007)(6512007)(38350700002)(38100700002)(66476007)(4326008)(66946007)(316002)(66556008)(6916009)(41300700001)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?254UAQ7MKydKFicVaqyhBGEZpcEKGX1kZ7JSGsHpRYzqGzrd+qsvKNkMYVci?=
 =?us-ascii?Q?JlsbisGAjUexe4mfMx59pwmO5wyJXsBgHiVD9XNAACgcV7SZAd50dZVDGJ+d?=
 =?us-ascii?Q?H5Q9UV0LNif4G9ezALAnVMpJCbaDSIdvOwr+SHeW4GCfnJC+VE9zVG01cfPh?=
 =?us-ascii?Q?yjXFGvtn5e2iYH3PLZ2KHd2BVdgfBEFfsmI/74QDhZj4KaZFxseICFEtEpe8?=
 =?us-ascii?Q?60XFu2oUqH5QQm4IA0QF/MaiaGr06mxwVo+y58k8u9aGYOo11P5Lnv2MzRvX?=
 =?us-ascii?Q?ATYIpJcqW4JvVZU9dxrxvALQMlyrsdQmNIhoRJB6AkauXSqSYpEXuBYP2ZAP?=
 =?us-ascii?Q?5fOtLHvLrd9iemSKPDt3gN+lukXPY/mnpU2XE1n73aJnyhG6ZcPU0wMWPdNy?=
 =?us-ascii?Q?6Ymcc9rM+wr93WSimL01Pfnr3lyiYMyl33T4D0yBrYoo7DbwTcQgCDUiQcOI?=
 =?us-ascii?Q?k3Bh3Pay5W5hIkl48DltnlC769VpQQWaJNwi+BFGo6hH/uTvd221etgLxqGp?=
 =?us-ascii?Q?dh7qGeHauq5x6UUOAzZFJvZC5hzlOm9PUwXzJ70OA7KOE8a5V83Ssi8tEZO2?=
 =?us-ascii?Q?n80r1wyuVAqVRLHt+JHMUMXF/HYhfHhI+lKDGYK28tEvZY85qdF8V0Y601cC?=
 =?us-ascii?Q?y1gh87dfTbGGjyNI8RoTdFmTDnAgZwuwibB22XZTexl58wzbhfspXuO67Kkx?=
 =?us-ascii?Q?/RJfjcEs88CG1dE3JGuUPBaZ6nrzRi8IV2rkHwB5Y/qesUqQ50wmUM8kLnhL?=
 =?us-ascii?Q?wcCTL/fdZ4DAdlb88x7yGWPSmfJMLM/ROu4T3ZMR4UVCy099quGDq0cXVYAh?=
 =?us-ascii?Q?OqiQa75uDUR9mkmFJm2N1pO/vX4GDUAP6+n4F9S/aMo+Jq4g8P/DnbExOvuu?=
 =?us-ascii?Q?AZoar+OK+0m1YOc1n49nWG9KhCX9OJSmB+wmauCr1xWGfNKWMpqRCaYd4JI5?=
 =?us-ascii?Q?zNcyoJ1l6vRZIy2d2Ce8eTgreSuXxIYLisdb40HjjAvCfEGgjQYb9xTBPD2Q?=
 =?us-ascii?Q?tYcbNroNikBP622uaz4sGihwjKd/UtkSTSUsoYYJ8kCidttTPpFW3hCB38+6?=
 =?us-ascii?Q?aTuo6BFmevibYrjtCAhPlnowq7JVOnC+NH8P3fdE1RvvbcrVu03eMAbMjc7y?=
 =?us-ascii?Q?dt1TnipopTmgClbhF+YBdxsEkzOLIkCi/qphbgFvVvSVwqJalkD4cbexlWrJ?=
 =?us-ascii?Q?0I4wDs2J/nYMVFWgiR4ciHNc4mGoaDX+JRwOfVexn/ozhKgKfWvTpv3lj3Y5?=
 =?us-ascii?Q?029pXZlUUn3TWiFKu6J49oEcLNxwgXuNRR97LXOQLKBM3GFPLh/O8S3EnWBj?=
 =?us-ascii?Q?5+cy755GwzBgeTxLqXMzFrUlhvFT+1IAibFkyJs/OiFQbEdH41zs5PcIoHbX?=
 =?us-ascii?Q?JXBRqEl6YzdCkVc+HDW0iVHfqsbiaKA/u1wbkYreY2D5cCmo6G2X6sqSW/fz?=
 =?us-ascii?Q?JVgMhdauHFYROqdxUU6ek2H+W/I00Wh6JSPt80NuejM1l5fOvdw/bhHVoWSX?=
 =?us-ascii?Q?+mlB0uM4GiYeXwEPP8Q/IjE/odcC64Sulx+uSNbedHut/Y0IpFUwkzah3SLJ?=
 =?us-ascii?Q?pld8+HghpJue3aK8UAfpcQsY/bJGbk2HQ5vbEkHhUlRLwyENRN/5MNAqGZfL?=
 =?us-ascii?Q?HRF/MaIzbc2WsNATl1pSKAg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f791a539-8182-4043-31cd-08db877bfdf4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:44:41.5488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nqs22CtFy7QWDlXCBlk0KJx6LIouPUS/elphFXuqujma/8PopnCglfEUmc3tXbR2fc969Wu9A4jV1ttjM00pZVMMc6dU80zeJ6gu3XQl/Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9784
Received-SPF: pass client-ip=2a01:111:f400:fe0c::703;
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

In the on of the next patches we need to repair leaks without changing
leaks and leaks_fixed info in res. Also we don't want to print any warning
about leaks. Add "explicit" argument to skip info changing if the argument
is false.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 6a3d41373a..8bb5d115fc 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -488,7 +488,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
 
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
-                     BdrvCheckMode fix)
+                     BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
     int64_t size;
@@ -503,10 +503,13 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
     if (size > res->image_end_offset) {
         int64_t count;
         count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-        fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
-                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                size - res->image_end_offset);
-        res->leaks += count;
+        if (explicit) {
+            fprintf(stderr,
+                    "%s space leaked at the end of the image %" PRId64 "\n",
+                    fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
+                    size - res->image_end_offset);
+            res->leaks += count;
+        }
         if (fix & BDRV_FIX_LEAKS) {
             Error *local_err = NULL;
 
@@ -521,7 +524,9 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 return ret;
             }
-            res->leaks_fixed += count;
+            if (explicit) {
+                res->leaks_fixed += count;
+            }
         }
     }
 
@@ -574,7 +579,7 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
             return ret;
         }
 
-        ret = parallels_check_leak(bs, res, fix);
+        ret = parallels_check_leak(bs, res, fix, true);
         if (ret < 0) {
             return ret;
         }
-- 
2.34.1


