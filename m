Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE9481F6B8
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNg-0005Dh-Of; Thu, 28 Dec 2023 05:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNe-0005DV-PE; Thu, 28 Dec 2023 05:12:46 -0500
Received: from mail-vi1eur05on20707.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::707]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNc-0000Sp-Ie; Thu, 28 Dec 2023 05:12:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9e34O2i1NHpsh6KYjV2RgB0jgXTC7O9jHB90w+IYjKY8eNW5V+v9XJwa6tWnMu/oI9+bXzkl4XGlSwauKNZhfH041u/0367eqgWHrHDCC7NdTjPkyLenI1Yce75z2mcgKjPSK9s/qbVvZukIlV9ASdqmV8H0af8b/Qkh2PbTBi+GcRcD1MjJxslWaqhTrLpJMzreZby5fgaDU17oYPbNhv7ZfH7h93qASvp8pdRaH3pNKbcTxc2n1l/f6jcdkFPy09OyWRGauSc1g7q/dlal479rDAS8yWcq79n6fpc1RjudKCzFhmbuCwf8uTBcVmzQ66XEyPZ6X7BIMpgjJJi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKJH/SnE1VYd6dB1J/HgjlmdPDZivDxE/8D7NJc2Hfw=;
 b=gkEh1jvTNQ0MLaTydeNheQF51V4fz1YIslGTdqsvZACr+A3o9ilLuaX52Pj5nU3MgXV7P96LxWiFQNJAef7l8FjjGw9QPZUJtReLz6LFwL77hSIrnQfmMxfa+/Zxay3dB2aYVvxwS/2f9zXWLDTcCuwacrdzcyhlkYaGDNDJUybxm58/sYLm2kTRddYZbDNchxR1tHX9K61xqrHYY70TB3IEEGeYRod7psegIo6HRMuJriDMFQ+8M7GaEdHhDyv3iwkYmp6E8H3njRZeYsvBAmO6dmPY5CtE/pc1gmBMpc31iSXH5eJ4k5wyYRmggJHnoPR1XGe0o/linTn7CW5Neg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKJH/SnE1VYd6dB1J/HgjlmdPDZivDxE/8D7NJc2Hfw=;
 b=qNx5+EuGfeiEvuI0P2NIAh6XjlTeV3NwipIJUdEFRgwfzwt6hUDFR4TsEMKgVulKEOBL7B6zIW2aGA8+C10eWUam2AkkcXbpCUL5+9sf68NB8WR+/qRwcsWQv6d+dJy7d7dd8vkPtKwiprsfkFM/uC05PIqlgCoSW9Wq42RH/5pI5Y23LEeH0ojh5qafoo0L8Oa8wbD+IzbPA7b0T9W/Mgo/cXm3bqcNdn5mFFpHRXviLJRWufWgXdPVqo++7PBMV4Tg1ar2QxrAeE5IkxiVRpskWfd1bz7j5XVAu0sr9nfoAbzfiIBo1EC5jOjsMYlq0lUlDahInfbmgQeLpRcYog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:40 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:40 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 01/21] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
Date: Thu, 28 Dec 2023 11:12:12 +0100
Message-Id: <20231228101232.372142-2-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b201b427-ea7a-42c8-39cf-08dc078d85ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrIqyAhBSMa/UZAmb9pcWiYXbgKHMXBwB59CO93+F8u4vOSoJ2osW3n5wNew8QQy6TXCtIz9PdWMhBcUdSG/sbt5enLaBwszKQbBpIT6IOLNC0gYPsjo1ZEJgA+WBzOq34qS+MpvobznjVG/pe9rwIekFQUJvwPkv7uzVWl79/DuvkOgGbGRoz6Lrlj86tY9841kcqOaLJMCsmK83R+4uqHfkoExCDJekyDJ1mlKoPyYIyg0NaYubR1r7aBhqrHwq1tJ/P2dgY7aFyCNfmHE7+7yAb6o/wGvSTUgS9uAnCu+fN9dXNA2cPwUGA4yTDXjk+95stEbZExFy45asKX2ZLzh/TXoavSXzgkT4iCGO/O+H6i7DCk7I48mCKX5F4YXIRmwBiKoyz7nz8xXpGDLWifdmrvOqAZVZzmrYIPRb5HD01/dHkXhQ19Lb0m6GCdezrt0UVgKuxTT2Xgf7qLh2MQcCto3D7fHMMVFvD8V/3HHnRUHgVUMrJdnl3hYLQPc4DSJDA5+ZnNeEXvDUGAJXw/x0jByEZnejeqXebsxpMdFuKJdQQUHTkcf7CFXnxP9bnUvODFto0qkcsM25di91/TsXe5/BOb1kfCGpALVBMWDrGKke3SBjimstTz51C0k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(4744005)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?faZzW4fHw7YQNUWQ6X3kmNklZWGMhjRMS3/jsKfSf0+MLeyXq7c9vQRBagYo?=
 =?us-ascii?Q?cP0K+ErlHz/Ip+KipILw71uKYU+lWSvyqj6bJ0sDiU0qytodQXDnQeNn0VEs?=
 =?us-ascii?Q?5VrK2fpsHWU5x8cuy+IE9Xmkr5Gd9OYq7RB1ZO2nddOAh94H7ZAujwIXxKv1?=
 =?us-ascii?Q?l7EEn0VYs0eDkAVTYVsDlqcIIYS3AuH2se3A16RZcEfK22L02BxG3awBCY1A?=
 =?us-ascii?Q?hZK9hnjgvvZWZEancqOCfHWi1Gr6MEJqToh3vLPxNdCcfj1PZ7SMG9mzm09V?=
 =?us-ascii?Q?vImQQKyWjx+Pl8xu0t6J+dqJLuSPNBlTmSSTJmX4B2IDjjY46CdOJKg8pPaw?=
 =?us-ascii?Q?DoO3Rq5AP6WwtWmG8OlvdwMKu7M3q1+DREJ1vob4O7dmLCSYQB2GA/yXAjc+?=
 =?us-ascii?Q?f1sLOupgKbtjD3k572I9LxA2l1Wv3xKwctruda/midkR5RFARYeqpOiwxNhg?=
 =?us-ascii?Q?1BuvcIOJbgzcnfA33WzEnr4Q/mdaUqqK4OQYGH5+/lolf53WBsviZLNIT4Mt?=
 =?us-ascii?Q?uI3y5RMH4jK92QNNt3yb1LQusSyN8K1amMVVUPBIwnbCR4cO6vKqnP0rRqtb?=
 =?us-ascii?Q?JqEjrEsfi1OKtabK2qvC6Ea2pRxowOtHNRpgTOprzNxnya8jBCR8aMETllRT?=
 =?us-ascii?Q?rIhEQy4fE4Yw8sMUTpNLpTA8gKPtd/B/DQ80NjMbs0Y1y5GMs/7NKl2Fv4hL?=
 =?us-ascii?Q?KoIC5IV6FPEDWNXjXUUE5SeRWXQ4XohlQxuDIH62tjzDgPlgk4lOhC0IKoHi?=
 =?us-ascii?Q?3fEUxOSUZpTstZN/huGUmCqvUrcRV5hnEd/8RVm4S8BTKXGf7j7QYix5omjm?=
 =?us-ascii?Q?fIPH7/RgL5yCozueBk8EVKv6ZkAi0Lb/eo9Tjh2HQ+6OFaxJJjnF7BqU+SpN?=
 =?us-ascii?Q?9qu0NMiv+FmIaafO0AY6DJWChkaLplmVg6ur+61SQPlnuVtMyMBOS6CsjalM?=
 =?us-ascii?Q?eafyjcXqhDvCvw7vPzEvEFowpFuhoC1zc+daexKRcpMZoohrU0vTMiaVo+Tu?=
 =?us-ascii?Q?j7YzYcgAp98kFcF0TNs94s6kmuwSsQckI1oytjuDkvMbRNXMlgujGQV0cBCz?=
 =?us-ascii?Q?dZ7vLCuwkf/35j8FYturij7k7BHTO+UEc0RWQMe3oMq70ZXwtUp2AobfMJiB?=
 =?us-ascii?Q?4I3XBip7uP1Dt0RYJHwpjGKlepFS/aSyLFed99hZrvWBlFed68mE1u+p4MEN?=
 =?us-ascii?Q?siiUIl9R1wUMzs18nqxrhsGqQSKmYX/VEWfKDIPsz9w5kwL9Af9VhNgEnw8n?=
 =?us-ascii?Q?hToNGw3bj0WEy0Pj69lYIx4KY6ZvRRHgfClyT6lC3BW8ZJGcnAjzIHVmCwIv?=
 =?us-ascii?Q?7fvFEe6ficCVtWQDZtN68R40fu+5I738Y6zPcVBgoRP5MPxl5TI8RZfmlNos?=
 =?us-ascii?Q?+prsDvuJHIvxVlmeEAv4KAnXRmWqfhvelJO7jsZMN5v5vG5RWujstXMNifAi?=
 =?us-ascii?Q?QQtiua0MbrZZqCT1mnSPmGcEbMMWuNg6gGlEujDk8LMGm/wnXQ/8sHSTHBRF?=
 =?us-ascii?Q?/JWpMhKvQqqdSWjLrgkd2YTPmzRmaKRyrmCI1sMhWaYAtqt73ySy8Gk6PGGK?=
 =?us-ascii?Q?40ur0Hnn8tD9oOryUh3ibK6vININVRiFl1JIq8g4KSCce+nxIK4EQQjYSOos?=
 =?us-ascii?Q?mrVm8mZb2mDdiu9lE/DKHAM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b201b427-ea7a-42c8-39cf-08dc078d85ed
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:40.0171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6jNsn91ihWu+XDe1L5PsaaYSTNut4q8lwd+UyDFOdFcPxC1NHnT0lQc2egWjmG3MT0wi8tmxiiu7TJdPjNqTGNFbtcK3EkJ28R4kW2X39E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:7d00::707;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

After used bitmap freeng s->used_bmap points to the freed memory. If we try
to free used bitmap one more time it leads to double free error.

Set s->used_bmap to NULL to exclude double free error.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index 9205a0864f..072b1efd78 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -245,6 +245,7 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     BDRVParallelsState *s = bs->opaque;
     s->used_bmap_size = 0;
     g_free(s->used_bmap);
+    s->used_bmap = NULL;
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
-- 
2.40.1


