Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A386712655
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 14:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2WHQ-0004rO-2q; Fri, 26 May 2023 08:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q2WH3-0004oT-DW
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:10:27 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q2WH1-0005Cr-Ah
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:10:25 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6af89b0f3e5so805677a34.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685103021; x=1687695021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sohObpPsTDyvbd/i6NEgtcjSRxEYuJVX4NYM6c82H20=;
 b=mpQp8UrxChZiYUryS2UoO5md5/prxMX/+NZhcBvlYFlR3ny0orR2ZtQgMROJswHrLK
 dWZ9+sm02tAj5l6d4Uf0b3qdSrN3yUKFxiOCSs3JkIK3uYRz9FO9X1B2ZQQ5atEnW6rx
 YCHGYEf9ci8p0ZQtJhUhOZh3Xlor7uQS88aG5u8rWBgic/xn/BEZA3prLRP18wVOFmb0
 UCcF7y1Qo/zbhNSZBKVjYv3NXtP1tOcfMH8M0nynYkNNZl8W81w4RFNL5pG4rFsxBnaR
 AUJsdSXqGhrrNJVLeh4aJr8+XNdTpPfUsT+n37XVzQnBKWu44qpvWG/P1SB7qeAOUvOV
 FXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685103021; x=1687695021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sohObpPsTDyvbd/i6NEgtcjSRxEYuJVX4NYM6c82H20=;
 b=PXGSbr4eDGPGAhwc0PILS4kSMCC01sEKZUUbvlgSRZobqXUvu54Z7zhd44En/akvK3
 j7pTOQdCkuMT81ZjSlEBYJMKPF4o6FPPhs6YmmRnJtypR6SxDFdpTtRYm3h31j29pFz4
 /BHOiCCjYUbKVPJn+Xv2iXndaQEXPbbEaFASmfBsc327GabUuMGhMfXXX727YWeyMEHH
 AFeBkSf5lrDKmGrdjR8mQf1AQQijlhpJQgR/kBYVhXX2NzAUDWqovYFglfUZh9eWEuIj
 3Wr0k6nM9rQNhpUNlK2Zb5JWQYO+ssN1dVBreJW1DHLstpRIqITQvmsn/X6nAsNStZPc
 7yyQ==
X-Gm-Message-State: AC+VfDwontXPbsXz32gBgNgNiAEnHxHF6kPbzQbhs6/SKsa1Ixf20Ddu
 rkEr4Q3taUmMVMHAvkRginy6eQ==
X-Google-Smtp-Source: ACHHUZ5p33ZqcLML8qWVSGuaVYEudlltc0/qkqEYVLPVmjtxpyJMuRAI6CyxV/1N/VuI1DGaob+ePQ==
X-Received: by 2002:a05:6830:1544:b0:6ab:1d86:e4a5 with SMTP id
 l4-20020a056830154400b006ab1d86e4a5mr570482otp.25.1685103021208; 
 Fri, 26 May 2023 05:10:21 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.186.3])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a9d618a000000b006abb3b660a9sm1611602otk.54.2023.05.26.05.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 05:10:20 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v5 1/3] hw/riscv: virt: Assume M-mode FW in pflash0 only when
 "-bios none"
Date: Fri, 26 May 2023 17:40:04 +0530
Message-Id: <20230526121006.76388-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526121006.76388-1-sunilvl@ventanamicro.com>
References: <20230526121006.76388-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-ot1-x333.google.com
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
Tested-by: Andrea Bolognani <abologna@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 51 ++++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

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


