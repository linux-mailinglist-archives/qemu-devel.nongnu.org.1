Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF1777C4C
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:37:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7i8-00052Y-0L; Thu, 10 Aug 2023 11:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qU7i5-000523-St
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qU7i4-00038k-1G
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691681782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=orF9RQE/xpWurBtCFUZqeLc0LA26vBB7/iIuyGwVWI0=;
 b=C94s7AyxEVCY8fct5FpunAHQowu3oRGnGNbIni2a1AidALnGai3+uM+VOzl7uNQx131ech
 VgnWYmGLC+zj6+W4Pp9tVgcJlYhVZguJ+LbPN82vUAGNNoHGJW1Bb3L12QdHNa007GBfUA
 ZpKHKji3uVhQP71v0lzMY1AGl7kxa2A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-5brm8E8uMrKWVeDwQKg80Q-1; Thu, 10 Aug 2023 11:36:18 -0400
X-MC-Unique: 5brm8E8uMrKWVeDwQKg80Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16750185A78B;
 Thu, 10 Aug 2023 15:36:18 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C4522166B28;
 Thu, 10 Aug 2023 15:36:14 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 si-wei.liu@oracle.com, Parav Pandit <parav@mellanox.com>,
 Gautam Dawar <gdawar@xilinx.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Hawkins Jiawei <yin31149@gmail.com>, Shannon Nelson <snelson@pensando.io>,
 Lei Yang <leiyang@redhat.com>
Subject: [PATCH v2 0/5] Enable vdpa net migration with features depending on
 CVQ
Date: Thu, 10 Aug 2023 17:36:06 +0200
Message-Id: <20230810153611.3410882-1-eperezma@redhat.com>
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
From v1:=0D
* Factor out VRING_ENABLE ioctls from vhost_vdpa_dev_start to the caller,=0D
  instead of providing a callback to know if it must be called or not.=0D
* at https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg05447.html=
=0D
=0D
From FRC:=0D
* Enable vqs early in case CVQ cannot be shadowed.=0D
* at https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg01325.html=0D
=0D
Eugenio P=C3=A9rez (5):=0D
  vdpa: use first queue SVQ state for CVQ default=0D
  vdpa: export vhost_vdpa_set_vring_ready=0D
  vdpa: rename vhost_vdpa_net_load to vhost_vdpa_net_cvq_load=0D
  vdpa: move vhost_vdpa_set_vrings_ready to the caller=0D
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


