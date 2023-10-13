Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEA97C8C20
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLgE-00014T-RT; Fri, 13 Oct 2023 13:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg9-00012v-8b
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:25 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg6-0005Z5-KP
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:25 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6c64c2c0f97so1450633a34.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217021; x=1697821821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcT+t2NWvvAgl7ag7U9fcr97JnnF4drB4JEVTRDmT40=;
 b=avUC1n5xIFxvVBI3cqnRTaM16sDJ1k/p0KQHvrm91rg1VZPKdJaVj4IlzAv7Ma4KT/
 z7WRO4QKXKpJHsv5pS2FncDhnmuTR+aXkYzHDfNzs1/mmei91cRjn6nqsk2m2bJm/gAM
 lO7HYyTIytfyZV9bwWSzcOBPsVtZktaLIQgKmta/ibDxQieDviMNAOxiLvlJQJh5MIh8
 9D/mvn/1bCeCjYcA6oLIDkn2PBRLcPIv0LWqYvoUjQtU1dTPvq9chWHsA4H1t53GTLFs
 PRIaqs0ihrTAvcn1XI0fBfBRk5VStRe9OzqQq1io6IDxFUHXt1BoF+g6MOB7Nx4dRlvE
 z4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217021; x=1697821821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcT+t2NWvvAgl7ag7U9fcr97JnnF4drB4JEVTRDmT40=;
 b=M4u8oAGLAtFAMUVlTV6LwBPEPRphmltNXggaza3Z+LcHiXfbhwVz63Q6YgL4oGT0nK
 9hdNGToZZpya0Rln97ccwjJr3VNp4VSyfxOR9Hi/tA2syex3E87gT6rbHXwN8X86zXOF
 g6YElC6Hw+eZjJunES5efmxoX1swJyOFwvW1PVvH2nPmPotkqbI2fWksfjAMmQ6QrdHS
 +pixMLx7fN7qgRyMxlfghyk+uN0vpWw2fJK7ywempcirCvFsEJJE/rVuYcSjSLeRuLRE
 /v0RrqZsLKDhiWyClnA9Kgq+ZcjnHM3E3aLMtlUsGHIprcGYN3riFhfEF13Dnf+/VClM
 wNkg==
X-Gm-Message-State: AOJu0Ywt7FiXpe7cX1aVmlNf60HkLyNAOMVe5LZntWKxKmzNK6MdRQQb
 RjkS5sGXGQi7+Mc9RuZFUnAziEFeGcQyBBuJP4k=
X-Google-Smtp-Source: AGHT+IEzQFYZlFewqQ2vjndcNQpmGUadwiB4lczpA0qhJxii7UWYGk/w1o6Pk4GBv0UvqiGHh5TuAA==
X-Received: by 2002:a05:6830:1d81:b0:6bd:db8:db with SMTP id
 y1-20020a0568301d8100b006bd0db800dbmr27658077oti.32.1697217021555; 
 Fri, 13 Oct 2023 10:10:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 08/13] tcg/ppc: Use PADDI in tcg_out_movi
Date: Fri, 13 Oct 2023 10:10:07 -0700
Message-Id: <20231013171012.122980-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

PADDI can load 34-bit immediates and 34-bit pc-relative addresses.

Reviewed-by: Jordan Niethe <jniethe5@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 6337b1e8be..f4235383c6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -719,6 +719,38 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
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
+static ptrdiff_t tcg_pcrel_diff_for_prefix(TCGContext *s, const void *target)
+{
+    return tcg_pcrel_diff(s, target) - (tcg_out_need_prefix_align(s) ? 4 : 0);
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
 
@@ -1017,6 +1049,25 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
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
+        tmp = tcg_pcrel_diff_for_prefix(s, (void *)arg);
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


