Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0047685D7
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 15:53:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ69q-0001RY-L7; Sun, 30 Jul 2023 09:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liyq.yuanqing@outlook.com>)
 id 1qPyie-00040l-2W; Sun, 30 Jul 2023 01:11:53 -0400
Received: from mail-tycjpn01olkn20819.outbound.protection.outlook.com
 ([2a01:111:f403:7010::819]
 helo=JPN01-TYC-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liyq.yuanqing@outlook.com>)
 id 1qPyia-0004vn-Av; Sun, 30 Jul 2023 01:11:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6IjqjN7XYtbiN7WbMJiSZqadQVlS89apQo9kt3fGu5Z07T5clfoN211cWxD52e45KcO+gaEx0xfhQdscq8c6FdF0YhilpxldC7KQBX0auB6S8uBbsd8Rsy/kRgiC0owDkCPEvhGzLCco00SBUU35dIEgtj2U19AZVDl9+H9agNxX3U6B7dNRgBo69cDH/h40zPYTy98dVawWQ/Rx/lfi6g+oKKxZwBSEiUFVihHfFL8GXX+ur8jMiRlKLFj65N+Cy6SXPpKS+lFOMjuLA1swFygFWKTCVw3hdkQJAGVTKWMeuopQ9xZ26GpgXaPmXE9QgoT1PsQYceOU8u2nRlhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vccijCw2wsIsnbl9JzWiPl1JaSOA3pRv2hGtf8f7IAo=;
 b=OgUOnQVZ7/GZ1nsrbcdAhDxYD3I1dlPrFO9TAft5RarMVkw+is+ycx2kIamz81KGY9szNRL5Dvx5mr6CPVJpswj+xhhq2OQlFJED+Bm/7mjPgOOT7rTHSQnQhXFzYOvFUIEGRWrvst86bBwulqJli7KRvfRI3ibkl1Xy4VYq3J8aWII8Jk8mIlxhhd+Nb/aMLwLZ1YGwjq8kxViQuTASHEz+UTKutzC8nsalFKI3DoG5WSNZBTzUOYbiH/lUAUapzZpT6VFHQ3SZTtVYiOR25Bph+3u7CuwHZxQ1q1Mwsvyw0IR29Q9QER1LAq63nLCOI8LVlnegXbwsorUml5JjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vccijCw2wsIsnbl9JzWiPl1JaSOA3pRv2hGtf8f7IAo=;
 b=dEvfrLTPzDU30+X9vckGspA+NxIMaf3N/sPXSvlWoLpL1JJO5LkZUDsgvKdwLafsB2PPasrZTA9egdfkGj+pvrUwopm/OXk1cg7mO+20TA7HmnB06YL+4eGBIAjksB6tCtMBKrPVaT6OXkbCJNya5mSWcn7/s5Mpf3jgrH0y697d49sPBxB1zOIHiQ8nCJSHlWuIljmmasOPGFUy54aUpNa5b3/YvwEtmb7riAXGw17hesh25FZBQQFHp0SCbpRo+MncRspSMcIeupD1WWPpn/HSCezqbkLzuqlicCUoMhb8YlInPJQUo/aUwCpDQ0YJJUPfAHattItGYZcIiHfscg==
Received: from OSZP286MB1275.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:136::7)
 by TYWP286MB2155.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 05:11:41 +0000
Received: from OSZP286MB1275.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f8b9:66e4:9d4e:f63c]) by OSZP286MB1275.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f8b9:66e4:9d4e:f63c%5]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 05:11:41 +0000
From: Yuanqing Li <liyq.yuanqing@outlook.com>
To: qemu-devel@nongnu.org
Cc: Yuanqing Li <liyq.yuanqing@outlook.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] hda-audio: use log-scale for amplifier levels
Date: Sun, 30 Jul 2023 05:08:58 +0000
Message-ID: <TYCP286MB12667F4B46EE030F93FFDA47ED04A@TYCP286MB1266.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [VFcGLYZJSVYrPc+NJFuA2pGQpH4ZhF55]
X-ClientProxiedBy: PH7PR17CA0043.namprd17.prod.outlook.com
 (2603:10b6:510:323::9) To TYCP286MB1266.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:b9::7)
X-Microsoft-Original-Message-ID: <20230730050948.63946-2-liyq.yuanqing@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1275:EE_|TYWP286MB2155:EE_
X-MS-Office365-Filtering-Correlation-Id: 014adad0-406c-47f2-b7f4-08db90bb7456
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuxdChb9ogMU+j5AmjwrMOjvvznMakyRq7E7MM9fkAt4AmA7+EuL6Fm5g64qK5r7/azh48ZjIme3962FGeahPhc76oSYQE4eqNpgrV2n3xCiXSD+9jUFS6tBtzCc1fq0wzsl+duSmgIbyZOxJb+S28up7DKMZKn7OvAbflSrJl+KUui/++rFzMtkxqVTcP6q8q8lM4uxhAQ0erefTO8Bd23/cBOmD6jyAsBYF7hmG1FSTGEkXimacZFf5FyKr0E5FmtT3KvDFv6D2i4nzEbVPBM2Rl5MRftk9AGbNUborMvursg9Hu8kROxCQko0GFQ7Gh1U8/682jfUGIPtmvBlo/gM6h2KUPlnzhtMH9hvU5lFA2ahbLlYp4/KQI+PQBJlaGjGblPMZiIclElrgzdTJhUPjDsSvwkNrpvUt/cR4BvGxAgs5AGuPDHMNeV/ZtfdI8UiR5ZGKsfitkYTxAYEA/nxVVgIS6O6zlyZK3vxBS/uzNESYcAFwQj9Khq5u/19aO2OLWQ8V4f/3ULV9rx3YHrB4/ww84waIeH7pavxiTf1WOPXaIkppF34ial3DUaPko146FstJib4dyAif5oEToZjpOdlUj0Zvoj0nJ2flrT9AUfAoqBSJLCzN2e0iFSp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W3178mc8jONwVESizgoqxsW4oM/bXGAeXfEd/Ryoa/H/Zl3X1f6Sz2iK8ZkQ?=
 =?us-ascii?Q?iOB9P4m3meYQzks563CVgRVtatSJI3OUT0okQeayVvzMSaY3o+ijZ4ueCZ50?=
 =?us-ascii?Q?C4yBeNgA85f8JF/pDOXSOMev1hFaa3L6IdyBMpk2V5MvNA35j1a4IzTxnVMq?=
 =?us-ascii?Q?GI1E1147u9++IO2siTMfGh4u57P5yA34eNkGI9jJAkK2m0q+odJ69qZULCqo?=
 =?us-ascii?Q?9aSbl6vffrFYjMN7gqF1leWOe9yQztjSBzdCFJ65wH/sPIwH23HpKZOXAJf5?=
 =?us-ascii?Q?Rh9U5FmjyJnN3U+Y5x6TxoKmSlDhiI1BBwgln/ZQdSZ+Q4z+btytjDvCqhpA?=
 =?us-ascii?Q?P5J3VEBCUtnF90PVWfHEREmQFW3RT2XlnFqvgHVQ3Yelooj9bDI7QqexbGT9?=
 =?us-ascii?Q?/F5B4b/3BVRlc6fhSGmStO4yQlOA85uebiMjU53xDBSojj0US4F9cPYNipSO?=
 =?us-ascii?Q?tLvVYb4E1aAELqC4tpUeClr6JLg/8wzM9XTv2qdJp3/NaiABlN8CWriOeGun?=
 =?us-ascii?Q?TACziOHmRwYBOeZ99XVYGlUYRBss+172vG766rflc2LFYx5PGnZytW4e8bM4?=
 =?us-ascii?Q?Z1DJFfddjKaOzu8OVwrEN7PLIQuJ/iiTXPC0z9vQwtS2Gprqft0kUjVYBGEE?=
 =?us-ascii?Q?UhUpA7s5xSisr14fJFJOXjQKTP6FTMbIFYkx/hkx4vzJkABrKEbTrTl5WO/X?=
 =?us-ascii?Q?rpPLn3PS9Uuix/bQtlO9DoDvM8RADW2bIjTM7ZQHoQrVsRr3Nsv/MtjjQ/NK?=
 =?us-ascii?Q?J0ffvpFzZS6DSptwXNiNWACOU7G6Mmieb6sSRAgWBCEn+xd6527oxQtLzPmr?=
 =?us-ascii?Q?EB2t0Lf+Z6mcquPftIt1FHO1EwWOiBhvdrLRD733eF9caGDM+1nbO8TBJhKV?=
 =?us-ascii?Q?P6eLtPwMLgxfks/GU0fbr1H74Cx5X2SQ0NPwIeInxsUk1XbtWHFtW9o1/dkb?=
 =?us-ascii?Q?GaKhBW/sgeqRsHjdgDjvTK3mYrwCpTcfq72WSGnhszDwjiIbGbvQQ9neAvxg?=
 =?us-ascii?Q?/RdNlZNPZg/X76VvBTyIQekET3gP99oyrvkw1iq1D3qWTckHc01Zj43+N4Yp?=
 =?us-ascii?Q?aP3QpHCCDcCl7veNyEBfQQYmz0yS5uvtZMgk7iQZUwJGqki1A4d7rHvRoMAk?=
 =?us-ascii?Q?ggSuq+a1XXr7+zkN+5YSCwki3y7EZDI1B2DqtlFO4+knGIm8asdzBb4OOfLN?=
 =?us-ascii?Q?rxDfDdEZxYAbgy7B9Vq+GDrJZmHGCNkFKEzp/fbxbuMIKmHHCfIjFX3DcDw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014adad0-406c-47f2-b7f4-08db90bb7456
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1266.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 05:11:41.6128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2155
Received-SPF: pass client-ip=2a01:111:f403:7010::819;
 envelope-from=liyq.yuanqing@outlook.com;
 helo=JPN01-TYC-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 30 Jul 2023 09:08:23 -0400
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

According Intel's High Definition Audio Specification (Revision 1.0a,
Section 7.3.4.10: Amplifier Capabilities), the amplifier gain levels
should be evenly spaced in dB, i.e. using a log scale instead of linear.

Here, the hda-codec reports amplifier levels from 0 to -48 dB at 1-dB
steps matching the 8-bit dynamic range, and the -49 dB level is mapped
to 0 (muted).

Signed-off-by: Yuanqing Li <liyq.yuanqing@outlook.com>
---
 hw/audio/hda-codec.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index c51d8ba617..c2aa71624b 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -121,7 +121,7 @@ static void hda_codec_parse_fmt(uint32_t format, struct audsettings *as)
 #define QEMU_HDA_PCM_FORMATS (AC_SUPPCM_BITS_16 |       \
                               0x1fc /* 16 -> 96 kHz */)
 #define QEMU_HDA_AMP_NONE    (0)
-#define QEMU_HDA_AMP_STEPS   0x4a
+#define QEMU_HDA_AMP_STEPS   0x31 /* 20 * log10(255) = 48 dB dynamic range */
 
 #define   PARAM mixemu
 #define   HDA_MIXER
@@ -433,6 +433,14 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
     }
 }
 
+/* first muted; then from -48 dB to 0 dB */
+static const uint32_t hda_vol_table[] = {
+    0,   1,   1,   1,   1,   2,   2,   2,   2,   3,   3,   3,   4,   4,   5,
+    5,   6,   6,   7,   8,   9,   10,  11,  13,  14,  16,  18,  20,  23,  26,
+    29,  32,  36,  40,  45,  51,  57,  64,  72,  81,  90,  102, 114, 128, 143,
+    161, 181, 203, 227, 255
+}
+
 static void hda_audio_set_amp(HDAAudioStream *st)
 {
     bool muted;
@@ -446,8 +454,8 @@ static void hda_audio_set_amp(HDAAudioStream *st)
     left  = st->mute_left  ? 0 : st->gain_left;
     right = st->mute_right ? 0 : st->gain_right;
 
-    left = left * 255 / QEMU_HDA_AMP_STEPS;
-    right = right * 255 / QEMU_HDA_AMP_STEPS;
+    left = hda_vol_table[left];
+    right = hda_vol_table[right];
 
     if (!st->state->mixer) {
         return;
-- 
2.41.0


