Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6631C74F3B1
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:37:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFQP-0002s4-3x; Tue, 11 Jul 2023 11:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJFPo-0002io-MB
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJFPm-0006JI-6i
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689089789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=U3f78T6S05z8KbkTyGOlkA0yT83nXXYOtug9vzpPwgM=;
 b=JEsfKtaEGwj4F3xgCGTeEaLUcgc4ukdEleEK56g8yRQ4jTtT/5CT6Hb8HsP/pMfeGVA9nz
 eDuuSI28N5umse0K3nVCsYfRyLhNGhE/8f48YPI++ILazOZBy2TIqibxWzsghA124lOZQx
 DJPRRTrdLbMIk4bTEEwlmt6idH3VvJI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-rENx7KDvNLiEg7z3yKnonQ-1; Tue, 11 Jul 2023 11:34:58 -0400
X-MC-Unique: rENx7KDvNLiEg7z3yKnonQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 785DC2804604;
 Tue, 11 Jul 2023 15:34:48 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15309C51488;
 Tue, 11 Jul 2023 15:34:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v4 0/7] virtio-mem: Device unplug support
Date: Tue, 11 Jul 2023 17:34:38 +0200
Message-ID: <20230711153445.514112-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

One limitation of virtio-mem is that we cannot currently unplug virtio-mem
devices that have all memory unplugged from the VM.

Let's properly handle forced unplug (as can be triggered by the VM) and
add support for ordinary unplug (requests) of virtio-mem devices that are
in a compatible state (no legacy mode, no plugged memory, no plug request).

Briefly tested on both, x86_64 and aarch64.

v3 -> v4:
- "pc: Factor out (un)plug handling of virtio-md-pci devices"
 -> Add stubs to fix arm64 compilation under mingw
- Added Tested-by's

v2 -> v3:
- "virtio-md-pci: New parent type for virtio-mem-pci and virtio-pmem-pci"
 -> Add MAINTAINERS entry

v1 -> v2:
- Reduce code duplication and implement it in a cleaner way using a
  new abstract virtio-md-pci parent class
- "virtio-md-pci: New parent type for virtio-mem-pci and virtio-pmem-pci"
 -> Added, use a new aprent type like virtio-input-pci
- "pc: Factor out (un)plug handling of virtio-md-pci devices"
 -> Added, factor it cleanly out
- "arm/virt: Use virtio-md-pci (un)plug functions"
 -> Added, reduce code duplciation
- "virtio-md-pci: Handle unplug of virtio based memory devices"
 -> More generic without any device-specifics
- "virtio-md-pci: Support unplug requests for compatible devices"
 -> More generic without any device-specifics
- "virtio-mem: Prepare for device unplug support"
 -> Use callback, separated from virtio-mem-pci device change
- "virtio-mem-pci: Device unplug support"
 -> Use callback, separated from virtio-mem device change

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>
Cc: Mario Casquero <mcasquer@redhat.com>

David Hildenbrand (7):
  virtio-md-pci: New parent type for virtio-mem-pci and virtio-pmem-pci
  pc: Factor out (un)plug handling of virtio-md-pci devices
  arm/virt: Use virtio-md-pci (un)plug functions
  virtio-md-pci: Handle unplug of virtio based memory devices
  virtio-md-pci: Support unplug requests for compatible devices
  virtio-mem: Prepare for device unplug support
  virtio-mem-pci: Device unplug support

 MAINTAINERS                       |   7 ++
 hw/arm/virt.c                     |  81 +++-------------
 hw/i386/pc.c                      |  90 +++---------------
 hw/virtio/Kconfig                 |   8 +-
 hw/virtio/meson.build             |   1 +
 hw/virtio/virtio-md-pci.c         | 151 ++++++++++++++++++++++++++++++
 hw/virtio/virtio-mem-pci.c        |  54 +++++++++--
 hw/virtio/virtio-mem-pci.h        |   6 +-
 hw/virtio/virtio-mem.c            |  25 +++++
 hw/virtio/virtio-pmem-pci.c       |   5 +-
 hw/virtio/virtio-pmem-pci.h       |   6 +-
 include/hw/virtio/virtio-md-pci.h |  44 +++++++++
 include/hw/virtio/virtio-mem.h    |   1 +
 stubs/meson.build                 |   1 +
 stubs/virtio-md-pci.c             |  24 +++++
 15 files changed, 337 insertions(+), 167 deletions(-)
 create mode 100644 hw/virtio/virtio-md-pci.c
 create mode 100644 include/hw/virtio/virtio-md-pci.h
 create mode 100644 stubs/virtio-md-pci.c

-- 
2.41.0


