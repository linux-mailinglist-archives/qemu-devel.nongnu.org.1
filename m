Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75475B659
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:16:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYBk-00053Z-24; Thu, 20 Jul 2023 14:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBO-0004KL-RC
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBM-0003Gy-It
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689876909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Tl7/y4tm1U21k3a2j51YzVThWNUiYwfs1PxNKmVHYA=;
 b=Tp6swRPjUkR6+NE3EdkxqgETkKb++KqofC3++s86Kk01ItLBjYstychYlL4DBcv8MdNrsv
 DtcVIzAIp1XL7TCuBNeRO3nwoZ2uMH7qhT79KxaTpBQq7At3qjbqUs4QLkwsvOa6cDr/G4
 hX2rFB7e8KIe2SL3r8SO8/d9rgSSR8c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-n7_ah0rlMRWkoJtFQphQ1w-1; Thu, 20 Jul 2023 14:15:03 -0400
X-MC-Unique: n7_ah0rlMRWkoJtFQphQ1w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 500F8185A78B;
 Thu, 20 Jul 2023 18:15:03 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB6F32166B25;
 Thu, 20 Jul 2023 18:15:01 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 si-wei.liu@oracle.com, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
Subject: [RFC PATCH 00/12] Prefer to use SVQ to stall dataplane at NIC state
 restore through CVQ
Date: Thu, 20 Jul 2023 20:14:47 +0200
Message-Id: <20230720181459.607008-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

At this moment the migration of net features that depends on CVQ is not=0D
possible, as there is no reliable way to restore the device state like mac=
=0D
address, number of enabled queues, etc to the destination.  This is mainly=
=0D
caused because the device must only read CVQ, and process all the commands=
=0D
before resuming the dataplane.=0D
=0D
This series uses the VirtIO feature _F_RING_RESET to achieve it, adding an=
=0D
alternative method to late vq enabling proposed in [1][2].  It expose SVQ t=
o=0D
the device until it process all the CVQ messages, and then replaces the vri=
ng=0D
for the guest's one.=0D
=0D
As an advantage, it uses a feature well deviced in the VirtIO standard.  As=
 a=0D
disadvantage, current HW already support the late enabling and it does not=
=0D
support RING_RESET.=0D
=0D
This patch must be applied on top of the series ("Enable vdpa net migration=
=0D
with features depending on CVQ") [1][2].=0D
=0D
The patch has been tested with vp_vdpa, but using high IOVA instead of a=0D
sepparated ID for shadow CVQ and shadow temporal vrings.=0D
=0D
[1] Message-id: <20230706191227.835526-1-eperezma@redhat.com>=0D
[2] https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg01325.html=
=0D
=0D
Eugenio P=C3=A9rez (12):=0D
  vhost: add vhost_reset_queue_op=0D
  vhost: add vhost_restart_queue_op=0D
  vhost_net: Use ops->vhost_restart_queue in vhost_net_virtqueue_restart=0D
  vhost_net: Use ops->vhost_reset_queue in vhost_net_virtqueue_reset=0D
  vdpa: add vhost_vdpa_set_vring_ready_internal=0D
  vdpa: add vhost_vdpa_svq_stop=0D
  vdpa: add vhost_vdpa_reset_queue=0D
  vdpa: add vhost_vdpa_svq_start=0D
  vdpa: add vhost_vdpa_restart_queue=0D
  vdpa: enable all vqs if the device support RING_RESET feature=0D
  vdpa: use SVQ to stall dataplane while NIC state is being restored=0D
  vhost: Allow _F_RING_RESET with shadow virtqueue=0D
=0D
 include/hw/virtio/vhost-backend.h  |   6 ++=0D
 hw/net/vhost_net.c                 |  16 ++--=0D
 hw/virtio/vhost-shadow-virtqueue.c |   1 +=0D
 hw/virtio/vhost-vdpa.c             | 139 +++++++++++++++++++++--------=0D
 net/vhost-vdpa.c                   |  55 ++++++++++--=0D
 hw/virtio/trace-events             |   2 +-=0D
 6 files changed, 171 insertions(+), 48 deletions(-)=0D
=0D
-- =0D
2.39.3=0D
=0D


