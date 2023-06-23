Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C626E73B72D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfrf-00006c-RP; Fri, 23 Jun 2023 08:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCfrb-0008Q1-FJ
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCfrZ-0005q8-OV
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687523165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sZHbTs8TAJFf8Dpeo1BmacfLNPoBXQ8HjQzLuJTJ5uU=;
 b=R6NKbuM5sS1j69iCJo7eUWwfE5Fgs7cTS10WsvLv1uNEpyJ9ih4Hf583YMUwwm28Q/Ye9X
 9idnxOVEmT47j6vsw47tpAu+vlVXZsLoa0IaRHGGktAEayz+owOgFAmvJgkrkNwdRl1DCs
 FiPIQI1dgBNJ/zqZg2efkaAqwyDXMeE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-YIvC8eBhN-iE_phqiDn_aQ-1; Fri, 23 Jun 2023 08:26:01 -0400
X-MC-Unique: YIvC8eBhN-iE_phqiDn_aQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2464D29A9D36;
 Fri, 23 Jun 2023 12:21:00 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.22.32.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DF3E40C2063;
 Fri, 23 Jun 2023 12:20:57 +0000 (UTC)
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
 Gavin Shan <gshan@redhat.com>
Subject: [PATCH v2 0/7] virtio-mem: Device unplug support
Date: Fri, 23 Jun 2023 14:20:49 +0200
Message-Id: <20230623122056.374312-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

David Hildenbrand (7):
  virtio-md-pci: New parent type for virtio-mem-pci and virtio-pmem-pci
  pc: Factor out (un)plug handling of virtio-md-pci devices
  arm/virt: Use virtio-md-pci (un)plug functions
  virtio-md-pci: Handle unplug of virtio based memory devices
  virtio-md-pci: Support unplug requests for compatible devices
  virtio-mem: Prepare for device unplug support
  virtio-mem-pci: Device unplug support

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
 12 files changed, 305 insertions(+), 167 deletions(-)
 create mode 100644 hw/virtio/virtio-md-pci.c
 create mode 100644 include/hw/virtio/virtio-md-pci.h

-- 
2.40.1


