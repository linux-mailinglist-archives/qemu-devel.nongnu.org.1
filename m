Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF5D70DA87
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:29:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1PFj-0000yv-Gg; Tue, 23 May 2023 06:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q1PFc-0000yf-6C
 for qemu-devel@nongnu.org; Tue, 23 May 2023 06:28:20 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q1PFY-0005Y0-QH
 for qemu-devel@nongnu.org; Tue, 23 May 2023 06:28:18 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3980f2df1e7so1213655b6e.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684837695; x=1687429695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OicM3Y3sf18/+oGcedsoxz5i3fkLdUZ5oYAeQUGIt1M=;
 b=GjdIqc5PQWvIxqtcx2rozQj+TPDjOw221whDB+a4BZI1dQXZUfAx1X4XORK+AxfQoo
 CTZJFCO8LkhlS9WSxwssBmCciptDQnCJ2HVNXNKVaiOqd7q4KQmq2bCwP0NwLX+Rq3xM
 RLsF7Nb7F41s3hp0Uh9EPyXyONUMxkY0u1enw4QKk7Beb8npPMmGV0ofetB0RO9nYY4G
 gj3viK6okKVVeoGB8EC2ygS5vo7uO7J+z+kb/sFdlgjUMmF1C6p5nmUS5Nd8jqFxRHaT
 VrsLnRjUQIb36s96U/veP6cLFg6UhdxtSN1jEiC2Gx/ZAUtnw7PMTbSBfOW5WcVxq99U
 5klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684837695; x=1687429695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OicM3Y3sf18/+oGcedsoxz5i3fkLdUZ5oYAeQUGIt1M=;
 b=EuncZC3mhXEMinvIr1UjuXJcwZhQun2KIOTVxS9j1JxBKMh3JeNm/WYaWufVPaaUL0
 zEfVpmUWm0vcomoC3lpHvsGHMX2cma6PlMwhP5cq8+SjVGahHSLXK72hdNA+M2vCD7l9
 DTJALW8nWhtysfXW22e8e/BvQlhqwSY8abTSEsFFcKxO2PgsitkXCntyyJGCQxuWGO1A
 65R5DWWsMLYLp4Ws1mfHEXRY5DJeAFVJDWQ0764I6qFYzemp6EGWoeKlGkuN4Lxq0i6O
 0FU3jWMoCofYncqNF2nOBzWFBRkrsE3ub9OOEiiWozz5N7QgvqGMNv4KZy+GpaWmbmq0
 bzAg==
X-Gm-Message-State: AC+VfDwFB9JRKHs4KdsCva75C+24hC2DU9uoXKWmu1PjeGjdsTMQ7yam
 lrfTgbPl2nx6pqj0UhWvToz9rQ==
X-Google-Smtp-Source: ACHHUZ5l9JlcCsF69leCt/jaHvZwsjYvmZimqDjZdBsJsF6PATYC9EtnMQwUB8Rjmxpx2KLEnv01cA==
X-Received: by 2002:a05:6808:2c5:b0:396:4977:e148 with SMTP id
 a5-20020a05680802c500b003964977e148mr6356504oid.9.1684837695148; 
 Tue, 23 May 2023 03:28:15 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.186.3])
 by smtp.gmail.com with ESMTPSA id
 b38-20020a4a98e9000000b00549efd1fc72sm3576862ooj.35.2023.05.23.03.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 03:28:14 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3] hw/riscv: virt: Assume M-mode FW in pflash0 only when
 "-bios none"
Date: Tue, 23 May 2023 15:58:05 +0530
Message-Id: <20230523102805.100160-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Currently, virt machine supports two pflash instances each with
32MB size. However, the first pflash is always assumed to
contain M-mode firmware and reset vector is set to this if
enabled. Hence, for S-mode payloads like EDK2, only one pflash
instance is available for use. This means both code and NV variables
of EDK2 will need to use the same pflash.

The OS distros keep the EDK2 FW code as readonly. When non-volatile
variables also need to share the same pflash, it is not possible
to keep it as readonly since variables need write access.

To resolve this issue, the code and NV variables need to be separated.
But in that case we need an extra flash. Hence, modify the convention
such that pflash0 will contain the M-mode FW only when "-bios none"
option is used. Otherwise, pflash0 will contain the S-mode payload FW.
This enables both pflash instances available for EDK2 use.

Example usage:
1) pflash0 containing M-mode FW
qemu-system-riscv64 -bios none -pflash <mmode_fw> -machine virt
or
qemu-system-riscv64 -bios none \
-drive file=<mmode_fw>,if=pflash,format=raw,unit=0 -machine virt

2) pflash0 containing S-mode payload like EDK2
qemu-system-riscv64 -pflash <smode_fw_code> -pflash <smode_vars> -machine  virt
or
qemu-system-riscv64 -bios <opensbi_fw> \
-pflash <smode_fw_code> \
-pflash <smode_vars> \
-machine  virt
or
qemu-system-riscv64 -bios <opensbi_fw> \
-drive file=<smode_fw_code>,if=pflash,format=raw,unit=0,readonly=on \
-drive file=<smode_fw_vars>,if=pflash,format=raw,unit=1 \
-machine virt

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

The issue is reported at
https://salsa.debian.org/qemu-team/edk2/-/commit/c345655a0149f64c5020bfc1e53c619ce60587f6

The patch is based on Alistair's riscv-to-apply.next branch.

Changes since v2:
	1) Reverted v2 changes and used v1 approach so that pflash0 can be used
	   for code and pflash1 for variable store.
	2) Rebased to latest riscv-to-apply.next branch.
	3) Added documentation for pflash usage.

Changes since v1:
	1) Simplified the fix such that it doesn't break current EDK2.

 docs/system/riscv/virt.rst | 33 ++++++++++++++++++++++++
 hw/riscv/virt.c            | 51 ++++++++++++++------------------------
 2 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 4b16e41d7f..4ac0d38fdf 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -53,6 +53,39 @@ with the default OpenSBI firmware image as the -bios. It also supports
 the recommended RISC-V bootflow: U-Boot SPL (M-mode) loads OpenSBI fw_dynamic
 firmware and U-Boot proper (S-mode), using the standard -bios functionality.
 
+Using flash devices
+-------------------
+
+The first flash device (pflash0) can contain either ROM code like Oreboot
+or S-mode payload firmware code like EDK2. If the pflash0 contains the
+ROM code, -bios should be set to none. Otherwise, pflash0 is assumed to
+contain S-mode payload code.
+
+Firmware images used for pflash should be of size 32M.
+
+To boot as ROM code like Oreboot:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -bios none -pflash <rom_code_image> \
+       ... other args ....
+
+To boot as S-mode payload like EDK2:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -pflash <s-mode_fw_code> -pflash <smode_fw_vars> \
+       ... other args ....
+
+To boot as read-only S-mode payload like EDK2:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -bios <opensbi_fw> \
+       -drive file=<smode_fw_code>,if=pflash,format=raw,unit=0,readonly=on \
+       -drive file=<smode_fw_vars>,if=pflash,format=raw,unit=1 \
+       ... other args ....
+
 Machine-specific options
 ------------------------
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4e3efbee16..1187a60d6e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1245,7 +1245,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     target_ulong firmware_end_addr, kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
     uint32_t fdt_load_addr;
-    uint64_t kernel_entry;
+    uint64_t kernel_entry = 0;
 
     /*
      * Only direct boot kernel is currently supported for KVM VM,
@@ -1266,42 +1266,29 @@ static void virt_machine_done(Notifier *notifier, void *data)
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                      start_addr, NULL);
 
-    if (drive_get(IF_PFLASH, 0, 1)) {
-        /*
-         * S-mode FW like EDK2 will be kept in second plash (unit 1).
-         * When both kernel, initrd and pflash options are provided in the
-         * command line, the kernel and initrd will be copied to the fw_cfg
-         * table and opensbi will jump to the flash address which is the
-         * entry point of S-mode FW. It is the job of the S-mode FW to load
-         * the kernel and initrd using fw_cfg table.
-         *
-         * If only pflash is given but not -kernel, then it is the job of
-         * of the S-mode firmware to locate and load the kernel.
-         * In either case, the next_addr for opensbi will be the flash address.
-         */
-        riscv_setup_firmware_boot(machine);
-        kernel_entry = virt_memmap[VIRT_FLASH].base +
-                       virt_memmap[VIRT_FLASH].size / 2;
-    } else if (machine->kernel_filename) {
+    if (drive_get(IF_PFLASH, 0, 0)) {
+        if (machine->firmware && !strcmp(machine->firmware, "none")) {
+            /*
+             * Pflash was supplied but bios is none, let's overwrite the
+             * address we jump to after reset to the base of the flash.
+             */
+            start_addr = virt_memmap[VIRT_FLASH].base;
+        } else {
+            /*
+             * Pflash was supplied but bios is not none. In this case,
+             * base of the flash would contain S-mode payload.
+             */
+            riscv_setup_firmware_boot(machine);
+            kernel_entry = virt_memmap[VIRT_FLASH].base;
+        }
+    }
+
+    if (machine->kernel_filename && !kernel_entry) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc[0],
                                                          firmware_end_addr);
 
         kernel_entry = riscv_load_kernel(machine, &s->soc[0],
                                          kernel_start_addr, true, NULL);
-    } else {
-       /*
-        * If dynamic firmware is used, it doesn't know where is the next mode
-        * if kernel argument is not set.
-        */
-        kernel_entry = 0;
-    }
-
-    if (drive_get(IF_PFLASH, 0, 0)) {
-        /*
-         * Pflash was supplied, let's overwrite the address we jump to after
-         * reset to the base of the flash.
-         */
-        start_addr = virt_memmap[VIRT_FLASH].base;
     }
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
-- 
2.34.1


