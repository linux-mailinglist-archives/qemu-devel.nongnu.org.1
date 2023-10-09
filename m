Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEF77BD29F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 06:49:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpiBo-0008Nq-OC; Mon, 09 Oct 2023 00:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpiBm-0008Mw-Il
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:48:19 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpiBZ-0003Rr-2N
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:48:18 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c760b34d25so26790685ad.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 21:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696826883; x=1697431683;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flzDQE1QokZHW+hOGv8gceXlgLhnm4s9nj6hmmZpjyU=;
 b=X0PaMKLmQySOoUPUuMRFo2xkmXeqc/FadoJ2Nj8OAAqRk1fkWbKpurJAUurej2oYPv
 dxOouDWtiXm5bOnZcTEGfOj7VaGP/Jhe127xi0X6DRDpRQQk+lDWZoTWIISZXIQNx+Vh
 aN/Kxgr/swF/It34EPik6YL7fArmJfrsFFSnbvw0Q9YSHCLbj+bSCRiEkmmPGsMRMKQa
 QtaoW03zuoa3FQ+lHusbz0AfdMd7B1aYN6kiwj3ZXdRU6AQbfmuTU5P0CDtRPbU8Ge+6
 O7ZSwm/EqHAJZEllHF9DK0thHG9ONOs8ekXaAzKUEJpXOer0ZERAcSSrA599Ts4kH0+j
 2J8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696826883; x=1697431683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flzDQE1QokZHW+hOGv8gceXlgLhnm4s9nj6hmmZpjyU=;
 b=eOK6waKj9d6NOcXblGN9OJE1shX87t/p5LR/O284Z8Gs/viXrM5xjemxXrKQmXJFVI
 D64nDhhXmHZAl0pl6/rypRyJcMM2J45Xd3t4IXYN0tykvPsYKbbcSWUoFds60aOOKgzr
 UumZ6HULQPrBZ5KCMeNf3m5rZeN5xeH0ckKlAu63IIWgE87hEPqaUF+kCXM9oErYQK/n
 EKyT2qZcZPzgCCgA2AqCE67VpCVg6DNhNZkjGXcwHZtLAbUQjYZXQ01NYr9MQTKy0Zb+
 /C2eoERPKNf2TFnz6hX3PtRHoCcbYe7XW7iPLgcU8tNpf3djiKwaMwDLT1sNjvhvuDbb
 GqZA==
X-Gm-Message-State: AOJu0YyFu+QIiZ5+02AVWU2wIKNkSTP9CB6pRyFVX0y/DoLRqgIFgHdP
 04UKblDfK3NmbzMkqxO7IwfvqA==
X-Google-Smtp-Source: AGHT+IGBUIkym2QQjiMwBtNmecbdrvYLDplF9Hal61fJtGzDF+MA33zBTpLp08K5z8gNzi5JfxbJMQ==
X-Received: by 2002:a17:902:fe83:b0:1c5:bc83:556b with SMTP id
 x3-20020a170902fe8300b001c5bc83556bmr11041271plm.52.1696826883488; 
 Sun, 08 Oct 2023 21:48:03 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a170902ec0400b001c452f827casm8406010pld.257.2023.10.08.21.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 21:48:03 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v8 2/5] vhost: move and rename the conn retry times
Date: Mon,  9 Oct 2023 12:46:58 +0800
Message-ID: <20231009044735.941655-3-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009044735.941655-1-fengli@smartx.com>
References: <20231009044735.941655-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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
index 3d7fae3984..fc784e4213 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -15,7 +15,6 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "trace.h"
 
-#define REALIZE_CONNECTION_RETRIES 3
 #define VHOST_NVQS 2
 
 /* Features required from VirtIO */
@@ -365,7 +364,7 @@ static void vu_gpio_device_realize(DeviceState *dev, Error **errp)
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


