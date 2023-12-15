Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B9081487E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 13:54:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE7gj-0001fQ-J9; Fri, 15 Dec 2023 07:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rE7gf-0001f4-MP
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:53:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rE7gc-0001SO-6A
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702644778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qZUC/ko8waO8HaBfoDx/TM3f28qXhy5ToF4cP47wghs=;
 b=YqmC2gaOlnY1lRSUTYYXkP8yIim9zWLZnT48KwVG6ctQA9YCBwM247kqAFCroqAysbW40p
 MBtalpJAdQooX+GpFj/fRVAPwEPYF2OWFMtIG6UTHqc8vZLvxK/mcokpCdPtXZuv5XyEko
 QvHROBjPuKVOjGCd/SPMcgmN81O7TrU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-VaKBz_o-M76zzoPSj9Otqg-1; Fri, 15 Dec 2023 07:52:54 -0500
X-MC-Unique: VaKBz_o-M76zzoPSj9Otqg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 431018350E6;
 Fri, 15 Dec 2023 12:52:54 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E26F492BC6;
 Fri, 15 Dec 2023 12:52:52 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, si-wei.liu@oracle.com,
 Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 9.0 v2 00/13] Consolidate common vdpa members in
 VhostVDPAShared
Date: Fri, 15 Dec 2023 13:52:37 +0100
Message-Id: <20231215125250.2483663-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
v2:=0D
* Avoid repeated setting shared->shadow_data by squashing Si-Wei's patch=0D
  [1].=0D
=0D
v1 from RFC:=0D
* Fix vhost_vdpa_net_cvq_start checking for always_svq instead of=0D
  shadow_data.  This could cause CVQ not being shadowed if=0D
  vhost_vdpa_net_cvq_start was called in the middle of a migration.=0D
=0D
[1] https://patchwork.kernel.org/project/qemu-devel/patch/1701970793-6865-1=
0-git-send-email-si-wei.liu@oracle.com/=0D
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
 net/vhost-vdpa.c               | 116 ++++++++++++------------=0D
 hw/virtio/trace-events         |  14 +--=0D
 5 files changed, 173 insertions(+), 160 deletions(-)=0D
=0D
-- =0D
2.39.3=0D
=0D


