Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB21F7D2187
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:16:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW6-0000XE-NS; Sun, 22 Oct 2023 02:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW2-0000VE-B1
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:46 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW0-0001XG-Fb
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:46 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso1659267b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954443; x=1698559243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3tYYl15SbYe+7PrLSwAYdfpLhjfdTC4pXipfF3UoTQ=;
 b=tayNMOARnLnhRw1rCxCN4xg7WlU9IZ7eH/n9nPM43E+iT7kPUv85WjR6G03DXESis/
 D2siW5FX5yCE57pDjbuif3WQlAD1Xd+KMtxILKCj1kwqGJgcPFs8qZewlXI9b19PHSB6
 buZKKW07OfSPIfv7N26GKByJHCFw31ZDRpc73I75Qx9qUnK+GeT+SvQOO16OFSfppOkq
 SzosmLpcaI5Pk0qxT+Rod1KlHOgI3MdIBhPKUwLPuZEuXSURChp7xdNwZtom3JJglXEi
 OKRnHQkPTsgwMZ/LiScViI7f7QVHmsRtDcLSRKSrzzzb1N7Wsx1DhP6qTyj6keY5JYbO
 q0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954443; x=1698559243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3tYYl15SbYe+7PrLSwAYdfpLhjfdTC4pXipfF3UoTQ=;
 b=CKdCPh8uz/EB4EaDrh4StBq0Uri1HN6xW3IVYT0BU/s3IZKG1RIkl2wiXso4TIj9s/
 C0lXuLJKzM1qo/5v3WboQpIWR9d6pJSQeGHGTgb8H/AyEh/V32hYl7C3X21xchoxCqqb
 5vyw418Q9YjrhCrbZMgvdWShxK38E6GeeI6YXLbQ4bMb7F3bHQejog/SazIT7Yo7zIKL
 fzy6pquRVjT/n5a8GJeGfRukUX0Z3cphFSv43NuScFfZWn5HqQuMuM8Kc9+xde5NG0bV
 NzWKc09A8C7VvHihys7Ii1lJtqNUGDod/FofkGw46A9rYME3SAt36TDI0Uwe1cETdbjD
 vnvQ==
X-Gm-Message-State: AOJu0YxEy576NlGm35FN18vRrVWNgnqF3JkMDajrV23varYu469wy988
 Bd9ciYwBnGkSjk/GE21F9sN8MqKOSebWxjf8S0k=
X-Google-Smtp-Source: AGHT+IGLhSd27yj3MjFeKV53/nYJ/4+16ZAU3701gk4QcH181ME5lH+Ru4JZMaaKXdkZYzHDTKmWcw==
X-Received: by 2002:a05:6a21:a5a1:b0:17d:53aa:d54d with SMTP id
 gd33-20020a056a21a5a100b0017d53aad54dmr2378448pzc.37.1697954443168; 
 Sat, 21 Oct 2023 23:00:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 12/90] target/sparc: Move BPcc and Bicc to decodetree
Date: Sat, 21 Oct 2023 22:59:13 -0700
Message-Id: <20231022060031.490251-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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


