Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD6381F6B7
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNw-0005LM-Ht; Thu, 28 Dec 2023 05:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNp-0005Il-T5; Thu, 28 Dec 2023 05:12:57 -0500
Received: from mail-he1eur04on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::713]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNn-0000at-NJ; Thu, 28 Dec 2023 05:12:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLADf5TpIHvuMx0eTvh8uslGw/3Wm/vEJGHqypDXrsKW16c4EvvRHTE+T7XHOJz7yJdbyH7wNtnB8WXLk6/mFjq+jt6hfpLjzhlX+qvQnR/t4Kj4wYlH6geRJxNfnGgZ993Lj2pTcLsV0Gm8A9ezNgmYSN6raby23fF7KbOjWNCDJQ0LE/FTY24JBeCS24kEvVu4PEAzw8OAaCPGFINmGAZZM45YxpkHK5NMzJWCcS0dSqnWU7ZFDsdxyJEA/Yb932s8PAmBAZvB9Lve/GneN9/LKS6a5a3a7cq3fsx1AjrIIC3li8fEWHiJSKPa5M2veGjPVQlbbVkEGjLadSFUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N2JwpCNxcAlatSCQUrsyN56yKpu3V05h+Yb8Q3o20U=;
 b=cWp66KOdkrYpXAUlcw2fnTNHkbg4zijngwfHC2Vr9GxS1wKjXovCWETcBQkcRVZ6dr+HjXPbrkKIQzAaoyJrcpyyUCcYVdOyFPFqouRr0phRYqAytYjr1G3fqkfnEp38tbj+aEtPUeaBiHiBnhrsXkd+jTV71ZEwbW3O9YZTUcJHHHubLh2UtGs41oiAw+2c0vKpPXdPJKH+5DsKFsF9iFmY9BToBbHaoyLfswZSmq01FrWOLwdIOClD5iuKpCkoNJd9J8DyQ4u4Gx1fRz9aU/utOJkAN1Yr0IqCaKOWGWaQapPqLeXR6hQ9+nCMEifvWjkwACpwilF6F8YUiZdvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N2JwpCNxcAlatSCQUrsyN56yKpu3V05h+Yb8Q3o20U=;
 b=FQNMzHzGmq+X5Y7G/D6BZBclX30yD3kjEc3A1ZP29mvRjkXVxc8nbiPym68wARnG7wP87R1xoHT6PsBkqyWf3HHJ1HB4AIgqEwISETSUjGpYq4Ku0vK1CPIgzKt+Y+qnde9iGDQ3+T7xfNHv65VLBH2MA/57jJ4BiqDgPBRGGmVzP6e4YibQxkKT5BQDpJGBbGTe5jcYqjxTZRfOJyZpMJhcrchx+wGMiRBGBBjVJ8GHVAUL5kD+ERCCwudFm7iYoWxMfn9TxW2jgekUnBXEqNqS4tEQtdx68QS6HeOzrdXuFu10yIBgyxOmPQvNP/CWnxm7eqYrHpyQ0QYPaISkjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:43 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:43 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 07/21] parallels: Set data_end value in
 parallels_check_leak()
Date: Thu, 28 Dec 2023 11:12:18 +0100
Message-Id: <20231228101232.372142-8-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: e09a0feb-be22-495d-ef56-08dc078d8800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsz+bvSykrM/gSlIjrnnhqEzBHlSE5MYniCZaK0OaZUNpo0w5MSKYXGk1Vrv5CKyN5HG/+Oj6y7LOHKakb1sR3e4T0Zwg+nQ3iLj5qc/Z5nkIyC9k8WWBW5iISzXtyglFsnv6kgKRdxEXdGEEk0pLBUd1grPKV2vad+loAEDiI2gE7y5/QlJt/+1o7Cl4Sot1/1xVwzKkzVkNSd851fuybly8HT+yNeJt7CmU6h/RFHe7agVxyLixcOvZm0SUhnMSCwtmU4hGAf+0Ub5syjtCEqMA0gJ7Xy+vPsDH+Ym0WKa2JaGNIPtR6ZXg3hxNQ7JPG/7PBoReL8GgvxANGZF4pYoetz2jZY1XlriBGQLy2zgAT1iL2ZKVz+WDyKW/fJwWqPSGbem/2DxaoAmHnrLHWMmValBNXpWs0zrW4l6wS3dKfjQC749P7RYrHoeSIyoKpCfpd21PE4Zf6m2NB6yfCMYt7KhgrsKFg2YVJChky3P+MtHoTAIM7JY6eKZAop+/E4ht68+mKn3rkKHgnhEMjtILRoa5vjfuhWZ4FM1hq2crS6tZQ15ZCBC9YHRtiZoPXsRde87auXtD/OeM+lo7VLfzZKKCHz/ojC3/BlWa7oTIlSoYM7DkZrhAsQbVx0t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(4744005)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xouc8eklUek+ML32DNKTbWk7X7Bch2X1kwUXGdM+4BrGtjAUtOkuKkOp6PbW?=
 =?us-ascii?Q?WQz3ZbOcSwYrc3r7P+h7/A8lDwnsyFrQsh+iWRTLSf/HureuR6caMKEbFQqG?=
 =?us-ascii?Q?CGbFc1LimM4cfR2/nCEncjX1dnyjdzeARxmeukxYWJpuLPhe4MQANX/xGT04?=
 =?us-ascii?Q?soIJqe185IKZzhiGEa/MjH004nN1LFu7JpvL7xEeIznk8IXPLWA2T6Hk4qXg?=
 =?us-ascii?Q?PJ/le6BNa0U7rlvPyDpI/e73jUQnSgHDR08T63j2A6CgPzaQUCcexT90qybs?=
 =?us-ascii?Q?dhVoGwTAxsHqjU1REaNSBmT/KjNWhHsgbjzy1RTAmbisdattWMWXUWP4TE4/?=
 =?us-ascii?Q?Tne7SsCoOYdJsx+HSwNDoRz7gDR8fws7rqgj6qh/3XjA2M2qf1Hnu5EW6ISP?=
 =?us-ascii?Q?g1fI1halUqmOC1/iSex4QW3HYCW2IQHr9/CbjJ7mrscZ1x7vDE4F5lVvM1au?=
 =?us-ascii?Q?7TOnzMpL4CfIDxQCh3Nyl0WJ9uXQRC5D8Inn/mDGDjapvv7wJgGwhgvoftsX?=
 =?us-ascii?Q?M6PO0QPqpeZ+R5L5bT5LdTDVzgT+Ag0GcNz4ZW03O1L5uxNT7HLjIL5II3eX?=
 =?us-ascii?Q?rLtcWbkLns7ptyzwiBLEBw/d7x7hWprHDtfix86e/bWS4RVWdPLqnlTVMxF4?=
 =?us-ascii?Q?4OqXxrbu+Wb8HD5FBXBRqzZW6J+TibNKmV/4v8HToD7fDAErUO0hYpaU/8s+?=
 =?us-ascii?Q?9aq3CzZEGnK+fW3+cj2YbiCqrA26G1nFO3RizW5ygnB2XH+N4+Yl3H5BNs3Y?=
 =?us-ascii?Q?r2nmEmWwre/3VI7svuZ1Rj/OOQETl++mqAx5XK0NpzhFACFYc0u5ElokHxuG?=
 =?us-ascii?Q?7LbIFgvvThKiV+tJ61Eb1HskP58XqhbQ2lfXwBzLJMEZG4or+RGsleZbtS66?=
 =?us-ascii?Q?RQdme1E0EMrlzD/Zgu+EvPSZXCbw5NWSCFgcwOUyfLz5USzLcalG+EsxQv/X?=
 =?us-ascii?Q?gl1oss5gMfLlnwTEH8Q5dLpcGc0ASuQ/+c5g+koPQcWxxzonsge/g5VtGb5S?=
 =?us-ascii?Q?QBa7YHsKHYT7exhDhgucwKu5EowX4++HcbwYkBxt6ZSBnncoLfLY3p8qsn8O?=
 =?us-ascii?Q?47Y5qv9R4H6LQki1kwm22Q7IGDKPJLaXZKHVMlv7tJOGvjd+/qanNzhhSy5J?=
 =?us-ascii?Q?mJz9YKJwPfuLcd0DimD9BbKtQf//z3xP1eGXVgow0bKH7nrgOm4jQpWYN0P7?=
 =?us-ascii?Q?xQQqPbG0kDh38NDcOGPXjQkTcMXBNX3npprnbbCIj2E3FLQf0ZWWr7dyrKxE?=
 =?us-ascii?Q?CZd1rLBcOWBXueRxV3SR3jwKxuAji1UVCzG4m3xBrx9XNQKlRM5Srk6EysZk?=
 =?us-ascii?Q?ah94LggdsZC8A5+MbhKB2Z6pfjXLtEn77dN5X5CLkveHXV0L5XocCr+O8qMc?=
 =?us-ascii?Q?fvTOpNkak0mzLqqQ9vKLSysY0IPOgPS2xsOzj1odxy9FqAbPcd7SFU49pIUQ?=
 =?us-ascii?Q?S/uCMTK/LdO10/4vn7PeKIok63MlkMpM6z9gfyh+8qzN4bwUVhrCWkdwg6vx?=
 =?us-ascii?Q?mK22DIZqji7rf7S86ZiUBr9+P2xxmLZIpd8fUqzr2vj1UJ8VrH8hEW+LCZtp?=
 =?us-ascii?Q?nJMWnP81MT+u+E3BCW4gGftfWQA26somkAoilvSVw9KTw0QEAWF+eaJar5nN?=
 =?us-ascii?Q?A/jhNroJAEhQW5oeJKrDei4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09a0feb-be22-495d-ef56-08dc078d8800
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:43.4991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tidZ9BdgCSyltktOaqlDH3mpfBnSYvER4M6w9QO7R0+R2NqbMT3ag8FKyVHrlQ+UeFWUePe452lljMocohsGQTaGYw4aeaw2lFImO0b9Ti0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:fe0d::713;
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

In parallels_check_leak() we change file size but don't correct data_end
field of BDRVParallelsState structure. Fix it.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index 658902ae51..8a6e2ba7ee 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -806,6 +806,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 return ret;
             }
+            s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
             if (explicit) {
                 res->leaks_fixed += count;
             }
-- 
2.40.1


