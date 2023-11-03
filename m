Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD87E07A8
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:41:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8w-0005Pc-K9; Fri, 03 Nov 2023 13:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8P-0005Fb-6a
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8I-0003Zc-3R
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so21281345ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033135; x=1699637935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzmZAe300YPi4ndhKeOg8/gS+9pjI9UmQBGZdkogpCA=;
 b=iZov75pb1yjORVN+W4lZoHD7osw0gmAfsAL5pom7bS/tbSmDVzKleuGV+EMJ0JPJq0
 KPfQBEfsnjsZRo9G+kncgs4jPipiAXyGkVDJwvenkN2lrdfNQMOGwG+k5zkMuEJOmLNJ
 XyqVF06fYk5s2p9f3b+TcHF2SI8lPxHt2L5EQq+QxiORR6BorWPvFfgOuk1yZQKiFW4W
 oo1j71JpiEhPoSDlJJTKKHs0kws7PrZSDMPT5XUDveN3RHSnrOUSV7qGkP9XjyEt22UP
 cznxbri0R2IcotM8L76BlAN4SnPTrWcS3eT/RbNr5tXuIIlAGjYzcCNc9n/GdqLYKPSz
 JN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033135; x=1699637935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzmZAe300YPi4ndhKeOg8/gS+9pjI9UmQBGZdkogpCA=;
 b=u3gqB0V4kBU/703nIl9WdKw10ZJbl9kmG1+9gSNpd0BabTk2Br1XaDBpALVb4piPdr
 3LnR9s4w9YzoKa/Zu8PJp9o5RJDWjYgDBWDyGILFHxopzMkvp87Af6o83CFNsJLgGy5m
 0v5EKuW3pQWPo2aXHRIEKszBJK7vdGS9KUupE7fO7fvQd/jtSkT9+F0CsxDfz6sHbt26
 XwRWY/CC593/g5zTmYkBNBzyRiqXdy6a5On6tJW+C8lr/zl21kAmmcLHY/kE1viY5oYi
 bGmIjoDPkh9whJ+e5fYdXEhsofopzGmi8yyUoJkZcF/4ZxB84aMO38jEurrIavdApF/W
 P69w==
X-Gm-Message-State: AOJu0YwEgLeWVJIUQumUwNPsqtLJNrPWzE3cGyJ4ZP86xkhh/RT0QX1v
 WZ3iPRMIi6wzic39twXFU4wNA9+b2gjCb4XmIAg=
X-Google-Smtp-Source: AGHT+IED5IJidosnOChqhZ7uedc6CuDGMGlokfz0VknQsmX14H7CRXiuArBvYFBl5rvsMhzbM9vnww==
X-Received: by 2002:a17:902:da87:b0:1cc:548d:4252 with SMTP id
 j7-20020a170902da8700b001cc548d4252mr16775090plx.57.1699033135689; 
 Fri, 03 Nov 2023 10:38:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 16/22] target/split: Split ver from env->fsr
Date: Fri,  3 Nov 2023 10:38:35 -0700
Message-Id: <20231103173841.33651-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

This field is read-only.  It is easier to store it separately
and merge it only upon read.

While we're at it, use FSR_VER_SHIFT to initialize fpu_version.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h        |  3 +++
 target/sparc/cpu.c        | 27 +++++++++++++--------------
 target/sparc/fop_helper.c |  9 +++++++--
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 33c7d31fef..8ff222595e 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -191,6 +191,9 @@ enum {
 #define FSR_NXC   (1ULL << 0)
 #define FSR_CEXC_MASK (FSR_NVC | FSR_OFC | FSR_UFC | FSR_DZC | FSR_NXC)
 
+#define FSR_VER_SHIFT  17
+#define FSR_VER_MASK   (7 << FSR_VER_SHIFT)
+
 #define FSR_FTT2   (1ULL << 16)
 #define FSR_FTT1   (1ULL << 15)
 #define FSR_FTT0   (1ULL << 14)
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 69dfa1dd4e..bebfdbf313 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -368,7 +368,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "Fujitsu MB86904",
         .iu_version = 0x04 << 24, /* Impl 0, ver 4 */
-        .fpu_version = 4 << 17, /* FPU version 4 (Meiko) */
+        .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0x04 << 24, /* Impl 0, ver 4 */
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0x00ffffc0,
@@ -381,7 +381,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "Fujitsu MB86907",
         .iu_version = 0x05 << 24, /* Impl 0, ver 5 */
-        .fpu_version = 4 << 17, /* FPU version 4 (Meiko) */
+        .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0x05 << 24, /* Impl 0, ver 5 */
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -394,7 +394,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI MicroSparc I",
         .iu_version = 0x41000000,
-        .fpu_version = 4 << 17,
+        .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x41000000,
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0x007ffff0,
@@ -407,7 +407,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI MicroSparc II",
         .iu_version = 0x42000000,
-        .fpu_version = 4 << 17,
+        .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x02000000,
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0x00ffffc0,
@@ -420,7 +420,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI MicroSparc IIep",
         .iu_version = 0x42000000,
-        .fpu_version = 4 << 17,
+        .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x04000000,
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0x00ffffc0,
@@ -433,7 +433,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc 40", /* STP1020NPGA */
         .iu_version = 0x41000000, /* SuperSPARC 2.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x00000800, /* SuperSPARC 2.x, no MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -446,7 +446,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc 50", /* STP1020PGA */
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000800, /* SuperSPARC 3.x, no MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -459,7 +459,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc 51",
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000000, /* SuperSPARC 3.x, MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -473,7 +473,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc 60", /* STP1020APGA */
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000800, /* SuperSPARC 3.x, no MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -486,7 +486,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc 61",
         .iu_version = 0x44000000, /* SuperSPARC 3.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000000, /* SuperSPARC 3.x, MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -500,7 +500,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc II",
         .iu_version = 0x40000000, /* SuperSPARC II 1.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x08000000, /* SuperSPARC II 1.x, MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -514,7 +514,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "LEON2",
         .iu_version = 0xf2000000,
-        .fpu_version = 4 << 17, /* FPU version 4 (Meiko) */
+        .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0xf2000000,
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0x007ffff0,
@@ -527,7 +527,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "LEON3",
         .iu_version = 0xf3000000,
-        .fpu_version = 4 << 17, /* FPU version 4 (Meiko) */
+        .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0xf3000000,
         .mmu_bm = 0x00000000,
         .mmu_ctpr_mask = 0xfffffffc,
@@ -758,7 +758,6 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
 
     env->version = env->def.iu_version;
-    env->fsr = env->def.fpu_version;
     env->nwindows = env->def.nwindows;
 #if !defined(TARGET_SPARC64)
     env->mmuregs[0] |= env->def.mmu_version;
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 70b38011d2..22b412adb5 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -349,7 +349,12 @@ GEN_FCMP(fcmpeq_fcc3, float128, 26, 1);
 
 target_ulong cpu_get_fsr(CPUSPARCState *env)
 {
-    return env->fsr;
+    target_ulong fsr = env->fsr;
+
+    /* VER is kept completely separate until re-assembly. */
+    fsr |= env->def.fpu_version;
+
+    return fsr;
 }
 
 target_ulong helper_get_fsr(CPUSPARCState *env)
@@ -361,7 +366,7 @@ static void set_fsr_nonsplit(CPUSPARCState *env, target_ulong fsr)
 {
     int rnd_mode;
 
-    env->fsr = fsr;
+    env->fsr = fsr & ~FSR_VER_MASK;
 
     switch (fsr & FSR_RD_MASK) {
     case FSR_RD_NEAREST:
-- 
2.34.1


