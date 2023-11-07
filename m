Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E68947E32ED
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:31:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Br2-0002Yp-Ts; Mon, 06 Nov 2023 21:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Br0-0002Yd-VV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:10 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bqy-0002Oo-Sk
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:10 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc34c3420bso42061105ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324207; x=1699929007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0eTIZwcoiUS1TmOpNWgp5LerA9+yBbEFhZYXg8W26cI=;
 b=PNLe2rREEfIeOxmgXP3qB5KFUzP+xIm9EjHl5hmSiq93FuWpx5KbdmrF01FyxfeJSj
 E24uUP7nOisUzYYcWGy9C4kHPSS7K++Xbj5bwRzqjuyfYlExpmf8DJ5RsGqgImAd+ViN
 8GL5ck8hocFb/WcX4CMsridhBWU2VsRhUnvHgyfy+5QueW15I0+Q6UJXIV3kcVkqc+uP
 BhNT0yI5UysXMHmnAiN1iymVF+66MmBq04HG8F5XMoCUKMH6vwr8T5UKRl/msJE0zHtY
 Fsd6AA17gghC9L1yCrrxvLvJX/dtfgDKBVsqFbxqjhURvjXK3dIaQmaf+lWOD9OP3pbk
 9SWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324207; x=1699929007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0eTIZwcoiUS1TmOpNWgp5LerA9+yBbEFhZYXg8W26cI=;
 b=C2ySvXSbEN73JGraNJJi082SkLLwrcCKxH1YpFqs8jys8tIGaFd61ILyDvnkYIvC/S
 EnIqk555WiwgBB99So5qHD2SNe7O+65u8785CngpdPVlrti9CsfnL/QQIYnGapE5TTkK
 A6iILuuyLpoLLFFNtnEL5vCjd28irM7eT6ncDqyKyugWR3cUOuaO3fbzDoghujcSrLvt
 1E2RVt/IqTP6ta8J29neqgA/yG05Vip1oMi4W1R4pi6ANRIZRchpfL2ndKGmcAgKU+8x
 pH9C/nPSy8KahlQE0k0VmYLELSveDLsdH9Npo2gRIvUjuqb2qAk6sZkt/eY8XqiiPjcV
 qPGQ==
X-Gm-Message-State: AOJu0YwQQUvT6O9+UKZ2sCGF+HreQOcXIkr/DYS5b4fsODl0HT1tMxSX
 ZpbS3yZ1TfkrNeCyic7fE4WvhYmdFEbSeA==
X-Google-Smtp-Source: AGHT+IHdivdigJUjvRAkNLA9rf+ttC31OLmO8M0IhC8yljW96FE+f1Vxrd4bstlVfcV2oUSjNQeexw==
X-Received: by 2002:a17:903:41c7:b0:1cc:510b:36c with SMTP id
 u7-20020a17090341c700b001cc510b036cmr23485340ple.54.1699324206934; 
 Mon, 06 Nov 2023 18:30:06 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:05 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/49] target/riscv: rename ext_icbom to ext_zicbom
Date: Tue,  7 Nov 2023 12:28:59 +1000
Message-ID: <20231107022946.1055027-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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
of zicbom they're more likely to do 'grep -i zicbom' than 'grep -i
icbom'.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231012164604.398496-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                      | 2 +-
 hw/riscv/virt.c                             | 2 +-
 target/riscv/cpu.c                          | 6 +++---
 target/riscv/kvm/kvm-cpu.c                  | 6 +++---
 target/riscv/insn_trans/trans_rvzicbo.c.inc | 8 ++++----
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 9ea30da7e0..e6bef0070f 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -63,7 +63,7 @@ struct RISCVCPUConfig {
     bool ext_zkt;
     bool ext_zifencei;
     bool ext_zicsr;
-    bool ext_icbom;
+    bool ext_zicbom;
     bool ext_icboz;
     bool ext_zicond;
     bool ext_zihintntl;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9de578c756..54e0fe8ecc 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -263,7 +263,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
         qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
         g_free(name);
 
-        if (cpu_ptr->cfg.ext_icbom) {
+        if (cpu_ptr->cfg.ext_zicbom) {
             qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-size",
                                   cpu_ptr->cfg.cbom_blocksize);
         }
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 566b7545e8..943d5ecbfb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -76,7 +76,7 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
  * instead.
  */
 const RISCVIsaExtData isa_edata_arr[] = {
-    ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_icbom),
+    ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_icboz),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
@@ -497,7 +497,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
     cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
-    cpu->cfg.ext_icbom = true;
+    cpu->cfg.ext_zicbom = true;
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->cfg.ext_icboz = true;
@@ -1284,7 +1284,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zhinx", ext_zhinx, false),
     MULTI_EXT_CFG_BOOL("zhinxmin", ext_zhinxmin, false),
 
-    MULTI_EXT_CFG_BOOL("zicbom", ext_icbom, true),
+    MULTI_EXT_CFG_BOOL("zicbom", ext_zicbom, true),
     MULTI_EXT_CFG_BOOL("zicboz", ext_icboz, true),
 
     MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 26e68c7ab4..4d4c17fd77 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -213,7 +213,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
      .kvm_reg_id = _reg_id}
 
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
-    KVM_EXT_CFG("zicbom", ext_icbom, KVM_RISCV_ISA_EXT_ZICBOM),
+    KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
     KVM_EXT_CFG("zicboz", ext_icboz, KVM_RISCV_ISA_EXT_ZICBOZ),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
@@ -804,7 +804,7 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
         kvm_cpu_cfg_set(cpu, multi_ext_cfg, val);
     }
 
-    if (cpu->cfg.ext_icbom) {
+    if (cpu->cfg.ext_zicbom) {
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbom_blocksize);
     }
 
@@ -897,7 +897,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
         kvm_cpu_cfg_set(cpu, multi_ext_cfg, val);
     }
 
-    if (cpu->cfg.ext_icbom) {
+    if (cpu->cfg.ext_zicbom) {
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbom_blocksize);
     }
 
diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/insn_trans/trans_rvzicbo.c.inc
index e5a7704f54..e6ed548376 100644
--- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
@@ -16,10 +16,10 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#define REQUIRE_ZICBOM(ctx) do {    \
-    if (!ctx->cfg_ptr->ext_icbom) { \
-        return false;               \
-    }                               \
+#define REQUIRE_ZICBOM(ctx) do {     \
+    if (!ctx->cfg_ptr->ext_zicbom) { \
+        return false;                \
+    }                                \
 } while (0)
 
 #define REQUIRE_ZICBOZ(ctx) do {    \
-- 
2.41.0


