Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A91E7DEA16
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:34:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYr-0006iX-E2; Wed, 01 Nov 2023 21:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXv-0005o0-M4
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:31:19 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXu-0001fD-1D
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:55 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso407124b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888653; x=1699493453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mF9dOeZxo2aOz0Qybb3Ky4+BLIWImu3Ncx4MvbmRDnU=;
 b=kASNu/ZTeckSFF/zlvi9DQHC2qzkN+GVx1AXUgt46pJnHnvUiRnOHiSlv3ZbdhbKLh
 /4ZAnJs3e7L7hDftnDZhwcfoYvKOVd19+bmp/Bmv2a+tMxfqhHnec6EsapB18ZOE4VYy
 zDrH7U/eWceg3wg3S4MD1JmNYEecKqRE0WXYRuKSwkgcAoyHstA1C2IkvlTU/l3TKxLu
 GDKWGdY9Kd5Vc5/lCOAwlv2Fm0xdpbrnaLiuPlVSd96MWq3VZw2az8KldQsxW7je10KG
 Kq4GyhoW9e7gkE5uzCi6h7wr5K+eVRjwsFSfCjdQwVToUMRa4i/Xuc6qVot0HQPJ/Wdc
 z4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888653; x=1699493453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mF9dOeZxo2aOz0Qybb3Ky4+BLIWImu3Ncx4MvbmRDnU=;
 b=SMpnEcmjkMUBsrsmcVtzB54yy2DQMwcqkR8kMQ1M4iomrSRz44da6NmflDBh9KHa4z
 hKzCIiQDe2N3c8qlhRyi6blWBihfYZe3lsyed39jOM/CPFKse2pjOa5xKvnGnlFVyrvx
 e5zn4kq30ofNRdtzbpyhQh4V2TMAAK85SarlbIbcpe98FvVYim7dKlsp/tvOgkjHQjrY
 +o16LX9NXzcSZNO4xbJS211ppLsXhIcH34A2RUwciNiAQeRlSsXa9DzMY1jxdJzCSy4m
 r92NR9RjgfMz06HDJ7gw1fUSFNgXB4e3i4NJ6R4MZLY5vmpIyVDHb8jObavr20cZOgbR
 kRog==
X-Gm-Message-State: AOJu0Yzj4gvRFeAXiUX8CPOB4ljPKc5ds6EooK1OSMWhuo2kTwpbWEqq
 8vkjej0irKXKFgWyGROv7x3AtbWrNh02bKig+gg=
X-Google-Smtp-Source: AGHT+IE2Myeol+LTY4AshUMBPgL9I1pffQnj+QwZE2NaV+DNN0K09gZT6YrPRh3qLnEAbsO3WPpQLA==
X-Received: by 2002:a05:6a00:1949:b0:68a:5cf8:dae4 with SMTP id
 s9-20020a056a00194900b0068a5cf8dae4mr10429269pfk.3.1698888652796; 
 Wed, 01 Nov 2023 18:30:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 39/88] target/hppa: Remove TARGET_HPPA64
Date: Wed,  1 Nov 2023 18:29:27 -0700
Message-Id: <20231102013016.369010-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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


