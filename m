Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9EE82E290
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:27:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVP8-0000cQ-Vn; Mon, 15 Jan 2024 17:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVP6-0000bD-Nz
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:00 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVP5-00065q-3c
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:00 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d9af1f12d5so8001545b3a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705357557; x=1705962357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/bYy377eBAB8ujfxwt+DVHep63OPHeK0P6n1e/iX68=;
 b=Vav3GmjRgkXJwSaWLudvPqAKXJjdFE/fIOl/nJyKNFwEnDycuOnmlgA/SbOJtu/Xsm
 UzIfJiL4YX0cbF1VSPIT07QoAzZHtaPKMpTjGF3KPr59rW2VPiBLywCgUIsIY6piAfFh
 ZsIhmNQBU7y/aNAc+r0Q7CncEy5en8Y/gC99icdczitJN7r7bmJtMSVMzxdlhoQKB5HI
 /Much42Um4A3aiC7vPWmDVzQgDdHqCZ4uSF4+csPfQpNe5abtDd/7j9v9Wl1gZwm8Y/F
 +QhQBdSqozPGwag9gF0ItV/RzH88qSVHgTgrCoooS+XwxLtS4XBImnVEAkQ1mMyKuE0a
 NXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705357557; x=1705962357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c/bYy377eBAB8ujfxwt+DVHep63OPHeK0P6n1e/iX68=;
 b=X0QnDjhDWysbV+A6GpXgevObdmkMDXwE4GlrSqP8H3td50XJcBIwCDEiR/PdOFLI7g
 uWbx/T1B0LXdnf4Dn8xXoVrG+x+nRxbGAek38RpwTHNKx+MLfbKstP8EUE16qtZr5gQQ
 AGCEaeiotKTER4ZsOW3gEOd8maZpUFCKkenoLRSfKkG8doduATjX8k6KOQFnemdsP865
 hwcCR2dfFuy8/bs10zdtyq/Yr23Hs4TmGfH7BQD2BNNDyBhkmFSvyiTOYZDD5Aw9r3/J
 BXHwleVctsC/TeWrQG6gA0bAJ/p1em3baNC6aN/2xsi3pf7uQDVYLO73ynZMJFyUWfiK
 fm8A==
X-Gm-Message-State: AOJu0YyKPR8JgrGASgyo8UtOcQLSXudlVlsSiGjifyKt9ddGcvqEXA3T
 SvFK0zINxwpMr8UFHJt17Mmd2VW2Y8rW7NiB+0CBfYNfvz3I7g==
X-Google-Smtp-Source: AGHT+IHWwmlI0tVD1ma1PegEUkdASS4ig7dU46xONvvsVTHZGy4SJo3N6Os3aT26BjiJ+aBw+8qOwg==
X-Received: by 2002:a05:6a21:9207:b0:19a:fb32:2009 with SMTP id
 tl7-20020a056a21920700b0019afb322009mr3069499pzb.89.1705357557515; 
 Mon, 15 Jan 2024 14:25:57 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 ks19-20020a056a004b9300b006d977f70cd5sm8125940pfb.23.2024.01.15.14.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:25:57 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 07/12] target/riscv/vector_helper.c: use 'vlenb'
Date: Mon, 15 Jan 2024 19:25:23 -0300
Message-ID: <20240115222528.257342-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115222528.257342-1-dbarboza@ventanamicro.com>
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use 'cpu->cfg.vlenb' instead of 'cpu->cfg.vlen >> 3'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index c1c3a4d1ea..cb944229b0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -558,7 +558,7 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 {
     uint32_t i, k, off, pos;
     uint32_t nf = vext_nf(desc);
-    uint32_t vlenb = riscv_cpu_cfg(env)->vlen >> 3;
+    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
     uint32_t max_elems = vlenb >> log2_esz;
 
     k = env->vstart / max_elems;
@@ -929,7 +929,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
 {                                                             \
     uint32_t vl = env->vl;                                    \
     uint32_t vm = vext_vm(desc);                              \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;          \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;    \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t i;                                               \
                                                               \
@@ -967,7 +967,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
 {                                                               \
     uint32_t vl = env->vl;                                      \
     uint32_t vm = vext_vm(desc);                                \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;            \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;      \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                \
     uint32_t i;                                                 \
                                                                 \
@@ -1171,7 +1171,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
 {                                                             \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t vl = env->vl;                                    \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;          \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;    \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
@@ -1236,7 +1236,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
 {                                                                   \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;                \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;          \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                    \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
@@ -3971,7 +3971,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
 {                                                             \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t vl = env->vl;                                    \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;          \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;    \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
@@ -4011,7 +4011,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
 {                                                                   \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;                \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;          \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                    \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
@@ -4528,7 +4528,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                   uint32_t desc)                          \
 {                                                         \
     uint32_t vl = env->vl;                                \
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;      \
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;\
     uint32_t vta_all_1s = vext_vta_all_1s(desc);          \
     uint32_t i;                                           \
     int a, b;                                             \
@@ -4615,7 +4615,7 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
 {
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
-    uint32_t total_elems = riscv_cpu_cfg(env)->vlen;
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;
     uint32_t vta_all_1s = vext_vta_all_1s(desc);
     uint32_t vma = vext_vma(desc);
     int i;
-- 
2.43.0


