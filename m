Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD791816C6A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:38:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsG-00071b-At; Mon, 18 Dec 2023 06:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsD-0006wN-Uo
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:25 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs6-0003M1-Hu
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:25 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33664b6d6abso898445f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899197; x=1703503997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dQNFeem1A7Gkll9ZhccsIPpsQeRDUIGH2XBhKC8Oc8w=;
 b=lp9KWJ/0pY9uKOWFI+v9QXn9bk9Ux+m8B5sMBr8TOhfq1fTNiu2dXi9F0neTXfbypQ
 P6i/Dqqp2dEofEwIIw4g/pL12G5qzW/Ww4RwuHP64dx//vlb548X6WB0+7BSMZ3V7Eeh
 mpEo++nKhrArV2mmuj0cLYdTS+cdIJaanyZHSvEFE5yP8yn5TzSppaI7W9dugosuWVA5
 uH4WfQOLCklbTq49x7IhZkCyKFb3nDeekAxyTsk+4u8iUPxpocJCELPC9Z2dtJAcuGCT
 NBaIniTPMigL+Ee6H5/hCt/8VM5IjmxC2B8cXxg+5S5yZT5mllKI2qBorKMqQF1Z5l8j
 SoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899197; x=1703503997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQNFeem1A7Gkll9ZhccsIPpsQeRDUIGH2XBhKC8Oc8w=;
 b=ujnqMv8nM3Hndzim/NZ6OffR1xxyj1ueyR66Xv9QAILfiXA/csYkv7TTwL4ClSowwL
 FXqWuIVoR+7DYrqjnqDBAFrBzP10KmXVpE34scHtEugVogEHJzuMRL7RZWN0/pYaMKPS
 6cFwl92r3QJUWPfReNQ88NCa5b3ofwkeGWV7DLIy90ldX4zxWhSIgQ3l0NknDqTgLklC
 sePPSVw32PJNwmw2GWfsPBXrkiomVSylDNiL/kqJeICMQeWzFvV/53hZ0dRchaDALWxY
 PMon5SVSfjeNb6cU0mqlAZ67ZJup3a+6Pdkhwa+XHNSlpLFb4/qwNA8dBkh9q6SSW+sH
 VoEQ==
X-Gm-Message-State: AOJu0YyZ8N9KhCwX+x9Dz3tw/b3hLyfdHn102+CCDSnJjUGqy7zKYGNt
 gkKDlUM2rIRjCzV+8RIVMjTu3A==
X-Google-Smtp-Source: AGHT+IGaPyArKlF4fq+zPUeiAeBebbqK11AeCEOQMyMznT90bgVJ4BWC5pImLHzJp2fWuEjHMSC3dQ==
X-Received: by 2002:a5d:4004:0:b0:336:6665:d99f with SMTP id
 n4-20020a5d4004000000b003366665d99fmr912531wrp.138.1702899197213; 
 Mon, 18 Dec 2023 03:33:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 22/35] target/arm: Handle HCR_EL2 accesses for FEAT_NV2 bits
Date: Mon, 18 Dec 2023 11:32:52 +0000
Message-Id: <20231218113305.2511480-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

FEAT_NV2 defines another new bit in HCR_EL2: NV2. When the
feature is enabled, allow this bit to be written in HCR_EL2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/helper.c       | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 3a43c328d9e..7a590c824cf 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -844,6 +844,11 @@ static inline bool isar_feature_aa64_nv(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, NV) != 0;
 }
 
+static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, NV) >= 2;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 28448624c36..afed58b6f7f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5841,6 +5841,9 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         if (cpu_isar_feature(aa64_nv, cpu)) {
             valid_mask |= HCR_NV | HCR_NV1 | HCR_AT;
         }
+        if (cpu_isar_feature(aa64_nv2, cpu)) {
+            valid_mask |= HCR_NV2;
+        }
     }
 
     if (cpu_isar_feature(any_evt, cpu)) {
-- 
2.34.1


