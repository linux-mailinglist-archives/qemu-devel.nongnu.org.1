Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F3757981
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:47:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiCO-00023U-Cd; Tue, 18 Jul 2023 06:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCM-00022V-3R; Tue, 18 Jul 2023 06:44:54 -0400
Received: from mail-db3eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::703]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCK-0001xm-Mc; Tue, 18 Jul 2023 06:44:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE8qeWh/7u0+Z38F9e0oyQJQuB0ryIj7rb/e4OymLQwVI+eMWblcpoMKHSB65vwhdLNYGx6oHhmDpXAkEgDOzvp4DMAoeRH+Zj4RWLB/PlnaIkQjC5fryne6GN724T6Ok2muK37zG16GQEmTPecqe5QnqTtjhZEgtJdvbizhmRnCraNKafwwxYG9O0z0BflL7b8afJsu1s/cokM+3zwYrBBV3hkXYyjs3SeF4YPetFXSpOn/I96GCl87JTOnvFB+QWufBzx6HbInsDlMu/dzJGswz8q9xShNB07rP8TLo5V+Ttpk60z8YdHLz10cZRO/75Jp+HJ8O7WArisrltp2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo3CppeSMM+1BXWZY6EsFr+tgAetQN5B+M0ldLNK3tA=;
 b=d/6K30BRE+WNJuY3CW5gPc5o6KPZutZKvTfs7vV6NDVHKmVGSJlqqfafNnI6KQXhb+C6NSjKKrdz3OBq6X6m57p7z1j+wz22+4xsztBvEemm7cW4RNwJCByq5IOIIp6E0I4xVekpGBusAYHEo7JW4uwg0Gl1dxfUq9dJwVTkWj4AHa2nGJlXpLpJJRCHR+BoxAa5jUOFv4MMqdXPi06MNnxlW/YBmruiP29riy3HQk/aR1siwGaEh2lACTgbJ6/+r6d8YvLutFEDs9FtkB2Lain5bjFlekqAbPVw4BYvgmzrzCgZe639IZnBsmL5FlVzU1py4HQR3jBnP238ckXMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo3CppeSMM+1BXWZY6EsFr+tgAetQN5B+M0ldLNK3tA=;
 b=vmFa8FW/i2ZI4KXFhQ61AYMgDhEE+dM6yKzipriqc0av4KjSxyJ+UvI2Qyb7xuIii6GbY0ng2u3E0Z/ZhXGwq+3Nd9urpaQz2/ip3O6bNLNf5CecGxZBjRHKQ6wscqztYPlOx7pKfoUXHjcjXWMsz4GSzQzj4T8BaNqE/ZFq1wROjy/JGTy/gm9chAvfmzkzQNjMWMNheQiyceNKfp/+uKnXwpVXV9b+CDYg9wS1lvnORkqxnXyDUfpvYstm3IIyr42d/1hT/s8Eaae2rNzFHDuMPLZ0HB0X48MjNB98rdoYT9iVuhMdFTTzVB90HkxjprXr8CB/cu+8POZUbulICA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAWPR08MB9784.eurprd08.prod.outlook.com (2603:10a6:102:2ea::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 10:44:41 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:44:41 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v8 03/10] parallels: Check if data_end greater than the file
 size
Date: Tue, 18 Jul 2023 12:44:25 +0200
Message-Id: <20230718104432.1130469-4-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
References: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:803:14::14) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAWPR08MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d960b0a-f03e-49a8-6134-08db877bfd9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McXvrakob9VBVm/deXBrQnueTAS7bYNWi694IV6fDUhYmC92R54KQsDrnPNCMBz+N9Z+edb4XRRe8aD3T9ADHGXoBuywMEBDMG5+3xl9HsQPwmJMexP441YORswdQADp+wT28tQvgkxqqJf3paTH1GcqC8TfS2Wz0k6PYUtAHRTFBPgNLsyBtFIo/S1Ma5DU4q9+Vs/XZ/uoxU0j1z1nWN/7/9+r823us64EI8ZzsNdTODDFcvXP8+5EOZPgRcC8uS+CS8WtCYPvQdbVY/cjr/nx58CseanhZsuCyFf0NMoOWgGeNCIwnpyvrkEavTSrJGkYnSy580CdEdB9ZLpyrUUkoN2KlAEJvdZdc3Kl9kckNjNCDjg45aPmey1QpXFfOpEMaon5grApmfHRBWqywKSokGJms26gm1RdhfCeILAzmlXtCgFpkcfJf6MBW8ISgnBtbK2CmI3SQ2d8OmCtdul0VX94OjWe+E4/LaIExgiiDQqvd18t+YN9n1AfMLrigOwlSWgpwG8AeWGb8p2EEKRuqWcdRQmiBFVJi9ERjPtF7LoHFN8wWsqC15P1ohkxsmJSUIDJpy6KBVKRPrJdcNKSE1vNhBx0ZUmP2/BDb6wk2/ICpN/bIWm83/fUL8Y6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199021)(478600001)(52116002)(6486002)(6666004)(1076003)(83380400001)(2616005)(36756003)(86362001)(4744005)(2906002)(44832011)(186003)(26005)(6506007)(6512007)(38350700002)(38100700002)(66476007)(4326008)(66946007)(316002)(66556008)(6916009)(41300700001)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ApSH2o/zkvRwYnsrOW48CkrmhwpfZtRE3N3xhVNxRfSNjNCe1f26PbeujQDS?=
 =?us-ascii?Q?2judc2S1cNvuoxqAqoFkw2uJ23tWqtrc97qEJMNwYb3SuVnrp7047SyOqoMK?=
 =?us-ascii?Q?79juAHjpqrnzq5qNKHE0GSmIISV+/1OoCw2XgTH6PA2bYryycMqwQdvFiuZl?=
 =?us-ascii?Q?dHZq0Bs7nK4xC+I1SNIDRUrI36M6lNErmMpqFiK9aOPcu4GAB4Vc4NHhLR1h?=
 =?us-ascii?Q?gSLrB8nwZw5bNMsBMDkYq80Y7eujjLS6+RE3lDDLPD1QLBuVWDaibCLUa5S0?=
 =?us-ascii?Q?cfGiadwT5Zkng/d5kG021RHAFsmll34dXvnuC9Sk5h6E1dhODLXjs0lNrWeP?=
 =?us-ascii?Q?w19DcVsv7cDE2ktoLYj7nZjvaga4SgUrir17uEBiT/r/WvWfW4Oz3HEMTc1e?=
 =?us-ascii?Q?DixDaGHej/Hji4TRoh9YRdyBGemzC+OJNurjEiKuP/prf7YnnZimqSPnJ5eG?=
 =?us-ascii?Q?h8pRaRMW8whqc+GErvY44AO0yOh+aa52AcgceNCFbCVq4QW4vHCT+Xz85JZd?=
 =?us-ascii?Q?+mMp6KZeqmmNY8rIjswKwQeeK1g61MGM3KAYPqC2JfeFW5st9gn+ZnbmJoS+?=
 =?us-ascii?Q?iLZk7sqsKcJ09AOpcF0xJgoyO0VMZslgnYlV5LByc5xDyo52kTRhDkxrRKMr?=
 =?us-ascii?Q?CCZYkJlzvOlro2FWrHBJzaZtWOjdI11XPOxnDDko9fF7W7cBOpAX3YEOmH+7?=
 =?us-ascii?Q?B8pN1lUMXxfNPySjGq6q197cs11d1qtv8DeVyZVFwk6ui0m8Kz2c3SY6sLQ2?=
 =?us-ascii?Q?Q6LfNXP+6j41LuBlG/e9kocnAe51XxGztibkS7lSy9mnxQQ34Z/bxGbQrDRp?=
 =?us-ascii?Q?WaOUivLoKIGTjlJOs1Ai/fyKny/7flV9LwPu2l1pU1RFaOmZPZc9RNzB9Wlr?=
 =?us-ascii?Q?F7HxtwnKumwdvm3SS0CVzlna5u/eUFt2hFhDrIrbsv570crbi7LVGy3Vu7sz?=
 =?us-ascii?Q?Tl508Qx3xxfPBT6KtjmC+5pCy7ZxZsUcAJ5q8fLYsGffrY26mhLpeH65Ur8k?=
 =?us-ascii?Q?LOlsYgyZPicG3YVlTzSQghb3YuZki9E6TjtTVrp79Uqkc03TnAqu8Ix0ued8?=
 =?us-ascii?Q?XFFUD1fX/HL9jpLhpi7YV+7NIvzpObUmZZz2syyLkdDqYpj7V3cii4PEwmNy?=
 =?us-ascii?Q?RgSjY8ivFNi7EqR2MKRFxwWFQeunYX9Y1s4usaA1CZY41CsZzzEvK8eaRRYC?=
 =?us-ascii?Q?8WNG+wbb8TbuqJrV6KzpnIodc94pgY4jML7RoSbtd8CWjgjGbKTDv8SNaem6?=
 =?us-ascii?Q?LbIUFEfwvkXOhnn1N1zWMmXFLx+TaNYF/Xs779NT4bnvGCbuz5x9PtwSaUa9?=
 =?us-ascii?Q?4x2yCQS3WbHUBv6QAspu7f9Hv2V3a0QaMrbpHyb3wAFTl8CyrUdk8Wco5GwU?=
 =?us-ascii?Q?w9u9/WhXwDnwD1tzSPrunll52rN7REcwaMWDLOEUy/UXcIQXEs/8wlVoHMKq?=
 =?us-ascii?Q?SFI0H1IZc46mduzPhOpTZas2wT1q/yv2OWSpRLDPlxb3yDPqeGyTjKEDD+lN?=
 =?us-ascii?Q?DgqPh65dscrvdCF2bOyNJfy/miNFT0Qq5S8+AR5L+eBlkg8ypjku8WmeqjtC?=
 =?us-ascii?Q?kOyxSyAFGQwE2rsn3672PL1DKZ2UmSwWBVIK7NTVGgNGrBqR9MKMUwXgMXTd?=
 =?us-ascii?Q?17s8O2/u/pBV+UHQbG8vRy8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d960b0a-f03e-49a8-6134-08db877bfd9e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:44:41.0159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TP3PPCeQ3uZs5XBfylI7oWsRR/GWoHS2f7WgO6g/zYAY5oyVTApjdNQi/csWFcjVenyvPF3HuZCsECljyjAoXozta3oFbBOCxnZsYNon9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9784
Received-SPF: pass client-ip=2a01:111:f400:fe0c::703;
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

Initially data_end is set to the data_off image header field and must not
be greater than the file size.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 3c0dca3dbf..6a3d41373a 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -874,6 +874,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
          */
         s->header_size = size;
     }
+    if (s->data_end > file_nb_sectors) {
+        error_setg(errp, "Invalid image: incorrect data_off field");
+        ret = -EINVAL;
+        goto fail;
+    }
 
     ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
     if (ret < 0) {
-- 
2.34.1


