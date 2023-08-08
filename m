Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B13E773744
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:04:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCzq-0001N3-P3; Mon, 07 Aug 2023 23:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzp-0001Mi-Mw
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:57 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzn-0006ZZ-Nh
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:57 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68783004143so3679403b3a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691463774; x=1692068574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHOVm1j3rxxzTzvqcEEGiLi8+wjs2ljwtbn2VN1LzVo=;
 b=JTPG/2QSiPWd0gRNTL7Ng63wxMf7leHtb3axzW+MW2d4umyLPMuYlMYfZHi2SdDXuX
 V68s2HYJcs14Csr+Hm7k7lgNPC835EWNR+Khh9XogQOZaJk+Q/Pvg3SOROo11GmLZS/1
 J2a2ITDpDZ1oezpTfzS1rlem4wvaMw37zKKnQqYJrQRY8mD+k4piPfGhEC7UJjN4UYff
 GLqeGp2gZOKR1VQ6RdssYMAElNKf0WxoC+CNuYIgTUiJTekofA8KaZJMHJwEWf26/n6Y
 kU3+3xNEIc357VRJKXfkFuQv56GzXllSZotQhhQVqppFm/tOpF67JIHB5osLhrIIcW57
 h9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691463774; x=1692068574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHOVm1j3rxxzTzvqcEEGiLi8+wjs2ljwtbn2VN1LzVo=;
 b=MLG/0Q8k7S0gscl1CpfntApf55h3+hPQva4GwPQnRwDvX2ceoyVGGReZILfF+LVduY
 uD3G5S8m8tStNQpbrHyX2q8dsp4wf2ZO5RD3Q5Gp/aijp/La1L+CsftwI9ThODXB7X0z
 YrVJbuLIo0hwySRbecj8TAjxtQZi3dWjbspddtBOFxohvRAbKlBIisa2PRCfaYmU7yHU
 qTL0D8JJAb4T1joVofowkZQR4f1+n+NIN4RkDlMQIkC+E1YvnHMTl9eS0voKIqnCxiiY
 wNqvIGk/V03yLGDlYRD9Ccr/CMPZSuq3i+wRVRkXjj8vr73z1sKJGAV45yRwrGPVWVT4
 OLIw==
X-Gm-Message-State: AOJu0YzwSqkF1l+CoypKBWZLfzrPeI3Rec01AaBc1NPQkIT8JtKuUP0a
 HjiD2yOymfZ/R0D18YQBhQN8IQ+rOYuiosWOOUE=
X-Google-Smtp-Source: AGHT+IG8jmjxo98MiQwuyqZVGFro208GCSFQLSSsTMkf34wsE4NPJJOqMqTcp5dTrYodcADSgAmCwA==
X-Received: by 2002:a05:6a00:2294:b0:67a:c810:3cb0 with SMTP id
 f20-20020a056a00229400b0067ac8103cb0mr10675440pfe.3.1691463774319; 
 Mon, 07 Aug 2023 20:02:54 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a62e407000000b006870c50efaesm6903609pfh.9.2023.08.07.20.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:02:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com,
	jniethe5@gmail.com,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 3/7] tcg/ppc: Use prefixed instructions in tcg_out_mem_long
Date: Mon,  7 Aug 2023 20:02:46 -0700
Message-Id: <20230808030250.50602-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808030250.50602-1-richard.henderson@linaro.org>
References: <20230808030250.50602-1-richard.henderson@linaro.org>
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

When the offset is out of range of the non-prefixed insn, but
fits the 34-bit immediate of the prefixed insn, use that.

Reviewed-by: Jordan Niethe <jniethe5@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 66 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 2141c0bc78..61ae9d8ab7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -323,6 +323,15 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
 #define STDX   XO31(149)
 #define STQ    XO62(  2)
 
+#define PLWA   OPCD( 41)
+#define PLD    OPCD( 57)
+#define PLXSD  OPCD( 42)
+#define PLXV   OPCD(25 * 2 + 1)  /* force tx=1 */
+
+#define PSTD   OPCD( 61)
+#define PSTXSD OPCD( 46)
+#define PSTXV  OPCD(27 * 2 + 1)  /* force sx=1 */
+
 #define ADDIC  OPCD( 12)
 #define ADDI   OPCD( 14)
 #define ADDIS  OPCD( 15)
@@ -725,6 +734,20 @@ static ptrdiff_t tcg_pcrel_diff_for_prefix(TCGContext *s, const void *target)
     return tcg_pcrel_diff(s, target) - (tcg_out_need_prefix_align(s) ? 4 : 0);
 }
 
+/* Output Type 00 Prefix - 8-Byte Load/Store Form (8LS:D) */
+static void tcg_out_8ls_d(TCGContext *s, tcg_insn_unit opc, unsigned rt,
+                          unsigned ra, tcg_target_long imm, bool r)
+{
+    tcg_insn_unit p, i;
+
+    p = OPCD(1) | (r << 20) | ((imm >> 16) & 0x3ffff);
+    i = opc | TAI(rt, ra, imm);
+
+    tcg_out_prefix_align(s);
+    tcg_out32(s, p);
+    tcg_out32(s, i);
+}
+
 /* Output Type 10 Prefix - Modified Load/Store Form (MLS:D) */
 static void tcg_out_mls_d(TCGContext *s, tcg_insn_unit opc, unsigned rt,
                           unsigned ra, tcg_target_long imm, bool r)
@@ -1368,6 +1391,49 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
         break;
     }
 
+    /* For unaligned or large offsets, use the prefixed form. */
+    if (have_isa_3_10
+        && (offset != (int16_t)offset || (offset & align))
+        && offset == sextract64(offset, 0, 34)) {
+        /*
+         * Note that the MLS:D insns retain their un-prefixed opcode,
+         * while the 8LS:D insns use a different opcode space.
+         */
+        switch (opi) {
+        case LBZ:
+        case LHZ:
+        case LHA:
+        case LWZ:
+        case STB:
+        case STH:
+        case STW:
+        case ADDI:
+            tcg_out_mls_d(s, opi, rt, base, offset, 0);
+            return;
+        case LWA:
+            tcg_out_8ls_d(s, PLWA, rt, base, offset, 0);
+            return;
+        case LD:
+            tcg_out_8ls_d(s, PLD, rt, base, offset, 0);
+            return;
+        case STD:
+            tcg_out_8ls_d(s, PSTD, rt, base, offset, 0);
+            return;
+        case LXSD:
+            tcg_out_8ls_d(s, PLXSD, rt & 31, base, offset, 0);
+            return;
+        case STXSD:
+            tcg_out_8ls_d(s, PSTXSD, rt & 31, base, offset, 0);
+            return;
+        case LXV:
+            tcg_out_8ls_d(s, PLXV, rt & 31, base, offset, 0);
+            return;
+        case STXV:
+            tcg_out_8ls_d(s, PSTXV, rt & 31, base, offset, 0);
+            return;
+        }
+    }
+
     /* For unaligned, or very large offsets, use the indexed form.  */
     if (offset & align || offset != (int32_t)offset || opi == 0) {
         if (rs == base) {
-- 
2.34.1


