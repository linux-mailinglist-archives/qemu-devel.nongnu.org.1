Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9443F766E8F
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:39:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNK0-0006Tl-1Z; Fri, 28 Jul 2023 09:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qPNJw-0006Qu-Qg
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:15:53 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qPNJt-0003Mg-2X
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:15:52 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1bb94563d19so1299970fac.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690550131; x=1691154931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFuP7PaPRBJxoHUtdhdAxyN5WwLUi/EV/+uL9Zmq2Jk=;
 b=UDxx1aQE1TD+ZikaIjARYYn6DI3M883bFzZO5pyuB2h+J9+QTodUCSisUpS6yylsyv
 ATU+V8KNcArCaRfUUEsqJ8OjQNNbsSjA2N+1I0MWBJkaQJwqi/T7TJVyEe703LJboeUi
 41c27LyxeDxvC74enttkSdRMltHark25NWc28GkdpSg2MnYmTXzu2bFFeWJp9lvtBJ7o
 dJqiJmxRbIMka4W6Q1+k+lTw0cAdWuHsw80UoPIokYaFtAZYSZqhrwQRlMvMZ0VRNrJQ
 tnHucZkxBXVhPUjX7amQelS2TLhfvM/moDM/52sYdwHs04hbee1XGlCixTNxIB4plycU
 4X4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690550131; x=1691154931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XFuP7PaPRBJxoHUtdhdAxyN5WwLUi/EV/+uL9Zmq2Jk=;
 b=G7mBq2g0n0hvigpvkX2gxtE5oMxS4ZOejVe5xDowT03lqoAwBpiRVMv7WYGZLvPCQX
 YnLyLFMXe8cxvsWt/Wm/pSFRHz02DEFcBjMW0bpDPNbg0UKxtNij1xyeUFfiqA4mwH+G
 hQ5YrkunsksU3WQmECk9BK4s9bUgvhoRpVwD65GDhKdSVE7H6CTGxxTS1dNnV0vrXkVD
 wVjG0XKecBgcodwk2ocTUQjdg0ZyBMNzioXBkDHvSbXoQgikUenb+3Uo3qY6puZ4RlyC
 usdDGD8Y5L7S5dLg4zsjBl8pTQUk+CCbkSQ+55iBG7wSrgtlBbrD3QNt8rezrTRlFqtE
 8Cng==
X-Gm-Message-State: ABy/qLYuOtOAa9/8L4iuSNhFa5kpz6aelwyLlLhWTsEoB8hyW9xz2Ewm
 aC/t0sFl8L4jkzcIWOwcBZ7nkbev97p3Lqx6h9g+Kg==
X-Google-Smtp-Source: APBJJlGQN6qpG9mOd1nEy3Dyugc7BtmVFInmNnTXbDjXLIKYylVD36KIR8cjgHwwz5C36G/3T7LZVA==
X-Received: by 2002:a05:6870:472b:b0:1bb:7f1d:10f5 with SMTP id
 b43-20020a056870472b00b001bb7f1d10f5mr4909077oaq.20.1690550131395; 
 Fri, 28 Jul 2023 06:15:31 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 hv6-20020a056871cc0600b001b3d93884fdsm1699371oac.57.2023.07.28.06.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 06:15:31 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/8] target/riscv: make CPUCFG() macro public
Date: Fri, 28 Jul 2023 10:15:14 -0300
Message-ID: <20230728131520.110394-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728131520.110394-1-dbarboza@ventanamicro.com>
References: <20230728131520.110394-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2f.google.com
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

The RISC-V KVM driver uses a CPUCFG() macro that calculates the offset
of a certain field in the struct RISCVCPUConfig. We're going to use this
macro in target/riscv/cpu.c as well in the next patches. Make it public.

Rename it to CPU_CFG_OFFSET() for more clarity while we're at it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 2 +-
 target/riscv/cpu.h | 2 ++
 target/riscv/kvm.c | 8 +++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 644ce7a018..3e62881d85 100644
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
index 9d8a8982f9..9b8565d809 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -198,10 +198,8 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
-#define CPUCFG(_prop) offsetof(struct RISCVCPUConfig, _prop)
-
 #define KVM_EXT_CFG(_name, _prop, _reg_id) \
-    {.name = _name, .offset = CPUCFG(_prop), \
+    {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
      .kvm_reg_id = _reg_id}
 
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
@@ -278,13 +276,13 @@ static void kvm_cpu_set_multi_ext_cfg(Object *obj, Visitor *v,
 
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


