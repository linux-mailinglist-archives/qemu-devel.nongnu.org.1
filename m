Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C32482ACDB
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:07:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssU-0001Rj-U3; Thu, 11 Jan 2024 06:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss7-0001LR-UN
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:16 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss5-0004PD-2c
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:14 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-336990fb8fbso4247960f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971111; x=1705575911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K1vEHP8jltuQvEGl4ENo7Bv8xIOD4gLXh77ifsMSwb4=;
 b=C/s/jOrROYR6YAXmXOVc/jezFwwA7UWADeJYwc/6ZwwVlE49nnLFh5+3B+uAZOZ7sO
 ZVyBs/8jw3QRebSxylxvoqwvimx0A8BzcfHdcpcQeIBunht8afbmc2UZUJKZuW6xWR/G
 zifAEs3JQmRt1NcqpERCguVcntcc0Zso1qbDSfUZzfiN36bOBKVJezQQxVXHIu8LpSZr
 vcdf9ojSRZ3GGQ8U7RVarLF1YhgSy3Z2YfaZc0JQ8hsBhZkJMi7MrPtawvVcvO1KRbuA
 tKazIxdH2cv76y2vuNwTioUPwkHkPYdvKZXsv0ncmcV4OXKp3P85glxDzobgd/pi75up
 Nx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971111; x=1705575911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1vEHP8jltuQvEGl4ENo7Bv8xIOD4gLXh77ifsMSwb4=;
 b=L0DqsBC71sQAJtp8KqPeOFRg1FT0WN4HYjnW60/Nc2LM8B3n+s98q1QIgOBFQfNfhh
 qjn9Wa5JJUspOkaMTgP3A79nECH5F6zHIbym9FjftoersmCXveP03nxXUylbRfxOAqcq
 LbRtceUPVVx822wNFY3cZL7FVB6RGBOUA5o5vvWgULmPLKqaA++NrXTbKjyFbYXNHppj
 EFBIKoj3jSpyc//tAkSrUbqC6PhEj0extKhlYSZ5t9Y2AKHA5hcCmx0ie+dGlMCHozj3
 VqKKe5N3O5QjKLIyeO2xkPg7uECjOS2NffuWMoJUgrmOZkI8jc3QOZDXHlzL6gcGnjYH
 xiCw==
X-Gm-Message-State: AOJu0YzftBJZH2mXuzaxABt1XlOZdUejsnBZFm+FEh14tR+1QhpJV+Zy
 5/xsh3JkGbq9ZpgYfSC/ziFhcUsF2TnS9l9/8xoMYaW1FkM=
X-Google-Smtp-Source: AGHT+IHd9pPeYYNaHaEtDHf0a64Q+e1O43jTZoAq7gBqFi7GrOUiXf6gbDZEvtGMBoFqHcpMKg2/rw==
X-Received: by 2002:a5d:4146:0:b0:336:6778:6220 with SMTP id
 c6-20020a5d4146000000b0033667786220mr560548wrq.48.1704971111373; 
 Thu, 11 Jan 2024 03:05:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/41] target/arm: Handle HCR_EL2 accesses for bits introduced
 with FEAT_NV
Date: Thu, 11 Jan 2024 11:04:34 +0000
Message-Id: <20240111110505.1563291-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

FEAT_NV defines three new bits in HCR_EL2: NV, NV1 and AT.  When the
feature is enabled, allow these bits to be written, and flush the
TLBs for the bits which affect page table interpretation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/helper.c       | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 954d3582685..3a43c328d9e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -839,6 +839,11 @@ static inline bool isar_feature_aa64_e0pd(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, E0PD) != 0;
 }
 
+static inline bool isar_feature_aa64_nv(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, NV) != 0;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7889fd45d67..4e5fd25199c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5815,6 +5815,9 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         if (cpu_isar_feature(aa64_rme, cpu)) {
             valid_mask |= HCR_GPF;
         }
+        if (cpu_isar_feature(aa64_nv, cpu)) {
+            valid_mask |= HCR_NV | HCR_NV1 | HCR_AT;
+        }
     }
 
     if (cpu_isar_feature(any_evt, cpu)) {
@@ -5833,9 +5836,10 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
      * HCR_DC disables stage1 and enables stage2 translation
      * HCR_DCT enables tagging on (disabled) stage1 translation
      * HCR_FWB changes the interpretation of stage2 descriptor bits
+     * HCR_NV and HCR_NV1 affect interpretation of descriptor bits
      */
     if ((env->cp15.hcr_el2 ^ value) &
-        (HCR_VM | HCR_PTW | HCR_DC | HCR_DCT | HCR_FWB)) {
+        (HCR_VM | HCR_PTW | HCR_DC | HCR_DCT | HCR_FWB | HCR_NV | HCR_NV1)) {
         tlb_flush(CPU(cpu));
     }
     env->cp15.hcr_el2 = value;
-- 
2.34.1


