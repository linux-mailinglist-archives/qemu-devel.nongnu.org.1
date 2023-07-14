Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB7175329C
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:11:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCw9-0006LC-Lv; Fri, 14 Jul 2023 03:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCw6-0006Ki-FA
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:09:54 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCw4-000588-9l
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:09:54 -0400
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-55c85b5321dso919329a12.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 00:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689318590; x=1691910590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MHjvPHmIDmFZH1P1OHHcrfdWoiYcZMQ4N5O4/AK9/ok=;
 b=K+63sw/48TehXcZBcJ2I1zPB98Jz8kWBu4aqsp4M04IPb50IJIDU7VqoWP7NKBDuqJ
 X2lmjQ+Ac1JRNb0IzGttQPAMtSujmRDRDuUnKTUQHgY07+8mLjXcMgpwqKIQz3qkQVXS
 lY8jj5z7awCx8q8IHavhOFY1TunJ0feNDyXUlt+IBuRLGAm8R7S2rUbQHu0LC0n3c46v
 gjOpAokT9QKCk01yaDQ0k4/JJ6lqgyPNzsLBLz8zOZfjrLJriiB8K9VPIalO1TXJXvz9
 i95YvicwBEfFHKhLowVGmsXQrreVjMRNbm7M9nKh+msjgmJHiiPsuI2kMRrFuZv6NkTX
 gl9w==
X-Gm-Message-State: ABy/qLbU1W2Wn6AFqqvcQPK/Ldmafahtho50I8a1MMaPUAfdTNcZ/UaY
 VODhM1dSDkNW1oWqMLK2gYQY3Dc26+SzqQ==
X-Google-Smtp-Source: APBJJlGz8ZElAyOoShJEOU+eOaB/RNxSa3uVnl0zoD9iHARaWtGJEjCs9atXnkuw2AMvLOeVqC2YYw==
X-Received: by 2002:a05:6a20:8403:b0:12f:df4:6102 with SMTP id
 c3-20020a056a20840300b0012f0df46102mr3360853pzd.27.1689318589836; 
 Fri, 14 Jul 2023 00:09:49 -0700 (PDT)
Received: from localhost.localdomain
 ([2607:fb90:dd17:8dad:e558:8948:1ff6:c8c1])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a170902b20800b001b89466a5f4sm7041513plr.105.2023.07.14.00.09.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Jul 2023 00:09:49 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/11] tpm: introduce TPM CRB SysBus device
Date: Fri, 14 Jul 2023 00:09:16 -0700
Message-ID: <20230714070931.23476-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.179; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f179.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The impetus for this patch set is to get TPM 2.0 working on Windows 11 ARM64.
Windows' tpm.sys does not seem to work on a TPM TIS device (as verified with
VMWare's implementation). However, the current TPM CRB device uses a fixed
system bus address that is reserved for RAM in ARM64 Virt machines.

In the process of adding the TPM CRB SysBus device, we also went ahead and
cleaned up some of the existing TPM hardware code and fixed some bugs. We used
the TPM TIS devices as a template for the TPM CRB devices and refactored out
common code. We moved the ACPI DSDT generation to the device in order to handle
dynamic base address requirements as well as reduce redundent code in different
machine ACPI generation. We also changed the tpm_crb device to use the ISA bus
instead of depending on the default system bus as the device only was built for
the PC configuration.

Another change is that the TPM CRB registers are now mapped in the same way that
the pflash ROM devices are mapped. It is a memory region whose writes are
trapped as MMIO accesses. This was needed because Apple Silicon does not decode
LDP (AARCH64 load pair of registers) caused page faults. @agraf suggested that
we do this to avoid having to do AARCH64 decoding in the HVF backend's fault
handler.

Unfortunately, it seems like the LDP fault still happens on HVF but the issue
seems to be in the HVF backend which needs to be fixed in a separate patch.

One last thing that's needed to get Windows 11 to recognize the TPM 2.0 device
is for the OVMF firmware to setup the TPM device. Currently, OVMF for ARM64 Virt
only recognizes the TPM TIS device through a FDT entry. A workaround is to
falsely identify the TPM CRB device as a TPM TIS device in the FDT node but this
causes issues for Linux. A proper fix would involve adding an ACPI device driver
in OVMF.

v2:
- Fixed an issue where VMstate restore from an older version failed due to name
  collision of the memory block.
- In the ACPI table generation for CRB devices, the check for TPM 2.0 backend is
  moved to the device realize as CRB does not support TPM 1.0. It will error in
  that case.
- Dropped the patch to fix crash when PPI is enabled on TIS SysBus device since
  a separate patch submitted by Stefan Berger disables such an option.
- Fixed an issue where we default tpmEstablished=0 when it should be 1.
- In TPM CRB SysBus's ACPI entry, we accidently changed _UID from 0 to 1. This
  shouldn't be an issue but we changed it back just in case.
- Added a patch to migrate saved VMstate from an older version with the regs
  saved separately instead of as a RAM block.

Joelle van Dyne (11):
  tpm_crb: refactor common code
  tpm_crb: CTRL_RSP_ADDR is 64-bits wide
  tpm_ppi: refactor memory space initialization
  tpm_crb: use a single read-as-mem/write-as-mmio mapping
  tpm_crb: use the ISA bus
  tpm_crb: move ACPI table building to device interface
  hw/arm/virt: add plug handler for TPM on SysBus
  hw/loongarch/virt: add plug handler for TPM on SysBus
  tpm_tis_sysbus: move DSDT AML generation to device
  tpm_crb_sysbus: introduce TPM CRB SysBus device
  tpm_crb: support restoring older vmstate

 docs/specs/tpm.rst          |   2 +
 hw/tpm/tpm_crb.h            |  75 +++++++++
 hw/tpm/tpm_ppi.h            |  10 +-
 include/hw/acpi/aml-build.h |   1 +
 include/hw/acpi/tpm.h       |   3 +-
 include/sysemu/tpm.h        |   3 +
 hw/acpi/aml-build.c         |   7 +-
 hw/arm/virt-acpi-build.c    |  38 +----
 hw/arm/virt.c               |  38 +++++
 hw/core/sysbus-fdt.c        |   1 +
 hw/i386/acpi-build.c        |  23 ---
 hw/loongarch/acpi-build.c   |  38 +----
 hw/loongarch/virt.c         |  38 +++++
 hw/riscv/virt.c             |   1 +
 hw/tpm/tpm_crb.c            | 314 +++++++++---------------------------
 hw/tpm/tpm_crb_common.c     | 233 ++++++++++++++++++++++++++
 hw/tpm/tpm_crb_sysbus.c     | 170 +++++++++++++++++++
 hw/tpm/tpm_ppi.c            |   5 +-
 hw/tpm/tpm_tis_isa.c        |   5 +-
 hw/tpm/tpm_tis_sysbus.c     |  35 ++++
 tests/qtest/tpm-crb-test.c  |   2 +-
 tests/qtest/tpm-util.c      |   2 +-
 hw/arm/Kconfig              |   1 +
 hw/riscv/Kconfig            |   1 +
 hw/tpm/Kconfig              |   7 +-
 hw/tpm/meson.build          |   3 +
 hw/tpm/trace-events         |   2 +-
 27 files changed, 708 insertions(+), 350 deletions(-)
 create mode 100644 hw/tpm/tpm_crb.h
 create mode 100644 hw/tpm/tpm_crb_common.c
 create mode 100644 hw/tpm/tpm_crb_sysbus.c

-- 
2.39.2 (Apple Git-143)


