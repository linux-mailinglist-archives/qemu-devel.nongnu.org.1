Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F627080AB
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:04:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzcLj-0000wE-Au; Thu, 18 May 2023 08:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1pzcLd-0000w1-Gd
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1pzcLZ-0007DH-EQ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684411383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+MMw+Pjxrd6BRKUgTGKewguqLtgEQdjpNgMsZcOI6vM=;
 b=YLffSqDb/TgEFi62LLwKAsj5IH/Jcary5wmoDfzDL5oHxYZDDyQCFQIpDNPhmW6AigiL80
 ZJCWJIFnhwL9099eAfCzt81a6UOUUImVWREsuQIEMr4VMiDCsqga8zFYlKrl4dUucGoxrI
 YrdxbQ4F/VBWBx177BBhwa7xvSuRSFI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-n7CMkXYpPhqK4spSQWjmCw-1; Thu, 18 May 2023 08:03:02 -0400
X-MC-Unique: n7CMkXYpPhqK4spSQWjmCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2EB0800047;
 Thu, 18 May 2023 12:03:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AE021121314;
 Thu, 18 May 2023 12:02:59 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, Fam Zheng <fam@euphon.net>,
 Albert Esteve <aesteve@redhat.com>, cohuck@redhat.com
Subject: [PATCH v2 0/4] Virtio shared dma-buf
Date: Thu, 18 May 2023 14:02:54 +0200
Message-Id: <20230518120258.1394135-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
v1 -> v2:
    - Add new files to MAINTAINERS
    - Add hash_func and key_equal_func to uuid
    - Expose functions to send vhost-user shared_object messages back instead of exposing write_msg method

This patch covers the required steps to add support for virtio cross-device resource sharing[1],
which support is already available in the kernel.

The main usecase will be sharing dma buffers from virtio-gpu devices (as the exporter
-see VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID in [2]), to virtio-video (under discussion)
devices (as the buffer-user or importer). Therefore, even though virtio specs talk about
resources or objects[3], this patch adds the infrastructure with dma-bufs in mind.
Note that virtio specs let the devices themselves define what a vitio object is.

These are the main parts that are covered in the patch:

- Add hash_func and key_equal_func to uuid
- Shared resources table, to hold all resources that can be shared in the host and their assigned UUID
- Internal shared table API for virtio devices to add, lookup and remove resources
- Unit test to verify the API.
- New message to the vhost-user protocol to allow backend to interact with the shared
  table API through the control socket

Applies cleanly to 4ebc33f

[1] - https://lwn.net/Articles/828988/
[2] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-3730006
[3] - https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-10500011

Albert Esteve (4):
  uuid: add hash_func and equal_func
  virtio-dmabuf: introduce virtio-dmabuf
  vhost-user: add shared_object msg
  vhost-user: refactor send_resp code

 MAINTAINERS                               |   7 ++
 docs/interop/vhost-user.rst               |  15 +++
 hw/display/meson.build                    |   1 +
 hw/display/virtio-dmabuf.c                |  82 ++++++++++++++++
 hw/virtio/vhost-user.c                    |  90 ++++++++++++++---
 include/hw/virtio/virtio-dmabuf.h         |  59 ++++++++++++
 include/qemu/uuid.h                       |   4 +
 subprojects/libvhost-user/libvhost-user.c |  88 +++++++++++++++++
 subprojects/libvhost-user/libvhost-user.h |  56 +++++++++++
 tests/unit/meson.build                    |   1 +
 tests/unit/test-uuid.c                    |  46 +++++++++
 tests/unit/test-virtio-dmabuf.c           | 112 ++++++++++++++++++++++
 util/uuid.c                               |  38 ++++++++
 13 files changed, 586 insertions(+), 13 deletions(-)
 create mode 100644 hw/display/virtio-dmabuf.c
 create mode 100644 include/hw/virtio/virtio-dmabuf.h
 create mode 100644 tests/unit/test-virtio-dmabuf.c

-- 
2.40.0


