Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D77D78E0
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnZ8-0000wB-7T; Wed, 25 Oct 2023 19:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qvnYr-0000pa-8M
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:45:19 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qvnYp-0002EH-9f
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:45:16 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ca82f015e4so2166295ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698277513; x=1698882313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWrsEP2nCaxvct1xWBDFibPhdaq2BqmUx9lrQ3Glem4=;
 b=Rm5FSeRIEKkRBTnfhWWDd835E96BzyLALPEyY7poOlLop5V0m957MjJ5uLUOmO1GWI
 pD3N46g9gYqgC/TvK9L6URxBLNLSX21n6Fdql+K2Vozc7rTnyonOedjGcFoHuOhYx1P9
 tGtqrM3MMk7LHgM+x+XxmYlnWH7FNgBrZmmHp6jFNmFYcB02RDbVapRVsRR6IaCLpmim
 GM10TnB7Q4tMg5ei9Dm39RkUkCLK7h85fk4vfwpfAVctnv0GehDwDf+amHbr30s6zhVm
 RBGzHk+gvJyadWyD3jQDKetvCa4uNs506WrqYA5ZRgl4aoNE7naAkenOUns3dazDcymB
 r1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698277513; x=1698882313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWrsEP2nCaxvct1xWBDFibPhdaq2BqmUx9lrQ3Glem4=;
 b=PoPbqGsp22KZ+Mj8aQpKr8X/4qw2Y2FsakTfRbMlbvAW7mavUS0Jid5NJIFEUMM5Xd
 7ciy0wCi93ZBg568SZk71UH32s53s8XSuDsCvdtCFKqI+qC5AgxnwI9+rUDJYPWTuME2
 9dxTU1AAsK+pfj6Ez4OK5dYOJcNf2zX9WjzPzXvG5HswS5lvpUE3g2NdYgFiIqhmIgzl
 fnhRd5+boxOuA1efPDJzd0VIY3rB7L7W0shU8Dn2zHEvLeCvfbv1H+VsuX4TOZBw8qv8
 dCPodZcuQ/+JFTCdExFjM0uDfGOfQF5jaMSXpouL6z++DeOwF8polx//OFlX25ljusNZ
 TzUQ==
X-Gm-Message-State: AOJu0YwmwIoXC23lFoESsJPNo2Vgw/HiZhwfJKcbgVs2xNEY8VsOk9yh
 rAvvR2SSJDT7jZ4/gWwSIWFhXxMq3KH+j9VJkIk=
X-Google-Smtp-Source: AGHT+IFZHYLBDAmypjTBnAP6ju2MNvVcV5WCSOpzVPcsmGaoAOSNfIQGBJ5Wh+WVmL1/GADUD6TNrg==
X-Received: by 2002:a17:903:186:b0:1b6:bced:1dc2 with SMTP id
 z6-20020a170903018600b001b6bced1dc2mr15776205plg.0.1698277513285; 
 Wed, 25 Oct 2023 16:45:13 -0700 (PDT)
Received: from grind.. ([191.255.2.33]) by smtp.gmail.com with ESMTPSA id
 w14-20020a170902e88e00b001c736746d33sm9738654plg.217.2023.10.25.16.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:45:12 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 01/10] target/riscv/tcg: add 'zic64b' support
Date: Wed, 25 Oct 2023 20:44:50 -0300
Message-ID: <20231025234459.581697-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025234459.581697-1-dbarboza@ventanamicro.com>
References: <20231025234459.581697-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

zic64b is defined in the RVA22U64 profile [1] as a named feature for
"Cache blocks must be 64 bytes in size, naturally aligned in the address
space".  It's a fantasy name for 64 bytes cache blocks. RVA22U64
mandates this feature, meaning that applications using it expects 64
bytes cache blocks.

In theory we're already compliant to it since we're using 64 bytes cache
block sizes by default, but nothing is stopping users from enabling a
profile and changing the cache block size at the same time.

We'll add zic64b as a 'named feature', not a regular extension, in a
sense that we won't write it in riscv,isa. It'll be used solely to track
whether the user changed cache sizes and if we should warn about it.

zic64b is default to 'true' since we're already using 64 bytes blocks.
If any cache block size (cbom_blocksize or cboz_blocksize) is changed to
something different than 64, zic64b is set to 'false' and, if zic64b was
set to 'true' in the command line, also throw an user warning.

Our profile implementation set mandatory extensions as if users enabled
them in the command line, so this logic will extend to the future RVA22U64
implementation as well.

[1] https://github.com/riscv/riscv-profiles/releases/download/v1.0/profiles.pdf

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 12 ++++++++++--
 target/riscv/cpu.h         |  3 +++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/tcg/tcg-cpu.c | 26 ++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f40da4c661..5095f093ba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1394,6 +1394,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
+    MULTI_EXT_CFG_BOOL("zic64b", zic64b, true),
+
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 /* Deprecated entries marked for future removal */
 const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] = {
     MULTI_EXT_CFG_BOOL("Zifencei", ext_zifencei, true),
@@ -1423,8 +1429,10 @@ Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
     DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
 
-    DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
-    DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
+    DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU,
+                       cfg.cbom_blocksize, CB_DEF_VALUE),
+    DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU,
+                       cfg.cboz_blocksize, CB_DEF_VALUE),
 
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8efc4d83ec..ee9abe61d6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -64,6 +64,8 @@ extern const uint32_t misa_bits[];
 const char *riscv_get_misa_ext_name(uint32_t bit);
 const char *riscv_get_misa_ext_description(uint32_t bit);
 
+#define CB_DEF_VALUE 64
+
 #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
 
 /* Privileged specification version */
@@ -745,6 +747,7 @@ typedef struct RISCVCPUMultiExtConfig {
 extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
+extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[];
 extern Property riscv_cpu_options[];
 
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 6eef4a51ea..b6693320d3 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -107,6 +107,7 @@ struct RISCVCPUConfig {
     bool ext_smepmp;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
+    bool zic64b;
 
     uint32_t mvendorid;
     uint64_t marchid;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 093bda2e75..ac5f65a757 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -264,6 +264,27 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
     }
 }
 
+static void riscv_cpu_validate_zic64b(RISCVCPU *cpu)
+{
+    const char *warn = "zic64b set to 'true' but %s is set to %u. "
+                       "zic64b changed to 'false'";
+    bool send_warn = cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(zic64b));
+
+    if (cpu->cfg.cbom_blocksize != CB_DEF_VALUE) {
+        cpu->cfg.zic64b = false;
+        if (send_warn) {
+            warn_report(warn, "cbom_blocksize", cpu->cfg.cbom_blocksize);
+        }
+    }
+
+    if (cpu->cfg.cboz_blocksize != CB_DEF_VALUE) {
+        cpu->cfg.zic64b = false;
+        if (send_warn) {
+            warn_report(warn, "cboz_blocksize", cpu->cfg.cboz_blocksize);
+        }
+    }
+}
+
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
@@ -394,6 +415,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.zic64b) {
+        riscv_cpu_validate_zic64b(cpu);
+    }
+
     if (cpu->cfg.ext_zvfh) {
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvfhmin), true);
     }
@@ -889,6 +914,7 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_extensions);
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
+    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_named_features);
 
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
 
-- 
2.41.0


