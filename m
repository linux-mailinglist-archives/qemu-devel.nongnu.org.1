Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B7C7FB85A
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 11:45:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7vYo-0006kK-V8; Tue, 28 Nov 2023 05:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r7vYl-0006jd-98
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:43:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r7vYj-0005dp-Gq
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701168194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UgTGwcOENzROtaj0eWF6SpaTqmIF1t1/VaaJBjbfdZE=;
 b=ZUaexozZylkpRy7O0nznhQuMTl4w7C966P19Y3fPumKGpUFHI4htyVZz0gCtmwjQSDf5kL
 UWcHtmFWCqD4au3sKm0cNK3906r37St3dFinz4VvjNhEtMO5dG0pAifrCx/ry0n6+5iiEa
 BOnUGZ05roczyAj8NDIhv7Nu8OwUDQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-58IXC40YM6yiPgV6CTTHcg-1; Tue, 28 Nov 2023 05:43:08 -0500
X-MC-Unique: 58IXC40YM6yiPgV6CTTHcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE4F5101A529;
 Tue, 28 Nov 2023 10:43:07 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72F5520268D7;
 Tue, 28 Nov 2023 10:43:05 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gautam Dawar <gdawar@xilinx.com>, Jason Wang <jasowang@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, yin31149@gmail.com,
 Shannon Nelson <shannon.nelson@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Yajun Wu <yajunw@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>, Lei Yang <leiyang@redhat.com>,
 si-wei.liu@oracle.com
Subject: [RFC PATCH v2 00/10] Map memory at destination .load_setup in
 vDPA-net migration
Date: Tue, 28 Nov 2023 11:42:53 +0100
Message-Id: <20231128104303.3314000-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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
the source, so Linux can start mapping them.=0D
=0D
Also, the destination of the guest memory may finish before the destination=
=0D
QEMU maps all the memory.  In this case, the rest of the memory will be map=
ped=0D
at the same time as before applying this series, when the device is startin=
g.=0D
So we're only improving with this series.=0D
=0D
RFC TODO: We should be able to not finish the migration while the memory is=
=0D
still not mapped, but I still need to find how.  Suggestions are welcome.=0D
=0D
Note that further devices setup at the end of the migration may alter the g=
uest=0D
memory layout. But same as the previous point, many operations are still do=
ne=0D
incrementally, like memory pinning, so we're saving time anyway.=0D
=0D
Only tested with vdpa_sim. I'm sending this before full benchmark, as some =
work=0D
like [1] can be based on it, and Si-Wei agreed on benchmark this series wit=
h=0D
his experience.=0D
=0D
This needs to be applied on top of [2], which perform some code reorganizat=
ion=0D
that allows to map the memory without knowing the queue layout the guest=0D
configure on the device.=0D
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
RFC v2:=0D
* Delegate map to another thread so it does no block QMP.=0D
* Fix not allocating iova_tree if x-svq=3Don at the destination.=0D
* Rebased on latest master.=0D
* More cleanups of current code, that might be split from this series too.=
=0D
=0D
[1] https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61=
@nvidia.com/T/=0D
[2] https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg05331.html=
=0D
=0D
Eugenio P=C3=A9rez (10):=0D
  vdpa: do not set virtio status bits if unneeded=0D
  vdpa: make batch_begin_once early return=0D
  vdpa: merge _begin_batch into _batch_begin_once=0D
  vdpa: extract out _dma_end_batch from _listener_commit=0D
  vdpa: factor out stop path of vhost_vdpa_dev_start=0D
  vdpa: check for iova tree initialized at net_client_start=0D
  vdpa: set backend capabilities at vhost_vdpa_init=0D
  vdpa: add vhost_vdpa_load_setup=0D
  vdpa: add vhost_vdpa_net_load_setup NetClient callback=0D
  virtio_net: register incremental migration handlers=0D
=0D
 include/hw/virtio/vhost-vdpa.h |  25 ++++=0D
 include/net/net.h              |   6 +=0D
 hw/net/virtio-net.c            |  35 +++++=0D
 hw/virtio/vhost-vdpa.c         | 257 +++++++++++++++++++++++++++------=0D
 net/vhost-vdpa.c               |  37 ++++-=0D
 5 files changed, 312 insertions(+), 48 deletions(-)=0D
=0D
-- =0D
2.39.3=0D
=0D


