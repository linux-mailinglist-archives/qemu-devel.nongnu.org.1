Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6EA7D01D7
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:37:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhN-0000QW-UO; Thu, 19 Oct 2023 14:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfH-0006ZW-LG
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfF-0000mW-UK
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxQyEGJG94rK4SLZUCeD2LfRemmWxcyxJsLSwEgXUzM=;
 b=W9L0JxWmvWPJHZmGyoRn/FUEs6EIfob8N+lzi/3rHO5L0eCw/S4r2c11X1sPKJMnGOey5K
 qNJEAnSrdVyHSoC+kIyRGL8RWzX1INBOTTMUF6B5ptcMOMznTIGDPJAi9yrkzWbOcqEb+q
 UyYGLlbWE+WsVAGCIn/WcNe6/w/xGs8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-FD31bJjtPV-rVRbKCDGMeA-1; Thu, 19 Oct 2023 14:22:27 -0400
X-MC-Unique: FD31bJjtPV-rVRbKCDGMeA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32ddd6f359eso414001f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739745; x=1698344545;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fxQyEGJG94rK4SLZUCeD2LfRemmWxcyxJsLSwEgXUzM=;
 b=M78RS+GEr5czooovZU3+i/N7V/f4C6P8G0ALbdhIpsvCHt6geF3HpFzjKyNVnxfGxh
 ym97YA6oY/eyWJFUWqHdsvWzSTOOWarHu/GOTG6bYRed5skZnRUiHOGfNkyOjWHnk8zs
 /4nTCfDGmFg88Qc794vb491To+ngVQgTlgeD0Ty6cy0NV6hF/f1ZALCPcXR7PE58CG4o
 KZ91MIdWWipVlmtXZ5bLwEE+OQgx1WjZ6R3P/E430P3TYns6dBdAXmCcYmzJZF7qRld8
 w6+dkcbk6qz9n2ctWyvhRCueWZ2EXDbJHRUzK3ARGs3viQsKJceFjEQj/ndGCbhAngfS
 9Bew==
X-Gm-Message-State: AOJu0YzigllFrYv/L/UDIumf2D3dz0GevTCa6VAwyv88OXfH1gYe0J0T
 7piJB6FgT8jMx/jvnN2eb82yu8THHbV9Arpm17F/ohTyjVWikscQR/WNrm7PFfhz615B6Qo7rwK
 UtboNXPBQnQhGvMrrdHnkMxP/9MjHf0Cg1Eo2vQFhMwpBzWjD8g64jsJGVxD+ZO4Mdd5N
X-Received: by 2002:a5d:550c:0:b0:32d:9e5a:a38b with SMTP id
 b12-20020a5d550c000000b0032d9e5aa38bmr2110168wrv.25.1697739745534; 
 Thu, 19 Oct 2023 11:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNjYaSKsChnU4SJBeFeOFVMSI7A1JQLJr810t9iR8/6cU76H+ElthGYu8c7XMbfTuV9/kdXg==
X-Received: by 2002:a5d:550c:0:b0:32d:9e5a:a38b with SMTP id
 b12-20020a5d550c000000b0032d9e5aa38bmr2110151wrv.25.1697739745205; 
 Thu, 19 Oct 2023 11:22:25 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adfa35c000000b0031ad5fb5a0fsm5042886wrb.58.2023.10.19.11.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:24 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL v2 27/78] vhost-user: flatten "enforce_reply" into
 "vhost_user_write_sync"
Message-ID: <f055379dae841a6db216864d7010d21f64a659a1.1697739629.git.mst@redhat.com>
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

At this point, only "vhost_user_write_sync" calls "enforce_reply"; embed
the latter into the former.

This is purely refactoring -- no observable change.

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
Message-Id: <20231002203221.17241-5-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 95dbf9880c..23e9039922 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1292,24 +1292,6 @@ static int vhost_user_get_features(struct vhost_dev *dev, uint64_t *features)
     return 0;
 }
 
-static int enforce_reply(struct vhost_dev *dev,
-                         const VhostUserMsg *msg)
-{
-    uint64_t dummy;
-
-    if (msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
-        return process_message_reply(dev, msg);
-    }
-
-   /*
-    * We need to wait for a reply but the backend does not
-    * support replies for the command we just sent.
-    * Send VHOST_USER_GET_FEATURES which makes all backends
-    * send a reply.
-    */
-    return vhost_user_get_features(dev, &dummy);
-}
-
 /* Note: "msg->hdr.flags" may be modified. */
 static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
                                  bool wait_for_reply)
@@ -1330,7 +1312,19 @@ static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
     }
 
     if (wait_for_reply) {
-        return enforce_reply(dev, msg);
+        uint64_t dummy;
+
+        if (msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
+            return process_message_reply(dev, msg);
+        }
+
+       /*
+        * We need to wait for a reply but the backend does not
+        * support replies for the command we just sent.
+        * Send VHOST_USER_GET_FEATURES which makes all backends
+        * send a reply.
+        */
+        return vhost_user_get_features(dev, &dummy);
     }
 
     return 0;
-- 
MST


