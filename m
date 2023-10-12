Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9737C63FC
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn51-0006xM-FT; Thu, 12 Oct 2023 00:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4m-0006iO-1d
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:32 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4k-0002jc-A3
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:31 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so465951b3a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084008; x=1697688808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/aMUncszvwutqdnkY13b7I4j9Re5WvgdVwubMs61wU=;
 b=GiNIKQ2iTEkYRW0FpZKlm3f+MhwVmwdqIxTm3EiRS+cdcd6uKA2TXNFy7wUqephzJ4
 PmjnzVmFJmpGUaABb2Zqo3UU19FvHUqiPW7W6KEeGaUaL6x7hzUSe42pTBJX+LLVqsDx
 NZRHTDKMdzT+sPvQI32LI/PuzusYF10vnL5MaBt8Mcn5MQHEgSQs1z0wGjkYmL2rEd0+
 vaRhmPx4LrgKq8t//AxFTCTvTOnjJppbJukqtrP9M0qmruRMe8heIGe0Mn6u8mfkpeuo
 2RRHqO1rqHUZS7a9KFd30kQwVAbMvc3G1W7t5O7vcOvVoSWqvhgPCCBzh8EhlO1FpYoM
 ti0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084008; x=1697688808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/aMUncszvwutqdnkY13b7I4j9Re5WvgdVwubMs61wU=;
 b=tdwSeVTGrGyJkogDhD7QXeveHYJMIL5BHkpaHEnC7KRxYyxAXcTTSbLq0LsdQUyQdL
 ys7Jk72d5nwc37optAJV35uLS0sw1z9dkhFI7zYdm+UPP5MiyUW7kOIjl5XvxxMGIEst
 WYfhwa3EO56ZuIeMpN/QpfpBb/kH2xZjpuSyyg/FU4sA3s6uluUNX7stDLokH1JuYhTA
 i4UQ3mS3tht4MyZVYgmT53V+HE8pxCf/KuKKRHLKhqMN2hrmavcEO1/U/yH//AeXZU0n
 4Bdy95P2KfWEmP1vek0sXlbLa70bGnBIO2jvfXPzI1ezM6XmYGHen2nqtREWZp/ZM3BR
 Hr2Q==
X-Gm-Message-State: AOJu0YwtjglIH8h273r6H7/Bha/IvvgtbHmt1TzUSoMl52J5tacOaF1V
 fs3Rv92HWzVVOSe8LwuVzNbeTqx4Tc6uBA==
X-Google-Smtp-Source: AGHT+IFNSbtp9gOWaA35yiGFSM+gfpFU7XkKJy9mVXIfxNUmvsbnqmWo184VnycSxJfNdRqhNYaHBw==
X-Received: by 2002:a05:6a20:3c89:b0:173:3ef3:236a with SMTP id
 b9-20020a056a203c8900b001733ef3236amr4749898pzj.21.1697084008144; 
 Wed, 11 Oct 2023 21:13:28 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:27 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/54] target/riscv/cpu: move priv spec functions to tcg-cpu.c
Date: Thu, 12 Oct 2023 14:10:38 +1000
Message-ID: <20231012041051.2572507-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Priv spec validation is TCG specific. Move it to the TCG accel class.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230925175709.35696-20-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  2 --
 target/riscv/cpu.c         | 38 --------------------------------------
 target/riscv/tcg/tcg-cpu.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6eef1f697e..7291b84756 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -711,9 +711,7 @@ enum riscv_pmu_event_idx {
 /* used by tcg/tcg-cpu.c*/
 void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
-int cpu_cfg_ext_get_min_version(uint32_t ext_offset);
 void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext);
-void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu);
 
 typedef struct RISCVCPUMultiExtConfig {
     const char *name;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 989610ff90..a7cc7aa6e2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -172,21 +172,6 @@ void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en)
     *ext_enabled = en;
 }
 
-int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
-{
-    const RISCVIsaExtData *edata;
-
-    for (edata = isa_edata_arr; edata && edata->name; edata++) {
-        if (edata->ext_enable_offset != ext_offset) {
-            continue;
-        }
-
-        return edata->min_version;
-    }
-
-    g_assert_not_reached();
-}
-
 const char * const riscv_int_regnames[] = {
     "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
     "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
@@ -925,29 +910,6 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     }
 }
 
-void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
-{
-    CPURISCVState *env = &cpu->env;
-    const RISCVIsaExtData *edata;
-
-    /* Force disable extensions if priv spec version does not match */
-    for (edata = isa_edata_arr; edata && edata->name; edata++) {
-        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset) &&
-            (env->priv_ver < edata->min_version)) {
-            isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
-#ifndef CONFIG_USER_ONLY
-            warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
-                        " because privilege spec version does not match",
-                        edata->name, env->mhartid);
-#else
-            warn_report("disabling %s extension because "
-                        "privilege spec version does not match",
-                        edata->name);
-#endif
-        }
-    }
-}
-
 #ifndef CONFIG_USER_ONLY
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ef981ad0ce..a021ec833d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -99,6 +99,21 @@ static const struct TCGCPUOps riscv_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
+static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
+{
+    const RISCVIsaExtData *edata;
+
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->ext_enable_offset != ext_offset) {
+            continue;
+        }
+
+        return edata->min_version;
+    }
+
+    g_assert_not_reached();
+}
+
 static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
                                     bool value)
 {
@@ -226,6 +241,29 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
     }
 }
 
+static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+    const RISCVIsaExtData *edata;
+
+    /* Force disable extensions if priv spec version does not match */
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset) &&
+            (env->priv_ver < edata->min_version)) {
+            isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
+#ifndef CONFIG_USER_ONLY
+            warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
+                        " because privilege spec version does not match",
+                        edata->name, env->mhartid);
+#else
+            warn_report("disabling %s extension because "
+                        "privilege spec version does not match",
+                        edata->name);
+#endif
+        }
+    }
+}
+
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
-- 
2.41.0


