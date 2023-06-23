Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BAB73B77E
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:37:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfx6-0001WB-B7; Fri, 23 Jun 2023 08:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfwz-0001U2-B7
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:41 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfwx-0000eN-Aa
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:40 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f86e1bdce5so721782e87.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523497; x=1690115497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sSVcljr7M4U3vXfHfoYsOK7O4LxyuTaZb75s4ri4QDU=;
 b=IcGu5ZmBVUjWxH27uJ1wW9pxLtiePlmpDu8Cg7JVfGFiGjmhKtkzesMiuzm4XMGKuX
 mYBkaIQz3hR0s6q3ekcCrlRvIjv/QBS1oV0aGYonkYfW/TsOiWnhs9nGXl4QwLvqogR2
 2RnI9jYqIWWIluIsAkneOmO3KUiCLcUJSGD4M/2fnw/osYfRYB1Ddjcq47DRjR0tv5lI
 cu/iA+UGZgfHqN3c45EIwaaO8IeFRVcNZnwSpiKKIg8Ar5h49Ans/jaHJ2YZom5m+ZkE
 B3G98NjI7Q13EfZSBDQQxff+BACVTxpKr+NSZ/HsxOxXL4HCiLwDC+EQApaTKYFUMenh
 Ectg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523497; x=1690115497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSVcljr7M4U3vXfHfoYsOK7O4LxyuTaZb75s4ri4QDU=;
 b=G492GOsqYJ0b5Vee/gyqKNT8okBh3Tds2V41//BYG5dXE+wYl8tcwiGjZUIDrUQ9+2
 jxNYFZmVvMzfapeIMTrM+nUGnN7bXU+AUqFAlGhK8pix7KCMkoH1bOGdlqfro0qBALGt
 SKSmUIJfYt0cYjf0SnV614LeCVjqTbY9jDD3welqjxo08Nw42p7gN/aAXzp7Bp+CC+3b
 EGpl6c0K3rT23EuwDGUsSPykclE5lJsxfPmUb+QVxrw8vuJGfyRX65VROxTsHrqVMKht
 D8L7XSnde4MYzjNDksMw2TTHnE1l4GYnDH8GaGfSRYRSSSxymKTHWcJOVS1EFQY9g/i+
 P0Rw==
X-Gm-Message-State: AC+VfDwkWLLsPH8eyBVgD9fzrtsul2qzHg8j9TBAh4PYlbHBBVkOyK8i
 ULFoiPsVkDLatHFojFEX73R5K1bGZQ02KhzOlFs=
X-Google-Smtp-Source: ACHHUZ5V4t3YfyHoA3vCFXbQ2gCsSR+O1DI0mRnQF9buWE585C5FkM85F4ipSGSklLvBTPfYGvZTxg==
X-Received: by 2002:ac2:4d8d:0:b0:4f8:75b0:2295 with SMTP id
 g13-20020ac24d8d000000b004f875b02295mr4326783lfe.4.1687523497643; 
 Fri, 23 Jun 2023 05:31:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/26] target/arm: Add isar_feature_aa64_rme
Date: Fri, 23 Jun 2023 13:31:10 +0100
Message-Id: <20230623123135.1788191-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

Add the missing field for ID_AA64PFR0, and the predicate.
Disable it if EL3 is forced off by the board or command-line.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 6 ++++++
 target/arm/cpu.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index af0119addfb..c84ec2752f6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2195,6 +2195,7 @@ FIELD(ID_AA64PFR0, SEL2, 36, 4)
 FIELD(ID_AA64PFR0, MPAM, 40, 4)
 FIELD(ID_AA64PFR0, AMU, 44, 4)
 FIELD(ID_AA64PFR0, DIT, 48, 4)
+FIELD(ID_AA64PFR0, RME, 52, 4)
 FIELD(ID_AA64PFR0, CSV2, 56, 4)
 FIELD(ID_AA64PFR0, CSV3, 60, 4)
 
@@ -3814,6 +3815,11 @@ static inline bool isar_feature_aa64_sel2(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SEL2) != 0;
 }
 
+static inline bool isar_feature_aa64_rme(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RME) != 0;
+}
+
 static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 353fc485673..842e1b53ee4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1989,6 +1989,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, COPSDBG, 0);
         cpu->isar.id_aa64pfr0 = FIELD_DP64(cpu->isar.id_aa64pfr0,
                                            ID_AA64PFR0, EL3, 0);
+
+        /* Disable the realm management extension, which requires EL3. */
+        cpu->isar.id_aa64pfr0 = FIELD_DP64(cpu->isar.id_aa64pfr0,
+                                           ID_AA64PFR0, RME, 0);
     }
 
     if (!cpu->has_el2) {
-- 
2.34.1


