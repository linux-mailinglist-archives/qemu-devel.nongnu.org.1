Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ACF708C79
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 01:37:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pznAB-0007Gp-Hq; Thu, 18 May 2023 19:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pznA7-0007GN-T7; Thu, 18 May 2023 19:35:59 -0400
Received: from mail-bn8nam12olkn2081b.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::81b]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pznA5-0003Wu-Qj; Thu, 18 May 2023 19:35:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrvPe4u8kkdt7zaHnkfwvoUiJvSpO0+Chbws/IKsnXK2b14EwtE/LKIxLsFs1z9S5wVupL3PjqbP2RqCMNS+Hz/lGtDh4D8LmmTOymJalfCOUWOH6jyxDOt6o8xfu63dQcJVRrN2FYsr5VLmHV+uINPefh3cliQe+RMZl5C4ng2GoqBggCgpS6NOucZBlKD19nbgaqpkWJou4qU5W4+X2L/eqJDXdORlWrhD9PrPLFlh9JsH8EWF/QKgUASA6fxz1KN7OukQwnLdCMm0ySmGim7p2CUGj1xy+YfR4MCMdMYkJpava86Wv2CsL0Sp5BtqmlKx+nd7G6E43pppPmqWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BH4TVGM35UkygeoVIE71ilflH11ur0cdnvaLEzZ9Ag=;
 b=ZVhTiI/NLCa4HpGFsTHalMOQH6A698ZReLzotvRt0VgAYPsBYNCWmmE5CiVST9MdaZ8Y+LB+Rog4PTI6lE1ufidEST9Wp8rIrWu+MOlUXLW9efq81tuvuk5Hfp6yvUZXzf1VYoU4TNqx/wgA1TjR0p+Nglu9J7hBv8X6V2pTC6Nv8lct7qqJc+DddN4KdMx1GJCZQIZOhuSIVInbL/orUhQgiQsri7FaWuazo+6WMwliczyi1nFKDXmP5XaOcN6x6Bw9MAWjINnDZswXE81XcZ+FVTx4XrQzQv5WmVEW/8ZVeRLYSzfA4stTO+SvcM6bsDDaoolHraXShJ7RxLU79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BH4TVGM35UkygeoVIE71ilflH11ur0cdnvaLEzZ9Ag=;
 b=Ne7I5Zzoqk2D+ZzGxX0kfHIB6Xu8PhvEOYaSlJtAzhDqr2+PqFsZfehkkNsV2Fz5xKHIECmJRsTPF10dF6kNbamMFJB7tvT/xm5coQODgGR6xMuPScF8s4sEVGva4aArxIKqQSLr+IQg5QIwLL8BUwA7ImwPLJ026rfMunnUmvMD7EwiSQI0Iv6MrhoVEUGqjST5a8DBLNpXF9yKSvqWVMUHu3hSOlWO8fGNR0WI46zJtEFAx8fv3IAq6p8+CC2KnhIxSTydN+1x75j7VOhttbErIwCesduk5jL7T2+OIEk0tmw7ldjhVCyfc0EF0rVVXPoHXipuvC/Cz2D3hxKrSw==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Thu, 18 May 2023 23:35:54 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%3]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 23:35:54 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH v3 0/2] target/arm: allow DC CVA[D]P in user mode emulation
Date: Thu, 18 May 2023 16:19:04 -0700
Message-ID: <DS7PR12MB6309514B7E8ECEB35CCC68DCAC7F9@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [vj7lKyw+A+fAyEjLuG0cR//ECy94tzXR]
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230518231904.275762-1-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b7ad1f-d77a-462e-ebcc-08db57f89f3d
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nvAoS/oQTVQZ1S7Y8lGJvUKF8T8jzRwzy+3z9zHhNoLF60s8E5lwXI6Nax0Agig+KzVN7OzLXtyYNGWaOQIw2HpsiDfj+9XqoI9DU/Dzj+93DZ6x0ZFEEbSJ84tCRI+hDVHizHucF/BsokN+vnsurg6QB/V0jRXcESJpwcNeq0CeVJTdiMLTZoYYNL5jPghDDj2Avz9pR3vKdxMmpN6DIgooCzqagrn2EWVUXnmEyF4VqnaOaubiAg5Y6dOsADLFyeT3QnboKKThLx1giWpNYDk3rlDSe3e7GoEhYU8y9eW7X+sPYqcwsa3BpFO6ql+m8slspvgdFKbyL5Q+8BmepOxgc5yv4qs2Hqrj2MsAvrgwVg8Hh2VthJbxMAUJZ1Ngi5+d9oO4X8pOItYwTXhQByxCcawp/B6yKQnjwl5ae5e2+0AtCrHDw84Pq73tN/K/XplJzzTCN4PY9W0196kOmTkWFLgq92Sq42CCJN+vscz+u4Am5npK3sSWmQhjV1fvN6kvSsp8HF6H42XpUiIwxB4tdU96KD4XcTbNWDvU/5hpKd8q/yUG9JCS+zhKBaqngaIX/JxBk7/CXcWjXX665LztBGeBLTMYT8j9TJJj1wqMvZUnakAotpcDR3H3qcjWvC9RWujEbR3iP6Frck4QSf/jF9l5Uu4ihn4SRSE29zQrSIQRz6ZQOO1Fqy7l/G1yGa8yUb1C+jhSjRO+2B89OHvZZPRvuPiJ+kNBgvhfiDL1yaeUsLgMyphhROmh3xv99Or1hqQyc/OQCkcRp39y1u
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnOYVWOX6+R5AlPbr8uJuQgvuFvKJMtH5nOy8Wc5vLzV93+/utsbzWz8/qYtIXbaBBMW3pbPBPp2UkFuGAu213fuvV1eD/bjgmAmM60z9SyizIM4XgAuuMfO1x17tOc08OfuvFTBdXMs5Mcgj7vJB3ueKKvlENuQlQNAVIpZGxz+rzjPKsUblkab3xuyTrEFjsSqYz5nOwQ71JcpHk9Hxy1FZ39teBpM+edNSUyDvLEB7ZdY929PcHovkMDtvxUdI+tRpUBeXLJszQqoJTqDOsOy5kHZWGWAX126KtHyXS2FXA/hGSHAm/kdZl/W4YmolSU1bSFB7y9L6jmQMD8iVxc7lAuhvyIWSWJnW+/gnE5V3VZAC9Hl/EqzLTiorBhslafhwFTRBg+FzVTfoGJlQHtfUn2AFK5Z4544A9gj4BFFtzkaG6jjw4lD4eFCYyxOS0Q7327Wm/ImHboCYE+KS93xvdjZ74q1pJeTBM1a8bSyFFQpKYq35tz320rBbzenJMCMaALmsSvFSmuY0svluQ0sjzw1RZ0vbxZVFEbxNBPjyoQx9aPZVCiPYeSRttEwC9t7nPMii1tEwsVXrbZpwl7IdiZ1S4Mpzn260Yxj2HQ/2CfBvWRNSO5gcSw9vCFc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nAqW3clDsKOI5QDNL6BNFnhyT3VdFFY5LPKBgnahbWgRRn7+brNwusdUPN7F?=
 =?us-ascii?Q?3+Af5Q76gdApBSG1ImmuHkVEv01fqjtacEpz2Tt+3gswNKXYvGyFHpmetHVK?=
 =?us-ascii?Q?T/NR5/ag/u14pzuih4mZ9M/oBTZfzrjBG5Ps0Smv5qgSAgnhiIIQVTNoPaHH?=
 =?us-ascii?Q?OlH/lDtEkXPBZUasVVS9kVkNXQjKkkCuh2/bLifAHd2tpZMbNzT1u0yhtgJQ?=
 =?us-ascii?Q?UWHGHYvHGf6GE4uOp2GCprLI9KI1AFzmBKO3uHvi2d2SQwAYCcS5OCRaoKGg?=
 =?us-ascii?Q?F27StlmNybwjRx2PO04HpzP059TDgDndIcR/wfIiaF7ph0gdRwgH64RSfzIw?=
 =?us-ascii?Q?Gtyq5YE0JZaWuZIeHiu72gPbAR2GqDAhKCoPUgGoJQKN8oEROVU+YmLrwBfV?=
 =?us-ascii?Q?0NiLa+U35Bp5QrWN9/0/pTh0vcHBwesbZx2jdxowS7C2T6UHYFuweRl1c9RT?=
 =?us-ascii?Q?/9jQeuKf9KwX2HJiXC1x62+3BOqvessURSI7QpaACnPDpCeYUQLm5RUcIHup?=
 =?us-ascii?Q?GDoo5/Zl+Ht3O0joHqfqho8IbPhcbC0apZ0FhC6lkJRtagLfeaAbXSNbEImi?=
 =?us-ascii?Q?mRe+ze98gvtBMxSnTLBvK4dc/IwSYfF+2M6JYnuPNZtEPprGfRUg66gwsAe8?=
 =?us-ascii?Q?wOJPjVka/cHLpPBuNO37WeIVqshRkHjiF7JHb2WRyf0ddreGjCZSTErFPOkW?=
 =?us-ascii?Q?jIQYhHXLlOB8lKxJ9SkeBpJwV2l/Q5Cqlg9pd7I7WbI0mGxWben/ufdKOBVN?=
 =?us-ascii?Q?mExhOSxKn2p03jAZqxulPzIVZeG3B7h2deYe1ZyKXyu1kxCVqa38TRq82bJu?=
 =?us-ascii?Q?7UcPgOfmMoa0GkIS5Dx+Y/yU3Zjv+8p8FwhqcpL0Neti1kmNf5fXjs6M4TrW?=
 =?us-ascii?Q?2+iYJ3eYdmTufZesiKQpAUR8S5+w1nfpoduxjvOlfwTTQ0Dekc3mskGHqfeM?=
 =?us-ascii?Q?Oz63gsc/pQq2snTD5KQxrkYpo7SGm5o1V6snMDXXWwlOJXKWSWEZvKILFtTk?=
 =?us-ascii?Q?lTCpITqA3zub46pypqxrIuwIl5ZYr93DPBaiaDhvFk3VOEsWvOffuRr1OZhp?=
 =?us-ascii?Q?yTteVQ5Uuri1M59OrB7UDE/FgpbDWpNmdsr0+z1CCzwzPypEJNF/yjljznGv?=
 =?us-ascii?Q?wFPtVyhqRHiQ3it5bV5uqiJhHjnUxCCMqfi7+XA6LhbVmIMbvsPNuzk8BL1l?=
 =?us-ascii?Q?IbwcxjLsuWErmxin5nNdsMAw8tldJdpR8rduBXDOzVsJeFQtNgk9J54aE3o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b7ad1f-d77a-462e-ebcc-08db57f89f3d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 23:35:54.2296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220
Received-SPF: pass client-ip=2a01:111:f400:fe5b::81b;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

This patch series enables executing DC CVAP and DC CVADP instructions in
AArch64 Linux user mode emulation and adds proper TCG tests.

Changes in v3:
- Fix typo of HWCAP2_DCPODP
- Split tests into a separate patch
- Remove unnecessary handling of SIGILL in tests
- Merge 4 tests into 2

Changes in v2:
- Fix code to deal with unmapped address
- Add tests for DC'ing unmapped address

Zhuojia Shen (2):
  target/arm: allow DC CVA[D]P in user mode emulation
  tests/tcg/aarch64: add DC CVA[D]P tests

 target/arm/helper.c               |  6 ++--
 tests/tcg/aarch64/Makefile.target | 11 ++++++
 tests/tcg/aarch64/dcpodp.c        | 58 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/dcpop.c         | 58 +++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/aarch64/dcpodp.c
 create mode 100644 tests/tcg/aarch64/dcpop.c

-- 
2.40.1

From a44b84c39e86e1bc78c93250a6b2d80fbf2d5393 Mon Sep 17 00:00:00 2001
From: Zhuojia Shen <chaosdefinition@hotmail.com>
Date: Thu, 1 Dec 2022 15:02:18 -0800
Subject: [PATCH v3 1/2] target/arm: allow DC CVA[D]P in user mode emulation

DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
user_cache_maint_handler() in arch/arm64/kernel/traps.c).

This patch enables execution of the two instructions in user mode
emulation.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
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


From d5cb0b89d45703d35eb9375fd71be5ad94cb17ed Mon Sep 17 00:00:00 2001
From: Zhuojia Shen <chaosdefinition@hotmail.com>
Date: Thu, 18 May 2023 14:24:50 -0700
Subject: [PATCH v3 2/2] tests/tcg/aarch64: add DC CVA[D]P tests

Test execution of DC CVAP and DC CVADP instructions under user mode
emulation.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
---
 tests/tcg/aarch64/Makefile.target | 11 ++++++
 tests/tcg/aarch64/dcpodp.c        | 58 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/dcpop.c         | 58 +++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 tests/tcg/aarch64/dcpodp.c
 create mode 100644 tests/tcg/aarch64/dcpop.c

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
index 0000000000..6f6301ac86
--- /dev/null
+++ b/tests/tcg/aarch64/dcpodp.c
@@ -0,0 +1,58 @@
+/* Test execution of DC CVADP instruction */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP2_DCPODP
+#define HWCAP2_DCPODP (1 << 0)
+#endif
+
+bool should_fail = false;
+
+static void signal_handler(int sig, siginfo_t *si, void *data)
+{
+    ucontext_t *uc = (ucontext_t *)data;
+
+    if (should_fail) {
+        uc->uc_mcontext.pc += 4;
+    } else {
+        exit(EXIT_FAILURE);
+    }
+}
+
+static int do_dc_cvadp(void)
+{
+    struct sigaction sa = {
+        .sa_flags = SA_SIGINFO,
+        .sa_sigaction = signal_handler,
+    };
+
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvadp, %0\n\t" :: "r"(&sa));
+
+    should_fail = true;
+    asm volatile("dc cvadp, %0\n\t" :: "r"(NULL));
+    should_fail = false;
+
+    return EXIT_SUCCESS;
+}
+
+int main(void)
+{
+    if (getauxval(AT_HWCAP2) & HWCAP2_DCPODP) {
+        return do_dc_cvadp();
+    } else {
+        printf("SKIP: no HWCAP2_DCPODP on this system\n");
+        return EXIT_SUCCESS;
+    }
+}
diff --git a/tests/tcg/aarch64/dcpop.c b/tests/tcg/aarch64/dcpop.c
new file mode 100644
index 0000000000..0c4d32cfe7
--- /dev/null
+++ b/tests/tcg/aarch64/dcpop.c
@@ -0,0 +1,58 @@
+/* Test execution of DC CVAP instruction */
+
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
+
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifndef HWCAP_DCPOP
+#define HWCAP_DCPOP (1 << 16)
+#endif
+
+bool should_fail = false;
+
+static void signal_handler(int sig, siginfo_t *si, void *data)
+{
+    ucontext_t *uc = (ucontext_t *)data;
+
+    if (should_fail) {
+        uc->uc_mcontext.pc += 4;
+    } else {
+        exit(EXIT_FAILURE);
+    }
+}
+
+static int do_dc_cvap(void)
+{
+    struct sigaction sa = {
+        .sa_flags = SA_SIGINFO,
+        .sa_sigaction = signal_handler,
+    };
+
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        return EXIT_FAILURE;
+    }
+
+    asm volatile("dc cvap, %0\n\t" :: "r"(&sa));
+
+    should_fail = true;
+    asm volatile("dc cvap, %0\n\t" :: "r"(NULL));
+    should_fail = false;
+
+    return EXIT_SUCCESS;
+}
+
+int main(void)
+{
+    if (getauxval(AT_HWCAP) & HWCAP_DCPOP) {
+        return do_dc_cvap();
+    } else {
+        printf("SKIP: no HWCAP_DCPOP on this system\n");
+        return EXIT_SUCCESS;
+    }
+}
-- 
2.40.1


