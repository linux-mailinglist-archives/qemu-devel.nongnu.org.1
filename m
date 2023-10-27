Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 552147D9BD3
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:43:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO07-0007C2-9l; Fri, 27 Oct 2023 10:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO05-0007BU-94
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO03-00086o-GX
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32df66c691dso1384611f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417586; x=1699022386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FghHrdgVHqfiNAiADjKXA2QTjN97EJHzwctjZgJ8ESM=;
 b=Y9cLWH7DSpXupAJGlkNVHqSeyBlqp8wsEX7EzyVzb7uXylaIyndWUIHfvP9zSOzg/u
 ztIaX1ejqw/TCRG8U+etM/HmdiwFGs4QGV4/qXvj0nf8Voql9uBZzZFibSe45dXnAuwW
 gDFrXR4fxAytfGjJ0ltmKm9nzeh+WILu9fIWThs5kemF3DbN7Oh7LYKPOvIC3nJscXiN
 bMBqTgVQQW89gdvmZrAyTGzvpNV1gAZuLuwfauMZmsIxjwQTfARqBaUrjJDXZjEQb/TZ
 X7s0Enod1AJrIpJJaD1EUBD0MMra5IXDHJKPG70u0FhsyWV7sdfGZMVr3I+qj6EToj6U
 iB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417586; x=1699022386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FghHrdgVHqfiNAiADjKXA2QTjN97EJHzwctjZgJ8ESM=;
 b=ebsYDmix5pirsk41HJaN3fgWxdWTC/4bD7ob8xFDjjrFN/+wFLWNZU6RRr9Aw2U951
 V2gPM7pR2H8mStEPqIdDeITEFU96LHoB/wJ7/L47vo1EXRazDfyB24/jJ0doN2I1b4ba
 RPgjRc1m0ReXpULxH9eyXpDBDATZx/E1k96CAWkcvgnlUrYFER0rdVpVf6VWHzKoznYA
 bI+oeYgIt0J9DDsRzx/GlOgq9SkjbMQUr/bsz77LQ8FudvA4mcVGupb1LLmzE6CEHtKm
 8xvJA4AvjjzefTmmJGPo/hNgZ0eDu6eF9KXEdYdgLYoAFlu6f7CNhYyjWBZ7o0MLksME
 WnIQ==
X-Gm-Message-State: AOJu0YxY2OSocIut092x1n0aObJlhPXdhL+CoXjhnhuqRR+mFuk23zow
 VxejF414HUkPFmOQ2/eapurP9oTlWdqIuewdDSo=
X-Google-Smtp-Source: AGHT+IEiWYI6EoKAFp/qMlX9t6Y5WcYwKKksyPalZ42f9pPdTLuPrOYEv4zO0zu/Q7FqtIMEEJV61Q==
X-Received: by 2002:adf:dd83:0:b0:32d:a404:404e with SMTP id
 x3-20020adfdd83000000b0032da404404emr1965644wrl.60.1698417586086; 
 Fri, 27 Oct 2023 07:39:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/41] target/arm: Move ID_AA64MMFR1 and ID_AA64MMFR2 tests
 together
Date: Fri, 27 Oct 2023 15:39:05 +0100
Message-Id: <20231027143942.3413881-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Our list of isar_feature functions is not in any particular order,
but tests on fields of the same ID register tend to be grouped
together.  A few functions that are tests of fields in ID_AA64MMFR1
and ID_AA64MMFR2 are not in the same place as the rest; move them
into their groups.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231024163510.2972081-3-peter.maydell@linaro.org
---
 target/arm/cpu-features.h | 60 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index bfc9bfafe70..fc85a8fe130 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -641,6 +641,21 @@ static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR1, TIDCP1) != 0;
 }
 
+static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
+}
+
+static inline bool isar_feature_aa64_hdbs(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) >= 2;
+}
+
+static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
+}
+
 static inline bool isar_feature_aa64_uao(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, UAO) != 0;
@@ -676,6 +691,21 @@ static inline bool isar_feature_aa64_evt(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, EVT) >= 2;
 }
 
+static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
+}
+
+static inline bool isar_feature_aa64_lva(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, VARANGE) != 0;
+}
+
+static inline bool isar_feature_aa64_e0pd(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, E0PD) != 0;
+}
+
 static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
@@ -794,36 +824,6 @@ static inline bool isar_feature_aa64_fgt(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, FGT) != 0;
 }
 
-static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
-}
-
-static inline bool isar_feature_aa64_lva(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, VARANGE) != 0;
-}
-
-static inline bool isar_feature_aa64_e0pd(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, E0PD) != 0;
-}
-
-static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
-}
-
-static inline bool isar_feature_aa64_hdbs(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) >= 2;
-}
-
-static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
-}
-
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, DIT) != 0;
-- 
2.34.1


