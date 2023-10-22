Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE45D7D2224
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:24:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUey-0008OW-Vv; Sun, 22 Oct 2023 05:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUew-0008Mw-Vz
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUeu-000092-8N
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=531TqlQWhsnm90WF15Qposv4RJ1B3vlZ0ISTJMiNBoU=;
 b=FcyG2t7Cg3cEHnVzKcAVQgiVLjEsxQPOxz4w0zHbOUvzd+g7BCVyswE2Ilt07TIh9IxAPo
 d1odXSPlAWn5lgszM98PtB6vyeBJzrrv8O/UkudUta6Gdh1SJkbDpcCqV4uwLEYe0ZwdMz
 73+px10stUrhfr55oFf0TP5nrH1TO/g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-7uQwWUPjNV67GdeZyQMsKA-1; Sun, 22 Oct 2023 05:22:00 -0400
X-MC-Unique: 7uQwWUPjNV67GdeZyQMsKA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32db9cd71d7so1133979f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966518; x=1698571318;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=531TqlQWhsnm90WF15Qposv4RJ1B3vlZ0ISTJMiNBoU=;
 b=PIX4bwfmEW8fH6UQY3trYMu1GtF65ScdMppKFA9WaJMKlln7zHvsf62kOF/QW/G8E2
 bsJtKq7o9RtW0aBzgWqV1enFzjalPzS6W9QEOkQPDOTZ8BmMaEEPead6IjvYHm4lt1zS
 9ESANZ58rXkwpOQOwQKlHg/3g0AMVLPYPPB/hjh0RtFsvHOHctGLBR24Ab4/ZjxKerGZ
 QgFTR1ycg8Mukn06eUJMiz9OHz/60Jhs+k+PWgxmIoIY2ywNX9GSOwuwpE78KPLidGkO
 7Ph0qiQTiclUtTc7yYtncKkH1wFgPMmUlpClFK8ylaKQegviuRrmG9gd2AlUsVibSRBe
 etAg==
X-Gm-Message-State: AOJu0YzvXuRTgf8s0pLQnVYvbbiFb96bFFHq9sshuMKoqqgy4zZxxIsm
 oKj4eUAu/zzvckNwuUVUGN4b37ytKJFzK8jbenYdI07qClZesyqC4jFj9+LmfJmfaCSCkmf8eqy
 +IqF0WdNJQY97uBzK2tGdJsGJrxxa9rGV0JOurIIR4C2PIR8rnhX/xkQ+ZK/3zoVfAnYJ
X-Received: by 2002:a5d:5956:0:b0:32d:de4f:140b with SMTP id
 e22-20020a5d5956000000b0032dde4f140bmr10095199wri.6.1697966518337; 
 Sun, 22 Oct 2023 02:21:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKAh0GwUsyVAkQ1oPgCYsKfteCt0YEtrE72eUaV9bEKL992mx0VEaGRnc9ejNOFj/LYeeETw==
X-Received: by 2002:a5d:5956:0:b0:32d:de4f:140b with SMTP id
 e22-20020a5d5956000000b0032dde4f140bmr10095182wri.6.1697966517939; 
 Sun, 22 Oct 2023 02:21:57 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 w11-20020a05600c474b00b00405959469afsm6540071wmo.3.2023.10.22.02.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:21:56 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:21:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 00/62] virtio,pc,pci: features, cleanups
Message-ID: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

changes from v2:

dropped new thread/core tests due to failures on older  hosts:


>>> MALLOC_PERTURB_=158 QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-x86_64
+G_TEST_DBUS_DAEMON=/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh
+QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon PYTHON=/builds/qemu-project/qemu/build/pyvenv/bin/python3.8
+/builds/qemu-project/qemu/build/tests/qtest/bios-tables-test --tap -k
――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――
stderr:
qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested
(260) exceeds the recommended cpus supported by KVM (240)
qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus
requested (260) exceeds the recommended cpus supported by KVM (240)
qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus
requested (520) exceeds the recommended cpus supported by KVM (240)
Number of hotpluggable cpus requested (520) exceeds the maximum cpus
supported by KVM (288)
socket_accept failed: Resource temporarily unavailable
**
ERROR:../tests/qtest/libqtest.c:496:qtest_init_internal: assertion
failed: (s->fd >= 0 && s->qmp_fd >= 0)
../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU
process but encountered exit status 1 (expected 0)
(test program exited with status code -6)

https://gitlab.com/qemu-project/qemu/-/jobs/5338513625




The following changes since commit ec6f9f135d5e5596ab0258da2ddd048f1fd8c359:

  Merge tag 'migration-20231017-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-10-17 10:06:21 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to c7016bf700cfbee52d2797bc4c592a39b17c4de7:

  intel-iommu: Report interrupt remapping faults, fix return value (2023-10-22 05:18:17 -0400)

----------------------------------------------------------------
virtio,pc,pci: features, cleanups

infrastructure for vhost-vdpa shadow work
piix south bridge rework
reconnect for vhost-user-scsi
dummy ACPI QTG DSM for cxl

tests, cleanups, fixes all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ani Sinha (1):
      hw/i386/cxl: ensure maxram is greater than ram size for calculating cxl range

Bernhard Beschow (30):
      hw/i386/acpi-build: Remove build-time assertion on PIIX/ICH9 reset registers being identical
      hw/i386/pc: Merge two if statements into one
      hw/i386/pc_piix: Allow for setting properties before realizing PIIX3 south bridge
      hw/i386/pc_piix: Assign PIIX3's ISA interrupts before its realize()
      hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS
      hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new "isa-irqs" property
      hw/i386/pc_piix: Remove redundant "piix3" variable
      hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"
      hw/i386/pc_q35: Wire ICH9 LPC function's interrupts before its realize()
      hw/isa/piix3: Wire PIC IRQs to ISA bus in host device
      hw/i386/pc: Wire RTC ISA IRQs in south bridges
      hw/isa/piix3: Create IDE controller in host device
      hw/isa/piix3: Create USB controller in host device
      hw/isa/piix3: Create power management controller in host device
      hw/isa/piix3: Drop the "3" from PIIX base class name
      hw/isa/piix4: Remove unused inbound ISA interrupt lines
      hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"
      hw/isa/piix4: Rename reset control operations to match PIIX3
      hw/isa/piix4: Reuse struct PIIXState from PIIX3
      hw/isa/piix3: Merge hw/isa/piix4.c
      hw/isa/piix: Allow for optional PIC creation in PIIX3
      hw/isa/piix: Allow for optional PIT creation in PIIX3
      hw/isa/piix: Harmonize names of reset control memory regions
      hw/isa/piix: Share PIIX3's base class with PIIX4
      hw/isa/piix: Reuse PIIX3 base class' realize method in PIIX4
      hw/isa/piix: Rename functions to be shared for PCI interrupt triggering
      hw/isa/piix: Reuse PIIX3's PCI interrupt triggering in PIIX4
      hw/isa/piix: Resolve duplicate code regarding PCI interrupt wiring
      hw/isa/piix: Implement multi-process QEMU support also for PIIX4
      hw/i386/pc_piix: Make PIIX4 south bridge usable in PC machine

Damien Zammit (1):
      timer/i8254: Fix one shot PIT mode

Dave Jiang (1):
      hw/cxl: Add QTG _DSM support for ACPI0017 device

David Woodhouse (1):
      intel-iommu: Report interrupt remapping faults, fix return value

Hanna Czenczek (1):
      vhost-user: Fix protocol feature bit conflict

Hawkins Jiawei (7):
      vdpa: Use iovec for vhost_vdpa_net_cvq_add()
      vdpa: Avoid using vhost_vdpa_net_load_*() outside vhost_vdpa_net_load()
      vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
      vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()
      vdpa: Introduce cursors to vhost_vdpa_net_loadx()
      vhost: Expose vhost_svq_available_slots()
      vdpa: Send cvq state load commands in parallel

Ilya Maximets (1):
      memory: initialize 'fv' in MemoryRegionCache to make Coverity happy

Jonathan Cameron (2):
      tests/acpi: Allow update of DSDT.cxl
      tests/acpi: Update DSDT.cxl with QTG DSM

Laszlo Ersek (7):
      vhost-user: strip superfluous whitespace
      vhost-user: tighten "reply_supported" scope in "set_vring_addr"
      vhost-user: factor out "vhost_user_write_sync"
      vhost-user: flatten "enforce_reply" into "vhost_user_write_sync"
      vhost-user: hoist "write_sync", "get_features", "get_u64"
      vhost-user: allow "vhost_set_vring" to wait for a reply
      vhost-user: call VHOST_USER_SET_VRING_ENABLE synchronously

Li Feng (5):
      vhost-user-common: send get_inflight_fd once
      vhost: move and rename the conn retry times
      vhost-user-scsi: support reconnect to backend
      vhost-user-scsi: start vhost when guest kicks
      vhost-user: fix lost reconnect

Matheus Tavares Bernardino (1):
      hw/display: fix memleak from virtio_add_resource

Stefan Hajnoczi (3):
      vhost-user: do not send RESET_OWNER on device reset
      vhost-backend: remove vhost_kernel_reset_device()
      virtio: call ->vhost_reset_device() during reset

Thomas Huth (1):
      MAINTAINERS: Add include/hw/intc/i8259.h to the PC chip section

 hw/i386/intel_iommu_internal.h            |   1 +
 hw/virtio/vhost-shadow-virtqueue.h        |   1 +
 include/exec/memory.h                     |   2 +
 include/hw/acpi/cxl.h                     |   1 +
 include/hw/i386/pc.h                      |   2 +
 include/hw/southbridge/piix.h             |  30 ++-
 include/hw/virtio/vhost-scsi-common.h     |   2 +-
 include/hw/virtio/vhost-user-scsi.h       |   6 +
 include/hw/virtio/vhost-user.h            |   6 +-
 include/hw/virtio/vhost.h                 |  12 +
 subprojects/libvhost-user/libvhost-user.h |   3 +-
 hw/acpi/cxl.c                             |  69 ++++++
 hw/block/vhost-user-blk.c                 |   6 +-
 hw/display/virtio-dmabuf.c                |  12 +-
 hw/i386/acpi-build.c                      |   6 +-
 hw/i386/intel_iommu.c                     | 150 ++++++++----
 hw/i386/pc.c                              |  19 +-
 hw/i386/pc_piix.c                         | 123 +++++++---
 hw/i386/pc_q35.c                          |  14 +-
 hw/isa/lpc_ich9.c                         |   9 +-
 hw/isa/{piix3.c => piix.c}                | 281 ++++++++++++++++------
 hw/isa/piix4.c                            | 302 ------------------------
 hw/mips/malta.c                           |   5 +-
 hw/scsi/vhost-scsi-common.c               |  47 ++--
 hw/scsi/vhost-scsi.c                      |   6 +-
 hw/scsi/vhost-user-scsi.c                 | 254 +++++++++++++++++---
 hw/timer/i8254_common.c                   |   4 +-
 hw/virtio/vhost-backend.c                 |   6 -
 hw/virtio/vhost-shadow-virtqueue.c        |   2 +-
 hw/virtio/vhost-user-gpio.c               |   5 +-
 hw/virtio/vhost-user.c                    | 239 ++++++++++---------
 hw/virtio/vhost.c                         |   9 +
 hw/virtio/virtio.c                        |   4 +
 net/vhost-vdpa.c                          | 374 +++++++++++++++++++-----------
 MAINTAINERS                               |   7 +-
 docs/interop/vhost-user.rst               |  11 +
 docs/system/target-i386-desc.rst.inc      |   8 +
 hw/i386/Kconfig                           |   3 +-
 hw/isa/Kconfig                            |   8 +-
 hw/isa/meson.build                        |   3 +-
 hw/mips/Kconfig                           |   2 +-
 meson.build                               |   1 +
 tests/data/acpi/q35/DSDT.cxl              | Bin 9655 -> 9713 bytes
 43 files changed, 1219 insertions(+), 836 deletions(-)
 rename hw/isa/{piix3.c => piix.c} (52%)
 delete mode 100644 hw/isa/piix4.c


