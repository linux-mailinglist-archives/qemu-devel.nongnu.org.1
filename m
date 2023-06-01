Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE571F5EF
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:30:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qnG-0002el-Og; Thu, 01 Jun 2023 18:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q4qnC-0002dU-L8; Thu, 01 Jun 2023 18:29:14 -0400
Received: from mail-bn8nam11olkn20800.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::800]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q4qnA-0004sJ-71; Thu, 01 Jun 2023 18:29:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT0Hy5rl1KkzhmUM9RcPuSrLPaTHGs1JJFwX84bBk58Yj2+OP8Xb6ugW77+whPeXwrMpq/RR8aHJ78K0EB23wKsf3j2x6q/anOUivvd8+strf+eTB2SpwYT15zVfNq2IUqG0YtiwMjskDlUfifLY7MpFM/trxyp6P2GSoqngqcwjml2MVapY+munBnldymBKzTJB5jL9lYoI73p0XEw7AYUC+zCnVgzapMJqDbTeGsZJ5ts5Ew0paf0vDFfCfo5EmYPhc/950gIhdijWZn4VG9dN0WWI5Wl7/U9BRBGDxolITuBRgooh+TrrwMV4uUCyz8YdsSCk8huoK+BHzhE/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofzy86fv1JAB4tbaMqMQuizFKU69szd2GZ6Egdq+UYQ=;
 b=TOwnncLcj5Z1MlaRFSgL76g98TrOPTtsttevbt0tGV9A4cDlSLVKwVwO85K9Ie5ogxlYoAX8Fs0hhP8hGTcv/S9XgDzPE08l77Zq2qpiOAptFh2FtAaBfqIU/czNfZjq+HE+Gq8JYb/mofXxVCOEdww6EXtE/KXcm09EoBoNKriGlrcdMDdj64qOZyJZ58JrfVEQSTTiIUqU+cxklfsqhJUlt7lEXJCe28ZFGgheCnanOAYb743d3eMgS6WBwnBb1v/qYUKO+uHqiVuUKl6AEHK5rWg3yzD6yP4DG1bw7r6D+g35E3K4+R1qlvwIZEYX69ReE7Vdz4QB3po5qNJSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofzy86fv1JAB4tbaMqMQuizFKU69szd2GZ6Egdq+UYQ=;
 b=i3AZTKq85xxD7jMeaNyVqB8uzr98cJRdsqdg2XJeUISiS/CRBN1vBcbK7Obx9N5lWrj7Ez1s3Dpget5kN5bTwqFUD3KdWpH+0krikQcClAi0ICaceawyNhmlMK63nNsQ7agqlxphx1UxbyZ5yZs4eLNNsGnZ+tj3fO9MVMTnOjkQEeg4T+XkUU07Xx7IQwEl6M8/Wl135kpHuljQRIyOxCQED0yUKJ94rt3GUQdL9CAB3h5yhNhAPaLcgioQjSdFDM3K6f3PmymxPi9Pn88yGjesGKvMJFraII/h18GbvU7F507wN/kWgprVR8z69O+3hGcyfMoDSU7L0DeQErYHaw==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24; Thu, 1 Jun 2023 22:29:08 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf%2]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 22:29:08 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH v4 1/2] target/arm: allow DC CVA[D]P in user mode emulation
Date: Thu,  1 Jun 2023 15:11:57 -0700
Message-ID: <DS7PR12MB6309408A6BB4A469862CCA34AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <DS7PR12MB6309FD700EF00EF1EB541CA7AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
References: <DS7PR12MB6309FD700EF00EF1EB541CA7AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [s0UomxEUSJRSqg5WZuvgXBKEIGak6LOx]
X-ClientProxiedBy: SJ0PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::11) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230601221158.48705-1-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 539d1aa7-2992-4e3c-e876-08db62ef9d44
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmo7HDJh1DrTtBBfugGKTjxKNzyt/Mu7Cb6bY/Q35eL3yuNVZTvglCTg6jl0HUaJ1rgooJ/TT7cXWF2YrBujTC3GMSX3uiYu4fQk2wTKXCo4pDGXpQRn5a2R6KwKIc1yO8GlQC5MR5DpgF9fH4C2MCS05hYWndL+aeV3Co2KjSVMcWMw/JmNZ5dkTtos+uZvigKL75ol0LamaYCNbqOdv2I5yedwFOW7wHsdTrVDyjZbsb/bIFteBY68Vw0oliDZXXWr8oQx1lAJnVHoLzu8zsy8UubpFLUytPXz+QzG0jzFmE8XjXSdPt3tOvNUE4FmfCJ1ViNUWu+VO5KXUJrLwp4eqi1QvLC1ixVFLKByEN9y7wrbJcUppwvF5T5Tn2GIETNHarC5Nk9MULo1Fi1SMTA9vaFbp8EGvnSZ++PtbBQzpuNxIcYook4H8/ZwyoaetuChRcZM1mUrYeIcS0fAG5y0eF2wQ0cvgBJe3VuLPLyEBD/vy1/2VLil8ks70Eyvqsl70M+oveVulofiyLtbTYa1jyUIoqALLOAFmwKtLItM6+o4/IM4znSnsu8JgAjMPU5rN1rk+r/uSRb8J3v2xmu49SbLgs/mhAZJFNGa9yoLdW+Ds3pxQc/2pIkHhLUZtTYVJTTfszJq+dAAKO3nVkVnhSf0X6a3K567Kp12nDkMPBWewRPwbLb6PFReTtX7G9FQQWVIZBpZ6m4Hnk0JF9fCaSA0sbfiKfp3jQhoQeadrWQS7UQZNj6xlBDjn9DwfCU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWd1JxkGhv9e18CgRZBKABxmGy9NAkg3mEa5ksy8+2aVwV38dV3gvAOi3wi0bD/Y4MI5bzjQP+lFk/T06WCjbs4MKAJ4K/TU/GLivN9NG0hcT7husxauMz8QxkeSDYuUlLgSnuC1FBsS20M4yYW3kN60zUZrBwBBxmjSzj4ryiLEW0dMLBGo+KGSy29BHjrkMCrkiMGvpDdka653Mh4dAclhCqfvTT2FwmCB8muqt7d7xzTT5JIdMfolDfyUj8YbKyrigzeFL+RTjU/ycfIANaQr9w50PJI69pg2ncd1up907/vAiCS2tID1zQHXI+KthrUjzP4+OY5ZNeYCD98H49CIm90dmbx9u+wGdAp9Rg62GgQCcJ7ZXi9xl7plc57IhmhIqjujr/t72S/7bOOFrxMWBgHzF/qpGgW0f2rFhl5ham9IO4Ve5cqbK5dujgMurfeavKK8ikUb1tXVDfihqm0+WDadfzMWBJpDsyczun7kURREBJNrxVSOEwlFSSizRqCYhOGC8Gk/XZ4B7+aj7h06h95/9+Jk25sCkOT4Slz0MySXIAxaqltso3XHQuT1IsyG96qebsCUG4Ve97hEiCS6WSbFr3TwvkvlXHSbP6OnOpypcOhP4qQmHM+9Q9oL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v//h2MQedw36QhkdCIgc/ix9G3Qjr7ZaJQnJ+VJ4LAp3z/K8cRYrP0PR4U/E?=
 =?us-ascii?Q?rgkaNRFkMT0G0AD1jIcZmOZF25niEivM2olVypMoF5vZRh0SA43OEVVHCYmS?=
 =?us-ascii?Q?EsTGcLx8D8gIEdtiznasAwXivV2U7lFQBRGWWN6XF5SCA/TkntkLqu1o/kLJ?=
 =?us-ascii?Q?R/ugx+v3moac+Fz9bh+hcD0sXWtDBullkVbDAlrG7ejvYP4hvtd2lXTFtV5J?=
 =?us-ascii?Q?1AVhDeI3bB3OoE7lGdCXd5uNyu5czsSkwQlrL9duKzjC2Mn2qxVwHdojKhhr?=
 =?us-ascii?Q?1zOMe+OFXT7Jo0RK4hQ8ygYcxc12Nvr67X8O+F0lH476hDkx754Wzg+5X4Jq?=
 =?us-ascii?Q?VWys6z4TfCxRxVH7lfEGfNymKr2oJhPfK4rNBKv4g6bfVnwugtGXKhXN9c4n?=
 =?us-ascii?Q?8j2VPnKQESooFTPK/tqAF169zgL75Qk51EUrKoPbvbGc5d+xcuQMidu5VS7f?=
 =?us-ascii?Q?u5pWdGfR9GC2lKm2v6GuKqoM8T8MiblrP/7Zs5SlM5jp1jtcH4ZRdERlHnzS?=
 =?us-ascii?Q?f//LpooHCvCgWzxw3ZC+RXHUy5F2WXvRNMI2OZAwZiyUCjsAlv48vdvxd78s?=
 =?us-ascii?Q?t7Nqvia5vH5/Vl4JxIfNk7Kiu7x9YB/rfPlKyvfdV0b+rXU0Tg2fYduuwTq+?=
 =?us-ascii?Q?BMsj5XzxchYQxATQpgEb32BRgukQCHw44ukHVvcbD41JDA0gOmozgkp5BlEj?=
 =?us-ascii?Q?ZQ3VM5/b4pLGolk/sbGrnWPnu7W/i32rS6ekB+wUmfkDFMU+6bEk9r0FCzdm?=
 =?us-ascii?Q?73OlCSQ3cBPnLR+YgwCDw/EAILZUHzWFUJixRpbMe+fV8w5x6I7g+yXzA+TU?=
 =?us-ascii?Q?l2VmUXjYnaEbUJ3tI0giAsJHwc/Z3H1Ju8GiyHaOZGWFhFl+9J7M4AwPjc/o?=
 =?us-ascii?Q?YldoM5xK4ZXFjwxVblgTdH/zqTtcq7bMYZycyJ8t9Eqr9Ao1Cr8RLb9grXSa?=
 =?us-ascii?Q?h0yUh04DUlAFGe4CxlKq15NZqugjCeYgfw3DtgQ73h2MRqG74LfODccPZ1kf?=
 =?us-ascii?Q?QrTaiaqW3cO+TUsVT5zKs3faobzO+DsuO/e0ECFzCdI0pSnMuvaNuw8KtNwL?=
 =?us-ascii?Q?/SfHycH8qE3ka4K8ZClKmgLwPqyOZNBE9Xh3FlP3PEjqXcolEJHH/ZrG1wNP?=
 =?us-ascii?Q?yjFvLqd0zgCzT0nS8lsNnSn7VfWD30IlNvK3eh1Tovh5gTQZ1kvctLKxCQwS?=
 =?us-ascii?Q?ZBRuNdFIzuiBGlOQ71/hco8iP7GtgVTcfB/qBuR1QBg0z+Jhqjnb0bDnYXM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 539d1aa7-2992-4e3c-e876-08db62ef9d44
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 22:29:08.3130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
Received-SPF: pass client-ip=2a01:111:f400:7eae::800;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
user_cache_maint_handler() in arch/arm64/kernel/traps.c).

This patch enables execution of the two instructions in user mode
emulation.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0b7fd2e7e6..d4bee43bd0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7405,7 +7405,6 @@ static const ARMCPRegInfo rndr_reginfo[] = {
       .access = PL0_R, .readfn = rndr_readfn },
 };
 
-#ifndef CONFIG_USER_ONLY
 static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
                           uint64_t value)
 {
@@ -7420,6 +7419,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
     /* This won't be crossing page boundaries */
     haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
     if (haddr) {
+#ifndef CONFIG_USER_ONLY
 
         ram_addr_t offset;
         MemoryRegion *mr;
@@ -7430,6 +7430,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
         if (mr) {
             memory_region_writeback(mr, offset, dline_size);
         }
+#endif /*CONFIG_USER_ONLY*/
     }
 }
 
@@ -7448,7 +7449,6 @@ static const ARMCPRegInfo dcpodp_reg[] = {
       .fgt = FGT_DCCVADP,
       .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
 };
-#endif /*CONFIG_USER_ONLY*/
 
 static CPAccessResult access_aa64_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
@@ -9092,7 +9092,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_tlbios, cpu)) {
         define_arm_cp_regs(cpu, tlbios_reginfo);
     }
-#ifndef CONFIG_USER_ONLY
     /* Data Cache clean instructions up to PoP */
     if (cpu_isar_feature(aa64_dcpop, cpu)) {
         define_one_arm_cp_reg(cpu, dcpop_reg);
@@ -9101,7 +9100,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             define_one_arm_cp_reg(cpu, dcpodp_reg);
         }
     }
-#endif /*CONFIG_USER_ONLY*/
 
     /*
      * If full MTE is enabled, add all of the system registers.
-- 
2.40.1


