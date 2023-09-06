Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF85793AE4
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 13:17:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdqVx-0001JB-PA; Wed, 06 Sep 2023 07:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdqVv-0001Ic-FD
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 07:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdqVq-0005Mq-Vl
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 07:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693998955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GFjKDLTljm7fhWfEWZ6zxarvq8K8uRX2/BWVSbIzWys=;
 b=aj2Ayw63Sl9K1MeD1R99WnoPqdwlQ/l2fOU1PDFiQTM09fqKaqMY7Mkoq0DJ1DQBxfuign
 mT3qngnBAKtLXbMnHpScrY51KaGezzbXufJ3rlSUXDWcdAuoLd2S8jHN2o+ljymlycBjGE
 Fc34aXJ2b6NUNvv2ZcKe3l9hvgFsYnk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-TQMgI2r6PkGVCRksOcZNBA-1; Wed, 06 Sep 2023 07:15:52 -0400
X-MC-Unique: TQMgI2r6PkGVCRksOcZNBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 247B529AB3E2;
 Wed,  6 Sep 2023 11:15:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36D0E2012F37;
 Wed,  6 Sep 2023 11:15:50 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Albert Esteve <aesteve@redhat.com>, kraxel@redhat.com,
 marcandre.lureau@gmail.com
Subject: [PATCH v6 0/3] Virtio shared dma-buf
Date: Wed,  6 Sep 2023 13:15:46 +0200
Message-ID: <20230906111549.357178-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
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

v1 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00598.html
v2 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04530.html
v3 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06126.html
v4 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05174.html
v5 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00255.html
v5 -> v6:
- Unified shared table API mutex usage
- Typedef VirtioSharedObject struct
- Squashed refactor commit to fix compilation issue on patch#3

This patch covers the required steps to add support for virtio cross-device resource sharing[1],
which support is already available in the kernel.

The main usecase will be sharing dma buffers from virtio-gpu devices (as the exporter
-see VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID in [2]), to virtio-video (under discussion)
devices (as the buffer-user or importer). Therefore, even though virtio specs talk about
resources or objects[3], this patch adds the infrastructure with dma-bufs in mind.
Note that virtio specs let the devices themselves define what a vitio object is.

These are the main parts that are covered in the patch:

- Add hash function to uuid module
- Shared resources table, to hold all resources that can be shared in the host and their assigned UUID,
  or pointers to the backend holding the resource
- Internal shared table API for virtio devices to add, lookup and remove resources
- Unit test to verify the API
- New messages to the vhost-user protocol to allow backend to interact with the shared
  table API through the control socket
- New vhost-user feature bit to enable shared objects feature

Applies cleanly to 2d8fbcb1eecd8d39171f457e583428758321d69d

[1] - https://lwn.net/Articles/828988/
[2] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-3730006
[3] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-10500011

Albert Esteve (3):
  uuid: add a hash function
  virtio-dmabuf: introduce virtio-dmabuf
  vhost-user: add shared_object msg

 MAINTAINERS                               |   7 +
 docs/interop/vhost-user.rst               |  57 +++++++
 hw/display/meson.build                    |   1 +
 hw/display/virtio-dmabuf.c                | 134 +++++++++++++++++
 hw/virtio/vhost-user.c                    | 174 ++++++++++++++++++++--
 include/hw/virtio/vhost-backend.h         |   3 +
 include/hw/virtio/virtio-dmabuf.h         | 103 +++++++++++++
 include/qemu/uuid.h                       |   2 +
 subprojects/libvhost-user/libvhost-user.c | 118 +++++++++++++++
 subprojects/libvhost-user/libvhost-user.h |  55 ++++++-
 tests/unit/meson.build                    |   1 +
 tests/unit/test-uuid.c                    |  27 ++++
 tests/unit/test-virtio-dmabuf.c           | 137 +++++++++++++++++
 util/uuid.c                               |  15 ++
 14 files changed, 820 insertions(+), 14 deletions(-)
 create mode 100644 hw/display/virtio-dmabuf.c
 create mode 100644 include/hw/virtio/virtio-dmabuf.h
 create mode 100644 tests/unit/test-virtio-dmabuf.c

-- 
2.41.0


