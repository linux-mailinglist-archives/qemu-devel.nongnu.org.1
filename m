Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B02A787B5F
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 00:18:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZIc3-00083x-V0; Thu, 24 Aug 2023 18:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIby-0007xq-3x
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:30 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbv-0006M1-KE
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:29 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1c4c6717e61so219816fac.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692915326; x=1693520126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Pp4ENyA0zcCPmi/i3KrxCgSFMVQIQHcjUoqi5MpawE=;
 b=doEKNz294E9Qd/kxDBFDgf33R/wTwT6jNkNHmmjGPyIQV+DTyMtZKpfYH+VZ7zCjwJ
 4i3m+HYWkFNNUYqHPbykIlsuIxVGMXGDjgWF6fDpk0uriGmYs4o4KYkO0BPwwt836noR
 iwjnrNT4yCsA7jQ2oo8rt+OEV7IS1MbgmtXr3JtNbR/acEghdfOD40bCun1LZh9/aSbm
 lvWQizcotcBzR0Uxe82H2zKFBSZjVFKwYzAkNzOssz41vGMszsv79tWxbExj4fH6wRyE
 7YNAeC09z9VXtMakJC3B6bgHL2xbRrOfYbh9PUPE7wFA0i7yjxzQK5w3tTl7DaCylOh6
 UkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692915326; x=1693520126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Pp4ENyA0zcCPmi/i3KrxCgSFMVQIQHcjUoqi5MpawE=;
 b=Cqd93AT8lpXbd9ReBQsaYyYEP73DMjRqFIxMY2wflkzRVkfb0CHbmergb8FCYUluRc
 WIb+dmNpj8KjeFIrAptpAATvuWE6ItySbRm7zGekIAZS2e346v6EEptiYhO8XESqRtm9
 HOEl7Owr+Fg+IVXyJoIIMkcdhpcMYjSfBUXpFemxk00y9JCs/5Dx6DAUAu/69xy4r8fO
 IgPRjkckpw7jVzKuHPfHvjj04aft2tWrLM0GCFB2Lidj2AT+l/9gMInQZ8r6yD5nMNBu
 i+xja6/V/c/23oP/g9whaUAsVhf7kywb55H6R9NWEPKtzkckEvyqZGLcCvZ4wxeE596f
 6CEw==
X-Gm-Message-State: AOJu0YwZ83zAUbC1KLheswTD1mnOOZUh19BEsx6czkEqwOskE8UvqEX1
 EXX0ZbrNrPHT9wJinosiHINvWQ9UK15SQeq9AQU=
X-Google-Smtp-Source: AGHT+IGxrpvDeYsuRqtJlmvKnHvHBz1jb9brhu9qoPukbNBoWD8pkofhee7RhYhSQioNZHnMdMhPrA==
X-Received: by 2002:a05:6870:d14c:b0:1bb:75af:37b5 with SMTP id
 f12-20020a056870d14c00b001bb75af37b5mr1177881oac.10.1692915326000; 
 Thu, 24 Aug 2023 15:15:26 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 o129-20020a4a4487000000b00565fcfabab8sm256338ooa.21.2023.08.24.15.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:15:25 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v8 15/20] target/riscv/cpu.c: introduce
 cpu_cfg_ext_auto_update()
Date: Thu, 24 Aug 2023 19:14:35 -0300
Message-ID: <20230824221440.484675-16-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824221440.484675-1-dbarboza@ventanamicro.com>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

During realize() time we're activating a lot of extensions based on some
criteria, e.g.:

    if (cpu->cfg.ext_zk) {
        cpu->cfg.ext_zkn = true;
        cpu->cfg.ext_zkr = true;
        cpu->cfg.ext_zkt = true;
    }

This practice resulted in at least one case where we ended up enabling
something we shouldn't: RVC enabling zca/zcd/zcf when using a CPU that
has priv_spec older than 1.12.0.

We're also not considering user choice. There's no way of doing it now
but this is about to change in the next few patches.

cpu_cfg_ext_auto_update() will check for priv version mismatches before
enabling extensions. If we have a mismatch between the current priv
version and the extension we want to enable, do not enable it. In the
near future, this same function will also consider user choice when
deciding if we're going to enable/disable an extension or not.

For now let's use it to handle zca/zcd/zcf enablement if RVC is enabled.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ddbf82f859..c56abf8395 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -177,6 +177,44 @@ static void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset,
     *ext_enabled = en;
 }
 
+static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
+        if (isa_edata_arr[i].ext_enable_offset != ext_offset) {
+            continue;
+        }
+
+        return isa_edata_arr[i].min_version;
+    }
+
+    /* Default to oldest priv spec if no match found */
+    return PRIV_VERSION_1_10_0;
+}
+
+static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
+                                    bool value)
+{
+    CPURISCVState *env = &cpu->env;
+    bool prev_val = isa_ext_is_enabled(cpu, ext_offset);
+    int min_version;
+
+    if (prev_val == value) {
+        return;
+    }
+
+    if (value && env->priv_ver != PRIV_VERSION_LATEST) {
+        /* Do not enable it if priv_ver is older than min_version */
+        min_version = cpu_cfg_ext_get_min_version(ext_offset);
+        if (env->priv_ver < min_version) {
+            return;
+        }
+    }
+
+    isa_ext_update_enabled(cpu, ext_offset, value);
+}
+
 const char * const riscv_int_regnames[] = {
     "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
     "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
@@ -1268,12 +1306,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 
     /* zca, zcd and zcf has a PRIV 1.12.0 restriction */
     if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
-        cpu->cfg.ext_zca = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
         if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
-            cpu->cfg.ext_zcf = true;
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
         if (riscv_has_ext(env, RVD)) {
-            cpu->cfg.ext_zcd = true;
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcd), true);
         }
     }
 
-- 
2.41.0


