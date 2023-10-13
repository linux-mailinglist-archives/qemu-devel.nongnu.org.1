Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7186F7C8F58
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPpS-0000Kt-QO; Fri, 13 Oct 2023 17:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPpK-0000AP-BJ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:36:10 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPpI-0002UM-4B
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:36:10 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b2b1a7874dso611436b6e.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232966; x=1697837766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EynWRtwso05K74KvHBXRuppWWgfI8dvgToEWloWvo88=;
 b=g8OrILsVXabw937Qw1mhYsvLAr7b8FRQj7XHtZiWsVzAp4NoEVq2Ix5OXLEk2yt7II
 gdEn4wX1jAsNZKt2beunw8xkhFV55bLmUC8kXsxN2YXd/a1zccumo+9IE3QBRUqe6AvW
 rRBE7UQ3YF16uMcHpfFlnB2/3NPoY8mb3RU9uY5qtM9hjizZGOf+j8UnzJYc1HGSD93X
 /p2lVXiSkKeP5B/IbGUOEaHo00HDlPfUTfjWNLCESg+bpt7TDTTuE9j6b1ZzMoLnbxBK
 AsPpcO4lgo3YVCuXMIRzo0wuKevWhHGoqOoHkXiDLEt929qEvqXT9KBzQkT2zqv9E2Or
 +F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232966; x=1697837766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EynWRtwso05K74KvHBXRuppWWgfI8dvgToEWloWvo88=;
 b=iyVe40mVC2de64sz6eaFr6M64EcmF3w/G0VoS3kJWwS+lChXZKpsR8XdZN332te1CB
 R650JzjIh+VzMVhaxR4zygKaT59Ez2YusmgrYSY+zciGL593Nw7yOOQxtVzuLoKSgMAa
 I5m5C52NJHc0r5/V4XtQQDUu8esJYlUQM5PMb/Evkw3mSmubkP+4ghXPttFUGSAVINGx
 mYYN5iD52PR6iksr+IZMwha2+/ia2semT5fHPNUfnvvdqAcWEw4NmxThQFVh0NvHqWEU
 fsQz4iigm0TUGYSRouRaU3G+VyQzzs0ejPkeOWADKL5IWeVKUqBL1gWY/SGm0T73bWmm
 33mw==
X-Gm-Message-State: AOJu0Yw+uypNZ+4jsKVJWG12xRSB8WFoAwJSMCt3P9yTtCdB41DTAuJ4
 Xlp48wkK9/jEk2CDZJs+gbFfeJemJPy0QA1loNc=
X-Google-Smtp-Source: AGHT+IGIfLPC28s7l/wCePB29a581a216e45/CMdBt3zrlMLdLAG4RUbHq85GhmTEby4lELzUkDDqg==
X-Received: by 2002:a05:6808:1495:b0:3ab:83fe:e18e with SMTP id
 e21-20020a056808149500b003ab83fee18emr35809193oiw.54.1697232965907; 
 Fri, 13 Oct 2023 14:36:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v127-20020a626185000000b0068790c41ca2sm1123984pfb.27.2023.10.13.14.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:36:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 85/85] target/sparc: Remove disas_sparc_legacy
Date: Fri, 13 Oct 2023 14:28:46 -0700
Message-Id: <20231013212846.165724-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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
index ffdd600353..b7f98c7e18 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5296,149 +5296,6 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
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
@@ -5506,7 +5363,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     dc->base.pc_next += 4;
 
     if (!decode(dc, insn)) {
-        disas_sparc_legacy(dc, insn);
+        gen_exception(dc, TT_ILL_INSN);
     }
 
     if (dc->base.is_jmp == DISAS_NORETURN) {
-- 
2.34.1


