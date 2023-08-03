Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E676F59A
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRggf-0004Cs-J4; Thu, 03 Aug 2023 18:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggc-0004Ci-4Z
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRgga-0000Nm-Bh
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=thm/fnhI6kskNWZ5PLl/mTfNzXktl6SUV8xaAs/11Lw=;
 b=hV0LK1mRqRTlYvvyj3fEUdIXF0wtLdNnpN2FRZ1WvpIISOvI7gWmSTWppGYUrXpoqnjjow
 TDkvCECqguPsYteCLyvy4BIpo1ajgN+vFFjEu39J06i7jsqUUDjH059E2FIxIUvUwNIEHT
 v0vUkyqOkLHEEmJ/Wi0x/nsT7rXAPwE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-Ejy35XOpO1m8pr1XLMEC4g-1; Thu, 03 Aug 2023 18:20:46 -0400
X-MC-Unique: Ejy35XOpO1m8pr1XLMEC4g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993c24f3246so182035166b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101244; x=1691706044;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=thm/fnhI6kskNWZ5PLl/mTfNzXktl6SUV8xaAs/11Lw=;
 b=Y73w+p+TiEuzD7jEQnXcEzYVX9QB6ESCVg18A5OU33WEMOqgdNu37zKfbAwNm0j8VI
 36gQ4wdXeuXhEYriVP46sstQZzIQd9719MkEtIcQdlSyb5Rhcs6rlIt8xnOdJoqRAM2o
 T+JFwK3+bNDtIBmN+WWFNgeY6jzYPst6StTZQr6KYVDmfskTZSnoybES0DXEvZuHbjxd
 38NvXQZnmsh8oHh4i0F8LsecSFp4hnJxup1LnCswzIHhl3q4/qfcMbPATk9I2HewW8yw
 SSgYjIpnRs+5GlrMNkyeula/EJeqOGMp9wa/tKuuDNZi/Mw0jxgSzfMQKzGz7NVbcZFR
 ew7Q==
X-Gm-Message-State: AOJu0YyWncuTgfOQnQA+depQFeMN3P8qp+RAHamI/4sf1bYy3sCLFSrW
 tGAiG/6U1aQW6BMYOat70bXTTm6Zp7Fpc0vmPgeBsFLFNWC93VfQ/3QLKxwBXEoORY+Rrq5zJV3
 CnrsPG2gnolc8af+WLyFmhbq7qzR7rckvBdwJAxLsGvoSU7+nMAu9ZP72wvKQyAerUAxw
X-Received: by 2002:a17:906:519c:b0:98f:8481:24b3 with SMTP id
 y28-20020a170906519c00b0098f848124b3mr55351ejk.37.1691101244491; 
 Thu, 03 Aug 2023 15:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPC8TN0Xjeio7w1ksk8wTK3nuUmTTbgUdGW8POqg/C/e9Wf2ChNU7Ad5/cD7KXHsD3ASC0/A==
X-Received: by 2002:a17:906:519c:b0:98f:8481:24b3 with SMTP id
 y28-20020a170906519c00b0098f848124b3mr55335ejk.37.1691101244164; 
 Thu, 03 Aug 2023 15:20:44 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 gw1-20020a170906f14100b0099b8234a9fesm380988ejb.1.2023.08.03.15.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:20:43 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:20:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/22] pc,pci,virtio,crypto: bugfixes
Message-ID: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit c167c80b463768e04a22fbe37ba6c53a4a08e41e:

  Merge tag 'pull-request-2023-08-03' of https://gitlab.com/thuth/qemu into staging (2023-08-03 07:37:17 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd:

  cryptodev: Handle unexpected request to avoid crash (2023-08-03 16:16:17 -0400)

----------------------------------------------------------------
pc,pci,virtio,crypto: bugfixes

fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Edmondson (1):
      hw/virtio: qmp: add RING_RESET to 'info virtio-status'

Eric Auger (2):
      hw/virtio-iommu: Fix potential OOB access in virtio_iommu_handle_command()
      virtio-iommu: Standardize granule extraction and formatting

Hanna Czenczek (1):
      virtio: Fix packed virtqueue used_idx mask

Igor Mammedov (6):
      tests: acpi: x86: whitelist expected blobs
      x86: acpi: workaround Windows not handling name references in Package properly
      tests: acpi: x86: update expected blobs
      tests: acpi: whitelist expected blobs
      acpi: x86: remove _ADR on host bridges
      tests: acpi: update expected blobs

Li Feng (1):
      vhost: fix the fd leak

Milan Zamazal (1):
      hw/virtio: Add a protection against duplicate vu_scmi_stop calls

Peter Maydell (1):
      hw/pci-bridge/cxl_upstream.c: Use g_new0() in build_cdat_table()

Thomas Huth (6):
      hw/i386/intel_iommu: Fix trivial endianness problems
      hw/i386/intel_iommu: Fix endianness problems related to VTD_IR_TableEntry
      hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big endian hosts
      hw/i386/intel_iommu: Fix index calculation in vtd_interrupt_remap_msi()
      hw/i386/x86-iommu: Fix endianness issue in x86_iommu_irq_to_msi_message()
      include/hw/i386/x86-iommu: Fix struct X86IOMMU_MSIMessage for big endian hosts

Yuri Benditovich (1):
      pci: do not respond config requests after PCI device eject

Zhenwei Pi (2):
      virtio-crypto: verify src&dst buffer length for sym request
      cryptodev: Handle unexpected request to avoid crash

 hw/i386/intel_iommu_internal.h                |   9 +++++
 include/hw/i386/intel_iommu.h                 |  50 +++++++++++++-------------
 include/hw/i386/x86-iommu.h                   |  50 +++++++++++++-------------
 include/hw/virtio/vhost-user-scmi.h           |   1 +
 backends/cryptodev.c                          |  10 ++++++
 hw/i386/acpi-build.c                          |  11 +++---
 hw/i386/intel_iommu.c                         |  23 +++++++-----
 hw/i386/x86-iommu.c                           |   2 +-
 hw/pci-bridge/cxl_upstream.c                  |   5 +--
 hw/pci/pci_host.c                             |  15 ++++++--
 hw/virtio/vhost-user-scmi.c                   |   7 ++++
 hw/virtio/vhost.c                             |   2 ++
 hw/virtio/virtio-crypto.c                     |   5 +++
 hw/virtio/virtio-iommu.c                      |  12 ++++---
 hw/virtio/virtio-qmp.c                        |   2 ++
 hw/virtio/virtio.c                            |   2 +-
 tests/data/acpi/pc/DSDT                       | Bin 6488 -> 6830 bytes
 tests/data/acpi/pc/DSDT.acpierst              | Bin 6411 -> 6741 bytes
 tests/data/acpi/pc/DSDT.acpihmat              | Bin 7813 -> 8155 bytes
 tests/data/acpi/pc/DSDT.bridge                | Bin 12615 -> 13701 bytes
 tests/data/acpi/pc/DSDT.cphp                  | Bin 6952 -> 7294 bytes
 tests/data/acpi/pc/DSDT.dimmpxm               | Bin 8142 -> 8484 bytes
 tests/data/acpi/pc/DSDT.hpbridge              | Bin 6451 -> 6781 bytes
 tests/data/acpi/pc/DSDT.hpbrroot              | Bin 3343 -> 3337 bytes
 tests/data/acpi/pc/DSDT.ipmikcs               | Bin 6560 -> 6902 bytes
 tests/data/acpi/pc/DSDT.memhp                 | Bin 7847 -> 8189 bytes
 tests/data/acpi/pc/DSDT.nohpet                | Bin 6346 -> 6688 bytes
 tests/data/acpi/pc/DSDT.numamem               | Bin 6494 -> 6836 bytes
 tests/data/acpi/pc/DSDT.roothp                | Bin 9873 -> 10623 bytes
 tests/data/acpi/q35/DSDT                      | Bin 8361 -> 8355 bytes
 tests/data/acpi/q35/DSDT.acpierst             | Bin 8378 -> 8372 bytes
 tests/data/acpi/q35/DSDT.acpihmat             | Bin 9686 -> 9680 bytes
 tests/data/acpi/q35/DSDT.acpihmat-noinitiator | Bin 8640 -> 8634 bytes
 tests/data/acpi/q35/DSDT.applesmc             | Bin 8407 -> 8401 bytes
 tests/data/acpi/q35/DSDT.bridge               | Bin 11590 -> 11968 bytes
 tests/data/acpi/q35/DSDT.core-count2          | Bin 32501 -> 32495 bytes
 tests/data/acpi/q35/DSDT.cphp                 | Bin 8825 -> 8819 bytes
 tests/data/acpi/q35/DSDT.cxl                  | Bin 9673 -> 9655 bytes
 tests/data/acpi/q35/DSDT.dimmpxm              | Bin 10015 -> 10009 bytes
 tests/data/acpi/q35/DSDT.ipmibt               | Bin 8436 -> 8430 bytes
 tests/data/acpi/q35/DSDT.ipmismbus            | Bin 8449 -> 8443 bytes
 tests/data/acpi/q35/DSDT.ivrs                 | Bin 8378 -> 8372 bytes
 tests/data/acpi/q35/DSDT.memhp                | Bin 9720 -> 9714 bytes
 tests/data/acpi/q35/DSDT.mmio64               | Bin 9491 -> 9485 bytes
 tests/data/acpi/q35/DSDT.multi-bridge         | Bin 12770 -> 13208 bytes
 tests/data/acpi/q35/DSDT.noacpihp             | Bin 8241 -> 8235 bytes
 tests/data/acpi/q35/DSDT.nohpet               | Bin 8219 -> 8213 bytes
 tests/data/acpi/q35/DSDT.numamem              | Bin 8367 -> 8361 bytes
 tests/data/acpi/q35/DSDT.pvpanic-isa          | Bin 8462 -> 8456 bytes
 tests/data/acpi/q35/DSDT.tis.tpm12            | Bin 8967 -> 8961 bytes
 tests/data/acpi/q35/DSDT.tis.tpm2             | Bin 8993 -> 8987 bytes
 tests/data/acpi/q35/DSDT.viot                 | Bin 9470 -> 9464 bytes
 tests/data/acpi/q35/DSDT.xapic                | Bin 35724 -> 35718 bytes
 53 files changed, 132 insertions(+), 74 deletions(-)


