Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE227D015B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:25:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXgQ-0007jl-8z; Thu, 19 Oct 2023 14:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXf8-0006LI-KV
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXf6-0000kT-9Z
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E99g4CTTfhJ51zXlgqHdg/7C/6fC/h1geeLvGMNmvCc=;
 b=Bu7BaZrj7hm5m5vsn9W5GBQfIGs4deQKKhsrmJyfV+0LwvtOYaOBrf6TXN20QZAeK9GnsU
 TwtJaX+v0Fdcr5v0Fk2nGTlvsJGfd190BcSGzB/mTpuj2Sr8PKaImvYhSAIGLa03LH/ZxN
 HEElbvpJzxkRpc8J2KKXjntIhVxdPIk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-gIe3UD7LMxuXXXyHHWCxgw-1; Thu, 19 Oct 2023 14:22:22 -0400
X-MC-Unique: gIe3UD7LMxuXXXyHHWCxgw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c50c873604so63503181fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739740; x=1698344540;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E99g4CTTfhJ51zXlgqHdg/7C/6fC/h1geeLvGMNmvCc=;
 b=qoIur8s7RqchMdEpQo4lk7ak9pp9p6HiBEeUNyGFevzMVAswS9dHAnFlXFsBUOIETE
 piL6W7yGwjCRpKOxl1+wwAJlnsvW9MOeP+S+GdnFxkbgmrulSX7HaDUhOS1QQnrrtul1
 /zbO4MEr0LMs7g/LqJkkcxpHDjItOLXlAMAdrBTvHNw6JtNDDPzfvL962dERwiiZY6a6
 15+VW2UQyEOzt/SVe6b6BXyyg+uFqPwv25yDT3Eq6Ln+dXfXJbXnkAbm+v70X1I0zX+W
 3FS2ei0VRm9xiuasIT4Sqk0xmabDBwsEowYIdcqC5E9dth+mmJljt4Q3HoUCJjp+FkAh
 9J0w==
X-Gm-Message-State: AOJu0YztaFvoz5EMu3H6oAhJ3r6+lNznHpCndSae8+Wf3AZPpcHFPE/k
 y9iKieFbyUK34pBrlO28N9bbBvYKUaJLh8fsgiNs7m3zIy2tdbd1xmV6K+MVYm/IT5CpuvesY7I
 17MdCQo2vssYsMgfVIjJT00N9kcN4ip8MCGRrIr49N+AnLP3oJIY0gEifccG29ifGv8Jr
X-Received: by 2002:a2e:351a:0:b0:2c2:9810:3677 with SMTP id
 z26-20020a2e351a000000b002c298103677mr2060123ljz.6.1697739740231; 
 Thu, 19 Oct 2023 11:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWGdP8qtNjEaB4O3XLAm0p2U9bc0IKV26clMdzSwRGx7uJfphKjDtSmj7abWVB2kyX0BfrRQ==
X-Received: by 2002:a2e:351a:0:b0:2c2:9810:3677 with SMTP id
 z26-20020a2e351a000000b002c298103677mr2060108ljz.6.1697739739937; 
 Thu, 19 Oct 2023 11:22:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 y34-20020a05600c342200b004063977eccesm4993458wmp.42.2023.10.19.11.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:19 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 25/78] vhost-user: tighten "reply_supported" scope in
 "set_vring_addr"
Message-ID: <c0c12102686aa08962667555b1cce9295bc86f25.1697739629.git.mst@redhat.com>
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


