Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF6881F6BB
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNp-0005Gz-1Q; Thu, 28 Dec 2023 05:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNl-0005GC-KO; Thu, 28 Dec 2023 05:12:53 -0500
Received: from mail-vi1eur05on20707.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::707]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNk-0000Sp-64; Thu, 28 Dec 2023 05:12:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuJsAHn/DP1XCock5URfGHtL49Hairqm2Vk2cjQTxJxkvqwR7BuRbSr6Rfr44LFWuKQMJIpbbXkpaMMMnJWSFhPu1e/c1lCacsY9mGvSacb0TWZOUKupK8OQE7ilUo7ddo5xN+9trg6jk+my5GX1zx/EBAOlG8SFZmqdf0hnIc5058t+C9b0oVsogZ3P35p070nWej25EZoy85wVujP/noFUo/SwkMqEfU4DT8r/WuGckBJRXi8bTPW5MuE1JFoQqfDkKu0DJh+Vj921n/9jk7TuPoKHDj1meEVG7ktchycLZRANUV3wG3tAStzfa2QSmEl++xqMI1j0xblB1JktrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXO8ScENoFKWHNVwNMhYTBjNx87409obryISg/lbAE8=;
 b=aR/0RmSPPi73V1OyAl2O2doCHlUfD9u3yA0c05HhQ8pYSn2R39gV/XfLe7ZCCWRDASCxVmxeMLqI12iufnGz4BFQTZnzib+KYGXeoMFn/IMc5d5tM91G0I7hVtlqkof03gh7R3VEwa1fxpvNlsGmL4I+H98PDADIjqvi4WRqT83EH185W+H8Xo9hUvnxr+SN+AHNr5DfzMAZ5wxUU3xfCn+le0Cq7gSWUNm2Np4i9HIfoWVmne/PUVw/d0HLM1QMpcftn6O8ecZGy20LJmt7cQ9PgXi00AjpRhUkNM074ajXPkQ6f3oDxecnvMijzTWBYO4Ewh0kEck4K+QQZa7/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXO8ScENoFKWHNVwNMhYTBjNx87409obryISg/lbAE8=;
 b=tJdxnhxZVYtX+6MexVq094iUNqLCTR8+kdpUtfVUDI+IuoNeYgd3Mu5zSQZFMo4rOoyIBchVI/wiATRddWRDiaYQItsfII6/O3QtuM4YE+kx9WA/okbIfAdQnuXiSrbgdAa00d0fhoimdeWNR1h0CDe6Ix6UvteoOYZO7k62Dh8RTaqtnRFw0XAJdMUkMJQVQPWTvDO2pyIBP1U35juKChIKrllEnnfMQQAzel4mzC8H+JYl38dnJFKUrDfYE4FlFlThIlBypzmkSx3M6DWzFKUqGI6ZDftcg8fqafbzzKc33gBHyzN/hnbXXF46GCYxPEWKy6OiPZNFFfL2wnZFEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:42 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:42 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 04/21] parallels: Limit search in parallels_mark_used to
 the last marked claster
Date: Thu, 28 Dec 2023 11:12:15 +0100
Message-Id: <20231228101232.372142-5-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0f4d388b-62dc-431e-0a8f-08dc078d86fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cjIN9UPO8lU/Ze95wqyGuFZWOBGfBzxcMyAFZ3R2Oz1RDJ694WwRMO3qDlTOzRb3xDHMKJxjyPyV68hwqBBKp2Pj85Nl9hXOLCKo28rLiQTY8S1vYohNBsTMshtRJ7JOkI1Sm5/pxgmrZbGzsJg+6dbN/qJqJjGw4r5GeRjlgSgN9xBWYzuEL4E8b2bKHX2iDIfPVvSL9ha/IUIq4veU3hV1uxgBbQqafJoWStuRznjL4LE/c/SkjxSErNflMWxUq1WH5Y/cqFD8nFvy6dwJjJ/4rUMI/g2JlMYWWeXH4cYmf+h5WfOxIwbaH2kDZjQ303R+hOkppxAsX53+f3L7oHJKtw32U53j7DbmVzdXV004z+kMF0WQfP4wVew2DOkI67pmisfHCGuLeYrSRGVO1UwuIM+SVF6tuOcfmiYuDxWJytyjECcOOqHXH+P+aYymPns0zAG0lgBwdKFV3dtnMep+lCQpYqyv2GUDXrBlzVXM34CtDbrcERyZLgLbRgFtiuScgZYWs2OBT2tmM16cIv6iPtk3Aaaf6GLIgSpjp8vo5Mdg1e21EMBX/jaLZpY+kcu8SDRAGlDQmMf77E2KGdm88lSEmVwP5qzFFNNb4q5Qba+JrQRQ2H2nYMz7Sgp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F8I7H+jkP8UzRwWZQoybKRu0J4MgPpqHnQCaW7xcxX4pCgC6n8VclEd0i+pq?=
 =?us-ascii?Q?YyA3tTNflsrh9t3GHW1nXzX0GInkGsag6iuejtNS/AxcrxHMQbm/xHV7Gq3u?=
 =?us-ascii?Q?SemzoW+Z1rzBRB0JUTtIJ0u87RU8/NSuZNsxevM/ZyrhpQ0smRCVa+lk8C2E?=
 =?us-ascii?Q?8may+bNgQqhUjzZSXC6davlIP5ynlZ/t5lsQtE6Jr8A0pi4pLn4f4lcgLAeR?=
 =?us-ascii?Q?z0GHJC3nVpbP4HPEeW6h5HmgnS0BWOHRmlxTtCzS2OcAf/cm/BB+cwHjN12l?=
 =?us-ascii?Q?z7H9vyJMkkJQVaKbPfXK4n+UoFXQObl2HR+8JyEUrqcaLfrgmtj5vOPyA194?=
 =?us-ascii?Q?FJwajP8mBT9HCQDsQUjfQ7lo1dvCb5+0NZtWmMze2yhhGIaliBf8tPC1uQKv?=
 =?us-ascii?Q?+PI0e+5Tvzc2Wj2bSHmyo8JEBGQsNBVIR9ASoc4rpjLv0PRei7QX50LcNOcz?=
 =?us-ascii?Q?FNSC0YIBESl6cD63PDhaCSBMbLiedjgreM9S2p3PQj+LiRIcfbuZZutvbej2?=
 =?us-ascii?Q?ztE0b1QjdKKDLMH6VKUmEI757LPBa2KtoEramXYUdCNEHaN3AsD5endYdAT6?=
 =?us-ascii?Q?O1ss3DFLwOLYaOY7zHo6gevYxAByap5YQpAOPoqXYr6HqKSgf9kEVSGqggLc?=
 =?us-ascii?Q?gV78Absx5f43TLM6k2gBdJRpD6V+DSnRU88J716vdA74uqA6W2oqd8b0iFqD?=
 =?us-ascii?Q?R9hH7AMdB8Ak8fYCdIy46u1AxnLW3L2KwQSfc5ZxZXqjmsNcTkLzzJ+pRSFo?=
 =?us-ascii?Q?vYB7r0cvMnhDNTxCuHCQD8gJpjLXEnHm/m4/kH0shH2BTQNeSrlJU9scvWXc?=
 =?us-ascii?Q?ze/77uZQkDh/40SQI4zVP3nNywrCMoY2b6tqA85ETNTUwF9OzK8sDTRAdZfP?=
 =?us-ascii?Q?+KS9qUUjQTaSW7dUGItVj99RqP6XRm/jkZ9nMILq6ffNOhzpp8j/6PVwcXEg?=
 =?us-ascii?Q?X68u/pMWnalPkc+AkB5bVumgBgAe+E4EcLPCsEjScjbhAJnHpWtqpl0mtTSL?=
 =?us-ascii?Q?RKevJ7NICQJcSIM/rgR+yqnYCm0rBLlymrDXqbfZ2NUcCy3EhsKSf6fJoeu1?=
 =?us-ascii?Q?LCNAaCveO+LD/sgntkgrueYo3qNcnJx7S5VDah8zivpXe69uRFRSPV6ZrAv9?=
 =?us-ascii?Q?5icofOfho9ugUWjb+KlWlfXy1TS6pcx01sCXK80d4ZMUv2CPMQD2IdcEqWXD?=
 =?us-ascii?Q?/Qv572HzY99SwEh0NhtdSliplU6g9rSl3uOS7G9RXh7qnRJsy/eu5THeSRg1?=
 =?us-ascii?Q?zmXReAyhCsr7TQG6+OLwKmte+IJacdWudjTn1sVe/iYX0ZHbmrtNH/r0d9t/?=
 =?us-ascii?Q?ps6SdH3blU8/HKGeGYFWNIZOEXzVQzdyVBk0Ak2plS/N8izumTvvDfdRT/vY?=
 =?us-ascii?Q?A6+n3CzcCm1hYwGN1o4iOkUOz6noHRpChwoKkeo41YlDdZep7iU2NK4A9MWa?=
 =?us-ascii?Q?zf8fN3b+tF+w/6XZqtS4RtkaOvMo8tNlDrsZAnIyUJX+rAb0rKK+VysDdsXc?=
 =?us-ascii?Q?QRGu6HRRK8heGb+2JbaQEWCmXreOMwARA+3EnpvH5Jg30ogUhOonUDytptWQ?=
 =?us-ascii?Q?0onca4Qn8vlQq9AALSrN0QAtgkR5qS+Ig81WHEH019WU3ErTRNmPv8+DDmbm?=
 =?us-ascii?Q?b6174na76IFK6AP2/uOgjlQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4d388b-62dc-431e-0a8f-08dc078d86fd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:41.7626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lu/cK2QwXmTleHCyIQliIfwiP/cTG7EJc6SjqjqnLG53GZC6pVwYrKMdW03CpAZe1o0C+FhqGGpu02Q/Kgti/J8Wh2nqA14WrifmRx8OJg=
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

There is no necessity to search to the end of the bitmap. Limit the search
area as cluster_index + count.

Add cluster_end variable to avoid its calculation in a few places.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index ae524f1820..4470519656 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -182,13 +182,14 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
                         uint32_t bitmap_size, int64_t off, uint32_t count)
 {
     BDRVParallelsState *s = bs->opaque;
-    uint32_t cluster_index = host_cluster_index(s, off);
+    uint32_t cluster_end, cluster_index = host_cluster_index(s, off);
     unsigned long next_used;
-    if (cluster_index + count > bitmap_size) {
+    cluster_end = cluster_index + count;
+    if (cluster_end > bitmap_size) {
         return -E2BIG;
     }
-    next_used = find_next_bit(bitmap, bitmap_size, cluster_index);
-    if (next_used < cluster_index + count) {
+    next_used = find_next_bit(bitmap, cluster_end, cluster_index);
+    if (next_used < cluster_end) {
         return -EBUSY;
     }
     bitmap_set(bitmap, cluster_index, count);
-- 
2.40.1


