Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F53704443
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 06:16:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pym5y-0000V3-Jc; Tue, 16 May 2023 00:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pym5s-0000SG-VJ; Tue, 16 May 2023 00:15:26 -0400
Received: from mail-co1nam11olkn2080f.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::80f]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pym5q-0003gZ-PI; Tue, 16 May 2023 00:15:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feSZXRBU3IAiQ2mkCDTC/buY2EI7/pMP8J7xsq6GFSwJcOOG3Ip83awJwS5N22cssKr9CWiqU27z/uDciSITGVwjNjebPm9PlvvFIYsNGUPB7xWzNnCdEK9UjlmRB9NTP0WoXpNb6Nq4I3AUeLxMkOyn5/iEGSJIcsM0hq+zIZz4KlUXS6PQ3GmxUEiCTQKY4h5IIJ0OYcQFBiCUvsgORlT2Sqq9P1OJxtyKtxVOikMFKG5pmj9+iJLGaor/uMRgNZK7YBqV3wl8iUsRCeiH3Zp/jIMaicFtg6BkMX4k+UssaVIKtbPk+QFq6X2LpjabAupt3zGokGg13tvoDt8LVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IE1EjeAi9vat495DF8ADrBhDKeVSBjS4j4V5Fl7taI=;
 b=Y/+VPc4J7QrUVWxag1TUyb96VkXH5AVYZbbvrREAwwOwUM4hF6UPsWccre2lN1v3BeDywQlTIw4zWR8AH8zlcWr3vx6m2Wc4Aq3VdXgNITPrQBGOZaePppvZXgwkya2BW1DOwb5BRTnjsYLrZ8wREy8i4YdA1WMLVCAjJHOmds8mkQ96rqWon1qIkfYoUskVDLI61/9vyUalVQmo/n0F24AiQUdivNe/ooaGjtahgLltKJcAChe7F2SV2rsU1yGDFoaonr8ENXFmUw0lqd3xQrOedCgejPmsd8A8v7R2PzbCVcRTkIYEUe+v1f++IarTT0bvGJizlMUu0IcDWQewNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IE1EjeAi9vat495DF8ADrBhDKeVSBjS4j4V5Fl7taI=;
 b=l1KC3h7leeQ4HVcXyA68O6rpXib7JpZTVYs6v+vh4I4M+JaIX2/yJwJ9b3M1V+9TMTQyjRtzSZHZGRrdwbyQHlswI9wggmaT8+WuTmyKh7QGCMEnUZzT7H9h6dTkACga77DCRD/ic6g2WsYsHh2WNo9HOicDWCaJ/3NOFeHVGxqDjdYOyOH6Ak+qTx/Im/ngbvWjbRANdlEP1z9aVas/uLGZnOtuMwceXQlGmddtJsNVgJxe5elgoTDR4AQk3gAaB9tYpeHyc8xNbOu5gcMQLz5ypDw/qmysh2QgXx/1kQAq4HWND4FXV6GNh0ozmYD+b3BwMMLnnxcRBV6K+mnGcw==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Tue, 16 May 2023 04:15:18 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%3]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 04:15:18 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH] target/arm: allow DC CVA[D]P in user mode emulation
Date: Mon, 15 May 2023 20:59:03 -0700
Message-ID: <DS7PR12MB63094479AA92D99D8D777A95AC799@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Q6WonyrvLSiQJ3t//BYTRrgC3SEHnifU]
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230516035903.124348-1-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a52919f-e1b6-4071-bc4b-08db55c427f6
X-MS-Exchange-SLBlob-MailProps: mWtqiNqNgRuKO27nt/mZoWqn7+cej2MkObptWfEuqbmKOFeC0iPdncwSakyvgpe2FH+78DjsDDxymQ1jfWJkcCseOlcv1o1FqXSDZwZDfjlH1UvEby3/sQJLrxQdp6V+S697iRt0qiCATHZs0sTBZfNKg0gANc2NvvoGfkLLx2bHmMZ7Hb+ZvYx2uCwHQmaa0fdWe/ISdn65Lig9giw55TrvCcpbTx23k5do0fbEA3xmDPtlwJezqAfHSGzQFJ3HIR9uKeWEMz//1u1p2tpD8PK493Bp+i76PqbiyTyjcQd1vQEriROQm6AFTv/W9LtxGiYISn86b44YrXvj5+N1YgPm0gaJIJTchp34WAT7BDf/b+T4eATZ0ku1xd0YmNvKVklHH/oI2Hazi8I9YEuy/8QTzf+prxN0brXivm8GkS2cfRAO6IAZqAKEy7Tr5tq4DugWgSgiVQAvJBk5oXEfYLo5uDvAtddh8VxOXhpbXXJ3x4M761OhCjyR1OjgBUmjbeTlYmMg/4VDAiZ2FLjBViVYsyXWRkbwVsh9anTG4EoiJ4ZZe92q6bRn4KHA9CkavoUngkwuXez68dx3+m+FmVmi52PxldAthkyIMmBhf8yOvnMO52wmQrsaA0MDudmRHkugLgJE5adJCvZSsN/Ytk89TRqgzy8zPiMjMIp951HlpZtWiFKHq+elhmxNR6n8wMi/zsFjzopkZOjmXMVC/+9ARfKB/yRSjHChj0zMlxuaKvbygQZJPfj9e1+rJBiKwtKhPyLadRYsnkklS+C7i9B+AqaeI2dafARzsfmzStc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBlY4bIbSBoWoTrBpkN6noxbYqVJMiI1YK7/0OjUKSl0/bBjGoEZ5MTyYWn4NDw+QHzsfjweilVk69Mb5duFT+lHbLx0Ho0IKkOnLWIysUbqSq7bSTLhWhj2D43fc3D/WiIevugwjwIj3i+RiySYyABF3wY0mVOY7R/9uRHqg9cSd8yH9/53685mr9n9ZymAqVLHVYPdAtDhdY7qngFkpBeAwKMTaiZ6kuVUxIxPYhVcQaNQOYGARPVUFUudzdy2vRrOmGCqvd5n1NGSgZMOF4QLs1ocXqufZkkgE8IUUZkGRgD0IaL1brM15ScYo2cOxo1P6JQcYAHokoqJxFJUSJi7nvXDGiaXyHNOv0UTyqKAnWC0St+u6UCyotBOBjWqxbxeI+WieZqs0OclvrYQVNeKPY22uFI/hspBpIdpRX5mMSn73dV7ZUS1Du3J5ylBHSpMKxl5R7s40fQtEjnc6yZg/CX1EDsW8i+RyIA0E5dzy0pu3v+MGX/6CPXnoQ78XzSr6oq6FU/XFgHynF09qnoZNwrziwdzkAcG/hHInIA0pbBkmUSVPFo3ry/Nwbins/tEskA7PFw6QfGN/5VF610I8EIjodZC44I2+nK8Bi6NCjS/IioAS8iXNZkBOefy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e8XjbUkWrP5SvEbUKlrTvySlibi0fiJWAJZWvaD0JADSyPPYT0Ce66yEIJ+o?=
 =?us-ascii?Q?EBSVpiAja5IDdW++XOo+mMeOMFn6vQp1wkvIMVoAN1oHKxd2BNNu+2cOfCan?=
 =?us-ascii?Q?NQPpmSJNuxmajKrsTbqSWEw+02Mq+mY4+WciAK/ledM4iMndPMZrn2bMlabz?=
 =?us-ascii?Q?kgYHnxl6Wt88oM/YwcMp6vJSb+njA3Ka1WJz/TQkbQ4p5R2uM+np1FrI3VvK?=
 =?us-ascii?Q?k0vabSQ1S7GexHS9ooQ+uYBpv5ojJpOEbki4wArTTFutA4JXGfqWBm+YBeaq?=
 =?us-ascii?Q?Qm3BOh/RwlkDXLNse5qRphWuaiP1oCttRlV6qDqgKhPEec+pD+CSJEP3nJ7o?=
 =?us-ascii?Q?7NZpIuGmlDlHJy3VJWKYISzHJItmTr/CPFps5sluwfOpnyQeq3ngUYjgA9+9?=
 =?us-ascii?Q?nY+MDHs5hKsNZHoyCujQHTk8ORgr3Ek8zI1mlhIZnr3UReKMenGKfJ0hTG2C?=
 =?us-ascii?Q?7R5d36uc2OWPzq0K7GW72LiamRTKAK3Temzmx2+VH/N6i12KM1u/cWuf8TgI?=
 =?us-ascii?Q?pnXMLRjwAy9FvHpQ6BfciYnH6R3GWD/sJcwqg53IYzKpCNatN2PwaynsMIJ+?=
 =?us-ascii?Q?7SJBLHT6vlMDliabokqAdt0lp34WyjOChV+4HOMXt7Lavk6pZJJvgUN+3DYa?=
 =?us-ascii?Q?RTcU2LQPwm6IEKSjFwltNVYtv1VfdAcudNlQ/4hGf2Rjui4QUQnmLEeZPmxA?=
 =?us-ascii?Q?dNXkbQ0bwiBre9H633ycWHKnhSNL30SPmDMwSUDy+0e152h9R16I9KCrXt76?=
 =?us-ascii?Q?0P5oCg5/WCkIv/LfsPMwsoUO0M9kEoeotNq31ZoOmpCNbuc4VomLgrqD7qYl?=
 =?us-ascii?Q?HN03Hqw/mxWo72KBgGz9lRca+hbKHuNdvnj1ddUPlwAEpUGpakYrA1w1DF/i?=
 =?us-ascii?Q?oRDMWEnAzTehzYPrZFuotdCnbek7/jO2Y5X2a3ItzXhwM+adrKDKNdbLJyUR?=
 =?us-ascii?Q?Mr0KavpIRv2zYef4gJUA6KH3s6dByyTzbd7FysWOMpUE4E5Xhm10XqmrB7WB?=
 =?us-ascii?Q?poJr1ypypmoTy+LEfmM2tuh0Hrv0/3R5kF3jEoC3x/c50nt1wk1kE+rF0VTt?=
 =?us-ascii?Q?rCpDPPkcu98psOE4iGzaW3L3Ar1KCGFGaxFWzCCXVPMfauBgNIUGumiFXfPz?=
 =?us-ascii?Q?r8lwGZouVgn6vn3D1S1cpmm26uh9iwgV/jpdfitssUVl8rFAA/MFBVUM0CRR?=
 =?us-ascii?Q?TsIpuIGWL2UPVJOEac/GNyi3Xlx/EPkJ9nCAzUTT03Im9ub58b7oWq7b6C0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a52919f-e1b6-4071-bc4b-08db55c427f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 04:15:17.9601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392
Received-SPF: pass client-ip=2a01:111:f400:7eab::80f;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
user_cache_maint_handler() in arch/arm64/kernel/traps.c).  The Arm ARM
documents the semantics of the two instructions that they behave as
DC CVAC if the address pointed to by their register operand is not
persistent memory.

This patch enables execution of the two instructions in user mode
emulation as NOP while preserving their original emulation in full
system virtualization.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
---
 target/arm/helper.c               | 26 +++++++++++++-----
 tests/tcg/aarch64/Makefile.target | 11 ++++++++
 tests/tcg/aarch64/dcpodp.c        | 45 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/dcpop.c         | 45 +++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/aarch64/dcpodp.c
 create mode 100644 tests/tcg/aarch64/dcpop.c

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0b7fd2e7e6..eeba5e7978 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7432,23 +7432,37 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
         }
     }
 }
+#endif /*CONFIG_USER_ONLY*/
 
 static const ARMCPRegInfo dcpop_reg[] = {
     { .name = "DC_CVAP", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 1,
-      .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
+      .access = PL0_W,
       .fgt = FGT_DCCVAP,
-      .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
+      .accessfn = aa64_cacheop_poc_access,
+#ifdef CONFIG_USER_ONLY
+      .type = ARM_CP_NOP,
+#else
+      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
+      .writefn = dccvap_writefn,
+#endif
+    },
 };
 
 static const ARMCPRegInfo dcpodp_reg[] = {
     { .name = "DC_CVADP", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 1,
-      .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
+      .access = PL0_W,
       .fgt = FGT_DCCVADP,
-      .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
+      .accessfn = aa64_cacheop_poc_access,
+#ifdef CONFIG_USER_ONLY
+      .type = ARM_CP_NOP,
+#else
+      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
+      .writefn = dccvap_writefn,
+#endif
+    },
 };
-#endif /*CONFIG_USER_ONLY*/
 
 static CPAccessResult access_aa64_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
@@ -9092,7 +9106,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_tlbios, cpu)) {
         define_arm_cp_regs(cpu, tlbios_reginfo);
     }
-#ifndef CONFIG_USER_ONLY
     /* Data Cache clean instructions up to PoP */
     if (cpu_isar_feature(aa64_dcpop, cpu)) {
         define_one_arm_cp_reg(cpu, dcpop_reg);
@@ -9101,7 +9114,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             define_one_arm_cp_reg(cpu, dcpodp_reg);
         }
     }
-#endif /*CONFIG_USER_ONLY*/
 
     /*
      * If full MTE is enabled, add all of the system registers.
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 0315795487..3430fd3cd8 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -21,12 +21,23 @@ config-cc.mak: Makefile
 	$(quiet-@)( \
 	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
 	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
+	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
 	    $(call cc-option,-march=armv8.3-a,              CROSS_CC_HAS_ARMV8_3); \
+	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
 	    $(call cc-option,-march=armv9-a+sme,            CROSS_CC_HAS_ARMV9_SME)) 3> config-cc.mak
 -include config-cc.mak
 
+ifneq ($(CROSS_CC_HAS_ARMV8_2),)
+AARCH64_TESTS += dcpop
+dcpop: CFLAGS += -march=armv8.2-a
+endif
+ifneq ($(CROSS_CC_HAS_ARMV8_5),)
+AARCH64_TESTS += dcpodp
+dcpodp: CFLAGS += -march=armv8.5-a
+endif
+
 # Pauth Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
diff --git a/tests/tcg/aarch64/dcpodp.c b/tests/tcg/aarch64/dcpodp.c
new file mode 100644
index 0000000000..dad61ce78c
--- /dev/null
+++ b/tests/tcg/aarch64/dcpodp.c
@@ -0,0 +1,45 @@
+/* Test execution of DC CVADP instruction */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP2_DCPODP
+#define HWCAP2_DCPODP (1 << 0)
+#endif
+
+static void sigill_handler(int sig)
+{
+    exit(EXIT_FAILURE);
+}
+
+static int do_dc_cvadp(void)
+{
+    struct sigaction sa = {
+        .sa_handler = sigill_handler,
+    };
+
+    if (sigaction(SIGILL, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvadp, %0\n\t" :: "r"(&sa));
+
+    return 0;
+}
+
+int main(void)
+{
+    if (getauxval(AT_HWCAP) & HWCAP2_DCPODP) {
+        return do_dc_cvadp();
+    } else {
+        printf("SKIP: no HWCAP2_DCPODP on this system\n");
+        return 0;
+    }
+
+    return 0;
+}
diff --git a/tests/tcg/aarch64/dcpop.c b/tests/tcg/aarch64/dcpop.c
new file mode 100644
index 0000000000..8b4ea7c91c
--- /dev/null
+++ b/tests/tcg/aarch64/dcpop.c
@@ -0,0 +1,45 @@
+/* Test execution of DC CVAP instruction */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP_DCPOP
+#define HWCAP_DCPOP (1 << 16)
+#endif
+
+static void sigill_handler(int sig)
+{
+    exit(EXIT_FAILURE);
+}
+
+static int do_dc_cvap(void)
+{
+    struct sigaction sa = {
+        .sa_handler = sigill_handler,
+    };
+
+    if (sigaction(SIGILL, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvap, %0\n\t" :: "r"(&sa));
+
+    return 0;
+}
+
+int main(void)
+{
+    if (getauxval(AT_HWCAP) & HWCAP_DCPOP) {
+        return do_dc_cvap();
+    } else {
+        printf("SKIP: no HWCAP_DCPOP on this system\n");
+        return 0;
+    }
+
+    return 0;
+}
-- 
2.40.1


