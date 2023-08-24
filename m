Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B06D787186
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 16:31:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZBLe-0007qG-Hv; Thu, 24 Aug 2023 10:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qZBLb-0007q2-TH
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:30:07 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qZBLX-0008Nz-2r
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:30:07 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso42918895ad.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692887401; x=1693492201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MF29GBhTNvUUmI0gukMZgybyAxbxiWyFk7P/UUSYLco=;
 b=DMupJUrb1jLs+2bSPPXRxtOOLQTa8uU/E/JQMqTqmdXkHY8RHoMwoizqWsiVePod58
 4rrMGdk1pkFOXc5zt1f1Xb47rpMZ00EVJhB1iYXxPHSD1xyPO5zIBAkewmALtibo0B/v
 84PvcFCTx/WSyKFFf3l/h5gBoMEJsJYWUwJFwp1N+XbjUpNItEnMP2o8MDPuz34GFQJu
 R0blRo5iTYiLxy4uVPWVOQRr7lxwqWhC2fmYS2gDesv7eTobvfqLpF0YqgvkU36bsbqm
 ElA4essiBRaa+LcFAibldSsf7mfQG+JX2gsYjlJgrKoGAYTcQTktqexi0XWW6hdy6hcc
 cu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692887401; x=1693492201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MF29GBhTNvUUmI0gukMZgybyAxbxiWyFk7P/UUSYLco=;
 b=LroaNIDnYppZoewzI5Oi4jmu7UQXLikZOyG9NxwhGMAOkeoZLOPDWoXj9r8QZM7sp6
 ysu5AyxhL3t9zmoSZQhPWi7YKjb6xvfs9xoyqrNFYjyMEVMR0mFQ4QqFfMS2sT5rCsWV
 /KtdxEsOSwwhIzCezRANTAs1nGQ7vbuQqmy4mLG+G+QvaaWmTJSHtmfmznFxfsViukt6
 Fq9moEU1eGtf8BN3UehCw7m8r0vqGEPcODbJJ+6shk20ha+F2UBO/BC1QdGFQ1+OVdov
 0LCGWcCLJk1TPKt+n0bQS+QqY6vwPrS8Ck1sPQJmCqJz2RT5JJf8rQKDvYjhS2NInhef
 GxVw==
X-Gm-Message-State: AOJu0YwRM+k7HUrUP/2fOjyeYB6zFQrj7UEiDU1eEgjhgU/tUT5IRlkM
 j4o4H7qY6/PUasQv3RNDRNzpXg==
X-Google-Smtp-Source: AGHT+IFnMQ18i/W8Q5TPzXMoaqzagKuV2rbEwt2KWuJZ3BP7/EF1BogcqyHBDUHjkITK2G2TqohWbw==
X-Received: by 2002:a17:90a:e285:b0:268:c7fc:b771 with SMTP id
 d5-20020a17090ae28500b00268c7fcb771mr11911928pjz.14.1692887400796; 
 Thu, 24 Aug 2023 07:30:00 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.191.205])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a17090a2bc600b00262fc3d911esm1666864pje.28.2023.08.24.07.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:29:58 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 00/12] RISC-V: ACPI: Enable AIA, PLIC and update RHCT
Date: Thu, 24 Aug 2023 19:59:30 +0530
Message-Id: <20230824142942.3983650-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series primarily enables external interrupt controllers (AIA and PLIC)
in ACPI tables for RISC-V virt platform. It also updates RHCT with CMO and
MMU related information.

Below ECRs for these changes are approved by ASWG and will be
available in next ACPI spec release.

1) MADT (AIA) - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
2) RHCT - https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view?usp=sharing

First two patches in this series are to migrate a couple of functions from
ARM architecture to common code so that RISC-V doesn't need to duplicate
the same.

The patch set is based on Alistair's riscv-to-apply.next branch.

These changes are also available in  riscv_acpi_b2_v2 branch at:
https://github.com/vlsunil/qemu/

Changes since v1:
	1) As per Igor's suggestion, migrated fw_cfg and virtio creation
	   functions to device specific file instead of generic aml-build.c.
	   Since ACPI is optional, new files are created and enabled for
	   build only when CONFIG_ACPI is enabled.

	2) As per Igor's suggestion, properties are added to the GPEX PCI
	   host to indicate MMIO ranges. The platform fw can initialize
	   these to appropriate values and the DSDT generator can fetch
	   the information from the host bus itself. This makes the code
	   generic instead of machine specific.

	3) Added PLIC patch from Haibo.

	4) Rebased to latest riscv-to-apply.next and added RB tags as
	   appropriate.


Sunil V L (12):
  hw/arm/virt-acpi-build.c: Migrate fw_cfg creation to common location
  hw/arm/virt-acpi-build.c: Migrate virtio creation to common location
  hw/riscv: virt: Make few IMSIC macros and functions public
  hw/riscv/virt-acpi-build.c: Add AIA support in RINTC
  hw/riscv/virt-acpi-build.c: Add IMSIC in the MADT
  hw/riscv/virt-acpi-build.c: Add APLIC in the MADT
  hw/riscv/virt-acpi-build.c: Add CMO information in RHCT
  hw/riscv/virt-acpi-build.c: Add MMU node in RHCT
  hw/pci-host/gpex: Define properties for MMIO ranges
  hw/riscv/virt: Update GPEX MMIO related properties
  hw/riscv/virt-acpi-build.c: Add IO controllers and devices
  hw/riscv/virt-acpi-build.c: Add PLIC in MADT

 hw/arm/virt-acpi-build.c        |  48 +----
 hw/nvram/fw_cfg-acpi.c          |  17 ++
 hw/nvram/meson.build            |   1 +
 hw/pci-host/gpex-acpi.c         |  13 ++
 hw/pci-host/gpex.c              |  12 ++
 hw/riscv/Kconfig                |   1 +
 hw/riscv/virt-acpi-build.c      | 342 +++++++++++++++++++++++++++++---
 hw/riscv/virt.c                 |  72 +++----
 hw/virtio/meson.build           |   1 +
 hw/virtio/virtio-acpi.c         |  28 +++
 include/hw/nvram/fw_cfg_acpi.h  |   9 +
 include/hw/pci-host/gpex.h      |  28 ++-
 include/hw/riscv/virt.h         |  26 +++
 include/hw/virtio/virtio-acpi.h |  11 +
 14 files changed, 492 insertions(+), 117 deletions(-)
 create mode 100644 hw/nvram/fw_cfg-acpi.c
 create mode 100644 hw/virtio/virtio-acpi.c
 create mode 100644 include/hw/nvram/fw_cfg_acpi.h
 create mode 100644 include/hw/virtio/virtio-acpi.h

-- 
2.39.2


