Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9080D7CFA2D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:01:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSce-0005sJ-AF; Thu, 19 Oct 2023 08:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScX-0005nr-Ov; Thu, 19 Oct 2023 08:59:25 -0400
Received: from mail-db8eur05on20717.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::717]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScW-0002iq-37; Thu, 19 Oct 2023 08:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9lZ2GiL4hnOsIp1WO+Q9/TiglsbRtCVNj4cygyKGqJcQdaxnE1XnRsiq+xNQc73iEZW2vZbtHir7jPp6030yJgpFFmVKl4egoMG8u0dwUdGV+LPCk7OWx+ilU6bIEwWwx0niPzwwqZo/sEED80Q8g+O8CXfZmICkZEt2Q/N+3hv3jD3srABeTBuUsHPugJQ9l3hdW+TDcWtvzEwQSvRUZ8EoclIhyp3zPi2LBn0jE/8y0GbJL4fvXUAxqtehzuBp3REvH4dGoiS11nNjztNvW/SoJtp23DWR/1fns5x6lDh2sF4ehQ6R6f4BkSv0NEdtVf4IuUaTxpzPCO8Blqq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UUsUWJac+HNAUU17zSb3q3mAf9jMCl9RlQFBSNn+z0=;
 b=BY+dACuvAj7aIEDyUklBEaUbuQub0Vd9Y3zZbX+gB6ICDCkFs/BgjRXtxu+Juw9CNHQ0ciwvLDLHJ3EJWajW0kC8NhchGgY2FPoB1RcCbFitCzINkBbDvdV/PlenwVWaEMMe21B+T6qgHZqFO0MKBG2Q1rcemr0EKjPaGJ3CXodLlhDf360K2owikEWsEFk83JBRv25Pev1SGlnb4McrQ++hMb5Bhg2BUlCs3fDMLJEf55OraOL29bYjxUpQxFurfjMWdWmcV2vb1JbiZoGt+cosF35zruS432JeNegN/+3dBObQ8c+/GC3ipE/3fEDgNjwbAEE/CUi8LMoznbTEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UUsUWJac+HNAUU17zSb3q3mAf9jMCl9RlQFBSNn+z0=;
 b=Pif+O8e2HuknLvUnCqqDOcJV8BIfuz2LId2eWaQf7BgzXxVy2vQAzTp0Q2HHw3Y978qCGmglsaaplu8kBM+aMcwQh7co6C7e3n3u1Bb0T8I8H4s0uLGVtV7yP7Zghg5vAHzzJw+IQ6PnX2x/Fl/+4VERN45UecbAb8Q3hIGLyDfk4WQr5MbXinLQFWnQAIeo48Qx5RMxpgUTn59cumsn5JIxjlVGE+SqzSZQAEay80zdhUWMXARTrGTfNiypklOI/ecXb7ZF6k58TMijy3mRvb4QP4on7g7/ohdh/Wpg/5PG8rh0a7gjuakEkAfN3zOgom0BA9+avszsW2XFIgaVeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:13 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:13 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 11/20] parallels: Let image extensions work in RW mode
Date: Thu, 19 Oct 2023 14:58:45 +0200
Message-Id: <20231019125854.390385-12-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e5369127-ff5e-40ca-58be-08dbd0a33144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oLW+dqlBz3iqWr7JdgDSnjOJhHJmB6eDeFREt+JnZmOzad2TkLKlMb1FWRkXh0ZCrlHy1UdLzwXVPcbH+Afg7GZi/LOxUzKU18lmxpR7eTtvO4lgmpUcFWraCzZMuYaFVBwM79i5VGaFah3grjMudfbr51luteWNstzF5xnLlT6qp+0+PviQHDsrz8R4bhyI0MQKwOs0aICz6WV9wMfNO4clrKWRk/dldGxjZF+nuJbWvtrcDS6RQ+wbBFqaF8bqWKANrjjvBEWpMmvWckixzMn1/eEl+wtwg+7h7lwRTtawWp4erVn2QnehtS+sHC+147sHVa9eKmzWnSDxFWx8TUVp1g5bqOgiyAoT9p424NyeWkWtHmaQJ4PLfPCUiuRMOx6Ky3F1ZBevOP2e7FCTIHgUBobJLK37izDaJ+5nauRUbeB1Kkh7zfoE9nvkQ/Tcu5QBSSowiDlFcPiUqQ5KBbmro5dTQGYNp2GwwG7zwpI1FFAcq97VM0P7/mUpuD/YKiiEMCQVabVm8NPLo3vy/ogJWOW2M/mNNrC4Wj5rmJXqhfcabEzY2dXxxWRDCSjdG/iLrjIbnhuvYpafoYoXX42s7dLHmR/WMoRaXFJMrl09yUVpM+BdAa3duTkJKms
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pq6F8Xk29nF829q88rvoNfP+Vs0PwWn/8xJAVm84Ai/BP6Ewnvzbjw0CZL54?=
 =?us-ascii?Q?1McgMEl931hEZA3n84IAES32No7TSr83edeGzZQTMVwUZIsLsHvGONWBXUmU?=
 =?us-ascii?Q?gSy6vxinJy6YBML7NDQKsyAc2SzNHWWV2rQ7bfZB0pBuq9TXXNKgnrqlWUVZ?=
 =?us-ascii?Q?K7Tf2sG6TbJbfExNDyp1ZSUkoaKZcM5L02aEcostFje8+KWAgAmDe2HNiddM?=
 =?us-ascii?Q?HnFKEDrdqzJmeRq9QmjYaKlEuGMBmX6+mjs432Hc0VQUoWdpBF3doZ8km3RI?=
 =?us-ascii?Q?cFQPFZKkTlCmwEhseDqwlsfIeIDgFvxI0JFropa//TnccNYkd7V15opbR1zp?=
 =?us-ascii?Q?aMg7ymf78DW8eQa4VzA2qiOHM+p9WwKob5vCUlM9ncKKn+vy7aNp62G6fd+f?=
 =?us-ascii?Q?fgyDfTgP0iPqK8UuSTQvl1L9irkmRoLcvoGlVzIakyBd/6SKbxVaMPNtJWnS?=
 =?us-ascii?Q?+MHnjHTIWrItt2m2Wr9teYUTEdjUpsJQ6c97GlofAjyNBzV4DwnWDftrxb/R?=
 =?us-ascii?Q?lBs3NieuG6EWTVaIpQHmrEj2mbVFae9C8ALpy5GeFKC5vGiklZ3ssOD5Fnc7?=
 =?us-ascii?Q?xEanWK1nZZm0rBya6FcehhlxzbakSxuuoLOzlRskXhaVfDEA14YfPthUHz0L?=
 =?us-ascii?Q?0d9LcC6fkPPsWnY1ffLDlRpcO50bOTSDLGzvHhnBdOdTf9PLTEXh5EJOAAtW?=
 =?us-ascii?Q?IgFRChR4El1uyjjk6/TBfIPKzYCD7WFa01TPAldMtH9CufqiRF46ZuIeHDKf?=
 =?us-ascii?Q?xdky1ZxkMIdU/dHE/l8rFo728IcMGv79PQI7M8l4eatSC3YLREKl4rk9FNi2?=
 =?us-ascii?Q?iHtRRxpuLFhVK3sOhWkUaiUavPH8wkMOtWWnAB/ofRBU85FmsPHo3OT9bjgQ?=
 =?us-ascii?Q?IdyifoLOj2v1B1GgieIHlTMzuMapmM/1EmoQZsWFiiomtAe3HsPfHBG8oPAf?=
 =?us-ascii?Q?m09+NZezM3G+hAUQL06dAfAZi+mI9Yjil6gXSdZJdMrD8M1jrgY5hFpH5s7X?=
 =?us-ascii?Q?5WJOPOihWf/wQOcx38Ow16h/BerW9fXoO6a2DgZk1fwPbdIlFRMeSjejZqoJ?=
 =?us-ascii?Q?DXtN5KwEz7i/AKJzM1HoWpgZ56RH2yiMtiTh+LCZQDjXunjVg/L64yuC6Zmm?=
 =?us-ascii?Q?iISW2PPUBn1quNSCNAp7wDRENj0UJSbf48uwKA3b1uz1t8ZAKbi0VoZezD+d?=
 =?us-ascii?Q?StQIgRka0144ccoY19DYKjkBncUCr8oPB5FjP9N9W4KkGObr+CkGcSHE9VKs?=
 =?us-ascii?Q?0gKj4nm44S2eVcBfiyTjABqc5W9X225VExiTUBKB4osJMUnLtJMZ3sGgIFch?=
 =?us-ascii?Q?wFxKSRC0uRdAUV2jbi5gHLQ7hGyH64z2aGdxlFfeo7QIPZ3hRmJOD8R+gf8w?=
 =?us-ascii?Q?di9xXivb+nCnh8euAQjcC1kqhhEZ+n8zIPiSz2gDwgiDNxW4Cxx2cRpbywoM?=
 =?us-ascii?Q?GRaBFYD18HUfXkC6bgJfhvWQ74x/yBh+3hYmi7hABzJXvEoBqf2kk3JVmZm+?=
 =?us-ascii?Q?OW8Wi/aWzVoBS2ecmVNR5C1tV3Jw3nvmr2G7pss60GcL6/HgatpGIulCCMkG?=
 =?us-ascii?Q?U5SBrDUgUsX0FsHFbASijifG/yJyvSKRyNfW94ye2EifoMxNdND07oTGwGmM?=
 =?us-ascii?Q?aILdHHboueWE5GHk5oOW3k0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5369127-ff5e-40ca-58be-08dbd0a33144
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:12.9720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBoP+JIb8zOKMqiobYE6Yu2G9D9BZqgCDfFLix6JxEk2BH2TJdgejMNjiRKDWyw8pP/b8pFRVR4xvb2qIWzs1M0j0eNB+mu2GqFRAc0DtEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:7e1a::717;
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

Now we support extensions saving and can let to work with them in
read-write mode.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c |  4 ----
 block/parallels.c     | 17 ++++-------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 0a632a2331..a0de4f1b07 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -177,10 +177,6 @@ static BdrvDirtyBitmap *parallels_load_bitmap(BlockDriverState *bs,
         return NULL;
     }
 
-    /* We support format extension only for RO parallels images. */
-    assert(!(bs->open_flags & BDRV_O_RDWR));
-    bdrv_dirty_bitmap_set_readonly(bitmap, true);
-
     return bitmap;
 }
 
diff --git a/block/parallels.c b/block/parallels.c
index bb1e765ec8..2198eff21e 100644
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
2.34.1


