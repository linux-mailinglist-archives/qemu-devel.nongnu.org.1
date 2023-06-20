Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3BE736C44
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaiq-0001WM-7v; Tue, 20 Jun 2023 08:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaim-0001Ty-Iz
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:32 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaii-0001tS-EN
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:32 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f87592ecaeso2432869e87.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265062; x=1689857062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tr1rTDfiq0RcGbvkGBpYZNXlVGVfs0mzt9B/xYUDj8Q=;
 b=pIZ+S/ePfHYaVxByvQGvc317/MW5QwsPUDyxlsXFk7nWSZi+diPyqWwySV3YCXdVzS
 f44jGspyRAgTzfQt42mdg8U9J3Tzy+NAVQq5kpR92PW9W+jcWNiCfIlGTTPEmk4zs21G
 K+QKoUx91MXIPq97vhRGtJdIncetbS2COC4Ugi3RAEYhUetdYacOxx+NcbFID4/zZCB0
 /ImSHa5hbKTCon77DZ4X9iNk5R164A5TsWh/sR2Hmb+vwDu6lyV6Nzjj1VuUqLqNx/KW
 bfdZlEDYI5TvCThrsVSBBV9u2eIBl1yVtV2zxA2EwQQQ/PuCoVR+tHGQh4dWgaVMDmDk
 gwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265062; x=1689857062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tr1rTDfiq0RcGbvkGBpYZNXlVGVfs0mzt9B/xYUDj8Q=;
 b=MRTvFZ/8ZDvx+Z9BuMcCKee7emHKoiyLbQQmmRcHjs9uRfYdLY1qif6/H6ef0X2tt8
 gnMZHeZdmPFO+o6B9HBr0kQWkeOBlPGIePOYrsNGtVGB1mXHQf7ZwVBLUOYa+K1VdH0H
 X9IQNBb2EQNHGva7Wg9S8cykjY+lVan/SbBc6qWgizmiry0hFK7UAeQS739wPAjmrISs
 cU5pixMLVYspHSQLx1x1l2jWtniB3K+urKfhqvhXxUASUM+wmtmtGQFYe/ZGKlfoBIoG
 6GXj+oNfbXXXHK6t1VrK8D0uggP+jhrspb4uvYswTSlaED1sDRTRMftbQK1wWd/BR4Mc
 mJYw==
X-Gm-Message-State: AC+VfDyZqi08tykNjwPzhyja8z0KvFYmWAWX9OblQm0zfx5pPDG2Srcz
 AfoSqTGxJJmUV+6iwYNhtutcrq1sUu/2xJH4GkkRBEC+
X-Google-Smtp-Source: ACHHUZ6actceYG/JmEnfVHawYoOIAy5pecr0yqCXYenchYUG5LZWHoQxuwuLae74VlS1K39spBxiFg==
X-Received: by 2002:a19:6519:0:b0:4f8:6d54:72fa with SMTP id
 z25-20020a196519000000b004f86d5472famr3546755lfb.2.1687265062685; 
 Tue, 20 Jun 2023 05:44:22 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 02/20] target/arm: Update SCR and HCR for RME
Date: Tue, 20 Jun 2023 14:44:00 +0200
Message-Id: <20230620124418.805717-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Define the missing SCR and HCR bits, allow SCR_NSE and {SCR,HCR}_GPF
to be set, and invalidate TLBs when NSE changes.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  5 +++--
 target/arm/helper.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c84ec2752f..318d1033b8 100644
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
index d4bee43bd0..d2f0d9226e 100644
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


