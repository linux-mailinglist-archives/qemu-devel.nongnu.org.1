Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7677D7968
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6o-0002GH-M1; Wed, 25 Oct 2023 20:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6L-0001RS-1w
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6E-0006tB-OO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ca6809fb8aso2284235ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279584; x=1698884384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTjsxTEB+wSbTivrTvElIlgrS7SAqTr5YpOJzPS1BFA=;
 b=L99mEGsb5GzXKVrRAE2AfNlXRqxcnzt5Ttbhu/rsE/Fs6cy4ezqCuqDXxFNj/5MTDR
 17OuAPp7budrCOOXDaUdQnddhsubGBPV6BtMjEzQ9PGXCjhgWEatnD2HBvpGtESjazhS
 p0XRrwZJSOUf6blumGy/sjo8iI0fELngCiZgIhHsrYul31IbUxy0u9nc6pJd7+6NCDaz
 X5Subr+2/ZfB5yjLDt5ulGHpasponf90tU9xiXZMVDA5W9V3c9AMVXTkNcf8gCc5qvA/
 y+vJfBoT4GE0iPQ6vota56FqCk9W0EVbxdjkPMf6JJsnhwHD6C+HuJC8tvOS0r+KjyEN
 /p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279584; x=1698884384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTjsxTEB+wSbTivrTvElIlgrS7SAqTr5YpOJzPS1BFA=;
 b=bAmX935jPdlgbJ+YYQqVZDP+nuevrMzVHRKNTunZQXMmKXHcLSr/qSqE719LidOERB
 lpGXDygaD9EgKENT0C21EX9+eWJ2eaFD/cZEXZEeemklM/wR/bpWcQUez2UvharSoehU
 Cxa5KhoaRPEwKpdotVk4vkJon1H25exsjMpH++6xB87PNBtJ0ngaoiH7iTT35kxnLX21
 bA4clrScgxWshkjPt5bmfTpbf9r7G/QZ5ChJsmp7F6w6IIm3am84bbxPL6q7YR8h13sA
 uQcScyIMGVWAToO2Qv4YNEqESF1KwXydUOSzbRDy9/iSDlqMo+fAE38C9w5ruUFVqbeh
 eoGw==
X-Gm-Message-State: AOJu0Yw2/jd7exBOqDm7C+A021+O+iYLUffv/ilI/56nms4oMzh1gcjs
 iK4PsW6t+f521IoAy8JjcYHgXPwayss6yls8mG0=
X-Google-Smtp-Source: AGHT+IHsd8PWW6IH0oEU1YV30RaBwI3qsnOU77PPYwT2gSf+ZKj1KyD7hI9SLb4cFhi+9c6/301DWw==
X-Received: by 2002:a17:902:7407:b0:1ca:86db:1d31 with SMTP id
 g7-20020a170902740700b001ca86db1d31mr14926194pll.7.1698279584487; 
 Wed, 25 Oct 2023 17:19:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 44/94] target/sparc: Convert remaining v8 coproc insns to
 decodetree
Date: Wed, 25 Oct 2023 17:14:52 -0700
Message-Id: <20231026001542.1141412-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
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
 target/sparc/insns.decode | 11 +++++++++++
 target/sparc/translate.c  | 32 ++++++--------------------------
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a596b0fc85..8de986f0bb 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -216,3 +216,14 @@ Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 MOVcc       10 rd:5  101100 1 cond:4 imm:1 cc:1 0 rs2_or_imm:s11
 MOVfcc      10 rd:5  101100 0 cond:4 imm:1 cc:2   rs2_or_imm:s11
 MOVR        10 rd:5  101111 rs1:5    imm:1 cond:3 rs2_or_imm:s10
+
+NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
+NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
+
+NCP         11 ----- 110000 ----- --------- -----          # v8 LDC
+NCP         11 ----- 110001 ----- --------- -----          # v8 LDCSR
+NCP         11 ----- 110011 ----- --------- -----          # v8 LDDC
+NCP         11 ----- 110100 ----- --------- -----          # v8 STC
+NCP         11 ----- 110101 ----- --------- -----          # v8 STCSR
+NCP         11 ----- 110110 ----- --------- -----          # v8 STDCQ
+NCP         11 ----- 110111 ----- --------- -----          # v8 STDC
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9122f82844..7cd1af1014 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4727,8 +4727,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 }
             } else if (xop < 0x36) {
                 goto illegal_insn; /* in decodetree */
-            } else if (xop == 0x36) { /* UltraSparc shutdown, VIS, V8 CPop1 */
+            } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
+                /* VIS */
                 int opf = GET_FIELD_SP(insn, 5, 13);
                 rs1 = GET_FIELD(insn, 13, 17);
                 rs2 = GET_FIELD(insn, 27, 31);
@@ -5168,14 +5169,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     goto illegal_insn;
                 }
 #else
-                goto ncp_insn;
-#endif
-            } else if (xop == 0x37) { /* V8 CPop2, V9 impdep2 */
-#ifdef TARGET_SPARC64
-                goto illegal_insn;
-#else
-                goto ncp_insn;
+                g_assert_not_reached(); /* in decodetree */
 #endif
+            } else if (xop == 0x37) {
+                /* V8 CPop2, V9 impdep2 */
+                goto illegal_insn; /* in decodetree */
 #ifdef TARGET_SPARC64
             } else if (xop == 0x39) { /* V9 return */
                 save_state(dc);
@@ -5391,13 +5389,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = gen_load_gpr(dc, rd);
                     gen_swap_asi(dc, cpu_val, cpu_src1, cpu_addr, insn);
                     break;
-
-#ifndef TARGET_SPARC64
-                case 0x30: /* ldc */
-                case 0x31: /* ldcsr */
-                case 0x33: /* lddc */
-                    goto ncp_insn;
-#endif
 #endif
 #ifdef TARGET_SPARC64
                 case 0x08: /* V9 ldsw */
@@ -5658,12 +5649,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src2 = gen_load_gpr(dc, rs2);
                     gen_casx_asi(dc, cpu_addr, cpu_src2, insn, rd);
                     break;
-#else
-                case 0x34: /* stc */
-                case 0x35: /* stcsr */
-                case 0x36: /* stdcq */
-                case 0x37: /* stdc */
-                    goto ncp_insn;
 #endif
 #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
                 case 0x3c: /* V9 or LEON3 casa */
@@ -5703,11 +5688,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
     gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
     return;
 #endif
-#ifndef TARGET_SPARC64
- ncp_insn:
-    gen_exception(dc, TT_NCP_INSN);
-    return;
-#endif
 }
 
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
-- 
2.34.1


