Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A40874485C
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXWb-0001WY-32; Sat, 01 Jul 2023 06:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWY-0001Vw-Db; Sat, 01 Jul 2023 06:08:14 -0400
Received: from mail-db3eur04on071e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::71e]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWW-00076K-50; Sat, 01 Jul 2023 06:08:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I45dS3DwLXGmlm5kx/QyiO0GVW9i89b5aUl6EJTq0xo8fHh8MkL+xI5SIipoKevuYeH9/F0AiWzsR55SkYzpOsUQGBMiYpu01Ii+04eO5BGQE7a2jaEN6NQmEGrSxXpFKwzjG0FwzA43lVC9KKJ8QbkzWfBvlENTsIqBO9BIfFmjV3ekS6kLaKNAZRLKW+5H4l5gJkMv28laJ/Knr8P1I69CB+VEdkWuFlshurWW8q6kxa9PnyjxddyHFNT4wSVYqir19xze5ShvHYHX5eg0/n5nbZaKq6Mji0JgjkwBOaI1qd0/R6u75XsL2Ui4rsaiHxiTi0+0U7+eNv1+GBcoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4RodxjprgK5br3qArjQt1InVIySxUMi0MlRq9BpZro=;
 b=mPmZEFTbma+u3NR4WGrArXpfQDNjcjUyenX7bWKlPXP6uKzT1CM7uVvkx015ZG84Sf+ZlCoeq6v588l3CSH8WxRaO8btVJqbsszx/TdvHwtpu1W/2EyH6/2Lgwq8RQFSkdJ35wnbp7O/pl3IWhPhDlWX8Q0cRQgnIapcpjcW7nIEuav0r6FfLgImAieH3Z/lrQaa6/heHtFTPmQw/0kDOI7P99TqtH9tYq0O73ogABt93H0c8RtYsJwOrmcG4U3AiV2d10mnpxFh+nsSFtXvaGPusN7ZnCCY3pZaSpL8SS/8I7rtM8xsI1bAfjMNrvYjCgb3kmChF0eeuAC925up3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4RodxjprgK5br3qArjQt1InVIySxUMi0MlRq9BpZro=;
 b=WI85IdQpI857sIFlJQbjkKFzJ6/1d3kw4KV8vd01tl4PD3Gwe3uXQRElK6UzFw4ow67C7hMVBHz5wCor7tXk7c0fqEBLqNazMBPSBBZhpqIaR9mWRPp2KPuiZn1+siZn8TwUngCzvrOYlq6pw18XdrhOPPecMdZ73II0vg+Cl9FxY7FCb2B783PvhAn5hJgqah2bOjPGIAKvlISrcPe6u9PPDBmVckW67RlKDZxFs+HqSJrVv3+CwYLQoDqdeYOwFbDdkjOUf37riJZ2K+v2yqLiYliS5+A41vFtAdaFICC7XRP6aQrMTJsVvqRhQzgdq3EkzPRwl7b7vQ3iWzQeFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:08:07 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:08:07 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v7 1/8] parallels: Incorrect data end calculation in
 parallels_open()
Date: Sat,  1 Jul 2023 12:07:52 +0200
Message-Id: <20230701100759.261007-2-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a2c62aa-f0af-451e-60ce-08db7a1b1104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opEFppgd7BX8oyX3fyQdNlpk9Zpq+jOzvyXtz1723WEspeqXnjugMVFAoHhL0yNn5d3tDuBqjPSmEY5QlsbgSxoTS2+ZJJHAp0ebuo+0FHcOV0hQxQw7d57sHmunKHQclCon/sdef/exarsIbPGXThZ7kcBaMkgBtx8/j9e49QdOovxsA8tUqHKTzgRfaGuJugNcfVLaKaxRVuRQ+rEGvQAGcUcWDtqId6hirTVWLr63Hg66pX1xZzBPZYtfKAJBEMwJn2tqlD27DWcr4Mi9cBAbpa0LCm+EkTsQVsoBhdLI+O/nfCbZGf38P5AxsybIA1G1B3vKD7+3ciOpQt2HuvESj+FpGyOyTD/DNepxk5zALmV6iTxHk3KbJwvPvMa17orOYlevbiNt97XI56YqYkH7N4IGwrPpUe4g9/J01Y4xU1rxYxSy5hjxk8W34yMxeV8f1eT/EiD4TK1hJrKOlCxWHV6mVLUTTzMZ7VtU9XPROdhgczyiNpJZV1YU/wWB6OJ+yRlDrb1Yx2MjbKNV212CYLQ+9o8mBiX0OoNl2BHNOHsMSM/pI9sXnSuIvtPsb4Z33rmhTv4HGH+BeoROs6gD3ErCu9L2veyH7sz44QaQ3erurM28fGOf08iO/Qwi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ROfpQiUR+YZ6Gv5gvAOVS0QlhixSkxfcljPGeA+S+udisK/juMA4mMLULBe?=
 =?us-ascii?Q?0cO4PjEbeTZGf4chk6F+N+dwGCMu9xPlRmJhVPAaxcEBUXMVitcOS/8b3S+E?=
 =?us-ascii?Q?8oPKlx5FbIBPnW93yk+aXW85gMdNCc+RfEfyZWnVoSTNlHezwmR3AJ9thdiP?=
 =?us-ascii?Q?Mr8udpeQjhhe1QPU9LEAs/N+QMloy7x1NCKpplBs2RHFoTdkN3sDNUQZgC8J?=
 =?us-ascii?Q?VGHPehl8muBzXIty3dGft4IN7t8uqcfSAyYPuGIgDkKZS1+8NH/shavGuHN4?=
 =?us-ascii?Q?D/IBnv033d/q/tCMq4TkfwIs1yimBBumSX6fLhgaZdWau8YcHSLKHQtefU8D?=
 =?us-ascii?Q?4BMxcIRLfYLKdpL9srG6E54+5oXtGsfp8jjz6J9pkuwhAJuY9LdJ2ynxiaiX?=
 =?us-ascii?Q?0FOH918srWhc9llTzwhZW61QgbbCatr8VWF4rQA0zXFwZOl0sWts0qghSm73?=
 =?us-ascii?Q?5IcNjcBFiRYfq6ElPgqklZwDWGaiI9a2MLoBwBcdyD1/jQ/n+bcNKxnzOKch?=
 =?us-ascii?Q?wOUoKnc/zAj8L6RwIrVHM1h85O3S2CNFhslmzDTm2A16BegRncbAVwViPtQ6?=
 =?us-ascii?Q?56l+KdJNrc7xaMFgrgp2g+tkkvZoFX2fV3ap8w5aiZvBLn2tX9HKiyJYTsoj?=
 =?us-ascii?Q?YwBjd7tB/fBEqN1OWGtwPEY+a+PklTZZaFvXrUQ3HMKuHb+Zfq/Eopj3pivq?=
 =?us-ascii?Q?nblNekjBVaYjiaI8qlT9v31vaU9/kHuAToVkpSUtlAKAy3VbmQqZqZjje1oY?=
 =?us-ascii?Q?6sH0Svqa3Q68gfTAsPSyq2IfbCvNaMurAmOACnlZe9CesHoiYQrc/BjsfsKA?=
 =?us-ascii?Q?71dX/ufIRvz1GnjLHmhEMm89F/9NYv6kwgblTFrkGWqnw5KD7KJXKQzR/BoU?=
 =?us-ascii?Q?aPL4ukbn8VRTuKh/Xbbka62P4rWJqkJLVhpwLf08CeNOZa+kZhJuqCUu3DI7?=
 =?us-ascii?Q?mbrFA3JaLQcG/hHh6XmNP/Tp1gylQUHBz7GMseTp4e8+W7rNiZg7sE88ueZO?=
 =?us-ascii?Q?7Hhfg3uxGa5gINhm+TgGCDQurSeu8weZHt6E6oy0MO6SsNcGoS11YS7b4MF8?=
 =?us-ascii?Q?sER6fp5s6IIWFGCHSl9tyy96exJra5FxHYHcZvENpLlYlkJ5xXiNvfRPIJFR?=
 =?us-ascii?Q?PabpZYiwT5r9gad6PerSxo+mVeRN1LKVvoef+V7l189U3k9Th7JfbShEW/0o?=
 =?us-ascii?Q?5zzWQTlfvTCy9qMYAwvk9+nIyg6SSJ5O9yZAd37HyK8r49Z5onWkOYenSuU6?=
 =?us-ascii?Q?Wgd1x8mVOP5jwm96CR4G4hVzvr3a2SmY7YldUgACLNUr8rfS08rh3SgdQiwb?=
 =?us-ascii?Q?KtpKDdTSxGhsYECo6az7UTkw98rlfEY8CLizYImfsLDqW3sVjIOOE++MyZkf?=
 =?us-ascii?Q?yNpTcoFmWxVyIzdBTydmlhIFmdQ+KLQzg8bpauM05bN73mnJ+5C5zWEAfhn2?=
 =?us-ascii?Q?uwGtuvpOZkKC1d9lD/hBLNQQFraPz7SAQUOkxcknDsRMp5n82jHnbIQa5Vsz?=
 =?us-ascii?Q?5VaR1w3EoHKCTmFrzYuShIGd0T9pkNcBcVIzYRZfqgIXyBKfOtoLei8COMA+?=
 =?us-ascii?Q?4o9B9pXkQrxTJ9uL4MFkf76nSoNw8CE3kuTF5ZSQ5Gs32Mjyc2IBLwE4zwqs?=
 =?us-ascii?Q?K2edKKGlmmUTX7CXPZPYH+I=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2c62aa-f0af-451e-60ce-08db7a1b1104
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:08:07.2132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BeA8VbAgNtGdAf5+su6twtx9r+BifGVIAH7SO0f/7+ywy+jAOWhyHC/ngt2lrsFBZhiEoCJonP8EW4Bl1a1QzElzmGV5KUwCqb72OY2ZaQ=
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

The BDRVParallelsState structure contains data_end field that is measured
in sectors. In parallels_open() initially this field is set by data_off
field from parallels image header.

According to the parallels format documentation, data_off field contains
an offset, in sectors, from the start of the file to the start of the
data area. For "WithoutFreeSpace" images: if data_off is zero, the offset
is calculated as the end of the BAT table plus some padding to ensure
sector size alignment.

The parallels_open() function has code for handling zero value in
data_off, but in the result data_end contains the offset in bytes.

Replace the alignment to sector size by division by sector size and fix
the comparision with s->header_size.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/parallels.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 18e34aef28..86bc3bfcb8 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -861,9 +861,9 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
     s->data_end = le32_to_cpu(ph.data_off);
     if (s->data_end == 0) {
-        s->data_end = ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
+        s->data_end = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
     }
-    if (s->data_end < s->header_size) {
+    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
         /* there is not enough unused space to fit to block align between BAT
            and actual data. We can't avoid read-modify-write... */
         s->header_size = size;
-- 
2.34.1


