Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AC481F677
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:46:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuK-0008Hq-4C; Thu, 28 Dec 2023 04:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuC-0008DU-8V; Thu, 28 Dec 2023 04:42:21 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuA-0008HI-09; Thu, 28 Dec 2023 04:42:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFQTlE+c8PgyCsauSBDOyFVOjiSGYAH812kqsQCsWblYx4NNnTCIbKsTSX38eNfDD6YRAyMyJLmyaDIFp8Xr0kEakdV8PpezfUx9MT/zFEh7F3APn1IO1MjLQKfwOUy3Nu4eV1iGtJ6nR7DMUZ3Ht8BznWaMmBrtOj34N8Fx0mb6270n4pyxLCRQUzHRc/Jmg8+AW0EtspSPWpGvkWby2BlmudlXFPh6q1kBQKn+PeZxO6clpwHVz+f18AQHcvhgTOq3SQUH6vQfHPOo1sjI4k72DYtedz3/q3yeGGlMJBCiwpx3Byfn8H/1CZ6Dlp9IP4uMQ6JqsNpmGebVb9/FOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtRIfsa8yMATIzeAlVqe/ZKQZpRciBlgyBwsHIDo9M8=;
 b=bwbhr0d2qYfZ47/d27PZ7Jn+L4VUy6SQ9DQxmI9YPPncVsGYlTXw8RLF6z8Y33/ZkLabHgSZ0K4T+++unR9UJEutOp9BUvHzJba0VvLAisVEZlvqZdBx0VFepm7wZtcw3yZB2GX9o8hzaag+B+m1U/UG21z1GA5R+lCA9AVYFTMY1Xhkihgv93yFAnrC4CzmvX9h5iIV7jLQQDLwk90nJBtD58zBMEVaKS+/Hs5RJ4RL8POZ34OUm9Z3XBFHa8FRxWLKqMp2X0MEKPSBbbkrAoDUG4rMCKUVv3lp82emBtS3Cv0Q2GVvYV9xz5TbwE0IkC1zMI3HXjBt+8zSQhnOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtRIfsa8yMATIzeAlVqe/ZKQZpRciBlgyBwsHIDo9M8=;
 b=YSy/llwRrzch4/xw5YQaBPGr1r0JeJpZNGzWRXOk2n/a7W/XPMXhQe8f4UQq8veeCi9omUeerzSP1r4Uhh3IBu4Y6dbWfKb9frqCyGIO5JGw3RawFzzoYfaBBVIbbRhk5+79pAxnIACOfKVnJDI/zLW0xBYKEgrdsv8GFt9WcfeKIYoPeRnoNJoi/Q+1sfYeTY8hzLZSEoUHaVOItAzZbcTnoKOmm9RUUAEOj7wvsyhR6Y2Le/1wDes6YUsYSebfNSkZubcH2DOX8X1Ma2XSOvIPm05WlcIQvltk/Hczh7//kLGFONe+/e5UKgrh/hhnSdeyak7JAaaPKXya3+WO0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:05 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:04 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 13/21] parallels: Handle L1 entries equal to one
Date: Thu, 28 Dec 2023 10:41:45 +0100
Message-Id: <20231228094153.370291-13-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 367fa2bc-1eea-401a-24d7-08dc07893fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6K9Olv/kJxrCalS6M9ojMoLyl1qIyIRkxnbF58d74EuTtdVj9OWctULMTPMrWn0rcj5B2geboJ/NM382viCkYgLzMH9/hub4DMeF4q1QWUP6ZNeWvTofI8W98CMfQsscdrHZpcbfTEEpjj239h9tBrnxT/juEbyFQpjGbCX/cp17Guyxd20F2ngMozj/tF2i+fReGViSUbLamyclAvbvE+oVakhL7wkwl/vgVXmJPurJnnzM0RPRY8L7nwRvgsk37NNvnN5mmkC861sRZvR5Yz34CiJjk1PUFSAteJGRVdlNYpLvaQaQjVbql3l8PB+1HFI5eLgYpMqxVPzyi9L+9kQN8U5PX/QJ9iT9E9Pj42gjx2JVeAwi4Y98M4FEP/vx4C6dctGsuacbMIsPx2PtIG8p/o/0j5ZyR595one0Dth+Z/qgve5VwcfZjzHFg259w7NoZStBCaFtgVgNeRd9CorK4U2llM00isRHon0GvTDYzRb3bLIn7JYTDnjuIa5RnGn6oylTG2pTh91wzoDvXZzuI2Tr5PiDPMsHvgeCUulPXHOVdh3nnXDVGca9CBbphKohOyU6UWnytjcQJuEtkU7qzf06d2xLuuo/QhoHCDUJGtG9VVnxSq4caAFCNETB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OjJGrjDofe3WP3UBnGqBiZQVigbl7+VbWcOpA1Ca8Reso2jKVT7Kt/H87QPF?=
 =?us-ascii?Q?ca3214PMH4Yxk3VuP5PKeqNZ63cMxScFoH3KIOyPRGUQcQg7tsez57qQjt7B?=
 =?us-ascii?Q?8ICF2QByaYIxGcFJE4J91Ys5vB144ZbxT90AWx19P0I6H2Bv1/miREmUjX3I?=
 =?us-ascii?Q?Ddl+G7/DbVv2SMudZCN/UN55fYBSk4mc1q4LP12jcv8r8qxTDXxaWf3+yei3?=
 =?us-ascii?Q?6YOW9JpIrNiWTALGf7VL83eHMH3y8Zrv3eZ8dKLIQL2cF1uuqGUrzqSP8iyf?=
 =?us-ascii?Q?OI8wFPxst9b5pZAwm3E8pMfuUALwOGdVCA8+Edk8sOhOdbijGPwoArYwcqTD?=
 =?us-ascii?Q?9475bvI7e09yB9Fgxs9X0wA3X0JWHotU2LifCObZcPZZtgO0Dm58xBXAPZUL?=
 =?us-ascii?Q?8eCFAqGpMlSbtaIT1v1jJoGTeuK8pZGrN17N6VVa9DSRNMRRDJXuu05Hyob3?=
 =?us-ascii?Q?MBuW6w6wWQJ9Qoshap8Z5odvpVd6SKO3lZzbP4ixOzf0xY+prRx4LZeDvYiI?=
 =?us-ascii?Q?H3ovDu85tdiBdfspOvjNrUHn9+YVoOvk25U9leT30zF2hMKtyBRz1Jd0PkHU?=
 =?us-ascii?Q?np+T9qGJmZp9FtlXvvV2UCVnnJUsMGqZNoE730803DggdojHQQyP7B8jwGd7?=
 =?us-ascii?Q?SjdrLpATIqW0NQM2iV3Pb+yZ9HfqRxOsHUDg+elN+SOi7FYCXYNQrvshgniO?=
 =?us-ascii?Q?Yint7RL4RV/D5MZJCyDFEUa3YtRYP8ibzen6UIlKfbQrDnMzjjYlR7Tu4AVv?=
 =?us-ascii?Q?SYGmQ4qiXHVzS07M7GpJYSo+5FrK6dQn82yKH8sQNJ4z2SKAnGCmRnbIU9Iv?=
 =?us-ascii?Q?HZ39GaPTQtSFkOxoQFS7Lhht9EFHfY0GeGi/eYXfiVnKkabANdgrs2ge/11T?=
 =?us-ascii?Q?ZQDinJWzSAScbup9e/oRLowMQXfeM0VRA56od/eBgtoVPPgwLjTOhAACj4+K?=
 =?us-ascii?Q?bVsA80VtWpUmbiIRq/aRhFImJQHCj7V9l3B0nBBXKZZCE/HLe1GuKYnbPP8c?=
 =?us-ascii?Q?U15SkQJKLosU/x1ORB5vU2REkSPmcszp1mc8UqiSbtZMJkC6WqQgFurYLaoq?=
 =?us-ascii?Q?BIz+s+g6ID8ZjMaQNP/gqf95ozwDTcCl+1GMuLYITej3b3HLzAbWL2fI6qqG?=
 =?us-ascii?Q?BYxhyK40BVVM/i2Hj682IS0Cq0IIYXXhlX+iJftldyc9ogzZXf+qgvllQPeZ?=
 =?us-ascii?Q?HjJxdPJ9cfAxq/JE+7R0KDsQtZNZ1v6GkQJKYgJI56nmsERyheS/XRXWPFxJ?=
 =?us-ascii?Q?Rqj+uk5KalIXe1yxRodxW2HbVwHSFayF/Qx0FqqszGsvqnEXD9FC7ysRE7C3?=
 =?us-ascii?Q?Hf7ppVJNqecp7ZjZtOqaIgNGwll8qHXWvs3QHgDJwYVh5mxBOdzpPhtbIkRF?=
 =?us-ascii?Q?0faiBzpL4wcCgtaFfRRhVOy0htano6BuVF4MGgLl2A+ue2LF5CFE9r63tHhl?=
 =?us-ascii?Q?O2nKVUizQxNTFM0Z+N112sCI1UeLgGhRAkotlt2PF5w5bgFp/nO8p4+sB2t6?=
 =?us-ascii?Q?av+7SL62KcWdpRD4EH+ZQo3BaJZiB5+kH3yBok8A2fhgWqzSckhZd4nGS3TX?=
 =?us-ascii?Q?lgKoumHyI8pDn6gOQtOkkyprCfpMxEtVl99irXeNunO/qjNCkrxHRYoDhokC?=
 =?us-ascii?Q?jFRoF8RRi3MIr2L5YGwKqXg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367fa2bc-1eea-401a-24d7-08dc07893fe8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:04.4946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fhisP2HrvKg7+XituHpPNE4zef8pAqnZc4mLf7Qw0uPSswf6FLcJFLbpxkfIgMxMI5rmcuyha490k7is8aN8DcfQIL/1aZMwAgVsmeQA1o=
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

If all the bits in a dirty bitmap cluster are ones, the cluster shouldn't
be written. Instead the corresponding L1 entry should be set to 1.

Check if all bits in a memory region are ones and set 1 to L1 entries
corresponding clusters filled with ones.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 195b01b109..033ca3ec3a 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -354,7 +354,7 @@ static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
     offset = 0;
     while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_size)) >= 0) {
         uint64_t idx = offset / limit;
-        int64_t cluster_off, end, write_size;
+        int64_t cluster_off, end, write_size, first_zero;
 
         offset = QEMU_ALIGN_DOWN(offset, limit);
         end = MIN(bm_size, offset + limit);
@@ -367,6 +367,16 @@ static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
             memset(bm_buf + write_size, 0, s->cluster_size - write_size);
         }
 
+        first_zero = bdrv_dirty_bitmap_next_zero(bitmap, offset, bm_size);
+        if (first_zero < 0) {
+            goto end;
+        }
+        if (first_zero - offset >= s->cluster_size) {
+            l1_table[idx] = 1;
+            offset = end;
+            continue;
+        }
+
         cluster_off = parallels_allocate_host_clusters(bs, &alloc_size);
         if (cluster_off <= 0) {
             goto end;
-- 
2.40.1


