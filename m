Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E8809E86
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 09:48:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWVN-0005wO-3p; Fri, 08 Dec 2023 03:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7WKM=HT=redhat.com=clg@ozlabs.org>)
 id 1rBWVC-0005qw-1a
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:46:30 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7WKM=HT=redhat.com=clg@ozlabs.org>)
 id 1rBWV7-0000jK-7F
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:46:28 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sml9H0jZbz4x2N;
 Fri,  8 Dec 2023 19:46:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sml9C6lF3z4x1v;
 Fri,  8 Dec 2023 19:46:07 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.0 00/10] vfio: Introduce a VFIOIOMMUClass 
Date: Fri,  8 Dec 2023 09:45:50 +0100
Message-ID: <20231208084600.858964-1-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7WKM=HT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello,

The VFIO object hierarchy has some constraints because each VFIO type
has a dual nature: a VFIO nature for passthrough support and a bus
nature (PCI, AP, CCW, Platform) for its initial presentation. It
seemed the best approach made because multi-inheritance is not
feasible with QOM and both aspect of the VFIO object, passthrough and
bus, require state. A QOM interface in that case is not sufficient.

One aspect of passthrough is interaction with the IOMMU. IOMMUFD
support was recently added and for this purpose, we introduced an
IOMMU backend framework simply based on a VFIOIOMMUOps struct. We
didn't want to use QOM again because it would have exposed the various
lowlevel backend objects to the QEMU machine and human interface which
felt unnecessary at the time.

The changes of this series introduce a VFIO_IOMMU QOM interface and
its VFIOIOMMUClass to replace the current VFIOIOMMUOps. This provides
better code abstraction for the type1 and sPAPR IOMMU backends and
allows us to improve the vfio_connect_container() implementation.
Also, QOM interfaces are not exposed at the QEMU interface level. Most
important, we can now avoid compiling the sPAPR IOMMU support on
targets not needing it. This saves some text in QEMU.

Applies on vfio-next.

Thanks,

C.

Cédric Le Goater (10):
  vfio/spapr: Extend VFIOIOMMUOps with a release handler
  vfio/container: Introduce vfio_legacy_setup() for further cleanups
  vfio/container: Initialize VFIOIOMMUOps under vfio_init_container()
  vfio/container: Introduce a VFIOIOMMU QOM interface
  vfio/container: Introduce a VFIOIOMMU legacy QOM interface
  vfio/container: Intoduce a new VFIOIOMMUClass::setup handler
  vfio/spapr: Introduce a sPAPR VFIOIOMMU QOM interface
  vfio/iommufd: Introduce a VFIOIOMMU iommufd QOM interface
  vfio/spapr: Only compile sPAPR IOMMU support when needed
  vfio/iommufd: Remove CONFIG_IOMMUFD usage

 include/hw/vfio/vfio-common.h         |   2 -
 include/hw/vfio/vfio-container-base.h |  22 +++-
 hw/vfio/common.c                      |  11 +-
 hw/vfio/container-base.c              |  12 ++-
 hw/vfio/container.c                   | 147 ++++++++++++++++----------
 hw/vfio/iommufd.c                     |  36 +++++--
 hw/vfio/pci.c                         |   2 +-
 hw/vfio/spapr.c                       |  61 ++++++-----
 hw/vfio/meson.build                   |   2 +-
 9 files changed, 195 insertions(+), 100 deletions(-)

-- 
2.43.0


