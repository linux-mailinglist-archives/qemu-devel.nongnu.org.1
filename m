Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF17D221B
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:23:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUfi-0001XQ-IK; Sun, 22 Oct 2023 05:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfg-0001RW-SO
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUff-0000G8-4E
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3kB7c3/8mnVXhh3/qxXLsdRopBKANEVLkGnuRjvnEA=;
 b=YaE52foPkASwHnuAQaR6Q6yY3zbHZ++vYTJeS/OBs12Ac75JFTlICcZpgkv9QPwhj2i/Qt
 rFFCHT0QXloQbrtcln7E8TUfxjINNLamU0NajY+2Stl7W5KD5+65Q+sd3/JhRdC60/fGtx
 7iKElz+Po5fadPSNL9U4odb/5uhdIrY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-7BPJAOM2OSmbPvUvSR_geQ-1; Sun, 22 Oct 2023 05:22:47 -0400
X-MC-Unique: 7BPJAOM2OSmbPvUvSR_geQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32dc767e619so1015172f8f.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966565; x=1698571365;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k3kB7c3/8mnVXhh3/qxXLsdRopBKANEVLkGnuRjvnEA=;
 b=ErzbTvmuto4jgTAPowk2n/rkKSuxrgYMIcqLUhrl9dOhrGeVj4cAezxb8Nh8uvLc6q
 K4QgG/+nfD8vm/LXe7akp8nAs6M+RJlfE0QoWx0K5X85mc2ur80JkvQICWhB2KjarjMx
 gKcjqYfp/6VgMphrk78VqQMLai33JCNt3H9bYsWXjnzUwP3IGqd7KmJNax+/14yqHMqP
 nyGmpp87Vct+mXpx/rfZOTuuQy2uozAJ9Q7F93ZIayqk8SIJb/DqbhqhmdnXsa+OeAqj
 51I9uMU4yFXB6b5IdMbQLt9pJw5Ba07W/ABtgxiHvCk+68GVk+Fg62Mqq3FspF+w90Fp
 BBNQ==
X-Gm-Message-State: AOJu0YwycAJ26zzKrzVewy47RaTsL2VkuSgCdT9FyqwuFkBqFX/RqUDP
 4bqpcoDHXbNzMSGkTUn2xKKUqyFT6PeFyzDTPvytszdYbKKPfnUnormTkea3CCpWiVEwVpB9gl3
 JgbWUj6oJV9QHStme09k+oo20t5W1FLX5bJ1eM9C+XAk0+R7Ec417+VgAuSaKBZE+aAQL
X-Received: by 2002:a5d:4a04:0:b0:32d:95ef:9281 with SMTP id
 m4-20020a5d4a04000000b0032d95ef9281mr4375900wrq.4.1697966565542; 
 Sun, 22 Oct 2023 02:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMjR+nV2zzwT81EXDYKPY3khxu3eSg9CxihOTaFr5VzZeL2qJvQLKtnoFknz5PzyRo2cOw/g==
X-Received: by 2002:a5d:4a04:0:b0:32d:95ef:9281 with SMTP id
 m4-20020a5d4a04000000b0032d95ef9281mr4375878wrq.4.1697966565158; 
 Sun, 22 Oct 2023 02:22:45 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 o3-20020a5d6843000000b003143c9beeaesm5286898wrw.44.2023.10.22.02.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:44 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL v3 13/62] vhost-user: allow "vhost_set_vring" to wait for a
 reply
Message-ID: <75b6b6da21a225b7853515d9e14775f8a5d9af3a.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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


