Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A9705803
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:53:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0ex-0003Q1-NK; Tue, 16 May 2023 15:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cI-0000Lr-GB
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:52 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cD-0003hv-Cw
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:48 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so13458148a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266342; x=1686858342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JyxwW/97nzLH4qcsKUT7VsDKiOxHavIc9pVCUEzi9E=;
 b=Okfajnhe5xsCo2ySERBG1mGCTK9C7gMSpcB0EDrEWAyV7TilI/k6vev0j5YIQNNJRU
 6J71ahXbvOpZRbxG3iC6LoZPJoA8TmGuKS58Jk2Lk6f5vzN3EDlnvozWqdNKMKPYD0AC
 b5w0073sH/nZMrh6kjrR+40SOwA1ARWlUjp2yKLjQHWpB4npIm+KJVOTrdv0V9VFiFXT
 cWVztUnJtBir++pU9z0fiDm4+tiGtFQBKs0RRC7PsqmdcoOk1num31cRI5BwvamvApsW
 cQoXnIRTzI16MNuS3J/YH6LjkXYxl+yCiCsDhQ9Lg1Zi1OBDgnYTK7fzaa8+Ci2ws2so
 BQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266342; x=1686858342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JyxwW/97nzLH4qcsKUT7VsDKiOxHavIc9pVCUEzi9E=;
 b=YcPFJNsD+GSPwtyzqca3YpWQ9MZ88vGrhoJJfPOY1yu0/HNZki4jbEjwYUBhBuv7RK
 z03Ivz2lxde0eXWkpmTy10vADRG5plJ3hhJsUXo0YPPm3XJMoiYTmy+PoGIMjAyioTKV
 lGfmO+nB4Npt0hV1GbouroLLE19bOKqpAAZu7aeGzE++KhjKNwKbg+JX4j6nxvRJTrA5
 1jOQSH2G2zlSKs1wpkyMueh8+Gt6xcICCCtTpF+9fpL08vGKNLBWyMTW8BqlxIH1r+yc
 elgMlMnfsEErnxNH45dVcohiJzwWG87zDsD2gWiApQ04J3ZM6Wtaoy+5tT3Xljilysjd
 QCIA==
X-Gm-Message-State: AC+VfDwBpg5W2nDpiCgaDsAL4Ydx2iSWlgEWiIa5KsQHNy8ZyTUh7rIk
 XEPbXeVqRL02F/CVWRrgUyQGGDP3lwzF6L+lGTo=
X-Google-Smtp-Source: ACHHUZ5owIABSNWKcP4R4FsfLtBwYgHKDBFOFmc4W/6u0F3U76fGm+EON7UTkmvJ2dXukiphi8p3wQ==
X-Received: by 2002:a17:90a:3ec2:b0:253:3b17:de90 with SMTP id
 k60-20020a17090a3ec200b002533b17de90mr924968pjc.21.1684266342104; 
 Tue, 16 May 2023 12:45:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 62/80] accel/tcg: Widen plugin_gen_empty_mem_callback to i64
Date: Tue, 16 May 2023 12:41:27 -0700
Message-Id: <20230516194145.1749305-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Since we do this inside gen_empty_mem_cb anyway, let's
do this earlier inside tcg expansion.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/plugin-gen.h |  4 ++--
 accel/tcg/plugin-gen.c    |  9 +++------
 tcg/tcg-op-ldst.c         | 28 ++++++++++++++++++++--------
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index 5f5506f1cc..3af0168e65 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -27,7 +27,7 @@ void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db);
 void plugin_gen_insn_end(void);
 
 void plugin_gen_disable_mem_helpers(void);
-void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info);
+void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info);
 
 static inline void plugin_insn_append(abi_ptr pc, const void *from, size_t size)
 {
@@ -69,7 +69,7 @@ static inline void plugin_gen_tb_end(CPUState *cpu)
 static inline void plugin_gen_disable_mem_helpers(void)
 { }
 
-static inline void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info)
+static inline void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info)
 { }
 
 static inline void plugin_insn_append(abi_ptr pc, const void *from, size_t size)
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 907c5004a4..34be1b940c 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -124,23 +124,20 @@ static void gen_empty_inline_cb(void)
     tcg_temp_free_i64(val);
 }
 
-static void gen_empty_mem_cb(TCGv addr, uint32_t info)
+static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     TCGv_i32 meminfo = tcg_temp_ebb_new_i32();
-    TCGv_i64 addr64 = tcg_temp_ebb_new_i64();
     TCGv_ptr udata = tcg_temp_ebb_new_ptr();
 
     tcg_gen_movi_i32(meminfo, info);
     tcg_gen_movi_ptr(udata, 0);
     tcg_gen_ld_i32(cpu_index, cpu_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    tcg_gen_extu_tl_i64(addr64, addr);
 
-    gen_helper_plugin_vcpu_mem_cb(cpu_index, meminfo, addr64, udata);
+    gen_helper_plugin_vcpu_mem_cb(cpu_index, meminfo, addr, udata);
 
     tcg_temp_free_ptr(udata);
-    tcg_temp_free_i64(addr64);
     tcg_temp_free_i32(meminfo);
     tcg_temp_free_i32(cpu_index);
 }
@@ -197,7 +194,7 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
     }
 }
 
-void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info)
+void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info)
 {
     enum qemu_plugin_mem_rw rw = get_plugin_meminfo_rw(info);
 
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index b695d2954e..2d5e98971d 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -115,13 +115,13 @@ static void tcg_gen_req_mo(TCGBar type)
 }
 
 /* Only required for loads, where value might overlap addr. */
-static TCGv plugin_maybe_preserve_addr(TCGv vaddr)
+static TCGv_i64 plugin_maybe_preserve_addr(TCGv vaddr)
 {
 #ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
         /* Save a copy of the vaddr for use after a load.  */
-        TCGv temp = tcg_temp_new();
-        tcg_gen_mov_tl(temp, vaddr);
+        TCGv_i64 temp = tcg_temp_ebb_new_i64();
+        tcg_gen_extu_tl_i64(temp, vaddr);
         return temp;
     }
 #endif
@@ -129,16 +129,28 @@ static TCGv plugin_maybe_preserve_addr(TCGv vaddr)
 }
 
 static void
-plugin_gen_mem_callbacks(TCGv copy_addr, TCGv orig_addr, MemOpIdx oi,
+plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGv orig_addr, MemOpIdx oi,
                          enum qemu_plugin_mem_rw rw)
 {
 #ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
         qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
-        plugin_gen_empty_mem_callback(copy_addr ? : orig_addr, info);
+
+#if TARGET_LONG_BITS == 64
         if (copy_addr) {
-            tcg_temp_free(copy_addr);
+            plugin_gen_empty_mem_callback(copy_addr, info);
+            tcg_temp_free_i64(copy_addr);
+        } else {
+            plugin_gen_empty_mem_callback(orig_addr, info);
         }
+#else
+        if (!copy_addr) {
+            copy_addr = tcg_temp_ebb_new_i64();
+            tcg_gen_extu_tl_i64(copy_addr, orig_addr);
+        }
+        plugin_gen_empty_mem_callback(copy_addr, info);
+        tcg_temp_free_i64(copy_addr);
+#endif
     }
 #endif
 }
@@ -147,7 +159,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
 {
     MemOp orig_memop;
     MemOpIdx oi;
-    TCGv copy_addr;
+    TCGv_i64 copy_addr;
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
@@ -223,7 +235,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
 {
     MemOp orig_memop;
     MemOpIdx oi;
-    TCGv copy_addr;
+    TCGv_i64 copy_addr;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
-- 
2.34.1


