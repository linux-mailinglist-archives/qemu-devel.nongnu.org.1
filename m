Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A747CE27E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:15:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vH-0005Jt-0v; Wed, 18 Oct 2023 11:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tn-00031Q-Uy
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tm-0006uK-AY
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxQyEGJG94rK4SLZUCeD2LfRemmWxcyxJsLSwEgXUzM=;
 b=Y4XnsliJtBIDxxhd4fYCmNPGRFMl3D0lQC2Ke/W+M9YR4LksFVEJlG2DiEcPdlkVruF5to
 Y7o9HyD4zBQwd2P3NqGO0cX9W2ItO/tlxUccL+2op/vd44h/OnGD+gSDWn25IzWBSMA26j
 fVPazA1wgpPjp907dodZ46rxglRq5pU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-3Nc2FyMIMCKaYvrt8Lo3yQ-1; Wed, 18 Oct 2023 11:55:47 -0400
X-MC-Unique: 3Nc2FyMIMCKaYvrt8Lo3yQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so44564145e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644545; x=1698249345;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fxQyEGJG94rK4SLZUCeD2LfRemmWxcyxJsLSwEgXUzM=;
 b=K7A3UmAqB61snNBCXUqyZRqzsBQo4mj4Z2MoODzbDUvOJfEWfYsx346UHJG0wWAbWs
 fD+KAKhfPbFKBiLY3oHAnpzR0qHkilIp/FeDK9O9vgj1yMTxGmiYSWvoTc60n4PsWpKy
 DEgcOB5t34OxE/1T5YVXCSv5ZwUPakSarrJ8L2zg6dCn20lKWVukxN23/sTw8rfYaA3/
 BvZElbd9GJ7iwy82ZAuwJeJrmPcEJEyD9kUyJkhpGumlCIbpNYufmBJikmXuLRXAnC6I
 U108I4CEiU9aCdJ2GLXqfNmnMc/Dh8VllL5h3K+JOhDSPc6JP030dBR75S3iEVlwZdHV
 7cgw==
X-Gm-Message-State: AOJu0YxRz62r1nuHonWeFaLwqD7tCnopZGyrsXxiWUq/eTrwRdTVNR87
 +Lu+fg+raIgkIrNByD1NDgVCgYRL/XHNw073X7y4BLhwyy6NVZjxt0S5C1+v6Os8nurHqOxJyRf
 ceOY/jwPPxqTHJGjZEHAoVgmxyc0Aj8+MpurN6rY4oUJLkPpm27T0FBoe/Ki2P6pFkWhSpg0=
X-Received: by 2002:a05:600c:418c:b0:407:58e1:24ed with SMTP id
 p12-20020a05600c418c00b0040758e124edmr4286672wmh.39.1697644545079; 
 Wed, 18 Oct 2023 08:55:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOlYVfw/P+UGkIVXgQqpRfSqSASliyYCrvnzxZNy5KGTBcEW0zMHraK2m4bcO1YGoMJDmyLA==
X-Received: by 2002:a05:600c:418c:b0:407:58e1:24ed with SMTP id
 p12-20020a05600c418c00b0040758e124edmr4286642wmh.39.1697644544571; 
 Wed, 18 Oct 2023 08:55:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a05600c1c8600b0040839fcb217sm2045776wms.8.2023.10.18.08.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:55:44 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:55:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL 32/83] vhost-user: flatten "enforce_reply" into
 "vhost_user_write_sync"
Message-ID: <999280bc8c079d5ff9d956bfb598a2f1a42bc682.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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


