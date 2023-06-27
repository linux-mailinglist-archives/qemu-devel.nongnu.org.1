Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC9740159
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:35:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBd0-0004EK-Pm; Tue, 27 Jun 2023 12:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBcs-000489-77
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:33:10 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBcq-00050L-MS
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:33:09 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1b060bce5b0so778078fac.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687883587; x=1690475587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCyEYTCurZlKeBb+smp4iBapbYzZbkqtdlsgVYmzaks=;
 b=cMFgPUoaW+uwcHq7JBXVNfZVDoT2oLLZi5P8QVyentU8gidzJvbNPy+G0TChsOjaII
 NN7quT3mZa/ZwHsBMBXUKc8KMgrboNh1ECWQt7nHF7PW9UmSjge232nmkwkLt+23SJ0x
 MJj7ldR8BdjOA2lzzzzEfXiZTU2OgywT0xBpLhVieirOGSrU/AQOuaexmTvHdeKjOJT7
 P+JRbp69e3AXrDlEKPgMTInube1nQiQO2x4bvzXET1T9U7Jys9YDu48Ii7nWeftP3J2w
 318Mbqej70QxdehT3Nq9kohz3DO3q9Z0w1A+tefF13JrQSN2b7WCg9kZmgB+6X6zYDss
 ioZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687883587; x=1690475587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCyEYTCurZlKeBb+smp4iBapbYzZbkqtdlsgVYmzaks=;
 b=WpuRa6H9cUiEHrDEK7nDvwfNnviOmUxGNE4nDvqJ5euMxn2M4G9Q3hV11jXW9/Oyco
 2rf/g03N1TwMOVIc6LQNC91oxXSFBn5Q/GijTaOCLrxeSXwCE/d3KhMYmD+BVvDEcgdW
 bUILiV9ju07P7btn+GbSZC4z78R9W0Ng+jzArBI0LjDzTIlJFTgzo3rWIuN1M21WGR9A
 yeg5FTUUnTzU7sDYspdaj3OB+rrPeU2zPO6x2r78WLtjbKwrSi2lwljWeefvjHl7bIUD
 iBId/oeOg5mVYOZH4iPLCWqRPHgJXCGY7BBPsb9W0TNKnQ60EK+8DU03x7nGBYmIlGrT
 W0xg==
X-Gm-Message-State: AC+VfDzllQaPnMn0kZOx7vn3Yc1Zn3isYtb8MDf4uIOgoZp+p5a249+P
 o9jgiwuz6IJ+jTjrtH0lZmU4viEUoSH0l0qDne4=
X-Google-Smtp-Source: ACHHUZ7Irv7IAxUf/vwUxBHZAFaOo9csvQKIAqOxFi4st/XmE1A9p7gkqN8lqDseY12EjfOElzeScA==
X-Received: by 2002:a05:6870:7342:b0:1b0:2bff:b9b5 with SMTP id
 r2-20020a056870734200b001b02bffb9b5mr6987933oal.47.1687883587485; 
 Tue, 27 Jun 2023 09:33:07 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 gu17-20020a056870ab1100b001a3093ec23fsm5254134oab.32.2023.06.27.09.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:33:07 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 18/19] target/riscv/kvm.c: add kvmconfig_get_cfg_addr()
 helper
Date: Tue, 27 Jun 2023 13:32:02 -0300
Message-ID: <20230627163203.49422-19-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627163203.49422-1-dbarboza@ventanamicro.com>
References: <20230627163203.49422-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2e.google.com
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


