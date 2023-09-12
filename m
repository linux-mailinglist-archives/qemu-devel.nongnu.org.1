Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5025D79CABE
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfzBg-000834-2i; Tue, 12 Sep 2023 04:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBb-0007rX-SV
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:55:56 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBZ-0002AZ-0d
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:55:55 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a76d882052so3823050b6e.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1694508832; x=1695113632;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ak3cZicP6FXgjNSZA0EnmzY0v3FARPxaB+bcgiWIe/k=;
 b=3BY233j733vHXG3eM7dPtsA+7AqBxGZUZ6vdYaTItyCoB314RHz/Gv0Zh+dicZcdSa
 bjI9t6t68vOY2DMUPrgEL3sgyqwJHROV3bku/BZ59KdvW4c2+8OM61RJFcTqFTBAmhIH
 XCPgj3u6+Cp+FjAeNEDd+o0MVq/q2eAB/bp7nt1vJ2ypKJFYj15f1WP8VkOWysTCZJK+
 qg+lyGynCzvzu2ZJdfgDgbZz0AtpnjbnqWxWgbdCZEDgjUS1JL8p3fBWs1i0/0UPPuAJ
 G1Gg+wi77Clyx7+xfD1+9U8MNUzb86hs8+8fFMsVozEU18NQ2R0hKWglKh7ggRnMpwv/
 jx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694508832; x=1695113632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ak3cZicP6FXgjNSZA0EnmzY0v3FARPxaB+bcgiWIe/k=;
 b=aLtI7iIfI5phk0WKP6P5AApYT41YTvUpeyf+02YXi99tArBATvtStaxgS3P4b24oQx
 NZ4atTzgIFV0+xhAsdIKcAkSGzw++Qz2U4+2UXVq4x3PFf44+1xWVF3t4ny/XvYW8C4z
 h695uh2QnJPc0hYWxjsVGbVaq6WyvivogJmb1WRKQxErH3Z7mHmWekQFRZR8GytZ7GEU
 K0t+VZxw2PWJw9Def07pfNg9LJ8hBOPkBhQ5oW1j8taBlT5C1Tagcua0VLkbjr3zSuuh
 yf+GBnV52HOTfQNIGTdSzgXxG2p4UAnvG6gmQMVCjilAD7HNpASPlYIcvI8Yr0rBI3ny
 gQcg==
X-Gm-Message-State: AOJu0Yy6TR5Yw23131Gh7lqn8O+MvvHywxfoV3LnOmp0sVy64vLeUncE
 dWk0qZ20vyUfndCobdEO+m5A0A==
X-Google-Smtp-Source: AGHT+IE/O+SlGVsoHz3jY9KbI8GKMMIon48Ogd4jVOl0FBeiBHomgynOYjyJv6TLhdncx+NETC5orw==
X-Received: by 2002:a05:6808:1784:b0:3a9:a334:907e with SMTP id
 bg4-20020a056808178400b003a9a334907emr15269223oib.16.1694508831794; 
 Tue, 12 Sep 2023 01:53:51 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a637d46000000b00570668ccd5bsm6523754pgn.14.2023.09.12.01.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 01:53:51 -0700 (PDT)
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
Subject: [PATCH v4 2/5] vhost: move and rename the conn retry times
Date: Tue, 12 Sep 2023 16:52:44 +0800
Message-ID: <20230912085315.2524857-3-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912085315.2524857-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230912085315.2524857-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=fengli@smartx.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


