Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B461E7CE268
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:12:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wX-0000v3-Tm; Wed, 18 Oct 2023 11:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tx-00039f-Mi
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tw-0006uq-1j
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3kB7c3/8mnVXhh3/qxXLsdRopBKANEVLkGnuRjvnEA=;
 b=L6xcZIHcYJZmX1HPgBcZBAgS2qaawU4/zPN8tn/kLA+Cn8yw0ue7SuqOgHkvQizcSlwSe3
 E0AivUEhJ9BIAANFOOKp5eIFOHFU4B03EGJRgsA4MNy5MPA78nOq5SLdFshTgGUk8bpiH2
 DG0X8cTxWOv6YuJL1ljZG6VNqqQ9rx4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-gBvJ7Z4zOFeBgWkBvM1Pfw-1; Wed, 18 Oct 2023 11:55:57 -0400
X-MC-Unique: gBvJ7Z4zOFeBgWkBvM1Pfw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so44443225e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644555; x=1698249355;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k3kB7c3/8mnVXhh3/qxXLsdRopBKANEVLkGnuRjvnEA=;
 b=LGvXdFZBaWJBKGUSqgaAE7w8mN9GpkCH+5qGRvPwDgTOX2Qw54SFa9FJw59XRRnfUM
 7vnUlW1zdPlalSG0pVrk9rRf0+GRVY6IG8MViEjN0YHKZMKbikUFekfLw157Js5nZgsI
 RsmyWf9huSBSOa8ZYYryDAaSOr4Vz0zq48PUHs/GbHYbJA+mjB69VfOZt8nagfAmHmto
 lnn8+5qG29t+bs/E92wKkABLBreGzbxvKkvoUhiRPSu9aX4Cf0gMUF7dqGxMkh5vsWch
 ptSh9hl7S1v2uD/o8GCaGq7DAgVVmP+7Pxh0NO9GqyvqOJB5gozv7PO12AGpyiJExUhv
 Q8/Q==
X-Gm-Message-State: AOJu0YztnfqaVtJdZyIRBMMgswAKs0s85uqc4kWFysX3uOEwHQudGtgp
 6NGDHUYnlmUnT+c4tr4wiHncVtVF+pc1KrWk0uAIfUOzFMmOuyKLrL8QCs2O7KZzVZRKRMc1NeO
 wT+NCZva5xqulbRL+zn5qcGyzN50RoYTBZtEwkUDvnOVn0kdVk4aTSW2qRmtcLdqpAdx3jTc=
X-Received: by 2002:a05:600c:3508:b0:407:4944:76d1 with SMTP id
 h8-20020a05600c350800b00407494476d1mr4445915wmq.17.1697644555360; 
 Wed, 18 Oct 2023 08:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwnTncaIrp1JRaO6+QfeejklWcuBG0WNfuMZOmITgvjh/UDYHeW4JjRhz2LfHhZmQLz0BjZw==
X-Received: by 2002:a05:600c:3508:b0:407:4944:76d1 with SMTP id
 h8-20020a05600c350800b00407494476d1mr4445897wmq.17.1697644555029; 
 Wed, 18 Oct 2023 08:55:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c358c00b00401b242e2e6sm2003884wmq.47.2023.10.18.08.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:55:54 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:55:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL 34/83] vhost-user: allow "vhost_set_vring" to wait for a reply
Message-ID: <3c501fe5baf0a50cda8f6da2d80c5f5c7c5c6eaf.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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

From: Laszlo Ersek <lersek@redhat.com>

The "vhost_set_vring" function already centralizes the common parts of
"vhost_user_set_vring_num", "vhost_user_set_vring_base" and
"vhost_user_set_vring_enable". We'll want to allow some of those callers
to wait for a reply.

Therefore, rebase "vhost_set_vring" from just "vhost_user_write" to
"vhost_user_write_sync", exposing the "wait_for_reply" parameter.

This is purely refactoring -- there is no observable change. That's
because:

- all three callers pass in "false" for "wait_for_reply", which disables
  all logic in "vhost_user_write_sync" except the call to
  "vhost_user_write";

- the fds=NULL and fd_num=0 arguments of the original "vhost_user_write"
  call inside "vhost_set_vring" are hard-coded within
  "vhost_user_write_sync".

Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
Cc: Eugenio Perez Martin <eperezma@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Liu Jiang <gerry@linux.alibaba.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20231002203221.17241-7-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 3c14947589..7e452849fa 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1160,7 +1160,8 @@ static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
 
 static int vhost_set_vring(struct vhost_dev *dev,
                            unsigned long int request,
-                           struct vhost_vring_state *ring)
+                           struct vhost_vring_state *ring,
+                           bool wait_for_reply)
 {
     VhostUserMsg msg = {
         .hdr.request = request,
@@ -1169,13 +1170,13 @@ static int vhost_set_vring(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.state),
     };
 
-    return vhost_user_write(dev, &msg, NULL, 0);
+    return vhost_user_write_sync(dev, &msg, wait_for_reply);
 }
 
 static int vhost_user_set_vring_num(struct vhost_dev *dev,
                                     struct vhost_vring_state *ring)
 {
-    return vhost_set_vring(dev, VHOST_USER_SET_VRING_NUM, ring);
+    return vhost_set_vring(dev, VHOST_USER_SET_VRING_NUM, ring, false);
 }
 
 static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
@@ -1206,7 +1207,7 @@ static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
 static int vhost_user_set_vring_base(struct vhost_dev *dev,
                                      struct vhost_vring_state *ring)
 {
-    return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring);
+    return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring, false);
 }
 
 static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
@@ -1224,7 +1225,7 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
             .num   = enable,
         };
 
-        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state);
+        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, false);
         if (ret < 0) {
             /*
              * Restoring the previous state is likely infeasible, as well as
-- 
MST


