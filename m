Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF377D3C3
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 21:59:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Av-00058i-7U; Tue, 15 Aug 2023 15:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0As-00056g-1Q
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:54 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ap-00014T-H6
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:53 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686f1240a22so5734502b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129470; x=1692734270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3aggFvLmkyyl4eR3KUMuICtg6+359fE3pW160k38Qs=;
 b=KkdJjxmPf9lI7OCk0OpP8JtvjIIzlItLrvtHxYv+gvd1uCAELXYT593RWMuWAJmnYq
 JjRG3IkYCQuBMScU6olOkgbI3o8HDCmrGNTLF8E5x3c8b8Biw5Cqr9Of5YEugAVYBvuW
 XRX/8dCpUvM1cAo9lO0sEBAvFF64vp5otLcOAL/puunKnzcB9d+2VCzSvmmPZlYWGKaM
 hF0pvcwYavtL/w8Dz7viVXwaUB24YHbHDaYHUtbMGUl0z3TzsxNlU/Q8GX64n9cwTOge
 PaPHkZH2+GWUAO8AZ9itLF33d2SY2w9kfYl/+sLIetmxSMtI2UwDEMJpVAYkMLAO2iKX
 dL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129470; x=1692734270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3aggFvLmkyyl4eR3KUMuICtg6+359fE3pW160k38Qs=;
 b=LZsZXAgRDJYccHXzw+hiHXqwb74JLlMBUSGNih08Smy5b8Ui0c8RYk1x8gDFfZ9FQh
 D6oXGXT5HkQN4E/BL5qrY0nnpJBEI7KlnphxiRXsUnsYlx8CPteLirBlanZa4ukY47RA
 qXzlaig8wzKdvZq83ZIJ5AivTe6GH1FlwrzOYhba3v/UXHLuWFXU4dveJxCZ4YWL3hDO
 X8iZ1KvbGixwsmwICmQPM2qVHS/y9mnrs7TU+TWuTFhnWTavyLV90MLf75h3pqq0fDiC
 +868RRjcBOGZgUHFMhagmfB7OZYSL5wqXoW8GZIRyD24fIEa01OE/NviXGLG5h3wzy/7
 WB5Q==
X-Gm-Message-State: AOJu0Ywa/9AYebwyFkpxYbOVFeOLASZg2tJ8dOPct6+gAJVjGxfKP6WQ
 c96VLY6e6E12KzeiReDt9V5RZOXdwqrAxiUNFh4=
X-Google-Smtp-Source: AGHT+IHIhI7VmVhk3kkyvqBKothXLGqeCknbaLhFRHR6LM2XX6uqaDeXWoKIpsQjOGIT1sYHkOG0NQ==
X-Received: by 2002:a05:6a20:748b:b0:132:2f7d:29ca with SMTP id
 p11-20020a056a20748b00b001322f7d29camr17481785pzd.24.1692129470227; 
 Tue, 15 Aug 2023 12:57:50 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 07/14] tcg/ppc: Use ADDPCIS for the constant pool
Date: Tue, 15 Aug 2023 12:57:34 -0700
Message-Id: <20230815195741.8325-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index a302bfff2e..a5c1891eb6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1076,6 +1076,12 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
+    if (have_isa_3_00) {
+        tcg_out_addpcis(s, TCG_REG_TMP2, 0);
+        new_pool_label(s, arg, R_PPC_REL14, s->code_ptr, 0);
+        tcg_out32(s, LD | TAI(ret, TCG_REG_TMP2, 0));
+        return;
+    }
 
     tmp = arg >> 31 >> 1;
     tcg_out_movi(s, TCG_TYPE_I32, ret, tmp);
@@ -1133,6 +1139,10 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
         add = ppc_tbrel_diff(s, NULL);
+    } else if (have_isa_3_00) {
+        tcg_out_addpcis(s, TCG_REG_TMP1, 0);
+        rel = R_PPC_REL14;
+        add = 0;
     } else {
         rel = R_PPC_ADDR32;
         add = 0;
@@ -1159,6 +1169,8 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (USE_REG_TB) {
         tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, 0, 0));
         load_insn |= RA(TCG_REG_TB);
+    } else if (have_isa_3_00) {
+        tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, TCG_REG_TMP1, 0));
     } else {
         tcg_out32(s, ADDIS | TAI(TCG_REG_TMP1, 0, 0));
         tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, TCG_REG_TMP1, 0));
-- 
2.34.1


