Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB0A737D37
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:20:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBt4s-0000GG-4P; Wed, 21 Jun 2023 04:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4m-0000EI-FW; Wed, 21 Jun 2023 04:20:28 -0400
Received: from mail-he1eur04on0726.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::726]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4k-0007B8-5M; Wed, 21 Jun 2023 04:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec6JycOOu2LAhyyRciNIWCZ+cbjTSQaveN3lIX1WSHJFjP2NxTqNQ/FA6tUZtXehDYkguejjwwVpcKrP2QkJ89gt0f4JeBGHqDTTv7m7EBC+2gm8p+8XkmpU041mEBDVmtBOI/N73lnDIaBlTq4AA0khQyzxVgfxGIgthhuyrqUSVb4UVPO0QiEeo9hdzHXr6EWXkz27ySKwWi5KBd9+CWWig7E/aMvtCFHT4hEbigX0/AnbClcmUIMKhEgGMZz9vlCTMFBvaBQj3ljKLd68PgggZTgnC1clLn17BPpdrAy3MzN//a0biKDjKUh0lvfUz4+gbUrzLgLpz2+Q3eZbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=digeMjfk7f9RMrOtkSaCGKZ/ON4DSNbpxzOK8YoV5uU=;
 b=ErQuJVRRNmM6X9/BSAMwk6rsqnykZ0CYJ9rZKkcFQOTopCy8diQFrdIn+uBvYT2b8svPDUimRCDDMphka/O0VJI+Z64itWEdhEGG/8vvg5r6FpS6VXKqdY+RZExKhe+Jko/juS6LJbBU3OWX4dyFf/ypEV4VmVKvnZ0z+hXMev4pxj/fKFBfpej5HPsNl7UHKaH6g2kkLoj+Jh1iy8D63TTZHFIBY4i1YRg8ZU4vEbS8qWsqLP3Gj+UP+OvoUakPMjXbOh75/IV3wTHyYVOqOjlYx9zUjEmFrsO1C/9+XxNSzih1I35E6iLfH6qZsoc7o9zaxa0I+Hw+3JlHF9suRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=digeMjfk7f9RMrOtkSaCGKZ/ON4DSNbpxzOK8YoV5uU=;
 b=KP5MXQvT9at1VMxrdPTEelx3Jf93iBugCYLoVK4NHiPS5Lyn4kNiRiZSu3ZsqR/+1Hj9EBfincijriuyIUda8oKqpAvEqtwaCVV+MZvAyOoW0udNAMf1vtgkrwYo+zkN1CY9fK7WpCbpu6dGafn7ahY8vCNNwPRJHoePJ6+Puz41yJm/4id638NmfNbczjwY/uWdGt9CIZmxdqtU00yW4KtTFMhWOCK9+qCQM5eONoJISMs0iVShockVmj7+x7LcrXT+uTRGkH+1AAcdPcP3qEgpBoxjQ8jd7G88ZYK7DwtasYYDa5EijLGJrUAwP5qo4nKchQ68I5hH6UI50uwfvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 08:20:19 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 08:20:19 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v6 1/5] parallels: Incorrect data end calculation in
 parallels_open()
Date: Wed, 21 Jun 2023 10:20:06 +0200
Message-Id: <20230621082010.139195-2-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
References: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0165.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::19) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU0PR08MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ebb924-9069-438f-936f-08db72305980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFN8Hnu8lB4058FTM8WIl4l3y54b5DwlKnQLdRkGAkuGw6rndIIW5CK8itRvFXwARBBLoP2/NvQuJpP9RIKFgcYwnm4p5j9Wfcvl/PO9bmSC4tZYsB8YpBPLC6CGHmH4sXOQq0zqRALVq/JSbye4F14r3qYisJP38RtgQ06nCDiNTRspoA/Ps5GjxbeCoIzTuuRF3kHEmTttyUikKI682XF+RBIxDUS4ni2SjHyQMCmVDkIM+kMVT54OdcxsqvQaqzPro7Rg5c3ggTtXRYJBI0zOXSVYTSrc/HFbMc2iR0pbiCHjOR/4FBh8e3Kwcbk+vavANxzZvLXbPMHirRwObKh205dWiwnEMQHpAqNute9YHbTSetBkU4EUst6B9k2znm2XPGZLYwbWg7q1cp/2/ihkuNTzCf1bMGw+7Yt7OZDlS9d7xqZNr6ldq2i2dHeYqlw8t3P9AO2IR2/sW+voh57/3lx3zOhXTQ3t84jPHOksKqPvGKZpMq9wKHAmC9ZMWVvDFRbUq/HO3Akqvnk/n3neoHY4jHbMT91KtZxdj+pKlnL6/WuBNn7UcuAFv7CF4C1GlnF0wOPlKh/qOczsPeVWddaawOyGpezjwc1m3VukL6Dt/1eXx4jWz6v/kpF1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(451199021)(66946007)(44832011)(5660300002)(86362001)(2616005)(8936002)(8676002)(1076003)(26005)(6666004)(186003)(6486002)(36756003)(6512007)(6506007)(52116002)(2906002)(478600001)(83380400001)(38350700002)(4326008)(66556008)(316002)(6916009)(66476007)(38100700002)(41300700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lIsKLr0psYIjOz6OFNVjINhmaam/cMKje4JZdmlyGsIGPBDjqD/e+RYgGUzy?=
 =?us-ascii?Q?w2zY3ZaCzV7nW/iicYrSbn3kd/7pKruTFfwjhH08hjXbSllMofXygAG9ZbR/?=
 =?us-ascii?Q?vtEne4/whqd6EljnHJ2JjU+ID6bWCaNhAFyR2JtRNwSMf2vf5WstmmqguOnN?=
 =?us-ascii?Q?3yRegBQgNQlDyiWockXtOinHkHjgwLIBL01Iev51+oCqnTq8qSllwT5Hfvnj?=
 =?us-ascii?Q?C3LvfQB7hem03ExBHKEdt8IYlNLfpJCLcgdWina6LBiv+uCNzqI/1BL6rjlL?=
 =?us-ascii?Q?UfJB+PECIvx3DZllpktxBeQ0ytAQ2DoVjmPOR3mlCPB0BbcN3UeeGv71Fuk0?=
 =?us-ascii?Q?qK+SQEWAd45CYEEN9DwkrCH/M/bNmfF+dE0V0fy+ziVg7rZ951GLCaFGpe9s?=
 =?us-ascii?Q?FhZusahTbECOikjhmT/VRPT/+7kL/yFPzRPF01KNrU2jPjUm2Hfx6YoLg+Ei?=
 =?us-ascii?Q?xRGHhR7fMDrZPnO5S7rVxk3eakQDearAJcAJOMPWvMm0WTt05jH/yhfeZB5r?=
 =?us-ascii?Q?5Flr5X+X4WFjgs6jKo01cDZDoX8N18z4Y3EjdPJ+nM5AWXUgsPZ9oG2xFRC5?=
 =?us-ascii?Q?Ig76xhnbQeRETRQvk3wUgCBMDT17cQF2mhyRaBB0GPGuvwOmrUZHCMF9pw2R?=
 =?us-ascii?Q?FW3PGgH3OT/ggIYVyV7PuQ3e3+XVEWGhOPvJdw+RqfOfpl25FIEjDkEDssy5?=
 =?us-ascii?Q?3m+HzOh0y0y0VsuYifp9DNnV1cKNUo5mbiFR87M+5JbvAK9nUJca6gxVxyYx?=
 =?us-ascii?Q?St7RiJn0zTAupL30TvftAJIBuxmn6emF+oIwJ2cwkVdXe83PJQGSW04jRJTN?=
 =?us-ascii?Q?YYCjAJ6W0E5LLj2zK/LzUb3HTYbfkX7MVqYGUjmRnSiKzuD+ZTzC4QH7g5ln?=
 =?us-ascii?Q?+VZ4BGza8KlIQEUB12zg9rrnbcFbTy3WpyzZcV7GchJ72ovcw1pZRFE8SkTQ?=
 =?us-ascii?Q?Ae4/3+x5GGBxUhrz6q7dQpPdcBfzB97YaNsF42O51EszbaCbpXqRI0CyMtdL?=
 =?us-ascii?Q?VMc2OcEBovdrRim2vidnPhDR6FcttZzlYkm6R5l3X/jsMWHzsZYWyASD2hK2?=
 =?us-ascii?Q?hqC8SAFATjYdj8p4BZ8O+Ju0S++1E6GFL4MK2tJ8UqgtK45kDneXaruiM9Tf?=
 =?us-ascii?Q?bMkYoI3QrBy2P0/0BI5X8v/YKrv/mRDB62E7EW4MI8XwhckKoI/4i64xo0ch?=
 =?us-ascii?Q?qrBvR4ZjL9a45oFjNNTillgadSJiM1CzxMM544RqOYNqKnA6fArJm6gJ4fFT?=
 =?us-ascii?Q?3JKZHMav/e+zTfwQn2em5lkxBfYWOfoXzq3jL0r6NMmxPBB49um/onlTrRxc?=
 =?us-ascii?Q?5oszGbUpSoJZhQ/6z4dBf912Sk3+jPM1ERIaROzWBqPB6XADC4Slvvpgz20j?=
 =?us-ascii?Q?P1wlcFSRSpgsxaxRf5a9yiYmIz3zXVUgm4epwkhVUrouXYD1cD52o9pP5aP0?=
 =?us-ascii?Q?TMiFL33JHb6Gva05gnF2WdHCx3p7MA3gI7gJ9V19a2LHI+stibsi0aFe4sbg?=
 =?us-ascii?Q?b0BbqCO+67ZADy2UTHiPAGX8TGDB8Vhz588H55mqR/iO9k8qtxQ/gGWqaIBb?=
 =?us-ascii?Q?CEXE9xAd0GRKhF/9XxHLe+35EbqIMAuKSA0TZl1V/ONsk4hdVuP4fZVctuVA?=
 =?us-ascii?Q?s4wfwpRehMmBrrEHjg4wTxQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ebb924-9069-438f-936f-08db72305980
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 08:20:18.9819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCffcfk1j3N7Byp6mQZGsNLZXqgAW/EF3sBGeAZCxAFj8VbjKvzwB6cmsoLl3VdKOFjXWlxaXk2t4O0PY643Rr7oh+mnTiMcKCRaIybD968=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8422
Received-SPF: pass client-ip=2a01:111:f400:fe0d::726;
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
index 7c263d5085..1ec98c722b 100644
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


