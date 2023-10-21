Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA937D1AF6
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bH-0007IR-Te; Sat, 21 Oct 2023 01:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4aw-0007Bq-IB
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:18 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4av-0008Pz-08
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:18 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b3ec45d6e9so1048275b6e.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866335; x=1698471135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzvcZe31/ZJG4v0X6So+um8Fp3Qd2Uum0t8sUDXqISw=;
 b=RVX8MxnHNC2M2+2OJTsTlYEo97k6p1ETF9XmBN+5T6qOvsVfsuM3stfArs8hiQ2sFr
 wN+F1MGMlHgG4FALATEcktGXfAJfyxrsHhAg+QbqZLFPVzX9ktqfzUOvQmfs4PJ8L70F
 OF28XxNwAcLGdmG6Zn7vmJu03PzsCluM43M3WAtf4acct4FDXGZzynK8fV8efQ0JN1/6
 yKsjW/7Pet5cFSeu5KvwWIup0C4HWSEuz7fv6xHOK+DGSysPS+Y8Cd0eZTByJ8XGvDbR
 Gls24IVHx7mRRUJtlJ3LxGXtZVbSyi1+nkwk0OFja88V1KQMXeZh4UZtCNMOYzq992G8
 o7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866335; x=1698471135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzvcZe31/ZJG4v0X6So+um8Fp3Qd2Uum0t8sUDXqISw=;
 b=TnXUSTPKorAjdfz1nEL7Tc9CwuCMin93Vs4amOCkAlOji8HqfDzIJb10m/F15QKpCD
 +TwBfPC1qbjTzw2S/cHWyGZ95vAiPlbQJ0GZekh2L7puvrJUjg1l6/PerIfT3uF1pf3h
 qRFP2/vet/QShA780otakfmIkLatYtvwKIQjebuHfFC8e5QNtvApwrXksPXia/BeN+Xk
 FqdaAye7noe/rHDQOcMm0ePY4TXyKsu2CGQTa35m09+/WBH4x8hfCbs12D4+5wyvm0uv
 i3hM6VRE5JwfEANRCia9HmsF5lbBwWOVdLaXUhSgLNuoS8AYlsaEEZeLIP9QiIIRth9u
 iWBA==
X-Gm-Message-State: AOJu0Yy2KcaOu+FpgoWZM2KkRW3QgZHaga1ZUEwlk68fvSC3z1Gc5XZ8
 VW6w3aFws2Z6fRQdT5Y7t5qToOkE51WOTjB96wI=
X-Google-Smtp-Source: AGHT+IHnCdZYXo4Uo8ihkC0n9X8sB3RZjjU5PuZJmWNMNqwy+hlfn5No44lT0TKIjdMhsiITDgIHpA==
X-Received: by 2002:a54:4e84:0:b0:3af:75e2:4c34 with SMTP id
 c4-20020a544e84000000b003af75e24c34mr3696457oiy.50.1697866335724; 
 Fri, 20 Oct 2023 22:32:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 19/90] target/sparc: Move SETHI to decodetree
Date: Fri, 20 Oct 2023 22:30:47 -0700
Message-Id: <20231021053158.278135-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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
 target/sparc/insns.decode |  6 +++++
 target/sparc/translate.c  | 50 ++++++++++++---------------------------
 2 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 9ab3f2eb82..f6f5401b10 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -3,6 +3,10 @@
 # Sparc instruction decode definitions.
 # Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
 
+##
+## Major Opcodes 00 and 01 -- branches, call, and sethi.
+##
+
 &bcc    i a cond cc
 BPcc    00 a:1 cond:4   001 cc:1 0 - i:s19                 &bcc
 Bicc    00 a:1 cond:4   010          i:s22                 &bcc cc=0
@@ -14,4 +18,6 @@ BPr     00 a:1 0 cond:3 011 ..     - rs1:5 ..............  i=%d16
 
 NCP     00 -   ----     111 ----------------------         # CBcc
 
+SETHI   00 rd:5         100 i:22
+
 CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d12f2b4b87..cdd929282a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2873,6 +2873,10 @@ static bool advance_pc(DisasContext *dc)
     return true;
 }
 
+/*
+ * Major opcodes 00 and 01 -- branches, call, and sethi
+ */
+
 static bool advance_jump_uncond_never(DisasContext *dc, bool annul)
 {
     if (annul) {
@@ -3029,6 +3033,15 @@ static bool trans_NCP(DisasContext *dc, arg_NCP *a)
 #endif
 }
 
+static bool trans_SETHI(DisasContext *dc, arg_SETHI *a)
+{
+    /* Special-case %g0 because that's the canonical nop.  */
+    if (a->rd) {
+        gen_store_gpr(dc, a->rd, tcg_constant_tl((uint32_t)a->i << 10));
+    }
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3049,41 +3062,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
     rd = GET_FIELD(insn, 2, 6);
 
     switch (opc) {
-    case 0:                     /* branches/sethi */
-        {
-            unsigned int xop = GET_FIELD(insn, 7, 9);
-            switch (xop) {
-#ifdef TARGET_SPARC64
-            case 0x1:           /* V9 BPcc */
-                g_assert_not_reached(); /* in decodetree */
-            case 0x3:           /* V9 BPr */
-                g_assert_not_reached(); /* in decodetree */
-            case 0x5:           /* V9 FBPcc */
-                g_assert_not_reached(); /* in decodetree */
-#else
-            case 0x7:           /* CBN+x */
-                g_assert_not_reached(); /* in decodetree */
-#endif
-            case 0x2:           /* BN+x */
-                g_assert_not_reached(); /* in decodetree */
-            case 0x6:           /* FBN+x */
-                g_assert_not_reached(); /* in decodetree */
-            case 0x4:           /* SETHI */
-                /* Special-case %g0 because that's the canonical nop.  */
-                if (rd) {
-                    uint32_t value = GET_FIELD(insn, 10, 31);
-                    TCGv t = gen_dest_gpr(dc, rd);
-                    tcg_gen_movi_tl(t, value << 10);
-                    gen_store_gpr(dc, rd, t);
-                }
-                break;
-            case 0x0:           /* UNIMPL */
-            default:
-                goto illegal_insn;
-            }
-            break;
-        }
-        break;
+    case 0:
+        goto illegal_insn; /* in decodetree */
     case 1:
         g_assert_not_reached(); /* in decodetree */
     case 2:                     /* FPU & Logical Operations */
-- 
2.34.1


