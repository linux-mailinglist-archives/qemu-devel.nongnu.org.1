Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF077B7B18
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:06:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUx-0005TV-De; Wed, 04 Oct 2023 04:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUj-0004uW-TW
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUg-0001fu-Ad
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8vj3X74gEmH7hHlDj9OTv9YYVd4Sl2ClFSieR1UZFo=;
 b=HQ27ihPAyI+RBgSzi1Ki+cWlY/s7tGQum5ZuYceufOWBUDZy6qMiteHmVAr8EqFhC6YPGH
 9hu12x6PgQOvLQgDHvEXUM05mTPWI2Zbru3XXcgWwryWmj0OToWbsd9VFvV+D+7Ke63zxm
 yihBI0+Rks9r0r9r6KspawHvA3zYVrg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-evzkXGqGOyiw28t3JF6XTQ-1; Wed, 04 Oct 2023 04:44:31 -0400
X-MC-Unique: evzkXGqGOyiw28t3JF6XTQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-406710d9a4aso14508965e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409069; x=1697013869;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S8vj3X74gEmH7hHlDj9OTv9YYVd4Sl2ClFSieR1UZFo=;
 b=JzE2gRE5bh1I2VbWuutjXxX7Q/fJB6CrS7vSzC1+rsrVJFaFhj1iEPTMqNmQQUErQz
 VE7AK3YNgjKeMknDOb9Nb/9619j9JTr9eCdM3wUheavfrhI3ZmGvrqW2Xix5yTFYuKZQ
 l5dMilmsYks0/JvwAzOjpFUBOVWTQwowQHq9vGpsj401gdIIH3z0U2mISg9KUvuXtep/
 8m3FILX64yH7kUvxxqD1j0OxsR+p9NTgdeAnGikYYhdfbAAKZ8Px/6iB8zXD0SJeWUPx
 qJhXAzvBUqbwX0PJa0xsH8cxRJ+zSsf/taAxddlME/EqfwodPafaYpNLjCrVI1OIn0My
 DhCA==
X-Gm-Message-State: AOJu0YwxgWKpsbTOccJU60Op9uw+LQ3BQcwzbK9pSmYd8957vbaeAgLx
 0emTzzwGDU58OVdJu+tbKDNRxOWUWxBEZdzCQiojlkw+pPhXWEsNSV7T5b6txjSLBguB2nay1jz
 D1ahD1IlNUrp/SHh5XLQOc/qA8b8+dnqqoWVLTG//0Y2/wl2YvG2rW0rZdhd4AxBRXH8U
X-Received: by 2002:a5d:4f8a:0:b0:31f:84a3:d188 with SMTP id
 d10-20020a5d4f8a000000b0031f84a3d188mr1388079wru.22.1696409069322; 
 Wed, 04 Oct 2023 01:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY9goEte4GZ6aiHF4kZ1NI6oJuYzwGDCiuY3IpcUDfSZoW3meKkgIDC8cObpV1mAZun7v0pQ==
X-Received: by 2002:a5d:4f8a:0:b0:31f:84a3:d188 with SMTP id
 d10-20020a5d4f8a000000b0031f84a3d188mr1388058wru.22.1696409069041; 
 Wed, 04 Oct 2023 01:44:29 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b0032327b70ef6sm3458404wrw.70.2023.10.04.01.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:28 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 25/63] vhost-user: tighten "reply_supported" scope in
 "set_vring_addr"
Message-ID: <ed10873162830e8d0b56e31fb277afc9f1c985bb.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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
Message-Id: <20230830134055.106812-3-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-user.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f4c06ecb10..dae16d3b33 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1310,17 +1310,18 @@ static int vhost_user_set_vring_addr(struct vhost_dev *dev,
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


