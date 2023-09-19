Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D25C7A6190
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZ8O-0007mK-FX; Tue, 19 Sep 2023 07:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qiZ8L-0007kp-PQ
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:43:13 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qiZ8J-0004Fd-A9
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:43:13 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fb2e9ebcdso4145739b3a.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1695123670; x=1695728470;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ak3cZicP6FXgjNSZA0EnmzY0v3FARPxaB+bcgiWIe/k=;
 b=PlhNhJ18J7/YO46NpeqxCYx04UYJ8bYnTehuSZ0CNkgLp37rxsHsmNgBNbHHdNzeb+
 g9tiF5hxh84LKTEsF+j/cfACJsPzjgZ/Z2BRaQe1l085bnQWYTKrL6mEnBEPAHBIm6Dw
 vKfv6ygkXU1lncfKY4JhX5cTUo7C2sYl3pjDc+SJw8Q8k1vMK38Kt8XVx6HUX8ucxi0V
 66eRvVkFOa1hKRymU1U51NzKBs27fbBAo89WWxslgL1dt9BfgQ5ztmB69BnWOr6W93Im
 3VBXfoShZ1XDQt+1dqbtOOtyLGsXgFRwZpwVb0ky0YEQVIc1nWRtzOlASgJdvXu0cksj
 cZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695123670; x=1695728470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ak3cZicP6FXgjNSZA0EnmzY0v3FARPxaB+bcgiWIe/k=;
 b=NbAZ7WeTQb+mAQznHEK1hAYOb0p8zHwYLu8/Vi//kXKzP+DVy7jkAbzjVEkAr8rjNq
 TI16ptToXoW6SPmCs3lHeeluHm0IeB+ZA73yNNVDaa1uRYgL6tyHnIBzfTAp+5aP7B7u
 wdB9G8ymO8JylLKO5b1mh+0cZiSVYJJFmgGlBsiCQS5dqJICPyoYdNzawOymEVxROReb
 tMAGGkTfbsnq5ZOG36w81EDbbfkzL+F5ND5a6P961shzoFl1dfFsOadh4r+lAb+vMmJ5
 RPHH276F4oPeFUJLmuiHBN2J8abd8wPriUPG7DJbDKXOjlSx2CKXa1aXKZhtT8b8uh/I
 Kdnw==
X-Gm-Message-State: AOJu0YzLiIGwz720xU6WhnG5llMh57mlDrkPYahfgPxVEHeY0cPp7T7K
 kboYuWfwFHNOxibbheYs6mvh3g==
X-Google-Smtp-Source: AGHT+IFqQdE9zR7dJmn8PVkbIaZPsz/mS2smwyJ0mv4zrKrqbOLPPiWN+FJb8sgzJQ8KZkA1mkcBRg==
X-Received: by 2002:a05:6a20:12c4:b0:159:b45e:1c7d with SMTP id
 v4-20020a056a2012c400b00159b45e1c7dmr12504989pzg.15.1695123669748; 
 Tue, 19 Sep 2023 04:41:09 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 z24-20020aa791d8000000b006887be16675sm8487030pfa.205.2023.09.19.04.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 04:41:09 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v5 2/5] vhost: move and rename the conn retry times
Date: Tue, 19 Sep 2023 19:40:23 +0800
Message-ID: <20230919114030.280414-3-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919114030.280414-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230919114030.280414-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Multiple devices need this macro, move it to a common header.

Signed-off-by: Li Feng <fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/block/vhost-user-blk.c   | 4 +---
 hw/virtio/vhost-user-gpio.c | 3 +--
 include/hw/virtio/vhost.h   | 2 ++
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index eecf3f7a81..3c69fa47d5 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -32,8 +32,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
 
-#define REALIZE_CONNECTION_RETRIES 3
-
 static const int user_feature_bits[] = {
     VIRTIO_BLK_F_SIZE_MAX,
     VIRTIO_BLK_F_SEG_MAX,
@@ -482,7 +480,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     s->inflight = g_new0(struct vhost_inflight, 1);
     s->vhost_vqs = g_new0(struct vhost_virtqueue, s->num_queues);
 
-    retries = REALIZE_CONNECTION_RETRIES;
+    retries = VU_REALIZE_CONN_RETRIES;
     assert(!*errp);
     do {
         if (*errp) {
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index 3b013f2d0f..d9979aa5db 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -15,7 +15,6 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "trace.h"
 
-#define REALIZE_CONNECTION_RETRIES 3
 #define VHOST_NVQS 2
 
 /* Features required from VirtIO */
@@ -359,7 +358,7 @@ static void vu_gpio_device_realize(DeviceState *dev, Error **errp)
     qemu_chr_fe_set_handlers(&gpio->chardev, NULL, NULL, vu_gpio_event, NULL,
                              dev, NULL, true);
 
-    retries = REALIZE_CONNECTION_RETRIES;
+    retries = VU_REALIZE_CONN_RETRIES;
     g_assert(!*errp);
     do {
         if (*errp) {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 6a173cb9fa..ca3131b1af 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -8,6 +8,8 @@
 #define VHOST_F_DEVICE_IOTLB 63
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 
+#define VU_REALIZE_CONN_RETRIES 3
+
 /* Generic structures common for any vhost based device. */
 
 struct vhost_inflight {
-- 
2.41.0


