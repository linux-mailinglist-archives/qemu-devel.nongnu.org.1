Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F7A7B7664
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 03:47:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnqxW-0000ud-NN; Tue, 03 Oct 2023 21:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnqxK-0000tv-Ea
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 21:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnqxI-0003RD-Qm
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 21:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696383938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A3wWVFUtRkwp8e4Vugo3pTBTI8IbjkvEy7wc+9sRSLU=;
 b=TIQhqdW/DA5fd5hNimCstgmZu/2p8S1LstX/PweDiLc4iKLKlEralgk717g2j0FMlbEtNq
 skItsj+3EITuXpHOaQApQRc9yfNd2xH5SKHt/E6Wcfw2K40MV19v4VkyHtL/5SSWD+1qra
 eHZ73yUsvJw2+qzMj13wwlnJTSsMuaY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-mO10QrLbOq2bidsN5BNSEA-1; Tue, 03 Oct 2023 21:45:35 -0400
X-MC-Unique: mO10QrLbOq2bidsN5BNSEA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2E01185A79B;
 Wed,  4 Oct 2023 01:45:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CE5E493113;
 Wed,  4 Oct 2023 01:45:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hreitz@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eperezma@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/3] vhost: clean up device reset
Date: Tue,  3 Oct 2023 21:45:29 -0400
Message-ID: <20231004014532.1228637-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

v2:
- Fix compilation error when vhost is not built [Michael]

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

 meson.build               |  1 +
 include/hw/virtio/vhost.h | 10 ++++++++++
 hw/scsi/vhost-user-scsi.c | 20 --------------------
 hw/virtio/vhost-backend.c |  6 ------
 hw/virtio/vhost-user.c    | 13 +++++++++----
 hw/virtio/vhost.c         |  9 +++++++++
 hw/virtio/virtio.c        |  4 ++++
 7 files changed, 33 insertions(+), 30 deletions(-)

-- 
2.41.0


