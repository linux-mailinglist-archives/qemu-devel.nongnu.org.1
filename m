Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F51D7C8C1B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:11:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLgM-00014m-Qi; Fri, 13 Oct 2023 13:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLgC-00013a-8g
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:29 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg8-0005ZS-Iq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:27 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b1ef786b7fso895664b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217022; x=1697821822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnIEHz3YbyZLNAezqFGknAR6TwEjyjNQhE5DMYmjFw8=;
 b=YjHc5EKIzlAKXdwsmYoGJJeweaOz9OY+WRjr++v9UtRNEH4UV1Y6xJDyYtHnEQyNbS
 BapU8UO9sRdjNXLf3GF01iHdS7ici+aznar6E88fXBPdwKVeyb3pv69TKokdKpcDrk3g
 cLBihmyUR82sEbTPZKJB80vNH1qnxJC+3cDLiZKxiJQ8e1GPVRBeHEu0xVjA7OHShAXh
 rLIJ3+lYOVYuZzXXdx2U6WeNTn0I55ocSg84g2BWi4tRAZjCekuzzqluvZlrgUR0mkk+
 EEWtGOx2RDvxioWN6w8iqsvsEqk9HAs2uvnVdIkVoQ1H67GrfwpTGJp7k+awQZiKtN5I
 wfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217022; x=1697821822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnIEHz3YbyZLNAezqFGknAR6TwEjyjNQhE5DMYmjFw8=;
 b=N9WqsynbZoe9PWi/fmEEAeg3G08IyjYwGRA43SYbt0F42oLuKF4PU+Y3o1m+pxkt39
 wPAYuZ0UEDB49pI7ZQdViD2aEQvrZV5hloEWQsAZT4EgZandJUs3uZbvWgw+UgCcd23m
 cFV5Qb5+uHzfGPfMOxQDxcBLwvxnqkPTQXZEfYDpv1YdFhvFZGB3s8cHUV2FWJ89KU3O
 qo2aNXJL18t7XPdE3FvgJpSOCpKpcVEi8iXt1dNijKv4MFFSY4Xy6Oo9zs9eAB2WClK6
 4uzYq5QpHIDqfeB1CLRZNKcG6kR3lShtYT2ClxJepXbQT95wCGKM2HbcehhdIePPYG9C
 FH2w==
X-Gm-Message-State: AOJu0Yxpt9T6uAp8AwPaR9acMkVUZoCjjri0tVJaZwRtd6dPl5uqHwN5
 QtzDKzAoRXDtxXi02kUkTpJQ2f568jTFQSmmC4k=
X-Google-Smtp-Source: AGHT+IGMcOc/y6mcmvTT+LLegGqIyhFSusrxS6gTyMK5nbXdxRhHW+jvkgnWDu7z381UlH3iFGax5w==
X-Received: by 2002:a05:6a00:230c:b0:68a:6305:a4cc with SMTP id
 h12-20020a056a00230c00b0068a6305a4ccmr32520294pfh.5.1697217022487; 
 Fri, 13 Oct 2023 10:10:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 09/13] tcg/ppc: Use prefixed instructions in
 tcg_out_mem_long
Date: Fri, 13 Oct 2023 10:10:08 -0700
Message-Id: <20231013171012.122980-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index f4235383c6..34df9144cc 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -329,6 +329,15 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
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
@@ -737,6 +746,20 @@ static ptrdiff_t tcg_pcrel_diff_for_prefix(TCGContext *s, const void *target)
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
@@ -1418,6 +1441,49 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
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


