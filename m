Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EFE737D3D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:21:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBt4u-0000Lx-NR; Wed, 21 Jun 2023 04:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4p-0000HJ-Cc; Wed, 21 Jun 2023 04:20:33 -0400
Received: from mail-he1eur04on0711.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::711]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4n-0007BN-NR; Wed, 21 Jun 2023 04:20:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYv4LLtHadxCuPY6d5hsZIhrfYvRx6WYAcjOwvPKlpjS381IwSne1TbzzX2EEzPSLgEAqSVful0+huWhSO0WtrwY/11aX0wGEXW5JCcdce2HUCRphIJ4Kh2BTq55vFg9FOgseC9y0UNWDKa90WSYshT/TVFrtlk85nCy/6+4OZmODIQ6zmevLjKztKUHiG7Y030Be8xT23mdZ252utxyiDB6k+zSbSzsfIF6CqRKXquVhXiQBbe9cuaAjaagIylOQEUwRj2vvCJ2KWtTAbtokGc5FRVviWuzsRggWKjBBzA5IGvu0mv/N8UzENrSWVFLAz77eRmy2vMvPoTT/NHw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe1pJDO3O0byZMFpzd+Ge0nMZSTuL1f7T16YHjPMQ3s=;
 b=Lp6RiQaPuXfnzGPsJ1j7O9Fv8rf1rVMx2S+3IH2gfsMwfc3Gs6tiehjOZlKdBbY0mleO7+nktNSeg5IRsrPYXZpgPTC8fwLxNMiiuAbR2JXaQbg3tafR1mQU5qde7hvV199QZjXbi4QaproVuMDfWTl79KaXpkWPVWMOrKk9EuZLFlApiGgf3Lrb+t+T06hg6GMmMpna3lyFho2IDpj8TvOHIQA7SM+xCFKO9ZCLrf1dfk+JSUpcsPquW78PchhUuTuOIU2jzQlFnNzc8VDZcx8KJmf/+3kyFNvBtPoMijn9KJuK6+j+UE8KOion2E5PaWgKmGfcS1k802Ocy7tazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe1pJDO3O0byZMFpzd+Ge0nMZSTuL1f7T16YHjPMQ3s=;
 b=LAZCXvsMWY3Y7oqkB/EpzNAtQfrwSxNIXFmJAQaw6mjfiRKVe6Nqs81yeJuojzADurQZ5Wp6E4BiwJaMGRdOw/mfSokolE3030DnCPljRpU14PdB4cM7mfiS1aPDX40Es/qh+diUfng89Ymic1ffsSQ4vGDSEnzIPkqLbp6C85qydaIenldlVYvJx6ynO0yCHVZsUNiZYGCMjTmJkLlxMRz3shiW/WnUw0UpjgGHO1bIxsS2lkZKsLAkeaXmimsXoptBnwaIufqcFsbJgqcMN5L0tqdtTsUmNpl7kukD0iPYq8+WgtbdxqMXazA4hPFki5l7An7Fyk73BtH75MuC/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 08:20:20 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 08:20:20 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v6 3/5] parallels: Add change_info argument to
 parallels_check_leak()
Date: Wed, 21 Jun 2023 10:20:08 +0200
Message-Id: <20230621082010.139195-4-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
References: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0165.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::19) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU0PR08MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: f11de038-bc86-47df-5bc2-08db72305a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTaP8ioMKk/3wtFVLpp1JUhkRG8fXIT21ESnAydyTAmk4jWncIYOcRGGzneV9BEusgT87G9WVfSaZwhTPxtTofeFihGpIIeu40E8YOGQqvFQjI/l4nsw6hrZ52hHFm+mqgbdpMRFSguBF8x3W+SBmbns1arYW8A+pXBHhDatRcQ24G9Q51tDqpa5I0PZvEUmUoOAyjraVK75xg3XRkX6wKMU7mIV2ihe/21GwG4VgDqOB1Kq/3JV4EwYj5G8huH6ds3QXWYUbdanrx/gixo8TSFbrQa8UI203aqzKT1YHrdme9OhM47agz/pFowlvEPEtfuveYWViFzBkn95ru28BEcF/JMqeYj1mwTUs3GzHf2BTBUWe1ulBt5Ewel51Xd2Uw3vVxXmVy0IuupANeMht677Hi+wpAgX4R6UOQSNECQCy86UwGkEIzSQ8uJXPwQUWWTLoxcqqku8By6avlM3vhP9RAjm76nottA6TJ+IOmssto/6pRncvGob9PyH2kZ7Q1cm3NrKAH4/U9OvWfi8cC437PDjg7/wDqniur3wydxHEaeiynlPDYWVFn7vpQKcq1XJIqO7eqyBsZ/obHSYmw5u82jnetm6tjzFQLTwmwGL8fEx+i3vHQoSG2Oi7YEd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(451199021)(66946007)(44832011)(5660300002)(86362001)(2616005)(8936002)(8676002)(1076003)(26005)(6666004)(186003)(6486002)(36756003)(6512007)(6506007)(52116002)(2906002)(478600001)(83380400001)(38350700002)(4326008)(66556008)(316002)(6916009)(66476007)(38100700002)(41300700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aoUrE3bDbHppbhiFCOGQwF1Qz9jYYkEwOrismllHuz9/RrEGXThrnqXre3wn?=
 =?us-ascii?Q?JZRn/okj1yyaBMOO5jz8Ibs4FfjHsBVJKDTrt36DNM3JpTL8BV8oKjq3c2ID?=
 =?us-ascii?Q?EGrFc3U/L3P9zQHKx5XdzVw03l9Tmek10iSbUx4HdurgVjTBRobxLhMvhmVG?=
 =?us-ascii?Q?J80sLvFcW/yvyW1QGyRxlqqaE2qUsTr4+bfxQrnp8oTXvYPv/jTPuU283l0C?=
 =?us-ascii?Q?iY978RsnPW70YZ+9TaC/vl+CTsKxOSZTbEwrppz2kTbQsRXyA2GmVIIwIeIS?=
 =?us-ascii?Q?v6E0ObO1htDZAShd5PbLD54fZBE4CnGJYRFjYPu+5SM909N+FNXOQ0peEpPa?=
 =?us-ascii?Q?qO0XuZThs9Et7kAF6H4ppw58Ym7BO27EuYvRVK+GI8o4zfESw9GAVO0vdcjy?=
 =?us-ascii?Q?Ox97YMG/TQcETpQeSnVHd8UDBybWb4a+u0AVyznFSlCuzkzI2Hesj/83M6yv?=
 =?us-ascii?Q?c7RanztAVaLf9TvayGPAXplo/Dpk16MAdnBjlAMkrkqAEp1XMRVMM7O+kIPz?=
 =?us-ascii?Q?tVADUXDCjV690OBUdNFnPFZs1+deWrpg3cvXQN20IC1hR5BZwqBum6UBf3gh?=
 =?us-ascii?Q?85n74mwL3JZbP71l9T+GATQ3+iIFPSCPWbE28KgqzdxZCRIcD9Rtje3hx7TO?=
 =?us-ascii?Q?LNXlQPBzyAWFEcsuhi9Dy+sSjxqgYWjJ16oggNGTmjxs7s0bTwEV7+ZoHVag?=
 =?us-ascii?Q?/cKZnroObd5QkCtmlprMhWN/qpymSnCy17fTSFBJqREwS83Sp5r1zpZyPZWX?=
 =?us-ascii?Q?8xo3vZ3rhTv8Nq1sKjpaevqNTiPC4W8+Ms0lKqT2f/IqZ/8IAjEliRgWR1vK?=
 =?us-ascii?Q?9EWiKW1zepc07DWFQqU0bom6zuo22ezGJgJTU0H1W5BEqZFVN7NDHTjNUAnf?=
 =?us-ascii?Q?M7xcYatpfsKGdnDImw84vDYqe8LUA8+SNqfDKF+R6/R2KRTUZ9XHq1r31ECC?=
 =?us-ascii?Q?3hMRfphRdByaGYFqerCtp45eO+rR8DUo0Vik9W/HXG0W8W3HYcdjqNfZiV45?=
 =?us-ascii?Q?obIHUM7bdUJKYsQW6VBcGrGvmwPDH/KkZh7UKYK51L7FVj8mqYa9fZOzkCcM?=
 =?us-ascii?Q?kLzrks8Qz6J57uu+Yl0vVDmPZnpSw7ci9A5Xl+pA60nN9uD9bY1pXCGGkqEM?=
 =?us-ascii?Q?KoTkbm0ldJ6U7r1iBdjZh6CJZwAzuAaoUuHLG7cNH6x64k2z1IfOGDdmlr3I?=
 =?us-ascii?Q?dgOb1qU+jsm4UyKdML1AYQxhq8ujEhuATAd7+G89UTqGhiGHoSKSpKcz8B+y?=
 =?us-ascii?Q?j/T8bv8R4vkgZuzxfQQNY+fILuwH+4XpEnGmq7U0fYLMRg1PfvqM/44wxkGo?=
 =?us-ascii?Q?7uPEQ5bDDQq6NtYCS5oNy3oZh7ebvbP3xsJsVbUBcipZ2JT1yR+2+SO34bP9?=
 =?us-ascii?Q?tf1auxXh2xBMHTa8PkfiGl/h3aTH68Bi/4MBH7LBlj8s1PoNSikTaeEaULa5?=
 =?us-ascii?Q?MYF7ZwuNU3Ob8PFTlTpIi2yQ8WgByqG1bHaFOxhWFPYvMgwDbhv5nz1jcNbH?=
 =?us-ascii?Q?9wRfePlvYrrfgMo+uslT5JfSL5bEJY0uX5VBoFItJXmEQMqxHkJZVQ8raMXm?=
 =?us-ascii?Q?SpP/Ly01ctHkjngpIWHczYz9Av9lP1EWA98But8h5z2+p92MgSCJyZihSP/R?=
 =?us-ascii?Q?Qh22GLxcJn1qoxEPgcbEJls=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11de038-bc86-47df-5bc2-08db72305a33
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 08:20:20.1472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHLuytIX76WrF9HcFYP1Sm/QR/6B3UZDqtDgKneTC7fmObadDmrYJlqdqm1Yer+nN+rtk/oqu98oADIKmKAI/csn75hZ52QAfA8MjCFLKKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8422
Received-SPF: pass client-ip=2a01:111:f400:fe0d::711;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

In the next patch we need to repair leaks without changing leaks and
leaks_fixed info in res. Add change_info argument to skip info changing
if the argument is false.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 4b7eafba1e..78a34bd667 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -484,7 +484,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
 
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
-                     BdrvCheckMode fix)
+                     BdrvCheckMode fix, bool change_info)
 {
     BDRVParallelsState *s = bs->opaque;
     int64_t size;
@@ -502,7 +502,9 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
         fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
                 fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
                 size - res->image_end_offset);
-        res->leaks += count;
+        if (change_info) {
+            res->leaks += count;
+        }
         if (fix & BDRV_FIX_LEAKS) {
             Error *local_err = NULL;
 
@@ -517,7 +519,9 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 return ret;
             }
-            res->leaks_fixed += count;
+            if (change_info) {
+                res->leaks_fixed += count;
+            }
         }
     }
 
@@ -570,7 +574,7 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
             return ret;
         }
 
-        ret = parallels_check_leak(bs, res, fix);
+        ret = parallels_check_leak(bs, res, fix, true);
         if (ret < 0) {
             return ret;
         }
-- 
2.34.1


