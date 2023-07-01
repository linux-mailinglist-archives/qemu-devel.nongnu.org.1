Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5890744862
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:09:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXWf-0001aR-31; Sat, 01 Jul 2023 06:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWc-0001YL-Ij; Sat, 01 Jul 2023 06:08:18 -0400
Received: from mail-db3eur04on071e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::71e]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWb-00076K-4y; Sat, 01 Jul 2023 06:08:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsiSllcvqcK5dtYMgdZIgh15i0DX/H5BgpSOs3m/CrxnEGb4F8Tp+kNeSt38if4It24u1Tt8mnyfsZGgJTLrxqIQ4wHKgzbgHKsty7FkeozV+YhD4G1crAqhQBzjPqEB5ZEIhnULSIOCO/HTreWOsCl7jl5kDMkj5OlcjNr9fBgOeeH+8H9vktrzWJ4Mf1u1A0hGxU67SLLdeB7/xhHRnjeNZJ0VVxzq1c2UeQUiueatKDq1r8rGYruK/pdjMyxjukVHZeZa+Hl1VCPB53nvSsf0WQoClOC6hbCrWhdpg7vhyC4uDITkqqJxuGyR/77gDxHVF4Fyqlq090bZSR5/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiCjSh44KAFGkdhWDPs9WkYqKHVrJ/JeEMCzqN6s+hI=;
 b=ixPTMz87eEb2d539Y20a8gP2rOsCqKffQb/10657BIIgWI0RKRK8JG34xLFLWyCwhnZtHroHPYGwGjframTJlxRTnGjX90Gr9OP7mmtr6cuEMDclpdTAQiZqHhcrIt0jAnTQC30974/Dl0lQXNgLzQlPbKtFTYUiahutd/1YwDBTJk7cUGEpaBkX47dxUUuVw/9xl6lCAqCLcsbfjV+9b7cxKCODDvo1HJDcV8pvmrfyoV/fQLIYvBroU0dZDG7cwHbNYK1sJV4z+ugYanGNSJ2GLD+4cvohfmGzlSQl+/Ar0z5WUbUW/I1gQ9eiO4H7px/Fis+lZxj2jJfQ/YIMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiCjSh44KAFGkdhWDPs9WkYqKHVrJ/JeEMCzqN6s+hI=;
 b=PA2Avz4yGLMWfUoIEQNqIuBKIBisstRv4iH62Gqehr6WezL1v+DZX2wXKOuzR4OFV/T/U0G22dOZw6+XNexQFyPzH9r8OqBcwjdlyYHxS94oAuaqDOpRFLNeXt8kPt+jOwSnjuEHCkbQbSHQkg1QbyueNFzs5l/QesJQqj8s6Sur1jSUmJRzhuH6USPX0l945pOyB6cGDpH3MaD75JrysF3Bo1Fh1aveMFJudsvSAhyiPEM6QlxTeh+FJUi6nHG91aNuYSegiYl9ndiYDlaHbO6mFUvsGKqzdcKasdYNFOTW8dztj/niHIEZ6LsAAs+iYGDGLPY+z5CDe25ahJV5rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:08:08 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:08:08 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v7 4/8] parallels: Add data_start field to BDRVParallelsState
Date: Sat,  1 Jul 2023 12:07:55 +0200
Message-Id: <20230701100759.261007-5-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0108.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::37) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d49de7-9c33-4c6d-83e1-08db7a1b11f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1I/UEhOX758WCvN+n2kSzXgtdmUzXviE16FXxUcdUICAht6namOdm1NCjIvXcOHs2/6OBc2BUFEq4b12ebcNNzJQJDk0NJH785HKmoID0/pglqFs4wPrB98ogxAd63QZ8FYBz6Bnq809JJbY76bBe8UxflKC87A32G/GdtXjG17W5yCgSYem/N3Wd45fN9csUgyYj1T4L+f3LikhyGaagdqY/Y9d0m4jHNKPnzpwvK5b5eMOcYyY0dGImwouaU7BnC6xVx/lKxZTlrNQ0uzK10hiao1/jqfDBSfeluShbsve7QcwpWjn3aKZXQsxc8U3z9ZkNY03zIzMNowCYFdLnW6EBuXZ/WIJjsx6S/DvNQBjqoQ9now/91h23J3sCys1Egh4LW6F1HqW1tzSDQebUcSBRMpQ7p9OUW34XpPx2nfFQLrIooYgARRvsX3ae0getXaN5rZzVG2/OXfVglXH6VsBIDy2hfZXWrFD9vY+myHHKn8KsezaN3hLBvyoa52ZiuxiJtkh4cyfhtBL5YbvPqWZGnJ2mZlNikh9iaqhgfwoI8TBakkyamTbO48cvA014yazOCGUa2vUGxwA7VwcNF6/MCS8qnzBkXX2JGUHOgLzMmhgoqPhjJ6IZAYcwni
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x01nb3D5nGfXjYskX6S90I1SmhCwEAp7HC/HR3zvYw5DVqIrmLt8qcD8GZMb?=
 =?us-ascii?Q?yRaCSiupUv7hAXMGGu8V24f1B31xoX3zUqIpteXRLnpmfK44qPA4Ut/P8Qaz?=
 =?us-ascii?Q?AreHoWzsLnBS+Lr9ukHRC7rc6yE9FKh6Rhg5tilcnj5NALtpyB67MnWDqjiw?=
 =?us-ascii?Q?0EAi220/D7JhzNp/OedzsMnZtz5k5edWucklmQiAt0Fy6oplWQcxCVhtGLeA?=
 =?us-ascii?Q?lN+EpmJY9B1HDPjC+7Ia3+Oyjc+DJVduDiJhJuXcASQw3L8PRaxjMbmGY56A?=
 =?us-ascii?Q?hNT0wPQM2nJUvaxt4URNooe+gKIt4jAV5eIxEWfnOjY0kXkRiT/dc2CsCoWH?=
 =?us-ascii?Q?iA1n6f6+xjPQ6qV33oMJxnlIcogu5NEW7SX4mR2Ob1xKprAP3lg6ExIIMgar?=
 =?us-ascii?Q?US/I9QPcPSbvWL7FYOryvIo1r7P5LJXoY1YRqUGX3VOUv422E1A9BfQMZ/dH?=
 =?us-ascii?Q?tnHTe/hT8ypufVr3f8NAft8l7GIMasM8H1Mv8b2xELbSyLcim/ZhvcyXVn9X?=
 =?us-ascii?Q?7zpFbKyHvULcc6v3ceq4CwyGehfhfGzJd8kW8T8J59anKQeBcTcyiM0Q9dEz?=
 =?us-ascii?Q?5mlgxs3Gke6fBo7z9TYR5cVf1t9diU5zP+fNpUZZZwHNlehfDfHOWtSdgYr4?=
 =?us-ascii?Q?mVVrUbUaWswmuL/WSZ+An1+YU0RooQpTSP4pkoA4zkvQ5KEFWkugH2NGGl0S?=
 =?us-ascii?Q?4wCQfIDnvADlVu7hP0Rf8MurxRAS381rbjUHtI2mUoi3s/hXq5hra5jmeL4p?=
 =?us-ascii?Q?1DMZtLCqv89epXFW/bKmsrKdz2COUALUbHZhEhI0I9mXrnkNF+42rSZdn7KS?=
 =?us-ascii?Q?s9qGav5/0TuvOOVxcL1ps9SWFXkD73TB6WXbqOqhLg+5j/VT20/7b+YTGGjG?=
 =?us-ascii?Q?ZliBxtCmZ6AnGFu+cEUMnAbridZ3CnBQA/xGT4m6mH6Zh4t7VORM3mHQXf6Y?=
 =?us-ascii?Q?MsirDI5tPpdrVCzeegYopCvdAe49N2QWdReBeeC+/86LANB/3OvaJiqPogR5?=
 =?us-ascii?Q?RuDqciyisiScJnpklIMGfJJK/BHYXOuTOnmZFbyQ+GtuxUgg/FuMiRkQLo+t?=
 =?us-ascii?Q?HqaUoGLWktKaCRJQA0DCw7NbpeIli6LxkjfW2UDJn2OGWLtPFLDLpkXIylWm?=
 =?us-ascii?Q?E8xfgX/O1KofaKgo4MyNKjNswYedyzmbALCfHqM9YeGZce8HWXweDvCXSI8m?=
 =?us-ascii?Q?Kc7+QStmyCgd4+NFIrDEte8Krqg3wIyRIAQkvtvi5Xivn3so9/JwXAKL4Wny?=
 =?us-ascii?Q?6nJpwTctZLZhxXjrfIkdEVZg9mzca55+Dp/Gt/Q+zg6ffc/Kevm/PMTjefeC?=
 =?us-ascii?Q?khz3Mdb1FHcyjuRc4NxX1VlOTCTTb5nA3JZ7i+28ounQnRKbF5n7B5aMdTG4?=
 =?us-ascii?Q?wqec7qSTcDv8g9XZn3aTCpN3VK9FDlDCpuV0fmlkl+kWeYcM1jAY3C2ZprUx?=
 =?us-ascii?Q?SaRaGQwxSNejF1UBjuXAer1UslRGyJdutgCWGiiIn7AjIM8jwt4pi8NBUUuq?=
 =?us-ascii?Q?isA/R2b/MnEGKzfAAUCBx9JC1Kt4cHLbFscEJUffg8Ren2y/Hps90dBvK+de?=
 =?us-ascii?Q?luQT3D108YaOf7a7TfmQtClaP4I+oAYKcOT6uxgEFJgRxLOUcJ/W8GqEvZmr?=
 =?us-ascii?Q?3WgpqudVRLfrRkQVv11xkJw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d49de7-9c33-4c6d-83e1-08db7a1b11f7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:08:08.8261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1EconiTzdGQ5VwiYTZpVSMy4kjotCpYtnAjdGbLkDSN7xzqBjwGpYLPE/9fsx5x1TZfIfNpF4OHYbis3m+CRwy6CfeRxzjU9FKUsgvwTQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8832
Received-SPF: pass client-ip=2a01:111:f400:fe0c::71e;
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

In the next patch we will need the offset of the data area for host cluster
index calculation. Add this field and setting up code.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 7 ++++---
 block/parallels.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 3cff25e3a4..374c9d17eb 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -864,10 +864,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         ret = -ENOMEM;
         goto fail;
     }
-    s->data_end = le32_to_cpu(ph.data_off);
-    if (s->data_end == 0) {
-        s->data_end = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
+    s->data_start = le32_to_cpu(ph.data_off);
+    if (s->data_start == 0) {
+        s->data_start = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
     }
+    s->data_end = s->data_start;
     if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
         /* there is not enough unused space to fit to block align between BAT
            and actual data. We can't avoid read-modify-write... */
diff --git a/block/parallels.h b/block/parallels.h
index f22f43f988..4e53e9572d 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -75,6 +75,7 @@ typedef struct BDRVParallelsState {
     uint32_t *bat_bitmap;
     unsigned int bat_size;
 
+    int64_t  data_start;
     int64_t  data_end;
     uint64_t prealloc_size;
     ParallelsPreallocMode prealloc_mode;
-- 
2.34.1


