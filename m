Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3337D2222
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUfX-0000wy-S2; Sun, 22 Oct 2023 05:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfV-0000pt-1d
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfT-0000FA-BM
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxQyEGJG94rK4SLZUCeD2LfRemmWxcyxJsLSwEgXUzM=;
 b=F6upYeWGHO/7iy2e8/pYMNo5Ob86xfgIyE+Sd5XCOncA748BzsCKy/HQUbZPdZJf1y1zHO
 SNPc0J22tObldnfx8y/8VwmZz83uE4SzDO8bnjIKgi5G2uSQaq0AsGQ23BadbiRiuRrDSr
 bcgwmlZBj7LRmHzLAa5E/f7bADmj8dQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-1kO3B820M3GnMPTfFsDQOg-1; Sun, 22 Oct 2023 05:22:40 -0400
X-MC-Unique: 1kO3B820M3GnMPTfFsDQOg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40855a91314so7581165e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966559; x=1698571359;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fxQyEGJG94rK4SLZUCeD2LfRemmWxcyxJsLSwEgXUzM=;
 b=uvNuzdz468lledK43wKCRftfrM3v06RgYwLPTTEFYYEQq9ZgLMrbopu5/4e+smg0m6
 k1rmrrCfwo2EMUw3mfdyO1JrgpBsgBaibgw37NpUeoDFnYgkIi+xdHioatDN68w9r34f
 ORjybg3ULIuxUHJSEP/dCE+PUcdSpIq0LaXP4PWdqP4NvP5gDlVSYAWDez0CuGlqAyrD
 RY1lwVPtzvudBZt3rVfuGe2MjDeqGfMcZaGGFnk4XrC49o3gDJQIWcdz2WPHXiKBX7aw
 OBkmEW/ut/JBOSVqLJ+UAIvTU9nWtb1UG+Ai4lof7mI5q/g9TdEWcuTViSUsOgst9Sbc
 RtNw==
X-Gm-Message-State: AOJu0YycDEH5zG4+qZiny1/6VuDEP6GgxS2teC5tPvCZH3PBo/5VlatM
 qnBeA78w6K4yB3GJBl3YFLKUL5XGAp70vfih50uOFtVENzUSO2udnlrtmfpfXVKenzuxSZu/ni/
 HVSlyD/4sghS+6TwoaPPHtNjU7gdJOzKEMX6BEYhxI4dtAyZreDUTAwHvSdND2bi8wYUe
X-Received: by 2002:a05:600c:1d26:b0:405:3924:3cad with SMTP id
 l38-20020a05600c1d2600b0040539243cadmr6033422wms.15.1697966558846; 
 Sun, 22 Oct 2023 02:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhPvEG6oO/QW5ScvK4drMzYODZ42trvl6I1wd55zCCUNnA5jB1C8+TKgtY2Z1NFGvaHG7yrg==
X-Received: by 2002:a05:600c:1d26:b0:405:3924:3cad with SMTP id
 l38-20020a05600c1d2600b0040539243cadmr6033389wms.15.1697966557768; 
 Sun, 22 Oct 2023 02:22:37 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c4e8e00b004064288597bsm6521990wmq.30.2023.10.22.02.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:37 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL v3 11/62] vhost-user: flatten "enforce_reply" into
 "vhost_user_write_sync"
Message-ID: <99ad9ec89d45dbc532471537a4468b9a5ea386e3.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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


