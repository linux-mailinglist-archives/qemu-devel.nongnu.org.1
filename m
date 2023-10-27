Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D25BD7D903B
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZD-0007LQ-Rw; Fri, 27 Oct 2023 03:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYZ-00078v-LE; Fri, 27 Oct 2023 03:46:59 -0400
Received: from mail-db5eur02on20701.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::701]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYX-0003ya-De; Fri, 27 Oct 2023 03:46:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jodTTJfyIFZ8zL3/sKUhsMynDRtoyMII/J+NFkybEYslMpoo0VOdd3swob55qKwKPKGKHOjJSB2e83UCLmyXpBo6VdgdqJdNGp+s8AwJS7/KSE+gffR2JrG4rZjiVknkqljyc6nelsw7HbdwOfeLiFxKluTagwgwBXDlyrcjs6+fb5bTtboqCvPVnVJ8Hp8J/0iIzzPeCY0WTz9CXAnpdFucqy8lmlmoiOEiaAzgeiUsqnCWW3XcPXPUH7VJrrp/PMsuwRoigvMb7eK9ne6dmQSFA0T7D6RQRV5LVabp8HQmI+s0YgW80qoPJfvBdR1pcS+HTf1a4HwhsFtdIWZQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akDO0OoBweI+xl2r6MzOa2bwAvtCS00NTm6TkugQl3I=;
 b=cc6gNtUvQ/n5TCV7TNDMlt+ZUsIySDfrqRcZHVX87HKPnnPV9AAzmeTUvjqZO36emNCTa+iFrebgC5ytgSZSg3fzFG9LWngNS/T90pB37ydtrN8rbXdu28tDMXBonFTOl8aACyJrE895ETQLgFaWD2nz5x/SHoamJhM2foYnFuqP4Msfe6MIKP/AdfpXyTQLs8QNQ6uev1YDx3cllZ6D/K/D6sQqilsPTIQDGDXto0zU1bi49beVGSBaUQbjFiLoGuu4filgPXMVUTDHsZh8v8E0JWaElUN64vVFl62h7PZA3lzYn4KDz24v1hfNa/r2FDiDNrqguEpeQivYcpz8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akDO0OoBweI+xl2r6MzOa2bwAvtCS00NTm6TkugQl3I=;
 b=LDKrkurJohAbfUXSJi//LZkVietMLr9AyvXtxO60R/vmULlIXOfKt0C0e+TWNJn/+x394OiTOK0jlESkwPTAlg44WVQwlAA0Q69DNdhUj/u7MCHthTtE/0VIATx5igHfnEbEoqCqmmR8GLgBfreOFO1NXv+bAOc/sNLURjHRa/y/L4HxcfO2M5S8loP3d00EZgZIzaGEU6vtb5fu8FOyUbI21JySri6rIAldDlLUNKvtefBl9i/I5tpQH4sqdtR1pYbFVWlklRB2rQ63FjIbE6dwK7z78gMPd3pDieISOTXenJv4fgu4nJmdDyb9kme9qSf9Eh6cGTfLE0dKaHBXXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:44 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:44 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 02/21] parallels: Move inactivation code to a separate
 function
Date: Fri, 27 Oct 2023 09:46:17 +0200
Message-Id: <20231027074636.430139-3-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::30) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: b5428472-290e-45ca-6479-08dbd6c0dd46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YcOW2Ot3nMmu4ZPJ0PJ7IAI0ZFo4+6xQa12vDAlv8j/ovrATY7Ej6rakDp1f/j4tygkgtGAO6qnuC9aZTOwvrj5ubM3jcZE6ycqs7MHNpKT/JNIT0P1Lt4moswUtRi+V5QXUbUTUksqEAky9ovp3upQajmHTdhPqAeGEGHWvHAloqsFgjrE9mlARjXL+Lqgcb9FXOXSLTK9ZMV1yT7jY280VrF+eEUO1TvUbw/DTXwNyv03wCSaPOpn3Obm/GiCMMo3VGwfo7n2NqH+FHJreFcgAjPqHOxkY6L2sU+Mrd/WEu+y2WALuz95C2/PBWzI6/H2B/nDrlvB2dp13VWciGZDidCp4MYLj+2nhw6wkEaaZio6PpRIVVj4vMrbwBjKP+DD4sWytflvuD1QGs2L+hpb4m81WAk95DLM/qQAFIZFsfy6tAdR3GeVDOy16yROHzFw9MlODprTYTe07Eaf5ufpW2uNMS9sxFa4dPE6hIqT3NG5myGrsykyJ4LK7WB7K6gwiPaOTiAFLKtJ/xva8tazLQoVEVCHi62hQSsGwGlwvj6SDlc7pI7sBe0JhGmM9EQv+AP+R0VYlFypQ163fCqBrC1m0bTYXVCoehIic5+2y58MKQX/T9WKpiWRqUzpJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vXnOD6FXBOg+3C6Hl8FGAM9R53619lTxvG5HCOWP9u2aXF4CB2m+OEChmJh2?=
 =?us-ascii?Q?Ap4YrchqF3tMLzYd4D89J9oMXXUOFDNgmhwlqV5Is0p31v9FM8SeBq7/YMnv?=
 =?us-ascii?Q?XXhy+8CHgKd8khHqHY91NJyINQcOnqUer+NaCJjfATel06bvKfrOSzne+JY7?=
 =?us-ascii?Q?v6XThrb0vtoex4x6niuAzxWy9IIZS2sH97ZtPm0wP3bXYvTjMsOEUzewBRPi?=
 =?us-ascii?Q?p1umNKRUIaygPPinRIFzPYqWw3Gksy7Q9J0naqTjF3gxGZJcYZLENPb5GeeE?=
 =?us-ascii?Q?g1JcW8ZMHWybnUgtn09TZJ4iQyRSnFe+6e6tHO8PSPrmEgIFL6+sJY/c6Tt5?=
 =?us-ascii?Q?qtAsubzL2yyQn1SCk5nPKHFAwkF2p7uukpJ5/gLq3tJhZsXfDVsFEzx9YaIl?=
 =?us-ascii?Q?pxx9R34FshcA4E9hfUF8tmWCv5Vy9+MN7mZETz6ubfQ2EEPcEoZICjZbfZBW?=
 =?us-ascii?Q?DX1Kox3b4sFJ6JQEpEVX8a3BfMho+RG9SSMjv3NJ9gSny6aUEyNlybMwT66D?=
 =?us-ascii?Q?zjJJZ4tMgztxYIfgpF4wyxsGnGov7UFQSZpQ7g/xwaFfcyln40YsE6Xqat86?=
 =?us-ascii?Q?ULuK0VVJmCQWgYc/Vdl2Luu9o+6k9EPpxzhm8dWYhIuVyQbZaHlgFm3XL+zF?=
 =?us-ascii?Q?EtwUEBYO2zt+FmOmjfa/0elIlkASUSvdB04lompu5RDLgUCxmpL5nUi/0Rud?=
 =?us-ascii?Q?71icmFqVy3GhLgcNTNfSHG3+0KPMgLYySJrDR/rL0DZkT1G1Icct135W3w2g?=
 =?us-ascii?Q?z4G4QccHCFDqZp6txhSGeBsZ5AhqzPcqMfF+aew8JT7LFSP3reDI/Hwmu+K5?=
 =?us-ascii?Q?y3c47ixVAS/nqdHdBOPnW7LuqDy4SuHjohwUwYOBtogy8eI+KliG0W/XnEJA?=
 =?us-ascii?Q?Pdxl7+0TPMqrCqOzEdqOuRy5yeDjOigl9WLcIJNCqaysoxxnzXHGgT11f64y?=
 =?us-ascii?Q?5FhMBqWNaGCrGJ/7vf27+uPnKI0jaO8GNpRGNPF3DJt2/Dd4iGTmpnYNU+cK?=
 =?us-ascii?Q?kIpjDFGNq/t2Yo5J9GGcfRgFRMNKMpsnY6TrbAFYqYqHVTbJk3WSTJLanEIK?=
 =?us-ascii?Q?+mLDRVT9I9KuDlacD9C3tTjzbpKzgq3156zFyiL4iOYqbYQypC/wiSpCqHWJ?=
 =?us-ascii?Q?TiUiQ9CEHdKR3AMPz0uoB54s+ktsNQQkXSv7bqx0OoBcNuTpecbWNWL86PTJ?=
 =?us-ascii?Q?9COuQN8VLS1tNrLKmzTQiUOjR2ddD66XQkZJmhsLI90K51O/O6ZAK6gR61Yd?=
 =?us-ascii?Q?oa7vIV1kxrNKjDACGDifWvF8nGlAThLe9lylZgW9TsQ7v8zBwmoTknpHI1K8?=
 =?us-ascii?Q?3YWpaKTO+32RsQCJX8gBLDLfm+6Mc0KLsjl+WcTGUjiESDnvPrZsiCqG6HTU?=
 =?us-ascii?Q?9WVUFrVcGCzUkX/JbVZEEpSwf6epG8F2JMoZ8aTfFPUVjntu6WLQRravU5Pv?=
 =?us-ascii?Q?dXLw/oawuF34BlSTuRcgccqAV9nsggi6Qo5rQO9oY1REwo1MITKkBZeB5ppv?=
 =?us-ascii?Q?wgpo+xyQ78pkk/vonend/zH/GdJIi7T1+f7y15Dj/dDLG9yxJa11QrUhgt9+?=
 =?us-ascii?Q?x73k3EIrGVCImim/4TMjvPAvUUSseh9IIIYlT2tZc9qCki7v55IdJoBSHpJM?=
 =?us-ascii?Q?ziEDBbeNKJFAAb6we3RDOqA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5428472-290e-45ca-6479-08dbd6c0dd46
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:43.8573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzpyha9+NgauA4CWPFn6C1h6Lgd1r5nUDqo000yChms3TJ09GPgIwJN3kdbm3QMH8HDXbWuMYjJagTGtbqlbHJRCx6Xz1BV9qkixBvHiYHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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

We are going to add parallels image extensions storage and need a separate
function for inactivation code.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 01a61a4ebd..8962bc9fe5 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1428,18 +1428,27 @@ fail:
     return ret;
 }
 
+static int parallels_inactivate(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int ret;
+
+    s->header->inuse = 0;
+    parallels_update_header(bs);
+
+    /* errors are ignored, so we might as well pass exact=true */
+    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
+                        PREALLOC_MODE_OFF, 0, NULL);
+
+    return ret;
+}
 
 static void parallels_close(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
 
     if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
-        s->header->inuse = 0;
-        parallels_update_header(bs);
-
-        /* errors are ignored, so we might as well pass exact=true */
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                      PREALLOC_MODE_OFF, 0, NULL);
+        parallels_inactivate(bs);
     }
 
     parallels_free_used_bitmap(bs);
@@ -1478,6 +1487,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_check              = parallels_co_check,
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
+    .bdrv_inactivate            = parallels_inactivate,
 };
 
 static void bdrv_parallels_init(void)
-- 
2.34.1


