Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 945F1756F2D
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLWBF-0004xR-Ud; Mon, 17 Jul 2023 17:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLWAs-0004qU-Pd
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:54:36 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLWAq-00042D-Rv
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:54:34 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b0156a1c49so3773535fac.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689630869; x=1692222869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OHWcO5WVLseUriAXyyBjp9pT8KS69mNOgRkAabIiLnQ=;
 b=ByA/v5Jo4/EIvSaa2gvA/uRjB31FCd9wTxhZcHJt5iUuib4UngegqZdJzlYbkZbtCJ
 QjWksX+pPqb5+Dy0UpC3FyQQpwamW7YQGM42fP9V2G2uouWqIhAkOXE91XH5pU8LYS3A
 ZdiXS3aHlTmtig4nQ0G3PbK6FK2NEG4i6f6AuAkmuu6VbN/58jNperO5LvfswORhBMxt
 a/1t8aFq9B6rkFMDmX+gDyQySmL64z1bY6zB1xNMBWltffgRh8Eu//1hE941ZQx/ocz0
 aRfTy/+puIS22NUwaDmO0zdIbY6C+mqhV4TCHx5TzZdomVhDSDxKLawCfsyNHq1T7VWh
 fn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689630869; x=1692222869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OHWcO5WVLseUriAXyyBjp9pT8KS69mNOgRkAabIiLnQ=;
 b=enAh2qpwE6VNjrThaB2FldRdhGIUQ9EBFgH7VvkcqPR9+Dpjeb/uUYSxyDzKUqGOD2
 DotlFmPexI5DuZfIR0pz5Qf9+YyS/mt8CY/w1XGZykT2Agd4AwcMvFofhywfPjtmV8uE
 P4+VRC1xQoX+/+XjuW3IkL17StlXuAkn10nqk4P0hzpOtWFEs5EYAFTTRhApS9+S+Eqa
 6gNoo5ZRWqG0h4cswjPD3EXqFF1FB2og7N6FjR0ISbzD8afjH6FJbJabXwJmhYcBR8Qn
 FnVfZA6WvPTyaFKNGDpgUIuFtxbdzVYjUJPiJKQGUvw0HFvib7i+5uQ0DIEct49MabAF
 oOvQ==
X-Gm-Message-State: ABy/qLbW4pefTjSIsSTf+JdjenImZF1hNz4o6tRxg/3nArcwefIHl6hh
 3mPvas0dbVZL8S9MdtJTE88YC/7+wq81TblsZoPSaw==
X-Google-Smtp-Source: APBJJlHgl5CVgATxb2xbD0/cposR8FPM2j7MmE2brdrYvNGTy3ytM1geuh6aHzwwBwJwDHvcTLY/Eg==
X-Received: by 2002:a05:6870:8903:b0:1b0:4b1e:f394 with SMTP id
 i3-20020a056870890300b001b04b1ef394mr13321547oao.11.1689630869538; 
 Mon, 17 Jul 2023 14:54:29 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a056830008100b006b9848f8aa7sm322958oto.45.2023.07.17.14.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 14:54:29 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 2/2] target/riscv/cpu.c: add zihpm extension flag
Date: Mon, 17 Jul 2023 18:54:19 -0300
Message-ID: <20230717215419.124258-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717215419.124258-1-dbarboza@ventanamicro.com>
References: <20230717215419.124258-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2a.google.com
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

zihpm is the Hardware Performance Counters extension described in
chapter 12 of the unprivileged spec. It describes support for 29
unprivileged performance counters, hpmcounter3-hpmcounter21.

As with zicntr, QEMU already implements zihpm before it was even an
extension. zihpm is also part of the RVA22 profile, so add it to QEMU
to complement the future future profile implementation.

Default it to 'true' since it was always present in the code. Change the
realize() time validation to disable it in case 'icsr' isn't present and
if there's no hardware counters (cpu->cfg.pmu_num is zero).

There's a small tweak needed in riscv_cpu_realize_tcg() made:
riscv_cpu_validate_set_extensions() must be executed after the block
that executes riscv_pmu_init(). The reason is that riscv_pmu_init() will
do "cpu->cfg.pmu_num = 0" if PMU support cannot be enabled. We want to
get the latest, definite value of cfg.pmu_num during the validation() to
ensure we do the right thing.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c     | 20 +++++++++++++-------
 target/riscv/cpu_cfg.h |  1 +
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7ec88659be..5836640d5c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -89,6 +89,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
+    ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_ihpm),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
     ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
@@ -1296,6 +1297,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_icntr = false;
     }
 
+    if (cpu->cfg.ext_ihpm && (!cpu->cfg.ext_icsr || cpu->cfg.pmu_num == 0)) {
+        cpu->cfg.ext_ihpm = false;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
@@ -1426,12 +1431,6 @@ static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)
         return;
     }
 
-    riscv_cpu_validate_set_extensions(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
 #ifndef CONFIG_USER_ONLY
     CPU(dev)->tcg_cflags |= CF_PCREL;
 
@@ -1446,6 +1445,12 @@ static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)
         }
      }
 #endif
+
+    riscv_cpu_validate_set_extensions(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
 
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
@@ -1784,10 +1789,11 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("svpbmt", RISCVCPU, cfg.ext_svpbmt, false),
 
     /*
-     * Always default true - we'll disable it during
+     * Always default true - we'll disable them during
      * realize() if needed.
      */
     DEFINE_PROP_BOOL("zicntr", RISCVCPU, cfg.ext_icntr, true),
+    DEFINE_PROP_BOOL("zihpm", RISCVCPU, cfg.ext_ihpm, true),
 
     DEFINE_PROP_BOOL("zba", RISCVCPU, cfg.ext_zba, true),
     DEFINE_PROP_BOOL("zbb", RISCVCPU, cfg.ext_zbb, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index d36dc12b92..85c7a71853 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -66,6 +66,7 @@ struct RISCVCPUConfig {
     bool ext_icsr;
     bool ext_icbom;
     bool ext_icboz;
+    bool ext_ihpm;
     bool ext_zicond;
     bool ext_zihintpause;
     bool ext_smstateen;
-- 
2.41.0


