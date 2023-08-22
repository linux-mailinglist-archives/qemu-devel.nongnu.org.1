Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEC9783C27
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:54:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYN8z-0005Dz-9g; Tue, 22 Aug 2023 04:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qYN8x-0005Dq-QU
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qYN8v-0000dc-JZ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692694420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=T9D2Be9EwR4YIV+1ZUUalL1dPCXNJ/BE0vE2iIdyW+I=;
 b=BS9epBiVSgtupA3kJd/vDjAbw2WdLfYFy/AWui2xhz0Jtq3l4axfDFeOiDY+Md035SxF7E
 k6oY6vtk8a7KVRQJOFLJxJBzBBdpYhb9eSqRkVaYVT1dNPvljhlq899mW3NbesWj3B8FGj
 LVGcHLyHJByz2zlUH704NbWxapvxdgo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-VuMUbHZ3NQehe7wJLV_3dg-1; Tue, 22 Aug 2023 04:53:35 -0400
X-MC-Unique: VuMUbHZ3NQehe7wJLV_3dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 410F885D061;
 Tue, 22 Aug 2023 08:53:35 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB0B440C6F4C;
 Tue, 22 Aug 2023 08:53:32 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Shannon Nelson <snelson@pensando.io>,
 Stefano Garzarella <sgarzare@redhat.com>, Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hawkins Jiawei <yin31149@gmail.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Gautam Dawar <gdawar@xilinx.com>,
 si-wei.liu@oracle.com, Zhu Lingshan <lingshan.zhu@intel.com>,
 Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>
Subject: [PATCH v3 0/5] Enable vdpa net migration with features depending on
 CVQ
Date: Tue, 22 Aug 2023 10:53:25 +0200
Message-Id: <20230822085330.3978829-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

At this moment the migration of net features that depends on CVQ is not=0D
possible, as there is no reliable way to restore the device state like mac=
=0D
address, number of enabled queues, etc to the destination.  This is mainly=
=0D
caused because the device must only read CVQ, and process all the commands=
=0D
before resuming the dataplane.=0D
=0D
This series lift that requirement, sending the VHOST_VDPA_SET_VRING_ENABLE=
=0D
ioctl for dataplane vqs only after the device has processed all commands.=0D
---=0D
v3:=0D
* Fix subject typo and expand message of patch ("vdpa: move=0D
  vhost_vdpa_set_vring_ready to the caller").=0D
=0D
v2:=0D
* Factor out VRING_ENABLE ioctls from vhost_vdpa_dev_start to the caller,=0D
  instead of providing a callback to know if it must be called or not.=0D
* at https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg05447.html=
=0D
=0D
RFC:=0D
* Enable vqs early in case CVQ cannot be shadowed.=0D
* at https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg01325.html=0D
=0D
Eugenio P=C3=A9rez (5):=0D
  vdpa: use first queue SVQ state for CVQ default=0D
  vdpa: export vhost_vdpa_set_vring_ready=0D
  vdpa: rename vhost_vdpa_net_load to vhost_vdpa_net_cvq_load=0D
  vdpa: move vhost_vdpa_set_vring_ready to the caller=0D
  vdpa: remove net cvq migration blocker=0D
=0D
 include/hw/virtio/vhost-vdpa.h |  1 +=0D
 hw/virtio/vdpa-dev.c           |  3 ++=0D
 hw/virtio/vhost-vdpa.c         | 22 +++++-----=0D
 net/vhost-vdpa.c               | 75 +++++++++++++++++++---------------=0D
 hw/virtio/trace-events         |  2 +-=0D
 5 files changed, 57 insertions(+), 46 deletions(-)=0D
=0D
-- =0D
2.39.3=0D
=0D


