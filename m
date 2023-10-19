Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 938AB7CFCF4
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:38:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtU7L-0006hA-DX; Thu, 19 Oct 2023 10:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7G-0006fs-PP
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7D-0000EN-PP
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZiWlRNulXY9zcz/Z0lV7RlrqHDJuq9AIIhFR5zobfxc=;
 b=dJVoO1UqcC2NBNG5UfFeC/e0J+kNBIJoC7JFBJNuU1dBrpCFqsSCwFjJFujX6aIpJ4M8oX
 bPjqx6qU76hxSjpIjgV2dBZO6gzYXCBu8EgGdcDHDNzHt+Sb4Cy7tnSCPPoYtCrYpTTyPn
 EQ257PwcXVKxUJD5n1V7XpX4wOu+coQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-5-wwwBJLMSS0vqaxBrrw5g-1; Thu, 19 Oct 2023 10:35:00 -0400
X-MC-Unique: 5-wwwBJLMSS0vqaxBrrw5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDD078EB36C;
 Thu, 19 Oct 2023 14:34:59 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75F45C15BB8;
 Thu, 19 Oct 2023 14:34:57 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Shannon <shannon.nelson@amd.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, si-wei.liu@oracle.com,
 Gautam Dawar <gdawar@xilinx.com>
Subject: [RFC PATCH 00/18] Map memory at destination .load_setup in vDPA-net
 migration
Date: Thu, 19 Oct 2023 16:34:37 +0200
Message-Id: <20231019143455.2377694-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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
Note that further devices setup at the end of the migration may alter the g=
uest=0D
memory layout. But same as the previous point, many operations are still do=
ne=0D
incrementally, like memory pinning, so we're saving time anyway.=0D
=0D
The first bunch of patches just reorganizes the code, so memory related=0D
operation parameters are shared between all vhost_vdpa devices.  This is=0D
because the destination does not know what vhost_vdpa struct will have the=
=0D
registered listener member, so it is easier to place them in a shared struc=
t=0D
rather to keep them in vhost_vdpa struct.  Future version may squash or omi=
t=0D
these patches.=0D
=0D
Only tested with vdpa_sim. I'm sending this before full benchmark, as some =
work=0D
like [1] can be based on it, and Si-Wei agreed on benchmark this series wit=
h=0D
his experience.=0D
=0D
Future directions on top of this series may include:=0D
* Iterative migration of virtio-net devices, as it may reduce downtime per =
[1].=0D
  vhost-vdpa net can apply the configuration through CVQ in the destination=
=0D
  while the source is still migrating.=0D
* Move more things ahead of migration time, like DRIVER_OK.=0D
* Check that the devices of the destination are valid, and cancel the migra=
tion=0D
  in case it is not.=0D
=0D
[1] https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61=
@nvidia.com/T/=0D
=0D
Eugenio P=C3=A9rez (18):=0D
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
  vdpa: do not set virtio status bits if unneeded=0D
  vdpa: add vhost_vdpa_load_setup=0D
  vdpa: add vhost_vdpa_net_load_setup NetClient callback=0D
  vdpa: use shadow_data instead of first device v->shadow_vqs_enabled=0D
  virtio_net: register incremental migration handlers=0D
=0D
 include/hw/virtio/vhost-vdpa.h |  43 +++++---=0D
 include/net/net.h              |   4 +=0D
 hw/net/virtio-net.c            |  23 +++++=0D
 hw/virtio/vdpa-dev.c           |   7 +-=0D
 hw/virtio/vhost-vdpa.c         | 183 ++++++++++++++++++---------------=0D
 net/vhost-vdpa.c               | 127 ++++++++++++-----------=0D
 hw/virtio/trace-events         |  14 +--=0D
 7 files changed, 239 insertions(+), 162 deletions(-)=0D
=0D
-- =0D
2.39.3=0D
=0D


