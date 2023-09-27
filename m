Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 675A87B0C7D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 21:28:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlaCR-0006Rv-DM; Wed, 27 Sep 2023 15:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlaCH-0006Rb-Nf
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlaCG-0004rA-3Y
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695842862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kUeZzeBsW7SMnR28n/0Vj+pkho33y3aoDfzprPE0NVQ=;
 b=KcPOl3JTmm9TvOq0FwY8o8gE6OJxNNKFjxUppywpBAQhTUYdcKgjU2aK67fCMsQhE8ywU4
 1Yj57nYQdtLkguki8mAKGpoZ4XZ7fvz1dAMlsj1TFUzfqrG5yQeNrTdasv0uDUvm/TLxp0
 sp2m3+Q13RPceOGn4KQTvKqzcvP2HlU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-pyugzX3INbuqFL_WLbCGNQ-1; Wed, 27 Sep 2023 15:27:39 -0400
X-MC-Unique: pyugzX3INbuqFL_WLbCGNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B3FD8007A4;
 Wed, 27 Sep 2023 19:27:39 +0000 (UTC)
Received: from localhost (unknown [10.39.193.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B97452026D68;
 Wed, 27 Sep 2023 19:27:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 eperezma@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/3] vhost: clean up device reset
Date: Wed, 27 Sep 2023 15:27:34 -0400
Message-ID: <20230927192737.528280-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

Stateful vhost devices may need to free resources or clear device state upon
device reset. The vhost-user protocol has a VHOST_USER_RESET_DEVICE message for
this and vDPA has SET_STATUS 0, but only QEMU's vhost-user-scsi device actually
implements this today.

This patch series performs device reset across all device types. When
virtio_reset() is called, the associated vhost_dev's ->vhost_reset_device() is
called. vhost-user-scsi's one-off implementation is obsoleted and removed.

This patch affects behavior as follows:
- vhost-kernel: no change in behavior. No ioctl calls are made.
- vhost-user: back-ends that negotiate
  VHOST_USER_PROTOCOL_F_RESET_DEVICE now receive a
  VHOST_USER_DEVICE_RESET message upon device reset. Otherwise there is
  no change in behavior. DPDK, SPDK, libvhost-user, and the
  vhost-user-backend crate do not negotiate
  VHOST_USER_PROTOCOL_F_RESET_DEVICE automatically.
- vhost-vdpa: an extra SET_STATUS 0 call is made during device reset.

I have tested this series with vhost-net (kernel), vhost-user-blk, and
vhost-user-fs (both Rust and legacy C).

Stefan Hajnoczi (3):
  vhost-user: do not send RESET_OWNER on device reset
  vhost-backend: remove vhost_kernel_reset_device()
  virtio: call ->vhost_reset_device() during reset

 include/hw/virtio/vhost.h |  3 +++
 hw/scsi/vhost-user-scsi.c | 20 --------------------
 hw/virtio/vhost-backend.c |  6 ------
 hw/virtio/vhost-user.c    | 13 +++++++++----
 hw/virtio/vhost.c         |  9 +++++++++
 hw/virtio/virtio.c        |  4 ++++
 6 files changed, 25 insertions(+), 30 deletions(-)

-- 
2.41.0


