Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B88B57B4E79
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:02:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEl7-0001us-Vq; Mon, 02 Oct 2023 04:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkv-0001di-5G; Mon, 02 Oct 2023 04:58:21 -0400
Received: from mail-vi1eur02on20713.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::713]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEko-0003Qj-4c; Mon, 02 Oct 2023 04:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzNnFHHyT0dPPRVQwHmnQRW3AHazomMLFDJFJqHhqPvDsmbcQbU+obIc1OsqMG17il7Xr41yhbVohZByHYxal/1q1sg/zwtvltorWUzIJVn/tOHHQk9HCynuiLhqsR2JZj09+IJUZED9wrZ6Q4T7na+mMi5YCyIE8+XmDVPZ3y6fwL8UzpMNZeNfEcdMyw7fEYEOHc47SkDj1vN7QjbqQ3nNXDA3xquorm3h8veLNAUEjhqcPpvLSVGS5od2JmXJQbicb+D4Xn14th7kU2qGZRf7A4NAINBL6q6rc6EPZzZsov7Cm0t4OVsf3DemKj/vnTJcv280yggSUpZVACkx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97ukfm6vS/99N2d/mWr2AxWxYEsWR6QQMKlvpEE00Dg=;
 b=IMZqLr3MdYwHWQeGv3UCPHNRqB5r2N0o7Uu7yKPZmSMZ7qLR6nqDDV/5LMdzgSmp3Yd35UxtUkWvYIksFqB4b3GvtBqyQIAuZnAvm3k3j1WPEvfRL0QW7apZueZ06zYmYvQAK9SuXnaLAjmlnCu0dDcc3zROGJfCckYIqiY5DzfxaeACZAfCAgNboSzNsXqmB52Y7M1OGyTdDj1EhYz25HEZZ17+vvsuRs+VmSPaQg6KgK8q8xZ2xyqfMSpzqdJtXc9qftVcgwB8Z9FrhEsA4Eudv+YVv+YJCrVP9I6OJQTvSvSoyJafcJrBVOKyZ03IDnY+Gy8Ia2hN2QdlMas5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97ukfm6vS/99N2d/mWr2AxWxYEsWR6QQMKlvpEE00Dg=;
 b=RVh1GafRbkYvRbiPOWLBz+EOj+tM2yiTpAd0IIRBk2S3RH+UYolKFHi9+e+2vxBfG8qjGTHunJn4j9Ej6IoVJOFp35pkuAQH3EI0tBja8Y3h6zW64jEr/YVSiMABt9KXqcB3bDhe274Nf+eeox6ShDszSKCZyDvqpwJm2qYwOOH/nj2QhMf0w/tA+0w6oGDzSp/WSrgPfMZRJFF3+MuUbivONNxs2uRrg6BaAXBVtd+a/0DrEDV13HXTrOqxZeQiHvcRu7ofsZRhgnipWclF3ew7u0epgG0UGWmB0rlmFz6LPcDiX4ysfVzbKhlLRMZp7FvKLZ6pLP2qW4Ma98qjtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:58 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:58 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 12/19] parallels: Make a loaded dirty bitmap persistent
Date: Mon,  2 Oct 2023 10:57:31 +0200
Message-Id: <20231002085738.369684-13-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 165fa02b-5af6-4a79-57e6-08dbc325ac05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrI7pVp2zhL6JXpZwEp86TS9OJodJS0yCQ0y0f93mI3HvfS9Su9psQoUoR6vCIJ/Oh8oF6KOf6JS8xjbSf3hYjSUaffZC5xHukPNyHGvJDsvio9A88hLgk7BJ5lUaTs2vkQZQpqUHst+ZrqJYBU39CcXoAvpi4ZNqzM5NQvF+D5p/P1lQCBF1/SCN+BDEJqchDFOjmGRkeyVvnVH8lYcr46OVO5Ifj6+dH4DWDngKe8OyJTIt7lvYFAx3m8vPDzWWyJvHg+LFp7/CX4DO5Lpg9Dve8bUSWtp/xKq9RapbB+1BAhGgStd7UwkawRR9ERvH76HJEGUWQ3HdKa8XmUb4pL6KZ1EL7ify8FjQDyVRWE8QLQNNLN30QfZzVR+CoZEwyGCUPs9N91BSMtMI+Bh4dmWMGgCT+57C9U+tgbXK+TxayUJtFjNVGp0gJp3nQoj+FPz3p6gtfayBpnv78Fm9N+OWriyYxSumzZibxuM6MjKrx9C2S+BsH9gHI6u+PRulK0GG9DDdy9BqiyYQ7TLgrqfgIHCSNiF86zcVlIgriG+CCk9XOHxigp8UsTOxhBGdMa4G/ueL5kc70z0Y9Mi8oVeabHQBnWi0NXdEg4BDVDh9PfKlY5fVaDqN/XfyCg2zSvdD+Y2MxwV+CSqjzEsHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(4744005)(2906002)(5660300002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QGfknqDAP2lSH0a35hahfhN2eqxHzFLmY/eHd/QkXfJ45ilEeOXP8XH1+AAW?=
 =?us-ascii?Q?0TMp6tDW5EyikYLYycSJJpWZIwsd7QtvjoV4YV0lJkIGNXxGld6/4JGkJ1Hl?=
 =?us-ascii?Q?9Rzn8zZOuq2tJPXDgggP7dQQ/ll5vMT9ippiXhdGaU954MuK4J1uY7bd0LYN?=
 =?us-ascii?Q?LcHrKTukR05AOc0e4hqrEFWam+ZVviwhC18QXOt0KGE5V/UXteiEtQHWE4oQ?=
 =?us-ascii?Q?O8c0ykDji8YIpNFOtv/LpbdljUR89599DLmRrnIPkbOzG4qZe0TI6U1Zf9iE?=
 =?us-ascii?Q?jw+xoh1kcfwP0gP7b56d7N8ak6MzyIU9G3OZpJGsq3PYI65Y+GCVMFixHuTg?=
 =?us-ascii?Q?5FRbMcyWZncEfm85yMk2IMg1ei9MAfnWywxldpxHWLSYO4HD8RR4fx8evQGK?=
 =?us-ascii?Q?5pX19OpoDEQg2CfDZ8enFRYsUJ98nAWJlKdEDDPFt0fBzpzaybDIA9UWOUAE?=
 =?us-ascii?Q?CHWOQDkrGu7wIk+ORPE8syM8luzAZV3xVd8BZvMv5XrpDheXvmo9avvMYprS?=
 =?us-ascii?Q?85d0scthERtc52CYZEYqDbCzGsOiy/er1ekKQ6UiSFToo7EGBBn7BSGr6hhj?=
 =?us-ascii?Q?urZfc7zPKPCkjYsaN2YZ1T6HN7Z1+JPY36PLtNxCD4kS5Y+GfmbQIhuYJK3a?=
 =?us-ascii?Q?5NZnYsa51hqE3WObgnZdGorPoGqNglBzy5AfJQBdAhX+OxRXvSWRt6/ULjrS?=
 =?us-ascii?Q?DnAjhl3xJyLXrIZCGqzCk7QgmuBytDEPEF67gAYPn1+MGFKOSUT2kfk/mpVb?=
 =?us-ascii?Q?S26KlmqJJr/xerqe3A7Zdi/t33enAO2ZB0ui0jiiI/V2fi+KB4EAHSEebhiJ?=
 =?us-ascii?Q?EKFPbTNBGPqMfAxnLQUd4YTAdIv+r++9TfOw8K4OflWM+jY1qs41xM0lmJEG?=
 =?us-ascii?Q?1Sw9jmauW1ARRayah6xakSAeKsrXl29h7Dc3j6l7d6wObNBxbDQAdyv6wnLy?=
 =?us-ascii?Q?WyU4lxsjKGAhFeG2j9kvRN6wFDY/bnFGwAYvry0griGm03G5g1AJ9z6VPRPo?=
 =?us-ascii?Q?cr14M1oCrkR5ZsGoWRz/x1tELf3GhGPr/NXyObONYR83cWXBXRl4/mfQcjeB?=
 =?us-ascii?Q?PSgDBQLmjtqdoq3Y7CnIibXKlzhZLijWQdJxgAXTMBOZ9+Sq71Dl46hqeqNK?=
 =?us-ascii?Q?j/Q4+9PVU2i1mv5wtNYC2g+pPb7L0Nb+AomO87VVtne9Zht9EHy/zCCjdi4w?=
 =?us-ascii?Q?b3SP55m0Ie4pKpa8cbWjuVhUyyW36G5JnANuCzWcpi5e8F51Um91Cm9RNDCv?=
 =?us-ascii?Q?SkbsEl69fTnoJ0WWUl5gAWbYPHnhqC5QhpdCa0RHV8ZuOxcVX1iUaCkiVLp0?=
 =?us-ascii?Q?KXTlwLWwZcR7dcjwklW0mL5H49kTNCRoC7lDEEbnYQWAGkCEFZELMgmPBxfY?=
 =?us-ascii?Q?8+qq32EIHz/kMFyMYkWf7kvkxnPmHq9roA/YuzhT5VTl0tYHa8OXADlRAlUk?=
 =?us-ascii?Q?SkNZdZKBnN08Dt/Dd/JxHCJ2V1CDraOhfIkUk7bTfv2buCjwKZNZp6FylZYa?=
 =?us-ascii?Q?e4GBJx1IBpy8z9qyxdAncNOja6gjg33VJBFqs7dMJnD3M4u33D2vWiqufNvI?=
 =?us-ascii?Q?atcaBRc5ixFjbFYGiuNz51NMQpK2QoAtV4+3mSW/XV5H2iTzoju0IzAKiHAF?=
 =?us-ascii?Q?8M0ujc9Lefwn0+MXEmzhThE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165fa02b-5af6-4a79-57e6-08dbc325ac05
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:57.3049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkjZGthNXCDLgg7vWi4xtftytqqZDaodd1SSHyerBfBGwfc2CbytaTwV9C6raVEBcr/UNC6S03d4XjGkB5/cZoLGnGFJurc9DuxXvWTi3iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:fe16::713;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

After bitmap loading the bitmap is not persistent and is removed on image
saving. Set bitmap persistence to true.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index ebda6b0a01..bb4478c350 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -256,6 +256,7 @@ static int parallels_parse_format_extension(BlockDriverState *bs,
             if (!bitmap) {
                 goto fail;
             }
+            bdrv_dirty_bitmap_set_persistence(bitmap, true);
             bitmaps = g_slist_append(bitmaps, bitmap);
             break;
 
-- 
2.34.1


