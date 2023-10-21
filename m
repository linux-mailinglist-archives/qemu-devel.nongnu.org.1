Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 195247D1B38
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:48:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4au-0007AB-N5; Sat, 21 Oct 2023 01:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4as-00079b-KP
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:14 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ap-0008Mq-RY
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:14 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5b856d73a12so1126528a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866330; x=1698471130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3tYYl15SbYe+7PrLSwAYdfpLhjfdTC4pXipfF3UoTQ=;
 b=t2n9J9rRtDwD73bljFOvXSnYs5XVjq8JE04adIFfA/hTEzcuRM2yl9r6dx/JhHIhcz
 E9533y1mrGnPbRaXNuWU1l5li9tBnhJmp5xh0MuQjzByZLrzCjwZ5JRSZChmxLUnz+c2
 WIFw9Yh2TqrUa1TGkmmabOmMhSuT24OT3l/MKUAzlgxeIanpVBNLvui/806ZhAOophzy
 9TbLBRLs1pwiqebr86inRwwiYBnf4LtiB5zpqCTCFczrYKK9nSaqqmuGNJ7/NfQyh+YD
 5CI1V08DMYSewTO35aWM3qGxEaGVTpcMTUqEx5Z2QYKd8KrI2dLsnaBtefs2hprM1jeb
 d6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866330; x=1698471130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3tYYl15SbYe+7PrLSwAYdfpLhjfdTC4pXipfF3UoTQ=;
 b=M/lcsvKjpTyWZu91uS0KfNiZmZ+u9qXmb3Zhsjj1Oob0OrOmhOry5eFcZBpfLjnzxP
 qKY6n7t4r8QazfxZyZ57DIZT9ro5Pur3RSnOzma5/XuCS3fCE4CIaj0/u836ydYXIKzA
 YVBuI+ebnefVmHWn6R+5IiKbTI+H0l53YMIjj36CPTIAo3P5XWrBBEt1hIjaRmv/uv8Z
 nWDIWOQoTXORAhzoZesFsT5F/nuQJYRkjuHdlp+6VNlmgy1zN5as6sJm+cjFFYp93kf5
 XnK6x3nNWhn0JbL9G6rysf2rKJW9jBlYCNYBnL14MZ8cIiywTsfDXK9qPhHGdJbZSMZh
 HYEw==
X-Gm-Message-State: AOJu0YyVsV6PpKDMK31ny23xDaNHL5M5CQOHG2sPoQ5rs6N/UeQjQ4zZ
 yp6iGhNDWijk5qCVcHBJCUYZxZ402jUTLseFisA=
X-Google-Smtp-Source: AGHT+IFtl2ke/xGhjXh+BAu7GtmIgdLoFkR+TLZWyLiFeZkReNEOXs/KUjILnJJ0er3aDsZR+KXFgA==
X-Received: by 2002:a05:6a21:998d:b0:17b:129b:1818 with SMTP id
 ve13-20020a056a21998d00b0017b129b1818mr4856121pzb.37.1697866329948; 
 Fri, 20 Oct 2023 22:32:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 12/90] target/sparc: Move BPcc and Bicc to decodetree
Date: Fri, 20 Oct 2023 22:30:40 -0700
Message-Id: <20231021053158.278135-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |   4 ++
 target/sparc/translate.c  | 117 +++++++++++++++++++-------------------
 2 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a5f5d2681e..15cd975f4e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -3,4 +3,8 @@
 # Sparc instruction decode definitions.
 # Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
 
+&bcc    i a cond cc
+BPcc    00 a:1 cond:4   001 cc:1 0 - i:s19                 &bcc
+Bicc    00 a:1 cond:4   010          i:s22                 &bcc cc=0
+
 CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7ef4c6d4f7..92ea6bab6b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1367,44 +1367,6 @@ static void gen_cond_reg(TCGv r_dst, int cond, TCGv r_src)
 }
 #endif
 
-static void do_branch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
-{
-    unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
-    target_ulong target = dc->pc + offset;
-
-    if (unlikely(AM_CHECK(dc))) {
-        target &= 0xffffffffULL;
-    }
-    if (cond == 0x0) {
-        /* unconditional not taken */
-        if (a) {
-            dc->pc = dc->npc + 4;
-            dc->npc = dc->pc + 4;
-        } else {
-            dc->pc = dc->npc;
-            dc->npc = dc->pc + 4;
-        }
-    } else if (cond == 0x8) {
-        /* unconditional taken */
-        if (a) {
-            dc->pc = target;
-            dc->npc = dc->pc + 4;
-        } else {
-            dc->pc = dc->npc;
-            dc->npc = target;
-            tcg_gen_mov_tl(cpu_pc, cpu_npc);
-        }
-    } else {
-        flush_cond(dc);
-        gen_cond(cpu_cond, cc, cond, dc);
-        if (a) {
-            gen_branch_a(dc, target);
-        } else {
-            gen_branch_n(dc, target);
-        }
-    }
-}
-
 static void do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
 {
     unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
@@ -3046,6 +3008,61 @@ static bool advance_pc(DisasContext *dc)
     return true;
 }
 
+static bool advance_jump_uncond_never(DisasContext *dc, bool annul)
+{
+    if (annul) {
+        dc->pc = dc->npc + 4;
+        dc->npc = dc->pc + 4;
+    } else {
+        dc->pc = dc->npc;
+        dc->npc = dc->pc + 4;
+    }
+    return true;
+}
+
+static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
+                                       target_ulong dest)
+{
+    if (annul) {
+        dc->pc = dest;
+        dc->npc = dest + 4;
+    } else {
+        dc->pc = dc->npc;
+        dc->npc = dest;
+        tcg_gen_mov_tl(cpu_pc, cpu_npc);
+    }
+    return true;
+}
+
+static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
+{
+    if (annul) {
+        gen_branch_a(dc, dest);
+    } else {
+        gen_branch_n(dc, dest);
+    }
+    return true;
+}
+
+static bool do_bpcc(DisasContext *dc, arg_bcc *a)
+{
+    target_long target = address_mask_i(dc, dc->pc + a->i * 4);
+
+    switch (a->cond) {
+    case 0x0:
+        return advance_jump_uncond_never(dc, a->a);
+    case 0x8:
+        return advance_jump_uncond_always(dc, a->a, target);
+    default:
+        flush_cond(dc);
+        gen_cond(cpu_cond, a->cc, a->cond, dc);
+        return advance_jump_cond(dc, a->a, target);
+    }
+}
+
+TRANS(Bicc, ALL, do_bpcc, a)
+TRANS(BPcc,  64, do_bpcc, a)
+
 static bool trans_CALL(DisasContext *dc, arg_CALL *a)
 {
     target_long target = address_mask_i(dc, dc->pc + a->i * 4);
@@ -3083,21 +3100,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             switch (xop) {
 #ifdef TARGET_SPARC64
             case 0x1:           /* V9 BPcc */
-                {
-                    int cc;
-
-                    target = GET_FIELD_SP(insn, 0, 18);
-                    target = sign_extend(target, 19);
-                    target <<= 2;
-                    cc = GET_FIELD_SP(insn, 20, 21);
-                    if (cc == 0)
-                        do_branch(dc, target, insn, 0);
-                    else if (cc == 2)
-                        do_branch(dc, target, insn, 1);
-                    else
-                        goto illegal_insn;
-                    goto jmp_insn;
-                }
+                g_assert_not_reached(); /* in decodetree */
             case 0x3:           /* V9 BPr */
                 {
                     target = GET_FIELD_SP(insn, 0, 13) |
@@ -3127,13 +3130,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 }
 #endif
             case 0x2:           /* BN+x */
-                {
-                    target = GET_FIELD(insn, 10, 31);
-                    target = sign_extend(target, 22);
-                    target <<= 2;
-                    do_branch(dc, target, insn, 0);
-                    goto jmp_insn;
-                }
+                g_assert_not_reached(); /* in decodetree */
             case 0x6:           /* FBN+x */
                 {
                     if (gen_trap_ifnofpu(dc)) {
-- 
2.34.1


