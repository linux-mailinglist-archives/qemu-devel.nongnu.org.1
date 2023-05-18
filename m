Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 456877081C5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:52:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6U-0004D9-4P; Thu, 18 May 2023 08:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6I-00049e-GE
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:24 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6C-0007yE-Jw
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f41dceb9d1so19556225e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414272; x=1687006272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TwDbjF8l3pQWDAsmh6VMzkv7CThxBT0If/DBybZ28xA=;
 b=P+zaZsrV0hBVPSdqmINaoqaH69lmLnOMmqFTU3CftCQzQQQPwcIXGhWdT/OCRsSFCV
 nZXEnVPL5yur+vjv+sm/OZ2toTNaDQQ7hO591YdnlWd2AY77Kxzr0EyPF+h37F14duEB
 xTbuch7Rc09nVQDfD81s5vyIoF9/prJ2+QmbURCe1WBjdgKco0emyw2ky6A2ZSEhXOyF
 S0ht6cOkIEcC574iIPViuPnWumMXPc/K9UKSZoyPlXCC/3UtE3da/Meancdv/tn7hcoc
 XwzYXoX31p73W4dkR/+q8tc91L2GgjyV3zJtSKX5eXla1iGax+4HZmDjGKOiGga16/M8
 C6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414272; x=1687006272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TwDbjF8l3pQWDAsmh6VMzkv7CThxBT0If/DBybZ28xA=;
 b=OyXaUoDAmKLqc+x/ANNjb+oQ6s9uJH0uspREsBVyU2XRCkVw08F+9G3vIVnN7xdb5r
 jxoXuR43SURTlnl9wd4fISWdGJDXuzQR/3d60TCj3JKCkeCXv1k1C/FyhdUiNYdoRRFT
 Kyg51Ok1HR26XQo8UepvgOudLpbrl37zQanRPYf/+fz1ySqBNVWX6y5Yl/EdhTHFzDX6
 qcKezUFE2nnH/kah+LTEqSoEL34kuRejwIn5ZOHOw0sj+NgPLfXk7rxOYXv4h4wmt+oR
 hMD2VtOnQ/8jg4yQhbGBToU4w+G7u43Fy2MJysSo3C18mcsKucqQKkoAdxOrRq4p+XZa
 Qb1w==
X-Gm-Message-State: AC+VfDwEfOoP15Boc5pZxjkdkO/Q4VQz82iWCfXWH2eTCBV22Wju3JR/
 RIwJYV/VmtTnzS7jTICoGd33PSUzlusCt8ezEWE=
X-Google-Smtp-Source: ACHHUZ699c3pZEY/z3pGTwzFPQN/w7/Lwd+sTTFzK50J2hdXnTabnHrkJnNAXm9kwBeUoTYaZwCDVw==
X-Received: by 2002:a05:600c:216:b0:3f4:253b:92a9 with SMTP id
 22-20020a05600c021600b003f4253b92a9mr1649515wmi.30.1684414271991; 
 Thu, 18 May 2023 05:51:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/29] target/arm: Split out disas_a64_legacy
Date: Thu, 18 May 2023 13:50:45 +0100
Message-Id: <20230518125107.146421-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Split out all of the decode stuff from aarch64_tr_translate_insn.
Call it disas_a64_legacy to indicate it will be replaced.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230512144106.3608981-2-peter.maydell@linaro.org
[PMM: Rebased]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 82 ++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index dff391bfe24..8a0ede96440 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -14200,6 +14200,49 @@ static bool btype_destination_ok(uint32_t insn, bool bt, int btype)
     return false;
 }
 
+/* C3.1 A64 instruction index by encoding */
+static void disas_a64_legacy(DisasContext *s, uint32_t insn)
+{
+    switch (extract32(insn, 25, 4)) {
+    case 0x0:
+        if (!extract32(insn, 31, 1) || !disas_sme(s, insn)) {
+            unallocated_encoding(s);
+        }
+        break;
+    case 0x1: case 0x3: /* UNALLOCATED */
+        unallocated_encoding(s);
+        break;
+    case 0x2:
+        if (!disas_sve(s, insn)) {
+            unallocated_encoding(s);
+        }
+        break;
+    case 0x8: case 0x9: /* Data processing - immediate */
+        disas_data_proc_imm(s, insn);
+        break;
+    case 0xa: case 0xb: /* Branch, exception generation and system insns */
+        disas_b_exc_sys(s, insn);
+        break;
+    case 0x4:
+    case 0x6:
+    case 0xc:
+    case 0xe:      /* Loads and stores */
+        disas_ldst(s, insn);
+        break;
+    case 0x5:
+    case 0xd:      /* Data processing - register */
+        disas_data_proc_reg(s, insn);
+        break;
+    case 0x7:
+    case 0xf:      /* Data processing - SIMD and floating point */
+        disas_data_proc_simd_fp(s, insn);
+        break;
+    default:
+        assert(FALSE); /* all 15 cases should be handled above */
+        break;
+    }
+}
+
 static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
                                           CPUState *cpu)
 {
@@ -14401,44 +14444,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         disas_sme_fa64(s, insn);
     }
 
-    switch (extract32(insn, 25, 4)) {
-    case 0x0:
-        if (!extract32(insn, 31, 1) || !disas_sme(s, insn)) {
-            unallocated_encoding(s);
-        }
-        break;
-    case 0x1: case 0x3: /* UNALLOCATED */
-        unallocated_encoding(s);
-        break;
-    case 0x2:
-        if (!disas_sve(s, insn)) {
-            unallocated_encoding(s);
-        }
-        break;
-    case 0x8: case 0x9: /* Data processing - immediate */
-        disas_data_proc_imm(s, insn);
-        break;
-    case 0xa: case 0xb: /* Branch, exception generation and system insns */
-        disas_b_exc_sys(s, insn);
-        break;
-    case 0x4:
-    case 0x6:
-    case 0xc:
-    case 0xe:      /* Loads and stores */
-        disas_ldst(s, insn);
-        break;
-    case 0x5:
-    case 0xd:      /* Data processing - register */
-        disas_data_proc_reg(s, insn);
-        break;
-    case 0x7:
-    case 0xf:      /* Data processing - SIMD and floating point */
-        disas_data_proc_simd_fp(s, insn);
-        break;
-    default:
-        assert(FALSE); /* all 15 cases should be handled above */
-        break;
-    }
+    disas_a64_legacy(s, insn);
 
     /*
      * After execution of most insns, btype is reset to 0.
-- 
2.34.1


