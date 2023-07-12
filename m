Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDB875012A
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:19:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJV31-00040J-1x; Wed, 12 Jul 2023 04:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV2s-0003zk-6I
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV2p-0000SH-J1
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689149874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lLuR6dAtqtQv+BBX5z7lYAiBGcAZGy4sYVjFeAyMrsc=;
 b=D2IcH0+hDFY06aISVN0vJd0/75+g8aC8K7R4+YqTTkv2BdVR0qJWXx1MC5Yb65u8q2/qQc
 6gIlEv903NWhoJtEQtQThlZMAU2WuyPxIRZeEq4o7pkHCMHtLJjkfDbUa//gHYjKuYszla
 5LGeDeC42JIhdT77n1JdVY4RuBx4jPY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-Ion7xuPtNniSPb9LPxMoRg-1; Wed, 12 Jul 2023 04:17:53 -0400
X-MC-Unique: Ion7xuPtNniSPb9LPxMoRg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAFD73C100A0;
 Wed, 12 Jul 2023 08:17:52 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49E9A492C13;
 Wed, 12 Jul 2023 08:17:51 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [GIT PULL 00/21] Host Memory Backends and Memory devices queue
 2023-07-12
Date: Wed, 12 Jul 2023 10:17:29 +0200
Message-ID: <20230712081750.80852-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

The following changes since commit 887cba855bb6ff4775256f7968409281350b568c:

  configure: Fix cross-building for RISCV host (v5) (2023-07-11 17:56:09 +0100)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/mem-2023-07-12

for you to fetch changes up to 339a8bbdfed910d0baa392c2071fd0e09b30aed9:

  virtio-mem-pci: Device unplug support (2023-07-12 09:27:32 +0200)

----------------------------------------------------------------
Hi,

"Host Memory Backends" and "Memory devices" queue ("mem"):
- Memory device cleanups (especially around machine initialization)
- "x-ignore-shared" migration support for virtio-mem
- Add an abstract virtio-md-pci device as a common parent for
  virtio-mem-pci and virtio-pmem-pci (virtio based memory devices)
- Device unplug support for virtio-mem-pci

----------------------------------------------------------------
David Hildenbrand (21):
      memory-device: Unify enabled vs. supported error messages
      memory-device: Introduce machine_memory_devices_init()
      hw/arm/virt: Use machine_memory_devices_init()
      hw/ppc/spapr: Use machine_memory_devices_init()
      hw/loongarch/virt: Use machine_memory_devices_init()
      hw/i386/pc: Use machine_memory_devices_init()
      hw/i386/acpi-build: Rely on machine->device_memory when building SRAT
      hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZE
      memory-device: Refactor memory_device_pre_plug()
      memory-device: Track used region size in DeviceMemoryState
      softmmu/physmem: Warn with ram_block_discard_range() on MAP_PRIVATE file mapping
      virtio-mem: Skip most of virtio_mem_unplug_all() without plugged memory
      migration/ram: Expose ramblock_is_ignored() as migrate_ram_is_ignored()
      virtio-mem: Support "x-ignore-shared" migration
      virtio-md-pci: New parent type for virtio-mem-pci and virtio-pmem-pci
      pc: Factor out (un)plug handling of virtio-md-pci devices
      arm/virt: Use virtio-md-pci (un)plug functions
      virtio-md-pci: Handle unplug of virtio based memory devices
      virtio-md-pci: Support unplug requests for compatible devices
      virtio-mem: Prepare for device unplug support
      virtio-mem-pci: Device unplug support

 MAINTAINERS                       |   7 ++
 hw/arm/virt.c                     |  90 ++++-------------------
 hw/i386/acpi-build.c              |   9 +--
 hw/i386/pc.c                      | 126 ++++---------------------------
 hw/loongarch/virt.c               |  12 +--
 hw/mem/memory-device.c            |  69 ++++++++---------
 hw/ppc/spapr.c                    |  37 +++++-----
 hw/ppc/spapr_hcall.c              |   2 +-
 hw/virtio/Kconfig                 |   8 +-
 hw/virtio/meson.build             |   1 +
 hw/virtio/virtio-md-pci.c         | 151 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-mem-pci.c        |  54 ++++++++++++--
 hw/virtio/virtio-mem-pci.h        |   6 +-
 hw/virtio/virtio-mem.c            |  92 ++++++++++++++++++-----
 hw/virtio/virtio-pmem-pci.c       |   5 +-
 hw/virtio/virtio-pmem-pci.h       |   6 +-
 include/hw/boards.h               |   3 +
 include/hw/i386/pc.h              |   1 -
 include/hw/virtio/virtio-md-pci.h |  44 +++++++++++
 include/hw/virtio/virtio-mem.h    |   1 +
 include/migration/misc.h          |   1 +
 migration/postcopy-ram.c          |   2 +-
 migration/ram.c                   |  14 ++--
 migration/ram.h                   |   3 +-
 softmmu/physmem.c                 |  18 +++++
 stubs/meson.build                 |   1 +
 stubs/virtio-md-pci.c             |  24 ++++++
 27 files changed, 479 insertions(+), 308 deletions(-)
 create mode 100644 hw/virtio/virtio-md-pci.c
 create mode 100644 include/hw/virtio/virtio-md-pci.h
 create mode 100644 stubs/virtio-md-pci.c

-- 
2.41.0


