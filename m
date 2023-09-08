Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E1D7981FE
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:10:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUfd-0006AQ-La; Fri, 08 Sep 2023 02:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfa-00063L-Uc
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfY-0008Eu-Eg
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:42 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68c576d35feso1615807b3a.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153318; x=1694758118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Qu073TjSctnDYoeikMwne9G4Nlj9hLM/T7NvyQrYNY=;
 b=rJIY9kd9LKqmycWQrpRhvDizeuGzb8L9lxZV2O5DUnJCkszpNBJ8Pr9Frm/YRsgbeD
 Nnx6b0akK1nBeQKeP6nPNuqikO7bOrCzvPNIZkZ1FMNfJVxbt6i5I302BKGfEnhrK9rb
 6QSw09xdlg57arwOVy7eaHYhckv9kCWFwVUsnndx8sgF1nO/YRAoYQuE0gaNeplXYqZn
 2YvRw4z8/tuwquvQhCYCfa8DwsSdo3iR7v6g5ETEFAys4ijiFAQbThXPE/SjWP/Rdv2R
 zydoA8ruAWt6tsq3MtK4QNmtzqTi/3gwiizeYoM5d3iBEjxe4kuDFuq16+7arg0ib4W+
 hMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153318; x=1694758118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Qu073TjSctnDYoeikMwne9G4Nlj9hLM/T7NvyQrYNY=;
 b=uDsDgHvctNYFFaS+OzwczGIHmLl9LkQBQ33Wc75ib2jRq8fhG7vQWCl4TvuY9xH67N
 bVti+ysdv02lGAwksUPHYWfnxNBbx9w83o99VTnEYZRHnDvMOHOSRYhFVrokFw3+74Sq
 oB53SIlnWd1QIHhZA8wMcXuoLv0aKfQU5PjhgEZ2SJUQclCN5FsbWjOMfymd5ZIQ/ofd
 zuBestqc/CJt5jDATaI1ehY0cchJuXYLFWfQb/3U4ejdWCqat9RnbWYRGiZ7uS+Pxj73
 XfiwHcnlMRLLfxTTJMVzC99OQAO0Mt74nJ/dHw1uzqUNczWafWjtYOlujrc7DdHINhHt
 Lweg==
X-Gm-Message-State: AOJu0YzHk9D5AC1lUwQ/GGKsYt4y/bm7de2ZN0ivVexnLBO2Vnzk3vx2
 lwmobJKUJkuTJdxwUvK9JGrHNFkqrygnRXCn
X-Google-Smtp-Source: AGHT+IFla0r6tNZsf1vf4xY4oTjwbMDAZRyuRbkCSt34yoya7MnfDIxWTcqOZjohuCmE+5tNY+cqRQ==
X-Received: by 2002:a05:6a20:1604:b0:149:122b:6330 with SMTP id
 l4-20020a056a20160400b00149122b6330mr2398559pzj.10.1694153318627; 
 Thu, 07 Sep 2023 23:08:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:08:37 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 59/65] target/riscv: make CPUCFG() macro public
Date: Fri,  8 Sep 2023 16:04:25 +1000
Message-ID: <20230908060431.1903919-60-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

The RISC-V KVM driver uses a CPUCFG() macro that calculates the offset
of a certain field in the struct RISCVCPUConfig. We're going to use this
macro in target/riscv/cpu.c as well in the next patches. Make it public.

Rename it to CPU_CFG_OFFSET() for more clarity while we're at it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230901194627.1214811-15-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 2 ++
 target/riscv/cpu.c | 2 +-
 target/riscv/kvm.c | 8 +++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

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
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 03e936348a..43c68e1792 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -48,7 +48,7 @@ struct isa_ext_data {
 };
 
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
-    {#_name, _min_ver, offsetof(struct RISCVCPUConfig, _prop)}
+    {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
 
 /*
  * From vector_helper.c
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index c01cfb03f4..14763ec0cd 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -205,10 +205,8 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
-#define CPUCFG(_prop) offsetof(struct RISCVCPUConfig, _prop)
-
 #define KVM_EXT_CFG(_name, _prop, _reg_id) \
-    {.name = _name, .offset = CPUCFG(_prop), \
+    {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
      .kvm_reg_id = _reg_id}
 
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
@@ -285,13 +283,13 @@ static void kvm_cpu_set_multi_ext_cfg(Object *obj, Visitor *v,
 
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


