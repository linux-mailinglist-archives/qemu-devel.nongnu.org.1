Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D674E1B6
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuX-0003zj-00; Mon, 10 Jul 2023 19:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuU-0003un-Mw
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuT-0004C8-3Q
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lAfUlLDrPcMNUXKJIJA1rQ6sYWvHzs/EbqL1gvZxI9U=;
 b=ToNod03mOSQ4J9hnoj+hJTK+jrrf5dFVvXiIYQXQEx87Z0hl2TZNvIBS3sRAbLaM/YxR7+
 NLLRlyU1kG2mEK02hMdI97A4dMgQ/cJw3LuoH+arjsF4BDbgnSJeb/x1inah/wP7C7sDwv
 SHkGGB0IMF5w4dp7qezLQprwqBXRW8s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-_B2wq78UMHWFOpOncB1_JA-1; Mon, 10 Jul 2023 19:03:11 -0400
X-MC-Unique: _B2wq78UMHWFOpOncB1_JA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fa976b8b6fso31040095e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030189; x=1691622189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAfUlLDrPcMNUXKJIJA1rQ6sYWvHzs/EbqL1gvZxI9U=;
 b=j2GwdSfOo7z6ZNme9zXI1VC31gunb6LGPDa4rXbJ+TVtg6jlNbrAIgtwzrQIj0N8Be
 yfHorKWTHWRvoGfU42jfRToUpcwAalbIH3eFTZCsrF27ZZ/7ENYdhI1egW1IzUPCBpj+
 1m441i+eArlUblVZs53bhctVq8QA8ynYaSSyR6VSRp6vNJE4tWia7TlWU03gwXjDI/BT
 UMs+y1SqGZM47pBlaIwzmwkmyn9Nute5hEIVr2+GzH9LqeGPhSAeLK1UHllavzmAZmjG
 LxOl6ASmJ2ZiPQQQ7jXD6AWi/S/vxDML8cdNqakqTFPX4qL0C+3f5eh9Wl12hZA9SybH
 fyVw==
X-Gm-Message-State: ABy/qLZqsvKRCd9dessMPxs4TNxj6AR0+30XYBLGFR8XUtir8Brz96AR
 BUadqtWSDhgbOgfD8/x46iD6Lzz4HhQZCBEz/Eeh2HUscJGmRvlamKmVx2A+sschdUa6RV+TPgv
 S9/adfsgmoV4jWuGcPua7r8RabHr1Bf6uNOkjvumLvcapYtZqhYNaHIdvsMFJWZ9RNMVX
X-Received: by 2002:a7b:c5d6:0:b0:3f7:3991:e12e with SMTP id
 n22-20020a7bc5d6000000b003f73991e12emr13508761wmk.1.1689030189728; 
 Mon, 10 Jul 2023 16:03:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE4IMtpgeHShLyDcFZgkhT+O7sDPlCFe4jqo27T7Vi2eu3JLymUZLOsJlXcjia+zvli/PHhZw==
X-Received: by 2002:a7b:c5d6:0:b0:3f7:3991:e12e with SMTP id
 n22-20020a7bc5d6000000b003f73991e12emr13508744wmk.1.1689030189481; 
 Mon, 10 Jul 2023 16:03:09 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b003f9b3829269sm21826965wmo.2.2023.07.10.16.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:09 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Tom Lonergan <tom.lonergan@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PULL 15/66] vhost-user: Change one_time to per_device request
Message-ID: <0dcb4172f2cecdfae113239ff931718eefdeb2d2.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Tom Lonergan <tom.lonergan@nutanix.com>

Some devices, like virtio-scsi, consist of one vhost_dev, while others, like
virtio-net, contain multiple vhost_devs. The QEMU vhost-user code has a
concept of one-time messages which is misleading. One-time messages are sent
once per operation on the device, not once for the lifetime of the device.
Therefore, as discussed in [1], vhost_user_one_time_request should be
renamed to vhost_user_per_device_request and the relevant comments updated
to match the real functionality.

[1] https://lore.kernel.org/qemu-devel/20230127083027-mutt-send-email-mst@kernel.org/

Signed-off-by: Tom Lonergan <tom.lonergan@nutanix.com>
Message-Id: <20230628163927.108171-2-tom.lonergan@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/virtio/vhost-user.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c4e0cbd702..65d6299343 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -367,7 +367,7 @@ static int process_message_reply(struct vhost_dev *dev,
     return msg_reply.payload.u64 ? -EIO : 0;
 }
 
-static bool vhost_user_one_time_request(VhostUserRequest request)
+static bool vhost_user_per_device_request(VhostUserRequest request)
 {
     switch (request) {
     case VHOST_USER_SET_OWNER:
@@ -392,11 +392,17 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
     int ret, size = VHOST_USER_HDR_SIZE + msg->hdr.size;
 
     /*
-     * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
-     * we just need send it once in the first time. For later such
-     * request, we just ignore it.
+     * Some devices, like virtio-scsi, are implemented as a single vhost_dev,
+     * while others, like virtio-net, contain multiple vhost_devs. For
+     * operations such as configuring device memory mappings or issuing device
+     * resets, which affect the whole device instead of individual VQs,
+     * vhost-user messages should only be sent once.
+     * 
+     * Devices with multiple vhost_devs are given an associated dev->vq_index
+     * so per_device requests are only sent if vq_index is 0.
      */
-    if (vhost_user_one_time_request(msg->hdr.request) && dev->vq_index != 0) {
+    if (vhost_user_per_device_request(msg->hdr.request)
+        && dev->vq_index != 0) {
         msg->hdr.flags &= ~VHOST_USER_NEED_REPLY_MASK;
         return 0;
     }
@@ -1256,7 +1262,7 @@ static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
         .hdr.flags = VHOST_USER_VERSION,
     };
 
-    if (vhost_user_one_time_request(request) && dev->vq_index != 0) {
+    if (vhost_user_per_device_request(request) && dev->vq_index != 0) {
         return 0;
     }
 
-- 
MST


