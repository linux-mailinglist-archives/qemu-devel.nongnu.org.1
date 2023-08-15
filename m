Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9A077D457
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:38:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0mZ-0006O7-Sj; Tue, 15 Aug 2023 16:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0mX-0006Ng-Ta
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:36:49 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0mV-0000zm-Ob
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:36:49 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bd0911c95dso5188331a34.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692131806; x=1692736606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/moBDfYtzaYLVdgO352m8Orp/d7gwm187/cF79ScUQ=;
 b=YcXNJzPR9Medty3BtYxUXbLSZbC6HgfKTdbveaf0Yei/DLk5rMMyOmGfVoD+xCEQWA
 XMoCo4mbOaowFk7E4MjLJbhYvvuVX289BTdhiu0KKETuuMawnyIsU0i6YqFwHJ/FIfYG
 HyEPGk3CpP/jAn855BCcF5Q/oIhqqY4hM4I/1mEb2OSKnfolwevIU41nvLJa1t27WvHM
 +UuybnQLUQxZ8zhI3HeYEPqpEQsPyJAmQDqM8zBGrAxKl/phsVKyjkjEdkPAJcgViqvB
 uWqb4qOyxig8OEe9/3IDUdgyc+5j8oTzMxnEGyjK1R7qMMEmJCZj9n6y8ZOoW1PbpEy1
 3WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692131806; x=1692736606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/moBDfYtzaYLVdgO352m8Orp/d7gwm187/cF79ScUQ=;
 b=RKyTM9/HNN9zqNn6Ap2++5PjjK1IdifIvc1KSOMFPtxTMlsHDt5ePKA/Qjh795t3ro
 dQI3LMK47qTKZz2SczLSnqQT8gDPFhG/6Ci4TBXa3klqQHFz0X+/Be0+eF7ywbtJSeUQ
 vmNMUGCmTR1Q0rklGrYP5st1AGef0ejrK9ZzapYV22uEC5vCb5CNlYrjRqv79ZkHFW7m
 N3XB4oa5ILinz/rNhgOGZwcS994/zaPquZmQ5N3z9JGvyALvYHmZOdE2fjtfu6bCEtHj
 snrl0Tfsqhz/FN/bgdJwBZ1jkgzUfnC3h+ADx1FPjF+AXBD+qexO/AyG5Tpi3vEP4W++
 d1Zg==
X-Gm-Message-State: AOJu0YzoQkydWAh7TdyktD1sbntvdyc6VckizhjymQ2lpXdFGpP0xUqu
 hxBzVrVS6PPR6MXUcasU1S6fJCYvdiJNf4wFlEk=
X-Google-Smtp-Source: AGHT+IGcc16JIID1w8Esqi/J0pJiJEPnL+puDdBUSy9hX5s6CXmlVP9CuoOYCVj5rrArHrVjpHMqTg==
X-Received: by 2002:a05:6830:10d2:b0:6b9:1ad8:18d8 with SMTP id
 z18-20020a05683010d200b006b91ad818d8mr12548735oto.27.1692131806451; 
 Tue, 15 Aug 2023 13:36:46 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a0568301bcf00b006b94fb2762asm5526849ota.23.2023.08.15.13.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:36:46 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/8] target/riscv: make CPUCFG() macro public
Date: Tue, 15 Aug 2023 17:36:29 -0300
Message-ID: <20230815203635.400179-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815203635.400179-1-dbarboza@ventanamicro.com>
References: <20230815203635.400179-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x334.google.com
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
index d78afe99f1..ca20dc1e96 100644
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
index b1fd2233c0..c16b7fe3c7 100644
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


