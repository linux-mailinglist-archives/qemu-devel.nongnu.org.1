Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BCE74897E
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:52:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5j9-0002GX-0t; Wed, 05 Jul 2023 12:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qH5j7-0002G6-9l
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qH5j4-0006lS-UO
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688575893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QxrJgGAUPxrDvz/ICUiyQnyZKNR4wEOMv3qXXRyyO8k=;
 b=I5BgahiilZFwXrq/6Ik10m9UreX9U6L9uG+w3NJAp1tWDdxwCbarxEUpZUaoNvJyBjWBrC
 PV0wstwQcFbAODhLvTzDyuptdW0A3Uvu8GB5bg03016XVWqQWAnJxcxl7loNrCE7rpNLEr
 j/7kG0f+f70Bs4gzP41+6zgifiTbpy4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-FZo84VQwNvKDDMn0k1vXqQ-1; Wed, 05 Jul 2023 12:51:30 -0400
X-MC-Unique: FZo84VQwNvKDDMn0k1vXqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6679810BB4;
 Wed,  5 Jul 2023 16:51:29 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4254A1121314;
 Wed,  5 Jul 2023 16:51:27 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, clg@redhat.com, bharat.bhushan@nxp.com,
 peter.maydell@linaro.org
Subject: [PATCH v2 0/2] VIRTIO-IOMMU/VFIO page size related fixes
Date: Wed,  5 Jul 2023 18:51:16 +0200
Message-Id: <20230705165118.28194-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

When assigning a host device and protecting it with the virtio-iommu we may
end up with qemu crashing with

    qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
    with mask 0x20010000
    qemu: hardware error: vfio: DMA mapping failed, unable to continue

This happens if the host features a 64kB page size and constraints
the physical IOMMU to use a 64kB page size. By default 4kB granule is used
by the qemu virtio-iommu device and this latter becomes aware of the 64kB
requirement too late, after the machine init, when the vfio device domain is
attached. virtio_iommu_set_page_size_mask() fails and this causes
vfio_listener_region_add() to end up with hw_error(). Currently the
granule is global to all domains.

To work around this issue, despite the IOMMU MR may be bypassed, we
transiently enable it on machine init done to get vfio_listener_region_add
and virtio_iommu_set_page_size_mask called ealier, before the domain
attach. That way the page size requirement can be taken into account
before the guest gets started.

Also get benefit of this series to do some cleanups in some traces
which may confuse the end user.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/virtio-iommu-page-size-v2

History:
v1 -> v2:
- test bypass is set before transiently enabling the IOMMU MRs
- add Zhenzhong's R-b

Eric Auger (2):
  virtio-iommu: Fix 64kB host page size VFIO device assignment
  virtio-iommu: Rework the traces in virtio_iommu_set_page_size_mask()

 include/hw/virtio/virtio-iommu.h |  2 ++
 hw/virtio/virtio-iommu.c         | 50 +++++++++++++++++++++++---------
 hw/virtio/trace-events           |  1 +
 3 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.38.1


