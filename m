Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB31A9C85D4
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Nov 2024 10:15:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVvq-00006G-H8; Thu, 14 Nov 2024 04:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvD-0008I6-Kg
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:52 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvA-0007gT-7G
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d462c91a9so294082f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 01:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731575627; x=1732180427;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwIuN+J3+bzup2NaOf8IKQF5a5sBeZ+ThACkLSBKsdk=;
 b=ktjc1JS2vTGXS1o/SYNGxLHL6KMdLxlBnEbr+ekVuqQj3ZRvQQ4sI7fI4tZH8096s5
 NZb2FmHDTZJ6vf1nzbBi9lnqxOQbETlREErZxtXXH4SQ9t0I6/er4dOMLX/MPuLl48qu
 i5qyEnvJArDzYTdYGka8gvlRp6neY4R/NvQMf2KSCpbZE00E+IZGLpExq0kpfYw29iiV
 8y0yCOK2Si/0RnlxbPcmzviKtRAbI6/qPfDCpgBO22Yc9isoNHmZNTu29rDZC7nsZrUX
 GwwY9DpNXtOsVfVfNWAyemByM6KdVVRJwP3j8MoGHKYNgHk0ay8qLpUh04sHuL9KhTSF
 MqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731575627; x=1732180427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwIuN+J3+bzup2NaOf8IKQF5a5sBeZ+ThACkLSBKsdk=;
 b=RhJ9hCL+ngKnij+tKRaI5H618nB2EwQqSZ4Aj1PFQNtDd5l0tAVepELc3bbnCId4g9
 7OFNC6UZqVsxsepDcXMjxaarny6Zw9l4PuOP9ybVXN5jOgjg8FZc0mH8tV4egNpBlQMo
 0ZTVZ/Vfs8TY6jK6F8HXhoz+a17wKAr+f6fabeUPvxHwd2LlkH1mdk8Nh0+EumfgJG09
 1BBCBbLICXHNE9bE8tCruJYLZmW4PY6mnjgLB78beo6k8P7k6POGOPs8IPBVm0AfHkjQ
 gZjX6eGgpxVBXMU0gPCjQNn5rgGmBsGpy34izWFYVwOwxr/MrEwHtaRYxg3R1S6fKjIy
 TueQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKAjjgnrCt3A4L5GPlIenoz6hJuvPh/eA6dqbyPwZIun1UBejZfwtDgSb2lRG3A6kOJNKU5SRhwY3P@nongnu.org
X-Gm-Message-State: AOJu0YyDZxBJUdS6hlhhgqHkx9sCTgnYUPIOUNKej5eUtNBrOG0wfdOk
 flBFxEo6B3vXFAIjH0/ej8uiyUxbPCGqV4fCnfkwOyJl8ZtIPhwGKFTRDLKelhs=
X-Google-Smtp-Source: AGHT+IG2QlQXLwSlFrWfUBOuz6VZJ2rI+ELe1TPnuRdPTlkw+gnDWl3BUF9BnNS18hECoSGMaBmpaQ==
X-Received: by 2002:a05:6000:2b08:b0:382:1e06:fb0 with SMTP id
 ffacd0b85a97d-3821e0612ecmr316365f8f.56.1731575626746; 
 Thu, 14 Nov 2024 01:13:46 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae313e3sm899050f8f.94.2024.11.14.01.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 01:13:46 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 3/9] target/riscv: Implement Ssdbltrp sret,
 mret and mnret behavior
Date: Thu, 14 Nov 2024 10:13:24 +0100
Message-ID: <20241114091332.108811-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114091332.108811-1-cleger@rivosinc.com>
References: <20241114091332.108811-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When the Ssdbltrp extension is enabled, SSTATUS.SDT field is cleared
when executing sret. When executing mret/mnret, SSTATUS.SDT is cleared
when returning to U, VS or VU and VSSTATUS.SDT is cleared when returning
to VU from HS.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 180886f32a..dabc74de39 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -287,6 +287,18 @@ target_ulong helper_sret(CPURISCVState *env)
                         get_field(mstatus, MSTATUS_SPIE));
     mstatus = set_field(mstatus, MSTATUS_SPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
+
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        if (riscv_has_ext(env, RVH)) {
+            target_ulong prev_vu = get_field(env->hstatus, HSTATUS_SPV) &&
+                                   prev_priv == PRV_U;
+            /* Returning to VU from HS, vsstatus.sdt = 0 */
+            if (!env->virt_enabled && prev_vu) {
+                env->vsstatus = set_field(env->vsstatus, MSTATUS_SDT, 0);
+            }
+        }
+        mstatus = set_field(mstatus, MSTATUS_SDT, 0);
+    }
     if (env->priv_ver >= PRIV_VERSION_1_12_0) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -297,7 +309,6 @@ target_ulong helper_sret(CPURISCVState *env)
         target_ulong hstatus = env->hstatus;
 
         prev_virt = get_field(hstatus, HSTATUS_SPV);
-
         hstatus = set_field(hstatus, HSTATUS_SPV, 0);
 
         env->hstatus = hstatus;
@@ -328,6 +339,22 @@ static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
         riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
     }
 }
+static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
+                                   target_ulong prev_priv,
+                                   target_ulong prev_virt)
+{
+    /* If returning to U, VS or VU, sstatus.sdt = 0 */
+    if (prev_priv == PRV_U || (prev_virt &&
+        (prev_priv == PRV_S || prev_priv == PRV_U))) {
+        mstatus = set_field(mstatus, MSTATUS_SDT, 0);
+        /* If returning to VU, vsstatus.sdt = 0 */
+        if (prev_virt && prev_priv == PRV_U) {
+            env->vsstatus = set_field(env->vsstatus, MSTATUS_SDT, 0);
+        }
+    }
+
+    return mstatus;
+}
 
 target_ulong helper_mret(CPURISCVState *env)
 {
@@ -345,6 +372,9 @@ target_ulong helper_mret(CPURISCVState *env)
     mstatus = set_field(mstatus, MSTATUS_MPP,
                         riscv_has_ext(env, RVU) ? PRV_U : PRV_M);
     mstatus = set_field(mstatus, MSTATUS_MPV, 0);
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mstatus = ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -378,6 +408,9 @@ target_ulong helper_mnret(CPURISCVState *env)
     if (prev_priv < PRV_M) {
         env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, false);
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        env->mstatus = ssdbltrp_mxret(env, env->mstatus, prev_priv, prev_virt);
+    }
 
     if (riscv_has_ext(env, RVH) && prev_virt) {
         riscv_cpu_swap_hypervisor_regs(env);
-- 
2.45.2


