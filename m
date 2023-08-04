Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51A770B18
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 23:36:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2Qx-0006Bc-G3; Fri, 04 Aug 2023 17:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qu-00068H-AU
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:04 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qq-0001rY-0x
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bbc64f9a91so22144275ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691184838; x=1691789638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXhvB8XyLuww2xCl1ZkNwGIY8SDIYkhxbiAR1SsdBhg=;
 b=foEKWYdGQy9sG+uwY/RobA2UVQi5vCEGTjS7lv8c5zCmAOGEpzkpcOerd8p7RvE0js
 0LWKyvejVLX6l0UigevP5e/he372Ar3NQ8ZS47bmiFhb63qtJhrYTHvvEVA2LMkt0Yvc
 MHG0zlikqIP2Uw4g8dM6BTGq3FI+D9815cLLO6fuz7yqzhN0QAVIzhn82z5RAAiBlkfG
 JzFBrw8HrRPrc7ijuwmmv5isBuJo8HAJ4i9oNP+EuMYZ0EyP2coVvj8jQTk/sg/4T1c6
 nETnGjAbQ2D6AgJd+N20TgEYwgxzJWchgouyE8fxAfTXxZjzOWoP3trrJhKHQDh4j3tK
 dJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691184838; x=1691789638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QXhvB8XyLuww2xCl1ZkNwGIY8SDIYkhxbiAR1SsdBhg=;
 b=UH76S+MOn/MN2F8iVfA9DCjBrn6lQoGAWKmzYxVYdiy93pQKcAu60w5FSbAop++ULm
 RY36SsYcIyZtqSegqtq3vZvyGgBh+YdyBnQXvdNR9mQtk/5+lr4KcYhJLZ4AXFzxzOaf
 QFGppJZKSnQW/bWPZ1s4ueIaqLHwymAHJwsohQkEsOkOav1qVKnt2zGq4Rdl36Vv3oIz
 iyNy0l1CSS9mvWa/+Qs5ZPeEoHt0SM6e7ZlrGfbvLlZktWZxP/+EWhoWSHbYH7/w/kwO
 cbG5oqiE6GoaQuuMkpsYowP44gC5sbA9TweE4NVZP9ZhHYi9ywmGKkXKbVcoHT5VlB8F
 UuGw==
X-Gm-Message-State: AOJu0Yxse6+qz093AF9KsOi2QSLWeGYn9P5JpuWASupATNmAE3aWCvgJ
 8nFTPl4Z3uIU+O0I27Bl056Hlv/PjqE/rPy+gHs=
X-Google-Smtp-Source: AGHT+IHEZeMkXMclEsP7Ok4otOfYOwJgD+kGPRncQsLxqgf673mnnyRjQxsFkgKVKeqdSpMbMHSNNg==
X-Received: by 2002:a17:902:d2cb:b0:1b8:a65f:b49d with SMTP id
 n11-20020a170902d2cb00b001b8a65fb49dmr4092212plc.12.1691184838573; 
 Fri, 04 Aug 2023 14:33:58 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001ae0152d280sm2188662plg.193.2023.08.04.14.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 14:33:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com,
	qemu-ppc@nongnu.org,
	bgray@linux.ibm.com
Subject: [PATCH 2/7] tcg/ppc: Use PADDI in tcg_out_movi
Date: Fri,  4 Aug 2023 14:33:50 -0700
Message-Id: <20230804213355.294443-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804213355.294443-1-richard.henderson@linaro.org>
References: <20230804213355.294443-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

PADDI can load 34-bit immediates and 34-bit pc-relative addresses.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 642d0fd128..7fa2a2500b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -707,6 +707,33 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     return true;
 }
 
+/* Ensure that the prefixed instruction does not cross a 64-byte boundary. */
+static bool tcg_out_need_prefix_align(TCGContext *s)
+{
+    return ((uintptr_t)s->code_ptr & 0x3f) == 0x3c;
+}
+
+static void tcg_out_prefix_align(TCGContext *s)
+{
+    if (tcg_out_need_prefix_align(s)) {
+        tcg_out32(s, NOP);
+    }
+}
+
+/* Output Type 10 Prefix - Modified Load/Store Form (MLS:D) */
+static void tcg_out_mls_d(TCGContext *s, tcg_insn_unit opc, unsigned rt,
+                          unsigned ra, tcg_target_long imm, bool r)
+{
+    tcg_insn_unit p, i;
+
+    p = OPCD(1) | (2 << 24) | (r << 20) | ((imm >> 16) & 0x3ffff);
+    i = opc | TAI(rt, ra, imm);
+
+    tcg_out_prefix_align(s);
+    tcg_out32(s, p);
+    tcg_out32(s, i);
+}
+
 static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
                              TCGReg base, tcg_target_long offset);
 
@@ -992,6 +1019,26 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    /*
+     * Load values up to 34 bits, and pc-relative addresses,
+     * with one prefixed insn.
+     */
+    if (have_isa_3_10) {
+        if (arg == sextract64(arg, 0, 34)) {
+            /* pli ret,value = paddi ret,0,value,0 */
+            tcg_out_mls_d(s, ADDI, ret, 0, arg, 0);
+            return;
+        }
+
+        tmp = tcg_out_need_prefix_align(s) * 4;
+        tmp = tcg_pcrel_diff(s, (void *)arg) - tmp;
+        if (tmp == sextract64(tmp, 0, 34)) {
+            /* pla ret,value = paddi ret,0,value,1 */
+            tcg_out_mls_d(s, ADDI, ret, 0, tmp, 1);
+            return;
+        }
+    }
+
     /* Load 32-bit immediates with two insns.  Note that we've already
        eliminated bare ADDIS, so we know both insns are required.  */
     if (TCG_TARGET_REG_BITS == 32 || arg == (int32_t)arg) {
-- 
2.34.1


