Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506A7CFA33
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:02:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScN-0005ft-CZ; Thu, 19 Oct 2023 08:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScJ-0005fR-VX; Thu, 19 Oct 2023 08:59:11 -0400
Received: from mail-vi1eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::703]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScH-0002f3-TW; Thu, 19 Oct 2023 08:59:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFs7OFLlDBfbzSImuFVmnCB4k4L5UyePAH8xCZN9RxK0AiPak7Pot6yXRAM9nrsK95ssFvyMey1Vw0wu9W4dDSkIIxSU8TPWNlhp4y/fdvKTfs1FenyDeVttMNBXb8BuXKTfRsqq61ng6TV8ew0iNdIcHRMaqDeuX4Bev7jK7a5FfkEY+oD/sMHuuMo412AQYPCm88Yo0WOvE755hRe5DzbGrA2ex4qH2vHCqQ3khevs873tN/vAIbM0PAiA9Zop+d8A+qU+Wwax9H7CK2ariWuYiBBsHrm/HAxaNmzGc0yKXM7D/df/gH+/++3RE2mIQ84T9kcMFtUChJoWMxAy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfQacRtA+dxtvKqlu6oakpPJG5E5HyZ5RmdNS2Y8cKU=;
 b=eRmdfATOVX2MvuGgZk5GMZk3mppnaBp2G2YtGzxZwg+Fgf4mc1Tn6OxM6zzcnbCN+qen340GMeWryUNR17fMeSoNYRr84hDFPY2WMSSl6PPJCOCLSG8YBpUk55wAZvRSy9NNUABddNXMO7wJEXTST/M4umvKVNdtJm/Ro8QkqSPzEffv3Itt2DieYjYwW2180H5ay+/Z5Sol/CvtBiypFKgJBpXw56WsZXQeC4x1IuNzM1nSWyDQveqUTryAI6LKCDcvff5Ws4ri+OYAhwBvloZoXfG2nxO8TAv87Ea/EXV4FfRZnWapSkRz6IjKP0aouvD2RpACWiTen1o8oqobLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfQacRtA+dxtvKqlu6oakpPJG5E5HyZ5RmdNS2Y8cKU=;
 b=eDeyafSMqeg6gGjHHOC7haMGpxQNHNG3KGzbl+kfEoEwZpKdd66eCsw7UiObJOYLa6rWMQBO+1u0i4QjDaxKvx3WwATrRJ+93YFY1iYPpYxoWBSyko0HT/gj+SNtfgkJELxOswb4Sws2KQfGIujsu+GA/38vuoOVY9pXwtV69K0MLM+SU/T1RYJincw2fkxINFUFD3v+gUQ3KmRFzmW+KK+JXlnHgY+BvWVzojyf7tLAbaVWSn/BqM8Y47BIv+PDMbL4SduemoBRad4jQbogPouxGtKZ7k3O0BohnEztzm5tvfk0x+kHWGqsgymLWYcRXm5fk184G2OHG3rMLnTHZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:05 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:05 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 02/20] parallels: Move inactivation code to a separate
 function
Date: Thu, 19 Oct 2023 14:58:36 +0200
Message-Id: <20231019125854.390385-3-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: dd3eb9a0-963b-45c9-1cb7-08dbd0a32c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4tSevXXGYYSU6e+fW0B/SgtFAiFrqUkj0Eaiou40h3BagBIXg5D/MLnlXNzs0SqDUaZ0QuOEDhpI/ZDmoUvUt39WqMwgSlNsJssWZ87ZrotGopfgOi3L479OQQe8s0m1mrVitcBBUE/np6re7KVrC39uc1Mm6xmobDXQNRQu2QaqlRDHYHs0X8rjAVz/eDjVplWKdcISpkSrMw9b0SEcf93FG5XBQahXwIaH9ufWYz0vL91t6yPL6Di+4kloWIwgu8dqJHRbD6ApDx5RHp3Tak0hwvTMCn3Q5kD7HrTSCxXAPZ0nLi52THQfpdf1DDlHS+/E8rSdopLG9BvqE181WpmCwA3ZTwKSrDVtQCWpjX+n+MHm5fKkRnd1BVqD8YQkO2lhoE/gL3hnz+JlCc4zpX/RMGDOfXKsm2ygQvKJY2L+w6gf8qXi18uwycTKNDfnDjjQlVzkOli5nq52eqRVJklkBxI99R4M1WisQYVxyM4e/tVwfhGopC8wBskmqVQ235quGw3UZRLLEI3W8VzkC9Gdnk8+tgBH/+o+64VWwYup/tZyAuYaw2gC89bk7d+bVThT+jCzcfArEXET/qNdWZP9u1J6drWXPStaExAEX70CBabepQx6FEon/xO4Nuu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y6Dx1QuVH6K1qplxe7RpPudxKBRsbLTQsdERx/2/0bx6Z77ROwDd8Vw+XOKI?=
 =?us-ascii?Q?Qo6Qgy6qXKqudiHyE2zediatHlFo9X3lQMUtIcSaHTAd7r//Wxm/SmeCiaIT?=
 =?us-ascii?Q?PAyrAYTAC5C3AxlaClpDEM29vvQBLPaNLuQHMYcEjnWg635V7WIKpz5CEboF?=
 =?us-ascii?Q?h5aiXpBAGEFuHXItKU6e9dkErn8lceNn2GDKygcpZXhzfY5OGo9w/IuLKcIJ?=
 =?us-ascii?Q?LEHBqsIETJ9ZhyJo1DqkU5ggiQCb/9F5XVpHFke7ezaA4t4pFbowRkeXvXg4?=
 =?us-ascii?Q?uKFhF74nr6FC5yZufVWV3tBh9m0VkuIdyrgT/0gd7p5SVvqctqHB61qOuL+8?=
 =?us-ascii?Q?K2XGeqA7g07FMrwlEMjoto3sbkbtguH2pKn7HV/4ku15INhU5rDLqsCQfWsR?=
 =?us-ascii?Q?gbDoXEjIB4+ODyAoNQ0YbUknnVeb4CSkwgpxGlj7gcjtNkIgcpEzeuCpayZb?=
 =?us-ascii?Q?IEpv9OjOTuwnk+iLmjh5Isu4abHJdcN1C+0pdODfw4NNFYNCmXsWGarcm63f?=
 =?us-ascii?Q?NxnMj/PXjgIdQ78jxYoJkKp7Nx7F9rwYaMylcsw6RwQ0YE8E3m3c97raaysQ?=
 =?us-ascii?Q?0GhYjWlUS+uCC40nUtcql9kfF1QyWcL9M1eDGxPtffQNI2pdNd7bISUjqzHs?=
 =?us-ascii?Q?rMgv0sjh4pLm7XYSXRuef+w/d3Fg7caCGbTxh69LcKCejR2pgFdNIbYt+7TJ?=
 =?us-ascii?Q?GFTAeHMslspPgen++U3arfyfU5aOHhtKU6HnSgOpe2pAbm2jAO+o/9c8tOXE?=
 =?us-ascii?Q?n0g+6jttDlDvuc+0/RayuTHn09qqPjEtviagB51ohJe753iacscxdk/eR9CE?=
 =?us-ascii?Q?4l3/TDz81hja5FIpuK0hRRlrbOVOMTBPzEz9bk3+2X+6qHtuRob/uPHzts8z?=
 =?us-ascii?Q?AI511F5qELweInAk/iVYCmVmCHPH6XuikF7+k0ax0vtgA8yhZrCOOY37UWP2?=
 =?us-ascii?Q?mAUxDB2oGN6yTVDHf+YM+M5KvKJNR0njXp6I3irvTmAJ9lpRmCWGV9A5UScK?=
 =?us-ascii?Q?6MDWAf/tgk1RjHP3kOxTs/Fk+4C2VStRxdqHL2ExnPOnzuvyK7wGLxAf+PvD?=
 =?us-ascii?Q?HEDgSyjaCE+Mx+7lhN4ozZsq92ekPySoCd+iVq0MZigM9gHxaDZnzcWt5D84?=
 =?us-ascii?Q?vwqnQw2yNLfvuH0J/GZp4qRqBOu28ZHecXdRw+SHG8m6xn3Cjgc1vm0bXeMf?=
 =?us-ascii?Q?EceI1D1uhaqFcUgxp/isiBX4F2PnU25guGEKDvTjJvWblPpWUFF5/ULVsiJA?=
 =?us-ascii?Q?Dy2tIdWxv8tYWFllRYnUKIJPWKLEDbaZbRYy/eEUFTdEDOEh5eDBh/4R7Bcr?=
 =?us-ascii?Q?gDAo0MEZdkPaZ6Ec3gwbBtCB0n261njOUQFdw0gRHO6Xw6eOi7FijwB1zfmT?=
 =?us-ascii?Q?5QhFGJSumU/gktzWnuhzlHvE38+P9my7An8VVoonk6N3zuROnlVJgVWywEXU?=
 =?us-ascii?Q?B5dINiaEJk55UvnFkcdFWlOVEvebPNVbnz2MkpQOFw7Lem9nICd3jkDFe84Q?=
 =?us-ascii?Q?CF6hc/mKqHyD+IO6+l7uo+ib+VtNZyT84IkLunSJqH8zrltZPrMST+1EsWVU?=
 =?us-ascii?Q?ZN7/qK61kjZVTYoFMb21T9o4v8aFYJUIF+qPeZ10nWezsW8zW1v/4JTt9xjy?=
 =?us-ascii?Q?IEu9ppBdAPJ0MS8i65QxFPE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3eb9a0-963b-45c9-1cb7-08dbd0a32c82
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:04.9714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VytNPPTsY3mnNFIKvwLpsrodxJrJuI6AuUYlFErOypbLz4CDHI4aOB84nYuLum1xxU5Mduk4KR7gNyF4oZ3iN43fP8Qb/RhpntRRdrY/sKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:fe0e::703;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

We are going to add parallels image extensions storage and need a separate
function for inactivation code.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index ba1fdde259..7eb92f87ab 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1430,18 +1430,27 @@ fail:
     return ret;
 }
 
+static int parallels_inactivate(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int ret;
+
+    s->header->inuse = 0;
+    parallels_update_header(bs);
+
+    /* errors are ignored, so we might as well pass exact=true */
+    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
+                        PREALLOC_MODE_OFF, 0, NULL);
+
+    return ret;
+}
 
 static void parallels_close(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
 
     if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
-        s->header->inuse = 0;
-        parallels_update_header(bs);
-
-        /* errors are ignored, so we might as well pass exact=true */
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                      PREALLOC_MODE_OFF, 0, NULL);
+        parallels_inactivate(bs);
     }
 
     parallels_free_used_bitmap(bs);
@@ -1481,6 +1490,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_check              = parallels_co_check,
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
+    .bdrv_inactivate            = parallels_inactivate,
 };
 
 static void bdrv_parallels_init(void)
-- 
2.34.1


