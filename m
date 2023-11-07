Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EFF7E330C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Br8-0002Za-SU; Mon, 06 Nov 2023 21:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Br4-0002Z6-Hf
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:15 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Br2-0002PE-Kr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:14 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so41079455ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324210; x=1699929010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RITwLF22GOA7XJqwWvXBbDskX10Qg7cuDTKhU9sNRf8=;
 b=lkmwVvoBVRixvrBYkiAsjmS8zVRz8SBBnAHfiofKuXvieLe27L2SgG74/9Xmrmyyo1
 OWhd3TrpY66kPmEQVxmYYXXDm6YUqUN+SMbHYbDr8kwFNmv0LNCeZnVsv65QI/tFt4H+
 s+M5BZZkWJvEVJZGN20uq2vbJU62AvnHTvvsWv9yDnKvG4cSx71R/UXituzawWaHhseU
 5pYcKA/iAu5EKmz7ftxkslz5Lr233Rj14yInx+UThIinv9uW7ams20QK51gJjyavPZHh
 g/oKu6mj49WiHpg0DRh7tDtma78jciousVfH2wxdsd7/fVTzNDwHMYGWW6EpJ3V7lREN
 t9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324210; x=1699929010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RITwLF22GOA7XJqwWvXBbDskX10Qg7cuDTKhU9sNRf8=;
 b=hIYJUhEPJHpJA4byHGDe7+SpncjpJ1ovdPbLKJa/Q5wpuQ3NwZMY4yjh7mMyp2BlgM
 g7kviy231mWYW93PdZ3Jbdxtcp/dxvlJ2Q8I7jtWPlaNAZQBiSN6Qg6yGDQSjNezLWHG
 lnBwq5X9tt7Oly18LXQchVyD4pPv4YEQ/cQRjJa5BaqVKezvXBrrvCIp4EQbERXklMsD
 r2GpLYYm1/K4TL49RNHvVmYuj226eR7R4yytijtbgzGgB6X5AVXVZD2b9c/dselrDtpm
 xKvpTnNgDG/wmzPgYXai35HCQX2yFPUWbca/jDkHH/TWM+/d2Yvoc5/+i8QT8xYzFZHM
 efLg==
X-Gm-Message-State: AOJu0Yzt1g7/2lbRsnie6zm8KIP/DPVGuO2MPFnfn3aQ0hirjfAoTclZ
 oyvpuduLgFrthCZI5wHhDY3cCXgr203JTA==
X-Google-Smtp-Source: AGHT+IHu/KuATDsRAuB4PYnEABAkZZfWTC5ImFuFyYq/tuC477ifJnA+sOkkyJXyupltSyNYSWemew==
X-Received: by 2002:a17:902:e887:b0:1cc:32df:427a with SMTP id
 w7-20020a170902e88700b001cc32df427amr1867907plg.27.1699324210550; 
 Mon, 06 Nov 2023 18:30:10 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:09 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/49] target/riscv: rename ext_icboz to ext_zicboz
Date: Tue,  7 Nov 2023 12:29:00 +1000
Message-ID: <20231107022946.1055027-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add a leading 'z' to improve grepping. When one wants to search for uses
of zicboz they're more likely to do 'grep -i zicboz' than 'grep -i
icboz'.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231012164604.398496-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                      | 2 +-
 hw/riscv/virt.c                             | 2 +-
 target/riscv/cpu.c                          | 6 +++---
 target/riscv/kvm/kvm-cpu.c                  | 6 +++---
 target/riscv/insn_trans/trans_rvzicbo.c.inc | 8 ++++----
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e6bef0070f..208cac1c7c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -64,7 +64,7 @@ struct RISCVCPUConfig {
     bool ext_zifencei;
     bool ext_zicsr;
     bool ext_zicbom;
-    bool ext_icboz;
+    bool ext_zicboz;
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 54e0fe8ecc..1732c42915 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -268,7 +268,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
                                   cpu_ptr->cfg.cbom_blocksize);
         }
 
-        if (cpu_ptr->cfg.ext_icboz) {
+        if (cpu_ptr->cfg.ext_zicboz) {
             qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cboz-block-size",
                                   cpu_ptr->cfg.cboz_blocksize);
         }
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 943d5ecbfb..efafc0ba0b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -77,7 +77,7 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
  */
 const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
-    ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_icboz),
+    ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_zifencei),
@@ -500,7 +500,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
     cpu->cfg.ext_zicbom = true;
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
-    cpu->cfg.ext_icboz = true;
+    cpu->cfg.ext_zicboz = true;
     cpu->cfg.ext_smaia = true;
     cpu->cfg.ext_ssaia = true;
     cpu->cfg.ext_sscofpmf = true;
@@ -1285,7 +1285,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zhinxmin", ext_zhinxmin, false),
 
     MULTI_EXT_CFG_BOOL("zicbom", ext_zicbom, true),
-    MULTI_EXT_CFG_BOOL("zicboz", ext_icboz, true),
+    MULTI_EXT_CFG_BOOL("zicboz", ext_zicboz, true),
 
     MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 4d4c17fd77..6e1678542b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -214,7 +214,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
-    KVM_EXT_CFG("zicboz", ext_icboz, KVM_RISCV_ISA_EXT_ZICBOZ),
+    KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
@@ -808,7 +808,7 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbom_blocksize);
     }
 
-    if (cpu->cfg.ext_icboz) {
+    if (cpu->cfg.ext_zicboz) {
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cboz_blocksize);
     }
 }
@@ -901,7 +901,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbom_blocksize);
     }
 
-    if (cpu->cfg.ext_icboz) {
+    if (cpu->cfg.ext_zicboz) {
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cboz_blocksize);
     }
 }
diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/insn_trans/trans_rvzicbo.c.inc
index e6ed548376..d5d7095903 100644
--- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
@@ -22,10 +22,10 @@
     }                                \
 } while (0)
 
-#define REQUIRE_ZICBOZ(ctx) do {    \
-    if (!ctx->cfg_ptr->ext_icboz) { \
-        return false;               \
-    }                               \
+#define REQUIRE_ZICBOZ(ctx) do {     \
+    if (!ctx->cfg_ptr->ext_zicboz) { \
+        return false;                \
+    }                                \
 } while (0)
 
 static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
-- 
2.41.0


