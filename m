Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F777B4E5A
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:59:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEl8-0001wO-Az; Mon, 02 Oct 2023 04:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkz-0001kY-IK; Mon, 02 Oct 2023 04:58:26 -0400
Received: from mail-vi1eur02on20713.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::713]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkw-0003Qj-K1; Mon, 02 Oct 2023 04:58:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhWlKrdpnGU3C+6TwsAfbJBCloHI4YfIRMGysfhjCj21BWHVXdtYa/oCZ8+uZ+vQMAV4mgtEpke+Yu0mdlg4KhRI/cFInhzteqsSvGJbZihliLOiDTx5QPdgD/gFVYkkeauxvjyh2XOQ2lCVWkDh0mqoEwNsUIEXf6qYKqZbEO/nFNY9j0tBBIQ2tQfUPLxy2PXagsRGXbYjuccsuIVOqB8iNE13QwVpNNj2S5pRIMXV3TZBmEhtO+bPLc2EZb10glE18kLLGnZ+bsJ1ALOKTRcGygAkLUh07oxKDSyP85iZT0CaZDGVOo2TvyaDWMXwLvkFU7O19p3b4zzt7aABWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFvHSjhVwI08ra1e46C7tkjSIYf3GKDf2+a+7wCCjxE=;
 b=d2n1SXmm9wyERz31RZwWTjugHeZiBhT97FhVGEhKWWw/foRNBbdxvCM57IYte4nQC7EayhdYbU71xjTsak5EyFdOQ8culjcRPPhUNf46QvaBAj+02aKOdGlYr8d/yhLGmbJPliUK214dtEYFgFFvb0O12z/V97/OJRGyupFtMeThcZyAvtautuGb6h3/00VHKF+KkIGp9jQVQ5IMviEvusAkgvYp4Tymap6C/K7uUli6QalvPa2z5In6+9Hwg4Xpqu9HMcoZncIk8r1hzrdNvu2OrbRbUtZPjJSfdaA3yIQF3wuc0nDNjrYbSQs2zqFw06W6gJ0i3zcdNU3tuyJo9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFvHSjhVwI08ra1e46C7tkjSIYf3GKDf2+a+7wCCjxE=;
 b=vc+4mSuwKGgrHIxq8qJ+btS/Q2kyJjVEkbKK0biDo1oueeIiyRlwVsEpqrTOa57f4JcJJvpqUFw0T4FXw0jo29JLzWvIy64afTE47oVyrkKt4LEzJ5nsPIC4MUGSSRpXnHY4aqBLHSjhBHn77ad5hEE5TVF66tVxoKJEXXZOehpGq6W97jmtF3rbfEPgGNyZPthhjj6nFL0G/Mhc9/mQzzduOAzi0oiSBYofVjI0PtzYInxjQalSeVXEjPaGR0NhfRdNTtgpxPCUgHZ0zB8iVaVzavKAVHWYStLF75KWTDZ6/pWNCzmLvx0lr5cfhotNArE/h7Bbd1xA5VQh/t5c7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:59 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:59 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 14/19] parallels: Truncate images on the last used cluster
Date: Mon,  2 Oct 2023 10:57:33 +0200
Message-Id: <20231002085738.369684-15-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9029a813-58ac-4e55-aa4d-08dbc325acff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6nUp1QcBSnCiDuZ75ONgatGOcElZij4jcXSkHbUzEz7Y7EsH22k6aFTViWjChZBHl+Zt/Ah6pN3RNVxa13sw7vRLrDtd0Y4G6TCN7XdLBkjOMfDlWfyDjBA1UUiiVrisXIzF89OU6H4v6gLyCA/ryo1lEM2nW2zhD+Iy5dt6jNvHv61NUmOgch0xSGdSxNXNUCtUuBANBVku4gohrCehNpQ/6OORPwQbUMg0V+QaetNpos2wbUQbW+w66ODm0Cs6t3xzKWL1+3JIaWP/kmypf9U7TTjJc0+c7m+GtiZSBcwpUk1EVlLkJDh80T36agvAAjjwpskxCP5tuOMV/2Y5+aRx56OkYUTvQTYtXtHsb7GNIYm4vzRUIJYzcAo//8wYiKImKfmy8MnF0GmiplG0lQLw/vXWqJ1TbkiF0JVMhmTxGkzrWk8OLSPUGuBjeeUBseH2zqGc8UvMVhMX9hRYJLCYW/NlPshhN6A7Uf/5uAd1Xf88mh7EH77ph2nQiXcxmrJN9CwB2/z8h+ubdqcauh3OmotfA4UKcJc7kYbsyQ7gCU4D+z0+nI9Z6fz+rfmSDVXDHNHlS0yzmLuS8+PTnR/Mdb0t/BxFz26YL2vNXsIOZqwFSBw1FvFqa3wmQru
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Plt2We9PM6Z6CjxfYfqTJIpAKnwkBtp8C5cC09yn33kKmfwowRSssIhRsfIn?=
 =?us-ascii?Q?ljGCsU+LdeL7YQYP843m26OM27CifPQk8nLWHhFdcVDk9I4nheULSdjjFo+c?=
 =?us-ascii?Q?ZVL19j3E0k1miYk9v6yY3SvJ6DL+dZZNcwwbPpGfeL7X7wgDiPLsBQdbJz46?=
 =?us-ascii?Q?78S0KblkQqCJuAj/Ss/ytidws/Epom01ODtq3/NOEZ9n6RhX/ubCYpvC4a2d?=
 =?us-ascii?Q?Xv3rTMelPLtODCW4ZPXVhqg5UnTwnUee6AbieMGVtDAC82vJq1m3ZF7wwlRx?=
 =?us-ascii?Q?qcjIVU7n81Skd3M7ZUxmgAEyU6soye4LYtB+o1mVuWnCC8sfOEP3/jdodZjI?=
 =?us-ascii?Q?1CJxQDyEdQHsdtgG4vfh8a/BtDAgAvK29We7ooFHA9rMj/LaBmxDSrLde1Na?=
 =?us-ascii?Q?yl/fHWNZgMgjZ0FPFQoA6BmKbIWY6acr7T6lUsNF+kSqf8TAkkdH7w5Lqr4V?=
 =?us-ascii?Q?F+LyKpOAzFM5qHizTgQs0XGSERipZOXnNj0WyHIG3i5ZtGzA/L6u48wBwZUJ?=
 =?us-ascii?Q?u8DOrI6gMQCkCVRUAYjJXi4jIMAeJBDnYjMa2K1FJqS8S7phhjuo+Nyz/lEv?=
 =?us-ascii?Q?qyEAq1cCrjAuD3WAOKtm+Rtk/3eRz24YLw3AtAGebTQXV0fpbNBXUTn4DRZz?=
 =?us-ascii?Q?h0jhToLwvNM0jtCmbP6cjF4Sh90k/6zVpLy8bQmmn+QKTQPQ5JPkHU1gEUsY?=
 =?us-ascii?Q?sPIHfnTIh9uEJfwpAxLMbz5mldP42Ck3sBqDjXduoXbOtiEect5jhIZV9epn?=
 =?us-ascii?Q?FiyJR7SsHCaiwGq1YcsTnuSp+WG9wFEq9IwSGIq3ZfU5tNiSYI2VVhd0Xemy?=
 =?us-ascii?Q?yQMz7j3jdnS8o55iZjelRfFgA2rPeSrmqmGTEwOA/2O+hheF7iz8WiFId6mt?=
 =?us-ascii?Q?2qcVkttYPixaxQP7YiAj1bCjgKSyNoiIqz4YbJBfTeuQjYVc5BZ+qfrPNXII?=
 =?us-ascii?Q?g92Dks1PfIOcCkg6Za5E/dBxSORWaagfJ8H2HuAmNK2iCwND/tUIlITJlmXr?=
 =?us-ascii?Q?oagc/blDUSYLEi+zBs8qw3YUhz6VjQfmJi590WtNj1dpsYJqCaoFiI4Dk5NX?=
 =?us-ascii?Q?EcCn0JuYciBhFjtTuUOQ0wH6j2Hdf8TZ75Dw0ujOHOEsr31nF1tSZQJ6mA9B?=
 =?us-ascii?Q?3Vje80U7/hLKTYLqgCSLzC+OLS12GSkpRLD4A084RHfGdbCFeHVFnysZss1B?=
 =?us-ascii?Q?dKPwVl/RNnwx4i7rdEbOej2sLMgrpkTu7fwsY4qK5QqGQHiHiAmlfnkSZCbf?=
 =?us-ascii?Q?iEQMNda+S3ZRlv8MPSvdOO/S4K4EPvpISnJDYJ/deXIXiRxWvAKScj6iNSOW?=
 =?us-ascii?Q?TzXiCZqTcbh3EsB1WYsZ/OytJUq6Yx3QXk+d/uUIF/qakPIWWvY2OtGd0KhY?=
 =?us-ascii?Q?ilPme56MY9uZ/jHeqjulkhyvZzX/KH4kBsJ+S8MNl/ncefRjZsJE+h362p2k?=
 =?us-ascii?Q?UDoqanvh5F7o3UhSYpFObpfGPAKChQNUSNcQYpEfEInHxOcymZ8tH1rvuf2W?=
 =?us-ascii?Q?dfH4Htqm3qXKFjvl1UpYPmlGc8ZLDqoh3Agwc9tCAmyZTWSqN+ygOBGC/udI?=
 =?us-ascii?Q?ExWMUPSLUJhD8zSbzcaP7PAKd5HhoKig3hXcMZa+2rmFULSqLQwQTBALrmHx?=
 =?us-ascii?Q?gxiTxeGQ1zRVd6yXFqsZWN8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9029a813-58ac-4e55-aa4d-08dbc325acff
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:58.8131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xb9rS/gvZ19DsYMqdo9I/Uf4RptW/q1aqZ+JJM8L2Y9Q61MTxWDFUifDidz1HEkiYxOblqs4c4xxtfOtb64Brn/aX8zLWwEV62DEaucZY0=
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

On an image closing there can be unused clusters in the end of the image.
Truncate these clusters and update data_end field.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 7b16ca2ab2..48ea5b3f03 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1452,6 +1452,19 @@ fail:
     return ret;
 }
 
+static int parallels_truncate_unused_clusters(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint64_t end_off = 0;
+    if (s->used_bmap_size > 0) {
+        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
+        end_off = (end_off + 1) * s->cluster_size;
+    }
+    end_off += s->data_start * BDRV_SECTOR_SIZE;
+    s->data_end = end_off / BDRV_SECTOR_SIZE;
+    return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
+}
+
 static int parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
@@ -1469,8 +1482,7 @@ static int parallels_inactivate(BlockDriverState *bs)
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


