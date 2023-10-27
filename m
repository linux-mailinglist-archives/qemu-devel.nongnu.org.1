Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCC97D9C1F
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO08-0007CK-0B; Fri, 27 Oct 2023 10:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO06-0007Bm-Dt
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO04-00086y-Jj
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:50 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso16772105e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417587; x=1699022387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NEjtn4tYJYgyuJoAFl2Zq6orFVKNiTU3YlEdz7lzhAM=;
 b=yNT7sVRq0fCscGduhZ9kbVjKZNKSk51Vi2eWTzOkL1IjYPpw8qhMYf4GeKiF0KUWgo
 40MPZjJV/AtdZ7yjRDPDDC/aeJXgKpkOqMoOHWd5C8k24wYKyf0d9qf31Vwx7xCl70m9
 9+zflSDqInEvch5sf+KY68LrCn12z4A5uRLf5kPJLQyHZsGN5KRd8YoPYChHl5TPeLPi
 +KhdRRb9Sfw5+sZNkZOBJoUW/sWw1LcXuWbOfyoqoHBPaq/Ppp4tCgVSsYEvQiwK3VNv
 Dt2lwSPqJKgbH5yG5yLVadDwM8myFU4M2/ezcEpg0S0Xclj0Q55Puc2qLl3hGUdlF3ce
 ZE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417587; x=1699022387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEjtn4tYJYgyuJoAFl2Zq6orFVKNiTU3YlEdz7lzhAM=;
 b=peoqVzMC5MpPD8PaVEHbNS8O7nQDIQc4wd6MH28vJ43Cu7Rk4448nVm8zYqqBjYy9i
 X2CFCCvdk7XC9RrVr/qfLpfRVj676brcr3Vp7ZDj9WeWU3cnL46Fnb+N9WTGW2mfjQu9
 3LJFkSBHDVPlln01MtvCIG+vj8e+809Umiy5q06cATJpe6DmH+YXJL9Qn9ICUfshCKjj
 Jas6SLSSa50oKqHvE30g+6UBexyAQMfuTGmZk66Xuy5OSpm12Lkx7neVrflR7Dmu6A7E
 ZvgBjXca+NacPmhlvj4ytshKEsL+8wbs+ZklwAu0CqNpDCM3BG3KdNsQc59+ScMi5NNA
 cgJQ==
X-Gm-Message-State: AOJu0Yy+Kdt7/nKCPA7OS+cytRmuSQ4Y+HW8lVjNavXwKYFWgdzmlAeD
 zyc4i/Lh9Wm8/JQyJFCs2hWCrOmtQSO786LwqG0=
X-Google-Smtp-Source: AGHT+IHjDqXBxOt0GZEccTctJ1P31Oopy6nHyA+YU+nw22997XfgdAiZ3vyi8f8JLiwA1QkjIQ14pQ==
X-Received: by 2002:adf:f24a:0:b0:32d:a476:527a with SMTP id
 b10-20020adff24a000000b0032da476527amr2346250wrp.50.1698417587009; 
 Fri, 27 Oct 2023 07:39:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/41] target/arm: Move ID_AA64ISAR* test functions together
Date: Fri, 27 Oct 2023 15:39:07 +0100
Message-Id: <20231027143942.3413881-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Move the feature test functions that test ID_AA64ISAR* fields
together.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231024163510.2972081-5-peter.maydell@linaro.org
---
 target/arm/cpu-features.h | 70 +++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 90200a4b98f..e73120ef974 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -451,6 +451,16 @@ static inline bool isar_feature_aa64_rndr(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RNDR) != 0;
 }
 
+static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) == 2;
+}
+
+static inline bool isar_feature_aa64_tlbios(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) != 0;
+}
+
 static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
@@ -514,16 +524,6 @@ static inline bool isar_feature_aa64_pauth_qarma3(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3) != 0;
 }
 
-static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) == 2;
-}
-
-static inline bool isar_feature_aa64_tlbios(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) != 0;
-}
-
 static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SB) != 0;
@@ -554,6 +554,31 @@ static inline bool isar_feature_aa64_bf16(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) != 0;
 }
 
+static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
+}
+
+static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
+}
+
+static inline bool isar_feature_aa64_i8mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, I8MM) != 0;
+}
+
+static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
+}
+
+static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
+}
+
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
@@ -804,26 +829,6 @@ static inline bool isar_feature_aa64_pmuv3p5(const ARMISARegisters *id)
         FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
-static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
-}
-
-static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
-}
-
-static inline bool isar_feature_aa64_i8mm(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, I8MM) != 0;
-}
-
-static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
-}
-
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, DIT) != 0;
@@ -922,11 +927,6 @@ static inline bool isar_feature_aa64_doublelock(const ARMISARegisters *id)
     return FIELD_SEX64(id->id_aa64dfr0, ID_AA64DFR0, DOUBLELOCK) >= 0;
 }
 
-static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
-}
-
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
-- 
2.34.1


