Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 140A792E938
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jul 2024 15:21:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthd-0003EJ-Pv; Thu, 11 Jul 2024 09:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthC-0001UN-My
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:50 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-00063L-2p
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:50 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ee98947f70so9094821fa.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703909; x=1721308709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qkQTHfpLx+pnlRm5hp2Jitmb5noDyDl+EjdoK4FsOFE=;
 b=P1/q3+9mf24lXJrFbtT3qkcNCNYfkEOCYKkofbWHwnrBrBVbbAjmVjwy4Fsw2NkbhH
 j1OSnnvVvoYw3jTz4RLKNAuU73Ck6oUqyt0ZqMyjbdFms0XOqXaxtKV3OvjJbj31+sg5
 Gn8EG/V+cm+BajEuQUusk+Od6Q/ubfYkVS7D0GnJpJE+MOfX9Gri7wOOhQBeDyfyDBON
 BQ/qjWQDOEnW1ZMMhOHtdiXDCk4jJGxFFMoVn/AhZWkeIqA7ErIhq5sEi3S2dNGezLhB
 bCJ8SpDwus2TBTS6x3DmZKqXu9g69XKkbbpV1YI4/GXr+mQFJqLeAlh+0zZPW+wRmAep
 HC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703909; x=1721308709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qkQTHfpLx+pnlRm5hp2Jitmb5noDyDl+EjdoK4FsOFE=;
 b=EUSskGNih3fVtXXMDQcCwvYYcZox7Y7zCXvtIuY87GfsKqfFMWJwWmL7VPQC5hZ8Hd
 sBRRpxesCyezRnYOdjFY8yd0pyasBV/2t448Zm+qQlDpZ5jkxawK1KD/XvLWuRtJsKXQ
 H2iSjhfi0bVfGZAb6buktfynsgiKk/tFNoytiHR1+8MJAJJwbFC/t36IkKOQxma6Kcos
 oFoNWIyQlVgsvECZpg/1P7zL0aFKoiWA4PiYsywJerUI5aUtiBFk2EKoh7KxqnFK/fCa
 NpTgreO9xqePBEahsFVOShnkqqpgslUIfyLbwE9FyegzlnX4sBntGLiHn6BA1MiefUkC
 F/yg==
X-Gm-Message-State: AOJu0Yx9WR5snKwSBX3mALdkJ5rwFKJzFVn0TihwiHhWlmIgPEWZpuMX
 nt2t0aRgJvI27G/4oSJF3xRIieZHnf6XKvTp31PUPbXGScFb9kfezJM3n/ZEOJDmId+Y9BCEfOn
 RkJU=
X-Google-Smtp-Source: AGHT+IH2TZJ5YwHxfrKq0ta8iApn18TcedV42pO+j/lD52Jrahb+XZqL7Ns0SqtH6Frl5jzc4ThLxA==
X-Received: by 2002:a2e:9e06:0:b0:2ee:8d07:3d51 with SMTP id
 38308e7fff4ca-2eeb3197b9amr49034251fa.49.1720703908843; 
 Thu, 11 Jul 2024 06:18:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/24] target/arm: Rename FPSR_MASK and FPCR_MASK and define
 them symbolically
Date: Thu, 11 Jul 2024 14:18:06 +0100
Message-Id: <20240711131822.3909903-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

Now that we store FPSR and FPCR separately, the FPSR_MASK and
FPCR_MASK macros are slightly confusingly named and the comment
describing them is out of date.  Rename them to FPSCR_FPSR_MASK and
FPSCR_FPCR_MASK, document that they are the mask of which FPSCR bits
are architecturally mapped to which AArch64 register, and define them
symbolically rather than as hex values.  (This latter requires
defining some extra macros for bits which we haven't previously
defined.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240628142347.1283015-9-peter.maydell@linaro.org
---
 target/arm/cpu.h        | 41 ++++++++++++++++++++++++++++++++++-------
 target/arm/machine.c    |  3 ++-
 target/arm/vfp_helper.c |  7 ++++---
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c75b0a73aec..4c656bdbb76 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1687,15 +1687,19 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 uint32_t vfp_get_fpscr(CPUARMState *env);
 void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 
-/* FPCR, Floating Point Control Register
- * FPSR, Floating Poiht Status Register
+/*
+ * FPCR, Floating Point Control Register
+ * FPSR, Floating Point Status Register
  *
- * For A64 the FPSCR is split into two logically distinct registers,
- * FPCR and FPSR. However since they still use non-overlapping bits
- * we store the underlying state in fpscr and just mask on read/write.
+ * For A64 floating point control and status bits are stored in
+ * two logically distinct registers, FPCR and FPSR. We store these
+ * in QEMU in vfp.fpcr and vfp.fpsr.
+ * For A32 there was only one register, FPSCR. The bits are arranged
+ * such that FPSCR bits map to FPCR or FPSR bits in the same bit positions,
+ * so we can use appropriate masking to handle FPSCR reads and writes.
+ * Note that the FPCR has some bits which are not visible in the
+ * AArch32 view (for FEAT_AFP). Writing the FPSCR leaves these unchanged.
  */
-#define FPSR_MASK 0xf800009f
-#define FPCR_MASK 0x07ff9f00
 
 /* FPCR bits */
 #define FPCR_IOE    (1 << 8)    /* Invalid Operation exception trap enable */
@@ -1704,7 +1708,9 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPCR_UFE    (1 << 11)   /* Underflow exception trap enable */
 #define FPCR_IXE    (1 << 12)   /* Inexact exception trap enable */
 #define FPCR_IDE    (1 << 15)   /* Input Denormal exception trap enable */
+#define FPCR_LEN_MASK (7 << 16) /* LEN, A-profile only */
 #define FPCR_FZ16   (1 << 19)   /* ARMv8.2+, FP16 flush-to-zero */
+#define FPCR_STRIDE_MASK (3 << 20) /* Stride */
 #define FPCR_RMODE_MASK (3 << 22) /* Rounding mode */
 #define FPCR_FZ     (1 << 24)   /* Flush-to-zero enable bit */
 #define FPCR_DN     (1 << 25)   /* Default NaN enable bit */
@@ -1714,16 +1720,37 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPCR_LTPSIZE_MASK (7 << FPCR_LTPSIZE_SHIFT)
 #define FPCR_LTPSIZE_LENGTH 3
 
+/* Cumulative exception trap enable bits */
+#define FPCR_EEXC_MASK (FPCR_IOE | FPCR_DZE | FPCR_OFE | FPCR_UFE | FPCR_IXE | FPCR_IDE)
+
 /* FPSR bits */
+#define FPSR_IOC    (1 << 0)    /* Invalid Operation cumulative exception */
+#define FPSR_DZC    (1 << 1)    /* Divide by Zero cumulative exception */
+#define FPSR_OFC    (1 << 2)    /* Overflow cumulative exception */
+#define FPSR_UFC    (1 << 3)    /* Underflow cumulative exception */
+#define FPSR_IXC    (1 << 4)    /* Inexact cumulative exception */
+#define FPSR_IDC    (1 << 7)    /* Input Denormal cumulative exception */
 #define FPSR_QC     (1 << 27)   /* Cumulative saturation bit */
 #define FPSR_V      (1 << 28)   /* FP overflow flag */
 #define FPSR_C      (1 << 29)   /* FP carry flag */
 #define FPSR_Z      (1 << 30)   /* FP zero flag */
 #define FPSR_N      (1 << 31)   /* FP negative flag */
 
+/* Cumulative exception status bits */
+#define FPSR_CEXC_MASK (FPSR_IOC | FPSR_DZC | FPSR_OFC | FPSR_UFC | FPSR_IXC | FPSR_IDC)
+
 #define FPSR_NZCV_MASK (FPSR_N | FPSR_Z | FPSR_C | FPSR_V)
 #define FPSR_NZCVQC_MASK (FPSR_NZCV_MASK | FPSR_QC)
 
+/* A32 FPSCR bits which architecturally map to FPSR bits */
+#define FPSCR_FPSR_MASK (FPSR_NZCVQC_MASK | FPSR_CEXC_MASK)
+/* A32 FPSCR bits which architecturally map to FPCR bits */
+#define FPSCR_FPCR_MASK (FPCR_EEXC_MASK | FPCR_LEN_MASK | FPCR_FZ16 | \
+                         FPCR_STRIDE_MASK | FPCR_RMODE_MASK | \
+                         FPCR_FZ | FPCR_DN | FPCR_AHP)
+/* These masks don't overlap: each bit lives in only one place */
+QEMU_BUILD_BUG_ON(FPSCR_FPSR_MASK & FPSCR_FPCR_MASK);
+
 /**
  * vfp_get_fpsr: read the AArch64 FPSR
  * @env: CPU context
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 8c820955d95..a3c1e05e65d 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -43,7 +43,8 @@ static bool vfp_fpcr_fpsr_needed(void *opaque)
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
 
-    return (vfp_get_fpcr(env) & ~FPCR_MASK) || (vfp_get_fpsr(env) & ~FPSR_MASK);
+    return (vfp_get_fpcr(env) & ~FPSCR_FPCR_MASK) ||
+        (vfp_get_fpsr(env) & ~FPSCR_FPSR_MASK);
 }
 
 static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 85e50ede373..cbe69ae3fe3 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -202,7 +202,8 @@ uint32_t vfp_get_fpsr(CPUARMState *env)
 
 uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
 {
-    return (vfp_get_fpcr(env) & FPCR_MASK) | (vfp_get_fpsr(env) & FPSR_MASK);
+    return (vfp_get_fpcr(env) & FPSCR_FPCR_MASK) |
+        (vfp_get_fpsr(env) & FPSCR_FPSR_MASK);
 }
 
 uint32_t vfp_get_fpscr(CPUARMState *env)
@@ -280,8 +281,8 @@ void vfp_set_fpcr(CPUARMState *env, uint32_t val)
 
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 {
-    vfp_set_fpcr(env, val & FPCR_MASK);
-    vfp_set_fpsr(env, val & FPSR_MASK);
+    vfp_set_fpcr(env, val & FPSCR_FPCR_MASK);
+    vfp_set_fpsr(env, val & FPSCR_FPSR_MASK);
 }
 
 void vfp_set_fpscr(CPUARMState *env, uint32_t val)
-- 
2.34.1


