Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3297D177E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:50:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLv-0007rE-Cm; Fri, 20 Oct 2023 16:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLl-0007lv-9M
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:09 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLh-0008Ea-92
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:04 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso1154679b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834639; x=1698439439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLJZOZT+lQfb7f2jxY8G9POC0Jl6++4YjRa95Z5whBs=;
 b=KEmwcthD0ITAkDvHlOVkgAITZWT2k6uUCKsn5oIA5QBzGR4Z8oKycd+y3lo3ge9ptF
 HYXOuAW0IuwhEhkRCstIxOjsI92vz83Zf5lQQoKLzfBm2QmbnO4dfRma/iTYmo8Hw5jm
 AzaXWhkx6sPsaGM/AuokX3NIhS5Fo3BEo/I7vbParkzH/+HDJk0pbD77PydiRKmDGoQD
 GVthDp/ITnhzptsKybxFsOVtyi6Gj+7MavTlNy+k2sCisZr7Ka03HlFaN1xq7vnO/SHU
 iY6w0irGT8Wm8kcQfFpD+9XzlCP3BcyzZrejmwQQc6vmJScI/FgSkGzw9xhlFoJjduy2
 exPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834639; x=1698439439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLJZOZT+lQfb7f2jxY8G9POC0Jl6++4YjRa95Z5whBs=;
 b=MR6TUUDcLHSJpymoBJtcvW4CJm87Qd6ZHLHHi6nOJXNP55nw01tgNEsDdiz/b6Tjbo
 OERlhFBmNQxbVv0UYI83Z/WQDS8SvpTggFTWyXM4TKeZi1WKdt4zFkrlr3yTboKbJEIf
 IwObaBIcLxWuXX/d9PoNKzT2ZGOjLEcaA/trjoKx7KBgSh14DFde2z296ZEDF2nGLouR
 KeLz2CvKhBz90SfLMDe3YCVxGF5Lebgvbw+jRLgAiC1xhwDp7bKs9lvF9XlJ1rWzRY8R
 rtQw1Z5VM6CF2tO+7GuWk/XLVue/SmvclXVATMfFItmZw4r3jV7W7DF8J99KsgSbjwSu
 v5GA==
X-Gm-Message-State: AOJu0Yxml19zMRjcoWsWBi2SREvJ3sSiuV70BSEDMZZK+ye0JH6vg2hI
 3NIkvxOV/QQHGHCLryhrAXd1v67gpC+VC1+X/jA=
X-Google-Smtp-Source: AGHT+IGfwqAUNIaFqmf7/BNw4Jab48mDUqppZWmGj3apEd+xxoRYtt1/uEx9Op5WItnVXOQ5oso5sQ==
X-Received: by 2002:a05:6a20:258b:b0:15e:bb88:b771 with SMTP id
 k11-20020a056a20258b00b0015ebb88b771mr2486228pzd.37.1697834639434; 
 Fri, 20 Oct 2023 13:43:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 29/65] target/hppa: Remove TARGET_HPPA64
Date: Fri, 20 Oct 2023 13:42:55 -0700
Message-Id: <20231020204331.139847-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
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

Allow both user-only and system mode to run pa2.0 cpus.
Avoid creating a separate qemu-system-hppa64 binary;
force the qemu-hppa binary to use TARGET_ABI32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/hppa-linux-user.mak |  1 +
 target/hppa/cpu-param.h             | 23 +++++++----------------
 target/hppa/cpu.h                   |  9 ---------
 target/hppa/cpu.c                   |  3 ---
 target/hppa/translate.c             |  2 --
 5 files changed, 8 insertions(+), 30 deletions(-)

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
index 2182437882..8320f82464 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -107,11 +107,7 @@
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
 
@@ -124,13 +120,8 @@
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
index 81d51e98b6..36875a6a1a 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -253,13 +253,10 @@ static const TypeInfo hppa_cpu_type_infos[] = {
         .class_size = sizeof(HPPACPUClass),
         .class_init = hppa_cpu_class_init,
     },
-#ifdef TARGET_HPPA64
     {
         .name = TYPE_HPPA64_CPU,
         .parent = TYPE_HPPA_CPU,
-        .instance_init = hppa64_cpu_initfn,
     },
-#endif
 };
 
 DEFINE_TYPES(hppa_cpu_type_infos)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index be1763cb45..450f64bac3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2156,7 +2156,6 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
 
     switch (ctl) {
     case CR_SAR:
-#ifdef TARGET_HPPA64
         if (a->e == 0) {
             /* MFSAR without ,W masks low 5 bits.  */
             tmp = dest_gpr(ctx, rt);
@@ -2164,7 +2163,6 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
             save_gpr(ctx, rt, tmp);
             goto done;
         }
-#endif
         save_gpr(ctx, rt, cpu_sar);
         goto done;
     case CR_IT: /* Interval Timer */
-- 
2.34.1


