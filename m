Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9C574A443
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:13:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHUPC-000635-J4; Thu, 06 Jul 2023 15:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qHUPA-00062X-Ln
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qHUP8-0003es-Ox
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688670757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vA6VZraYIjzYxbDaNGvgiO66f1LsbKPy5Fs8TnSWCfc=;
 b=PMBBCfOMC+MzGERS8NGN9BNvZOPuPmDlxSnQABerAV8sAU9efhnXrCTx+Qnhh3+fsy69Bz
 c8LctgV5L+5M8u83R+SBrna5hJa/SjWMmIzPGzG3x2M7LLW/HhmgCmcg5fKX/LpiB1RGko
 trY2A17TYS//zcQZrHPTeFSLq0Bfb/Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-vesBVK-pMMSneZNQ3gvWqQ-1; Thu, 06 Jul 2023 15:12:32 -0400
X-MC-Unique: vesBVK-pMMSneZNQ3gvWqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 615553C100BD;
 Thu,  6 Jul 2023 19:12:31 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D46F4087C6A;
 Thu,  6 Jul 2023 19:12:28 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cindy Lu <lulu@redhat.com>, si-wei.liu@oracle.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 Shannon Nelson <snelson@pensando.io>, Gautam Dawar <gdawar@xilinx.com>,
 Jason Wang <jasowang@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Parav Pandit <parav@mellanox.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>
Subject: [RFC PATCH 0/6] Enable vdpa net migration with features depending on
 CVQ
Date: Thu,  6 Jul 2023 21:12:21 +0200
Message-Id: <20230706191227.835526-1-eperezma@redhat.com>
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
This RFC lift that requirement, sending the VHOST_VDPA_SET_VRING_ENABLE ioc=
tl=0D
for dataplane vqs only after the device has processed all commands.  If thi=
s=0D
method is valid or not, or if it must be signalled by the parent driver=0D
somehow, is still under discussion.  In case it is valid, this code allows=
=0D
testing the vDPA device for it.=0D
=0D
Eugenio P=C3=A9rez (6):=0D
  vdpa: export vhost_vdpa_set_vring_ready=0D
  vdpa: add should_enable op=0D
  vdpa: use virtio_ops->should_enable at vhost_vdpa_set_vrings_ready=0D
  vdpa: add stub vhost_vdpa_should_enable=0D
  vdpa: delay enable of data vqs=0D
  vdpa: remove net cvq migration blocker=0D
=0D
 include/hw/virtio/vhost-vdpa.h |  9 +++++++=0D
 hw/virtio/vhost-vdpa.c         | 33 +++++++++++++++++++------=0D
 net/vhost-vdpa.c               | 45 +++++++++++++++++++++++++---------=0D
 hw/virtio/trace-events         |  2 +-=0D
 4 files changed, 68 insertions(+), 21 deletions(-)=0D
=0D
-- =0D
2.39.3=0D
=0D


