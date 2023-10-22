Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7807D2741
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwh-0004Qh-Ai; Sun, 22 Oct 2023 19:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwd-00044n-Ci
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:19 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwX-0007UF-Lo
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:18 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso2748330b3a.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017592; x=1698622392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cxhfM6phj49WLwMeZtSo44XtpuYSdXl6s4CPVwMV1M=;
 b=GpkEX7DDYVW47D0rLEQN6qyoDtCZsbTMa4/8/KRRL9asoaYdbbfRvBz28rOv0p2V5s
 kqE4K1zTo9MGoL8N0ey+y2v0zdFosjCIUnrpntfLFeaUUD0zuLJojqhcf7drcr8EH0TM
 DuC9PwqHXdYDihIjkDbwO/Rq/WzQi+Cj+7IlJUsvFuxI54R92n8KceeN/hYgJ9Ljb4aQ
 7P5AwU0e4kGh7r2inQFG2bLngdbo4uV83pV7jNB/IWOhjPL3MaeCHnpSsSrcD6VO9G82
 JiaQaPeauoguP6nilLZj3AoM2RUmqOsiV1DEHic8kqDgtpktAMryX2y3atZdnMdaLNYt
 TdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017592; x=1698622392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5cxhfM6phj49WLwMeZtSo44XtpuYSdXl6s4CPVwMV1M=;
 b=bP4ajZBJ24Jam8OSOUZeg4m8bQAgBo6yoaJiYnq4WihDC6dkC1ukSaZBz+jNlJAHGL
 7aweRInQmh4OqwxZvULq2js+wSCFlrRdJV187DKjtrXQcoMhQGbdzBqOgh8LpKCKIoLH
 hU6TyZfEx65Xio5Ss+2fn9VN/Dst5JpvHWVZqjVMi+yeQ3AvgeSrjfzj7ajdw59gLT76
 YqzkfnnJsLTHH7C9KVGrHLvBFmvEKPxnnmigAGR5l9FXvR1J66++64AszgY0LPJo/xtl
 LOnFqqAXkycSiuEAqtVTqUWgDAkDbyvVnvtZ1goBJJ9E4YuOXVoyyr3rdeiU6EX15qGo
 fFTQ==
X-Gm-Message-State: AOJu0YyWQqEYdBxg9Lyi0eNh3NLZBmHxoxd/1dZ2UQ+gsvrJKSCQbPy2
 Zht/v391E46TUODBPFvXXq0UsEBgaN65zY23k3s=
X-Google-Smtp-Source: AGHT+IF30dukT5dJvNxp5Thrqak9l3Fav3koT1YRVhMUXzs9O8M2MZH/gcnnz4Oh0Iijb9dPP+145A==
X-Received: by 2002:a05:6a00:1402:b0:6be:1b39:2f3a with SMTP id
 l2-20020a056a00140200b006be1b392f3amr9332335pfu.14.1698017592075; 
 Sun, 22 Oct 2023 16:33:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 44/94] target/sparc: Convert remaining v8 coproc insns to
 decodetree
Date: Sun, 22 Oct 2023 16:28:42 -0700
Message-Id: <20231022232932.80507-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 2050193cb0..84d5b2a64e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4724,8 +4724,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5165,14 +5166,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5388,13 +5386,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5655,12 +5646,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5700,11 +5685,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


