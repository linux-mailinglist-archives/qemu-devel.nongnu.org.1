Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 517407CEB2E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzS-000859-VL; Wed, 18 Oct 2023 18:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzR-00084l-Dt
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:09 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzP-0002TQ-Lk
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:09 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ca052ec63bso49635055ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667966; x=1698272766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnIEHz3YbyZLNAezqFGknAR6TwEjyjNQhE5DMYmjFw8=;
 b=vIBq9W7cZD5iC1NGLqLebyUUHmGu+Uy5wRZHtdWrvN1K40nlqM24vvUu8L9VE6bVzp
 seWU8afV95rnfMCBBqlcwTjK5KCQkYJJHRjTTx3l+VX6TsbmlQ1yKmwf0I22D4OJzY+8
 wLzQtyT357C0b+tdlFpi3sEG/X0cBORjhSYeiXxrdTDP1GmLtHUfaT6ziBADbXOCdTq4
 veEMq5MJqEz7VmFwsQW05sejJWGw6ETXii1vgk3m2XlCStlxcHnMkO+U5TOZWPLBJ0Ht
 IuSucmtYecKz31i8+c7R4Z9D0ipNkRkcm1QDvwerPXLeQIm8NEzwO2FaPmIfp9tROj7I
 k2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667966; x=1698272766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnIEHz3YbyZLNAezqFGknAR6TwEjyjNQhE5DMYmjFw8=;
 b=ZTjf391o6ci8/YC9Q8K812EuLyE/6k2fCZAmHHUNmFP84Gw5bOELTaSI2swzlRfn8a
 hm0fgZiOHvk8iwZAYpHWgH35jCIWBdsyjxshYrqmwyX2bM/UBJfJTde+P4r5k3Yi9xNk
 IhpPsCHuOU7gzTKyFXPQYgNhF7OG5z06R1B4+NN56Bm4rtFtLhRztO7VnYUxxTG+yG+R
 nCOcejqwIQu6IfZqZ/XO7Yjj7e1x94ylJJxWyG6TTzOx8vii//GbY66GXs8uCDQVmXhY
 MSShxMlwLu4yS0mQZF4bA//5WSYN3FYPcTiAwB5ifo7GQRz8hUcNtMoK49NKZWvDk4hd
 X5XA==
X-Gm-Message-State: AOJu0YxjiM5ZWwEXlFM9ol3DuGiEwuXN2HlfsrmwETOQinDmPhPhQHuu
 reEEMWjmyL79JatCUV45bKxV3QO6P7MIISuGP7U=
X-Google-Smtp-Source: AGHT+IGu9t4bp0/BUinNp+w4lt/Omv9ZzfZe6h8yzWg7c30oIWpsgWdo9c0R+CaRZsV3dtedJr+tOQ==
X-Received: by 2002:a17:903:41c8:b0:1ca:3fa6:4aef with SMTP id
 u8-20020a17090341c800b001ca3fa64aefmr778713ple.66.1697667966461; 
 Wed, 18 Oct 2023 15:26:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jordan Niethe <jniethe5@gmail.com>
Subject: [PULL 09/29] tcg/ppc: Use prefixed instructions in tcg_out_mem_long
Date: Wed, 18 Oct 2023 15:25:37 -0700
Message-Id: <20231018222557.1562065-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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


