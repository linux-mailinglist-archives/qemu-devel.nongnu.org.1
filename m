Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E835AA99D93
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 03:01:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kvC-0000h4-Qi; Wed, 23 Apr 2025 20:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kti-000667-73
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:04 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktc-00058T-FB
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:01 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so346792b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456215; x=1746061015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SkVIVJhYhjnAUQzC6lgapFUmJ317qZlaiCgQmtHCvg=;
 b=x/rLx0bWqQD4qlJ0aT5cSvQMTEAwwXMbcSjA7JchhWrdaz4jQNM5SxiOa+SVK7v9gG
 OJubKE9+31RG+xSiYpDPJdS5+0jyhQkm2g9NV3/GFcU5QlTFYZrfdG6P7qmExS7Foeb/
 OkfsXf+84EwtgZ+ybY7ZVinXabsgq+z8BDT74IDueQ1TE/GyBlbB27U9O2cFynl++j5j
 EaC+zuhCbTsFoAlAcpFMAZOu7ETtWJ3BBts590z8IHR2vA8UxuK6XkBnf8lqMidYhkwZ
 OcmQtHYHRR2InuII1cOynk4PPt162hc3GD1jw4H6Ou2g74xkzhUaDEROtXsT3Km9sXAq
 Ly7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456215; x=1746061015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5SkVIVJhYhjnAUQzC6lgapFUmJ317qZlaiCgQmtHCvg=;
 b=YK7DYooo3bWMBKwvZOxvXoeRyyn4QWu33A5YcKubexinxo4JhdSpzb1f0Sq+4YYIge
 RrY/Aj5svHQ/i7iIDzef9XToWgdTq7wjcHd3KAJxS2IvSe5yj3LiXSBI3RhZ7hWgUnzP
 oszaSLjO2mo0FJ3dGIfj+MG/i8EroUZWpvOonLm5l4ZyalnC6Uz+hJ2Sa5A5Va8zuUyo
 ehJzH3wvW0UloC9+Z2uy1Y8qOeFKGg2xN6EcISIn43ktdJ9rEQs/CFxJ00DiwhQ1GcdS
 dJBQilrNKMoQPiWm8gf9vYlof0ewXelyheZRiRPMoHm72QGIWBd36Qhy3SnRzkKuASU0
 LAbQ==
X-Gm-Message-State: AOJu0YyCJ+hvqZDTc/wtese3rIDyPYI6pyk3J8a7w630zrf3QL5WHsbU
 8hH5J1Wl/s88f6ita+Up565kB4qLodZzHe6xhLG22NX2Z6NQQu5S+JV82mD8FmiAEyS5GHK7//i
 o
X-Gm-Gg: ASbGncuWMULV6lXTbRNeoaanDTuvXfHNdK7cjfEqz49czj7pcyCQQS+2cXhvR96WA2c
 fQwaBPZ1mXeXfdUPw23wKDxa1Mf4ONZnD8u8yS6c7+azy5DLGz9DhlxUV3fnAZv0r8DaX+t+WLL
 O4p/UBhQ/gzjxM+7Yycj8Cnrh7z145XnL4xmUdH3L3vl8lICaaRIXlAGTv6z02hHtXl0fCkpgVF
 t+QuSOsUB0Vpn5fAOfK+atjhGJBG/pK/imjAWoOXwy+KSqywasCtp5wacGwVoIW5unuApcUx3Au
 fpttS6g1lqqyfMiBg+p9UQo9pGR3XlpUeXjDVfP+jsGq6ApWF8ex+UPDKTVcFLvDRt/qJYzWe1A
 =
X-Google-Smtp-Source: AGHT+IGI0iO672xlV8Hq81eJJMdVkfMLr0UaJkr4TTas+BY3Zr50tGZ5SzTX9OrEixBXECbpbcO4xg==
X-Received: by 2002:a05:6a20:c707:b0:1f5:8d3b:e272 with SMTP id
 adf61e73a8af0-20444e81be4mr833803637.1.1745456214920; 
 Wed, 23 Apr 2025 17:56:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 110/148] exec/cpu-all: remove exec/target_page include
Date: Wed, 23 Apr 2025 17:48:55 -0700
Message-ID: <20250424004934.598783-111-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-hash.h                  | 1 +
 hw/s390x/ipl.h                       | 1 +
 include/exec/cpu-all.h               | 1 -
 hw/alpha/dp264.c                     | 1 +
 hw/arm/boot.c                        | 1 +
 hw/arm/smmuv3.c                      | 1 +
 hw/avr/atmega.c                      | 1 +
 hw/hppa/machine.c                    | 1 +
 hw/hyperv/hyperv.c                   | 1 +
 hw/hyperv/syndbg.c                   | 1 +
 hw/hyperv/vmbus.c                    | 1 +
 hw/i386/multiboot.c                  | 1 +
 hw/i386/pc.c                         | 1 +
 hw/i386/pc_sysfw_ovmf.c              | 1 +
 hw/i386/vapic.c                      | 1 +
 hw/loongarch/virt.c                  | 1 +
 hw/m68k/q800.c                       | 1 +
 hw/m68k/virt.c                       | 1 +
 hw/openrisc/boot.c                   | 1 +
 hw/pci-host/astro.c                  | 1 +
 hw/ppc/e500.c                        | 1 +
 hw/ppc/mac_newworld.c                | 1 +
 hw/ppc/mac_oldworld.c                | 1 +
 hw/ppc/ppc_booke.c                   | 1 +
 hw/ppc/prep.c                        | 1 +
 hw/ppc/spapr_hcall.c                 | 1 +
 hw/riscv/riscv-iommu-pci.c           | 1 +
 hw/riscv/riscv-iommu.c               | 1 +
 hw/s390x/s390-pci-bus.c              | 1 +
 hw/s390x/s390-pci-inst.c             | 1 +
 hw/s390x/s390-skeys.c                | 1 +
 hw/sparc/sun4m.c                     | 1 +
 hw/sparc64/sun4u.c                   | 1 +
 monitor/hmp-cmds-target.c            | 1 +
 semihosting/uaccess.c                | 1 +
 target/alpha/cpu.c                   | 1 +
 target/alpha/helper.c                | 1 +
 target/alpha/translate.c             | 1 +
 target/arm/cpu.c                     | 1 +
 target/arm/gdbstub64.c               | 1 +
 target/arm/ptw.c                     | 1 +
 target/arm/tcg/helper-a64.c          | 1 +
 target/arm/tcg/op_helper.c           | 1 +
 target/arm/tcg/sve_helper.c          | 1 +
 target/arm/tcg/tlb-insns.c           | 1 +
 target/arm/tcg/translate-a64.c       | 2 +-
 target/arm/tcg/translate.c           | 1 +
 target/avr/helper.c                  | 1 +
 target/avr/translate.c               | 1 +
 target/hppa/cpu.c                    | 1 +
 target/hppa/mem_helper.c             | 1 +
 target/hppa/translate.c              | 1 +
 target/i386/helper.c                 | 1 +
 target/i386/kvm/hyperv.c             | 1 +
 target/i386/kvm/kvm.c                | 1 +
 target/i386/kvm/xen-emu.c            | 1 +
 target/i386/sev.c                    | 1 +
 target/i386/tcg/access.c             | 1 +
 target/i386/tcg/mpx_helper.c         | 1 +
 target/i386/tcg/system/excp_helper.c | 1 +
 target/i386/tcg/tcg-cpu.c            | 2 +-
 target/i386/tcg/translate.c          | 1 +
 target/loongarch/cpu_helper.c        | 1 +
 target/loongarch/tcg/tlb_helper.c    | 1 +
 target/loongarch/tcg/translate.c     | 1 +
 target/m68k/helper.c                 | 1 +
 target/m68k/translate.c              | 1 +
 target/microblaze/helper.c           | 1 +
 target/microblaze/mmu.c              | 1 +
 target/microblaze/translate.c        | 1 +
 target/mips/tcg/msa_helper.c         | 1 +
 target/mips/tcg/system/cp0_helper.c  | 1 +
 target/mips/tcg/system/tlb_helper.c  | 1 +
 target/mips/tcg/translate.c          | 1 +
 target/openrisc/mmu.c                | 1 +
 target/openrisc/sys_helper.c         | 1 +
 target/openrisc/translate.c          | 2 +-
 target/ppc/mem_helper.c              | 1 +
 target/ppc/mmu-hash32.c              | 1 +
 target/ppc/mmu_common.c              | 1 +
 target/ppc/mmu_helper.c              | 1 +
 target/ppc/translate.c               | 1 +
 target/riscv/cpu_helper.c            | 1 +
 target/riscv/pmp.c                   | 1 +
 target/riscv/tcg/tcg-cpu.c           | 1 +
 target/riscv/translate.c             | 2 +-
 target/riscv/vector_helper.c         | 1 +
 target/rx/cpu.c                      | 1 +
 target/s390x/helper.c                | 1 +
 target/s390x/ioinst.c                | 1 +
 target/s390x/mmu_helper.c            | 1 +
 target/s390x/tcg/excp_helper.c       | 1 +
 target/s390x/tcg/mem_helper.c        | 1 +
 target/s390x/tcg/misc_helper.c       | 1 +
 target/sh4/helper.c                  | 1 +
 target/sh4/translate.c               | 1 +
 target/sparc/ldst_helper.c           | 1 +
 target/sparc/mmu_helper.c            | 1 +
 target/sparc/translate.c             | 1 +
 target/tricore/helper.c              | 1 +
 target/tricore/translate.c           | 1 +
 target/xtensa/helper.c               | 1 +
 target/xtensa/mmu_helper.c           | 1 +
 target/xtensa/translate.c            | 1 +
 target/xtensa/xtensa-semi.c          | 1 +
 105 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index a5382f460d..3bc5042d9d 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -22,6 +22,7 @@
 
 #include "exec/cpu-defs.h"
 #include "exec/exec-all.h"
+#include "exec/target_page.h"
 #include "exec/translation-block.h"
 #include "qemu/xxhash.h"
 #include "tb-jmp-cache.h"
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 6557ac3be5..cb55101f06 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -14,6 +14,7 @@
 #define HW_S390_IPL_H
 
 #include "cpu.h"
+#include "exec/target_page.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "hw/qdev-core.h"
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index dae4fbcea8..e7c8b8672f 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -22,6 +22,5 @@
 #include "exec/cpu-common.h"
 #include "hw/core/cpu.h"
 #include "exec/cpu-defs.h"
-#include "exec/target_page.h"
 
 #endif /* CPU_ALL_H */
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 570ea9edf2..19562b5967 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/target_page.h"
 #include "elf.h"
 #include "hw/loader.h"
 #include "alpha_sys.h"
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index e296b62fa1..d3811b896f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -14,6 +14,7 @@
 #include <libfdt.h>
 #include "hw/arm/boot.h"
 #include "hw/arm/linux-boot-if.h"
+#include "exec/target_page.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "system/system.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 1a96287ba9..4362ae6aa1 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -25,6 +25,7 @@
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
 #include "cpu.h"
+#include "exec/target_page.h"
 #include "trace.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 2e8b8e8c67..c105d2a97c 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -12,6 +12,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "exec/target_page.h"
 #include "system/memory.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c5f247633e..c430bf28dd 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -11,6 +11,7 @@
 #include "elf.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
+#include "exec/target_page.h"
 #include "system/reset.h"
 #include "system/system.h"
 #include "system/qtest.h"
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index d21e428eae..c487f13e2f 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -25,6 +25,7 @@
 #include "target/i386/kvm/hyperv-proto.h"
 #include "target/i386/cpu.h"
 #include "exec/cpu-all.h"
+#include "exec/target_page.h"
 
 struct SynICState {
     DeviceState parent_obj;
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index d3e3917077..a410b55b9a 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -15,6 +15,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/loader.h"
 #include "cpu.h"
+#include "exec/target_page.h"
 #include "hw/hyperv/hyperv.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/hyperv/hyperv-proto.h"
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 12a7dc4312..06649b2a2e 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "exec/target_page.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index cd07a05861..6e6b96bc34 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -29,6 +29,7 @@
 #include "multiboot.h"
 #include "hw/loader.h"
 #include "elf.h"
+#include "exec/target_page.h"
 #include "system/system.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1b5d55e96d..5481fe40be 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "exec/target_page.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial-isa.h"
 #include "hw/char/parallel.h"
diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index 07a4c267fa..da947c3ca4 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "hw/i386/pc.h"
+#include "exec/target_page.h"
 #include "cpu.h"
 
 #define OVMF_TABLE_FOOTER_GUID "96b582de-1fb2-45f7-baea-a366c55a082d"
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 26aae64e5d..347431eeef 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "exec/target_page.h"
 #include "system/system.h"
 #include "system/cpus.h"
 #include "system/hw_accel.h"
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index f1eb42c2c1..39ea5cadd6 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -8,6 +8,7 @@
 #include "qemu/units.h"
 #include "qemu/datadir.h"
 #include "qapi/error.h"
+#include "exec/target_page.h"
 #include "hw/boards.h"
 #include "hw/char/serial-mm.h"
 #include "system/kvm.h"
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index aeed4c8ddb..c2e365a820 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -24,6 +24,7 @@
 #include "qemu/units.h"
 #include "qemu/datadir.h"
 #include "qemu/guest-random.h"
+#include "exec/target_page.h"
 #include "system/system.h"
 #include "cpu.h"
 #include "hw/boards.h"
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 295a614e16..e74d709a18 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/guest-random.h"
+#include "exec/target_page.h"
 #include "system/system.h"
 #include "cpu.h"
 #include "hw/boards.h"
diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
index 0a5881be31..c81efe8138 100644
--- a/hw/openrisc/boot.c
+++ b/hw/openrisc/boot.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cpu-defs.h"
+#include "exec/target_page.h"
 #include "elf.h"
 #include "hw/loader.h"
 #include "hw/openrisc/boot.h"
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 039cc3ad01..c6f2d4f494 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -35,6 +35,7 @@
 #include "target/hppa/cpu.h"
 #include "trace.h"
 #include "qom/object.h"
+#include "exec/target_page.h"
 
 /*
  * Helper functions
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 69269aa24c..809078a2c3 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -18,6 +18,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/guest-random.h"
+#include "exec/target_page.h"
 #include "qapi/error.h"
 #include "e500.h"
 #include "e500-ccsr.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 2d5309d6f5..21b2fc569a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -50,6 +50,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "exec/target_page.h"
 #include "hw/ppc/ppc.h"
 #include "hw/qdev-properties.h"
 #include "hw/nvram/mac_nvram.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index b5814690f5..0d34e6bfda 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -28,6 +28,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "exec/target_page.h"
 #include "hw/ppc/ppc.h"
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 925e670ba0..3872ae2822 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/target_page.h"
 #include "hw/ppc/ppc.h"
 #include "qemu/timer.h"
 #include "system/reset.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 3e68d8e6e2..739526335c 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -39,6 +39,7 @@
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/isa/pc87312.h"
 #include "hw/qdev-properties.h"
+#include "exec/target_page.h"
 #include "system/kvm.h"
 #include "system/reset.h"
 #include "trace.h"
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 406aea4ecb..a4f399c4ff 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -9,6 +9,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "exec/tb-flush.h"
+#include "exec/target_page.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 12451869e4..a795464803 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -17,6 +17,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/target_page.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 76e0fcd873..65411b3e4c 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "qom/object.h"
+#include "exec/target_page.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2591ee49c1..4365f8ed1e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "exec/target_page.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-kvm.h"
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index b4e003c19c..b5dddb22b8 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/memop.h"
+#include "exec/target_page.h"
 #include "system/memory.h"
 #include "qemu/error-report.h"
 #include "system/hw_accel.h"
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 0bb90fed04..d437fe070d 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "exec/target_page.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-keys.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 5aaafb40da..edbf19d958 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "qemu/datadir.h"
 #include "cpu.h"
+#include "exec/target_page.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d3cb7270ff..becdf3ea98 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/datadir.h"
 #include "cpu.h"
+#include "exec/target_page.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 011a367357..8eaf70d9c9 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -31,6 +31,7 @@
 #include "qapi/error.h"
 #include "qobject/qdict.h"
 #include "system/hw_accel.h"
+#include "exec/target_page.h"
 
 /* Set the current CPU defined by the user. Callers must hold BQL. */
 int monitor_set_cpu(Monitor *mon, int cpu_index)
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index ccb0c96070..f51a253626 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -11,6 +11,7 @@
 #include "exec/cpu-all.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
+#include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "semihosting/uaccess.h"
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 56c96b1c4d..99d839a279 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
+#include "exec/target_page.h"
 #include "fpu/softfloat.h"
 
 
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index f6261a3a53..096eac3445 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "fpu/softfloat-types.h"
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 2156c02214..7f3195a5dc 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -27,6 +27,7 @@
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
+#include "exec/target_page.h"
 #include "exec/log.h"
 
 #define HELPER_H "helper.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 21e8cf1400..c9e043bc9b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -34,6 +34,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/exec-all.h"
+#include "exec/target_page.h"
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index be38016fc7..64ee9b3b56 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -29,6 +29,7 @@
 #endif
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-mmu-index.h"
+#include "exec/target_page.h"
 #endif
 
 int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8d4e9e07a9..e0e82ae507 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -12,6 +12,7 @@
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "cpu.h"
 #include "internals.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index fa79d19425..507dbc1a44 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -31,6 +31,7 @@
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 30786fd1ff..71ba406782 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "exec/target_page.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/exec-all.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index e3bed77b48..9b0d40c9e1 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -23,6 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
+#include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 630a481f0f..0407ad5542 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "exec/cputlb.h"
+#include "exec/target_page.h"
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 39014325df..43408c71bb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -17,8 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-
 #include "exec/exec-all.h"
+#include "exec/target_page.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index d280018138..273b860d57 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -27,6 +27,7 @@
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 #include "exec/helper-proto.h"
+#include "exec/target_page.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
diff --git a/target/avr/helper.c b/target/avr/helper.c
index f23fa3e8ba..32cbf17919 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -26,6 +26,7 @@
 #include "accel/tcg/getpc.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 0490936cd5..b9c592c899 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -29,6 +29,7 @@
 #include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "exec/translator.h"
+#include "exec/target_page.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 09a6aaa3dd..51bff0c5d6 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -26,6 +26,7 @@
 #include "qemu/module.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
+#include "exec/target_page.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
 #include "hw/hppa/hppa_hardware.h"
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a1ade9079e..554d7bf4d1 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -24,6 +24,7 @@
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/helper-proto.h"
 #include "hw/core/cpu.h"
 #include "trace.h"
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0d0d1bc99b..14f3833322 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -28,6 +28,7 @@
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
+#include "exec/target_page.h"
 #include "exec/log.h"
 
 #define HELPER_H "helper.h"
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 64d9e8ab9c..197fdac7dd 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/translation-block.h"
+#include "exec/target_page.h"
 #include "system/runstate.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/hw_accel.h"
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index 70b89cacf9..9865120cc4 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "exec/target_page.h"
 #include "hyperv.h"
 #include "hw/hyperv/hyperv.h"
 #include "hyperv-proto.h"
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c749d4ee8..c9a3c02e3e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -67,6 +67,7 @@
 #include "hw/pci/msix.h"
 #include "migration/blocker.h"
 #include "exec/memattrs.h"
+#include "exec/target_page.h"
 #include "trace.h"
 
 #include CONFIG_DEVICES
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index b23010374f..284c5ef6f6 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -13,6 +13,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
+#include "exec/target_page.h"
 #include "hw/xen/xen.h"
 #include "system/kvm_int.h"
 #include "system/kvm_xen.h"
diff --git a/target/i386/sev.c b/target/i386/sev.c
index ba88976e9f..878dd20f2c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -26,6 +26,7 @@
 #include "qemu/uuid.h"
 #include "qemu/error-report.h"
 #include "crypto/hash.h"
+#include "exec/target_page.h"
 #include "system/kvm.h"
 #include "kvm/kvm_i386.h"
 #include "sev.h"
diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
index e68b73a24b..5a4721dcee 100644
--- a/target/i386/tcg/access.c
+++ b/target/i386/tcg/access.c
@@ -5,6 +5,7 @@
 #include "cpu.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
+#include "exec/target_page.h"
 #include "access.h"
 
 
diff --git a/target/i386/tcg/mpx_helper.c b/target/i386/tcg/mpx_helper.c
index 22423eedcd..b942665adc 100644
--- a/target/i386/tcg/mpx_helper.c
+++ b/target/i386/tcg/mpx_helper.c
@@ -22,6 +22,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
+#include "exec/target_page.h"
 #include "helper-tcg.h"
 
 
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 4badd73943..a563c9b35e 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -22,6 +22,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "exec/tswap.h"
 #include "tcg/helper-tcg.h"
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 818653ee6d..35b17f2b18 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -23,7 +23,7 @@
 #include "qemu/accel.h"
 #include "accel/accel-cpu-target.h"
 #include "exec/translation-block.h"
-
+#include "exec/target_page.h"
 #include "tcg-cpu.h"
 
 /* Frob eflags into and out of the CPU temporary format.  */
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 6418d4bb03..1dcc35f5df 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -26,6 +26,7 @@
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/translator.h"
+#include "exec/target_page.h"
 #include "fpu/softfloat.h"
 
 #include "exec/helper-proto.h"
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index f8965cd155..bb343078bf 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "exec/target_page.h"
 #include "internals.h"
 #include "cpu-csr.h"
 
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 70d1b5cf99..0d6c9844a6 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -15,6 +15,7 @@
 #include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "cpu-csr.h"
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index e59e4ed25b..53a0b4c3ce 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -11,6 +11,7 @@
 #include "tcg/tcg-op-gvec.h"
 #include "exec/translation-block.h"
 #include "exec/translator.h"
+#include "exec/target_page.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/log.h"
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 8251272219..f73e0def23 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -23,6 +23,7 @@
 #include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
 #include "system/memory.h"
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index dec2967fce..b1266a7875 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
+#include "exec/target_page.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 022c98f0c3..9203192483 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -23,6 +23,7 @@
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "qemu/host-utils.h"
 #include "exec/log.h"
 
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 2d18659b99..95a12e16f8 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -24,6 +24,7 @@
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 
 static unsigned int tlb_decode_size(unsigned int f)
 {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b54e5ac4b2..4bb867c969 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -27,6 +27,7 @@
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
+#include "exec/target_page.h"
 #include "qemu/qemu-print.h"
 
 #include "exec/log.h"
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 74fb80cc25..969dd34b3e 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -25,6 +25,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/memop.h"
+#include "exec/target_page.h"
 #include "fpu/softfloat.h"
 #include "fpu_helper.h"
 
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 78e422b0ca..101b1e65fd 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -28,6 +28,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
+#include "exec/target_page.h"
 
 
 /* SMP helpers.  */
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index df80301a41..d239fa9353 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -24,6 +24,7 @@
 #include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "exec/helper-proto.h"
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 78b848a6d9..8658315f93 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -27,6 +27,7 @@
 #include "internal.h"
 #include "exec/helper-proto.h"
 #include "exec/translation-block.h"
+#include "exec/target_page.h"
 #include "semihosting/semihost.h"
 #include "trace.h"
 #include "fpu_helper.h"
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 47ac783c52..acea50c41e 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
 #include "hw/loader.h"
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 21bc137ccc..92badf017f 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
+#include "exec/target_page.h"
 #include "exec/helper-proto.h"
 #include "exception.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index da033bffff..d4ce60188b 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -28,7 +28,7 @@
 #include "qemu/qemu-print.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
-
+#include "exec/target_page.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 51b137febd..0967624afe 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/target_page.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "helper_regs.h"
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 1f791a7f2f..5bd3efe70e 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "system/kvm.h"
 #include "kvm_ppc.h"
 #include "internal.h"
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index fb62b947f1..394a0c9bb6 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -26,6 +26,7 @@
 #include "mmu-hash32.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/log.h"
 #include "helper_regs.h"
 #include "qemu/error-report.h"
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index ad9ba8294c..c90ceb7d60 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -27,6 +27,7 @@
 #include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/log.h"
 #include "helper_regs.h"
 #include "qemu/error-report.h"
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a52cbc869a..399107d319 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "exec/exec-all.h"
+#include "exec/target_page.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "qemu/host-utils.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ca58094fb5..619c76cc00 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -26,6 +26,7 @@
 #include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "system/memory.h"
 #include "instmap.h"
 #include "tcg/tcg-op.h"
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index b0841d44f4..c13a117e3f 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -26,6 +26,7 @@
 #include "trace.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
                           uint8_t val);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index bee7dfd803..710449d17e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -22,6 +22,7 @@
 #include "exec/translation-block.h"
 #include "tcg-cpu.h"
 #include "cpu.h"
+#include "exec/target_page.h"
 #include "internals.h"
 #include "pmu.h"
 #include "time_helper.h"
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d6651f244f..cef61b5b29 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -23,7 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-
+#include "exec/target_page.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
 #include "exec/log.h"
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7fffa23bc8..7de6cbae5c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -26,6 +26,7 @@
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
+#include "exec/target_page.h"
 #include "exec/tswap.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 51743020d4..e14d9cbef9 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -24,6 +24,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/translation-block.h"
+#include "exec/target_page.h"
 #include "hw/loader.h"
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index e660c69f60..3c57c32e47 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -27,6 +27,7 @@
 #include "target/s390x/kvm/pv.h"
 #include "system/hw_accel.h"
 #include "system/runstate.h"
+#include "exec/target_page.h"
 #include "exec/watchpoint.h"
 
 void s390x_tod_timer(void *opaque)
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index a944f16c25..fe62ba5b06 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
+#include "exec/target_page.h"
 #include "s390x-internal.h"
 #include "hw/s390x/ioinst.h"
 #include "trace.h"
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index b079d120db..0e133cb9a5 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -25,6 +25,7 @@
 #include "system/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "hw/hw.h"
 #include "hw/s390x/storage-keys.h"
 #include "hw/boards.h"
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 1d51043e88..6cd813e1ab 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "exec/exec-all.h"
+#include "exec/target_page.h"
 #include "exec/watchpoint.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 0ff2e10d81..d5eece4384 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -29,6 +29,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
+#include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
 #include "qemu/int128.h"
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 31266aeda4..e02f443850 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -29,6 +29,7 @@
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
+#include "exec/target_page.h"
 #include "qapi/error.h"
 #include "tcg_s390x.h"
 #include "s390-tod.h"
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 7567e6c8b6..b41d14d5d7 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -23,6 +23,7 @@
 #include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/log.h"
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bcdd558818..5ce477d0ad 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -25,6 +25,7 @@
 #include "exec/helper-gen.h"
 #include "exec/translation-block.h"
 #include "exec/translator.h"
+#include "exec/target_page.h"
 #include "exec/log.h"
 #include "qemu/qemu-print.h"
 
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 8890d2b119..3fa5e78816 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -26,6 +26,7 @@
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/cpu_ldst.h"
 #include "system/memory.h"
 #ifdef CONFIG_USER_ONLY
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index c5d82a0854..217580a4d8 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -23,6 +23,7 @@
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "system/memory.h"
 #include "qemu/qemu-print.h"
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bfe63649db..adebddf27b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/target_page.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/helper-gen.h"
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index b1ee126112..e4c53d453d 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -22,6 +22,7 @@
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "fpu/softfloat-helpers.h"
 #include "qemu/qemu-print.h"
 
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6819b77668..5c7ed395ca 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -31,6 +31,7 @@
 #include "tricore-opcodes.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
+#include "exec/target_page.h"
 #include "exec/log.h"
 
 #define HELPER_H "helper.h"
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 4824b97e37..d02d16f9ec 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -29,6 +29,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "exec/target_page.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 1ce125794d..a7dd810055 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -36,6 +36,7 @@
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "system/memory.h"
 
 #define XTENSA_MPU_SEGMENT_MASK 0x0000001f
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index cb817b3119..5ebd4a512c 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -37,6 +37,7 @@
 #include "qemu/qemu-print.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
+#include "exec/target_page.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/log.h"
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 2ded8e5634..636f421da2 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -29,6 +29,7 @@
 #include "cpu.h"
 #include "chardev/char-fe.h"
 #include "exec/helper-proto.h"
+#include "exec/target_page.h"
 #include "semihosting/semihost.h"
 #include "semihosting/uaccess.h"
 #include "qapi/error.h"
-- 
2.43.0


