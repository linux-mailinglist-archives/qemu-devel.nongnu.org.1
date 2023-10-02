Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A632B7B4E70
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:00:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEkx-0001gH-Vr; Mon, 02 Oct 2023 04:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkf-0001Qu-Mi; Mon, 02 Oct 2023 04:58:05 -0400
Received: from mail-vi1eur02on20713.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::713]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkc-0003Qj-Bx; Mon, 02 Oct 2023 04:58:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6kwPzw6fMLbYQvA+J4g1V4GIDphnZqQzM2mI/XVivp3G2vaOUFKpNwEtwufDIygiN6W0fiLPxxFImPRxONzUGVqgZvXPpbkPCeR63iKHoiX2WkWKF/fQ7aM+rSLd1kX8AQeOG5JahUWNGx7M3xQFr0FSyIB1UU8O36sLMoRkEbWb1MCmL8PBtHu3empX9pCf7uwnIZiGS9w/KR3lDr5MWeffdoAU5S1OeW0vaBLjVRBEgofiw501nMRcyp+Ugg2EjpwEbZ6MkhNqg6JBMpbRvmOph3wx6URCWsvggQIhwC1854WtNguopF7N3ipaS9yOigyiRbfXk9qnjT4OROtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntnX2giu7Q2KhyJ8pzAzkiMjoJlJRZXyWwsc3SfG+7U=;
 b=ieNOUWsjjzXlastPQmZ/cHN2mph12viCZeR/u69cMG42jegIc3K0UAfNwz+8iSUfTjzDFqRKR//azK9EVqXfpMaNW/fXqgufymks8KY8ZLASxRLzRnzKeGnbZ/cUC8+XVFUlMU4jumJXAqsWLM8Zr1XJRAybjGwtOX9zE0JBQjyCrFWDuHLPRdTEF/kBjGCSB/4ZKn7sXinRS0k2J+YVrrHWVRoS61hH5wSDrw3IpORGvN5b6B2lsM5lfHTA/SVsGNQJ66YRoGFeW7sc5Hs5dtdlZveF79xGZiRARq1T1bhm3Ko1NH1d13KD4VcMxe1v93yQgw2oqj5MOKjR+wlSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntnX2giu7Q2KhyJ8pzAzkiMjoJlJRZXyWwsc3SfG+7U=;
 b=IWg97afR/ffeeW3NwtHCNy+ALFK3SBNW3Yxfb+YIQTZTW+esB0P6megYlBmseK8wp9YhuOkXDj4VvuMd2EdLFCRmjSYD2PMhbBKJWJFcQAzYHxjWPX8m5AjcdSGVcYONQ3cH8v002bTwOCmxQDyPnS9fcjnvEbqc6Si0yDELM0zVklHHScMct3pxQkWGmF3EzCp2vDlIuefMSt5WTN+Po/ctH3a3NYQ5WQv0WNzLmFilHeCB8c2YqxHq1J0XNXHkitHqYoxZbaLWPEbBXtr//ivD4C3YMjNPGCaIltBgQDIJ5nLX6XKtawpoAj7b+dJrd54PeFIUE/gFBC2TpGPQNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:49 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:49 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 01/19] parallels: Move inactivation code to a separate function
Date: Mon,  2 Oct 2023 10:57:20 +0200
Message-Id: <20231002085738.369684-2-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ef2c5c-46c9-4d02-b96a-08dbc325a616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnK+k+nlvcosnrFbwWqDospBX2aFmQHqkFFzlhoKFRf+1Y0z4b493O59N8zxPuNqziQrw+Y1rYPYAzKlH0te4RGPRMNdyzBrYJHHT9oeb2nYVc6b6ujuaZUZcNegZn5S5w/vJPVkDK6kccODNBnn6BbJGlvspeSuwJWHxmhwHhHXQNB0m6k8iUy8+Q1cahr/VqdHlS9vW2pbpubnGIXdwO1lzIakH2s2JgoZHSviv3e/Dw5JZBF2TqVUEZSCsWoOrh7nMTXwbP0HlY2KSAl1CXopwoZwhaoECWdN3gvqSQPp18HJPZajZ6oM4qDEycnA+bVCe/3TwpqrSP2KSlTon1KOLQXWmd9CiCkHjGirYzzQ9hD4xefH0S2jT4CziyoqJvoQ785EYkUfK9X8AGLNviIFNOQJrT2jw+Rv11ZjX70AEy+VtmxXo5gnSEXi/h+C52VFIG+PvTqgNmE4MWLsEYLSVxzTWaopcBxWqZhxYs1EDwqNzSPJKDkxJrhLziQGU1QFDibXAbiesCC5n9TT2QHr63qugieThijmPFCRPy7i2uLifKQBnXAss0DDyWwWFqiRqBZoBy8PymyKrekITqlRjSMgOkMswpeEjIjrzrq7TuUbBXGTsrnq13xeI8NM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vdl79t6JqLZ6hVzA6tLTUMIWWSOhZvwkn1EL4iDFmh/gQDhAbGasVrruucv9?=
 =?us-ascii?Q?dFyKC++jPvNRy2CTY9/ILnnhWuN/srT6Wu6hfP7VtPXokXSCuIkFeaAV8egy?=
 =?us-ascii?Q?0uUwulPMQxYMWF9fc3LR1yNovYK0F0YlZ4dpvwsADZzKy3e+lnXtYa5M+fBp?=
 =?us-ascii?Q?EAioqG6Foc/U0Tdqcxvh68YTEsnVH5JjcGBlWL/ytlimQQt2kng0tAr+ZyzG?=
 =?us-ascii?Q?r/DRI06F66xLaFOrrHxBgHrhgK70F7jfBj7aUlitXb4kzr//CJaAocl4zOTi?=
 =?us-ascii?Q?4qMSjd6bPXzkcjsfWFZTaGP8jTqgkG554KJWp3U/WJXPd9fvPReIpafA+Jwg?=
 =?us-ascii?Q?CbUC5BQ14Oer0EpEwqbwlpjdlKp+d6d2VO6oqRrpq82rA6HmnJJkLI7Bvny4?=
 =?us-ascii?Q?dKDLZsr0JuDE5XdY7urmsTuj/hm8fzkBDmNaGLAlevR0EG89Q3lX6vDcLtAx?=
 =?us-ascii?Q?E9kjYr0yoPkgZWy8iQYWry8ekT3g9rLYBBTbSiaC7BvYdoTf3aMz8ApVns+P?=
 =?us-ascii?Q?xqo3/8uLjHYea3uut9mVJRngDQq//vuLDWiSQWpmtUI0TZWmKwlfzY0A67OX?=
 =?us-ascii?Q?1cvtSXwWQsz4G28CnXGSz3F0s5XlKe3jdsEwESu0tDWl0NzY5KWCfusNC22W?=
 =?us-ascii?Q?qFLoMqRdIzrQsimuWRBAK3BpHiK7yde6wfmu0Vz5CUF8tmr7NwhXWIHdbn1i?=
 =?us-ascii?Q?dP5YwbxAeLsSLbywEGrSZG/BlUC0ts7Dk4sNpBazAHCKOFmgl2i/LDxxvtA6?=
 =?us-ascii?Q?AFN9HuHFhT9tOicweTsJPerIMuVytOLrs0RAgvBokx58cf6WW8a+j80Dp/bd?=
 =?us-ascii?Q?Wyi21vxHTdVjpKui7eydyK6kAH1u1+w3T2BCMfFVB+O59rKrRzbuUXvK/QB0?=
 =?us-ascii?Q?xzKbMyozVnbfItx470AwtUhDySTby5e8JmvZzdO57/2IMtLr7Lfy9D0XafNg?=
 =?us-ascii?Q?N4TqrR51a4M+HFJEgz2PbyIow/Iar4hrz00G0pjyuRUKaXaVA7JXhfeZHFNn?=
 =?us-ascii?Q?uRz54TK+6Ny2HzQBz+D2sy+Uq5yonubRRhY0U3Ip1+mJzbS+FhNA+gpJgacD?=
 =?us-ascii?Q?+L7TCLvWvRP8AWkk687hfCJbKDHqORXeCi3r3qNBleoROkWcVgVvFw5575hM?=
 =?us-ascii?Q?OL03E4+DP6RYOX+6Ozrr4bpkt6kQWRizK30iWJ4uChftzXFd6tCgzqyXu/u4?=
 =?us-ascii?Q?2qJ6/HgmBd5BwXJr3C/aP8XFfmYekmGBDNp+KRf14X1mITBIBRKrL6az8Vmq?=
 =?us-ascii?Q?z57xLW8C0lR5mTkLna+XdEVKpD8Qtr3tRXmRcr40/KClacerkim5ybiuRkjh?=
 =?us-ascii?Q?SVcTO4mmXL/IL8HY+99S0thrs3eYbeCf8MI2AMwHmkNdkzdhq4/Rkigsmh/a?=
 =?us-ascii?Q?wyXORF1u1oNKVeSqvwwSc55QTdE3A9NQXsWf4C4QBDHkYecJb559zaLov6PI?=
 =?us-ascii?Q?W4cVTVFKfkkF5Hgn75c/6QwZI6vYetcgkpO/A9dDatxa+L9wxtUt5mrVLU6W?=
 =?us-ascii?Q?SRebDokvoRRy5xv5rnbk2r3itdp0raBSRQEhQWWqou4rSQrJ3g2hU8v8uO6w?=
 =?us-ascii?Q?TS4Pd2rpUZikvzG1HP7AqAslkGNQRq5fzcQzbRs7SwC7NK+WQ1Df1V7eLg1z?=
 =?us-ascii?Q?LvQa6qO/g/DM3+GfHUXTMC8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ef2c5c-46c9-4d02-b96a-08dbc325a616
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:47.2194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j4QEHw0gQ05qx0TfogPStXOEvSVhEqhgH5jDvFspgvnNnk2XDecbIobRC5Xk1zzKE2tbX899JVT+b+C/gIObwjDo8NT1AlRJFedq4oNQGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:fe16::713;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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
index d026ce9e2f..d5b333d5a4 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1426,18 +1426,27 @@ fail:
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
@@ -1477,6 +1486,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_check              = parallels_co_check,
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
+    .bdrv_inactivate            = parallels_inactivate,
 };
 
 static void bdrv_parallels_init(void)
-- 
2.34.1


