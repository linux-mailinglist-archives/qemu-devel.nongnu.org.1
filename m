Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CDB73E5C2
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDpNd-0001Qt-QV; Mon, 26 Jun 2023 12:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qDpNI-0001Ba-6W
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:47:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qDpNF-0002Aa-UG
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687798053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GI/qdvUcG0+hk7noC5Z46oHKpjYFrioG//NljqI8+U=;
 b=P177hEU2+FYkXcH69BovmxzbCLcm0193XpHdpYm7JgPWyl7YHmmWhIOfBEQqfPH36rP9Nv
 cMJOjadEYfbU/07SBd6h476gUnrRD7MpbZcuY8AoNIq51WO3EOu5pxyfFhZxJdQ0wpW2wh
 EvOySUt1w+B1B4HbLFuyZul2qG5kTiE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-t3XJdjE5Mg-KiM6uwzpeqw-1; Mon, 26 Jun 2023 12:47:31 -0400
X-MC-Unique: t3XJdjE5Mg-KiM6uwzpeqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEF91280AA2A
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 16:47:28 +0000 (UTC)
Received: from centennial.enunes.eu.com (unknown [10.67.24.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D2481121319;
 Mon, 26 Jun 2023 16:47:24 +0000 (UTC)
From: Erico Nunes <ernunes@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, kraxel@redhat.com,
 Erico Nunes <ernunes@redhat.com>
Subject: [PATCH v4 2/4] docs: vhost-user-gpu: add protocol changes for EDID
Date: Mon, 26 Jun 2023 18:47:06 +0200
Message-Id: <20230626164708.1163239-3-ernunes@redhat.com>
In-Reply-To: <20230626164708.1163239-1-ernunes@redhat.com>
References: <20230626164708.1163239-1-ernunes@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ernunes@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

VHOST_USER_GPU_GET_EDID is defined as a message from the backend to the
frontend to retrieve the EDID data for a given scanout.

The VHOST_USER_GPU_PROTOCOL_F_EDID protocol feature is defined as a way
to check whether this new message is supported or not.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/interop/vhost-user-gpu.rst | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/docs/interop/vhost-user-gpu.rst b/docs/interop/vhost-user-gpu.rst
index 1640553729..b78806892d 100644
--- a/docs/interop/vhost-user-gpu.rst
+++ b/docs/interop/vhost-user-gpu.rst
@@ -124,6 +124,16 @@ VhostUserGpuDMABUFScanout
 :fourcc: ``i32``, the DMABUF fourcc
 
 
+VhostUserGpuEdidRequest
+^^^^^^^^^^^^^^^^^^^^^^^
+
++------------+
+| scanout-id |
++------------+
+
+:scanout-id: ``u32``, the scanout to get edid from
+
+
 C structure
 -----------
 
@@ -141,6 +151,8 @@ In QEMU the vhost-user-gpu message is implemented with the following struct:
           VhostUserGpuScanout scanout;
           VhostUserGpuUpdate update;
           VhostUserGpuDMABUFScanout dmabuf_scanout;
+          VhostUserGpuEdidRequest edid_req;
+          struct virtio_gpu_resp_edid resp_edid;
           struct virtio_gpu_resp_display_info display_info;
           uint64_t u64;
       } payload;
@@ -149,10 +161,11 @@ In QEMU the vhost-user-gpu message is implemented with the following struct:
 Protocol features
 -----------------
 
-None yet.
+.. code:: c
+
+  #define VHOST_USER_GPU_PROTOCOL_F_EDID 0
 
-As the protocol may need to evolve, new messages and communication
-changes are negotiated thanks to preliminary
+New messages and communication changes are negotiated thanks to the
 ``VHOST_USER_GPU_GET_PROTOCOL_FEATURES`` and
 ``VHOST_USER_GPU_SET_PROTOCOL_FEATURES`` requests.
 
@@ -241,3 +254,12 @@ Message types
   Note: there is no data payload, since the scanout is shared thanks
   to DMABUF, that must have been set previously with
   ``VHOST_USER_GPU_DMABUF_SCANOUT``.
+
+``VHOST_USER_GPU_GET_EDID``
+  :id: 11
+  :request payload: ``struct VhostUserGpuEdidRequest``
+  :reply payload: ``struct virtio_gpu_resp_edid`` (from virtio specification)
+
+  Retrieve the EDID data for a given scanout.
+  This message requires the ``VHOST_USER_GPU_PROTOCOL_F_EDID`` protocol
+  feature to be supported.
-- 
2.40.1


