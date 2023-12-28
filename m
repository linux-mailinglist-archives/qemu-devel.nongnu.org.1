Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1F81F663
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuL-0008IQ-17; Thu, 28 Dec 2023 04:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuB-0008D8-EJ; Thu, 28 Dec 2023 04:42:19 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu9-0008Jv-Ut; Thu, 28 Dec 2023 04:42:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH43IhTJmTW36RpW6wYGz3/KI9gNNNedi5hxIGh57QkweZSIicx2shEMYSGm6mBkpJFXFQedZLbn6LS1lJDO/OrXci9jC1UDYHofAgIqkY0V0LqBN/eUEf7Bg/B/bDz/xeSxuZrga3YI9haYChpwTli/qGxmlLqBfNcBcfqNyhBuYJ+HoRpOV0m0s+mOz/d/aHfMI6opVxqekwe3jnsQQY3kT20cIM8cDaA0xO2MohtdK61bGqqwk9vE9xiHNziVIYklMqgiq+17y0lJ9DHTeQq0V/hLSfmfiKOlT7Wc1I/yRwiPYa8WFosapNauY1aPYDE25mJCzZiS4o+iPQMxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5Oj30LUdw1Ptxbl2cnv9yLfr5rs7S0ow9Aga37sHnI=;
 b=Z8uvhN9NeR3KOe2u5pYe4z1kJWhyebfu/B0F5IOYWgZdihcMnr1EA3ogSo24dx8CpDYVRpOTJomyt0fssPBOpVKn/W6k9NCDYWM+o5nrn+1PQAxTTYJGfgugV4sFG/csiykWSuay+lV6w3SK0Nlvz8Cw639QZ1+9u7Xd7Z0N7ojFzyybgIUP7/JvcpXQH+l3nlNWvdYST98NMcXWv/Te72LVjnZj/ylS7ql/1Rk5VUSfU2nZdH7W8gzZcHDdXxt020OT9yJ8F4RFTY19iKck2sEZZlvCqWtqpSYDkIfcu/dKiV36wccVwwxnzF8AVMCXEFGfLVMsgYWGj0GEeZsTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5Oj30LUdw1Ptxbl2cnv9yLfr5rs7S0ow9Aga37sHnI=;
 b=ihvoX/hBYYCFSRqvs4mvH8gjnUFz9SC3ASw4r8BqA6tAo6gzFsPft6v4G4JTrJzUQDIvq2HYCFbvBbnwH2kuy16gbVrq9NHBz+T7IIhPasTptbxeTovzV3JNFogRK0GO0HXPTHxrPe2oxge+ldVpouYIUeA2uhMM7Q2nxt2Tc6ZDcYHdywMMfEgse3wtCwfDBPtSrxdsPnOaMMnWH5mB6StjO+j7R2PhQAEs4HwZWsZtZevjcCChzh7igqNT5/5QOG7ZuZ0kWfhHN1Q2dstL9Oug1aczdqYR8mDXjNCw6N2hYCxzuxCQwVUG8muMtRsUwIXmRn537am6BhXvHiq7lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:04 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:04 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 12/21] parallels: Let image extensions work in RW mode
Date: Thu, 28 Dec 2023 10:41:44 +0100
Message-Id: <20231228094153.370291-12-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 33371760-e5e2-4a3c-12b0-08dc07893fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfupy2W3INmftBcUiSoj7gZUSe1Y5yYINiOuQ2B7fkT0HeLpuv+CjWp5vMl8txzKbxCGmv52lhkQreoE4LDeFUauPrtd1zIN6jVw33omum256U8anuqmoFKskB9RHl8ybqCSSKTs0ly3ECoYfc5Khxsd2b7Rkx/ZtpuhKv8x1yRMAI8f/AxIEXeOSxGbJgSoLmqRUkU1QyKTieNDvhtKCZVb+rXVhjZuVG+rWNF+WafZ3+749Y4i4XLEkPujNXwvpBEDt2Abj2c87bNVx+TzFFqdfIgJ7Opb2IIuqo+SyAqtkcnlTIuYlpqStS1nCi/GAsG1BvNUJzbBAeo0TWE7L9qGg1bVcMtQXTajXFqms/4DzsszCwmvh1l3ENB7HfBRZZLTY6nyzzrJSDT9fNYANATpUZdnUxwXmwCSn5CaN++ok7xuL84yCOUr9ffKDC07fgggzMOtDVSmufA0SdZObwG6h9fLkbLQLEfTvzIwzi7eFW13OIWN1uU0TfcwxGpTBpavNGtZU0nL0DGXrvN+yJ0jIEMBqL1dcqAfZIqgjsVcOEMM89Q+g4HJ2QmY6O7cCgEo9WiYZUqVcVRZ/0ourfNy78ywLfqvWh2uTePkNNVYVr8PnjAptoUH+5V1Yd9keoMaRSM5cI9wRpfgADycMkkdYFkdBzbTuomVYexfBas=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WsuUOFoqDRneQKyxDs7fYOEd+RmLKMtsGDd3MdpHVA7AmGW2BArc2BkqM565?=
 =?us-ascii?Q?PLUPKWOxO/ORKnBpZ7jca27YwafrUOxAnWo5NAMa3IzsaSksc/V05uOE1R4W?=
 =?us-ascii?Q?SdDMn6JlNVTZGIZOYlt0ynpYFBawYVesJcc9XQ28K4QTvlRy/OZaXM5L4Neq?=
 =?us-ascii?Q?5oGoKCF0WQrsER+KSkhl2fbL5Jh1nT/DtSB6xRvycsV51eoRnsHqBPTv1lgP?=
 =?us-ascii?Q?l8+XFjjZmhCPWY9mLs0R8JYY9eXDWDPV6MfpA3OfKgjA9G4sYn75Zs03eTCs?=
 =?us-ascii?Q?QsIY5OySfvIa2/2uZ/A5+uu+qyq60yZFnIu7o4Lt24Ssnu89b0DW04dopv2f?=
 =?us-ascii?Q?O/YyuFnUoy9KxHNJ4vx9HBJOBurm6y36+MiaeH8OA8iN0m4J84sF0EUFi1OU?=
 =?us-ascii?Q?ssDvnuq5EgcSJeLNTGS/l+XZNoBQNPm7ikF5AY8i5K9HidQPfno9PtPd7u0H?=
 =?us-ascii?Q?ng9ue0R68139FxxBxWwcOoR4V3XJh/WFpvLDPEoRC+QkjUSh15jS9XLkC70K?=
 =?us-ascii?Q?s79tA1Q0/2C4O/MozIGdo+5UXVMnofdfZWu6i1MAgzokrzXyG1vdwsyhO2nF?=
 =?us-ascii?Q?rIlnwCbdLfyQkD8XjgBT7A3jv5FaSHkCgcCkCTBELPCfmsommuCYxRKgEJDT?=
 =?us-ascii?Q?EVTah7iPPvlPgdTZqFypYfEa5hdy2QDt2jBwaQI6bBh/pPu9r9cCAcqIQaKw?=
 =?us-ascii?Q?reJYvqA1wYs6NAX+tlo4frAvNltF6w1U0EiMWhf3QiiZ5i6Fgudp+rfdX4Gm?=
 =?us-ascii?Q?KNmmQ8uwtGtMdLCEJCOOc3VoJaAQjPgZu5Y0GAyZDia7vLGSqBj5KIpxxbE0?=
 =?us-ascii?Q?CK/t5219xfY/wNab/kvKbwOJTBSXzwjfm/MZJRHXXdIQLhWF930RGChtgDDo?=
 =?us-ascii?Q?VS6S28n6RD0+vMJnWskfuaSqITzgtXEGfn9AdPr9AXfCHOPrCgeROOgQOprZ?=
 =?us-ascii?Q?+4rR6mCjRoAWxCcp14GTHp2vFx8wir10ShxWy8fR/LYxgwohzdig56mS79oX?=
 =?us-ascii?Q?rhrmRYU5gndMRz5cdC/Vh/UDNR2ijZ3E118gqDabW2l5XnY+k77oRd4wPl0f?=
 =?us-ascii?Q?kvFKb/226NdWzTFoRZMM4Rxwz/eve9fD81J6bPNNwNA2zTcFj0LNiZUrJA0c?=
 =?us-ascii?Q?OmRMowx2FbsUYKa2TIJ5gEvj5a+MC6i8u7cufQa0dhIK1ZOFToyp3ucg3uRx?=
 =?us-ascii?Q?LOg9JxR6bZ3AG25z66oUBRNh1f4lZsq708GDf8hN789Sgh1DbEMBekxdsoaZ?=
 =?us-ascii?Q?O++WLt740cpFK9sZKWeqETXE/OMtYbI3oyBOHCBiuJN75GQxO8z97uVj2N/3?=
 =?us-ascii?Q?UhNsR541HYRTmrFtWzFCSWbXTEE3bHlyAhMkWNBDqjg3wbxGXKHdrM9HMFyt?=
 =?us-ascii?Q?XAvFQ5TiU/2TI+v+BH0mym9HG0vh26DfcgiL4zxBd5xJkddjr9KtF4xO0BS+?=
 =?us-ascii?Q?5HHnrD1zSzvlG3BFI6F163Vilgh5Bpx8/DAOB0tz1N7ZnXVZqB+0Qk8zcNeY?=
 =?us-ascii?Q?bU7OgiLZRY5z8w2VaFXckr0nVmXm7NEEzvGLaVq62dJXA7q8WVtVHhuEOq5D?=
 =?us-ascii?Q?OS6FRTOlAOD2JrWQIwCCc+0Ablrwt9UPspPktvlNYsnZR0QoodJNDOQq5rN5?=
 =?us-ascii?Q?HNSgyQVXWA+zBpFTr2VTsdY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33371760-e5e2-4a3c-12b0-08dc07893fb6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:04.1606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tt6hDIMMj/V9igGXrvikqVlUwU7LYrvVSEfJe2gqopxExH03K6ZkKwaJ7EfMzy2nbywXrB2wMOwxo2fuDTfhlnFtzFpRNzrqJvLB1AcsCxk=
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

Now we support extensions saving and can let to work with them in
read-write mode.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c |  4 ----
 block/parallels.c     | 17 ++++-------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index c83d1ea393..195b01b109 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -175,10 +175,6 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
         return NULL;
     }
 
-    /* We support format extension only for RO parallels images. */
-    assert(!(bs->open_flags & BDRV_O_RDWR));
-    bdrv_dirty_bitmap_set_readonly(bitmap, true);
-
     return bitmap;
 }
 
diff --git a/block/parallels.c b/block/parallels.c
index a49922c6a7..d5d87984cf 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1374,19 +1374,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (ph.ext_off) {
-        if (flags & BDRV_O_RDWR) {
-            /*
-             * It's unsafe to open image RW if there is an extension (as we
-             * don't support it). But parallels driver in QEMU historically
-             * ignores the extension, so print warning and don't care.
-             */
-            warn_report("Format Extension ignored in RW mode");
-        } else {
-            ret = parallels_read_format_extension(
-                    bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
-            if (ret < 0) {
-                goto fail;
-            }
+        ret = parallels_read_format_extension(
+                bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
+        if (ret < 0) {
+            goto fail;
         }
     }
 
-- 
2.40.1


