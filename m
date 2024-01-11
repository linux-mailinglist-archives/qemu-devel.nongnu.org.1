Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13782B503
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 20:03:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO0K2-0001xB-As; Thu, 11 Jan 2024 14:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0Jz-0001x0-Sd
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0Jx-0002KL-Ug
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704999748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N+psGPCNp1A3MJtkEUzDWqFXD2joADq29LbRaMx5pNY=;
 b=hLAENekDBQEhPFTDJ2wZL8MISpj2PftAMYloIctrdGci8KDYSm0WWw34pyPhxNfiC5QQ8i
 +iPe14hAIDj0zN9oTtGsQPacXjFhC4Tc4anhluC5EiCIJCu+7kKYeFm2fGbHeYYggru6dO
 P/+JgHjfkjc1X/l4ie3jc5Sd7+0WPjQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-COOmojc-Ml6y0un1K0Ub3w-1; Thu, 11 Jan 2024 14:02:26 -0500
X-MC-Unique: COOmojc-Ml6y0un1K0Ub3w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B269185A780;
 Thu, 11 Jan 2024 19:02:26 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B3DE492BF0;
 Thu, 11 Jan 2024 19:02:24 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>
Subject: [PATCH 0/6] Move memory listener register to vhost_vdpa_init
Date: Thu, 11 Jan 2024 20:02:16 +0100
Message-Id: <20240111190222.496695-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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
destination from the moment that all devices are initializaed.  So=0D
moving that operation allows QEMU to communicate the kernel the maps=0D
while the workload is still running in the source, so Linux can start=0D
mapping them.=0D
=0D
As a small drawback, there is a time in the initialization where QEMU=0D
cannot respond to QMP etc.  By some testing, this time is about=0D
0.2seconds.  This may be further reduced (or increased) depending on the=0D
vdpa driver and the platform hardware, and it is dominated by the cost=0D
of memory pinning.=0D
=0D
This matches the time that we move out of the called downtime window.=0D
The downtime is measured as checking the trace timestamp from the moment=0D
the source suspend the device to the moment the destination starts the=0D
eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526=0D
secs to 2.0949.=0D
=0D
Future directions on top of this series may include to move more things ahe=
ad=0D
of the migration time, like set DRIVER_OK or perform actual iterative migra=
tion=0D
of virtio-net devices.=0D
=0D
Comments are welcome.=0D
=0D
This series is a different approach of series [1]. As the title does not=0D
reflect the changes anymore, please refer to the previous one to know the=0D
series history.=0D
=0D
[1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.25=
40987-1-eperezma@redhat.com/=0D
=0D
Eugenio P=C3=A9rez (6):=0D
  vdpa: check for iova tree initialized at net_client_start=0D
  vdpa: reorder vhost_vdpa_set_backend_cap=0D
  vdpa: set backend capabilities at vhost_vdpa_init=0D
  vdpa: add listener_registered=0D
  vdpa: reorder listener assignment=0D
  vdpa: move memory listener register to vhost_vdpa_init=0D
=0D
 include/hw/virtio/vhost-vdpa.h |  6 +++=0D
 hw/virtio/vhost-vdpa.c         | 87 +++++++++++++++++++++-------------=0D
 net/vhost-vdpa.c               |  4 +-=0D
 3 files changed, 63 insertions(+), 34 deletions(-)=0D
=0D
-- =0D
2.39.3=0D
=0D


