Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D03C97B7AED
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxV1-0006IX-PH; Wed, 04 Oct 2023 04:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUz-00068n-QH
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUx-0001uY-NL
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAOgA2Zhmct24yG1OyPjPxdJTiOfpbrE6FglPV2ws+s=;
 b=BoRDSBAkLEor+wuhxTYHxktx+PeNq6J0E5HeCtmqVPUwwPr8rnp+Q0J7KcFglyRTiwUSqQ
 Beie0S4ViACoP7c/TcZ6aAdNU+6sm4OYDrBgan8MQm6PFLOq74zGFos1m3ypX550TJQBuZ
 fRcIO4Yw1dSCQFQd7Z9VhKgkuheXY34=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-22bP-191O_W-7WXmsrENMQ-1; Wed, 04 Oct 2023 04:44:44 -0400
X-MC-Unique: 22bP-191O_W-7WXmsrENMQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32339eee4c4so1422866f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409083; x=1697013883;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rAOgA2Zhmct24yG1OyPjPxdJTiOfpbrE6FglPV2ws+s=;
 b=sYpwrZAI8PpfYRgen4+QuwjQEnnotxmGtbLmExNhhsj6xqt+Ae7lIV5Wr/dijwEI3U
 fNW02BA8FfuQeKTMTajPCAmzljiPxiud5oVxsLZbpvhqADXv5OIq3yZMLQsbne9a+rX1
 iShwkkUoJKWAZkLkaO2g0XJrq/fTHe3yny/1Jl/dZ8mrBYcVeAp1T4vr/vJh/NTkBikr
 aRkXVtNCW9VV8pKQ2SziBBF3OhfXUwXeMr8JSXUa0pgcxwzP2DJJnsbXBLwQB3/MVYOE
 82qil9WTOX3lxnL6KM8Bkhrr1MtapRnGkRnSiIXXvJT3P0D/9VnXJxJPcGuI/elJHxJK
 0wug==
X-Gm-Message-State: AOJu0YzlR24yougGRrjgs8LRz/BGSa00i7vmdHlpJFuCdqeQRcLCpSEA
 Gs8hABAhHzhtMQ5fTLXqHpSz9vELlPTbpfeyBhG71U8TpzMzd5p8+Z9f6FO29WkNc/Ra4h6tsbp
 xOPEK7bFXhwb/dFbPhJCdK4z9ftiT3Zc1wgrvIZq2NQb/ofjC03CecIDULpOrRCsbvItD
X-Received: by 2002:adf:f804:0:b0:324:647e:a8b3 with SMTP id
 s4-20020adff804000000b00324647ea8b3mr1385678wrp.14.1696409082953; 
 Wed, 04 Oct 2023 01:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFqOsym8gnF1Yq6TEDZTcbLuI//yVFzMBslJ8Nwf06SemtIyYNUw5FW9b4yTTUlcOiIjhBEA==
X-Received: by 2002:adf:f804:0:b0:324:647e:a8b3 with SMTP id
 s4-20020adff804000000b00324647ea8b3mr1385662wrp.14.1696409082693; 
 Wed, 04 Oct 2023 01:44:42 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 a15-20020a5d570f000000b003217cbab88bsm3435155wrv.16.2023.10.04.01.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:42 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/63] vhost-user: allow "vhost_set_vring" to wait for a reply
Message-ID: <727dfdef92f3ba592ace05b10315e8b31f15fdf2.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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
Message-Id: <20230830134055.106812-7-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-user.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ccb60da007..ae0734d461 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1149,7 +1149,8 @@ static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
 
 static int vhost_set_vring(struct vhost_dev *dev,
                            unsigned long int request,
-                           struct vhost_vring_state *ring)
+                           struct vhost_vring_state *ring,
+                           bool wait_for_reply)
 {
     VhostUserMsg msg = {
         .hdr.request = request,
@@ -1158,13 +1159,13 @@ static int vhost_set_vring(struct vhost_dev *dev,
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
@@ -1195,7 +1196,7 @@ static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
 static int vhost_user_set_vring_base(struct vhost_dev *dev,
                                      struct vhost_vring_state *ring)
 {
-    return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring);
+    return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring, false);
 }
 
 static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
@@ -1213,7 +1214,7 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
             .num   = enable,
         };
 
-        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state);
+        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, false);
         if (ret < 0) {
             /*
              * Restoring the previous state is likely infeasible, as well as
-- 
MST


