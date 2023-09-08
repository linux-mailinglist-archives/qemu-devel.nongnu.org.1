Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A070479820F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:11:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUdy-00049V-Tf; Fri, 08 Sep 2023 02:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdv-0003vQ-Hl
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:59 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUds-0006Wa-GT
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c1f8aaab9aso14771075ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153214; x=1694758014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YFC/Wd1PZEGT1vXAEy/Fv/qkqYKA8VvtbmwE/sCiNlE=;
 b=SzggFB3poeOPTgMsn/VVhUZAAb7UX/AmZeq/HDFVnHMnCDDXbn0+7wTL6kUQL++9XX
 QVq26ddCUH09dFR35ljgArviAP/NgIs5JVB2Titr/BYsRyvQbOZo9dpPp8V86ELXdvZj
 zTh0Ie17TMSpgzXRiYa/RM0nGiRiHcxfMSrOg55zVzDUKTIBezFQ91pbKGWKDFELw2f7
 C9am93B0qGHKRg1qjXde6G1Ktx6qVUQbgCmE5krzUUD5T9t6AZsBEfYGbdXXKJQjCAZb
 yIXkIJuUtPy2GnaMD3Ysot7ss/bsUIDFqr3O7rH1YcbrmhOpr6aHDFy/n5wlMx5KnpX5
 S37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153214; x=1694758014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFC/Wd1PZEGT1vXAEy/Fv/qkqYKA8VvtbmwE/sCiNlE=;
 b=Yet0rpnL9GlJpYO8C7Vx/7Ucg4RFziZj023exkiyVgAl6/vSb6a025VQNJL0A0io80
 T3rGYbVvwV7pkPuFTUoIs2K02uFU8267mNVlfQm3tqg7lLMoVN4HTaJkU3GgxnBvNhrv
 SU910jXqwWxgyaV56cv3+ky8rBgOdy7h11HQDFRfYT0wQl7TBXc3hszbSVBXmebny3Tf
 MOqG7zONxuSCTa533/M82/c7lwClqtZsr++yKuXW4zXWuiOkYZUeEtM0jXJbFp+aSB88
 K54jk0/5YBfD3dZK5MYvY2pdmm1dXMukYae3fGdbuyRRWoPRXcvTgbxis9FVzTvXrMJp
 wHDg==
X-Gm-Message-State: AOJu0YwBe5COzLJDcZe/876cl8e3gvzrX0s3fZWd3khHB/pw8lhzSXLp
 1zcRvHnAUfeDvJ+mTA7U1te903++NE1dgeLa
X-Google-Smtp-Source: AGHT+IETlzgjeG7GJWqeJMN8KGJilPSjlKpysMsiBDpa2ctynYijNRLrt+cJ4Vv0uDT0wCOnZVWkGQ==
X-Received: by 2002:a17:902:ec88:b0:1c0:d19a:9829 with SMTP id
 x8-20020a170902ec8800b001c0d19a9829mr1637501plg.25.1694153214381; 
 Thu, 07 Sep 2023 23:06:54 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/65] target/riscv: Create an KVM AIA irqchip
Date: Fri,  8 Sep 2023 16:03:57 +1000
Message-ID: <20230908060431.1903919-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

We create a vAIA chip by using the KVM_DEV_TYPE_RISCV_AIA and then set up
the chip with the KVM_DEV_RISCV_AIA_GRP_* APIs.
We also extend KVM accelerator to specify the KVM AIA mode. The "riscv-aia"
parameter is passed along with --accel in QEMU command-line.
1) "riscv-aia=emul": IMSIC is emulated by hypervisor
2) "riscv-aia=hwaccel": use hardware guest IMSIC
3) "riscv-aia=auto": use the hardware guest IMSICs whenever available
                     otherwise we fallback to software emulation.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230727102439.22554-4-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm_riscv.h |   4 +
 target/riscv/kvm.c       | 186 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+)

diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index e3ba935808..7d4b7c60e2 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -22,5 +22,9 @@
 void kvm_riscv_init_user_properties(Object *cpu_obj);
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
+void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
+                          uint64_t aia_irq_num, uint64_t aia_msi_num,
+                          uint64_t aplic_base, uint64_t imsic_base,
+                          uint64_t guest_num);
 
 #endif
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 2953547cb6..6e909d0fdd 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -36,6 +36,7 @@
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
+#include "hw/intc/riscv_imsic.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "kvm_riscv.h"
@@ -43,6 +44,7 @@
 #include "chardev/char-fe.h"
 #include "migration/migration.h"
 #include "sysemu/runstate.h"
+#include "hw/riscv/numa.h"
 
 static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
                                  uint64_t idx)
@@ -1035,6 +1037,190 @@ bool kvm_arch_cpu_check_are_resettable(void)
     return true;
 }
 
+static int aia_mode;
+
+static const char *kvm_aia_mode_str(uint64_t mode)
+{
+    switch (mode) {
+    case KVM_DEV_RISCV_AIA_MODE_EMUL:
+        return "emul";
+    case KVM_DEV_RISCV_AIA_MODE_HWACCEL:
+        return "hwaccel";
+    case KVM_DEV_RISCV_AIA_MODE_AUTO:
+    default:
+        return "auto";
+    };
+}
+
+static char *riscv_get_kvm_aia(Object *obj, Error **errp)
+{
+    return g_strdup(kvm_aia_mode_str(aia_mode));
+}
+
+static void riscv_set_kvm_aia(Object *obj, const char *val, Error **errp)
+{
+    if (!strcmp(val, "emul")) {
+        aia_mode = KVM_DEV_RISCV_AIA_MODE_EMUL;
+    } else if (!strcmp(val, "hwaccel")) {
+        aia_mode = KVM_DEV_RISCV_AIA_MODE_HWACCEL;
+    } else if (!strcmp(val, "auto")) {
+        aia_mode = KVM_DEV_RISCV_AIA_MODE_AUTO;
+    } else {
+        error_setg(errp, "Invalid KVM AIA mode");
+        error_append_hint(errp, "Valid values are emul, hwaccel, and auto.\n");
+    }
+}
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
+    object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia,
+                                  riscv_set_kvm_aia);
+    object_class_property_set_description(oc, "riscv-aia",
+                                          "Set KVM AIA mode. Valid values are "
+                                          "emul, hwaccel, and auto. Default "
+                                          "is auto.");
+    object_property_set_default_str(object_class_property_find(oc, "riscv-aia"),
+                                    "auto");
+}
+
+void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
+                          uint64_t aia_irq_num, uint64_t aia_msi_num,
+                          uint64_t aplic_base, uint64_t imsic_base,
+                          uint64_t guest_num)
+{
+    int ret, i;
+    int aia_fd = -1;
+    uint64_t default_aia_mode;
+    uint64_t socket_count = riscv_socket_count(machine);
+    uint64_t max_hart_per_socket = 0;
+    uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
+    uint64_t socket_bits, hart_bits, guest_bits;
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
+                            &default_aia_mode, false, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: failed to get current KVM AIA mode");
+        exit(1);
+    }
+    qemu_log("KVM AIA: default mode is %s\n",
+             kvm_aia_mode_str(default_aia_mode));
+
+    if (default_aia_mode != aia_mode) {
+        ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                                KVM_DEV_RISCV_AIA_CONFIG_MODE,
+                                &aia_mode, true, NULL);
+        if (ret < 0)
+            warn_report("KVM AIA: failed to set KVM AIA mode");
+        else
+            qemu_log("KVM AIA: set current mode to %s\n",
+                     kvm_aia_mode_str(aia_mode));
+    }
+
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                            KVM_DEV_RISCV_AIA_CONFIG_SRCS,
+                            &aia_irq_num, true, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: failed to set number of input irq lines");
+        exit(1);
+    }
+
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                            KVM_DEV_RISCV_AIA_CONFIG_IDS,
+                            &aia_msi_num, true, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: failed to set number of msi");
+        exit(1);
+    }
+
+    socket_bits = find_last_bit(&socket_count, BITS_PER_LONG) + 1;
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                            KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS,
+                            &socket_bits, true, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: failed to set group_bits");
+        exit(1);
+    }
+
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                            KVM_DEV_RISCV_AIA_CONFIG_GROUP_SHIFT,
+                            &group_shift, true, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: failed to set group_shift");
+        exit(1);
+    }
+
+    guest_bits = guest_num == 0 ? 0 :
+                 find_last_bit(&guest_num, BITS_PER_LONG) + 1;
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                            KVM_DEV_RISCV_AIA_CONFIG_GUEST_BITS,
+                            &guest_bits, true, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: failed to set guest_bits");
+        exit(1);
+    }
+
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR,
+                            KVM_DEV_RISCV_AIA_ADDR_APLIC,
+                            &aplic_base, true, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: failed to set the base address of APLIC");
+        exit(1);
+    }
+
+    for (socket = 0; socket < socket_count; socket++) {
+        socket_imsic_base = imsic_base + socket * (1U << group_shift);
+        hart_count = riscv_socket_hart_count(machine, socket);
+        base_hart = riscv_socket_first_hartid(machine, socket);
+
+        if (max_hart_per_socket < hart_count) {
+            max_hart_per_socket = hart_count;
+        }
+
+        for (i = 0; i < hart_count; i++) {
+            imsic_addr = socket_imsic_base + i * IMSIC_HART_SIZE(guest_bits);
+            ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR,
+                                    KVM_DEV_RISCV_AIA_ADDR_IMSIC(i + base_hart),
+                                    &imsic_addr, true, NULL);
+            if (ret < 0) {
+                error_report("KVM AIA: failed to set the IMSIC address for hart %d", i);
+                exit(1);
+            }
+        }
+    }
+
+    hart_bits = find_last_bit(&max_hart_per_socket, BITS_PER_LONG) + 1;
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                            KVM_DEV_RISCV_AIA_CONFIG_HART_BITS,
+                            &hart_bits, true, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: failed to set hart_bits");
+        exit(1);
+    }
+
+    if (kvm_has_gsi_routing()) {
+        for (uint64_t idx = 0; idx < aia_irq_num + 1; ++idx) {
+            /* KVM AIA only has one APLIC instance */
+            kvm_irqchip_add_irq_route(kvm_state, idx, 0, idx);
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
+
+    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
 }
-- 
2.41.0


