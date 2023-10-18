Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE5D7CEA79
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESl-0001xf-FJ; Wed, 18 Oct 2023 17:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEST-0001A0-4L
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:05 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESQ-0004S4-Hx
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:04 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57be3d8e738so4125076eaf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665921; x=1698270721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HV5pYQwKSuXLoav6s1Qqsg8a/tXHn3qomGwcXH2ymT4=;
 b=FXEbzw3/TunQaUY92D9mvMlzady8XDQYNijmU6HUESZ4IVUocOSxDNZQbY21VhN30Z
 ZFGeL1RTx95scBBv67dHpZVp+5LVtZUu6xQQSfAh8dzGsUsaStPSGEw9aP/dhsdJ50Hw
 ZCx9ZrweYLWy/t3kEQ5//zGn3lqv9v2k4meM41BJRHT9ImWEVrmkTkGygt7OwcazLGp0
 wMbrr4oj+UlQwNJCbv6vC2Yc9gS/UpAjQeypC4oxjFIMbkG7xR+meUm2nlWrZkZO88o8
 YUUWqWDZiRbdVNcoWt5AruLCCgke35lTSkVG6eBlBxoFlmDEaFGBnKGJmwJVD2gm7OmV
 GydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665921; x=1698270721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HV5pYQwKSuXLoav6s1Qqsg8a/tXHn3qomGwcXH2ymT4=;
 b=a20wjBagtUxpU4WhfnP9bYBYbzfg18/mGVOVsNDCwogbyX/G5tj5KO75LTiC2CeBlh
 wWa+gvxnchRGYrAW2CGJ6t/MsGanmxG7QNEI++oF8nSCTtdaJC/ucM2nu+6HRI5uQX2d
 YM/ZaCxAiXqmXwEjLmBLiDVIbg5eiUQAzu0yIXNAs/2G+B4Poj+wOdG+8XBYHDUqlGCz
 3vTt7Dnt0ETJmGtsDW/rMl7qbS5z1y5DhHfG9LPqd+Xcxslnh/alnACzv6G/Vb2dq0YB
 PmBx9Sq0TR9xfYS9fDfBoiJLkjPf+auC2u/xeYpQZ/eqcn7E9oem9vhmWlxYWjLDNlpc
 zcUQ==
X-Gm-Message-State: AOJu0Yzh0J5dGna5YahOCMUQ09iq0ZPboB0qhfEFELwlsSDuja+xPZP0
 aJucSkr3waM8G4Z30If/7G1hnAxuvrBdnKIjh2o=
X-Google-Smtp-Source: AGHT+IFoqNYlD6iI+Q1M7TtOh14x7QD58jjq/eYq7CdSblPu86iu0H3NdrQjyxFmS/jqJ1ED+fWvgA==
X-Received: by 2002:a05:6358:c609:b0:142:d097:3725 with SMTP id
 fd9-20020a056358c60900b00142d0973725mr269953rwb.9.1697665921158; 
 Wed, 18 Oct 2023 14:52:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:52:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 29/61] target/hppa: Remove TARGET_HPPA64
Date: Wed, 18 Oct 2023 14:51:03 -0700
Message-Id: <20231018215135.1561375-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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
 target/hppa/cpu.c                   |  4 ----
 target/hppa/translate.c             |  2 --
 5 files changed, 8 insertions(+), 31 deletions(-)

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
index 1a12b2a186..251f85444a 100644
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
index 6bf415139f..bbb6080e2d 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -253,7 +253,6 @@ static const TypeInfo hppa_cpu_type_info = {
     .class_init = hppa_cpu_class_init,
 };
 
-#ifdef TARGET_HPPA64
 static void hppa64_cpu_initfn(Object *obj)
 {
     HPPACPU *cpu = HPPA_CPU(obj);
@@ -265,14 +264,11 @@ static const TypeInfo hppa64_cpu_type_info = {
     .parent = TYPE_HPPA_CPU,
     .instance_init = hppa64_cpu_initfn,
 };
-#endif
 
 static void hppa_cpu_register_types(void)
 {
     type_register_static(&hppa_cpu_type_info);
-#ifdef TARGET_HPPA64
     type_register_static(&hppa64_cpu_type_info);
-#endif
 }
 
 type_init(hppa_cpu_register_types)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8bea28f0fd..94969cf2f0 100644
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


