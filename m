Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EFE7D2174
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:13:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRZt-0008S4-MK; Sun, 22 Oct 2023 02:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZp-0008La-8A
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZm-0002D4-Vm
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1615889b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954677; x=1698559477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlZGGo9skZpt5kXsH4zxBgv3Gua/KvvRaliGeEBdcVo=;
 b=Tn4fWs24qHqrJ4XWLqzpMrX2qYwj0+oR4/SDy9XGTPrDkFQlt6YEZoFkXRGDyEmB5P
 qouicGEI4WedtvTW0kjRW0vPp1nT95VmsqAo9bq+2kMh3XTp+Xg5pYhY4q5mWXcCCVuq
 zdvmhoQQMqPuwvCewk2ea+BKI3KSUJtcngl7IWMQDaxKKLisFdjtgN/ubLRufyPgiefq
 TZPEGlvqnOHUorumKdy/0+4tz74fL75BStCtJFwNhb0LtahZdQNIsFa2jSblZjus3kyx
 a4nbVfLwNuk3B8A+hh/LMBKnyLbEnkYkuNxoydsOj1hVxzy8hUtVeV8eTYkfZuiIDWvI
 UuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954677; x=1698559477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlZGGo9skZpt5kXsH4zxBgv3Gua/KvvRaliGeEBdcVo=;
 b=QewU8SsqGwmaMsVWYiSpfJetvaA/8tkB+5y6A2LHEOpxC8LpUhhQaQp7yiIyHbAeP1
 LtE4TlV7ME3i2fhTIh1CQ5nuAzEyJO7pKxrw9+IiYhsu+rn0M/2cvL9CpMODkGR5kjkt
 A1ZRAfyyT9+bZ9KH6EyGxcTJCvKPcilnbf+jVckiRren+nbx+qb93lS+uV7hc4mTKTaX
 uEs3ty9N+SbIoHSLWlAX5m/k+V+OhHe5fCoEPxMwosPuw6Twpdg/RnhlMR3p3pT5Qx2B
 LmH8yoN1flhSDuO3uRSXKuRgAMT3vu0PUDAmeHJzHMVRsXstr4L0Nob3f9PcBrwLsRai
 jtfw==
X-Gm-Message-State: AOJu0Yznou3OO9WEx8FskopZ26qGn39Yq2yNCOJoMhR7OdSuT1DqCycK
 K22+KKlvv/nCm8Kkb5Fyi+UfqluYWNhc/SmDJqE=
X-Google-Smtp-Source: AGHT+IFZr9Xa6LzLjKv1xOfp8xsIOECbFmodKHeKk5Ch9k/b63j7Pdg+7hni/592sHA7OJiWpZ2YPw==
X-Received: by 2002:a62:b610:0:b0:68a:6d34:474b with SMTP id
 j16-20020a62b610000000b0068a6d34474bmr10673235pff.15.1697954677683; 
 Sat, 21 Oct 2023 23:04:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 42/90] target/sparc: Move FLUSH, SAVE, RESTORE to decodetree
Date: Sat, 21 Oct 2023 22:59:43 -0700
Message-Id: <20231022060031.490251-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/sparc/insns.decode |  4 ++++
 target/sparc/translate.c  | 35 +++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 271789ac13..aa90b5c5bb 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -223,6 +223,10 @@ JMPL        10 ..... 111000 ..... . .............          @r_r_ri
   RETT      10 00000 111001 ..... . .............          @n_r_ri
   RETURN    10 00000 111001 ..... . .............          @n_r_ri
 }
+NOP         10 00000 111011 ----- 0 00000000-----          # FLUSH reg+reg
+NOP         10 00000 111011 ----- 1 -------------          # FLUSH reg+imm
+SAVE        10 ..... 111100 ..... . .............          @r_r_ri
+RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 861aeaaa34..7f414c1a52 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4213,6 +4213,11 @@ static bool do_saved_restored(DisasContext *dc, void (*func)(TCGv_env))
 TRANS(SAVED, 64, do_saved_restored, gen_helper_saved)
 TRANS(RESTORED, 64, do_saved_restored, gen_helper_restored)
 
+static bool trans_NOP(DisasContext *dc, arg_NOP *a)
+{
+    return advance_pc(dc);
+}
+
 static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
 {
     /*
@@ -4601,6 +4606,24 @@ static bool do_return(DisasContext *dc, int rd, TCGv src)
 
 TRANS(RETURN, 64, do_add_special, a, do_return)
 
+static bool do_save(DisasContext *dc, int rd, TCGv src)
+{
+    gen_helper_save(tcg_env);
+    gen_store_gpr(dc, rd, src);
+    return advance_pc(dc);
+}
+
+TRANS(SAVE, ALL, do_add_special, a, do_save)
+
+static bool do_restore(DisasContext *dc, int rd, TCGv src)
+{
+    gen_helper_restore(tcg_env);
+    gen_store_gpr(dc, rd, src);
+    return advance_pc(dc);
+}
+
+TRANS(RESTORE, ALL, do_add_special, a, do_restore)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5416,18 +5439,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 switch (xop) {
                 case 0x38:      /* jmpl */
                 case 0x39:      /* rett, V9 return */
-                    g_assert_not_reached();  /* in decode tree */
-                case 0x3b: /* flush */
-                    /* nop */
-                    break;
+                case 0x3b:      /* flush */
                 case 0x3c:      /* save */
-                    gen_helper_save(tcg_env);
-                    gen_store_gpr(dc, rd, cpu_tmp0);
-                    break;
                 case 0x3d:      /* restore */
-                    gen_helper_restore(tcg_env);
-                    gen_store_gpr(dc, rd, cpu_tmp0);
-                    break;
+                    g_assert_not_reached();  /* in decode tree */
 #if !defined(CONFIG_USER_ONLY) && defined(TARGET_SPARC64)
                 case 0x3e:      /* V9 done/retry */
                     {
-- 
2.34.1


