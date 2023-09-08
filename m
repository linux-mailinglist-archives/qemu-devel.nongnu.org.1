Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4931D798A35
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 17:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qediF-0007Ku-4T; Fri, 08 Sep 2023 11:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qediC-0007KE-9m
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qedi9-0005m6-Jy
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694188075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3mb/1ETQevXuHtJtG4xSdJ04Rm3Q8GrMTHy676kq98I=;
 b=DVJBbwFgm7nhbLQCLD588iNQJI+XjzAFi5K8UTzBs7R0trNwLYs0JVHQx7orEqp5TIEnLP
 KabsFfpZuvgayjJTd3DxWhk+bSPzjX7X3iKfmN8zNDn5h+M+qe26cdu1McfP04UjUPpnd7
 exHKUJaQRF+Mz6EBzotAu1NeYli0Z28=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-tZguA_9fMZu9O8NR0Cu4OQ-1; Fri, 08 Sep 2023 11:47:52 -0400
X-MC-Unique: tZguA_9fMZu9O8NR0Cu4OQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDD0C94EA42;
 Fri,  8 Sep 2023 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5544321EE566;
 Fri,  8 Sep 2023 15:47:50 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, marcandre.lureau@gmail.com,
 Albert Esteve <aesteve@redhat.com>, philmd@linaro.org, cohuck@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com
Subject: [PATCH v8 0/4] Virtio shared dma-buf
Date: Fri,  8 Sep 2023 17:47:39 +0200
Message-ID: <20230908154743.809569-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
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
v6 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg00987.html
v7 link -> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01190.html
v7 -> v8:
- Move "qemu/osdep.h" include to the virtio-dmabuf source file.
- Remove duplicated glib include.
- Change the title of commits to better reflect the path to the change

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

Applies cleanly to 03a3a62fbd0aa5227e978eef3c67d3978aec9e5f

[1] - https://lwn.net/Articles/828988/
[2] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-3730006
[3] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-10500011

Albert Esteve (4):
  util/uuid: add a hash function
  hw/display: introduce virtio-dmabuf
  vhost-user: add shared_object msg
  libvhost-user: handle shared_object msg

 MAINTAINERS                               |   7 +
 docs/interop/vhost-user.rst               |  57 ++++++++
 hw/display/meson.build                    |   1 +
 hw/display/virtio-dmabuf.c                | 138 ++++++++++++++++++
 hw/virtio/vhost-user.c                    | 168 ++++++++++++++++++++--
 include/hw/virtio/vhost-backend.h         |   3 +
 include/hw/virtio/virtio-dmabuf.h         | 100 +++++++++++++
 include/qemu/uuid.h                       |   2 +
 subprojects/libvhost-user/libvhost-user.c | 120 ++++++++++++++++
 subprojects/libvhost-user/libvhost-user.h |  55 ++++++-
 tests/unit/meson.build                    |   1 +
 tests/unit/test-uuid.c                    |  27 ++++
 tests/unit/test-virtio-dmabuf.c           | 137 ++++++++++++++++++
 util/uuid.c                               |  15 ++
 14 files changed, 818 insertions(+), 13 deletions(-)
 create mode 100644 hw/display/virtio-dmabuf.c
 create mode 100644 include/hw/virtio/virtio-dmabuf.h
 create mode 100644 tests/unit/test-virtio-dmabuf.c

-- 
2.41.0


