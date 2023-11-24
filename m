Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D657F7A1B
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:15:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ZlL-0004oj-5U; Fri, 24 Nov 2023 12:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r6ZlJ-0004oW-3k
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:14:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r6ZlH-0007Qn-J5
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700846078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pKbwHd5+EKYgYS4p1KG7gRXRVdqYbU5idndkrK85bz8=;
 b=TnTfMbhFNHgCpTQT2AZzrv0c+cYY34qEn6ZQ7O10rkzqS7lBxEQTRNEpv9ISZk4okckDhk
 V5H0Iu7eMp++QR130cC5jenJ3ZY0fVS0QkHueGOKhVdyS7POoC1mhTUkoH8zvUHbfU8ElR
 UgcJ/Q9oTwYmYTgA5PubLkg+XYJF2NI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-6l1kn6KKOZyy0m36W8EUpg-1; Fri, 24 Nov 2023 12:14:35 -0500
X-MC-Unique: 6l1kn6KKOZyy0m36W8EUpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03B4781B565;
 Fri, 24 Nov 2023 17:14:34 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC4240C6EB9;
 Fri, 24 Nov 2023 17:14:32 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Parav Pandit <parav@mellanox.com>, si-wei.liu@oracle.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 9.0 00/13] Consolidate common vdpa members in VhostVDPAShared
Date: Fri, 24 Nov 2023 18:14:17 +0100
Message-Id: <20231124171430.2964464-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Current memory operations like pinning may take a lot of time at the=0D
destination.  Currently they are done after the source of the migration is=
=0D
stopped, and before the workload is resumed at the destination.  This is a=
=0D
period where neigher traffic can flow, nor the VM workload can continue=0D
(downtime).=0D
=0D
We can do better as we know the memory layout of the guest RAM at the=0D
destination from the moment the migration starts.  Moving that operation al=
lows=0D
QEMU to communicate the kernel the maps while the workload is still running=
 in=0D
the source, so Linux can start mapping them.  Ideally, all IOMMU is configu=
red,=0D
but if the vDPA parent driver uses on-chip IOMMU and .set_map we're still=0D
saving all the pinning time.=0D
=0D
This is a first required step to consolidate all the members in a common=0D
struct.  This is needed because the destination does not know what vhost_vd=
pa=0D
struct will have the registered listener member, so it is easier to place t=
hem=0D
in a shared struct rather to keep them in vhost_vdpa struct.=0D
=0D
v1 from RFC:=0D
* Fix vhost_vdpa_net_cvq_start checking for always_svq instead of=0D
  shadow_data.  This could cause CVQ not being shadowed if=0D
  vhost_vdpa_net_cvq_start was called in the middle of a migration.=0D
=0D
Eugenio P=C3=A9rez (13):=0D
  vdpa: add VhostVDPAShared=0D
  vdpa: move iova tree to the shared struct=0D
  vdpa: move iova_range to vhost_vdpa_shared=0D
  vdpa: move shadow_data to vhost_vdpa_shared=0D
  vdpa: use vdpa shared for tracing=0D
  vdpa: move file descriptor to vhost_vdpa_shared=0D
  vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared=0D
  vdpa: move backend_cap to vhost_vdpa_shared=0D
  vdpa: remove msg type of vhost_vdpa=0D
  vdpa: move iommu_list to vhost_vdpa_shared=0D
  vdpa: use VhostVDPAShared in vdpa_dma_map and unmap=0D
  vdpa: use dev_shared in vdpa_iommu=0D
  vdpa: move memory listener to vhost_vdpa_shared=0D
=0D
 include/hw/virtio/vhost-vdpa.h |  36 +++++---=0D
 hw/virtio/vdpa-dev.c           |   7 +-=0D
 hw/virtio/vhost-vdpa.c         | 160 +++++++++++++++++----------------=0D
 net/vhost-vdpa.c               | 117 ++++++++++++------------=0D
 hw/virtio/trace-events         |  14 +--=0D
 5 files changed, 174 insertions(+), 160 deletions(-)=0D
=0D
-- =0D
2.39.3=0D
=0D


