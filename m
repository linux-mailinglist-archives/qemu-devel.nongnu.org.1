Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE86855CC1
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Feb 2024 09:44:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXLG-00015d-55; Thu, 15 Feb 2024 03:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1raXL7-00013P-Ng
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:43:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1raXL5-00016k-P8
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707986607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l4UV+TeoEkjx0RFMuBJTXCL+UsBOif88tt5uvY15aDQ=;
 b=ZBZtbyLrOnJhfNVqS3oAqsSnkIHPL7w4CKJmfz7ER+/jm41GEoQXEUPSIq70RC8GlNXuBu
 bAlRBAAj6OEGIvgPdQHZcAQybRDTPoO/lmBg+wBUDXTAkxQhiCJxcE2+0mRp1rNB9fifBp
 x7Y6Uci2pC3awABXrFchqdzkVxR7Txc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-nvMqXk-SP3OFL-z_eZOK1Q-1; Thu,
 15 Feb 2024 03:43:23 -0500
X-MC-Unique: nvMqXk-SP3OFL-z_eZOK1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A95D38212D0;
 Thu, 15 Feb 2024 08:43:23 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 861117595;
 Thu, 15 Feb 2024 08:43:19 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, mst@redhat.com,
 peter.maydell@linaro.org, clg@redhat.com, zhenzhong.duan@intel.com,
 yanghliu@redhat.com
Cc: alex.williamson@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v5 0/4] VIRTIO-IOMMU: Introduce an aw-bits option
Date: Thu, 15 Feb 2024 09:42:10 +0100
Message-ID: <20240215084315.863897-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
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

In [1] and [2] we attempted to fix a case where a VFIO-PCI device
protected with a virtio-iommu is assigned to an x86 guest. On x86
the physical IOMMU may have an address width (gaw) of 39 or 48 bits
whereas the virtio-iommu exposes a 64b input address space by default.
Hence the guest may try to use the full 64b space and DMA MAP
failures may be encountered. To work around this issue we endeavoured
to pass usable host IOVA regions (excluding the out of range space) from
VFIO to the virtio-iommu device so that the virtio-iommu driver can
query those latter during the probe request and let the guest iommu
kernel subsystem carve them out.

However if there are several devices in the same iommu group,
only the reserved regions of the first one are taken into
account by the iommu subsystem of the guest. This generally
works on baremetal because devices are not going to
expose different reserved regions. However in our case, this
may prevent from taking into account the host iommu geometry.

So the simplest solution to this problem looks to introduce an
input address width option, aw-bits, which matches what is
done on the intel-iommu. By default, from now on it is set
to 39 bits with pc_q35 and 48 with arm virt. This replaces the
previous default value of 64b. So we need to introduce a compat
for machines older than 9.0 to behave similarly. We use
hw_compat_8_2 to acheive that goal.

Outstanding series [2] remains useful to let resv regions beeing
communicated on time before the probe request.

[1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
    https://lore.kernel.org/all/20231019134651.842175-1-eric.auger@redhat.com/
    - This is merged -

[2] [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for hotplugged devices
    https://lore.kernel.org/all/20240117080414.316890-1-eric.auger@redhat.com/
    - This is pending for review on the ML -

This series can be found at:
https://github.com/eauger/qemu/tree/virtio-iommu-aw-bits-v5

History:
v4 -> v5:
- small change in the aw-bits options description  [Cédric]

v3 -> v4:
- remove dependency on
  [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default page_size_mask
- Fix qtest error [Michael]
- add doc entry in qemu-options.hx

v2 -> v3:
- Collected Zhenzhong and Cédric's R-b + Yanghang's T-b
- use &error_abort instead of NULL error handle
  on object_property_get_uint() call (Cédric)
- use VTD_HOST_AW_39BIT (Cédric)

v1 -> v2
- Limit aw to 48b on ARM
- Check aw is within [32,64]
- Use hw_compat_8_2


Eric Auger (4):
  virtio-iommu: Add an option to define the input range width
  virtio-iommu: Trace domain range limits as unsigned int
  hw: Set virtio-iommu aw-bits default value on pc_q35 and arm virt
  qemu-options.hx: Add an entry for virtio-iommu-pci and document
    aw-bits

 include/hw/virtio/virtio-iommu.h | 1 +
 hw/arm/virt.c                    | 6 ++++++
 hw/core/machine.c                | 5 ++++-
 hw/i386/pc.c                     | 6 ++++++
 hw/virtio/virtio-iommu.c         | 7 ++++++-
 tests/qtest/virtio-iommu-test.c  | 2 +-
 hw/virtio/trace-events           | 2 +-
 qemu-options.hx                  | 8 ++++++++
 8 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.41.0


