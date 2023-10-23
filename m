Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E707D3ED7
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:16:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQw-0005WT-Sp; Mon, 23 Oct 2023 14:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQv-0005Ve-3M
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:45 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQq-00085j-4H
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:44 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-564b6276941so2818456a12.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084819; x=1698689619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnIEHz3YbyZLNAezqFGknAR6TwEjyjNQhE5DMYmjFw8=;
 b=ScwISToGSRjtHeh2hnmZ5HHNKpOhBJkM31Yqfv5Jt6Ig/6nPR7Xe1pCK+5ARc0OGNY
 veADuNnB7VLi4i1vq9ERnBTlWMG6nL7SWiyclPgMf9j1ND7aNjH9/zu6GYYV+mdsM/A1
 w04DNFouMmwzNlycuqCQkG48ZkpTRty2cDO73v9lDgaOcHcGYBoj9lqI2BAHq5cpK4M/
 01mTMEefTiYvDRCUZ8uNDobU4SNbofg3NQrPnu3/5UQY0Rozi/4F9aNKieg5yWxs0G+6
 deHycCo8IOTuHfWyKBtflhV1X2pqQTUY+H7TRiZYiN3OU9DMTqOvuL/YIN0XXERuGp6r
 1prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084819; x=1698689619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnIEHz3YbyZLNAezqFGknAR6TwEjyjNQhE5DMYmjFw8=;
 b=vb9i9tMJxDzwU5kpm8KfikvxUbg/Ab6ovmEMRF9n2FVnomGpOguP6+cbxWAXA9RikD
 51AoK0/CiZJnmdDJ7x4FbYwAeUxhM4wGGtV3/HYNpNTMbLhWJ2exnyDTKlhiwxKrX550
 NXr8QRx4+HELxmMs/rrB+qSGR1kQoGrWkK7+V2oR0Qg9+kY2vozsus71lV1E02YzsdqT
 9BkX2LBARQTySDyuUGKRaA5rxeBBarlpALj/QaeejF/Lsc9j/fFOn1D4bNQ6MgVNutkH
 8m9SJ+Gu8cP07Eo1e2HRkXIWteUszdOTOqYK4PDPuHw8us32IooPDx3h1QBSJR31GZjK
 tCiQ==
X-Gm-Message-State: AOJu0YzSC+q+2UzLM340K99eT4G426YeqR1dU9xY6MkGnxLHA6P2FBuv
 G0p5Q1MyFw1RqNzpdi89MbD1UK0t25l81zccAr0=
X-Google-Smtp-Source: AGHT+IHaB+6XIZrrpT1MSB6sasiAdzajC6P8p8WBAhDn0Pi2znVzIx4RCvdD0NhfzZ4L3eewn6WHqg==
X-Received: by 2002:a05:6a20:da88:b0:17e:2afd:407f with SMTP id
 iy8-20020a056a20da8800b0017e2afd407fmr499358pzb.9.1698084818831; 
 Mon, 23 Oct 2023 11:13:38 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jordan Niethe <jniethe5@gmail.com>
Subject: [PULL v3 09/38] tcg/ppc: Use prefixed instructions in tcg_out_mem_long
Date: Mon, 23 Oct 2023 11:13:00 -0700
Message-Id: <20231023181329.171490-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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


