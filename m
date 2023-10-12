Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A467C7069
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:37:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwoK-0002ej-CK; Thu, 12 Oct 2023 10:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoH-0002c4-Qh
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoE-0005em-PK
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mM+X1v49ua7s8GQs8OGEiuRfWNZ4oZI1zrZ5auxvezI=;
 b=Fl2RKdenLbYjBpisqWa4X6QMEWlq+QT9J7ydZrg7f+iw35n/q3ZxJbfYhMmmH5BeC9m5lK
 /L41l3vj/kM9n7sQijPGN67yS6j1xS1hz9URYQ+yKkAc07/Ux2LF4clpHc8Vyzws4nmIlr
 Cwd9k5IyR1YkGvC2PLghGaC3XKgbk+0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-YC4yxJpCNSqCuumZFzFRkA-1; Thu, 12 Oct 2023 10:36:57 -0400
X-MC-Unique: YC4yxJpCNSqCuumZFzFRkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4D263857B7C
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 14:36:56 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F5EB1C060DF;
 Thu, 12 Oct 2023 14:36:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Subject: [GIT PULL 00/18] Host Memory Backends and Memory devices queue
 2023-10-12
Date: Thu, 12 Oct 2023 16:36:37 +0200
Message-ID: <20231012143655.114631-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

The following changes since commit a51e5124a655b3dad80b36b18547cb1eca2c5eb2:

  Merge tag 'pull-omnibus-111023-1' of https://gitlab.com/stsquad/qemu into staging (2023-10-11 09:43:10 -0400)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/mem-2023-10-12

for you to fetch changes up to ee6398d862c108f8136a26d93d26680f3d222a3a:

  virtio-mem: Mark memslot alias memory regions unmergeable (2023-10-12 14:15:22 +0200)

----------------------------------------------------------------
Hi,

"Host Memory Backends" and "Memory devices" queue ("mem"):
- Support memory devices with multiple memslots
- Support memory devices that dynamically consume memslots
- Support memory devices that can automatically decide on the number of
  memslots to use
- virtio-mem support for exposing memory dynamically via multiple
  memslots
- Some required cleanups/refactorings

----------------------------------------------------------------
David Hildenbrand (18):
      vhost: Rework memslot filtering and fix "used_memslot" tracking
      vhost: Remove vhost_backend_can_merge() callback
      softmmu/physmem: Fixup qemu_ram_block_from_host() documentation
      kvm: Return number of free memslots
      vhost: Return number of free memslots
      memory-device: Support memory devices with multiple memslots
      stubs: Rename qmp_memory_device.c to memory_device.c
      memory-device: Track required and actually used memslots in DeviceMemoryState
      memory-device,vhost: Support memory devices that dynamically consume memslots
      kvm: Add stub for kvm_get_max_memslots()
      vhost: Add vhost_get_max_memslots()
      memory-device,vhost: Support automatic decision on the number of memslots
      memory: Clarify mapping requirements for RamDiscardManager
      virtio-mem: Pass non-const VirtIOMEM via virtio_mem_range_cb
      virtio-mem: Update state to match bitmap as soon as it's been migrated
      virtio-mem: Expose device memory dynamically via multiple memslots if enabled
      memory,vhost: Allow for marking memory device memory regions unmergeable
      virtio-mem: Mark memslot alias memory regions unmergeable

 MAINTAINERS                                   |   1 +
 accel/kvm/kvm-all.c                           |  35 +-
 accel/stubs/kvm-stub.c                        |   9 +-
 hw/mem/memory-device.c                        | 196 ++++++++++-
 hw/virtio/vhost-stub.c                        |   9 +-
 hw/virtio/vhost-user.c                        |  21 +-
 hw/virtio/vhost-vdpa.c                        |   1 -
 hw/virtio/vhost.c                             | 103 +++++-
 hw/virtio/virtio-mem-pci.c                    |  21 ++
 hw/virtio/virtio-mem.c                        | 330 +++++++++++++++++-
 include/exec/cpu-common.h                     |  15 +
 include/exec/memory.h                         |  27 +-
 include/hw/boards.h                           |  14 +-
 include/hw/mem/memory-device.h                |  57 +++
 include/hw/virtio/vhost-backend.h             |   9 +-
 include/hw/virtio/vhost.h                     |   3 +-
 include/hw/virtio/virtio-mem.h                |  32 +-
 include/sysemu/kvm.h                          |   4 +-
 include/sysemu/kvm_int.h                      |   1 +
 .../{qmp_memory_device.c => memory_device.c}  |  10 +
 stubs/meson.build                             |   2 +-
 system/memory.c                               |  35 +-
 system/physmem.c                              |  17 -
 23 files changed, 839 insertions(+), 113 deletions(-)
 rename stubs/{qmp_memory_device.c => memory_device.c} (56%)

-- 
2.41.0


