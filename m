Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E567D9043
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:48:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZa-00089W-Os; Fri, 27 Oct 2023 03:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYs-0007IU-Px; Fri, 27 Oct 2023 03:47:23 -0400
Received: from mail-db5eur02on20701.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::701]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYm-0003ya-Rk; Fri, 27 Oct 2023 03:47:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE1EhhBzgWdGN9vSOHOggf7RgimCEQKX3ZJB6ctXe+wknqkylZTUacRedIonzK39asT8jI5EAccj7BcsOfIFRuZxABNkCGMieHYo9q4CasL4v+bqt1tXTQf7Cuput2az/QMCB3JGLaaohuwDQi52Iyo1QwUqHRWpMAPgta++u+/L08yBhMqhBSV2U9AhdljXY3YOtYCgVzKO/MvE8a/XtyzI4X3DEAWBan2gyzX2Gjyu+3TBs6BKSYscQh2Y/lDRpi5FyyxLiX5g1tZV3ugEv44qDOkg/m+r6GDB0gFWvyfYrTphs/T6cSWjSFW+noeh0Aot7DGHbG5BJFWgXnRnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAHDWvdr+vYn61+Lo68SnuBI28aNWSrUGFbEi5BAGTs=;
 b=Qb2hfWU3AGgERHseBxJuEKxT/6XJiPmdfUD5AKtf7/YpVsqZ7OShMo+rhxH4bM/xkx//bP6wiuAt3j3xZ5KUwIuh35V0ZBlBDdqBScfVut7/Ypcj0qTfypgzVx4hUMclwvmyZ9vLnVx77LBtKcySXsULbEXYAQobMUskqd673mdp4zoHGylZJBnR14iIL3//mPAauKIl86grP7Skn9qaqQLatpYt3ERteguwR1L3FKz/y4R2H9ImWBBNuKLvS0pmUIbPQiMdkhBmMlPhY0RSDz+x1bIC+Hmoi1WSP4yQzCDBtW25/A5La/QVl88vDPzp6E9N7s0t0yeXZsxk3tZQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAHDWvdr+vYn61+Lo68SnuBI28aNWSrUGFbEi5BAGTs=;
 b=UX0LK3W5ojmMzlCCQnPtbFn4Q4TynhLVzdD4bf5+iuq8X6wXv614W2znRxUImYt6uhZhhPIQKE3n5r5U14qpsoWi+ugn32FAdmPgTrTtE6KNct2fCAhtHVTIxCl3YDfsA2wJU3kxUd9D+qlaR5kks/gq3rLsOHSRzMDBxXHWpc4gPPd6qg5TINsQf2AYj/JAJBL49aC6iXOW0glEOu+HjEqnpS6pRd0Vzrx0ObfrGG74lO2PpTcArhc/Alown6RVxmShSVc3IjwI76JPSY3XZNWNCagWTY+KbOgZ8vMrd4d8gUXk1is2I4Yszzq5Un3fu3I58tMIy3ECoD7B1vvjXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:49 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:49 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 11/21] parallels: Mark parallels_inactivate GRAPH_RDLOCK,
 guard parallels_close
Date: Fri, 27 Oct 2023 09:46:26 +0200
Message-Id: <20231027074636.430139-12-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a45db872-1644-4507-e1a1-08dbd6c0df3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTeFNdI6Kki3Vl1rsqELRP6lr57eL3TavmK/S4ByYOmXnSFCVj2KiYnulMVUdbWQfqOpbo87nLO4mx6vXqHfXaYjjRTxUqMo1LXttcEhSNgYYglgVeww+7XkSXxeBtTLiRiiaJEHq7d0MLBiRNX+AqozrJQcJ8AszCqL7aQRhrySCa+1LYsF0vQfIbA6snAeKSQCKzeHV2ymKR7mEz0ljfEN44Dvv5MVryMAO7fdOpWLEK3ntTjiNDDt8A5fCNuEFQqWQhxIRwkJeWcd7JsoptUmRgIymwjiQaZMyYhUH9VldCqqFhuldEYd2J1c/I4mZZmqfQENUhz7ZIAeml/8hQQqKsbo8N+HURlaZyqJN8qy1Kiwow2lgm+K4aLVkwDj3JZ7Z7AqJjdprC96p9S2Ai90zYqHXfVqDOop4y9kXNsvIpYSaXSAsi+IlmBNbZVPB2M4mtQX1yO5wvixFGh1INx51Z12hqsNld5JXJsGPdIgihBgay6UsQ2zNBAmVsATt9QAP5S7gMVlaGJhJZWzkl2mmvbYF+Q/pgVdvqAVdFB9ZtPqJWEPeYIsAMkjv8u4zP+GhNbjOEYb9jOJA34W6Bta28u42JVkFgnGvL1237NQGPj9RPxpnJfs+CtQyBKd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JhH7eyC4cOQc99RsgBe/34nctl/UUIhW1Lq2mf2kuUhNbRWknmo5LZK2dnTh?=
 =?us-ascii?Q?Y6tJn36NwYFUx1XhuonF+HKEJfMwu/nnY2BMeyGAMTImZpQgGbypn2X/DA1z?=
 =?us-ascii?Q?TboTROzXc9n0eovYzkkzT3qvIyrwCbjLpc4QqL38Bq2RibXP0HtXpptXLA0x?=
 =?us-ascii?Q?v2fHMWlobm1Qne88FSZyKlJF70GuxQ2UTZThiqR/2w0SC/XKpIWpFqMi0HrS?=
 =?us-ascii?Q?IJgqXRxjKftKSstfnT+8bw74J7VSnSlBz7Sc9ay2GuAfMpqbw/5XPZ3J3IEU?=
 =?us-ascii?Q?HyP3p8+QSJ08sA85DQvwlAaIVI2E39/HG5WFvWtmy872hhIGC/E+Pf/x8Iw9?=
 =?us-ascii?Q?fZ9+zkb2TZUSLZyF/xZa5f+CJa9ig9XSjchFzfpzUDRdDnWj5GIeSMPcy7BN?=
 =?us-ascii?Q?wgulFY0CJPrXXDvkqXpnrUxOlFg/mDvt0juezX56zofz8X1p+LbnQqnDXEBG?=
 =?us-ascii?Q?5r+y5EB6RxFMJoHcqBhUBHYlkmxxl1NTAO0XUmsniFAGX6sBgdcZpOhNvYgW?=
 =?us-ascii?Q?ReASF1z8ml4X+MKDQiH1bGm+YLMOTUxKT5wUh693iYYJvdzAvIJOHigXUgCQ?=
 =?us-ascii?Q?rSTn3xK10bKKqmPbt6y08hAYIkyIC2fYnMQtoQLoK1RE4bZYkomsWkDRBC+Z?=
 =?us-ascii?Q?1CQpmGnwhf1J18SNgABw9bGvRnMMJzmqeIp7H6XdVuaqpWK9rRdxQqVbXoN3?=
 =?us-ascii?Q?PHoezV/ogjOyinEUku3+Y2eo5RLM5DzZNgG7UOiArhUyQrG9+AEfPxBQZYEF?=
 =?us-ascii?Q?W+OWWJnoQaoTSQ0EXiER11Hxa78vJpnv26ISR0nesbAqCx4Fsq9kqAfe1Uqc?=
 =?us-ascii?Q?VjgmT8QMTB3/EQKzuEo7mMYg6ZFeAlRxffj4opPvmCp13/+DOAjW8jR9E9DY?=
 =?us-ascii?Q?Qn84U1O0N3fU+VU5ZNZ0MU0EGZSek6Ha8Cp7bslP0pfmzKlT4+zIe+NmwolQ?=
 =?us-ascii?Q?WlXXwdL3XyW/oeMLohkqzEsVVF1yHb4rJ6R6CLkq/4hW+gfOgCyhxWLAuVUF?=
 =?us-ascii?Q?5Fi3PtwK6x4zm6H39+IqZa8YrE4vI4lOAgcVWG/4Zd/p9mciPx6DP/XD7DUI?=
 =?us-ascii?Q?vnG1Se/uJ5YrL77n6afhu+LkesVBB94eiJ2kw5ON7kCnZjoNY5JbBdduSyU2?=
 =?us-ascii?Q?9m1xqwfusaILCVRostjRqa1wbCFeUKoexpJSwcWZXtVcOzPgaPiYYni0fa/2?=
 =?us-ascii?Q?UQLUNDre47/DHhNIfT3JtzlaU6PMLlTC3fScy9h+nV6T8xUKm7bC6U6W95w+?=
 =?us-ascii?Q?09jtf71VO0tsspv8jaZAbPCp2iB5d0NDAMf7MJlHhXLTdxORLNCHM/T0AI2S?=
 =?us-ascii?Q?A6x0O6qs2F234w2kBT5WED+3gBCgK2Jlw388TK/FUGIXvKthjt1wFyqyYPTy?=
 =?us-ascii?Q?grIf7lnoh0TekoH7FSg41+eVzGUqbSK+uOKwmn8bqaBCCJ9RttYLGkIPNtQs?=
 =?us-ascii?Q?ph6UmsniKEnV0cTu8JRPW2yCyZ4AJ+602LRKbOCEpFpWiok5HVds3HxBK1n4?=
 =?us-ascii?Q?lzjAxo4NTKI0uiSpi6EPuFYDlOhhrpSNPr8Ptie7IY/EnsyrUHTIOzdGlozu?=
 =?us-ascii?Q?pseTFepC+srTp+KtDcWlQBDCxhD19udwFxWgWV7SCOZLiib75m3qKoKzBjp6?=
 =?us-ascii?Q?0sVHHC2CQ7q21DphzMpP9+0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45db872-1644-4507-e1a1-08dbd6c0df3f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:47.1594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 329YaaEQwD18kYybLKmv1tySwLrJuoIl6b4arVIBTApx96Sb8EyTsXeWuo8qb+eKlI5+2O5s38cfZ9FoeupB8DWjloyqiK3Den4iXqdrpH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::701;
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

Add GRAPH_RDLOCK annotation to declare parallels_inactivate() have to hold
a reader lock for the graph because it calls
bdrv_get_device_or_node_name(), which accesses the parents list of a node.

Assert we are in the main thread in parallels_close() and guard the code
with GRAPH_RDLOCK_GUARD_MAINLOOP().

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 2d82e8ff6a..4c2cb09e43 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1465,7 +1465,7 @@ fail:
     return ret;
 }
 
-static int parallels_inactivate(BlockDriverState *bs)
+static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
     Error *err = NULL;
@@ -1491,10 +1491,13 @@ static int parallels_inactivate(BlockDriverState *bs)
     return ret;
 }
 
-static void parallels_close(BlockDriverState *bs)
+static void GRAPH_UNLOCKED parallels_close(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
         parallels_inactivate(bs);
     }
-- 
2.34.1


