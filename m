Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B975973D8A0
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDgkJ-0003Ft-1U; Mon, 26 Jun 2023 03:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qDgkF-0003FE-Fu
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qDgkD-0007AY-0e
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687764878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tD4BlpJCMG1U3zdAa3RbxKDX7iStHZj0SKo+P+p5AMQ=;
 b=BjU+BCDdbPofMawPkIdQt2WM0fseDLN4UGLnKUUgZiyl6eYj7qeqnG8fzds7wZ+D8IwI1M
 9vAiGbOzEvRjXjJUNdUchfjTvu6BLnEmP2ivgP5+ZkDISnG5GUW7C51x9nf44o6SG2VB7V
 YPu9kFKRJHXfJ8/8Dqw/VTjk6VFfNiE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-CVg46_jBN2KFpsPjODZoXA-1; Mon, 26 Jun 2023 03:34:34 -0400
X-MC-Unique: CVg46_jBN2KFpsPjODZoXA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40F7B3C0ED46;
 Mon, 26 Jun 2023 07:34:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B59B1492B03;
 Mon, 26 Jun 2023 07:34:32 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 cohuck@redhat.com, Albert Esteve <aesteve@redhat.com>,
 Fam Zheng <fam@euphon.net>, kraxel@redhat.com
Subject: [PATCH v4 0/4] Virtio shared dma-buf
Date: Mon, 26 Jun 2023 09:34:22 +0200
Message-Id: <20230626073426.285659-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

v1 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00598.html
v2 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04530.html
v3 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06126.html
v3 -> v4:
    - Split the different message types for shared objects into different messages
    - Add a vhost-user feature bit to negotiate the shared object feature
    - Minor improvements following suggestions

This patch covers the required steps to add support for virtio cross-device resource sharing[1],
which support is already available in the kernel.

The main usecase will be sharing dma buffers from virtio-gpu devices (as the exporter
-see VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID in [2]), to virtio-video (under discussion)
devices (as the buffer-user or importer). Therefore, even though virtio specs talk about
resources or objects[3], this patch adds the infrastructure with dma-bufs in mind.
Note that virtio specs let the devices themselves define what a vitio object is.

These are the main parts that are covered in the patch:

- Add hash function to uuid module
- Shared resources table, to hold all resources that can be shared in the host and their assigned UUID
- Internal shared table API for virtio devices to add, lookup and remove resources
- Unit test to verify the API
- New messages to the vhost-user protocol to allow backend to interact with the shared
  table API through the control socket
- New vhost-user feature bit to enable shared objects feature

Applies cleanly to b455ce4c2f300c8ba47cba7232dd03261368a4cb

[1] - https://lwn.net/Articles/828988/
[2] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-3730006
[3] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-10500011

Albert Esteve (4):
  uuid: add a hash function
  virtio-dmabuf: introduce virtio-dmabuf
  vhost-user: add shared_object msg
  vhost-user: refactor send_resp code

 MAINTAINERS                               |   7 ++
 docs/interop/vhost-user.rst               |  42 ++++++++
 hw/display/meson.build                    |   1 +
 hw/display/virtio-dmabuf.c                |  90 +++++++++++++++++
 hw/virtio/vhost-user.c                    | 115 +++++++++++++++++++---
 include/hw/virtio/virtio-dmabuf.h         |  59 +++++++++++
 include/qemu/uuid.h                       |   2 +
 subprojects/libvhost-user/libvhost-user.c | 101 +++++++++++++++++++
 subprojects/libvhost-user/libvhost-user.h |  53 +++++++++-
 tests/unit/meson.build                    |   1 +
 tests/unit/test-uuid.c                    |  27 +++++
 tests/unit/test-virtio-dmabuf.c           | 112 +++++++++++++++++++++
 util/uuid.c                               |  14 +++
 13 files changed, 610 insertions(+), 14 deletions(-)
 create mode 100644 hw/display/virtio-dmabuf.c
 create mode 100644 include/hw/virtio/virtio-dmabuf.h
 create mode 100644 tests/unit/test-virtio-dmabuf.c

-- 
2.40.0


