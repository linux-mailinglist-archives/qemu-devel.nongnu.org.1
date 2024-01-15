Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C220D82DAE2
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPNXs-0007kW-Kq; Mon, 15 Jan 2024 09:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@0x0f.com>) id 1rPK1X-0007iA-Pr
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:55 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daniel@0x0f.com>) id 1rPK1U-0007RO-QY
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:55 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-28c0d8dd88bso5646010a91.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 02:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1705313810; x=1705918610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KSWRvjdunXVculkFnNEyuJu0w7WiR/OJ/9EgypgZ8rs=;
 b=uGReKK/iVUZePUbKJniaZ+Xen4F1csMbVsQ9iKSoAtR5h0y9suSi4wwn3OrPZraKWA
 +y3SANUjjV9gGgyiWnXsXdK2n98QYDHFQolFc7kzyrexxdymv0a0/WTiH4S+QseKSdQN
 vk2LrdM7TbsOfJ9dgWX53sLZR2xTDEkuVFeHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705313810; x=1705918610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KSWRvjdunXVculkFnNEyuJu0w7WiR/OJ/9EgypgZ8rs=;
 b=B6zgYZYRGSM8c7LCuOOfV78Iz50bZpv1/dqd8R/xuGd2LrOAfym3UrjVoIRKbsLxKI
 xYxpPuJGTUqxPXoK39TjruH5ePJ3qgYP+O7DEyW8MTO2q7onz+fluT3m9zJvyVCBdhMd
 FjclMNI2DDAeuQPeWxa1ay5+iYWFbH2fK9qgbzCdXfJWtUaghcVOwuUgbV2Yqf4MZ1Ek
 2GLF3BJTnLQ/KX209Su4eeXDaPi4BOAoxxqkt59Pip35a8Er6pF+N5DjI8zh+xzxMdn3
 LJrvdMfsGJl/Kdo+/d/u+6Q80ntm4gSP161hPj3e/gF/QfL5v6cP7m6rgeABdv8xVRhO
 Aafw==
X-Gm-Message-State: AOJu0YwlBo+WjTqfNq5TgIWJkzS7iJ24pJDs5/vg14ujPMd6XvhTAohK
 +3JpCNMYBOXGo3w7E1OuDvz2fy2l2F3rZPLBO/1xOhbSkgU=
X-Google-Smtp-Source: AGHT+IEEBbjTH/wtfi7IyIHNj0IQ7No+TBrRvcMO66Se6BBejPxiiTKNKsa2SgNJh15pg5OVFWllpA==
X-Received: by 2002:a17:90a:8047:b0:28c:3b34:f343 with SMTP id
 e7-20020a17090a804700b0028c3b34f343mr2339638pjw.55.1705313809794; 
 Mon, 15 Jan 2024 02:16:49 -0800 (PST)
Received: from shiro.work.home.arpa ([2400:4162:2428:2ffe:81d7:ea6b:d9c6:ef79])
 by smtp.googlemail.com with ESMTPSA id
 se3-20020a17090b518300b00274b035246esm7767855pjb.1.2024.01.15.02.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 02:16:48 -0800 (PST)
From: Daniel Palmer <daniel@0x0f.com>
To: laurent@vivier.eu
Cc: qemu-devel@nongnu.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] target/m68k: Fix exception frame format for 68010
Date: Mon, 15 Jan 2024 19:16:42 +0900
Message-ID: <20240115101643.2165387-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=daniel@0x0f.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Jan 2024 09:02:29 -0500
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

From the 68010 a word with the frame format and exception vector
are placed on the stack before the PC and SR.

M68K_FEATURE_QUAD_MULDIV is currently checked to workout if to do
this or not for the configured CPU but that flag isn't set for
68010 so currently the exception stack when 68010 is configured
is incorrect.

It seems like checking M68K_FEATURE_MOVEFROMSR_PRIV would do but
adding a new flag that shows exactly what is going on here is
maybe clearer.

Add a new flag for the behaviour, M68K_FEATURE_EXCEPTION_FORMAT_VEC,
and set it for 68010 and above, and then use it to control if the
format and vector word are pushed/pop during exception entry/exit.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 target/m68k/cpu.c       | 4 +++-
 target/m68k/cpu.h       | 2 ++
 target/m68k/op_helper.c | 4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1421e77c2c07..20718944b4c8 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -137,7 +137,8 @@ static void m68000_cpu_initfn(Object *obj)
 }
 
 /*
- * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD
+ * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD,
+ *      format+vector in exception frame.
  */
 static void m68010_cpu_initfn(Object *obj)
 {
@@ -150,6 +151,7 @@ static void m68010_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_BKPT);
     m68k_set_feature(env, M68K_FEATURE_MOVEC);
     m68k_set_feature(env, M68K_FEATURE_MOVEFROMSR_PRIV);
+    m68k_set_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC);
 }
 
 /*
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d13427b0fe61..0fc591e618f6 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -549,6 +549,8 @@ enum m68k_features {
     M68K_FEATURE_TRAPCC,
     /* MOVE from SR privileged (from 68010) */
     M68K_FEATURE_MOVEFROMSR_PRIV,
+    /* Exception frame with format+vector (from 68010) */
+    M68K_FEATURE_EXCEPTION_FORMAT_VEC,
 };
 
 static inline bool m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 1ce850bbc594..b09771672dec 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -52,7 +52,7 @@ throwaway:
     sp += 2;
     env->pc = cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
     sp += 4;
-    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
+    if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
         /*  all except 68000 */
         fmt = cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
         sp += 2;
@@ -256,7 +256,7 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
                                   uint16_t format, uint16_t sr,
                                   uint32_t addr, uint32_t retaddr)
 {
-    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
+    if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
         /*  all except 68000 */
         CPUState *cs = env_cpu(env);
         switch (format) {
-- 
2.43.0


