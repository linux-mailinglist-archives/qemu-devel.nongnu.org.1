Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7FC77953C
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:52:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVLw-0005mP-GL; Fri, 11 Aug 2023 12:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLu-0005le-8g
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLs-0001Nd-KX
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:06 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc34b32785so16215825ad.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772663; x=1692377463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSaNKhqzYwOq4diDL6Wp3COIrsXI0IfNJEj6qqfJvRM=;
 b=IqZrj74AxZu23ERZGxLIL6yPHH9VFJQ8PDPWwpw7tKcJaAJsdZcP1xftLLsvvE6T6L
 FXr/X9CmYeTj748v6ONlsE4S3/csr5thqEoI7NbCSmy0UkuilU0NcoXCvsGhCSvfM9Ar
 pEuSotmHGJFJ99FUxWfsdjZgVOKBeS5C8FyLeFlIxOy5dmyqRt7MqoS6YsHkTuU9YsBG
 GOTo2thaphku9dqOKG8hG5oRXvkBbZYbweSxXTNAMEoBs5mnuvkFkLh/tl2pHF1q8P74
 wY/iY2D3BEK+PdXhD8J+nWi1lA3DlnJJXwg9eDYsXKqRqx1qF14zvgb4w0QP5+oV6ToJ
 yPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772663; x=1692377463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSaNKhqzYwOq4diDL6Wp3COIrsXI0IfNJEj6qqfJvRM=;
 b=dq3YgQnBvBBx8hJh4SrFsl6//QdcHRPIgHJMXSBHQmQ0Gari4k1hdHaErgO50biBPz
 8CEIEJV6IWg7IiWL4eXy8KLvGyu63OIvEBZ6JrGzsgLzhZUHsRjO8z4uwfPXpr3w5Wju
 N6Q3Ee2qqa/fGq/eZU2ETKxsnOpTL+vcCsstqjUyFUD69wrrAriCCHjH6ixABHrFkDNj
 QkecGsBNlVxSNx7hwFr3M18ZNViZIjjnaR1/pvJzd/su1h1FmySUvXQ4KmaVKUc3Wy32
 sKWTUajOGaWuM/hWvxxhVZP0A0tmJEeUviUIx4rybbvBA414Tu7300xzvWE11sw4nrX6
 uJTg==
X-Gm-Message-State: AOJu0Yz7muIUuzcsilGjBISVtw0EzdboUom+wxlsqOtndBU6ImwvzfLa
 Pv8/2c2DNapV7wLzF5i6yRMlXO6w9/ccvmaP3p8=
X-Google-Smtp-Source: AGHT+IFh4Fqf8zWPWJhp7YO49x5MsjA1IxlPyyXhvdddFn82DeWjsVm1ZMT3VceEYeUtQzAi1TCG/w==
X-Received: by 2002:a17:90b:144:b0:269:3bc6:9cc5 with SMTP id
 em4-20020a17090b014400b002693bc69cc5mr1530057pjb.40.1691772663206; 
 Fri, 11 Aug 2023 09:51:03 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:51:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH v3 10/15] target/arm: Add isar_feature_aa32_a32
Date: Fri, 11 Aug 2023 09:50:47 -0700
Message-Id: <20230811165052.161080-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811165052.161080-1-richard.henderson@linaro.org>
References: <20230811165052.161080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Add a probe for whether A32 mode is supported.
Fill in the field for the pre-v5 cpus.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       | 5 +++++
 target/arm/tcg/cpu32.c | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 88e5accda6..41d05839a2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3462,6 +3462,11 @@ static inline bool isar_feature_aa32_i8mm(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar6, ID_ISAR6, I8MM) != 0;
 }
 
+static inline bool isar_feature_aa32_a32(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_pfr0, ID_PFR0, STATE0) != 0;
+}
+
 static inline bool isar_feature_aa32_ras(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->id_pfr0, ID_PFR0, RAS) != 0;
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 47d2e8e781..ea8ccf59a9 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -145,6 +145,8 @@ static void arm926_initfn(Object *obj)
     cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
     cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSP, 1);
     cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
+    /* Similarly, we need to set STATE0 for A32 support.  */
+    cpu->isar.id_pfr0 = FIELD_DP32(cpu->isar.id_pfr0, ID_PFR0, STATE0, 1);
 }
 
 static void arm946_initfn(Object *obj)
@@ -158,6 +160,9 @@ static void arm946_initfn(Object *obj)
     cpu->midr = 0x41059461;
     cpu->ctr = 0x0f004006;
     cpu->reset_sctlr = 0x00000078;
+
+    /* We need to set STATE0 for A32 support. */
+    cpu->isar.id_pfr0 = FIELD_DP32(cpu->isar.id_pfr0, ID_PFR0, STATE0, 1);
 }
 
 static void arm1026_initfn(Object *obj)
@@ -187,6 +192,8 @@ static void arm1026_initfn(Object *obj)
     cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
     cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSP, 1);
     cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
+    /* Similarly, we need to set STATE0 for A32 support.  */
+    cpu->isar.id_pfr0 = FIELD_DP32(cpu->isar.id_pfr0, ID_PFR0, STATE0, 1);
 
     {
         /* The 1026 had an IFAR at c6,c0,0,1 rather than the ARMv6 c6,c0,0,2 */
-- 
2.34.1


