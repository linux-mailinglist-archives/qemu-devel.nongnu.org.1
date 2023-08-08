Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3974D77374B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCzr-0001NV-BR; Mon, 07 Aug 2023 23:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzq-0001N1-8u
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:58 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzo-0006a4-O4
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:58 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686f8614ce5so5175119b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691463775; x=1692068575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XokUtbe+DsLYWyevZrlewM8nCsy1TFXDfLF6baDQHOE=;
 b=wPwKuh4WUGKaOcRqdeltxuwtQCALNgXPFt1NZHzkK2wYgCqOXYWdVqySlg5t+IAwyB
 av4RqWiaD6QTfQ1kuD7WS+6sOvXD15Qpf/diLzdfczPDtoJLre1K7mFwTWpDqUxJ/spg
 Ufclm8ZhPAmZLBfGFDamVeDy6lc1ggbBRU+XfDqMwtSIVH1yAJZVnTEDWuPuhy0mmxVi
 FvEX/xjnxDleeVg/1xZ0AE/hat0wefIkCGqHb/1nsU8LuYAGV4yk/I15UgdpK27+vVrj
 /mDCsZNR5Rd2wd7uRric4tU/A85NSWQGMJ6NX+XYp0kvPwPkcGZE3+yBuOMre6lGZ2qX
 ksOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691463775; x=1692068575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XokUtbe+DsLYWyevZrlewM8nCsy1TFXDfLF6baDQHOE=;
 b=Ih1XsjGiCwsXeLqApKubceIObfeuIJsfaANx9lHPg4L1y07rhZ0ziBV/clg7T46vL/
 LjcNdBChG8DCw/P+vmc3oz17LhP00XCFfmX0dUemJ5xYlf4jMMIj7h9qM7sP1wYgZWLx
 p5L/PFy9IRyuPXb3Y9Oo5bASeXc9rrZbYOiHtkPqSaCsBoZ1u/DBGUhFQdYadsClHn3V
 9JSvCr9ZiiZCpKlM42pVyHF2yvCBmkP82GrDJvV01Wv4+Hziriy60ZvtvzU4QsyHMb06
 Zpr5VVfD2w6YdLCyVomdNOpJntZTyGn4GZnCVuqSnF7R8qmVB9d32ykNFjKMgbESmA/1
 Nfew==
X-Gm-Message-State: AOJu0YzLzW1bVhTprPEYl+nr5dDBko/3sEOtA/A4MddzYKOHKye+4fAT
 J8gRswHazkg2sOvAxip+DhHKGSMiiCWWvpPA93c=
X-Google-Smtp-Source: AGHT+IGrPY8nAtbDZ0tm2bwvFTyWJmSpPlD8OS0LVHXx4T7lpC0K3xyWkBNMGJSPg3hV2X1Ox4laoQ==
X-Received: by 2002:a05:6a00:1305:b0:666:e621:d83e with SMTP id
 j5-20020a056a00130500b00666e621d83emr13765296pfu.13.1691463775303; 
 Mon, 07 Aug 2023 20:02:55 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a62e407000000b006870c50efaesm6903609pfh.9.2023.08.07.20.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:02:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com,
	jniethe5@gmail.com,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 4/7] tcg/ppc: Use PLD in tcg_out_movi for constant pool
Date: Mon,  7 Aug 2023 20:02:47 -0700
Message-Id: <20230808030250.50602-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808030250.50602-1-richard.henderson@linaro.org>
References: <20230808030250.50602-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

The prefixed instruction has a pc-relative form to use here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 61ae9d8ab7..b3b2e9874d 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -101,6 +101,10 @@
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
 
+#ifndef R_PPC64_PCREL34
+#define R_PPC64_PCREL34  132
+#endif
+
 #define have_isel  (cpuinfo & CPUINFO_ISEL)
 
 #ifndef CONFIG_SOFTMMU
@@ -260,6 +264,19 @@ static bool reloc_pc14(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return false;
 }
 
+static bool reloc_pc34(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+{
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    ptrdiff_t disp = tcg_ptr_byte_diff(target, src_rx);
+
+    if (disp == sextract64(disp, 0, 34)) {
+        src_rw[0] = (src_rw[0] & ~0x3ffff) | ((disp >> 16) & 0x3ffff);
+        src_rw[1] = (src_rw[1] & ~0xffff) | (disp & 0xffff);
+        return true;
+    }
+    return false;
+}
+
 /* test if a constant matches the constraint */
 static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
 {
@@ -684,6 +701,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         return reloc_pc14(code_ptr, target);
     case R_PPC_REL24:
         return reloc_pc24(code_ptr, target);
+    case R_PPC64_PCREL34:
+        return reloc_pc34(code_ptr, target);
     case R_PPC_ADDR16:
         /*
          * We are (slightly) abusing this relocation type.  In particular,
@@ -1111,6 +1130,11 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 
     /* Use the constant pool, if possible.  */
+    if (have_isa_3_10) {
+        tcg_out_8ls_d(s, PLD, ret, 0, 0, 1);
+        new_pool_label(s, arg, R_PPC64_PCREL34, s->code_ptr - 2, 0);
+        return;
+    }
     if (!in_prologue && USE_REG_TB) {
         new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
                        tcg_tbrel_diff(s, NULL));
-- 
2.34.1


