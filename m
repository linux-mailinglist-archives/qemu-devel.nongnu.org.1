Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7087516F1
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 05:54:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJnNz-0005OV-AZ; Wed, 12 Jul 2023 23:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNs-0005Nd-GT
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:52:52 -0400
Received: from mail-oo1-f47.google.com ([209.85.161.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNm-0004bS-Lp
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:52:51 -0400
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-5634808e16eso277147eaf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 20:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689220361; x=1691812361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fI8arKM2WcE0nqtQSHDEDseO4rqY/wXIbAyNoLQP65g=;
 b=TyFiF18UkwNH0ypsjmSzMsP9PRw4qq7+x6nVJ/oMTtJgMt4f/Ur71apn/lijeUKDWk
 6e7rquVXuFydAwEDNaDsgUDs4u+LzmyKHyzAt9Ju3aakibCGKhPqC0stgTHxUeyTM2dG
 3R8lfv0N1RRGqOp5ltycRdbLPYobNJBETws61xDJ9CCizzT/50ejajRgsjxEiSGwphi7
 34fcV2FC8TZ5mOzjIdd+o2ftRjfXvuBkW/KpYGPRp4d2paEx1nRrj/+X9wwmt6gYtMQb
 uuF8yITKAZeRnd4JgZZIEhw99DyRYLgDDFDC2US7rRwaNwV/AtMsOKLGutzdfWncY9gA
 +wSA==
X-Gm-Message-State: ABy/qLbScVqbUPIA+daSBq1MxW7R2j4sXcgZkOtU6uSXFCZxG2gHIEhR
 q8BgF88lc8lTy0+sDaVCrQMDVW4r4p4=
X-Google-Smtp-Source: APBJJlGdnSzeM2cmuPi2bKESvLFB5qGEeXktXpTFexfK9Mt2Gik+JOGzVVlOnENPGXSYY5Rn7/hNXg==
X-Received: by 2002:a05:6358:6502:b0:135:725f:a8af with SMTP id
 v2-20020a056358650200b00135725fa8afmr686083rwg.15.1689220360945; 
 Wed, 12 Jul 2023 20:52:40 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:8b82:587c:b800:84d:31b7:313d])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a1709027c0600b001b8a37ffb5asm4756199pll.4.2023.07.12.20.52.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Jul 2023 20:52:40 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] tpm: introduce TPM CRB SysBus device
Date: Wed, 12 Jul 2023 20:51:05 -0700
Message-ID: <20230713035232.48406-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.161.47; envelope-from=osy86dev@gmail.com;
 helo=mail-oo1-f47.google.com
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
LDP caused page faults. @agraf suggested that we do this to avoid having to
do AARCH64 decoding in the HVF fault handler.

Unfortunately, it seems like the LDP fault still happens on HVF but the issue
seems to be in the HVF backend which needs to be fixed in a separate patch.

One last thing that's needed to get Windows 11 to recognize the TPM 2.0 device
is for the OVMF firmware to setup the TPM device. Currently, OVMF for ARM64 Virt
only recognizes the TPM TIS device through a FDT entry. A workaround is to
falsely identify the TPM CRB device as a TPM TIS device in the FDT node but this
causes issues for Linux. A proper fix would involve adding an ACPI device driver
in OVMF.

Joelle van Dyne (11):
  tpm_crb: refactor common code
  tpm_crb: CTRL_RSP_ADDR is 64-bits wide
  tpm_ppi: refactor memory space initialization
  tpm_crb: use a single read-as-mem/write-as-mmio mapping
  tpm_crb: use the ISA bus
  tpm_crb: move ACPI table building to device interface
  hw/arm/virt: add plug handler for TPM on SysBus
  hw/loongarch/virt: add plug handler for TPM on SysBus
  tpm_tis_sysbus: fix crash when PPI is enabled
  tpm_tis_sysbus: move DSDT AML generation to device
  tpm_crb_sysbus: introduce TPM CRB SysBus device

 docs/specs/tpm.rst          |   2 +
 hw/tpm/tpm_crb.h            |  74 +++++++++
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
 hw/tpm/tpm_crb.c            | 307 ++++++++----------------------------
 hw/tpm/tpm_crb_common.c     | 224 ++++++++++++++++++++++++++
 hw/tpm/tpm_crb_sysbus.c     | 178 +++++++++++++++++++++
 hw/tpm/tpm_ppi.c            |   5 +-
 hw/tpm/tpm_tis_isa.c        |   5 +-
 hw/tpm/tpm_tis_sysbus.c     |  43 +++++
 tests/qtest/tpm-crb-test.c  |   2 +-
 tests/qtest/tpm-util.c      |   2 +-
 hw/arm/Kconfig              |   1 +
 hw/riscv/Kconfig            |   1 +
 hw/tpm/Kconfig              |   7 +-
 hw/tpm/meson.build          |   3 +
 hw/tpm/trace-events         |   2 +-
 27 files changed, 703 insertions(+), 354 deletions(-)
 create mode 100644 hw/tpm/tpm_crb.h
 create mode 100644 hw/tpm/tpm_crb_common.c
 create mode 100644 hw/tpm/tpm_crb_sysbus.c

-- 
2.39.2 (Apple Git-143)


