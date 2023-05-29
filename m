Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF64714CCB
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:17:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eai-00046v-Kj; Mon, 29 May 2023 11:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3eae-00045o-57; Mon, 29 May 2023 11:15:20 -0400
Received: from mail-am0eur02on20715.outbound.protection.outlook.com
 ([2a01:111:f400:fe13::715]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3eab-0003QL-Tg; Mon, 29 May 2023 11:15:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5nDSLmjVz5sfCH3YXHNbm9FdnIiTgfS4j4CxUgC2P1TEGewteX7bir9c5aNA+beCLFKXnLhMssV7TWqH85kRGtP3NtphaxMKpKwzJfcwoZEYcUsmjeIrDqS8NgMxCY+A9eB6zCFwb4ryR6Hygo5Dexxuk5RUF7yZOQAKVqMTehyhLhpy878JmJXRMisxqtmSwqmyCO98BzrzMzfAEdAvLSljJ1UoKbWTNd2vTWhOcSungz/ec4XJGWbLd/cOA+2f1vptCnMXbabJK06Jh+2J3wLX99BOeqt7dGAGz8B6Tlqz1SaeIgG29SLUriSiTL1yZQDoeMQWYmcu96AMlZeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZGG4BPO2k5OO77LErlJtgQCaRWnKjE/02SWPzb1A4g=;
 b=BFsAPtcDCihF4CljMujMDv1udYYx0W6KZ3cXfRi8d43a4RtBVHL/AhCYm5iROVu/Rk83QNQTTLlfVlkbjdONZu0FLgLKGWtmoto76SzTT8VlCe3K7KWvkeLO5OErg/mmhj3x3FyhhK3C77yyFL62o+xLmT0UpkdZj1YoieMXF7bKiII9XwTkJilf3oYv67M4FpmGAw0cBEpFnG4Z6XZJsbI1zRmX/NNr0ZDfA5Vnhqppp6X094f96WNsvm/F5hRcpZcmHlmAEHBlRWGZ2+fXQFflguXjwIsmUSPIIhU76gigHJsQp5vNygb/9B3XRIEgp17gUofClupv6mKMm+EZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZGG4BPO2k5OO77LErlJtgQCaRWnKjE/02SWPzb1A4g=;
 b=HlNOOLjMn7z2Gc/8ayAhJzkLW0D2jaDVR8INwNGSq546LO2RLMK+07hr99ZulOb/AaJ5bZxfGBvzsSVp7DWjdPE2VAaWQY4xGB/yj5Ee4Kvtn5CEoqtXXxOH/JE+hTpIW2/QLgDWizaONzHMClYDIxi0pnQlGQqMeZZtdNXgtNiinc7mTz1J4Vk5ot4lHoSpYU7HnmsJHRh4F+vrH+y3aOgm4PdlycEThlzdUUn8YL3OF9hARnhupNDd7ABjnJT7R1GsiPT1AgXmU9+9cYohK0gBLODF54BottrPDLAScHfZf131Ex0H6gvhxI2SV+GQ9l8PIqATlJWza8cclisfHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAXPR08MB6382.eurprd08.prod.outlook.com (2603:10a6:102:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 15:15:10 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 15:15:10 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 0/5] parallels: Add duplication check, repair at open,
 fix bugs
Date: Mon, 29 May 2023 17:14:58 +0200
Message-Id: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::8) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAXPR08MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d95be9e-5111-4eb2-63b1-08db60577ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EH9CHaPBMqVSiQpywS6ux8n85JQtUumUFOGyD/GVM6m4ZhbGBxFvGIig+8DGYzc6s5S0hMTjNjQjAIcQnyOBbs1u9LKg+88o4wOLBQmG/KRgZmvZFcAQ0IDh/rPhrZk2OeuDxNGDrSmyHeI3Ze7IVmyjDsh3UhQjlU3wXDyxFpyTdcP1bsw/dwyOmywpmDeGfPN5q4bnGYcdnTGw4108wbzD2gvZhag8oomUOkvGFQUAjkgaM8BO9C0fDgtHBKKag9Y6CJR+E644zoSRdxWgCmNffqYMe5V5Jz4wVc2qm7e1OcTrOX2w0bvnLR8rCs+b+iHN9VDEbAq2+sUlHsWP1mKJJPU5IFMmQ3d1ufVXAHSiA3yu2PZjQmwI+8WeBIhao4GDEm7/96S+YW7Qz+Rhozw/cvkQrvuCL/zuNie6Lt69qzC1tDk8X0siChDKie4w5Hw/SKzl65NqoUevrkzZgs4cZyiiYnc+9Rz5erRdCyjJrHezjAINI7bfNfUdInwkqSgnmY3y3mXc2O8zKhSNBXXJvGaJGugHyE/YOlxBI8FkAaihniDiLOQmm0hh5B7TfMmZdvZ3EO0gRFun/VNosA1dnQ1RBAc2SUX8e3zBMexHJ9PyuYLotD1F7TScfG7c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(366004)(396003)(346002)(376002)(451199021)(6666004)(52116002)(6486002)(2616005)(83380400001)(6506007)(6512007)(36756003)(38350700002)(38100700002)(86362001)(1076003)(186003)(26005)(2906002)(4326008)(316002)(66556008)(66476007)(66946007)(6916009)(8936002)(8676002)(44832011)(5660300002)(41300700001)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3++qY2aKJgaEPovzfBRiwSiYJiBi8M84FI01uxeB8xXXagqL8QYS6SUekA6o?=
 =?us-ascii?Q?1hQPFvIQNhnAHybLc/ZbKIRDo8mZrZ55hNMuu/E2tLY+Edbj0FT6vWFM3BgF?=
 =?us-ascii?Q?KUycRWmO8MCWP3uQvYm7IkaD5iDvDdwa9k2fxpxot6tV07OdMNf2qI/thxIs?=
 =?us-ascii?Q?/QFpDL7Dv2pLyEAcZqrVEFmHQp1aTseZ/N++sVuTCxkD0CpXLuCqH8YnBPq9?=
 =?us-ascii?Q?htbNiHNZx6N5KVRL/NCMU36181FuTVXEMUSRpxTWCFXgQj76JHGXSTPZw67U?=
 =?us-ascii?Q?j2oeR53e3sIgyjbrgjQ46zPMNjxqysEpDeRamru/x/95IQKahbEJHjJxEfow?=
 =?us-ascii?Q?DqtPhSAraoIqu15BbFOWoIyGwddcaRf8oMLxQ4/CjEajL/HKPuFEwLaKYyT1?=
 =?us-ascii?Q?z1JCCDYD2RRXkZ9KSiuBhmsK1M04fA5TUijAh2f/a4c1iXA7NbuOAy6hLvXn?=
 =?us-ascii?Q?hSwhfb0OWm0MXGlmU+JVI6KCUDWwwNgERcaNJkOOPKdrobTUBzMVdLiMpf0D?=
 =?us-ascii?Q?h4f8MrfGyzLte2l24YJBBFTizvsTw3SAOcTKN6/lTwPiFehFnJ0r7oe9dcvd?=
 =?us-ascii?Q?2cgU0/G/pq8tWXa1wryoMfsRGyBacAfYE3C9n+B6HXYt3SvDdlU8sNcA1/Ej?=
 =?us-ascii?Q?CBpvM5T/HPdbijZx4vcWNK4/7IbS9QIDXSb/SyaoraRzi09KRCw62bucCRl5?=
 =?us-ascii?Q?eZo3QdkyyBfG4C0EO68/tYRFKDOA38DqML71HHPzU5EYM334PuagohyMOXUo?=
 =?us-ascii?Q?rNCg8CD8KI3Yz7UT7hNNnza0+vJbWsUgGKw9rfrTnblciHDpqq1hnURCqblO?=
 =?us-ascii?Q?93gc2H/3flTT04waWpvMw3NHjc0pKpLhNhxKPQeI2SkUpz8XOY/GJpMJnAqu?=
 =?us-ascii?Q?OT/MQKi/3asfIik6uLcGGS7xMoFqOEckJ7iu4Or7OUt+vzkOf76sQ+buflTU?=
 =?us-ascii?Q?expC24VWIfu04e7JrYn7rRbkydLw5NemCB72PD9iV8lRxGpPYCII47vESdeX?=
 =?us-ascii?Q?FhGnr/0vSAsrQNvK3hsDO9GTZ7o2qYiPGT6Wm6klzhOxNrZOG+Zf/ZxzGpYq?=
 =?us-ascii?Q?h2mv8TYsVZGTu7mILQqAiYMf5Jx1vGAlq4j0QINQTe/RB9Ex1XqNGspp+J85?=
 =?us-ascii?Q?M2aJgeSNFEJ5my8ZGwB4FzDSTfDGj0z3tObYn/4qXmuFNakqLqdMLIxNfoo+?=
 =?us-ascii?Q?jZsfwI8x8GooV08Eo9nlZqCx43T/pt4++EmHG041Q72owNhZgNrzSC9qz8Pa?=
 =?us-ascii?Q?SzTmJ9xZEcm6wGGZidpCmRuzujP/U+1aasphHf4kycJZ3bTvcQYswafn7tPv?=
 =?us-ascii?Q?v7m7vFlx8ci81asK69aVQr1AmbX3+cQrn8/Ok4ZhpUpuJyahrnKRnubuIKCA?=
 =?us-ascii?Q?aJmcZsfsVEa//syzT4ecVoSK7gBG3PtjmP306LOkwrxekXpnu4k36Xyl5/yQ?=
 =?us-ascii?Q?EeMSzLZya+NTJwfLHsQ8fGfKMEKZVpW8dnwuY2xJIVjnXTAxf0wvywrz8dRz?=
 =?us-ascii?Q?B2TEcojLoxNKIPG/BVcL4XswjXLr6YgKuc11ZB8AgCdiAOCTkiKAXLH4xPEa?=
 =?us-ascii?Q?7PKkImu/DCUrFSZ8/+F7G10V7pw7MRL07rooocLPPRlQLYwYJBLPNbhIAQ9z?=
 =?us-ascii?Q?x7Vm7IdGHkPZ4rz2GDXYww0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d95be9e-5111-4eb2-63b1-08db60577ead
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 15:15:10.7838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IJCLsDI2LNc+CjfYAOUEdAmLTaRqMOU5hPxtfyYmspW8kP0+JCCkbLiQnVn2aYqJb9BuzsR6GH6BFF6BFGz4RMzcSKWSdgpYg2ro74x3qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6382
Received-SPF: pass client-ip=2a01:111:f400:fe13::715;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
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

This patchset should be applied on the top of [PATCH v11 00/12] parallels:
Refactor the code of images checks and fix a bug.

Fix incorrect data end calculation in parallels_open().

Split image leak handling to separate check and fix helpers.

Add checking and repairing duplicate offsets in BAT

Replace fprintf() by qemu_log().

Image repairing in parallels_open().

v5:
3: Fixed a byteorder bug, fixed zero-length image handling and fixed uint32
   truncation.

v4:
2,5: Rebased.

v3:
2: Added (size >= res->image_end_offset) assert and changed the comment in
   parallels_get_leak_size(). Changed error printing and leaks fixing order.
3: Removed highest_offset() helper, instead image_end_offset field is used.
5: Moved highest_offset() code to parallels_open() - now it is used only in
   this function. Fixed data_end update condition. Fixed a leak of
   s->migration_blocker.

v2:
2: Moved outsude parallels_check_leak() 2 helpers:
   parallels_get_leak_size() and parallels_fix_leak().
   
3: Used highest_offset() helper in parallels_check_leak(). Fixed a typo.
   Added comments. Replaced g_malloc() call by qemu_memalign(). Replaced
   bdrv_pread() call by bdrv_co_pread(). Got rid of keeping bytes and
   sectors in the same variable. Added setting the bitmap of the used
   clusters for a new allocated cluster if it isn't out of the bitmap.
   Moved the leak fix to the end of all the checks. Removed a dependence
   on image format for the duplicate check.
   
4 (old): Merged this patch to the previous.
4 (former 5): Fixed formatting.
5 (former 6): Fixed comments. Added O_INACTIVE check in the condition.
              Replaced inuse detection by header_unclean checking.
              Replaced playing with corutines by bdrv_check() usage.

Alexander Ivanov (5):
  parallels: Incorrect data end calculation in parallels_open()
  parallels: Split image leak handling to separate check and fix helpers
  parallels: Add checking and repairing duplicate offsets in BAT
  parallels: Replace fprintf by qemu_log in check
  parallels: Image repairing in parallels_open()

 block/parallels.c | 295 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 232 insertions(+), 63 deletions(-)

-- 
2.34.1


