Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3142741AF6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:32:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEcmB-0004wf-Su; Wed, 28 Jun 2023 17:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEcm9-0004bM-3V
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:32:33 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEcm6-0000Nx-KW
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:32:32 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-56584266c41so283857eaf.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687987949; x=1690579949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTu4I+IbylsievNIKCcfpk2plmgKnmy/lQ3yGoAND/E=;
 b=dCjVuIex4r7suoDrJcS0s0RSec8Pz80tsqQujAwmazuiB1z/gRZ8QDa023K+SXwpB9
 6BZ2XykLERZEmwgRdcxc/vYJKFO0VBMijtfDP7wEezLYSZRKKx3aOps+tbxoS0HcJrex
 1x09QlFr+4bSOruPm7FeWhcSpqFLgdg13k3sv4x+g4YtYfBxGqQJP1tN4IYNgAfdbjU2
 9xypgzzmB0Va8d+L3u2tWCGE/9n+my+/My21o3oRZ7knjuH/9vh2AY9zQrFlj+Idm9zA
 3O8EJAJzpy/Zm4CHW9ty35ieY59ib+OeuprVEvnYlNisYJcLmo1jLO3LU5Y0BwJyKTiY
 jzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687987949; x=1690579949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTu4I+IbylsievNIKCcfpk2plmgKnmy/lQ3yGoAND/E=;
 b=UxD1y2jd86/DZ4J1WM+ZPf+NnZM1U7YWzIiE5WboSkD8vUcGe0Geok13nghhckIApa
 k2XIuuInuAU3vMGAGqSMXec98WFWGbfE1tUZPpbZw88Svo3CQ/iDXm0Dqxm+q2eqdwTu
 DEed7mQsqRVLIIuNTm2+EbSWHhVHZGXg36xjh4KwMYI8dOtNKxkc3vzQEc3pR1/+fTi1
 EWL33QRJrxjXD2iSYj0ZuGHAtA4ktXE+U1n2+v7Y2+y+Tu+Jd4KVa9BAu97WzLaKZVvc
 eUsbA3COioyVIbDalFABIOgNFUv1AsMyH6Zq0vuba2lJmW13/Ituap0zuZpvH2L1GIoH
 YJ0Q==
X-Gm-Message-State: AC+VfDyOhJfjsw8O10pWBq+kA/LvO2LxOBWbOzi4gXzWbDXyjCzgBjAv
 uerqVavsiFM+711nsT6q7ZeSEjnu9GkugouSybo=
X-Google-Smtp-Source: ACHHUZ5n4UfUlJiXDe5wr9+wecnSb9n/SXBcuOvsf4PYwYM5JZ4azJbRvvRD1JgjChA25qdo3xZRIQ==
X-Received: by 2002:a4a:e1a5:0:b0:562:f872:3b8c with SMTP id
 5-20020a4ae1a5000000b00562f8723b8cmr15606167ooy.3.1687987949201; 
 Wed, 28 Jun 2023 14:32:29 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a4a4511000000b0056084a91c74sm832892ooa.24.2023.06.28.14.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:32:28 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 19/20] target/riscv/kvm.c: add kvmconfig_get_cfg_addr()
 helper
Date: Wed, 28 Jun 2023 18:30:32 -0300
Message-ID: <20230628213033.170315-20-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628213033.170315-1-dbarboza@ventanamicro.com>
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2d.google.com
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
index aa4edc8a56..d1bf518893 100644
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


