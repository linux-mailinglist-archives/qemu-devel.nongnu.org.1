Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F4C8D2C37
	for <lists+qemu-devel@lfdr.de>; Wed, 29 May 2024 07:17:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBfG-0000Hb-1G; Wed, 29 May 2024 01:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBf9-0000Gi-70
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:15:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBf7-0005OU-8i
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:15:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35b447d78f1so270939f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959742; x=1717564542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lYg149xiDrskv7d7tmQoM7GARXqxhL96WVIVZMmwqus=;
 b=nz6Lv+QeWfQ6wpBFZoH7FQ6HpwsFMj6sn0sVwY0EnVaNPaek2E89jMJUblYk2Eu3Dm
 XYLiHZCgbyYWDLFBFO3oSofqsUQk3+538rLPyProI69zvmkjiU6NYyFwY91DeChBeVMu
 iXsKQUnhXjtkixle9uYqhRDBlJmxkEio/X9vFukQrYqxAbsxHAm7hqqsj9BgHPJpypq3
 Cz6+B9VLDwtm3txXgHytxBhz5UJUuPHJ/VgAl8/ak+p/a/U/GoD0z2YGeAWDM7GX0zLP
 ebVa9sgzM1RdbKVAxsatVWpFO/iWurtLHW/rPqRMRBcbv2TWk/G9oofHUOZ8MA7xaJpd
 dUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959742; x=1717564542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYg149xiDrskv7d7tmQoM7GARXqxhL96WVIVZMmwqus=;
 b=JClQyGvfgNtwoyPXfFqIW7j8bFHELK2ARJ6b53yrwMnWZX5cPPCS1z0DZguPThaQvz
 TQzNCfnZhI1rdFHGO4r0GTY+Ns7qVb8oNGKuROTcUq24CyywgZceBg1UJMP2B7cYT7Zo
 wycmpwC9Kp/8jt1/PZ63IPVLioIXXaJhuZuggBbJXm0HEtjKof70V7nfyKwi4LYnwx1c
 3CWks7HAj1FXi27nv/ZCCp9+T2qEvvtzNS8e84z8FNdE7o5fdsWKB7OqBaQ8/3GRDZGf
 HUqGTMKXZNi4y3dbit8DeCKdOOfK85UsQGaIuqvUYUjgeHvz7rk7i7p3zTrG/5juDX2A
 aSug==
X-Gm-Message-State: AOJu0Yzvrz2NqdzgrvWxOnZXE4iVDnengraiW7xFECEshOMvadeiPE7V
 MzPsf+69Xusn3g5cEsTlBtQ3y8UXPCJh061L405hz4qPfqZl6MqoimQ+UaT8pmb3auIQjfaxFsv
 y
X-Google-Smtp-Source: AGHT+IENfJuwLNcWb3y13GYd/sdZ1uWF51qlJzttrDDkzTKCkXAgmtHsBfaGXS0TjtWAJIQIanCgqQ==
X-Received: by 2002:a5d:6d82:0:b0:354:f5f2:1997 with SMTP id
 ffacd0b85a97d-35c79789426mr872449f8f.3.1716959742234; 
 Tue, 28 May 2024 22:15:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08ac22sm13565549f8f.33.2024.05.28.22.15.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:15:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 00/23] hw/i386: Remove deprecated pc-i440fx-2.0 -> 2.3
 machines
Date: Wed, 29 May 2024 07:15:16 +0200
Message-ID: <20240529051539.71210-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Missing review: #20

Paolo, Michael, should I merge this myself? Ack-by welcome ;)

Since v4:
- Rebased on top of 7b68a5fe2f ("Merge tag 'for-upstream')
- Removed obsolete comment (Daniel)
- Clean DEFINE_I440FX_MACHINE (Daniel, new patch).

Since v3:
- Deprecate up to 2.12 (Thomas)

Since v2:
- Addressed Zhao review comments

Since v1:
- Addressed Zhao and Thomas review comments

Kill legacy code, because we need to evolve.

I ended there via dynamic machine -> ICH9 -> legacy ACPI...

This should also help Igor cleanups:
http://lore.kernel.org/qemu-devel/20240326171632.3cc7533d@imammedo.users.ipa.redhat.com/

Clashes a bit with Daniel general deprecation policy for all
versioned machines:
https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg00084.html

Philippe Mathieu-Daudé (23):
  hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
  hw/i386/pc: Remove deprecated pc-i440fx-2.0 machine
  hw/usb/hcd-xhci: Remove XHCI_FLAG_FORCE_PCIE_ENDCAP flag
  hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST flag
  hw/i386/acpi: Remove PCMachineClass::legacy_acpi_table_size
  hw/acpi/ich9: Remove 'memory-hotplug-support' property
  hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
  hw/i386/pc: Remove deprecated pc-i440fx-2.1 machine
  target/i386/kvm: Remove x86_cpu_change_kvm_default() and 'kvm-cpu.h'
  hw/i386/pc: Remove PCMachineClass::smbios_uuid_encoded
  hw/smbios: Remove 'uuid_encoded' argument from smbios_set_defaults()
  hw/smbios: Remove 'smbios_uuid_encoded', simplify smbios_encode_uuid()
  hw/i386/pc: Remove PCMachineClass::enforce_aligned_dimm
  hw/mem/pc-dimm: Remove legacy_align argument from pc_dimm_pre_plug()
  hw/mem/memory-device: Remove legacy_align from
    memory_device_pre_plug()
  hw/i386/pc: Remove deprecated pc-i440fx-2.2 machine
  hw/i386/pc: Remove PCMachineClass::resizable_acpi_blob
  hw/i386/pc: Remove PCMachineClass::rsdp_in_ram
  hw/i386/acpi: Remove AcpiBuildState::rsdp field
  hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine
  hw/i386/pc: Simplify DEFINE_I440FX_MACHINE() macro
  target/i386: Remove X86CPU::kvm_no_smi_migration field
  hw/i386/pc: Replace PCMachineClass::acpi_data_size by
    PC_ACPI_DATA_SIZE

 docs/about/deprecated.rst             |   4 +-
 docs/about/removed-features.rst       |   2 +-
 hw/usb/hcd-xhci.h                     |   4 +-
 include/hw/firmware/smbios.h          |   3 +-
 include/hw/i386/pc.h                  |  22 ----
 include/hw/mem/memory-device.h        |   2 +-
 include/hw/mem/pc-dimm.h              |   3 +-
 target/i386/cpu.h                     |   3 -
 target/i386/kvm/kvm-cpu.h             |  41 ------
 hw/acpi/ich9.c                        |  46 +------
 hw/arm/virt.c                         |   5 +-
 hw/i386/acpi-build.c                  |  95 ++------------
 hw/i386/fw_cfg.c                      |   3 +-
 hw/i386/pc.c                          | 107 +++-------------
 hw/i386/pc_piix.c                     | 171 +++++---------------------
 hw/loongarch/virt.c                   |   4 +-
 hw/mem/memory-device.c                |  12 +-
 hw/mem/pc-dimm.c                      |   6 +-
 hw/ppc/spapr.c                        |   2 +-
 hw/riscv/virt.c                       |   2 +-
 hw/smbios/smbios.c                    |  13 +-
 hw/usb/hcd-xhci-nec.c                 |   4 -
 hw/usb/hcd-xhci-pci.c                 |   4 +-
 hw/usb/hcd-xhci.c                     |  42 ++-----
 hw/virtio/virtio-md-pci.c             |   2 +-
 target/i386/cpu.c                     |   2 -
 target/i386/kvm/kvm-cpu.c             |   3 +-
 target/i386/kvm/kvm.c                 |   7 +-
 tests/avocado/mem-addr-space-check.py |   9 +-
 29 files changed, 98 insertions(+), 525 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-cpu.h

-- 
2.41.0


