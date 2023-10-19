Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D754B7CFA50
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:03:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScU-0005lX-VC; Thu, 19 Oct 2023 08:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScQ-0005jK-FD; Thu, 19 Oct 2023 08:59:18 -0400
Received: from mail-db8eur05on20725.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::725]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScO-0002g2-8i; Thu, 19 Oct 2023 08:59:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1uABb1k+P4xg/zNPaE1OkxiYEn+utBnzrNzZq+dtj/PRn/Qs/VIMjNhU985WibasPBWZ0ar+uxCgGoa51G2HaQttBOkywDaHVPAv5Rd3sz0HgptZf1hV4/sgPjL+KiAAIj7SHgnTXIcqpME6SrZhChhgK2xbk4yLVBFFL60/n/GvBaisBX15y9z8lqPttPPc3D0J+7X799wJjFqw0WEkRrunwNuShMxubf9Yl2xnNLymNS+g20iOzxq+t/kjd/22bqNzF2QbrsJZeLhHgEv8UT485LQklYeCWNNKwXv/II0a5WTo/3APRh/Wd39ha7iAmRjkeBrcsjrY7czm4OQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYGC276nRVTIguNvwpRfI3oZX12GIxnO8UajaNte3mY=;
 b=Y+msWJqK0ynmwksqecVPF6n1SEOQco9/lAjgKzHv5660Xk+i3pFZ7HVGZvQsW3PGQo4CWAn6eg/2ekCuSfJCDdsdYnL5+7zBT5auupNfCEyS8mSrkvKENOtXRTgsIYhRvgPZpi1Dr3tjvTj2R8h++hajJOKUjhXyD2jA2QdOnwNON88kWrn/bkvauaJrg/eXOWPyBsLUuCAGjQSesCmSBvLF1Dp681LoSFIhsRx6ZYWAs9o2aDhm4tr7SiF9NdbyEvNfF6DFvVLw9Ud05lvF0BDsiVSH/pcZj1EzfVQRknDsVayvboFA4IsTe5x+spnK0GX5NkO6m6XGwqoJwO4bRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYGC276nRVTIguNvwpRfI3oZX12GIxnO8UajaNte3mY=;
 b=vNY/kWZfqkMx1Vag3aDncBT79qLI889rztxitdNFS4EcG9qaTt6/NpNeFGPuYwR1yXWe1dqR2No+P7/zr08LkcsTJQJJLsWoqe/np8MpKt/eJWBYBdg5uckZJXqp4ecc//3t+n6IBac4WWg/6fLexrWgbdqUoU5c2vm9hnLmI6/KCdoC+q1YY5uSAU7gOHJ8GkSuwxkpND3410JD+f9qEw6/hBSD0fcTvhuHqQML45I/V/bbhKjGVkbPOXJZrM2U6OtZTrK/rLaugN7seNdTDweJ0NgIgFoeB3OVaigHyt7HmHf6NEhdW/4vA66h+rJ6oFlR6gGNdhhVUFw7C6q3UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:08 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:08 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 06/20] parallels: Recreate used bitmap in
 parallels_check_leak()
Date: Thu, 19 Oct 2023 14:58:40 +0200
Message-Id: <20231019125854.390385-7-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8372816e-332f-4790-8642-08dbd0a32e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yx5JM2jsiL+ckDIEU8Fzlz8dnM72Ospd4evm3RMYrtBtzU75LXx22t0NQbven4DbSR6PxSxR/YwpyS/hrVGIaj7W0UoY7J8AtnJO3Kwclwe/dg7loVrRuL4u8VNDo9bwxvK2fAMcLbF01KQXVJtLa3Eyk+Ht5ms5sC453Pusy1bf6/Gz6uuNfs5itP1SD98ry0SKBt+Q2p3Z2qrAkDug1UdkdH9RW1ewt/d9pobBo7Y1MWMVLO/+Agc8HGKBGdWlu915yqOtSbLEGpZCZIieqxHzTzXHLqskVxO43r4+Fj79SH0SVwwnD6qLChxwaA1FUP/YkZuYXp0GX0vviyGosPUOHCucc0FLDwxqjvNnlFtJG6Vey82BXBBE2tCZYFggbY0ZhEYVkCpJOl59w8NefCQRxHWv2P2xmehv9cFZycDvDFZacqN5v55RstfLhABy+O9XWTpuIez0XfQWJxT5IrCR88+O+qI/N/1Wye11VgmH6u8NbexSTfqlDrF8Qu/r3vWXw84EqExlNSuXJBL5F5IEnpbBsf2n3picMLVcBHFERC6o2FhBA/ZOz9N9xQGh7EV3oDb4HrB/Pi9rj9GN+0NZS/VpmJj54k2TP4ZlIzMSJLU3E1vSz03A4MydIBFz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(4744005)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GTHWms3KR/6Kxb2BgUciUJ4S1+605ZrOavA8m0Km34jzIJ4DPZbp/fEhXeaI?=
 =?us-ascii?Q?I/9GXi3MMqGas1RnSV+3Jw5ociTarNU/pF2h6VGg4+20+7vnOVOHUaNfqTUo?=
 =?us-ascii?Q?4IPHfVdqJWBzAHnvFxgHS7BxtkAVg2wKVmAN1f9zW9UjIzaBEclaviG3rovw?=
 =?us-ascii?Q?IHSr3eRPXLdDxvqci9y00ipWzC6E/In83v5gHmcop3jmeu9cHdnxOyzIFznd?=
 =?us-ascii?Q?tFH8XP13tX++JZveV3TOTO7aO59DXnjWlY1Jz4GGAPBf+KRYWBoMF6ZMsbsn?=
 =?us-ascii?Q?JC8+HYZO/dDinZ79IGjURZTZ9uu5QmKPhT5EDScckQDiTGg8vmRpSJhuJG8u?=
 =?us-ascii?Q?vuAW/74Wu2TJco3JWJDdWayLHFB9iURWAnDiWUSW2LWRDtUKR672x97MtSO0?=
 =?us-ascii?Q?KJnzaA5gbnZwhrkAVgt2WeN1lRm/M00bFKqHj+pQRPCGyQ43RbKxnmR2yyZP?=
 =?us-ascii?Q?DQk0VP9kifBGNJpUHzwJPFGjM0PJ5bJUpdU+YmKBiD4j6Fn2icdb75Q/DWug?=
 =?us-ascii?Q?O9b18c6UUbFTz+ZmYSntecbj/X45DB/lljL/cVJyQLWOkQVP/p+3ZIq/cHlH?=
 =?us-ascii?Q?uWzT16qwNaUAvEkrN3LtiRYdwkp5ZycdjYveOwdtyVRga958aJmVXa60I1pe?=
 =?us-ascii?Q?rTgllI7vytirb+ITV7F/qUeBuCdkkLKdQsK73s8E7eA3mplVZDHNnZcCycd/?=
 =?us-ascii?Q?Al8T9mLXLkv6an83i55WY5Yg85/Ye6dcH71wwV268aQ7yTTaLSbCmQPhBCoK?=
 =?us-ascii?Q?5Cz0v7Llsb+Z15CtH2yRR6aWVJlRHPSuy8qJegAxCKuvgPEzj36E+xvUjggt?=
 =?us-ascii?Q?imx1S0XNKONJWdsg1NIpscnT+Ln9zurMMp1l8YtDrtVHkWqeVCTNO2V79zqW?=
 =?us-ascii?Q?MNL8WQaY3uvt7eGr1bs0MNvMo//E943I1pLfgGQQzmsfZapgsWXWT/F5N6oO?=
 =?us-ascii?Q?HJzXLdnMrG2nU2jw1shPnBmzg2s1SU1Lq9bEwAEe2BK/txE13uQ2C4VaYozR?=
 =?us-ascii?Q?YhsYGbxcCi+cv40m8loZJQEw6s3VAkcs7F+cY5gL8DHcqKDXsSmN/JIRFaMY?=
 =?us-ascii?Q?xap/auZb1z9kgFFzmexQJz8v30pHpDe3H1bIO8Szq5wzarAA+nLHH0phN3CO?=
 =?us-ascii?Q?h3afpWxYOEZgyN/SSyPIADKUgQEXHcg4Y1oqWnWIQ6et1nSLeZ1V/1R6NxaR?=
 =?us-ascii?Q?XX/lfnaRp/9lEpN+d2tVu5l/ntqcBuYZCtmOz1TIyCcJkR7E8lhS0Wqou46T?=
 =?us-ascii?Q?NiczCkWGw06YB0QDX8Kt4JEPP5FlyrHjXGlxBUU+tdB3X5KVXFcKtb5TYL0D?=
 =?us-ascii?Q?5P1H/v4ftSjbD7GCj3VNIAh8m5u+vIcTHDFCwYXs/K2ZreNpLGHesE3kfrc8?=
 =?us-ascii?Q?DuQ6j8EzbeJTDPBqF+56XXIpZ+ac2rP8oVK8acbiPl33ejvKvNt9NnUxShsd?=
 =?us-ascii?Q?GoEI1X3mkA5+Npib7E+fhtRpvDCZOXxMBSjEMXITNZuyaNNQMrHFYVcZpAZr?=
 =?us-ascii?Q?fE9B5rvGxePpJc/L5NU/KA0u5hhVrG/D0ZZ61y/JXUoIDevLJAcckZqMskLe?=
 =?us-ascii?Q?sWuAQxQtHOvvyGY/TzPNrYVdZXPmEgaMeMS5T7LCajiVJsT4Sqzx/enfVOJ7?=
 =?us-ascii?Q?tNznf1+9pMDC1dmGEeebzf4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8372816e-332f-4790-8642-08dbd0a32e7b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:08.4158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8X7+OG5oXSt95hzezoxPFZiMdQU/aFT4OvCmIHy82ovk8lMvsycjh2wfYN0FkqKoHCYSESTqJqzrS/m1t1sov991+Y1Rb5H8wI/Aqq9PAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:7e1a::725;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

In parallels_check_leak() file can be truncated. In this case the used
bitmap would not comply to the file. Recreate the bitmap after file
truncation.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index ba9fc46279..dad2bf67cf 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -807,6 +807,14 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 return ret;
             }
             s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
+
+            parallels_free_used_bitmap(bs);
+            ret = parallels_fill_used_bitmap(bs);
+            if (ret == -ENOMEM) {
+                res->check_errors++;
+                return ret;
+            }
+
             if (explicit) {
                 res->leaks_fixed += count;
             }
-- 
2.34.1


