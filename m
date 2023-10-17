Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1A97CBB31
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:29:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNr-0003U0-Jm; Tue, 17 Oct 2023 02:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNY-0002sI-Sh
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:33 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNX-0004iB-6g
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:32 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so2952826b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523390; x=1698128190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rm7z9mYq9FPEIcvf5xAJUJvg0gWyaJ4v7z2/vituMlg=;
 b=e8oAQXz9otL0F+IbDLLcnUgePgVLmFlJewaqGSjp8I+FVIeylPGweB5Weu7FCJsJ3p
 4/S2yrJT3tX7+8WbFgnd6Y3HDC9h/TJmg9X1PlsMccdoeh6DOQw1PBE2M1UWChiqY9d+
 eNoufJFGp3JV8olF8wZQI2jrYCIMgcKPF6z1F9ORt+srv++X5MMV82ebEFJOoACpqH5l
 x/4cvvyq5UyPD13B7hhfNgCaWMv2uBCTkoWjzlpi7zY8VS8YrQfAh8Ipzs/HDBHrXt9B
 ub4LsjpDCJiR7h7HJ3A7Lkru0Bthyk8tXvCni/AuTiwwJ/MYUWAMQ/iSF2/vrKWWLxBx
 8CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523390; x=1698128190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rm7z9mYq9FPEIcvf5xAJUJvg0gWyaJ4v7z2/vituMlg=;
 b=urxz70x1lORrCx736Cv7kDfE74PP3/m7kXom1H+1r2kAI7UR7l86LUJwON70YgWjMu
 qr2lc3yODIeJecYYDsicpAhybW7rOQ97nA1EkWFr00mcl/dYnFgv1nBc9DTCFv/WJTUo
 /0+PSdekKa0iglS187AoLZ8KMye4N9Irn6+t2I88q3oKQgVbhbbPKJIIneGXsmly3og6
 1vYhcZxUiL7PUYgwsFj+Q43I1Z/C0urQd5AbBtR8VXfuKxTPAsKAOA0+FXzpu/D8jSxn
 MvCSsiYEyGEj3BrNTgKKpwz27XLMakbDfTgmUGp0r89bF+XttpLCV74Z7JAzgvWBKwdH
 DRnQ==
X-Gm-Message-State: AOJu0Yzn9KNvKWnf8U5dC+nQBSfwqxXC595OMbcr84ErQexmUJKDIIs1
 ox2hTT98nO5u6InIqL9CNBIy0bapkJ+N3po9ruw=
X-Google-Smtp-Source: AGHT+IF00orQ4LXy5InFEmrVk2v5FbZ3v0x3xSxL4eGQvzD6EpNoojE2WgqhVLdQcMs13Ll19d77tA==
X-Received: by 2002:a05:6a00:1ad2:b0:6b8:f7ed:4deb with SMTP id
 f18-20020a056a001ad200b006b8f7ed4debmr1367119pfv.13.1697523389757; 
 Mon, 16 Oct 2023 23:16:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 53/90] target/sparc: Move PREFETCH, PREFETCHA to decodetree
Date: Mon, 16 Oct 2023 23:12:07 -0700
Message-Id: <20231017061244.681584-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/sparc/insns.decode |  8 ++++++--
 target/sparc/translate.c  | 14 ++++++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 8e6a24e094..86108679eb 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -224,6 +224,9 @@ RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
+NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
+NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
+
 ##
 ## Major Opcode 11 -- load and store instructions
 ##
@@ -292,8 +295,9 @@ CASA        11 ..... 111100 ..... . .............          @casa_imm
 CASXA       11 ..... 111110 ..... . .............          @r_r_r_asi
 CASXA       11 ..... 111110 ..... . .............          @casa_imm
 
-NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
-NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
+NOP_v9      11 ----- 101101 ----- 0 00000000 -----         # PREFETCH
+NOP_v9      11 ----- 101101 ----- 1 -------------          # PREFETCH
+NOP_v9      11 ----- 111101 ----- - -------------          # PREFETCHA
 
 NCP         11 ----- 110000 ----- --------- -----          # v8 LDC
 NCP         11 ----- 110001 ----- --------- -----          # v8 LDCSR
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6b860dbd75..1b402de49f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4101,6 +4101,14 @@ static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
     return false;
 }
 
+static bool trans_NOP_v9(DisasContext *dc, arg_NOP_v9 *a)
+{
+    if (avail_64(dc)) {
+        return advance_pc(dc);
+    }
+    return false;
+}
+
 static bool do_cc_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
                         void (*func)(TCGv, TCGv, TCGv),
                         void (*funci)(TCGv, TCGv, target_long))
@@ -5534,10 +5542,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x0b:      /* V9 ldx */
                 case 0x18:      /* V9 ldswa */
                 case 0x1b:      /* V9 ldxa */
+                case 0x2d:      /* V9 prefetch */
+                case 0x3d:      /* V9 prefetcha */
                     goto illegal_insn;  /* in decodetree */
 #ifdef TARGET_SPARC64
-                case 0x2d: /* V9 prefetch, no effect */
-                    goto skip_move;
                 case 0x30: /* V9 ldfa */
                     if (gen_trap_ifnofpu(dc)) {
                         goto jmp_insn;
@@ -5552,8 +5560,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_ldf_asi(dc, cpu_addr, insn, 8, DFPREG(rd));
                     gen_update_fprs_dirty(dc, DFPREG(rd));
                     goto skip_move;
-                case 0x3d: /* V9 prefetcha, no effect */
-                    goto skip_move;
                 case 0x32: /* V9 ldqfa */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     if (gen_trap_ifnofpu(dc)) {
-- 
2.34.1


