Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2253C711FEE
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2QtW-0005LG-AL; Fri, 26 May 2023 02:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1q2QtP-0005Ep-ND
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:25:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1q2QtM-0000qw-Jp
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:25:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ae452c2777so3926905ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 23:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1685082335; x=1687674335;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1C0UYjIrCFodvNRiqEHXxZVoFTPAVZq1EdtJGjVqtXw=;
 b=P2aBusqCin3KnObGgGF5eGu8p2r5/nP2VJObx5uYw0Lox8eJTn+A1KKP5HhXIBOPyA
 958PSIPsGjMIfY48KDM9eWTUGjqvOsUM65/L+tBIyv3sOe3kTyoL0qr3GF8EBf8I0dVr
 P0f7KRLQyxWGOScUTlG6aqhZPeB5VILv7nS8omySEJMKvE54NiTXNLbKHQxrsKFHXY1g
 FOqY0/QZDsra3L92+1iPnGt6FwFaCWymuugVitJ99WGPj3AYtxB8EgUjfGR7Lg3wna/+
 C6SS3i+wiO0DHFCIY9IhEeHYgodzq+muz67Jyc0n8bGM611wbzuJ+qXyv+1kMyXyr76U
 L2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685082335; x=1687674335;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1C0UYjIrCFodvNRiqEHXxZVoFTPAVZq1EdtJGjVqtXw=;
 b=ckvTiCZRm0mmx7jlxzMNLLU58x+0rR+2HN+Y7hjDjQDtyIrN6lcL0njDYNBcqSK3vW
 MTh3JYL4FcZxHuKJ/5asiYq4OLnL59HVavZiIC9hWGu0m5LHcv3Dvsz0hLTdisfG9eor
 ebrrUNqTOnqFL/6VH2EPEkBzUnxngVee1dlsmA5LbRX87+XEMF4uvWlm1YIezAFlFBDH
 2esM/iiIOIjpU9d1rWpUMGsF0qOoOM2pgGe+o5SdorK6jFbCdjxV+34Ju+n8SlvPT449
 lKs+qk4WuFkGCX8CY/aOevNlJnRMXeAZJ1hj96WLqhtk7bAtQmQhglhF5rAEw66k6M8e
 dA4A==
X-Gm-Message-State: AC+VfDy3gv8mPg0nhSvQugIX5Ey78V/I5qcPEv1TUHc81P9zr2L1R+4v
 UrG1f32ui2FPf2pSA77fGuUJBs5nT+x0u8MH05dUuaru+b1ryHVQuuTDKN3PKSqxneiM8NzegyE
 4VBkREu13KpfwxdMKlzDW6AtaVAQVgY1lDLo/bJS77b9UHVH/gHQ2IcfQQ1RPPNmFep+U8BTb+r
 Qvb9C0
X-Google-Smtp-Source: ACHHUZ6wa1D5MjwdLipRo87u4avsi3ZvaKHVUVuYnS+XPlQ4eL5pJcH7Ig8zM3dMs+bFu8rKL6qmog==
X-Received: by 2002:a17:902:c40e:b0:1b0:7cc:982a with SMTP id
 k14-20020a170902c40e00b001b007cc982amr1208190plk.5.1685082334910; 
 Thu, 25 May 2023 23:25:34 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a170902bb9800b001a94a497b50sm2429150pls.20.2023.05.25.23.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 23:25:34 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, rkanwal@rivosinc.com,
 anup@brainfault.org, dbarboza@ventanamicro.com, atishp@atishpatra.org,
 vincent.chen@sifive.com, greentime.hu@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com
Cc: Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v3 4/6] target/riscv: Create an KVM AIA irqchip
Date: Fri, 26 May 2023 06:25:04 +0000
Message-Id: <20230526062509.31682-5-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526062509.31682-1-yongxuan.wang@sifive.com>
References: <20230526062509.31682-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x635.google.com
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

implement a function to create an KVM AIA chip

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/kvm.c       | 83 ++++++++++++++++++++++++++++++++++++++++
 target/riscv/kvm_riscv.h |  3 ++
 2 files changed, 86 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index eb469e8ca5..ead121154f 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -34,6 +34,7 @@
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
+#include "hw/intc/riscv_imsic.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "kvm_riscv.h"
@@ -548,3 +549,85 @@ bool kvm_arch_cpu_check_are_resettable(void)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
+
+void kvm_riscv_aia_create(DeviceState *aplic_s, bool msimode, int socket,
+                          uint64_t aia_irq_num, uint64_t hart_count,
+                          uint64_t aplic_base, uint64_t imsic_base)
+{
+    int ret;
+    int aia_fd = -1;
+    uint64_t aia_mode;
+    uint64_t aia_nr_ids;
+    uint64_t aia_hart_bits = find_last_bit(&hart_count, BITS_PER_LONG) + 1;
+
+    if (!msimode) {
+        error_report("Currently KVM AIA only supports aplic_imsic mode");
+        exit(1);
+    }
+
+    aia_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_RISCV_AIA, false);
+
+    if (aia_fd < 0) {
+        error_report("Unable to create in-kernel irqchip");
+        exit(1);
+    }
+
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                            KVM_DEV_RISCV_AIA_CONFIG_MODE,
+                            &aia_mode, false, NULL);
+
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                            KVM_DEV_RISCV_AIA_CONFIG_IDS,
+                            &aia_nr_ids, false, NULL);
+
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                            KVM_DEV_RISCV_AIA_CONFIG_SRCS,
+                            &aia_irq_num, true, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: fail to set number input irq lines");
+        exit(1);
+    }
+
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                            KVM_DEV_RISCV_AIA_CONFIG_HART_BITS,
+                            &aia_hart_bits, true, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: fail to set number of harts");
+        exit(1);
+    }
+
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR,
+                            KVM_DEV_RISCV_AIA_ADDR_APLIC,
+                            &aplic_base, true, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: fail to set the base address of APLIC");
+        exit(1);
+    }
+
+    for (int i = 0; i < hart_count; i++) {
+        uint64_t imsic_addr = imsic_base + i * IMSIC_HART_SIZE(0);
+        ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR,
+                                KVM_DEV_RISCV_AIA_ADDR_IMSIC(i),
+                                &imsic_addr, true, NULL);
+        if (ret < 0) {
+            error_report("KVM AIA: fail to set the base address of IMSICs");
+            exit(1);
+        }
+    }
+
+    if (kvm_has_gsi_routing()) {
+        for (uint64_t idx = 0; idx < aia_irq_num + 1; ++idx) {
+            kvm_irqchip_add_irq_route(kvm_state, idx, socket, idx);
+        }
+        kvm_gsi_routing_allowed = true;
+        kvm_irqchip_commit_routes(kvm_state);
+    }
+
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CTRL,
+                            KVM_DEV_RISCV_AIA_CTRL_INIT,
+                            NULL, true, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: initialized fail");
+        exit(1);
+    }
+}
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index 606968a4b7..6067adff51 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -21,6 +21,9 @@
 
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
+void kvm_riscv_aia_create(DeviceState *aplic_s, bool msimode, int socket,
+                          uint64_t aia_irq_num, uint64_t hart_count,
+                          uint64_t aplic_base, uint64_t imsic_base);
 
 #define KVM_DEV_RISCV_AIA_GRP_CONFIG            0
 #define KVM_DEV_RISCV_AIA_CONFIG_MODE           0
-- 
2.17.1


