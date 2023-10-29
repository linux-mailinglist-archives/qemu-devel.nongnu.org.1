Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A62B37DAE98
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:28:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxDJf-0003TD-52; Sun, 29 Oct 2023 17:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marielle@novastrider.com>)
 id 1qxCux-0001uS-PF
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:01:55 -0400
Received: from out-170.mta1.migadu.com ([95.215.58.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marielle@novastrider.com>)
 id 1qxCuv-00046K-Kr
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:01:55 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=novastrider.com;
 s=key1; t=1698613301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GFoIeXJ41GUo62f6dyhb4xjXazYAtreCSXuwN4KhqZo=;
 b=YH4wOi/OpVNaFsFXxGLryJN1YpZH5azNwMpunwz16vJQp47jKYn9Ilh+xnQmnuZkDFBseh
 GTzmixsAu199dma50qAItQN0KYlZaiKozSP0Ff63u0BLwuA8lPYZP7FFa9x26P31pJKrHY
 wOhS8GFDCAddQluQP2yYMvvV1EkxIH8MIQyrHrudLhvze4eTirc/Zb1014AggEFstE5Eco
 XttlHUg+vlgqDN2tbkSiOKd+TuACOKsbGYWiVeYWd00xXvFQBCLZmKKSfArKEWFP2diz+e
 2dKImrjIVCYp5g/bzb2GqW3qPjb2of3Hzworl5GYIld54bDdcXYiBJVDf3k/Ug==
From: Marielle Novastrider <marielle@novastrider.com>
To: qemu-devel@nongnu.org
Cc: Marielle Novastrider <marielle@novastrider.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH] linux-user/elfload: Add missing arm64 hwcap values
Date: Sun, 29 Oct 2023 21:00:58 +0000
Message-Id: <20231029210058.38986-1-marielle@novastrider.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.170;
 envelope-from=marielle@novastrider.com; helo=out-170.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 29 Oct 2023 17:27:26 -0400
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

Specifically DIT, LSE2, and MTE3.

We already expose detection of these via the CPUID interface, but
missed these from ELF hwcaps.

Signed-off-by: Marielle Novastrider <marielle@novastrider.com>
---
 linux-user/elfload.c | 3 +++
 target/arm/cpu.h     | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2e3809f03c..d9683809a1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -768,12 +768,14 @@ uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_sm4, ARM_HWCAP_A64_SM4);
     GET_FEATURE_ID(aa64_fp16, ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
     GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);
+    GET_FEATURE_ID(aa64_lse2, ARM_HWCAP_A64_USCAT);
     GET_FEATURE_ID(aa64_rdm, ARM_HWCAP_A64_ASIMDRDM);
     GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
     GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
     GET_FEATURE_ID(aa64_sve, ARM_HWCAP_A64_SVE);
     GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
     GET_FEATURE_ID(aa64_fhm, ARM_HWCAP_A64_ASIMDFHM);
+    GET_FEATURE_ID(aa64_dit, ARM_HWCAP_A64_DIT);
     GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
     GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
     GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
@@ -807,6 +809,7 @@ uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_rndr, ARM_HWCAP2_A64_RNG);
     GET_FEATURE_ID(aa64_bti, ARM_HWCAP2_A64_BTI);
     GET_FEATURE_ID(aa64_mte, ARM_HWCAP2_A64_MTE);
+    GET_FEATURE_ID(aa64_mte3, ARM_HWCAP2_A64_MTE3);
     GET_FEATURE_ID(aa64_sme, (ARM_HWCAP2_A64_SME |
                               ARM_HWCAP2_A64_SME_F32F32 |
                               ARM_HWCAP2_A64_SME_B16F32 |
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 76d4cef9e3..7605d6ee3a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -4073,6 +4073,11 @@ static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
 }
 
+static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 3;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
-- 
2.39.3 (Apple Git-145)


