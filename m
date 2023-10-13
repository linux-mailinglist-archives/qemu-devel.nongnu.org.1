Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFF57C8F13
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:30:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPin-0006Od-UG; Fri, 13 Oct 2023 17:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPim-0006Na-6Y
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:24 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPik-0000XT-I7
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:23 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1e1b1b96746so1453684fac.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232561; x=1697837361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsodXfLEaZhD/yMTWsJj3qmTL84PAW7ln87Nf8q7RYo=;
 b=P+hE1WjfSB495mwWpH4OQ66yIo9n0KvebO6LHrvqs0mFVBKXrF9JMxY8v6LIaGSCkm
 rzYmw72yVjuezT+PAYHVQOJvQynch2JmV7oOKXK7qXBtd+WaTun/Rhniqbrt8POWrFEw
 PwaU/lF4oCikxGAIpseVDjazacLJ6IEBWiZ+TqpzEUIMEGUpw0+73Y5ojRjdzh8rAHbk
 sklHRwDdKLUBBOKwfhl0GO0Pr+0xyqq7KwpPIWAqFIjZoIS5toSIL3OAmG09qVQueLsv
 s1u4ZbGwW5t9hSy/xqpCK7DtJ9HDxAC4M96fNmgFJl0VMLWfhAIphvFCrNWPOHbyRmyV
 HpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232561; x=1697837361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsodXfLEaZhD/yMTWsJj3qmTL84PAW7ln87Nf8q7RYo=;
 b=vPvEd/hVMp9LBbENhCzkhLd9KTUSPOCkQMZeTCYY7o4ZHPvGcalzZD5ESuNfjA5tHS
 2vAMXDnvdLhG1cM2OHlC2vNeB1Dv3kmXuOcR3go9n9x8HNKNylMTnqS3AT1QlmmnwEfu
 oEt36jiL6Zttn1WPYTkEZmxAMRQNAcJraU/AEJXA+kj2whXCvOHYJZ6IIk0Nt8DuNAtW
 IHFMMqvpvvWT2Hty9ypXKWjpRjVoCMSA5Wk9gmwW0dtyynKXqCuEJo/q5RbynqpN1+29
 DxvbDEZDWUffE5nN25bnO4zd8Z3twTvcuWd5+MN6gWlf3n6LDEj4r9R1UpRSugE9aHkg
 iTXw==
X-Gm-Message-State: AOJu0YxAhi/MKpnAw/JJNBj4NWFLOjDB9IEckNvgb+dIcR4Pv5blJU+u
 dTn7cPF1uSX+mvgsD1tdAQSz8o7edfntjlFMxHs=
X-Google-Smtp-Source: AGHT+IFE+7VIoYIGxs4spbxFBv56zaL4+ikVfARtgi548BHZJyZE5FHuY0Hgj1+/APBpQUn4aIperg==
X-Received: by 2002:a05:6870:348e:b0:1d5:a58d:1317 with SMTP id
 n14-20020a056870348e00b001d5a58d1317mr32221210oah.10.1697232561209; 
 Fri, 13 Oct 2023 14:29:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 35/85] target/sparc: Convert remaining v8 coproc insns to
 decodetree
Date: Fri, 13 Oct 2023 14:27:56 -0700
Message-Id: <20231013212846.165724-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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
 target/sparc/insns.decode | 11 +++++++++++
 target/sparc/translate.c  | 32 ++++++--------------------------
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 7ec1518b54..a124fdeaac 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -211,3 +211,14 @@ SRA_i       10 ..... 100111 ..... 1 .   000000 ......      @shifti
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
index caa2eff626..72f3cbab47 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4738,8 +4738,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5179,14 +5180,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5405,13 +5403,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5672,12 +5663,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5717,11 +5702,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


