Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1960474E1D8
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:07:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzu5-0002rA-UI; Mon, 10 Jul 2023 19:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzu3-0002qd-P4
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzu2-00047w-A1
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiHSJhGfrExMCfEGSl3IWf42A4x66124Sakgqtwn2N8=;
 b=GoIY1Gdy28qCltqzLAdYJvWxLT5y/PHaRgVej8pevnGVtrYkBhaP70Cn3Ea10UM5N1P3gb
 my/OM6hZO30GZBBjR5d7NpPC4w+dMwNRTZbUImFlnqS2CgY+L4h70hk7S6EcMve4RVCg7f
 fdq3JrVeMC4ezURISep0lfpeNhHnytM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-W0bHCzI7M4W_8ClL_5TS_Q-1; Mon, 10 Jul 2023 19:02:44 -0400
X-MC-Unique: W0bHCzI7M4W_8ClL_5TS_Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fa8cd898e0so34200385e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030162; x=1691622162;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jiHSJhGfrExMCfEGSl3IWf42A4x66124Sakgqtwn2N8=;
 b=GorEQtIXSMK4pFYkCN0y3ko7ehKnENI2bEYHB75alqhmHAONQRoH0MDrO6QWIGIQ2n
 k3s/z5z7HdBRlhOy9YRpr6Hu8GC8J0U8rHC2AHBXI6bV939wIDLAd7gP8sus9A3y+6C3
 8ynRYdFtw8m2naoTPz/7oFCLtawDKmoL7ShwZ25vQk3ic4rPggoEfPs5pJ0lM/c+8mlo
 7erjvfx3Itkse3M9HPngvrE5FUbdeLYt/OR6hrDg7yQk48Bprv1pu0L+QvKzq0rMHyXR
 zRmsheJ6uvtRJVaw19TVW1s6hTb9rEbFwX/9HokOv1lbHwVRkW01w9MGO1MQj2Ib+2Lh
 IULA==
X-Gm-Message-State: ABy/qLbN220DEIIvm6hAv7su5AOGTRtjpaMP1px6hDIHKP93rJbQy1sy
 SY49Lho9bfL+Yu/4GuIMZZ7iEnbQAkIcedxuQM6YLBclafpfcGJUWBBFa9ZWsbgGgrYsvYaWv9D
 l5u6DZtfwjuNCK4xwSpdr7upRjKnmRgxV6Q/ba9o4TN6CYnUYQBjIVPxt76Z4R6I3jFwa
X-Received: by 2002:a1c:4b17:0:b0:3fb:b008:2003 with SMTP id
 y23-20020a1c4b17000000b003fbb0082003mr14360472wma.38.1689030162573; 
 Mon, 10 Jul 2023 16:02:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFlYaWrizfsxLZe+Zx/hxlf0IhPkrQdk2DeqS/Cp7SLjpv8dXnNsEi/KDKe5Tu6TMxmn0MSZw==
X-Received: by 2002:a1c:4b17:0:b0:3fb:b008:2003 with SMTP id
 y23-20020a1c4b17000000b003fbb0082003mr14360449wma.38.1689030162279; 
 Mon, 10 Jul 2023 16:02:42 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 l4-20020a1ced04000000b003fbe561f6a3sm11446797wmh.37.2023.07.10.16.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:41 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Erico Nunes <ernunes@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 05/66] docs: vhost-user-gpu: add protocol changes for EDID
Message-ID: <50cbd5b4b37de3f474495c5fd6a66d5c0e8e49c2.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Erico Nunes <ernunes@redhat.com>

VHOST_USER_GPU_GET_EDID is defined as a message from the backend to the
frontend to retrieve the EDID data for a given scanout.

The VHOST_USER_GPU_PROTOCOL_F_EDID protocol feature is defined as a way
to check whether this new message is supported or not.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230626164708.1163239-3-ernunes@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
 
-As the protocol may need to evolve, new messages and communication
-changes are negotiated thanks to preliminary
+  #define VHOST_USER_GPU_PROTOCOL_F_EDID 0
+
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
MST


