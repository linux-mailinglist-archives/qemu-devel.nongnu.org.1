Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D0D7E340B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:15:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRv-0005mT-Kn; Mon, 06 Nov 2023 22:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRi-00057Z-Jw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:07 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRc-0001QS-R0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:06 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so39090595ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326479; x=1699931279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVaSUdm8wIzLLsLpBUjpNJYI2RdNW+CR3uBhuw+VEbI=;
 b=YxybFH0OFrcdmpqL2OZ+Mn9Y9GJwNMywaKpzP9KLa82z1me01AF6Zjqx7h67UgPxkg
 Yw/IvBQh6FHZH3sdOFuRovDuNOdb5IPuvipnfKCFpW0bz4bq/BiyoUelAd4qxXaJ60cc
 MSnmooehTqpAT/R4Uq+pfYXxbua/2I5EsPAhO4GiT+XN8ipIZ6o5IUxRBUlqjNQxIk0A
 CMhWiM69HVJvC83aS04ii7dsThoE02XpPpE6lF7BXENd7zGF5YsoXd5/g4LOQHW1tUHL
 lfDloK02/0oYL7pSf2eCep3KeEoq8yWw60x25vHK2M3aoAwmptyyqq9r/oTK5feN9zZX
 qszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326479; x=1699931279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zVaSUdm8wIzLLsLpBUjpNJYI2RdNW+CR3uBhuw+VEbI=;
 b=ONT1EjTNzSpcNujkXpBhtlWtROfoS+SP5d/2svvkzHXbvPn32a26JS27xuAOtd8T9n
 So7cgEHSgXtzA3RGMQghc/sS/beUxlDR+RuAxf+iStA96CU/3FUObXLF6OOdCI2pZjZ3
 DQWy2Dux64zW12dX8kQaox2lzocS9Qmo/hOWBWpMhSIdiZAo9gUqmnXCaxmtk668TBxc
 rd9r2Soi9YTLYvaofMPlZ1SR8Q0ZLZC9dbkPbpisXsOLcq4H0LKXfToTQQVyhLNNj0T8
 VPMVK3AbDf67nUHaWmURVbDhV01tTRRAWTmK0725qVlY3gDyDt12zKwJHfXueVAiE933
 FB5g==
X-Gm-Message-State: AOJu0Yx8Z0YhVqT5YQ2L8YKFLHj8lpHAeKG3LgMt9ZnB6wD5c3ayo/Es
 P/3GiDvzYD5KkiaonVQSr0G4FJMZMZM35K98xxo=
X-Google-Smtp-Source: AGHT+IEHZ0fAlvxYUG/xR342B5Fd+IiBnzVqsDTkPnLz3uZmlbtm7VitnxWVFUYf1O9SUEwwt0tOdQ==
X-Received: by 2002:a17:90a:ac06:b0:280:200c:2e20 with SMTP id
 o6-20020a17090aac0600b00280200c2e20mr20255894pjq.27.1699326479460; 
 Mon, 06 Nov 2023 19:07:59 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 68/85] target/hppa: Fix interruption based on default PSW
Date: Mon,  6 Nov 2023 19:03:50 -0800
Message-Id: <20231107030407.8979-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The default PSW is set by the operating system with the PDC_PSW
firmware call.  Use that setting to decide if wide mode is to be
enabled for interruptions and EIRR usage.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  2 ++
 target/hppa/int_helper.c | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index ea676ba062..ea8e7e99a4 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -137,6 +137,8 @@
 #define PSW_SM_W         0x200      /* PA2.0 only : Enable Wide Mode */
 
 #define CR_RC            0
+#define CR_PSW_DEFAULT   6          /* see SeaBIOS PDC_PSW firmware call */
+#define  PDC_PSW_WIDE_BIT 2
 #define CR_PID1          8
 #define CR_PID2          9
 #define CR_PID3          12
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index f355c4c76b..a11d607b31 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -52,9 +52,17 @@ static void io_eir_write(void *opaque, hwaddr addr,
                          uint64_t data, unsigned size)
 {
     HPPACPU *cpu = opaque;
-    int le_bit = ~data & 31;
+    CPUHPPAState *env = &cpu->env;
+    int widthm1 = 31;
+    int le_bit;
 
-    cpu->env.cr[CR_EIRR] |= (target_ulong)1 << le_bit;
+    /* The default PSW.W controls the width of EIRR. */
+    if (hppa_is_pa20(env) && env->cr[CR_PSW_DEFAULT] & PDC_PSW_WIDE_BIT) {
+        widthm1 = 63;
+    }
+    le_bit = ~data & widthm1;
+
+    env->cr[CR_EIRR] |= 1ull << le_bit;
     eval_interrupt(cpu);
 }
 
@@ -104,8 +112,10 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     /* step 1 */
     env->cr[CR_IPSW] = old_psw = cpu_hppa_get_psw(env);
 
-    /* step 2 -- note PSW_W == 0 for !HPPA64.  */
-    cpu_hppa_put_psw(env, PSW_W | (i == EXCP_HPMC ? PSW_M : 0));
+    /* step 2 -- Note PSW_W is masked out again for pa1.x */
+    cpu_hppa_put_psw(env,
+                     (env->cr[CR_PSW_DEFAULT] & PDC_PSW_WIDE_BIT ? PSW_W : 0) |
+                     (i == EXCP_HPMC ? PSW_M : 0));
 
     /* step 3 */
     env->cr[CR_IIASQ] = iasq_f >> 32;
-- 
2.34.1


