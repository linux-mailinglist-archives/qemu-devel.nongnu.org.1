Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C8D73EE63
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:08:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuJS-0005bf-Gd; Mon, 26 Jun 2023 18:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuIf-0002uf-MH
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:03:10 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuId-000638-VC
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:03:09 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1b0138963ffso2685153fac.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687816986; x=1690408986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCyEYTCurZlKeBb+smp4iBapbYzZbkqtdlsgVYmzaks=;
 b=VMj2ZaRzIM3zCWRQZCZVCLeXCVXYpLoYlvOcbSDV42TdHpzFnBa6+ldRRXfOU7ZzyK
 ujqk90NibCwq4z62vZ/M8sHyhMKlIT5uwYksE8y3V1B+JfpyE+X6bhg3RUnpPF6ZWnL7
 ZXOCJ6i5ae+z48kpJ5k6eOt5LLR1JqdUBt9zjU1wjVPRXfI72gyv1bdlTx7w78UbgB6u
 0D8t/COEJUvBRhvMLQU6gOrcD96xHw3QjhOsU0Yhd4AVM2DiaObk0R75T7DZhKCki1rh
 htjTmEERa4n7mOp6LSjz+xsq30M9WFWMJHswOaWksAppJZ7T9+wtUgLLhyruUS8wmc34
 hgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816986; x=1690408986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCyEYTCurZlKeBb+smp4iBapbYzZbkqtdlsgVYmzaks=;
 b=Z/REs7ELRYv140ZZPlFRCSP50DtARSA3kGARtrqybcTVKKMawc7m5g8GVK38jyy32p
 I/SUhVblPupvhUKoBEt6yTuMo/2QWJYf3djgX2lQBXdpJGR+mJcYWslMDima1mEwphp3
 LyWusAE0xhkX3mYkE+1toonrg3KsDKMYtncYjp4gnpC2bZuwOVTcubUK65+deWbHIFVI
 aJQp8yPWiK7oqLkyONTbV6N8hLlWfatUX1Ab3xPcDwepKOIQbs3jfp8c+cHTZa1IUgUL
 qyiuxknIP1M6FudjVIYo+SSSaWmqYUxwvL7Vu0ERdcmZBpVLIDmr0/lxDNSbxSQFWSZQ
 yrIA==
X-Gm-Message-State: AC+VfDy2QStepVDyX2CUVb5PUyijiRu05brWo5knqg2dHpUuVoyi1xi6
 rLeF5HNES6a9X8DuKnM2FpQxK3jI4V/gzvkzZ0E=
X-Google-Smtp-Source: ACHHUZ5Z9XvLNR3QNGu7wkriINv+aeyQeH/dKWDA428ptEpc2MoKjr2botLXBo8bA4Sn5lwc4ZddMg==
X-Received: by 2002:a05:6870:1a90:b0:1b0:432d:acae with SMTP id
 ef16-20020a0568701a9000b001b0432dacaemr2827751oab.39.1687816986295; 
 Mon, 26 Jun 2023 15:03:06 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056870a10c00b001b03fbfa0c5sm1831419oae.39.2023.06.26.15.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:03:06 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 18/19] target/riscv/kvm.c: add kvmconfig_get_cfg_addr()
 helper
Date: Mon, 26 Jun 2023 19:02:08 -0300
Message-ID: <20230626220209.22142-19-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626220209.22142-1-dbarboza@ventanamicro.com>
References: <20230626220209.22142-1-dbarboza@ventanamicro.com>
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

There are 2 places in which we need to get a pointer to a certain
property of the cpu->cfg struct based on property offset. Next patch
will add a couple more.

Create a helper to avoid repeating this code over and over.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 6eebeb123a..e8f6683030 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -215,11 +215,15 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),
 };
 
+static void *kvmconfig_get_cfg_addr(RISCVCPU *cpu, KVMCPUConfig *kvmcfg)
+{
+    return (void *)&cpu->cfg + kvmcfg->offset;
+}
+
 static void kvm_cpu_cfg_set(RISCVCPU *cpu, KVMCPUConfig *multi_ext,
                             uint32_t val)
 {
-    int cpu_cfg_offset = multi_ext->offset;
-    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
+    bool *ext_enabled = kvmconfig_get_cfg_addr(cpu, multi_ext);
 
     *ext_enabled = val;
 }
@@ -227,8 +231,7 @@ static void kvm_cpu_cfg_set(RISCVCPU *cpu, KVMCPUConfig *multi_ext,
 static uint32_t kvm_cpu_cfg_get(RISCVCPU *cpu,
                                 KVMCPUConfig *multi_ext)
 {
-    int cpu_cfg_offset = multi_ext->offset;
-    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
+    bool *ext_enabled = kvmconfig_get_cfg_addr(cpu, multi_ext);
 
     return *ext_enabled;
 }
-- 
2.41.0


