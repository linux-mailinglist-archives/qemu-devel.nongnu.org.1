Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D877D3CF
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Ax-0005A8-5W; Tue, 15 Aug 2023 15:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Av-00059B-5e
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:57 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0As-00015Y-Hp
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:56 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6887059f121so586573b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129473; x=1692734273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqBKPmbTeyzbaEOoqwFakyRjcnv8k/gpOjB7jfp4teM=;
 b=Iph7fDMSyC3A81kverLqvoj0p1sM6GHXO+KQgSLyJzG5NGNdsTj/tIgS1vg2lycEaU
 VNC5jzIKPkpSuUonn+zIG1LC9rNVS3zwh082eCRRyBBZcetZ2JwLq1TFSW37acAoIL5G
 zJSzve5W70Gd8B1uqp80DEM4bNhO4AXCPHwoCOg0ZmUlZaZriXOE4uqw33T97Et0Isg7
 7YsvhnP5YDi4Rln01YwzH0JJEgEeIRwrHZIG0gxSioK3Wl9BUpN+eELt13BRUuXu7e/W
 dssDLh0LaX4hvxIt3NI3xTPQ0D7Mq6ylECbQDkS11Q6MI+F+8yGmM2ILX1lHhSMFalK7
 b6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129473; x=1692734273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NqBKPmbTeyzbaEOoqwFakyRjcnv8k/gpOjB7jfp4teM=;
 b=eAsSGICywoJLCVIsYw8HcpR3X4jsjOy2PPkdaBXdi+P7e8fE+rNC4disqiK0evgReR
 e3Myb3fg5oBKswAdL2VyRq8tUAGFipDHkTwolTnmvP5UUjBjs1gWDAo5e3Lgg3XyxeI4
 AaO19JQJwiPKSWcgcCIQ2lROZsQ6jk8KFZLUwt2iJ9j7kN+8jfU6QsAKC6rfIHXHKkTL
 htugxcPwtIJe81QbhWY147y2C+o7hjGkwiOuBHybHbfQbtRcVjM2mRIHX+KLIT2pIUxF
 zyaAormSJ9YGudFDb2sZV1floy+huBrexdxlloCTQiaa9ArlJvv2knH0Us2iyxSWO0j5
 +7Xg==
X-Gm-Message-State: AOJu0YzUKv80bQnk89PnyOPFnDRyp6ditbBVmrso1qYwnhOHB7gnEBZa
 Orgzhep+F2OMGknnlu/rb/bvOfIkXevSGgxvFHM=
X-Google-Smtp-Source: AGHT+IGGAX6z3G07PO5zgZM9KKODvOBEVjri7RFbhKcyOtI7D+bFdCw7j0HYnXH38iwsofs+MRtjdA==
X-Received: by 2002:a05:6a00:2e20:b0:686:be77:431c with SMTP id
 fc32-20020a056a002e2000b00686be77431cmr14303019pfb.13.1692129473034; 
 Tue, 15 Aug 2023 12:57:53 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 10/14] tcg/ppc: Use prefixed instructions in
 tcg_out_mem_long
Date: Tue, 15 Aug 2023 12:57:37 -0700
Message-Id: <20230815195741.8325-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index 40472f3d00..1aece2cbf7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -329,6 +329,15 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
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
@@ -732,6 +741,20 @@ static ptrdiff_t tcg_pcrel_diff_for_prefix(TCGContext *s, const void *target)
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
@@ -1413,6 +1436,49 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
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


