Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 191617D0171
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:28:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhk-0001Wc-NU; Thu, 19 Oct 2023 14:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfI-0006ab-VJ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfH-0000mb-Cr
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3kB7c3/8mnVXhh3/qxXLsdRopBKANEVLkGnuRjvnEA=;
 b=cpaxlEAU8VsPcS/yHW+LM0AAq8h+cwHq8K29XlyiMlceaNCVtpWeMLbthTTkssf3PaWYCQ
 cSy5xG66XXic9ja8rkyrUdTKj3GvFBpqUomNHoMY7KB8MbE73I9qt0nm4M2gQeu7I6Alhd
 4Klw1mKAEk1KgpH5g+IpKT6BBm3ijhA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-gFGwKE8dOq-ZdVJUa1RoNw-1; Thu, 19 Oct 2023 14:22:33 -0400
X-MC-Unique: gFGwKE8dOq-ZdVJUa1RoNw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32d879cac50so5516f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739751; x=1698344551;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k3kB7c3/8mnVXhh3/qxXLsdRopBKANEVLkGnuRjvnEA=;
 b=lqfF7Ken6vqpAesNEvJAnuSlFKX1rTN66i+2z4EZMDD0mc8jp9mUhuBdwU+LBaBpSG
 PsVLLevNYUjLeosyvvVoj1mvRlKd4vAtOp96Q5Djqxw6EbHSdCIZ9s0RFzP3ZdHzMTR8
 KTFMQ0FuxOj38d7ADhuXi/pi4CG/sa2DLKPzsuJG8GjfhKvR7+wvvgTirBDsj/bnXTxI
 bgTxTIdChvoshE92tOc2iVj09UkqIb+oG3H3NP9Gu2cUBQsTujTyRUiLBjwh80flxKQD
 CgP01+Qfg5UOIIT5PZVn7zCrrKXzVcUUSC4joR3zK+Hmu2KLH8xvhNdlYlwBlkZOEptq
 /U/A==
X-Gm-Message-State: AOJu0Yxtm9qOaORLVkdpwm3PwikkBzmMtHNzAFYhKJhmj6nd9xEzdYOv
 hFNZ33Il8rkg9ZxG4TQV69qYWUauw89rG0Ll5HiCHuMZD7XnOCDIF/vdktAfLkAY/8QoDiOsFU6
 Hw5Lk2s9MGnxThRGS+uBuiGaWaLEhwbdw8ralspjfMYGGBM15PBe+X258mKm2CqH+s3TT
X-Received: by 2002:a5d:6151:0:b0:32d:9fc9:d14c with SMTP id
 y17-20020a5d6151000000b0032d9fc9d14cmr2061791wrt.47.1697739751201; 
 Thu, 19 Oct 2023 11:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELmmBTIhz9rbfO/UiN7opCYS0ME9cXRVfL7eKbKJp5D1jQyoVwAvGHaI2JHbUxKfqedt2AzA==
X-Received: by 2002:a5d:6151:0:b0:32d:9fc9:d14c with SMTP id
 y17-20020a5d6151000000b0032d9fc9d14cmr2061772wrt.47.1697739750907; 
 Thu, 19 Oct 2023 11:22:30 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adfb60c000000b00318147fd2d3sm4970378wre.41.2023.10.19.11.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:30 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL v2 29/78] vhost-user: allow "vhost_set_vring" to wait for a
 reply
Message-ID: <25e7564f205b1f0c7ccb81ca241014764e634f63.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


