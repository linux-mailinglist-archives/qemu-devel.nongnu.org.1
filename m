Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 687D373B77D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:37:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfx8-0001WX-6Y; Fri, 23 Jun 2023 08:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx0-0001UP-2L
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfwx-0000eU-HW
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fa71e253f2so16979315e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523498; x=1690115498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D6fHyXUUwcQ21JROt7AMggIpVEP9C+qn5opEGGFkXS8=;
 b=n12zAZ/lcBVkPhIf0aDGKRrCBBXhZucw6ED3h/Yd2RIpP2wbErF1CVpWWWcfVnzjqu
 qE6gnm53FUj03ciWxMOOsHrVLTjj2cEmxWqbfLSnCeaNf4IBnfBw4nPnujcd1w2xGrFW
 Eeb1ehdZ81X8L/nX5v6XCpPQtbjHXx7EqKKdq9H/Km3qshlJuXrFZFHVgDDE1PsRKBmo
 vXxfZJOVoj2Jqwu5GcehiYStdtadOiWfqq5RNX9tJYX9MAjcE56HALXuPoa2ywE7STOm
 sBFaqUBudi+9etL0ZO2r1LCW1adJ/R0uPGO9ahrouuIPDMNDEVmexC6tOIyVe/i+94zE
 MofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523498; x=1690115498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6fHyXUUwcQ21JROt7AMggIpVEP9C+qn5opEGGFkXS8=;
 b=FrX8I2Pv6gduwFbcCLYItwOB35Rbetcp31v2RIoZZZHz66hJT/1oG8Qjx569lwrp10
 V7lI7rS4ZhCoR63OILreFNU0HSwNS6wp9uWWunqQmw7Z6N6aqZxb6sr9VqKkjOx47FLv
 AOxkbMNnCqge56i+i0PAnHRTHcfuPAwyriogyHKBSuUiHQP2ZZIPVy63nYcX3RhFpeM7
 an2PhMp8Kq0c6ErPFse2F4ZiLYa3oPd2k6lyusl2TFwg0Nlq7Oc0UcIJVJaM+twtaWMc
 ZO/NQRQ9/oMNMhgHTcS0iHAaWBq0oUSTJzqMlwbe3d2B5Zc32cpP25c6eFmwDKUtU7At
 4ANA==
X-Gm-Message-State: AC+VfDwQjgJs2KppzqyJClb8IBLXgy/ip00cVMqn5JzpiqGXxdxza15a
 b6aa1KEL+BQo57GOKl+Ndh+8a6FNdDCTiiu0zls=
X-Google-Smtp-Source: ACHHUZ4CUS+6t0W+Ykfj+mUoYHqJyz3TDHv06DOgWp9Muld6FgsDkdfiJsw2vh9E0WYQzAQKAqjEaw==
X-Received: by 2002:a05:600c:230c:b0:3f8:f1db:d1f5 with SMTP id
 12-20020a05600c230c00b003f8f1dbd1f5mr20318395wmo.5.1687523498104; 
 Fri, 23 Jun 2023 05:31:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/26] target/arm: Update SCR and HCR for RME
Date: Fri, 23 Jun 2023 13:31:11 +0100
Message-Id: <20230623123135.1788191-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Define the missing SCR and HCR bits, allow SCR_NSE and {SCR,HCR}_GPF
to be set, and invalidate TLBs when NSE changes.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  5 +++--
 target/arm/helper.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c84ec2752f6..318d1033b87 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1655,7 +1655,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_TERR      (1ULL << 36)
 #define HCR_TEA       (1ULL << 37)
 #define HCR_MIOCNCE   (1ULL << 38)
-/* RES0 bit 39 */
+#define HCR_TME       (1ULL << 39)
 #define HCR_APK       (1ULL << 40)
 #define HCR_API       (1ULL << 41)
 #define HCR_NV        (1ULL << 42)
@@ -1664,7 +1664,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_NV2       (1ULL << 45)
 #define HCR_FWB       (1ULL << 46)
 #define HCR_FIEN      (1ULL << 47)
-/* RES0 bit 48 */
+#define HCR_GPF       (1ULL << 48)
 #define HCR_TID4      (1ULL << 49)
 #define HCR_TICAB     (1ULL << 50)
 #define HCR_AMVOFFEN  (1ULL << 51)
@@ -1729,6 +1729,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_GPF               (1ULL << 48)
+#define SCR_NSE               (1ULL << 62)
 
 #define HSTR_TTEE (1 << 16)
 #define HSTR_TJDBX (1 << 17)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d4bee43bd01..d2f0d9226ec 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1874,6 +1874,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_fgt, cpu)) {
             valid_mask |= SCR_FGTEN;
         }
+        if (cpu_isar_feature(aa64_rme, cpu)) {
+            valid_mask |= SCR_NSE | SCR_GPF;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -1903,10 +1906,10 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     env->cp15.scr_el3 = value;
 
     /*
-     * If SCR_EL3.NS changes, i.e. arm_is_secure_below_el3, then
+     * If SCR_EL3.{NS,NSE} changes, i.e. change of security state,
      * we must invalidate all TLBs below EL3.
      */
-    if (changed & SCR_NS) {
+    if (changed & (SCR_NS | SCR_NSE)) {
         tlb_flush_by_mmuidx(env_cpu(env), (ARMMMUIdxBit_E10_0 |
                                            ARMMMUIdxBit_E20_0 |
                                            ARMMMUIdxBit_E10_1 |
@@ -5654,6 +5657,9 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         if (cpu_isar_feature(aa64_fwb, cpu)) {
             valid_mask |= HCR_FWB;
         }
+        if (cpu_isar_feature(aa64_rme, cpu)) {
+            valid_mask |= HCR_GPF;
+        }
     }
 
     if (cpu_isar_feature(any_evt, cpu)) {
-- 
2.34.1


