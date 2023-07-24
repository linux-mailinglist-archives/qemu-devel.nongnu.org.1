Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3C875F92C
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 16:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNw6i-0000rY-92; Mon, 24 Jul 2023 10:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qNqFg-0004Yl-JZ; Mon, 24 Jul 2023 03:45:08 -0400
Received: from [2406:e500:4420:2::628]
 (helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qNqFe-000142-Ex; Mon, 24 Jul 2023 03:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9/xYR6Tzdt2yXS279cgJl9akZFfUWR0HKbkR3xU2pa30gEhGpNV4qo3PX052c8xS1ZHuZ9yMeKVWoZYPNwUm5gFfqZkrltlDt85dyKF5QgjlFHS76tArDVRhdoPkvFGdhVnbwM4xkclJLiQ8T+x6JFvKDVMv/e4JA41tm985Ytxv0BIkswc/I1uIzbxmQ7tgzPWQ/7nSHD6V0Y+GpRtSgHO72Q4wiLdROXNCNT3KrUZM6ZQo/7IzpCNCpWeIAWg3MAP6C4eNElnk4WGIprWhkkYFba7fa//zTCRmD70XdRxJz6OWNzPMisEbtimEBujFykaEqLziaVKPlwGgIjd9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7Kg3gYROpMBI46Er87/LWC0w5v9gcnxAJeWClg0BdU=;
 b=XAYsvrFCp54PKHbzBjASmn3STkEUUosAp4LJT2n8l8qLaxApOu3DNH3m59cQCpsIEFEGbdIO7E/Ai86yF/QkR5LpC45+LGZPwThQkPo9izpQKh9+DcmBDgOBWDycNhA9yzOlEzNwtczLd7ML+FuAeUy4G+xwOmko00H/3jkF6zkhdSBeUqxYh5gaH07+wENybUarisrwWCoUGDpJ8k5PSIoK/osouItkbVjMIAns9nra2yQ47/1evMJv1GYnaz3nEAwSmpmUxcmzdaiRcBYVrf/grgYOgYHbPYUI/jVVITVBml9DBRUncfafpluUzlKN4UnnHY742T3l0rELjC5QNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=archeros.com; dmarc=pass action=none header.from=archeros.com;
 dkim=pass header.d=archeros.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=archeros.com;
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13) by ZQ0PR01MB1110.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:30:19 +0000
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 ([fe80::801d:e216:d86d:2c4d]) by
 ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn ([fe80::801d:e216:d86d:2c4d%4])
 with mapi id 15.20.6609.026; Mon, 24 Jul 2023 07:30:19 +0000
From: Evanzhang <Evanzhang@archeros.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com, Evanzhang <Evanzhang@archeros.com>
Subject: [PATCH v1] block/stream:add flush l2_table_cache,
 ensure data integrity
Date: Mon, 24 Jul 2023 15:30:04 +0800
Message-Id: <bce1328c87f7e5d877dead476e9e66036cc4f7d8.1690166344.git.Evanzhang@archeros.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1690166344.git.Evanzhang@archeros.com>
References: <cover.1690166344.git.Evanzhang@archeros.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::20) To ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1015:EE_|ZQ0PR01MB1110:EE_
X-MS-Office365-Filtering-Correlation-Id: 4853937a-3170-463f-e8d5-08db8c17d589
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/5tcy5iWizqLr1AuFVIJJL+7LqA66piZyp4vCyYiwkfIkaYh5KG5HGy5MvWIuJFp0FN7qhXKNpaBA0b/6Wc+SgRVQmP+D9/VxXmm0r/jTsDyd0QUS8lFFw1QiQ+WEXfbOela99+kszQJy26ddXk2ARQLgP1XRJD1JlccJAlJY97RIzv0zeMYv0515a6Q9qzhoecMMW5x7yiaa6PJlTln55pgqrhQclp/vC54ws7AVOh0qa3B4b3v2Ft/nDoXCErV/2RjJoDol14YCU6fmFHvxXyl3lVWnSJf3c3JlVVG1IybLUQG47EPLzz8EGR30BnyXSIu6cg46xo0q7rMyu1kDtZIdkWBpg8h9NhgRvrLi1VpCjLMDvIHx3nCIeVuN7k6aqajFxZOO5C/PJCOHw2j0lf1kSVvgS6nhNEHl6FjiUWI8TX4BvTzgNaBkt342llzv7SUwYurs2RbAqud//CnhvXyVy5PclXBSfzITsJ6McMYDYhy75v7g0aw4KW+MmPXEnZ8kwhXYZCuNjdG4AF8ZquICsOkcNYeStDhz1LsS3Y1ytMbnIy3hS9K8lpcMOr63noQd0t+9SytBC6rOJZ8vNYU9a3B9Qoe1vqLKi2s6i9zHhGUzVsrLpZHgUpgzQ2r4vsweiZXfFuctIfbO6x/qFon8IFiY+nkdm0eCVPnVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(39830400003)(366004)(451199021)(83380400001)(2616005)(41300700001)(8676002)(8936002)(5660300002)(6666004)(52116002)(508600001)(107886003)(66476007)(66946007)(66556008)(4326008)(41320700001)(186003)(40180700001)(4744005)(86362001)(38100700002)(38350700002)(26005)(2906002)(40160700002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FhzNB/s46fPJRSddu7dnXPNxwKmzPM+EcaXMLFWZ0zDxIQvQewGKLM0fFwfE?=
 =?us-ascii?Q?xMEeW0Zv4zTUxxwmApsKnXUnoVUl4uoAXaJK3GobSRDOmycHILGOgec1JXJm?=
 =?us-ascii?Q?z7x1AA1/TbfauBhpFAac8Zp5EYiaAVQVmkP66nFnB5SJr1O3BXQL2DGf/2eN?=
 =?us-ascii?Q?DAqEtdiI8AuJzU9CY1clkuLzigUpKQ0JfEsUM2HnIA6K2WRK0C+w2yAAWAGn?=
 =?us-ascii?Q?PzZM+OHHIoPQBhdp933hHfGWKM3XoUBnUv7r9RFlWpGGRqaGGoZHrv4mT5DJ?=
 =?us-ascii?Q?cKqp9wdcZHrQPu+hQzzhDccJtwZMXXvDCAw+B9nKzKhiQeR/rYlx1+RzfSLU?=
 =?us-ascii?Q?sL3biJ3k/gDtnnI2xpS7RurzHt++JPDuv6dXVX3bEnojlv9+gRxs+Ht2j0ln?=
 =?us-ascii?Q?/9CVUqpsen8ek+xenxbYkCluuZtJAzCSZAeLftvIHjX8q3zRHYa5uCz8qmId?=
 =?us-ascii?Q?Z6A225d7t2qEy4CmVYmPjlWd6T2nav6HjMJR1HWFzjT/n+YcxGwnjOeyDfhU?=
 =?us-ascii?Q?C7Oyi85mgsYNSqazAdUxFKIphLZCoRUEEEDqnVMy3sXWBClukOhQDSdoKdHs?=
 =?us-ascii?Q?gvZgL3HaAuJmDDFHmH0sbMGWHkPtwWKehH+rlQqIGGYEXv3+hUBBpO+JsjJc?=
 =?us-ascii?Q?vmSKGXpwWajPlRUqS9wYm31BVHl0/p8MSUuuF8h1rApN7Sdmf0kskFnvlT8S?=
 =?us-ascii?Q?n+9kr6gRjDm/EjlVCLBdR3VrKKLA+rFgNbPO8ADQdrmjS/urVCUVZoNrSfnA?=
 =?us-ascii?Q?fijNDMmH4fkuPHrtI9W6AygowqBxhO6NU0q550L54F9ZAxqIecYEL+N6PPVj?=
 =?us-ascii?Q?6aqYLqYSA3VAAmhj5rLb+Kfa8QQJZXbWoKvIyt+feCxJIee1KA4uQu877kNU?=
 =?us-ascii?Q?+MRaqjdS2BqB02Ayc37XnFi53eiDdv+qb0GnPeFcZxDc9Kbt0T+LP7SgZQzs?=
 =?us-ascii?Q?EPTHwLpNrHE5qr118iDduYMgHx4m18JwnFhghR2vR1v+LZYgegEn/LygMXkn?=
 =?us-ascii?Q?c6QtCsbI+YdWsZPvNmM8Q5QzikGfbJH5OhA9kO//zq09+MtpckFQZl2MhFow?=
 =?us-ascii?Q?jydDVnajuJUV9RY5hHcaEP+RP0XsIFtPLr1EMAee3s68G7++tw0kHSsSTXqr?=
 =?us-ascii?Q?QdWeqft/ukXU+HoB1L+gMCN2Hj+LglvYBgF/WXlDqMgcj2BAg3DRQhwgSjxE?=
 =?us-ascii?Q?cUyIzQE0ogPt9O8Z94Cdj033GsvCYZejzuOcP2PSVN+SWVp8y5mHQEdTRAy/?=
 =?us-ascii?Q?z8wVPi3Lynr+4J38dn7WUv9gMQen7M6p80aOn8Gl8KAb5BtBTj1NAZ7zkSQj?=
 =?us-ascii?Q?8TF9tBpKHBz7CLWc6jtZbId/4emcSWEn2dTC88WI2fzxpxMvtbQcIE8yabVR?=
 =?us-ascii?Q?D7MGElJhE+KiFgdbA5cHhC0hvzAORD8lkCltxiIIPU6iV4FmQ9NY07CMC9Js?=
 =?us-ascii?Q?xCniHfKpi/q9p9vhV48tUBhaz9IlLSSttz01GV/Be/VYTcOIZLZbQLggdpEy?=
 =?us-ascii?Q?UCAMppQV4QYppvrO5JF1703Y60pJFyd9rVgXySlFp/wofIVllFcSJkKbXLM+?=
 =?us-ascii?Q?jaakHzgCfjBF0rmmeEczFmt53XmwsTEfy9UP4mc7kYtwwZSWCWLUzi0x489B?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: archeros.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4853937a-3170-463f-e8d5-08db8c17d589
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:30:19.9054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8387253c-f44a-4a28-8058-3e5c20af6b4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOP2vuCOzxzxQZy0fvSl6YXX6Azv+KNtw9nqFsH56Me5e8HBN6RzH/XwocXs0qGdLaxZ+t73GXKFW24SlFJcag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1110
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2406:e500:4420:2::628
 (failed)
Received-SPF: pass client-ip=2406:e500:4420:2::628;
 envelope-from=Evanzhang@archeros.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, PDS_HP_HELO_NORDNS=0.001,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Jul 2023 10:00:13 -0400
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

block_stream will not actively flush l2_table_cache,when qemu
process exception exit,causing disk data loss

Signed-off-by: Evanzhang <Evanzhang@archeros.com>
---
 block/stream.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/stream.c b/block/stream.c
index e522bbd..a5e08da 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -207,6 +207,12 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
     }
 
+    /*
+     * Complete stream_populate,force flush l2_table_cache,to
+     * avoid unexpected termination of process, l2_table loss
+     */
+    qcow2_cache_flush(bs, ((BDRVQcow2State *)bs->opaque)->l2_table_cache);
+
     /* Do not remove the backing file if an error was there but ignored. */
     return error;
 }
-- 
2.9.5


