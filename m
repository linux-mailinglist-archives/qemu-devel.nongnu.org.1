Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA07D2756
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:43:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhws-0005xj-FJ; Sun, 22 Oct 2023 19:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwj-0004tP-Th
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwh-0007a7-V8
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:25 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6bd32d1a040so2741595b3a.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017602; x=1698622402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qx3u54d+nn4AJiYHxsZxrV/lZkovZWfUNN7/yAhb/AU=;
 b=WEzJ64ysvPf9zvXwHfZ0/OrONEP7PVgsnV/uugzeqHPDJH2hVmAmfAJDSZAXPRSKu7
 bDDBDyWfvbjJpUqfoT4NyFyKR6ZP4e4Mkm7SMUHVzDNAT9TD4Mx3/quz8yK+EqeELNU3
 mRufdeRMBTFDqn8rFbrjWi3ftVOhBdHtl3Anc4ORGGgCy4FrHCz6mc/WYjtRcvWUjrHr
 fftD7igxZ+3BpSJiP+pkOCzzntQUUUEJkq2MzV59buTYMOzG9TQmTbZ14a4VsnA/K6OA
 oWkP3kDaahgqZp3Wj4xKPEcDpbYdV83aSnhhyUE/3MkoPU/LfkRQq+lZj6niyyBn+NDs
 ROKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017602; x=1698622402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qx3u54d+nn4AJiYHxsZxrV/lZkovZWfUNN7/yAhb/AU=;
 b=Ld8HJ7n3NKmWiEbubrHet3UB3ZmZnyiz16tkZIQ16eg/7i1mksWpmLd9dy3wb56YSH
 PoDwIqWBxT1b6aDiIYMHp+5yKcsd7+2HFxkZvbBKKQ8UOX4V1R9SbpsnVpALAVg+z4vX
 XqJe7DLRgTmzhB2CqLKO3OoFNQNb9DlhGHJObgbzU7MRM4+HGXTfbg3+9cZxONe/MItT
 evns09YkD/VtEbAioKgWv+zyz6Iiykj/GfeYJD8RU+nAATTcUTQBAij2K7ojoaUGu4KX
 Fse6hivCSnX/BlZq2QvsIqB0Bw51T9rC4xkIyjfBOwNtIQ67tZ9SzhIm+EcDubF1N332
 VndQ==
X-Gm-Message-State: AOJu0YyABQAHpQIiMSoijYGrH1Bzqm36OBi4v/6RCWtEfuLwCf8rBGgQ
 JwSe4fcPS8CFpPj7xRrFrRBHh+wJJ2dAqgGi2QI=
X-Google-Smtp-Source: AGHT+IG5+zxhr2UItGt1E3qHt68sF6zNd9mFgfA6Cb2xQakgjMMx3MsWzlCmoNFi+HNEJNENmZOmvA==
X-Received: by 2002:a05:6a21:4986:b0:161:76a4:4f74 with SMTP id
 ax6-20020a056a21498600b0016176a44f74mr9337914pzc.1.1698017602535; 
 Sun, 22 Oct 2023 16:33:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 57/94] target/sparc: Move PREFETCH, PREFETCHA to decodetree
Date: Sun, 22 Oct 2023 16:28:55 -0700
Message-Id: <20231022232932.80507-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  8 ++++++--
 target/sparc/translate.c  | 23 ++++++++---------------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 82c484fbc7..aa452f1d00 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -231,6 +231,9 @@ RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
+NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
+NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
+
 ##
 ## Major Opcode 11 -- load and store instructions
 ##
@@ -299,8 +302,9 @@ CASA        11 ..... 111100 ..... . .............          @casa_imm
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
index 6f2636303d..a65bf9ebd6 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4031,17 +4031,12 @@ static bool trans_NOP(DisasContext *dc, arg_NOP *a)
     return advance_pc(dc);
 }
 
-static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
-{
-    /*
-     * TODO: Need a feature bit for sparcv8.
-     * In the meantime, treat all 32-bit cpus like sparcv7.
-     */
-    if (avail_32(dc)) {
-        return advance_pc(dc);
-    }
-    return false;
-}
+/*
+ * TODO: Need a feature bit for sparcv8.
+ * In the meantime, treat all 32-bit cpus like sparcv7.
+ */
+TRANS(NOP_v7, 32, trans_NOP, a)
+TRANS(NOP_v9, 64, trans_NOP, a)
 
 static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
                          void (*func)(TCGv, TCGv, TCGv),
@@ -5454,10 +5449,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5472,8 +5467,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


