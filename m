Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6FE7E3382
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPP-0000Rl-Qq; Mon, 06 Nov 2023 22:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COS-0006w3-KU
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:45 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000he-4w
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:44 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc5b705769so47366735ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326276; x=1699931076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mF9dOeZxo2aOz0Qybb3Ky4+BLIWImu3Ncx4MvbmRDnU=;
 b=Xm29FvE0UmEb5fLz87SdOpTHhPId5TfaALrALPRUatPn5BPlSDQMVSNxwUEH/3ileN
 45c0j5vRaKpugqSEct3mNg00E18jm8Ei4KlU3UL/eMPtqiY61qumkOAK+qPo+U//qrJH
 bmuEma5UKIs2UgJrNppzBusfg1VR8tFXV0CQ45/6VZ6IcYEuWn3PuW7f7xxqfXWU2qRc
 DINHYjOhtQ4t6Ub+k9yJ4lQV8em8hW7NIwGak0B9eWf4hZPYlTMBrRPuP9bJju45er5Y
 lqHLmQJ7GGP8jOoCrdHzs6ODSehxAwFDTG9cM41zPNeA9HY6cPnLRGDzHjGvoeegtOnb
 H6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326276; x=1699931076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mF9dOeZxo2aOz0Qybb3Ky4+BLIWImu3Ncx4MvbmRDnU=;
 b=wCQflaDWNukEVQ6a51yGv6vkSmZw5z/z6hzYp7TnWo73EB2hFoB5I8hosTxXSErQGy
 iEgzCNbPh3+2FehGqy4fU3LEHkmPe6sF/F+yIAjJ4rRvrLrY/W1vzeFl8lv1nt7MCfzS
 9WWaeEvhC47EgI7ZYtMW/Bsa/Los4JxbB9LNvqBUH3HyN4Sa5Qp0/7t3jcx0vZFDdiCI
 BpJelDsLWZ1u6ooxCBO0Q1M1GeZ0tBkBb7vhWDMpZ7us9O8/WGUf6k3c8oDSEbaR8h5V
 SWdisWq8AoePouup9dhjI0u0yaCUdm1XIxyA/sI6z4BkdMg8jW2n7w6ed7C3bEd2xs+F
 xWyw==
X-Gm-Message-State: AOJu0YxTCsafdrjfWcee9SNUg1YFrJ3vCNXbat3YNmDQtAT8ADU4xOK6
 jW9CnH0IMcTI1oPIVq680jfhrP+gVqwwythDTm8=
X-Google-Smtp-Source: AGHT+IEENoqXHBClODPdUvXawhIjhnuy0EUiNl1Jk3sYfXpIEK7tUS3/ABMOZFclqrSsup/5oHrXUA==
X-Received: by 2002:a17:902:f394:b0:1c5:f0fd:51be with SMTP id
 f20-20020a170902f39400b001c5f0fd51bemr24047297ple.69.1699326275787; 
 Mon, 06 Nov 2023 19:04:35 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/85] target/hppa: Remove TARGET_HPPA64
Date: Mon,  6 Nov 2023 19:03:19 -0800
Message-Id: <20231107030407.8979-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Allow both user-only and system mode to run pa2.0 cpus.
Avoid creating a separate qemu-system-hppa64 binary;
force the qemu-hppa binary to use TARGET_ABI32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/hppa-linux-user.mak |  1 +
 target/hppa/cpu-param.h             | 23 +++++++----------------
 target/hppa/cpu.h                   |  9 ---------
 target/hppa/cpu.c                   |  2 --
 target/hppa/translate.c             |  2 --
 5 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/configs/targets/hppa-linux-user.mak b/configs/targets/hppa-linux-user.mak
index 361ea39d71..8e0a80492f 100644
--- a/configs/targets/hppa-linux-user.mak
+++ b/configs/targets/hppa-linux-user.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=hppa
+TARGET_ABI32=y
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index c2791ae5f2..2fb8e7924b 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -8,26 +8,17 @@
 #ifndef HPPA_CPU_PARAM_H
 #define HPPA_CPU_PARAM_H
 
-#ifdef TARGET_HPPA64
-# define TARGET_LONG_BITS             64
-# define TARGET_REGISTER_BITS         64
-# define TARGET_VIRT_ADDR_SPACE_BITS  64
-# define TARGET_PHYS_ADDR_SPACE_BITS  64
-#elif defined(CONFIG_USER_ONLY)
-# define TARGET_LONG_BITS             32
-# define TARGET_REGISTER_BITS         32
+#define TARGET_LONG_BITS              64
+#define TARGET_REGISTER_BITS          64
+
+#if defined(CONFIG_USER_ONLY) && defined(TARGET_ABI32)
+# define TARGET_PHYS_ADDR_SPACE_BITS  32
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
-# define TARGET_PHYS_ADDR_SPACE_BITS  32
 #else
-/*
- * In order to form the GVA from space:offset,
- * we need a 64-bit virtual address space.
- */
-# define TARGET_LONG_BITS             64
-# define TARGET_REGISTER_BITS         32
+# define TARGET_PHYS_ADDR_SPACE_BITS  64
 # define TARGET_VIRT_ADDR_SPACE_BITS  64
-# define TARGET_PHYS_ADDR_SPACE_BITS  32
 #endif
+
 #define TARGET_PAGE_BITS 12
 
 #endif
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index cb838defb0..77ddb20ac2 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -120,11 +120,7 @@
 #define PSW_T            0x01000000
 #define PSW_S            0x02000000
 #define PSW_E            0x04000000
-#ifdef TARGET_HPPA64
 #define PSW_W            0x08000000 /* PA2.0 only */
-#else
-#define PSW_W            0
-#endif
 #define PSW_Z            0x40000000 /* PA1.x only */
 #define PSW_Y            0x80000000 /* PA1.x only */
 
@@ -137,13 +133,8 @@
 #define PSW_SM_P         PSW_P
 #define PSW_SM_Q         PSW_Q      /* Enable Interrupt State Collection */
 #define PSW_SM_R         PSW_R      /* Enable Recover Counter Trap */
-#ifdef TARGET_HPPA64
 #define PSW_SM_E         0x100
 #define PSW_SM_W         0x200      /* PA2.0 only : Enable Wide Mode */
-#else
-#define PSW_SM_E         0
-#define PSW_SM_W         0
-#endif
 
 #define CR_RC            0
 #define CR_PID1          8
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 70ce0c3b99..9582619be2 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -252,12 +252,10 @@ static const TypeInfo hppa_cpu_type_infos[] = {
         .class_size = sizeof(HPPACPUClass),
         .class_init = hppa_cpu_class_init,
     },
-#ifdef TARGET_HPPA64
     {
         .name = TYPE_HPPA64_CPU,
         .parent = TYPE_HPPA_CPU,
     },
-#endif
 };
 
 DEFINE_TYPES(hppa_cpu_type_infos)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 41f4e06841..187d47f4c3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2177,7 +2177,6 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
 
     switch (ctl) {
     case CR_SAR:
-#ifdef TARGET_HPPA64
         if (a->e == 0) {
             /* MFSAR without ,W masks low 5 bits.  */
             tmp = dest_gpr(ctx, rt);
@@ -2185,7 +2184,6 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
             save_gpr(ctx, rt, tmp);
             goto done;
         }
-#endif
         save_gpr(ctx, rt, cpu_sar);
         goto done;
     case CR_IT: /* Interval Timer */
-- 
2.34.1


