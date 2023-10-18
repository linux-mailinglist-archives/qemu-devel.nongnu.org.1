Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A25E7CEAE2
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:02:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVn-0002Kf-Om; Wed, 18 Oct 2023 17:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVl-0002Gh-MN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVk-00058J-3w
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:29 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso124875b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666127; x=1698270927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IfXXjPSCAekTKnfIpCckOL6yHpkL7tvWXEcAjeu6hPU=;
 b=Jv1wp4dy/uMbbKRKlcXmBIXFn8ZmG7/7xM7twHvg5FN9fQCH3D0U5SESPRUd02aBI1
 z5+mymZr/YCX/E/dGiGdcX8ObZ8x7pUEqhm2i2kSz0D6KdAOrooRBPSD8zAc2LReRrb9
 zGUVEFpQRDKDangngRz9tY4YruZYzsYQAfPus3NIhwSKhYGEbhOHDNZqsVwnQJovdgIw
 7bZwCIbPAJXFG93SEI75lb6/NNfXGa0P5uwLEvGyLlm8BSgdwmKW9hbkJuAsN11vXGe6
 UsvdeU/F/Sues5eotk+A2G9TAZEAFmIRZdYmBOze3WIWI+Uc0mThyLaYt4g0cu2q3P3D
 BLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666127; x=1698270927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IfXXjPSCAekTKnfIpCckOL6yHpkL7tvWXEcAjeu6hPU=;
 b=JH1/ZNq1vw2pYbZiM0ftEFFAffcNMwnRBwqWwc0msKKv1XmEcfGa7gy6VShks6Bclh
 Wmv4UE4AfH2xa2oYMZEVlQn3NJFbevs/QPpDVNtbnYU9BHYY9p35ewxL0xAqpkpeX4Y2
 pk9ghIr7k7Tn3tjAUb3jUapOP8EUG63PXIq2GRMFG5RykDp+plCp9M4i8ACCvwZAZH+x
 vkAASC2k0p4JisrswXV7rcbj483yHoTT0l8/jiKhvSAOKLb+3mcD3ymcxr6nwEixzU0p
 A7eSN3JSTVIMKqzYbAB8hvodxAlBcRfJ39u/NSBlW+hpCxOUHONpTWuSFEHfuEKghwyJ
 e1sw==
X-Gm-Message-State: AOJu0YwoHQs1E7qPQDESl+DTEkEErCoa/o2Q9G0aJgl/RsN3K1+Txgb/
 LKjVAWTPukD0x7x3U4Vy2v8EJU7ujuyluFp0/2k=
X-Google-Smtp-Source: AGHT+IEf0qS3Knw3NMn/ddcwS75SfDemZxsP5NTyw4vXtCcN0EKDeyY9y5too4+bMvCxMEPW/o5fYA==
X-Received: by 2002:a05:6a00:2789:b0:68a:5cf8:dae4 with SMTP id
 bd9-20020a056a00278900b0068a5cf8dae4mr168682pfb.3.1697666126834; 
 Wed, 18 Oct 2023 14:55:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 58/61] target/hppa: Fix interruption based on default PSW
Date: Wed, 18 Oct 2023 14:51:32 -0700
Message-Id: <20231018215135.1561375-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

From: Helge Deller <deller@gmx.de>

The default PSW is set by the operating system with the PDC_PSW firmware
call. Use that setting to decide if wide mode is to be enabled for
interruptions and EIRR usage.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  2 ++
 target/hppa/int_helper.c | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 5ce05046c0..5c7fddbc2b 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -124,6 +124,8 @@
 #define PSW_SM_W         0x200      /* PA2.0 only : Enable Wide Mode */
 
 #define CR_RC            0
+#define CR_PSW_DEFAULT   6          /* see SeaBIOS PDC_PSW firmware call */
+#define  PDC_PSW_WIDE_BIT 2
 #define CR_PID1          8
 #define CR_PID2          9
 #define CR_PID3          12
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index f355c4c76b..021f410bef 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -52,9 +52,16 @@ static void io_eir_write(void *opaque, hwaddr addr,
                          uint64_t data, unsigned size)
 {
     HPPACPU *cpu = opaque;
-    int le_bit = ~data & 31;
+    int widthm1 = 31;
+    int le_bit;
 
-    cpu->env.cr[CR_EIRR] |= (target_ulong)1 << le_bit;
+    /* The default PSW.W controls the width of EIRR. */
+    if (cpu->is_pa20 && cpu->env.cr[CR_PSW_DEFAULT] & PDC_PSW_WIDE_BIT) {
+        widthm1 = 63;
+    }
+    le_bit = ~data & widthm1;
+
+    cpu->env.cr[CR_EIRR] |= 1ull << le_bit;
     eval_interrupt(cpu);
 }
 
@@ -104,8 +111,10 @@ void hppa_cpu_do_interrupt(CPUState *cs)
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


