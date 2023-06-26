Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B902773E3A4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:41:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKU-0000Oi-34; Mon, 26 Jun 2023 11:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJp-0000Hf-CG
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:57 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJk-0002ng-Kq
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:57 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313e1c27476so1849027f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793988; x=1690385988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4ZERABmYQLNGRj/4+SUnFM7V6PLDkdMgWoOdwZzG5w=;
 b=V2brBXtF3J/hAG5bLaxT4caeDUKFTUiAz28VjlqH8oCofI4fia3W79SwGwjgEyMAJ6
 MpnHBhrKSUTb/z/U4sixfU9alUM2Ewu7P+roLuprErUEr8pVyhGX6KWJwA1VilIPRC3M
 FZPro2FMygAIs6CVt6cV0gQLMDMp+52LmegfXOGRRebnPxcj+tUbj+acgO410JDhcR41
 RS5AKC05N+VgPKe+EDeXVxXYRQrOYVGxsPvYXuLrJY2LGRinmYGd5T/0BjwkYNejVPjs
 Xo68U2qtVIQ1YdnvEu5BxAbPjZ8fNzUoDAYWloRF1Wnw3MGoNRUvGR7caVEXpuHApiwO
 Su2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793988; x=1690385988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4ZERABmYQLNGRj/4+SUnFM7V6PLDkdMgWoOdwZzG5w=;
 b=GxTMLA65ATPEA99BvQEGt3aGTZ1JUEva1fKm3lf6z9WODtFd1Hw52oooS4lyGm8DBj
 Qe5Kx45aje9b/gxOr2VPetZQCV6ZPcZIDYFxxm97vnjn8FbAIEPN4wadde8Ij+hCa9Sa
 IuJVy9J4HogJtSxdEj8IG9+ed/MFke5zz3OHcK4ktLYLjPdDBfQ99ORUjUIG5QW0Asx2
 kdwkqkALHETIqPOekOzddJ2dqixTmi4l3b8WqlTUpZ7zNzAgI7ecI4KwGip5LXaQ1S46
 xqMP8Kc21HX4t8ufeo4kufhJd7LDOKen8vSvLGA6LvIJjQ8si+CQyaaEzsEWsJsxLg7Q
 m0kQ==
X-Gm-Message-State: AC+VfDzxroZmFn4H9+v5a4NBNODCVnHnk3HQYHIoXj8mPGZdMepNBqpe
 YQS/8/7Pk6g4jUPuy2y7STrKe432BAGb8+MdVY2RNW1c
X-Google-Smtp-Source: ACHHUZ5XeNSpCC0o1mIG4K8I8jkzbF9hzHLAU3uTOTcM7V61R4nhTeTHSdb+pa9GrcnUhtcMjjVgXw==
X-Received: by 2002:adf:e7d0:0:b0:30a:8e6a:3d77 with SMTP id
 e16-20020adfe7d0000000b0030a8e6a3d77mr28188924wrn.1.1687793987966; 
 Mon, 26 Jun 2023 08:39:47 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 02/22] accel/tcg/translate-all.c: Widen pc and cs_base
Date: Mon, 26 Jun 2023 17:39:25 +0200
Message-Id: <20230626153945.76180-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Anton Johansson <anjo@rev.ng>

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621135633.1649-3-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal.h      |  6 +++---
 accel/tcg/translate-all.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
index 65380ccb42..91f308bdfa 100644
--- a/accel/tcg/internal.h
+++ b/accel/tcg/internal.h
@@ -42,8 +42,8 @@ void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_SOFTMMU */
 
-TranslationBlock *tb_gen_code(CPUState *cpu, target_ulong pc,
-                              target_ulong cs_base, uint32_t flags,
+TranslationBlock *tb_gen_code(CPUState *cpu, vaddr pc,
+                              uint64_t cs_base, uint32_t flags,
                               int cflags);
 void page_init(void);
 void tb_htable_init(void);
@@ -55,7 +55,7 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc);
 
 /* Return the current PC from CPU, which may be cached in TB. */
-static inline target_ulong log_pc(CPUState *cpu, const TranslationBlock *tb)
+static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
 {
     if (tb_cflags(tb) & CF_PCREL) {
         return cpu->cc->get_pc(cpu);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c4d081f5ad..03caf62459 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -274,7 +274,7 @@ void page_init(void)
  * Return the size of the generated code, or negative on error.
  */
 static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
-                           target_ulong pc, void *host_pc,
+                           vaddr pc, void *host_pc,
                            int *max_insns, int64_t *ti)
 {
     int ret = sigsetjmp(tcg_ctx->jmp_trans, 0);
@@ -302,7 +302,7 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
 
 /* Called with mmap_lock held for user mode emulation.  */
 TranslationBlock *tb_gen_code(CPUState *cpu,
-                              target_ulong pc, target_ulong cs_base,
+                              vaddr pc, uint64_t cs_base,
                               uint32_t flags, int cflags)
 {
     CPUArchState *env = cpu->env_ptr;
@@ -634,10 +634,10 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | CF_LAST_IO | n;
 
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
-        target_ulong pc = log_pc(cpu, tb);
+        vaddr pc = log_pc(cpu, tb);
         if (qemu_log_in_addr_range(pc)) {
-            qemu_log("cpu_io_recompile: rewound execution of TB to "
-                     TARGET_FMT_lx "\n", pc);
+            qemu_log("cpu_io_recompile: rewound execution of TB to %"
+                     VADDR_PRIx "\n", pc);
         }
     }
 
-- 
2.34.1


