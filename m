Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E1E7CBB29
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdRo-0005et-Ho; Tue, 17 Oct 2023 02:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdR3-0003lA-A9
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:13 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdQw-0005Du-Vh
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:06 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-27d3c886671so3250905a91.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523601; x=1698128401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oj4L1wn5xycsKiEhLIXeWeTUxVzLt/BGJR7AYYVjFwY=;
 b=EL2AHF+o+9nC7+PiPUkSud/mAzjNuTLgoT1ncSaco4pegslPYboFL9//bFWKtPIo1S
 4ZVRhCJMoqpfdK56aggXkGs6j1s+08L5wUdVXaADNyNu2Ia5TyBiT5ZMY0fRLjOzmhvn
 idEu+NgBFcXlyELSkgTUPRWfBQHuptGAxTx6cXMpX1tp/J31VWCufKrnmuTYrQqmFQbz
 AHbbV7RSLjayJkvhjzT8aQwTirMFERNrx7a/tkT0hCVvQ6TuoqKAXZslXzy8u1PUscSY
 XnrS5AyNmy1hPszJ9IAThexhG5nH6K0/5s01/s7iTEEnrOuMTa9rbicJclVg2C6IMxFp
 Sp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523601; x=1698128401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oj4L1wn5xycsKiEhLIXeWeTUxVzLt/BGJR7AYYVjFwY=;
 b=R/88yhOrDrSsOX+NND130gGAnxfZIkZcFY3djSEBwjrO/vcLLl/eDfrPsT5iFomUQS
 Q79cMK7q0li7e3kTq2wcapv+Bu1IErD6R6oMeKIT68Ts3g+AEJPS/nV5qxVrGobFDZxR
 ab2g+dXruPwMBHREAqxM8GmWMwLRUJpQLLmY60JWmP0XmgNXAQ5MOzxAt2YjyXo8fFxC
 OFRL74eJMirAY2hKUmvkCgEJ536RmlSi6WCjaMVXT+EgcVUPQJ+h2U4TEerjkd58R2Mm
 yM2piXL5v4+QAbS9hJx/W3RdehDO0On+KO8n4PJAhXJZEIvvQjVM/In+W79qRkpKwOH0
 5PFw==
X-Gm-Message-State: AOJu0YwxqAN5Vi6L8GEbpzr4bm5Lhu6cOLNxemQ/OFUsNtCd+5cZjfxh
 rxvFLy2NJLK36gRnRTlR4BZp6/5A9LG38vHimyI=
X-Google-Smtp-Source: AGHT+IHX2A21ifVQD6Uj5IGTUeJkfV2Ol7+ioqe37DnRkUeONjzsQb+yMbLTcEi0XtChC0CCKJwTRQ==
X-Received: by 2002:a17:90a:6089:b0:27d:7eeb:d4d0 with SMTP id
 z9-20020a17090a608900b0027d7eebd4d0mr1320211pji.12.1697523601377; 
 Mon, 16 Oct 2023 23:20:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 by2-20020a056a02058200b00588e8421fa8sm550331pgb.84.2023.10.16.23.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:20:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 90/90] target/sparc: Remove disas_sparc_legacy
Date: Mon, 16 Oct 2023 23:12:44 -0700
Message-Id: <20231017061244.681584-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

All instructions are now converted.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 145 +--------------------------------------
 1 file changed, 1 insertion(+), 144 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ba41cfda3d..c458de2103 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5403,149 +5403,6 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
 TRANS(FCMPq, ALL, do_fcmpq, a, false)
 TRANS(FCMPEq, ALL, do_fcmpq, a, true)
 
-#define CHECK_IU_FEATURE(dc, FEATURE)                      \
-    if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
-        goto illegal_insn;
-#define CHECK_FPU_FEATURE(dc, FEATURE)                     \
-    if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
-        goto nfpu_insn;
-
-/* before an instruction, dc->pc must be static */
-static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
-{
-    unsigned int opc = GET_FIELD(insn, 0, 1);
-
-    switch (opc) {
-    case 0:
-        goto illegal_insn; /* in decodetree */
-    case 1:
-        g_assert_not_reached(); /* in decodetree */
-    case 2:                     /* FPU & Logical Operations */
-        {
-            unsigned int xop = GET_FIELD(insn, 7, 12);
-
-            if (xop == 0x34) {   /* FPU Operations */
-                goto illegal_insn; /* in decodetree */
-            } else if (xop == 0x35) {   /* FPU Operations */
-                goto illegal_insn; /* in decodetree */
-            } else if (xop == 0x36) {
-#ifdef TARGET_SPARC64
-                /* VIS */
-                int opf = GET_FIELD_SP(insn, 5, 13);
-
-                if (gen_trap_ifnofpu(dc)) {
-                    goto jmp_insn;
-                }
-
-                switch (opf) {
-                case 0x000: /* VIS I edge8cc */
-                case 0x001: /* VIS II edge8n */
-                case 0x002: /* VIS I edge8lcc */
-                case 0x003: /* VIS II edge8ln */
-                case 0x004: /* VIS I edge16cc */
-                case 0x005: /* VIS II edge16n */
-                case 0x006: /* VIS I edge16lcc */
-                case 0x007: /* VIS II edge16ln */
-                case 0x008: /* VIS I edge32cc */
-                case 0x009: /* VIS II edge32n */
-                case 0x00a: /* VIS I edge32lcc */
-                case 0x00b: /* VIS II edge32ln */
-                case 0x010: /* VIS I array8 */
-                case 0x012: /* VIS I array16 */
-                case 0x014: /* VIS I array32 */
-                case 0x018: /* VIS I alignaddr */
-                case 0x01a: /* VIS I alignaddrl */
-                case 0x019: /* VIS II bmask */
-                case 0x067: /* VIS I fnot2s */
-                case 0x06b: /* VIS I fnot1s */
-                case 0x075: /* VIS I fsrc1s */
-                case 0x079: /* VIS I fsrc2s */
-                case 0x066: /* VIS I fnot2 */
-                case 0x06a: /* VIS I fnot1 */
-                case 0x074: /* VIS I fsrc1 */
-                case 0x078: /* VIS I fsrc2 */
-                case 0x051: /* VIS I fpadd16s */
-                case 0x053: /* VIS I fpadd32s */
-                case 0x055: /* VIS I fpsub16s */
-                case 0x057: /* VIS I fpsub32s */
-                case 0x063: /* VIS I fnors */
-                case 0x065: /* VIS I fandnot2s */
-                case 0x069: /* VIS I fandnot1s */
-                case 0x06d: /* VIS I fxors */
-                case 0x06f: /* VIS I fnands */
-                case 0x071: /* VIS I fands */
-                case 0x073: /* VIS I fxnors */
-                case 0x077: /* VIS I fornot2s */
-                case 0x07b: /* VIS I fornot1s */
-                case 0x07d: /* VIS I fors */
-                case 0x050: /* VIS I fpadd16 */
-                case 0x052: /* VIS I fpadd32 */
-                case 0x054: /* VIS I fpsub16 */
-                case 0x056: /* VIS I fpsub32 */
-                case 0x062: /* VIS I fnor */
-                case 0x064: /* VIS I fandnot2 */
-                case 0x068: /* VIS I fandnot1 */
-                case 0x06c: /* VIS I fxor */
-                case 0x06e: /* VIS I fnand */
-                case 0x070: /* VIS I fand */
-                case 0x072: /* VIS I fxnor */
-                case 0x076: /* VIS I fornot2 */
-                case 0x07a: /* VIS I fornot1 */
-                case 0x07c: /* VIS I for */
-                case 0x031: /* VIS I fmul8x16 */
-                case 0x033: /* VIS I fmul8x16au */
-                case 0x035: /* VIS I fmul8x16al */
-                case 0x036: /* VIS I fmul8sux16 */
-                case 0x037: /* VIS I fmul8ulx16 */
-                case 0x038: /* VIS I fmuld8sux16 */
-                case 0x039: /* VIS I fmuld8ulx16 */
-                case 0x04b: /* VIS I fpmerge */
-                case 0x04d: /* VIS I fexpand */
-                case 0x03e: /* VIS I pdist */
-                case 0x03a: /* VIS I fpack32 */
-                case 0x048: /* VIS I faligndata */
-                case 0x04c: /* VIS II bshuffle */
-                case 0x020: /* VIS I fcmple16 */
-                case 0x022: /* VIS I fcmpne16 */
-                case 0x024: /* VIS I fcmple32 */
-                case 0x026: /* VIS I fcmpne32 */
-                case 0x028: /* VIS I fcmpgt16 */
-                case 0x02a: /* VIS I fcmpeq16 */
-                case 0x02c: /* VIS I fcmpgt32 */
-                case 0x02e: /* VIS I fcmpeq32 */
-                case 0x03b: /* VIS I fpack16 */
-                case 0x03d: /* VIS I fpackfix */
-                case 0x060: /* VIS I fzero */
-                case 0x061: /* VIS I fzeros */
-                case 0x07e: /* VIS I fone */
-                case 0x07f: /* VIS I fones */
-                    g_assert_not_reached();  /* in decodetree */
-                case 0x080: /* VIS I shutdown */
-                case 0x081: /* VIS II siam */
-                    // XXX
-                    goto illegal_insn;
-                default:
-                    goto illegal_insn;
-                }
-#endif
-            } else {
-                goto illegal_insn; /* in decodetree */
-            }
-        }
-        break;
-    case 3:                     /* load/store instructions */
-        goto illegal_insn; /* in decodetree */
-    }
-    advance_pc(dc);
-#ifdef TARGET_SPARC64
- jmp_insn:
-#endif
-    return;
- illegal_insn:
-    gen_exception(dc, TT_ILL_INSN);
-    return;
-}
-
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
@@ -5613,7 +5470,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     dc->base.pc_next += 4;
 
     if (!decode(dc, insn)) {
-        disas_sparc_legacy(dc, insn);
+        gen_exception(dc, TT_ILL_INSN);
     }
 
     if (dc->base.is_jmp == DISAS_NORETURN) {
-- 
2.34.1


