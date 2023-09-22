Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC817AB134
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 13:50:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjeer-00085p-IK; Fri, 22 Sep 2023 07:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qjeen-00084R-2u
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:49:13 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qjeek-0000ej-Vr
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:49:12 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-578b407045bso1552824a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1695383230; x=1695988030;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ak3cZicP6FXgjNSZA0EnmzY0v3FARPxaB+bcgiWIe/k=;
 b=W7nba+RQT7MwcJIz/2F5el851s0xIOEjzUih1/qyvLIKCDc+i+6K+rKChoxR08zym+
 4DEm7As+xL2supOUycpjh00wmJp8cFckTB6TUV+pJS5Ulq2q8FW7uCmz1exz6bxUVgf+
 GtlrIzDblTpe5+OpC9PoZbrRuuY/Yri0MVW9bENq1Y4ydonTDWU/kdJyvP3d2PMNFRBZ
 AL+9XOjG7fjxtrr1/lB/IncAiY7joyeW/R1tg4tXoIIbxwPPaezvAw+hURc6oWFisHsA
 Y+OOXosZBtYsFnODSUJ/g3VKsc7YcfukJP8iv4b4MRCrAksGu1v9hoNOl66sBL9xQkPp
 XN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695383230; x=1695988030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ak3cZicP6FXgjNSZA0EnmzY0v3FARPxaB+bcgiWIe/k=;
 b=G+s3NAH15LR5u8tGEf8EpGQBTOGd17uouI7Py0T5Hx756lCbwxg+0qLG9m47FQPnVh
 FuaRF3w08SusmQyhg5vzdAkho/MdpNc9dZF5DJ16fgT8oaUHyCqZvulOYi7TAkNI9H+N
 ZQcIw37ZY+ZwAg555JUqgeX5rogccaYCeVA/aYtkleJ81LfxXQ5E/Dn/g96KfElidcz5
 IIkfmDLcSiZBd++K5jCJJ6L6CXq8JJgLlZSdA7EPdDbWg1ET0PMDA/8hNw982+4E37ey
 DLkehuzqEOKkHqQfF7uclltIt/1kDPUHpwtNDkgvjy7yfubM3t+3w15DD028150U/3Uy
 31wA==
X-Gm-Message-State: AOJu0Yw6woF85HTt45stT0Z2jge0aKsYbXnivz/Mx2X1GAzgog9tZh//
 wzNnVMY9Rxv80QDilvqFKNnezQ==
X-Google-Smtp-Source: AGHT+IEdtggdijxsSdrzKJYLiQKj0JE0DMcNvELy95ai1DCaxGuMl2D5HMOYaDh876aeh8wj172NRQ==
X-Received: by 2002:a17:90a:cf0f:b0:274:7725:ed9c with SMTP id
 h15-20020a17090acf0f00b002747725ed9cmr7386034pju.35.1695383229087; 
 Fri, 22 Sep 2023 04:47:09 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a17090a438600b00263f41a655esm3303961pjg.43.2023.09.22.04.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 04:47:08 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v6 2/5] vhost: move and rename the conn retry times
Date: Fri, 22 Sep 2023 19:46:12 +0800
Message-ID: <20230922114625.5786-3-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922114625.5786-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=fengli@smartx.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


