Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AE77D2219
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUfP-0000RW-LD; Sun, 22 Oct 2023 05:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfL-0000Qh-IS
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfJ-0000De-Vd
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E99g4CTTfhJ51zXlgqHdg/7C/6fC/h1geeLvGMNmvCc=;
 b=CPpTzUMA0H2yPljNEu0qMLLF+k8A+0NuxVXaWXBExyi+FUG778DkDCMah0PGyydm9w8Wdj
 YoCaufrTfUEcgTgn6EOzUXKRzqScMptMmBpaTgZGS+hfQk8kqLj1J86esBL6OI0bw6qRt/
 GjDj3dNgN/kDjBxi/8q9ajVXOQZKJj0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-hVfpRjfFN3abC-T88xnZLA-1; Sun, 22 Oct 2023 05:22:31 -0400
X-MC-Unique: hVfpRjfFN3abC-T88xnZLA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4084d08235fso14303665e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966550; x=1698571350;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E99g4CTTfhJ51zXlgqHdg/7C/6fC/h1geeLvGMNmvCc=;
 b=ALAaObJDKOXOQSxZMPixvlcyl5YzrR5zl9NZol5GKYeZfMHCYZHRkILywP051QKr1j
 0uCxUYp2menW8PW9C7NJnxGdv9awUCGq5DCEyMeYHjMcpqsWqaSppwb1p45tJEl3Q5K9
 1SrUmZH6VFd9QyigVNstzWoNiqs+anz/g+zblA1JcMEQHgrZcekg56y+auNlaYXoBdgN
 n7NDg9XHTjOuCFzhjx6o9A/nAjaGf6kKnX55wYLWN7x6d4wJAXvA8iUgS7xTxDL5YUIz
 pqVVR6XpUPswS7OifUWJhb29OqPK6RRS139/2RNrYJXyDkFNVTKa2dW+z3nnw++Ni1Zm
 NxMQ==
X-Gm-Message-State: AOJu0YxbpMxVbRA9UzzBGivtKA+W5Xk0UrqgxjfGRVfLkBK1I6+PCCu3
 9bF/WHXyA8qU28asy0j5SR6sLz4WyJ9a0WC3c5cFjhAU4a9hXnm1b4oy9EcgjeYcGNGAPkzYfJW
 zuhPs4Y7jlVehBuJtEV0TLqcTPcx1nkTShVyIVe1DlsamUfmyHPkTaCG762E1GsLaZi04
X-Received: by 2002:a05:600c:5493:b0:407:859c:a1b2 with SMTP id
 iv19-20020a05600c549300b00407859ca1b2mr4702269wmb.14.1697966549977; 
 Sun, 22 Oct 2023 02:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnjRqMzQpoTzkCBLHxl0lVTDGioriNlIkFeZSk/m9dZ8JSPlYvsIbYwXPBf+4wq3IbAznBRw==
X-Received: by 2002:a05:600c:5493:b0:407:859c:a1b2 with SMTP id
 iv19-20020a05600c549300b00407859ca1b2mr4702248wmb.14.1697966549686; 
 Sun, 22 Oct 2023 02:22:29 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 x22-20020a05600c189600b004083a105f27sm11102208wmp.26.2023.10.22.02.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:29 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 09/62] vhost-user: tighten "reply_supported" scope in
 "set_vring_addr"
Message-ID: <ed0b3ebbae4d3afd9f742613ed64444e4d04ae0a.1697966402.git.mst@redhat.com>
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

In the vhost_user_set_vring_addr() function, we calculate
"reply_supported" unconditionally, even though we'll only need it if
"wait_for_reply" is also true.

Restrict the scope of "reply_supported" to the minimum.

This is purely refactoring -- no observable change.

Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
Cc: Eugenio Perez Martin <eperezma@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Liu Jiang <gerry@linux.alibaba.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20231002203221.17241-3-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 3e33a2e9e0..6c7b4cc75c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1321,17 +1321,18 @@ static int vhost_user_set_vring_addr(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.addr),
     };
 
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
-
     /*
      * wait for a reply if logging is enabled to make sure
      * backend is actually logging changes
      */
     bool wait_for_reply = addr->flags & (1 << VHOST_VRING_F_LOG);
 
-    if (reply_supported && wait_for_reply) {
-        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+    if (wait_for_reply) {
+        bool reply_supported = virtio_has_feature(dev->protocol_features,
+                                          VHOST_USER_PROTOCOL_F_REPLY_ACK);
+        if (reply_supported) {
+            msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+        }
     }
 
     ret = vhost_user_write(dev, &msg, NULL, 0);
-- 
MST


