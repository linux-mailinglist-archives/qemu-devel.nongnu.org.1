Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC20EB005DA
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Jul 2025 16:56:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsgM-0006Gx-5p; Thu, 10 Jul 2025 10:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uZscs-0002MP-HJ
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uZscq-0000pB-44
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752159109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05FnDLOBUs73yFR98h/6VBX+yutNkKSf4EMRt4runqg=;
 b=TYqGhHxPzRkWUy/tuGJvpfOMuUIC2m3cekNT3CCSzDxxJqqTiAY73xu999weRVYlH+UGZE
 //mwnw0OTddY5QFQU3kxWy5/BLtB1w11A8ckTFv3N/UVcLA56EpjAhNbMNNv4uXGrKBLON
 BUFLzZ0FPavotrueDP75iu/+8Fjd/jE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-HCAoC35iPWqoFWW5xS2_6A-1; Thu, 10 Jul 2025 10:51:48 -0400
X-MC-Unique: HCAoC35iPWqoFWW5xS2_6A-1
X-Mimecast-MFC-AGG-ID: HCAoC35iPWqoFWW5xS2_6A_1752159107
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3af3c860ed7so574546f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 07:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752159107; x=1752763907;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=05FnDLOBUs73yFR98h/6VBX+yutNkKSf4EMRt4runqg=;
 b=tpD0dgJqdCPp9YWTllOnkZCaaep55BovY/+mFI4Ztg+T2om51qWw1MCF1FuDQ4kFb7
 LZEWh8wo3rm4vseizdM0wCjVZOl7/WwsXe7ILj4OjzGIKTmGV+0ci6XGIYuvq8RT3egF
 BLCfLHzoWbu78DOpJlX6Keu4BcLRyp2yNBh4vcvBLvcnekZ0WZB92I/FfKVQCAQ9FGnA
 Wn7jVowptjgLRPn/TWfoSxhebS4k4/DZemEYky1Gg4cYMmNd4fu1FQ1TKlTT0+CErs6g
 bn4yc3vNPGtqkK/ANfhvFuPhKOM9Ifm/EQuJlqRORb+SG8PDH/4aATl/DY9x4PG83r1S
 oN1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWblmpo1b+4P1TSz0fTW+aQcJhDW2pMz7OvLUQgfhHlOXByCeKinoxC7vJu65pV0xbFjIa+HhtJo0Dz@nongnu.org
X-Gm-Message-State: AOJu0Yzt+tLvxbpSr03EwPpeTwKTYaXx/0mLHDeoNIBNnYzywgSdDWaB
 uG/660eiZiESzzwIKKZdfRnlMMYQb0dYETN3OLQYj75UZ5mt14QlvagfkMavbjYCnL1cSi6cotx
 tJjZNOdAlhAUW3NARD+RuZb6IbGg2q17fuHW6dpO8hgTvVGBaycFIE54C
X-Gm-Gg: ASbGnctKlHbSGwle6OWekxizjCFQwYU4h0zzNqP7KE2+2IbKH4pmE0VI3ODAuufEt1d
 XfgLVGgfpg3i18lTCw6oUFj/Xqx/tnNPC8tjaIzlNvyh6JZiTciW98OIiOh6PX0WdkWC2NGlGFo
 QkoBLQrQK5T8mKqWKCDuuJPZOtf8kA6zDEn+Ry5MkDeD41LtUIvH7WfjtvrelwcKJ7ngCohjjcG
 kOIFHr9p+K4MHOcvD4MZRCFl8ws5WH8LLsMV+qmfmG5PfZSbFTTPxTJCG8ZZ8hK1vu0YfD/uUGf
 OYuYAhxqPuHja84=
X-Received: by 2002:a05:6000:4112:b0:3b4:9721:2b16 with SMTP id
 ffacd0b85a97d-3b5e86b1c39mr2396186f8f.36.1752159106942; 
 Thu, 10 Jul 2025 07:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg/Ab2s2BbkdKWhIf9TRGF/KDqBwJ7nD7DtYGpim6900QAqIwyWOT1GJv3q8ltj8x088zh3w==
X-Received: by 2002:a05:6000:4112:b0:3b4:9721:2b16 with SMTP id
 ffacd0b85a97d-3b5e86b1c39mr2396164f8f.36.1752159106357; 
 Thu, 10 Jul 2025 07:51:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8b6fdcbsm2092380f8f.0.2025.07.10.07.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 07:51:45 -0700 (PDT)
Date: Thu, 10 Jul 2025 10:51:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v6 00/36] ACPI PCI Hotplug support on ARM
Message-ID: <20250710104944-mutt-send-email-mst@kernel.org>
References: <20250708142437.1344644-1-eric.auger@redhat.com>
 <bc2625dc-ac1b-4ac3-99ea-a82ee2b48c9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc2625dc-ac1b-4ac3-99ea-a82ee2b48c9f@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 10, 2025 at 03:18:47PM +0200, Eric Auger wrote:
> Hi Michael,
> 
> On 7/8/25 4:22 PM, Eric Auger wrote:
> > This series enables ACPI PCI hotplug/hotunplug on ARM.
> > It is not enabled by default and ACPI PCI hotplug can
> > be selected by setting: 
> >
> > -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
> >
> > Expected benefits should be similar to those listed in [1],
> > ie. removal of some racy behaviors, improved latencies.
> >
> > The infrastructure used in x86 is heavily reused and a
> > huge part of the series consists in moving code from
> > hw/i386/acpi-build.c to a generic place and slightly
> > adapting it to make it usable on ARM. The DSDT table is 
> > augmented to support ACPI PCI hotplug elements.
> >
> > On ARM we use use a GED event to notify the OS about
> > hotplug events.
> 
> This morning Peter applied several series on target-arm.next and
> 9d8ade51a20d ("hw/arm/virt: Basic CXL enablement on pci_expander_bridge
> instances pxb-cxl")
> introduced a minor context conflict with my series� (with
> hw/pci-host/gpex-acpi: Use GED acpi pcihp property),
> in hw/arm/virt-acpi-build.c. This is straightforward to fix.
> 
> I have a branch where this conflict is resolved
> https://github.com/eauger/qemu.git
> arm-acpi-pcihp-v6-on-target-arm.next
> 6a8c8f69a0� hw/pci-host/gpex-acpi: Use GED acpi pcihp property
> 
> Please let me know if you want me to respin
> 
> Eric

As that's not yet merged in master, too early I think.


> >
> > Best Regards
> >
> > Eric
> >
> > This series can be found at:
> > https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v6
> >
> > previous series:
> > https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v5
> >
> > History:
> > v5 -> v6:
> > - collected Jonathan's R-bs
> > - cropped last 2 patch commit messages (Jonathan)
> >
> > v4 -> v5:
> > - Collected Jonathan's R-bs (many thanks!)
> > - fixed the tests/qtest/bios-tables-test issue by
> >   creating a variant for the viot test
> > - use the 3 phase reset API
> > - fixed qom-test failures that were due to unconditionnal
> >   fetches of the GED property
> >
> > v3 -> v4:
> > - toook into account all comments on v3
> > - static acpi-index is now supported unconditionally
> >   from acpi pcihp option. See indiviual patches.
> > - I hit a problem with ref block generation at
> >   [19/32] tests/qtest/bios-tables-test: Update ARM DSDT reference
> >   blobs: despite I regenerate the blobs, I get some errors.
> >
> > v2 -> v3:
> > - lot of changes taking into account various feedbacks
> >   (many thanks to all reviewers). Please refer to
> >   individual patches for details. Main changes:
> >   - no more machine option, acpi pci hp is not set by
> >     default.
> >   - removal of 2 unused variables in the osc method
> >   - introduction of GED property to set the bus
> >   - rework of the init/reset sequence
> >   - fix virtio-mem-pci hotplug regression
> >
> > v1 -> v2:
> > - collected a bunch of R-bs from Gustavo (many thanks!)
> > - Fixed the breakage of bios-tables-test in TCG mode by
> >   incorporating Gustavo's patches (part of
> >   [PATCH 0/5] ACPI tests for PCI Hotplug on ARM
> >   https://lore.kernel.org/all/20250526053123.1434204-1-gustavo.romero@linaro.org/)
> > - Tweeked the dsdt aml changes to avoid any dsdt blob difference when
> >   acpi-pcihp is off.
> >
> > RFC -> v1:
> > - First 3 trivial patches were pulled separately
> > - Fix of the register region size (0x18), ie. ACPI_PCIHP_SIZE
> > - addition of aml_pci_edsm which was not called in RFC
> > - acpi-index feature is now fixed. vms->bus was not set on
> >   acpi_pcihp_init. The init sequence is still hacky though. Suggestions
> >   are welcome.
> >
> > [1] [PATCH v6 0/6] Use ACPI PCI hot-plug for Q35
> > https://lore.kernel.org/all/20210713004205.775386-1-jusual@redhat.com/
> >
> >
> > Eric Auger (32):
> >   hw/i386/acpi-build: Make aml_pci_device_dsm() static
> >   hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
> >   hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
> >     acpi_dsdt_add_pci_osc
> >   hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
> >   hw/acpi/ged: Add a acpi-pci-hotplug-with-bridge-support property
> >   hw/pci-host/gpex-acpi: Use GED acpi pcihp property
> >   hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
> >   hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method
> >   tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _OSC change
> >   hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
> >   hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
> >   hw/i386/acpi-build: Move build_append_notification_callback to pcihp
> >   hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to
> >     pcihp
> >   hw/i386/acpi-build: Use AcpiPciHpState::root in acpi_set_pci_info
> >   hw/i386/acpi-build: Move aml_pci_edsm to a generic place
> >   qtest/bios-tables-test: Prepare for fixing the aarch64 viot test
> >   qtest/bios-tables-test: Add a variant to the aarch64 viot test
> >   qtest/bios-tables-test: Generate DSDT.viot
> >   hw/arm/virt-acpi-build: Let non hotplug ports support static
> >     acpi-index
> >   tests/qtest/bios-tables-test: Update ARM DSDT reference blobs
> >   hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI
> >     hotplug
> >   hw/acpi/ged: Add a bus link property
> >   hw/arm/virt: Pass the bus on the ged creation
> >   hw/acpi/ged: Call pcihp plug callbacks in hotplug handler
> >     implementation
> >   hw/acpi/pcihp: Remove root arg in acpi_pcihp_init
> >   hw/acpi/ged: Prepare the device to react to PCI hotplug events
> >   hw/acpi/ged: Support migration of AcpiPciHpState
> >   hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
> >   hw/arm/virt: Minor code reshuffling in create_acpi_ged
> >   hw/arm/virt: Let virt support pci hotplug/unplug GED event
> >   qtest/bios-tables-test: Generate reference blob for
> >     DSDT.hpoffacpiindex
> >   qtest/bios-tables-test: Generate reference blob for DSDT.acpipcihp
> >
> > Gustavo Romero (4):
> >   tests/qtest/bios-tables-test: Prepare for changes in the DSDT table
> >   tests/qtest/bios-tables-test: Prepare for changes in the arm virt DSDT
> >     table
> >   tests/qtest/bios-tables-test: Prepare for addition of acpi pci hp
> >     tests
> >   tests/qtest/bios-tables-test: Add aarch64 ACPI PCI hotplug test
> >
> >  hw/i386/acpi-build.h                          |   4 -
> >  include/hw/acpi/generic_event_device.h        |  17 +-
> >  include/hw/acpi/pci.h                         |   5 +-
> >  include/hw/acpi/pcihp.h                       |  17 +-
> >  include/hw/arm/virt.h                         |   1 +
> >  include/hw/pci-host/gpex.h                    |   1 +
> >  include/hw/sysbus.h                           |   1 +
> >  hw/acpi/acpi-pci-hotplug-stub.c               |   2 +-
> >  hw/acpi/generic_event_device.c                |  77 +++
> >  hw/acpi/ich9.c                                |   7 +-
> >  hw/acpi/pci-bridge.c                          |  54 ++
> >  hw/acpi/pci.c                                 |  50 ++
> >  hw/acpi/pcihp.c                               | 439 ++++++++++++++-
> >  hw/acpi/piix4.c                               |   5 +-
> >  hw/arm/virt-acpi-build.c                      |  38 ++
> >  hw/arm/virt.c                                 |  27 +-
> >  hw/core/sysbus.c                              |  11 +
> >  hw/i386/acpi-build.c                          | 532 +-----------------
> >  hw/pci-host/gpex-acpi.c                       |  74 +--
> >  tests/qtest/bios-tables-test.c                |  53 ++
> >  hw/arm/Kconfig                                |   2 +
> >  hw/pci-host/Kconfig                           |   1 +
> >  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5293 bytes
> >  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5379 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 0 -> 6202 bytes
> >  .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 0 -> 5347 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6654 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7768 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5495 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 0 -> 5310 bytes
> >  tests/data/acpi/riscv64/virt/DSDT             | Bin 3576 -> 3538 bytes
> >  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 2985 bytes
> >  32 files changed, 811 insertions(+), 607 deletions(-)
> >  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp
> >  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
> >  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.viot
> >


