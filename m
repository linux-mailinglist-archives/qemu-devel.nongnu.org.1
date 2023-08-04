Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD73770B17
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 23:35:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2Qx-0006Ca-Qq; Fri, 04 Aug 2023 17:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qw-000690-7D
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qs-0001tL-6T
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b8ad8383faso22437905ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691184839; x=1691789639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9+EpIdtYkIJvK6T0vT+EMuiDbj1ltMIRQcPyROrXSQ=;
 b=KwIZiEVcDhev+eWBVVpPuLKPID1xjkkteDl9TPi5id34tgPWpXOo54y5VVqoc+ZJR7
 XOE1qWOC+dWRO8DmaBWKJcPWjO43WvRzjfrwB/8QqBmaNlbY18GffHjrnoeKFqs54Ol1
 jZS0xowzIYkpXSGH6tnLWU//zrwFzsjPeepx4aaKHUjMd4vfqmKZb+6JxqJcoD6UNL5e
 I6Le5cRV2VWr0ijyISesaXCtKAcMDlxVkzIpr7JWANZBhhWrygyUA3+bKUhu7p6EKze1
 Oh++s5mJ9E59eCZp+lQqJuNh0QVtBAlpufVWcGA7KG8FfGxLyk5HlrIEJNjcFDCyYDQk
 J5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691184839; x=1691789639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y9+EpIdtYkIJvK6T0vT+EMuiDbj1ltMIRQcPyROrXSQ=;
 b=JgIKzON19qr6uz2EV9qA2rEXJgO59V1Sip1ZcLUudC5YoV+R+yITCibN/OVBMr7oRc
 0rqK2E9i+6/LJlPNQRnS+/cm3ZdbdSM+xskuB/nHxGKf4+H82lzutOrAx8xmuIMrgSyN
 fjBAWRL/+/Vu+wWZEnDtcNK860Lc919AVenYb82Va01i/vy5qlbqqt1JjKaTnRPg1Q/h
 xok6F0WGXYJx3YKFZfUq+IoIfejvAmMYn+tLjW9GS7QeqOyTdpEUf8vlmM+Ot+01tVBJ
 VZeSgGs7vhJszLdL39g8npwS/ViG3v60R+HZWBIZ0/h5IfGU/eMlVdR9qJEMbr4qSoye
 /oiw==
X-Gm-Message-State: AOJu0YwCSC+vI5uP3sKktiARUkF8LQpGCrRxoFeoF1oPWnke45/qyzMH
 YNgmsCpjFDY9bRFnO5/FqPj9XTM48Nx/UXr9cOQ=
X-Google-Smtp-Source: AGHT+IG83ipNP+6aiRDO9JMTxDxNcGHYeQTaOGIvBOXDuoEA/fd470IHeBW2uisJ3PDJBjLGPKgWLQ==
X-Received: by 2002:a17:903:2351:b0:1bb:c69b:6f6b with SMTP id
 c17-20020a170903235100b001bbc69b6f6bmr3799389plh.6.1691184839459; 
 Fri, 04 Aug 2023 14:33:59 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001ae0152d280sm2188662plg.193.2023.08.04.14.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 14:33:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com,
	qemu-ppc@nongnu.org,
	bgray@linux.ibm.com
Subject: [PATCH 3/7] tcg/ppc: Use prefixed instructions in tcg_out_mem_long
Date: Fri,  4 Aug 2023 14:33:51 -0700
Message-Id: <20230804213355.294443-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804213355.294443-1-richard.henderson@linaro.org>
References: <20230804213355.294443-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

When the offset is out of range of the non-prefixed insn, but
fits the 34-bit immediate of the prefixed insn, use that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 66 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 7fa2a2500b..d41c499b7d 100644
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
+#define PSTXV  OPCD(27 * 2 + 1)  /* force tx=1 */
+
 #define ADDIC  OPCD( 12)
 #define ADDI   OPCD( 14)
 #define ADDIS  OPCD( 15)
@@ -720,6 +729,20 @@ static void tcg_out_prefix_align(TCGContext *s)
     }
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
@@ -1364,6 +1387,49 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
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


