Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE577CFA71
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:10:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScU-0005ks-IT; Thu, 19 Oct 2023 08:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScP-0005iB-An; Thu, 19 Oct 2023 08:59:17 -0400
Received: from mail-vi1eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::703]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScN-0002f3-Nz; Thu, 19 Oct 2023 08:59:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H86ut6qqa1QU1KppDTRV6WjntR85r/009Pp1mff0Z+fgMsJEUGD7RAgQtQFJ1NIjzipmWDbSNePoWK+ng6Mx34XiXc8BUkcWtVh1zhh6QT3y7NJ8xO+x8wSoxwrwuVLcvVNZ90mJ3r1VXl25vQpTHUO5Yieh2OnW+Ey0+M/F7pZpxi80JogUAEFN23D9e1NULjFbLGtVKbrS7XFji0rjQP2FWuQo1nK70mMBNG0j+0CnKgIElij/l7NYZlf77ew+2RetTp2C67LW/6dMblMI9DC9N2+P/kipfBpOAJgzMPXQRO6H85gP/cX/9XnBExh2PTaXhNpjohpE4DRG8DDLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDffaETnr5fYHpQ2nnTQuJeK/UGFcL01sqPorLAFZHs=;
 b=V5ooYvWJ4jVVoZWIwXvKH7uxDIBIZ59xDQHzRf++NM++e0mRX/zJ6GO3S62LVVt0YY6zCi9wbFbuFRaWWGKDCmMYnz5bLPRBbwihSRbonH7KT8VgZtpDRHuJKFsZzAWSjgefookAMdumOu3N+Ox5428yRFPvcdtPhKjQu829OWzrKjbchKS0R6Q76r0q392ufO1kI6hbC+RLqt9lNZkgBq7vQ84Gtm+OU2PkOnQAF+SAhThtsbtvMFTzLK5WVCERVj9b22xK8iYO/MHOeZkekYh8wKvGTWUJV/fM6HxWNcAttGjUY4bWLl3jfl7hy+Df6ve9oEcqg2bYhMIYliMP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDffaETnr5fYHpQ2nnTQuJeK/UGFcL01sqPorLAFZHs=;
 b=r5x7VznOlPo1f0sloiHwRaOHsau0R3aieTwyGE210yodqHdBINN7hv+/Mk8RdHDuc+M37zwAcenp6Bk7AiFM4yBP1FZWbyA4hQBDNU90Xj6h8gXZ2efYAcFFYcyvwHCmK0FhUyBrFf0UlqAEWqQtt50s4FIFi+cub2d/p+pvftWz4swRGqB4ldVx6CSRdR0zGQC8cI5txeVUAJsjO2EA9X2ublIAdeWxcP6l6ny1tSzWbF77aEDLJBA8bIvzehIxg7yqWpkwU8S92Ej/ct+MbFBcMyldOxJp6hUg91CJ7UGzXkj8fdiov982VEErSn2pYs4R7Nm5XufyBFpwDCoyJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:07 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:07 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 05/20] parallels: Set data_end value in
 parallels_check_leak()
Date: Thu, 19 Oct 2023 14:58:39 +0200
Message-Id: <20231019125854.390385-6-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 427b2bf4-71b0-48e3-7bb8-08dbd0a32dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPfSD25N/FDL/x6JzSG/VniJ0Ab/neEIP0gDnbsjBtXNHIMtyy51h7moOOWYrxSuBvodTfxA08HQUmSkdtSlTgzAMDe19+bF2Qray+FwCncCd6REdS6u0kth4ubLyLD8u74it/ynjEU5RkIYlF+K9awNQwcO/bctUBAGRwWS34MdKLvETI4mom5z62a7irMNw9pmKw/uuUB7VhnbU7t1DRcjnQNUl1diBX3oHr+lfTZGZqN492RcfrCekr/ZXP3Wf3viFkJhszTTA27MD3EVKwTrB1M14K/zN1JIDOx+cSy+V2gu1lAoKbTMEd1U9StNVaF+ZQX4B9i9x2xx5qRtn67cuaxP6V7FVRVX1Xvn+8EUbs39ybZsM/tPijeYn0/FwaBoDm0Ex4aS1MryKgnEudQmHLYb+/3EjyIS1k730Xyu5ivxB3CC/5u1irS2yN8OCx+8lUidBXxARf5FH2ey1JYYPFKee1aRovJC4AzNA2dlJuGURxDycpcRzZT/2dotF10ld/qhFr1DMs342Pk/nlbS5SSjwLsyG5flnqwa4FuFBZk+s0UdK2Hq4Gh5s1JkeXB2OnQgI1pC500KBefajaXZzz3AGZ34jczuhrc2vh2bcV5jOI0f0oruvquU3tJX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(4744005)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Oc2aEKMpcpW/ANqVQGqBwu+KpZmB4zSaxqUUA3O7oW/l8sRIwmUvfxZojLl?=
 =?us-ascii?Q?SOvUJP38o+6g/d6c/NU/aZxeIXWMWBxOvv8wktTfL5ZEbrpohH88jtAsr8dl?=
 =?us-ascii?Q?ci4SPG7OqMSEkFs/FCL/ITfbUrnhCcjkYKHZ+CTvewy15Nr+9whSCnE0mLGE?=
 =?us-ascii?Q?53A0q984JQR+753DFwWxkp9cfCFzLykI1+0NsN2Z5mMbIB1gJoa6h6yJejmv?=
 =?us-ascii?Q?QAcXf9vpZcViRnJAyPW6HEaINvuy8iIiP1VzKiBHoiNNHaFzZNMQa9RzVW4L?=
 =?us-ascii?Q?T/sWKrJn9IZBmGDslxihoojg28r33l+SncIpMyL1YEGtolht4uUgJd+1VHIw?=
 =?us-ascii?Q?HO8OHOy2WvitZ394tyIUw/g7OE/4ondyV8+aXP50PYBviI/S3UelTuDwFgxI?=
 =?us-ascii?Q?fdE7e6JDweA5vWturBp9EjPT0A8DTMBfIbVH+wtzfou4zl8gbNOr/BddoV1y?=
 =?us-ascii?Q?+CqKdnLfMpqsLXXgi0XEjus9Zo7diuKyLfGnyQXxG8mz/MPgcZgQtH1xLBJQ?=
 =?us-ascii?Q?jUT+Snkhnv325K896PKEztuE3YxkTUghRoPhiC1I7v7NHgjbyqqXUJ6MQ4Vy?=
 =?us-ascii?Q?/nHp72Pmwx84GKmHorIAHN0LhjzL4nCyeaP+doNkk0m90ziNTWxNcBv0jRoS?=
 =?us-ascii?Q?ok9tHm38MJ4l4KDyCT0L9c3mACc7sxnjpdt1vNe2+R+8znMhxKCTDHin76gy?=
 =?us-ascii?Q?6ZphdZm9k7gFKEfsa5a4I1on/MOsftgNBq5y6R/Ls9w6JoTp62AGGhCqbqd4?=
 =?us-ascii?Q?Tw9krmJD90OTb2G6gxujyY5l9wptqLZb4fI2LmNCONV8mMHHmM8XXyTkpVT4?=
 =?us-ascii?Q?LvjAbqndaojfQnCDi3zOEcAva+QuF+WyQBv3k2qgZ2XiGzJx1RZAZT566nmN?=
 =?us-ascii?Q?hXrCPxDWgVorBbXsXX0/fgv+wlxeXrY14wL/xYzf2TV7OQLsGX67CeXjY2fK?=
 =?us-ascii?Q?4Km2XOnEqrGCELTOGaYyHfJBmn6d8fw7EzqZqXwAU7EJtsDSRajX3b7i+bWC?=
 =?us-ascii?Q?Z98Sj/vXFe+Bb5c0mY3atoYCgKD0F9w/FmRAHZqg+u5Byt4JFuKE6fWLuFGz?=
 =?us-ascii?Q?oytHLxL0DRHxC0HJE+lxGOGKaaBaPrxm0phaBJjjGPxuEU6+2hYHgHAQKVm7?=
 =?us-ascii?Q?QRouifV8EvW0XAsW55Ecu8w4SKCRFHxp7dv+xEbtA6Ba9jRfx9I6OHzU7hY0?=
 =?us-ascii?Q?gn5SaFjTgJ14vcQZGyq0CYtdlbuVrcuN40YD4UUIfjJi7TaHLpw+kv3hTmxh?=
 =?us-ascii?Q?aLAegxQ3R8xU7gq++P4n0gU6VzpYAZnUlB1YeVNr8PQxhGZeAa/7DLyvo79P?=
 =?us-ascii?Q?vZG4SpILPdISKjD9VCmgPy7ju+R2mvB7dTWK0L4eM5rvsZjkOsFiIOu8KBjR?=
 =?us-ascii?Q?q2GVm3K0BjP5InzG1S9OC58i9LM/4sxGLDE17ci3lpEd2/RZqVsGt79ONBNn?=
 =?us-ascii?Q?e02j3m6SQS01CXwxpdJJwliA9CpKSZOQsuIX5VfOGC7U16nEODSZ+eZI5+wd?=
 =?us-ascii?Q?qJ3MZnWyywj0DvZ2VXCikO7SOT1JwjrodB0ik5Hs3nXASH4hRJ4jZYte5rX0?=
 =?us-ascii?Q?K+fuV2uPQPv6X6zEAawKdY3PqnMfggmkcTyzWsNglHpiLiYjRh8Y0myak00p?=
 =?us-ascii?Q?WyEZoQoedAWe/6tFapkJCyc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427b2bf4-71b0-48e3-7bb8-08dbd0a32dec
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:07.4598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDrbH8RRVLqX50d0di0S4tNGRJXuRDtwz/smFU77yEYofeQiwaB+Xu1ZNtvZzIwVupDSgakItt1Xt/Q93uVktmTT3f7NP2MhHLkXVa1vwaQ=
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

In parallels_check_leak() we change file size but don't correct data_end
field of BDRVParallelsState structure. Fix it.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index ce97387e3e..ba9fc46279 100644
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
2.34.1


