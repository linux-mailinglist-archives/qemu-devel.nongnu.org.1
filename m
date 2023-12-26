Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4FE81E64D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:24:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3fW-000167-G8; Tue, 26 Dec 2023 04:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fU-00015y-OL
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fT-0008EA-3C
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ANh4JCA2TsJmc1d86LQB2fG1OYyBIgfOFbiE/6vjwJk=;
 b=UOefl4aAALz8zUZnO7vejvQVpa1SwydyJLJVykvpqgu9hbIS9Ceo0TSdGF8sc/XCrKc0rT
 ysWH9shOV+4vXIIKhzWmKNYcyNKGg4KKnwzIBQFMY0g9cAPDzZioCcYW5NyFTNtbIDIS7Y
 kRCDffF5qZVkYcvdyOlCXyJ2b4p9XQE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-A2Y2kPVeP4eewoM-fDI7UQ-1; Tue, 26 Dec 2023 04:24:05 -0500
X-MC-Unique: A2Y2kPVeP4eewoM-fDI7UQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40c58a71b7cso40780775e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582642; x=1704187442;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANh4JCA2TsJmc1d86LQB2fG1OYyBIgfOFbiE/6vjwJk=;
 b=R2+c7WqP+QQ6+OoCkn4PxAMlePWgXfhF5nX9L0t5nyCic6kkJj4IZKN4z3hWeSidO+
 oTkamzwZrdprY3JVbIr+xKlZTR+Sfsi81FlJYQVamCDttWFUM9MM2pUBMWnLgq6Gwzxo
 /qNg/OnFG97cz65rzBf/FnmtHsPgTcsxpwcnujBAe7DYkuZnzhAdjMBLEjLbHxRdD94p
 XtZdJ4+rL++b3fqP3OsLeZ8xv/Bfmxv1fWHl8zQ4SKYZtgZcUtEn4/2H4iF6X/6P6PaZ
 YLgegeEF14T6ZH2ewP17IQ6qyrNYVqVU0y//uhJ3D6o4bm11u6/SBHByE+7UXATcz6hY
 7wbg==
X-Gm-Message-State: AOJu0YzoRPv75if9nIhYLMBZZxtJs3kcwFqpc4WMSdNwhFToIKTVw6UJ
 taY5PQW0WcAr+2ZwNF/5m/WYTqTGVPVC9A7Fkh5Cj8YRMuuCGiar2n/bNaAHh0404F4iSV6WWe0
 2oqAljLOUEX5ecpnvibLGqw6CPZXzMCX2YEAO8/+yclRKQJuylctmgONlKErsNoQnSR9VOwCL4A
 t8
X-Received: by 2002:a05:600c:2a8e:b0:40a:44c0:fd43 with SMTP id
 x14-20020a05600c2a8e00b0040a44c0fd43mr4030856wmd.17.1703582642120; 
 Tue, 26 Dec 2023 01:24:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ5HUdRLAeO8/tdHy6MZiRUkD2bHbNcKh8lBH3Z4p+3ZmO+1UJ5xwQNttG/W4nhJzDoV/r7A==
X-Received: by 2002:a05:600c:2a8e:b0:40a:44c0:fd43 with SMTP id
 x14-20020a05600c2a8e00b0040a44c0fd43mr4030849wmd.17.1703582641667; 
 Tue, 26 Dec 2023 01:24:01 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 u4-20020a05600c138400b0040c03c3289bsm20160978wmf.37.2023.12.26.01.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:00 -0800 (PST)
Date: Tue, 26 Dec 2023 04:23:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/21] virtio,pc,pci: features, cleanups, fixes
Message-ID: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 80f1709aa0eb4de09b4240563463f991a5b9d855:

  Merge tag 'pull-loongarch-20231221' of https://gitlab.com/gaosong/qemu into staging (2023-12-21 19:44:19 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 7b67b2f0f4f7c5ec888a331af599d9daff735d60:

  vdpa: move memory listener to vhost_vdpa_shared (2023-12-25 11:34:55 -0500)

----------------------------------------------------------------
virtio,pc,pci: features, cleanups, fixes

vhost-scsi support for worker ioctls

fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Aaron Young (1):
      hw/acpi: propagate vcpu hotplug after switch to modern interface

Dongli Zhang (1):
      vhost-scsi: fix usage of error_reportf_err()

Eugenio Pérez (14):
      vdpa: do not set virtio status bits if unneeded
      vdpa: add VhostVDPAShared
      vdpa: move iova tree to the shared struct
      vdpa: move iova_range to vhost_vdpa_shared
      vdpa: move shadow_data to vhost_vdpa_shared
      vdpa: use vdpa shared for tracing
      vdpa: move file descriptor to vhost_vdpa_shared
      vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
      vdpa: move backend_cap to vhost_vdpa_shared
      vdpa: remove msg type of vhost_vdpa
      vdpa: move iommu_list to vhost_vdpa_shared
      vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
      vdpa: use dev_shared in vdpa_iommu
      vdpa: move memory listener to vhost_vdpa_shared

Mathieu Poirier (1):
      virtio: rng: Check notifier helpers for VIRTIO_CONFIG_IRQ_IDX

Mike Christie (2):
      vhost: Add worker backend callouts
      vhost-scsi: Add support for a worker thread per virtqueue

Zhao Liu (1):
      tests: bios-tables-test: Rename smbios type 4 related test functions

wangmeiling (1):
      Fix bugs when VM shutdown with virtio-gpu unplugged

 include/hw/virtio/vhost-backend.h |  14 ++++
 include/hw/virtio/vhost-vdpa.h    |  40 ++++++----
 include/hw/virtio/virtio-scsi.h   |   1 +
 hw/acpi/cpu_hotplug.c             |  20 ++++-
 hw/display/virtio-gpu-base.c      |   4 +
 hw/scsi/vhost-scsi.c              |  66 ++++++++++++++-
 hw/scsi/vhost-user-scsi.c         |   3 +-
 hw/virtio/vdpa-dev.c              |   7 +-
 hw/virtio/vhost-backend.c         |  28 +++++++
 hw/virtio/vhost-user-rng.c        |  16 ++++
 hw/virtio/vhost-vdpa.c            | 164 ++++++++++++++++++++------------------
 net/vhost-vdpa.c                  | 116 +++++++++++++--------------
 tests/qtest/bios-tables-test.c    |  20 ++---
 hw/virtio/trace-events            |  14 ++--
 14 files changed, 334 insertions(+), 179 deletions(-)


