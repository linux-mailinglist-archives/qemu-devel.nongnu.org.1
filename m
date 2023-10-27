Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2334D7D9059
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZK-0007kg-Uq; Fri, 27 Oct 2023 03:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYb-0007Al-EI; Fri, 27 Oct 2023 03:47:08 -0400
Received: from mail-db5eur02on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::72e]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYY-0003oB-00; Fri, 27 Oct 2023 03:47:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh7MSmMtYfRY5oyTUXCth/q+hieUOX3Z5looueyl9KsGsVTy6l/lkvJQPOTz78223/VTj12ApX8wM3QXZq98hRwocu8QZfYLMhc9FJvJ0Kq5PqM8E5x8ZleDAhGT/FlwShQPVOXKGlH9xHA/MkKeY7U2G0Sc3JZhn21Kg2U07cRqwa2TNgmu0q42MHfuoMA4sFIVP1zeuknD7MnByTagf1voVAP5KSlIi6rdjRlRg4xroxSPgDYGn6IjtMM7xawREdb3fLkt+ItK3v9zhsdAav8wer0cCwaa7D3plj2mYYtdruuah68sSxw99HgbDl15faQ45VD1XBDVsE0G07KIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvKeDMX2EBy1kTgcVxNzT37BwWLl9FTEGKKWL6qtGqg=;
 b=IU4AufGe3w/H5MMVVsgJVfzeRG1an2GpmfkHKrGUKqWFyo+/kFLxY88j39u9ylKxNFOuDKf9h6h2J2nwJw2Bv81FymRKdfLuJHDHFoQCk14jwb9v1edQiouzs5FRGGg3KYqB3WF7GN6iCGxLdoZ1wF1pCCHSFwFyB/UEp7EIXWDh0L606gufdFPF1PwNi7RDMWEM77vtluq3Urgdyt9a26f9N0BEMlf5Q3i/q4mibg0pP6JfygrXJDQFTvEps2PL+rYaOCl+jFaOLmiGLPnLw0S2cUlGc8HWf/nzzHN9G/K1bQpkgRGn5sEa4QZPRXqvhMXD3op2sdLjFM/MrZCzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvKeDMX2EBy1kTgcVxNzT37BwWLl9FTEGKKWL6qtGqg=;
 b=Vok8ldUK4nqqe/cfnm9iuqirj6tXnlTNNUN41pWPaWubTLY9FamKG/rD8WRwfNG1ugj5ONjW/dUckJ84ixKMYhWbVpomdXa/vKJcNLdjn8jEoMuQzP1Rp9hbaM5DdqTY4U1g/kMvUJ0DjNYmGCgcum1QGtWMQ6aJvWsQiiLODF8gQAKnngA5P0rJEY4PpNrPJC1k/Y1zt+22HU4CQ9LujNb5EnaepD0hmgTC74Vox0hqpzlfOt02cW+n9cArIugbJO1crgqtUa+qd/G/X5At37hLUeQRfxo6AGEXExwhYcxERWHEGJkW+zGOcbpsHTam2wLbi6VrfngJ/NVzaHc81Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:45 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:45 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 04/21] parallels: Add parallels_mark_unused() helper
Date: Fri, 27 Oct 2023 09:46:19 +0200
Message-Id: <20231027074636.430139-5-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a598567f-4d24-43b2-b0af-08dbd6c0ddb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lvd/H0D5ja4SOonJ0UXqkkMK2RR/+fdeG5vb7fjt4V3eOuA8VaIgy2wWb4SU+aXx1ceboc5rmc06ZAtOqIj0cLL+I51tdX6LyIDPkRX5ZyKRp7WInT4fgfcRM6+dLpwclbdJQwPlcik3gEvlpouSi+4L1wTs8Mupk2LXhN1Ppmxc4tPoyqtkF/pRzxDLDL3eatK3MgoZeAyR42Xcn0PpV6HMmgCqxk8WRBLyCMiOZP5CV4/wiBKyLcscGneFdV5TRVYjtdAU3jtxGqHsNuEbuqMFkcYr/q/pmUvdmdCGNIcGfMP/zdjaYcRdymW/vGGhLGDM5cgLMjT9N1ep86OiB8hjwpmEAlQhf2d9Q7pmrv+JtNtKqPFtDzyjNUn1F+/gnAMvnfSktASdffoRob4g3wp9suX7rFTnbd2F3WxpE0mygh5CcYhHlMyAjHtVj+3wZzNDglmtKiTT03jvrHu6ctnT4AAifUQIzZkKDT2WKOMe/lN0+LsrtKp238OCAgSUVI3v4Cw0nTvBbZ/HAAvVMyoNUUukLClTZWCjr1hj27ZAM89rJsmVCAlQpkGfBbfonXYTFwTQjDgfEpBnvxum//lQAsZy3VFM0//NbPW8ogzeZcXxdLzvTBjgIMHYBL5L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PAWP4mLenkI6XHgOwbE87M0aGtjZb8Ej6PsIkcSARveNZfG6EIcFE61/bRTF?=
 =?us-ascii?Q?OZ7mtUtIb/3rwzE7nNTB9cq56xEPR8fyl3XgKCL8OoHRpfT0E+8+7ah/3m5n?=
 =?us-ascii?Q?EzpSBLrnleCpovugCj04P4LAsiTRqAofZNRDLayQgQfVuO2CyAjqJ8/ookL6?=
 =?us-ascii?Q?M8O56nhuGQ8wFRYq1Wubril+DU7TRiUDDR/gz6PazXLOi2V3zbESVFBEuYne?=
 =?us-ascii?Q?rYDGM8/IGMHd71ROE45uPrEIISbbrhostZEDeAwGpvX3kacPhRoGUtGSabnG?=
 =?us-ascii?Q?DKiZJ9dmMCcyxD7oKBfcJ+lFrdywKc6ltrFBxpls+aobw5qbI6O7E2Uih9RK?=
 =?us-ascii?Q?ZBFa0YtxQAt7dgxy0AMf2+V5UwT+hP4sL/W2ug0E3N/F0cCA0nPHJZqc+HJz?=
 =?us-ascii?Q?ZAJM4nQjxZHxg/itmuNrcxLxLzStkPa/vMiivHws6yTJJQ3ZI+4xIeWQ/zNi?=
 =?us-ascii?Q?XoFccXVfCWOhIwIfSKtjfKwizR5P2WmZokq/4fJvQHNrrYjUlEMgK+rVywO4?=
 =?us-ascii?Q?Lwe4RO1XuzUOQ6smdQwb2mLBagnoMRVWHuXVzWFfHxdaoOXjXF3Q8ts8BnjD?=
 =?us-ascii?Q?1MzB6m3Erjj/B5KEWLW+C16LtcTTZ16t30uiT901+8i5w6Ch8eI+arogU3wV?=
 =?us-ascii?Q?UvfCdWMXBFmAzUJwUeY2O0EjX5CKaYnuVAgfd+vICNrv4oF1Hy3fuDm2iWAa?=
 =?us-ascii?Q?1C7QYbp8MJ5JmdIvvfQgZ4Ak2/6QDAbvUVAtBc0vHVMU8jd8KxlpY7rqEGzR?=
 =?us-ascii?Q?pQitjwMfU3mnTkyzizHORJ26dKkWh8a1fOlOiuJ+OR67EbK4WEC8PbwM+zNS?=
 =?us-ascii?Q?qTB8xK4AOgGRsoAsJfLJWtb8NN1ThvVkagDjZcg+W2RlnutiNWwJKrZnU6/X?=
 =?us-ascii?Q?VaCY1du0W8+G/0LNAI77LGfmDPJed8AHSXmulN1iVr46goIPa07LKXrm48+9?=
 =?us-ascii?Q?ScuopxxtWYnShkNQbOO6JoeoxEI/KL58mSZ9Z1XdydnVz6cmV2JnsjMQfDZR?=
 =?us-ascii?Q?YYNgfYnl7D3IJ46iY6iA1KiITmlz0gNpm5ZKvTvX3SramYfU7nCT+vpopFcY?=
 =?us-ascii?Q?Rzu8cjMZJ/rLgfSqwzjSJo0/UiDYfhkgiufUC25sluwGWaxrmRyic9TSFuBQ?=
 =?us-ascii?Q?lLAA6fdodGjuTwfGqOxw4uN5Q8vFVnT5oETY4g/tkT753cRRhkoKR3s6LIAj?=
 =?us-ascii?Q?Cc4Pl2rwFZoA7PWQaXquZ1HHxAm8GaH3bgbHBQEDHFq7CMfslH2PVRt8xaG9?=
 =?us-ascii?Q?5ZBHEdkIicutCGJQeD8ENEzME2Hc1SO4+puRWagmbHO2WSaOt1Pru7um40Fa?=
 =?us-ascii?Q?LwzQ4JaQuA9DicXSjGNDft6gw9o4tO8YLVStTmzxU2pm1CaoErhP26Finmzx?=
 =?us-ascii?Q?6UdhQ35sh8IbSGSRfhH6n+4TRcONJ4m/ySOP3PilOQWTLA2UzvuWb1mBZcLz?=
 =?us-ascii?Q?L9dM57KZn+uzK8sDkYtmaXPQyw0cqDILXKv6H52pHQiYV3Na9XXEFVjqdLNp?=
 =?us-ascii?Q?dKNZQy5oUDN+XElysb1ow7eqhbBT8W3fDSeDU+3E2GHoar/OmxL9PGHLkPym?=
 =?us-ascii?Q?B4udreTXxLs8QjpMCQrfvyftr95yvWeD7LmhGznVYuST0m0Ou0JbXIJvI2cg?=
 =?us-ascii?Q?Odcuu4QE5K6VieA0TO+K62E=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a598567f-4d24-43b2-b0af-08dbd6c0ddb1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:44.5785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1E0MhvjjCcZ3dY1wDo+V2/ObpNGIE3QF+sbzl+YR9pVYDT1rADDY41SAGVY/Xvj0wock3tX8s0YisFwn1ZHLvpt3bLx6aIdyk9fT4t/gnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::72e;
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

Add a helper to set unused areas in the used bitmap.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 17 +++++++++++++++++
 block/parallels.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index e9a8cbe430..a30bb5fe0d 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -195,6 +195,23 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
     return 0;
 }
 
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint32_t cluster_index = host_cluster_index(s, off);
+    unsigned long next_unused;
+    if (cluster_index + count > bitmap_size) {
+        return -E2BIG;
+    }
+    next_unused = find_next_zero_bit(bitmap, bitmap_size, cluster_index);
+    if (next_unused < cluster_index + count) {
+        return -EINVAL;
+    }
+    bitmap_clear(bitmap, cluster_index, count);
+    return 0;
+}
+
 /*
  * Collect used bitmap. The image can contain errors, we should fill the
  * bitmap anyway, as much as we can. This information will be used for
diff --git a/block/parallels.h b/block/parallels.h
index bb18ee0527..31ebbd6846 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -92,6 +92,8 @@ typedef struct BDRVParallelsState {
 
 int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
                         uint32_t bitmap_size, int64_t off, uint32_t count);
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count);
 
 int parallels_read_format_extension(BlockDriverState *bs,
                                     int64_t ext_off, Error **errp);
-- 
2.34.1


