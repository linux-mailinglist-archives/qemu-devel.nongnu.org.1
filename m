Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E74BA3A591
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Feb 2025 19:29:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSLF-0006sC-Tg; Tue, 18 Feb 2025 13:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkSL6-0006lw-74
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkSL4-0000BR-Cz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739903337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5ic1kQ00SjPC9W6tRUPbS8TZMhDToAtjvooCcGHwTDs=;
 b=Zd/Vu3ijZGLV96vt+i41e1SvwZzCJf2DM14VbJSABl7eXNd45eejA9cLqa5v/L5PIaaPxd
 PNcCvKhlTgEPwPIUuohaT4glH4glGo1ah6C71XBxmnIWUxT4Ff1Cl3bJq2aaRbV+whOk8r
 R59BnQG4obxQMyrMxFmoqHrK4jr4q1w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-v5mwcotOOpOGzQB94y49xw-1; Tue,
 18 Feb 2025 13:27:47 -0500
X-MC-Unique: v5mwcotOOpOGzQB94y49xw-1
X-Mimecast-MFC-AGG-ID: v5mwcotOOpOGzQB94y49xw_1739903266
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F32F1800872; Tue, 18 Feb 2025 18:27:46 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.254])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43D841800373; Tue, 18 Feb 2025 18:27:39 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: [PATCH v3 0/5] Fix vIOMMU reset order
Date: Tue, 18 Feb 2025 19:25:30 +0100
Message-ID: <20250218182737.76722-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

With current reset scheme, DMA capable devices are reset after
the vIOMMU which translate them. This holds for the different
IOMMUs and various DMA capable devices such as virtio devices
and VFIO ones. With virtio devices, spurious traces can be
observed at qemu level such as "virtio: zero sized buffers are
not allowed" while for VFIO devices, translation faults can be
observed at host level.

Virtio devices use 3 phase reset and virtio-pci devices are reset
in the 'hold' phase. VFIO device reset are registered using
qemu_register_reset() and as a consequence they are also reset
on 'hold' phase.

Note that the tree of QOM devices resets depth-first but it does
so while enforcing the 3 phases. First the tree is traversed doing
the 'enter' phase, then the 'hold' phase and eventually the 'exit'
phase.

However the QOM hierarchy is not built so that vIOMMUs get reset
after the DMA capable devices (IOMMUs are using either legacy reset
scheme or hold phase). Changing the QOM hierarchy does not sound
trivial while forcing the vIOMMUs to be reset on 'exit' phase
sounds reasonable and much simpler. Obviously this relies on the
assumption that all DMA capable devices quiesce their DMA before
(ie. during 'enter' or hold' phase).

This was tested with qmp system_reset and virsh reset.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/viommu-3phase-reset-v2

History:
v2 -> v3:
- Collected R-bs and A-bs from Zhenzhong and Jason
- fixed the cover letter (Zhenzhong)
- no code change

v1 -> v2:
- Removed hw/i386/intel_iommu: Tear down address spaces before
  IOMMU reset
- Also move SMMU base class reset to exit reset. This was an
  oversight from v1
- Add last patch documenting expectations in terms of DMA reset
- Improved commit messages and cover letter
- dared to keep Michael's A-b for the patches whose code was
  not altered

References:
[1] [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com/

Eric Auger (5):
  hw/virtio/virtio-iommu: Migrate to 3-phase reset
  hw/i386/intel-iommu: Migrate to 3-phase reset
  hw/arm/smmuv3: Move reset to exit phase
  hw/vfio/common: Add a trace point in vfio_reset_handler
  docs/devel/reset: Document reset expectations for DMA and IOMMU

 docs/devel/reset.rst     |  5 +++++
 hw/arm/smmu-common.c     |  9 +++++++--
 hw/arm/smmuv3.c          | 14 ++++++++++----
 hw/i386/intel_iommu.c    | 12 +++++++++---
 hw/vfio/common.c         |  1 +
 hw/virtio/virtio-iommu.c | 14 ++++++++++----
 hw/arm/trace-events      |  1 +
 hw/i386/trace-events     |  1 +
 hw/vfio/trace-events     |  1 +
 hw/virtio/trace-events   |  2 +-
 10 files changed, 46 insertions(+), 14 deletions(-)

-- 
2.47.1


