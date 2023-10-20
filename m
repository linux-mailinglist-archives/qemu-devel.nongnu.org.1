Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 478097D1797
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:54:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwP4-00023V-KK; Fri, 20 Oct 2023 16:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP1-00020d-Hy
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:27 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOz-0001Df-TW
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:27 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso1115545b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834844; x=1698439644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wM6oyD2tzl0dJH7FSQ0obv2SUstAr+kC/PKso0mR/f4=;
 b=q9J1mEZKolsO6/7XmrUFsT34HsbqbORm7fg+kk24XJCVTOAf7XW84i8Uzx9dqJ04Rv
 /nLdNIDjvp8lm+d6zP7NDCc+J/gyBgIHxe6tQvq/+YAcLj2XryXh7ZL0AelPzcaP7VJR
 cDcnX/OVqJFnuI/HlONwa8l0giHiFdGczv1zt2KkyK2z5VK2HLAP1bIpm4s6Wyt7yNbc
 br6r1x18MRCheTAYUTB1evqi6Hbn9MBGUV6X5fyY5sBHH0vs4gXzw6KS6JTLTmmOPImh
 SE/qzuU5ZmvU4pyQ02+K5jwUL69cBiEVqTvwhfYx2b2QPLLY1VdkB33kpjqnHsRK8sWc
 MH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834844; x=1698439644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wM6oyD2tzl0dJH7FSQ0obv2SUstAr+kC/PKso0mR/f4=;
 b=OqFAPBYvI9Giw/FS+YOlJQewZ1C+59Wnr6MQsa27o3p0brUQst3vqSxssxbJVbygy0
 8pL5sfpgZhRlFtoJprUQsIQ9f5vGzF1uy0URm9UveyWa8JClyA79R1dBZml67xoR3Jzk
 Z47uGBaoLosXcqwzKcBynhFHiB2kGQlTy2tSSgdIdT2q/OdfM1vE6vrvEmTqeHTnbqV8
 CSGgzlL9mYQT3OE3jFAdW+HMYu9gTDO20BL0sW0hv62tgINkceDnNA/t8IoMJoHXl0cQ
 3RUwg+nW4RFXRW1YA/Eamkuoi054HrHlsaOKQ82lbh8WXF7wi5eCara41lURtH9r7y9M
 uMJw==
X-Gm-Message-State: AOJu0YwldJMGonYqR3w9skaNVjCOCKlWs9SfxQvuYaOAiK9yHUt3kWr/
 USngwE/T6nqsulJGqKZbwJvggLg6UqpvfdM9+sk=
X-Google-Smtp-Source: AGHT+IGgedYkJ4+aYJ0ItGSgAnG8FqxW+rR5zzjI95FeHd3wpNqTvo0SsIvh+QoM5LijD5kKqK8FZg==
X-Received: by 2002:a05:6a00:1389:b0:68f:d35d:217e with SMTP id
 t9-20020a056a00138900b0068fd35d217emr3115072pfg.2.1697834844678; 
 Fri, 20 Oct 2023 13:47:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 59/65] target/hppa: Fix interruption based on default PSW
Date: Fri, 20 Oct 2023 13:43:25 -0700
Message-Id: <20231020204331.139847-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index c9a9b9d3be..4aea46442a 100644
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


