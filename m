Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CDC787B5C
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 00:18:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZIc5-00086K-0C; Thu, 24 Aug 2023 18:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbv-0007u1-PQ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:29 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbt-0006KZ-E3
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:27 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a9a6a7a824so108387b6e.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692915323; x=1693520123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1K2smOpPZCrS+utxF5n38uQLJp83KUqBfs1CpTXpgho=;
 b=c2rCukjxZU2wMx2Z4vlEes3nZGjx15COUaZhnWVmUjTwVY6okS++Juo3EYfoF01Pfk
 x75CWf/MkX4bXL8jAaCAFpbxni3E35L6FIiPxvcGDntY2E+NeRyrD5ZQO4mFopF4fzYg
 flP626rihy+v8/rCOV/60MCJXwuBvL7gNsOchzJP2JH2lqi3k2bBLB9ExnN8rvj+NYHj
 YkhWvtApzj4Vyz9GnzwRMnP6PzpDnqvownur/gtGohF80d46G5Ol/E+09JH/a+ifOYkw
 r/UZv4FLZnHI18Wqcr4O1xhwrz11nUNDpOOH+GWf3gRKYak5f+C+fPLALfM3rqmnwrna
 YeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692915323; x=1693520123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1K2smOpPZCrS+utxF5n38uQLJp83KUqBfs1CpTXpgho=;
 b=T4Ck2muj0p6BQjemGdLXavNJ5pKUctuScB/l0GSmXryrRDZZjCSPaOh69g2cvCU22L
 9bGO8FC6kca2zwjrmFfa/BKyET2GYuFYcgAp0mXMPU7JDLej+4+ASW/eYTbgNsTAvaTq
 pyO+PuK/jdhVyMOAAqKl/83dKV5HkbXMG7myHkGwVG7WHjHWXdV9wCw8g8Bix17ch+S7
 6pngo5hstrEJNxT68TMMC6rNDXY23f/oZaOtVZNcNYJsulipVY5qWWKLGCoh1wzBfyuh
 ZyDbE4y5zg0abPDzulb5S9mE6mWSrWOU032oAAbGmAR32/i1ws8A7jEK8jNFZDG1Ce3r
 qA7A==
X-Gm-Message-State: AOJu0Yxk9gA78rZusbmys717zRKXeuTeG1/5wSx3indfMQfTdVNVCG5/
 9TgTh42nOV+WuQ7qv1bvCtyjik+A3YI0f87sy9E=
X-Google-Smtp-Source: AGHT+IGrsnkNqhi2X5tL+hk9YnC/3eBP/Kkju2r/SD9FgYYEFZxtsAfKshn5xTlZfE7K4HgPLp916g==
X-Received: by 2002:a05:6808:1a85:b0:3a8:3d2f:347e with SMTP id
 bm5-20020a0568081a8500b003a83d2f347emr532884oib.20.1692915323306; 
 Thu, 24 Aug 2023 15:15:23 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 o129-20020a4a4487000000b00565fcfabab8sm256338ooa.21.2023.08.24.15.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:15:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v8 14/20] target/riscv: make CPUCFG() macro public
Date: Thu, 24 Aug 2023 19:14:34 -0300
Message-ID: <20230824221440.484675-15-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824221440.484675-1-dbarboza@ventanamicro.com>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The RISC-V KVM driver uses a CPUCFG() macro that calculates the offset
of a certain field in the struct RISCVCPUConfig. We're going to use this
macro in target/riscv/cpu.c as well in the next patches. Make it public.

Rename it to CPU_CFG_OFFSET() for more clarity while we're at it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 target/riscv/cpu.h | 2 ++
 target/riscv/kvm.c | 8 +++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cbf8ceec54..ddbf82f859 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -48,7 +48,7 @@ struct isa_ext_data {
 };
 
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
-    {#_name, _min_ver, offsetof(struct RISCVCPUConfig, _prop)}
+    {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
 
 /*
  * From vector_helper.c
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6ea22e0eea..577abcd724 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -62,6 +62,8 @@
 const char *riscv_get_misa_ext_name(uint32_t bit);
 const char *riscv_get_misa_ext_description(uint32_t bit);
 
+#define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
+
 /* Privileged specification version */
 enum {
     PRIV_VERSION_1_10_0 = 0,
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index faee8536ef..7c6dec05e3 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -200,10 +200,8 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
-#define CPUCFG(_prop) offsetof(struct RISCVCPUConfig, _prop)
-
 #define KVM_EXT_CFG(_name, _prop, _reg_id) \
-    {.name = _name, .offset = CPUCFG(_prop), \
+    {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
      .kvm_reg_id = _reg_id}
 
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
@@ -280,13 +278,13 @@ static void kvm_cpu_set_multi_ext_cfg(Object *obj, Visitor *v,
 
 static KVMCPUConfig kvm_cbom_blocksize = {
     .name = "cbom_blocksize",
-    .offset = CPUCFG(cbom_blocksize),
+    .offset = CPU_CFG_OFFSET(cbom_blocksize),
     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicbom_block_size)
 };
 
 static KVMCPUConfig kvm_cboz_blocksize = {
     .name = "cboz_blocksize",
-    .offset = CPUCFG(cboz_blocksize),
+    .offset = CPU_CFG_OFFSET(cboz_blocksize),
     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
 };
 
-- 
2.41.0


