Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E17DBA8C
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:23:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSCp-0006cW-Jl; Mon, 30 Oct 2023 09:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qxSCh-0006Ya-SG
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:21:16 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qxSCe-0002m6-6a
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:21:14 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-27d8e2ac2b1so2923972a91.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698672068; x=1699276868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=761HdFCW1pcQUslCwap5ud8fHzy5Mu/ijaNYkufTzQ0=;
 b=JJWfDPt2QHQQC6EKhr+k4e9396RHshFZSafbHqQFQ6DUlLOpaFLU0tKSuu3FsJqry7
 ROX3V6LI4En9Hs1mESc/BK+ZLBxmlC99QQ3jrToPT8TT1orPccS3OUCTYBMEQXi8Pg/d
 CD3cQHw9gttiCVPSDqiEgSp4NFloPdQrFEPzIRtItFp4IdpJ+xx9O6OrZ7NgbZ0mmrnh
 GeEQj8bJS6VJCQ7RE30SHxBT1TyHTJwQ0h0bXoSZMncBXZNrxb17o9Av/AGwyuPn7fY4
 hKoVP8u64jA65DOHmate8eXI9DdFzMUHucR/gt3rubHhit+gaPmbbENA8Qkk/KCl5y8S
 cGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698672068; x=1699276868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=761HdFCW1pcQUslCwap5ud8fHzy5Mu/ijaNYkufTzQ0=;
 b=pJPJIjkJjQA4k6OAnkmolenIi9Jypq67gksI91Oq5JeC6edj4o0UPxNjtW+utxoKek
 68oTQvBP6dUg5TbJHAod1hjUii8B6SJFzurTl+iZQDkYXjRox+5XmjOoKNfuMw1vImcz
 NVrW2IfTjKu6O/68yj9yMmRf2S6dveFqDgHViOdlOI6gR/3hSbXtE1pXJ643MY+pVzDt
 r+UV+gYTKVS081nOdjV9iENR7xfCMbs7cPLXNW2Ydd64Z5+xH7qPX5hP13UgrKyfAjrM
 5i7Y+hcg5JEcHIR66+dDF8ddGWp8B92Y7nKgCni/mN1CKBuq5s9yF18bjStY9oADqV1G
 rpbg==
X-Gm-Message-State: AOJu0Yw4MrQ8APQG3gbKpDAh5Y6mGtX6rApOX03EvZ9X535wHat5yQO+
 1Dq9gvYO+1Z67A2I6SwHBMMBvg==
X-Google-Smtp-Source: AGHT+IHWx3W2IUl2Qj7B5+0sKqY9xyFM/gKT59NnySRClapPLgpGhOcNPcc7EVESbGy78PbId1E80g==
X-Received: by 2002:a17:90b:11c4:b0:27c:ef18:d270 with SMTP id
 gv4-20020a17090b11c400b0027cef18d270mr6724205pjb.20.1698672067872; 
 Mon, 30 Oct 2023 06:21:07 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
 by smtp.gmail.com with ESMTPSA id
 15-20020a17090a000f00b0027ced921e80sm8122412pja.38.2023.10.30.06.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 06:21:07 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 00/13] RISC-V: ACPI: Enable AIA, PLIC and update RHCT
Date: Mon, 30 Oct 2023 18:50:45 +0530
Message-Id: <20231030132058.763556-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x102c.google.com
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

These changes are also available in  riscv_acpi_b2_v5 branch at:
https://github.com/vlsunil/qemu/

Changes since v4:
	1) Updated copyright for new files as per SPDX format suggested by Drew.
	2) Updated RINTC patch to avoid code duplication as suggested by Drew.
	3) Moved mmu offset below cmo in MMU patch as suggested by Drew.
	4) Updated tags.

Changes since v3:
	1) Addressed comments from Daniel and Drew.
	2) Added a new patch in microvm to use common function for virtio in DSDT.
	3) Rebased to latest riscv-to-apply.next branch and added tags.

Changes since v2:
        1) Rebased to latest riscv-to-apply.next branch which needed
           changing ext_icboz to ext_zicboz in CMO patch.
        2) Fixed node type in MMU node.
        3) Added latest tags.

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

Sunil V L (13):
  hw/arm/virt-acpi-build.c: Migrate fw_cfg creation to common location
  hw/arm/virt-acpi-build.c: Migrate virtio creation to common location
  hw/i386/acpi-microvm.c: Use common function to add virtio in DSDT
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

 hw/arm/virt-acpi-build.c        |  51 +----
 hw/i386/acpi-microvm.c          |  15 +-
 hw/nvram/fw_cfg-acpi.c          |  23 +++
 hw/nvram/meson.build            |   1 +
 hw/pci-host/gpex-acpi.c         |  13 ++
 hw/pci-host/gpex.c              |  12 ++
 hw/riscv/Kconfig                |   1 +
 hw/riscv/virt-acpi-build.c      | 323 +++++++++++++++++++++++++++++---
 hw/riscv/virt.c                 |  72 ++++---
 hw/virtio/meson.build           |   1 +
 hw/virtio/virtio-acpi.c         |  32 ++++
 include/hw/nvram/fw_cfg_acpi.h  |  15 ++
 include/hw/pci-host/gpex.h      |  28 ++-
 include/hw/riscv/virt.h         |  26 +++
 include/hw/virtio/virtio-acpi.h |  16 ++
 15 files changed, 498 insertions(+), 131 deletions(-)
 create mode 100644 hw/nvram/fw_cfg-acpi.c
 create mode 100644 hw/virtio/virtio-acpi.c
 create mode 100644 include/hw/nvram/fw_cfg_acpi.h
 create mode 100644 include/hw/virtio/virtio-acpi.h

-- 
2.39.2


