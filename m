Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E08749013
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 23:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAFK-0005h6-Sg; Wed, 05 Jul 2023 17:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAFE-0005W1-EU
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:41:08 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAFC-0001s8-TR
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:41:04 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6b75637076eso3583a34.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688593261; x=1691185261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlLQjagViR0FyfdG19YZGqTlXXHzWIymhpifchyyRcs=;
 b=aFjpuVs/VgTFQyi6u4L4GzEjgrOtUXjgji6dDiPFAutgRQzEMAPnQ9+qObFpM7+xAh
 wCUGIg0f4xvph1TIrGEStLZy40Fr4s86jKkmp2DpVM3KA1PiLeDainyENP/p5MxbARq9
 iK/Dqf1Dz8sWTmUjHY2ECSKnaf0rr0WcXkD5s8puHfEWNB7m/KRV+kheFDOj5y7f0S4e
 q2CBKgfofuVd1QnEZ/ZLunF9mrxRfSnwZayO8i9W12Syu6rOexow5iaUSK3vBC5hdOCG
 lVEI5eBBIYqDKwn7naG05pPtra10e9zA4DMXN8P/aMGgIhbYfSXfYZHsxM8tRrTdIycA
 qVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688593261; x=1691185261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlLQjagViR0FyfdG19YZGqTlXXHzWIymhpifchyyRcs=;
 b=PlSsBFW7WeHP+6+MHYUBRxvokAPfMi7u2RggXfkeLIR7DV3qBuCWmEVhHyCxZ4uC9O
 0uhQ5qIQECdZ6Fa52DdwFu0Wy1oeBFWVUc6/ow5cIwi//Py7RlVekIjr4HfFHIWQmKMt
 QSDxQpbevTEudOpjJsfuqGjWjgJsWZth6QOCOUi5I2oTKFLo0vtqoTyeJj66kT18kRhX
 0OxzysL6X4v9lciE/BgTKaVcsexMtLuJeVcwNmwitOMCyHejfoCbZxwJexTGVK5/VshG
 JyyPfzDAaJ7FHnQamSXDXEyEial7rCvUOiD8vBV/UvuZPviBsU/c1juA3SdfFZNBCQu6
 XMNw==
X-Gm-Message-State: ABy/qLZ6u6HrsHYNQf3XxyN+6zBVRxweVpq8gwahmPXYjLkGH6jZzNuu
 BdRk+8+yURbbWp0wcv6y+gpWLo0bmlcVqYLMROg=
X-Google-Smtp-Source: APBJJlEVWYGIb1dJ48+N4XalRs4NVD9FrIY6oEDh5vQ6QB+zYDYtXyO5lYvf3DPChLDUMWaOYJnzWQ==
X-Received: by 2002:a05:6871:723:b0:1b3:93ad:70b with SMTP id
 f35-20020a056871072300b001b393ad070bmr275096oap.27.1688593261537; 
 Wed, 05 Jul 2023 14:41:01 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a4add01000000b0056665a16536sm70764oou.30.2023.07.05.14.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 14:41:01 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 19/20] target/riscv/kvm.c: add kvmconfig_get_cfg_addr()
 helper
Date: Wed,  5 Jul 2023 18:39:54 -0300
Message-ID: <20230705213955.429895-20-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705213955.429895-1-dbarboza@ventanamicro.com>
References: <20230705213955.429895-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x332.google.com
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
index 55ea189520..d503e03078 100644
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


