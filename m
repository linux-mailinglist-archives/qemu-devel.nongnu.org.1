Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A3B81F6CF
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:17:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInOL-0005Z0-Eo; Thu, 28 Dec 2023 05:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInO0-0005Nq-2m; Thu, 28 Dec 2023 05:13:11 -0500
Received: from mail-vi1eur05on20707.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::707]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNw-0000Sp-Tk; Thu, 28 Dec 2023 05:13:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKMpIUm+H6OZ/8SlR9mvI5K44mxURzdWkMujz/ENTgRmTi1rKM/Jqf7t7Z3RlNwdzhPg/YfwgAVHt/TS9PhyFOgui9H5Xt0HS4mMQHZD3J8a1VYleXIQvtmd2uONWwJgDIng7Qb97JCm+R7GODDLEcHjXprvduOblPskfom4brmD1nZtONb1vFMmZ8MNCsIF9CwGTTLv/5wL7aXb6XFfLr4uPDXrPDbIZC56AVhaxK7rkRCW08uFAfUKPZd+BYbii/XKwfl8kGGVmfXVZIEnmlW+apCO9sYe88jDxzdJnTFWvj3neHMKWX55cNcB8Vj07pBFnw/2/U89TqQ28jjz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5Oj30LUdw1Ptxbl2cnv9yLfr5rs7S0ow9Aga37sHnI=;
 b=fNEW3cf0gj3woLF12Gl3xFj4fkrn0HZkedIDxdHAIPhQMz3bNcNqMVBINAD8umjeJO/mIzhSeYSq/nLxS+HrU6hGwOx965gQooc5ectFv0ay4oMz0I6rtlTMhSvzu7qaciUlS6AVZouanKwVIKA6OmgdRzXPP0ZVb/MqopfKJvSdWaZDM6w1S9xanq0hwB1LcDXEQz5PqprX9NFi2iJShg9GxeedIccWZjIJEoX2fczWScxeHC81SxQgU9Dz03lmlefNaLNg3enQ9QvyuEIMjWyWidhACRUUlr3+W+G6v++Mgb/dGMVRLlba5SVDvGNJephJFyzbJD3Oi98rCqwubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5Oj30LUdw1Ptxbl2cnv9yLfr5rs7S0ow9Aga37sHnI=;
 b=DEJbZwcuZvxWvyYIXhxcUvgDXvgEjzRNp0XK25WSXBeXjLmGCheq2uwrycchB9dxXvJruyz+tp6e82xVtC3m1CX19Kx9iUgbLlSedFbuERaL9/9LS8CEsyZoJh693A1wZ+7h/Oef8rVAC7A4PmFetlgItVfni68atinN440jNM/hKiVqkLXx5Nks9Hu0OFY0q3k0bgxYAz28Pcq5Hm5Ekc1Uv7ivCUoQUHEGospq+PBlh6a9Dxz/wex+3P25bUWeKM4AysVTAoLAQh7SHTwIMcCpGHJvNRv6CKcu9GcnnsuqtXmB22qIAGjEJ40P8EiClrIrdvdv5OEx7g+bwsnKaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:46 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:46 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 12/21] parallels: Let image extensions work in RW mode
Date: Thu, 28 Dec 2023 11:12:23 +0100
Message-Id: <20231228101232.372142-13-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 65936307-e7a2-47ba-6a44-08dc078d89fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNfD60VB6e7mhM2I4POc8waIB1Dr2pXUVb+Uluidu0Exx9j0UPgTake+bD+c7XZSUOcsEs4mqZif0t4o3D7eoEhB0fW+ti5R5Ev26xn/uPYz14exN9o7lFFzYQ+Tu/3C/tIHTpI1DxOqW0PtHl7HToi+o16y/ljLbolaTfiQ/th89x102sUlDcfCAip2rlmBVti5ng+c/6PqLySeyXP4nRLiC9w25uFjM3yKqLKzsnDklj49YnStLfHs0aJ3tz8Qg9QUu6oVez+SJIrWOXR2gSuYld6vGDkRMQHpIEjMaoTEBsYSTUuKJIqFPplm6r2jHUVBxqet2+b5iME0r4zKch763Vxuw4DFzhm/c3YnQh3vvk+9u2Q7jspo7Nuy6jcC54zFHZ+gRGbR3tp2XOZe0h1G0HYcmAtCSpLtoADWZjLNagIi98K/VCNumdg3OVgmX8QnseD4GH5zNSOZpcY5KNX6jSs2hkLwmdexZ92LJNbGXQ+n57UiOjFQFIr/iHkQtrSqlv/BOT34h9dTvnnJ72tuMV4M50+M1DNuCH1LQUryrqDUmHre1on+3bacE/1VJq+z01UjyQsUp83hDxCji3Bi5ZtMiBLK+tSr+vxkHCg5j+aGtigqfNZfRbHnZzIzguKpUf7LZBmFzLuaGvLA2OMUdmCxE1CkLosd++8fRiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RUh7ptAvpPisycoSgVNcuRMzt0KKBkTJOrjmvgqD9XO+oovF9RwKnJdUbZZb?=
 =?us-ascii?Q?aP3LOI1QlFmBymYWJa0jnPdiAzjB3ejCwGP7LWBhk0dY8Uj0X2Maq8g3t6MX?=
 =?us-ascii?Q?UBBSpxLFUKEJHcfm3+l7/Z9zfbfzw68vJNw8pgy3/+mhkZaWQZiUqyLbriLj?=
 =?us-ascii?Q?EvnzdDBN7DKX6x7P1lbenwhuRL7fCLxE+8RKZoZkAsXEeih2s7pqzuyQ/X0u?=
 =?us-ascii?Q?190rhcTJHM7OxrolzrIFG8Vdup0Hkx1Npr/6+fVFOsKpgaeuhzFmVNCeXvLd?=
 =?us-ascii?Q?2P8jRyZDtUNXEzpnaTEPNgfCmYNWNwA0iztMOIfacCz+Sj2trdFigxC4cNwl?=
 =?us-ascii?Q?IZ4swg0bQ15hEdXraBrGpJ+Z4Vh1gxFCCJCKAguZSfYhX6OAQdwg6Io2Dixp?=
 =?us-ascii?Q?uk9rEURNMbIlqw+terzapKTmhRLHWBHhMuytu+xtnKzu/oHdxHRoRIglR6Eg?=
 =?us-ascii?Q?pMhisP3Is1mwVrrlYUtco9Uk+ZWi5U5n4ibDo3cUyhENn3Qb/+Vwlaac+NLA?=
 =?us-ascii?Q?Y0u2dAli4hILkXY4ksndcnHLRgyvJ2XyZGXnh/EQvtOHxfFCGnls0ko+FG+Y?=
 =?us-ascii?Q?q6o5pSeUEfFHQDkxkwM/klQ+BS5BolfEoUgjfzpNo9K5bPiJ42jSApuZqNw5?=
 =?us-ascii?Q?hGSdlB+VHlklzVSdeU5PmIzzl//uPbA95JdhTSoo+Djm+f+QWU9eC/nReU/B?=
 =?us-ascii?Q?8lHytPDNrkRdQmZX6w9TScTfMen/ugqyxjr14Bg+SEKuiSqWqY8j7HrHTzbe?=
 =?us-ascii?Q?epFdjXM8AhHObvAUbeMfebUfCs1M40cL6bulMN8b6gAZtiogSsH+iabgSImA?=
 =?us-ascii?Q?QA9A1/U5zQQJx9EuiqVVMCz9casYpufmyhCYc5lRF4AAoIjs5l1CUDjQhI5T?=
 =?us-ascii?Q?sbIZaq/5rq0S5roCYpEG1OyMt8/Of2l0HvSWUx9PDU4jvJVlgxedVMNRH5vb?=
 =?us-ascii?Q?QX0e7mHY7n5AaZooLVZAsy7TB3QUEQTt7aBCUkEEI928xinaYNu4sGuXwwG5?=
 =?us-ascii?Q?KaFHZeTYf5vXfbkDsDKhb31PwG2OcWbvqZAt//pkVI1mUl9iylsl4n1JrVK7?=
 =?us-ascii?Q?5Oo/7vqlY3Rtxm3R+zd67X5k6krHsMcvGjJV6BiXOVGcIyhOnCPGlBSzOzN6?=
 =?us-ascii?Q?p0GTrlshBUAHByM0nD9i6aCM5v/JbwsWaYOX0PMaxRFuGBKj8KNpvujXpSp2?=
 =?us-ascii?Q?elJn6LFElMfFkuU1+pwHddjrc4E0xOtfWkgTJp5bxfK7jmakGqfkw+ROfQRC?=
 =?us-ascii?Q?AZJt9dqq3M5vTRQG18YYcu5R54eFFc2AljoUjthKzY6Rjt7pHLRuiZ83dj2o?=
 =?us-ascii?Q?4wCXXU3z/av3AmP8WM4jse66/DJloL7Q0bm9m8iTsn2y828TEYgXXZTQAn7v?=
 =?us-ascii?Q?18AUbPRWkWC1iuf5NNWgqGfa4ugTgPj4HRYt+Gz00c2EA4CLptpP92kMjQeL?=
 =?us-ascii?Q?boMay7mLH18pFD/bakvGrH9KziYkXsp++csp6e0375DQvxQqIjsVucNbIJsY?=
 =?us-ascii?Q?5TfOxpbBzKmKJF2SKwZ7c8x8XsogFpzT45aT5J11jwB6R/4f4nRXdEqVnvpq?=
 =?us-ascii?Q?KpZEAh29njL8hPqwfUeFe3OklSdPiWnD9sWKJauuB1L74Oo80lh4KyxwFzED?=
 =?us-ascii?Q?CNSjCmrhFYUS6HF+bYCLshk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65936307-e7a2-47ba-6a44-08dc078d89fa
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:46.7555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMLBFQrmb+vYI5oEd/xKXUzuc1u94+zfeMggUX3H4LDTgjPS2gHB66W4Jo/aLR5luzFnQYkpCfESu1EvtJneQmpHATvvze7JCNSvj6/i16o=
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

Now we support extensions saving and can let to work with them in
read-write mode.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c |  4 ----
 block/parallels.c     | 17 ++++-------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index c83d1ea393..195b01b109 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -175,10 +175,6 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
         return NULL;
     }
 
-    /* We support format extension only for RO parallels images. */
-    assert(!(bs->open_flags & BDRV_O_RDWR));
-    bdrv_dirty_bitmap_set_readonly(bitmap, true);
-
     return bitmap;
 }
 
diff --git a/block/parallels.c b/block/parallels.c
index a49922c6a7..d5d87984cf 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1374,19 +1374,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (ph.ext_off) {
-        if (flags & BDRV_O_RDWR) {
-            /*
-             * It's unsafe to open image RW if there is an extension (as we
-             * don't support it). But parallels driver in QEMU historically
-             * ignores the extension, so print warning and don't care.
-             */
-            warn_report("Format Extension ignored in RW mode");
-        } else {
-            ret = parallels_read_format_extension(
-                    bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
-            if (ret < 0) {
-                goto fail;
-            }
+        ret = parallels_read_format_extension(
+                bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
+        if (ret < 0) {
+            goto fail;
         }
     }
 
-- 
2.40.1


