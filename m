Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A15BFBB6732
	for <lists+qemu-devel@lfdr.de>; Fri, 03 Oct 2025 12:35:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4d6q-0006Ja-Fj; Fri, 03 Oct 2025 06:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d6o-0006Iy-HM
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d6b-0004gB-DL
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759487615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qz9Z1vXYcjOhpLuQvRtYs7SZG0Y+C0wInBSAec3GhBs=;
 b=bARlyKZptKrLSwbdScSXx4ZZZC6oxVxJjgGExNToxXg6dc+xCbbNgbtw5GcCPjV4VVBFHW
 LBpjtRBY6vQk0xv8Qbo2dEfEId2SlEhw8M0A59ip6szh3AhPv8N5UeXdLDMrWJTovwyrNC
 XJqPGTLGjhUf4VzTKFDjg0WIpeuDYWc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-FyvfPhdiMXOsCoO_qyoyTA-1; Fri,
 03 Oct 2025 06:33:33 -0400
X-MC-Unique: FyvfPhdiMXOsCoO_qyoyTA-1
X-Mimecast-MFC-AGG-ID: FyvfPhdiMXOsCoO_qyoyTA_1759487612
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0EA819560AE
 for <qemu-devel@nongnu.org>; Fri,  3 Oct 2025 10:33:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.118])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E721C300018D; Fri,  3 Oct 2025 10:33:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/5] vfio queue
Date: Fri,  3 Oct 2025 12:33:23 +0200
Message-ID: <20251003103328.1864910-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 29b77c1a2db2d796bc3847852a5c8dc2a1e6e83b:

  Merge tag 'rust-ci-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-09-30 09:29:38 -0700)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20251003

for you to fetch changes up to f0b52aa08ab0868c18d881381a8fda4b59b37517:

  hw/vfio: Use uint64_t for IOVA mapping size in vfio_container_dma_*map (2025-10-02 10:41:23 +0200)

----------------------------------------------------------------
vfio queue:

* Remove workaround for kernel DMA unmap overflow
* Remove invalid uses of ram_addr_t type

----------------------------------------------------------------
Cédric Le Goater (1):
      vfio: Remove workaround for kernel DMA unmap overflow bug

Philippe Mathieu-Daudé (4):
      system/iommufd: Use uint64_t type for IOVA mapping size
      hw/vfio: Reorder vfio_container_query_dirty_bitmap() trace format
      hw/vfio: Avoid ram_addr_t in vfio_container_query_dirty_bitmap()
      hw/vfio: Use uint64_t for IOVA mapping size in vfio_container_dma_*map

 include/hw/vfio/vfio-container.h | 13 +++++++------
 include/hw/vfio/vfio-cpr.h       |  2 +-
 include/system/iommufd.h         |  6 +++---
 backends/iommufd.c               |  6 +++---
 hw/vfio-user/container.c         |  4 ++--
 hw/vfio/container-legacy.c       | 28 +++++-----------------------
 hw/vfio/container.c              | 15 ++++++++-------
 hw/vfio/cpr-legacy.c             |  2 +-
 hw/vfio/iommufd.c                |  6 +++---
 hw/vfio/listener.c               | 18 +++++++++---------
 hw/vfio/trace-events             |  7 +++----
 11 files changed, 45 insertions(+), 62 deletions(-)


