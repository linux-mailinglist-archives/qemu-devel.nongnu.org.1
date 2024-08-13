Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D9D950941
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Aug 2024 17:40:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtcf-00029T-9U; Tue, 13 Aug 2024 11:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sdtcd-00028z-PP
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sdtcb-0007LD-VU
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723563579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KF7ksS8mqinHtAwsYaED5eVUUKaymGfylxECt6NmKJg=;
 b=KrU1Gco/k6gUXysseefNjxDxBik1CQ0deRLeRv7LYgU71B1cMxuuuCxPpGBnhfNWKDKjQE
 jngLngGM6d/2wOjrlPslFIWJZsDaXPfYAV4F7mpsoPKtkm2Rbg17xkId1XfbncUTsqkaag
 jdzKGPOWmLZnguHJkt9dLcpGVFqv6qM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-Vyc0lhDjNISq361-ZkrEtg-1; Tue,
 13 Aug 2024 11:39:35 -0400
X-MC-Unique: Vyc0lhDjNISq361-ZkrEtg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F12D1955F66; Tue, 13 Aug 2024 15:39:34 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.45.226.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96B45300019C; Tue, 13 Aug 2024 15:39:32 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/4] virtio-mem: Implement support for suspend+wake-up with
 plugged memory
Date: Tue, 13 Aug 2024 17:39:16 +0200
Message-ID: <20240813153922.311788-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

Currently, the virtio-mem device would unplug all the memory with any
reset request, including when the machine wakes up from a suspended
state (deep sleep). This would lead to a loss of the contents of the
guest memory and therefore is disabled by the virtio-mem Linux Kernel
driver unless the VIRTIO_MEM_F_PERSISTENT_SUSPEND virtio feature is
exposed. [1]

To make deep sleep with virtio-mem possible, we need to differentiate
cold start reset from wake-up reset. The first patch updates
qemu_system_reset() and MachineClass children to accept ResetType
instead of ShutdownCause, which then could be passed down the device
tree. The second patch then introduces the new reset type for the
wake-up event and updates the i386 wake-up method (only architecture
using the explicit wake-up method).

The third patch replaces LegacyReset with the Resettable interface in
virtio-mem, so the memory device can access the reset type in the hold
phase. The last patch of the series implements the final support in the
hold phase of the virtio-mem reset callback and exposes
VIRTIO_MEM_F_PERSISTENT_SUSPEND to the kernel.

[1]: https://lore.kernel.org/all/20240318120645.105664-1-david@redhat.com/

v2:
- Removed unnecessary include directives changes
- Updated RESET_TYPE_WAKEUP documentation
- Removed unnecessary interface from VirtIOMEMClass type info

Juraj Marcin (4):
  reset: Use ResetType for qemu_devices_reset() and
    MachineClass::reset()
  reset: Add RESET_TYPE_WAKEUP
  virtio-mem: Use new Resettable framework instead of LegacyReset
  virtio-mem: Add support for suspend+wake-up with plugged memory

 docs/devel/reset.rst           |  8 ++++++
 hw/arm/aspeed.c                |  4 +--
 hw/arm/mps2-tz.c               |  4 +--
 hw/core/reset.c                |  5 +---
 hw/hppa/machine.c              |  4 +--
 hw/i386/microvm.c              |  4 +--
 hw/i386/pc.c                   |  6 ++---
 hw/ppc/pegasos2.c              |  4 +--
 hw/ppc/pnv.c                   |  4 +--
 hw/ppc/spapr.c                 |  6 ++---
 hw/s390x/s390-virtio-ccw.c     |  4 +--
 hw/virtio/virtio-mem.c         | 48 ++++++++++++++++++++++++----------
 hw/virtio/virtio-qmp.c         |  3 +++
 include/hw/boards.h            |  3 ++-
 include/hw/resettable.h        |  2 ++
 include/hw/virtio/virtio-mem.h |  4 +++
 include/sysemu/reset.h         |  5 ++--
 system/runstate.c              | 13 +++++++--
 18 files changed, 88 insertions(+), 43 deletions(-)

-- 
2.46.0


