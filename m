Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF289761128
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:46:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFXn-0008D8-GB; Tue, 25 Jul 2023 06:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFXl-0008Ck-Tg
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:45:29 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFXk-000372-DY
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:45:29 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1ba5cda3530so4129902fac.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690281807; x=1690886607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOPvppBtU3tERm03xm7z5N4AAn0DHu0QgP1daqx/8gs=;
 b=AX93BukBnGkW0S8rcOm55Ve4Oz5kAlu0QhlSQShzfus7rMY5V8/D2cxDejCD/j6+/q
 Q/s8cSwVlimaPoea7dVCaw/jUvE2xLj800bju5H0tf8vbauN4bvAHz17J9p/5HN0XlFj
 YUcD/ZJ7ZUroGQBz0wM3SwMThDy69O+mvtC6ncj/Tdw2RHXgIMOd6WASKxhzhihCu6an
 dYxnIup4qd6iX0U74CqZnTmI9oOlfUkPPBpyUKWcXm+YsHLXp0V5DzJAJjVLcfS0hWZ6
 BYYjZc4MRzDLM1j/MYawajSSh7/XkeAwxAID7gj/jXwPz437hNBuc80WaPhQoGl3K7Rd
 sIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690281807; x=1690886607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOPvppBtU3tERm03xm7z5N4AAn0DHu0QgP1daqx/8gs=;
 b=jQPkWncrmQQAvYoRX4NHSHeFZNC3NAFfHKn4vm9PvNjRMOw4r+gFcLjSwJUbbBc1+o
 11ViVbyLkTcxtQNEKuPWViUJBB2C03ffAr5cvw0EEw3PpqZyClwnfTGngbow2QqoHQkM
 hOR0LH/6tK4HK+V/oz3ow5pq0vg7DGMR+2epgH8W9oWMYuyIIzub9hHX8vYEbn1OhJlo
 wHmrT052E5kdi+bYfn3d1HzLy3sr2ceKqlbRTq+euphppARVn3ftS5+bvyxYlT1mVck/
 WXgoknSWA9Ujr26w9rIGZCKnQ1mnXeo/XR9BSoh4aAerRHQiZ+IrOPVvi+mQtOq+2g/a
 qrAg==
X-Gm-Message-State: ABy/qLagV7z47SKYXqpI8fJrKuUzS7Ty+E029fxYJSVAnGtCGbuW2i9B
 Nc6b0nM+2JbiNxBw1lrkpNwCTw==
X-Google-Smtp-Source: APBJJlHSq2uBiTm1xQ8MM+BSknk+Ufd69TSpreM89ve71Rzj0TNO3ZpNcBZSEunQeHUE8seKBzIosQ==
X-Received: by 2002:a05:6870:9125:b0:1b0:408a:1d14 with SMTP id
 o37-20020a056870912500b001b0408a1d14mr14525327oae.44.1690281806710; 
 Tue, 25 Jul 2023 03:43:26 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 c20-20020aa78c14000000b0062cf75a9e6bsm9343165pfd.131.2023.07.25.03.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:43:26 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v2 3/4] vhost: move and rename the conn retry times
Date: Tue, 25 Jul 2023 18:42:46 +0800
Message-ID: <20230725104256.4861-4-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104256.4861-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::32;
 envelope-from=fengli@smartx.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Multile devices need this macro, move it to a common header.

Signed-off-by: Li Feng <fengli@smartx.com>
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


