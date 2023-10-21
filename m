Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E81417D1B07
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:40:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eE-0002BB-C3; Sat, 21 Oct 2023 01:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4e8-0001xh-EP
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:36 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4e6-00014d-2x
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:35 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-77784edc2edso93008185a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866533; x=1698471333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPSGcQVowKCmfcGp+EPHz4OvzjcKg1TIvpNZBqc/ZJU=;
 b=y1Oj3qkty5+euVIvHeBeTjfr0Ih7vWP84baccF/zt42A0b4SesL0BS2LuM/7NHqYIZ
 BEl9kn5SGuKtDUngvgwzLby9+kFfBhMyv9/CqUS4KtZ69kcU9d9TCgddyJTeTWb47aBz
 ZpAO5/oen1HLdRyLe6UWhwJPyh3zpAWvguosm3BduQLvE3yPBzPvZhi10CiWPkwbNhNT
 bcmESslLJ8MSQ+SNWzPEXmVJoBm9jwZUEEHtW23HcqNrleNUOtJuyOEat54uEygIGsWO
 6IS39WaNNZmX3weKZd7JjD+PCH/Ztxc+3orLwsU2LfSHcnRf9G++hbzbaQuEFombh76U
 eaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866533; x=1698471333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPSGcQVowKCmfcGp+EPHz4OvzjcKg1TIvpNZBqc/ZJU=;
 b=vgg5PJDMpyti4RJLUiBRv3iXuVNcZpko42WEri67SDkagHgTMnmz7NoqJQGFKM9nSy
 5JlWxvm/QKbGBOE0uvJ7wcB8JxO28I5sBpz+fyh8Wdp1hkaC59xk9/6bn2f9+tiYhS7z
 qC27Zzn884nejv9it2PDe8zPQgKIt7c5tY9TdkO/pC8UCaj1ngu2pTqNjfzaGpAXFQCC
 5G6fwww3Wvuy/c/OINpAoYvozNVH6x6SAv7swMybOJgWA8xYJarmxuNO8dzZotPvIMRv
 oEcATZiCS8Ejr+7a5GV2UD//Bp+4zmmIqmdRozGjZV67eBNztteok3vsuqIPtVjnAzwY
 Dp4A==
X-Gm-Message-State: AOJu0Yxz8+8AyDbWK8nFlv0qRnFFYz8jhcDhOhhD1MZP5bXfQ/ZbgypG
 tDW0B8j+sseRfgHuKlyIjbcJR6fs3wpveoz4POI=
X-Google-Smtp-Source: AGHT+IEY8hJfeP2u6iapBsO4g4yFHsXL+Ndf37jjRLbfxhaXugYk4mgKf8VbALuUb1iFKEBK1uKE+A==
X-Received: by 2002:a05:620a:4047:b0:76f:135d:ce08 with SMTP id
 i7-20020a05620a404700b0076f135dce08mr4083390qko.57.1697866533005; 
 Fri, 20 Oct 2023 22:35:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 40/90] target/sparc: Convert remaining v8 coproc insns to
 decodetree
Date: Fri, 20 Oct 2023 22:31:08 -0700
Message-Id: <20231021053158.278135-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x736.google.com
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
index 667067822f..1303df92a7 100644
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
index 7fd19ff5ee..edd9211572 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4830,8 +4830,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5271,14 +5272,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5494,13 +5492,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5761,12 +5752,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5806,11 +5791,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


