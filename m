Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE047695CA
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:14:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRlt-0003Bh-JS; Mon, 31 Jul 2023 08:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRlp-0003BJ-N6
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:13:05 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRln-00057T-MD
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:13:05 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686b9964ae2so2930067b3a.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690805462; x=1691410262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ak3cZicP6FXgjNSZA0EnmzY0v3FARPxaB+bcgiWIe/k=;
 b=eRsbn0DpQuI8VzGSPbN4slKZhVelHKMtMqKaM/jG0nlqcka8rq8mldubonQvknEftg
 KAYlP0sptRWa6aTcKHGhDvx9R2uh3RMQw+qQ8D8suhaUAxsJTTC0t0GYFBLZ4KcAOzCQ
 H5aq06MiGjGPX9eDDj8judUu2RxxwbCPzjzLxF0XE0ZnGcMOAFaXWAHtPt0V+J7MbdEg
 BxSzKi8vKH+5lzlSlDIVsM2uWa+tNduUvWmrFrMPWr2GHF9k/FWbQpEafH93TifBt27r
 TM4pQY/UX1BNmQFKUL8zV8IdcJI7LGYxDoBelbgknVM6N9QMGjRQVESZCqVLES+LifC+
 1KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690805462; x=1691410262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ak3cZicP6FXgjNSZA0EnmzY0v3FARPxaB+bcgiWIe/k=;
 b=PzidI5oyROwlNHUMZ6Hn71z4RVD+Evh7YDSp6hntXY6bmzeuyMwnF8/nMEcPOvLpbp
 9+QUOAhJ0t1wi4EFy4Fmh/GdlJLGYzHUC3Z9VoxxAM8wxycIpOmACDNmjg2yCifBwFOs
 Mfz7dPPijCYSL0Dyr+uWpaqFyCyJl48nXHx2AjIXojIBPmZb9/8a82hewRaRn9Il1nUV
 s+jrMHKR/+Sbo2Dg56DweFkEkDr7FhkxZ/aUWGHNGpYX5hf9nU1TIU0SkNH+WCWzKCHN
 pobKrxP+O+BYASOYIMtq3iUbLqz5Dqkm+h/vauh7ozNlsfhth1Dpap4XaaccGLVKJA1u
 MHzg==
X-Gm-Message-State: ABy/qLY+3TqGf2rG2dYOBrC++F9G4BgrxEYx5Nt+QzWTlmpLQpqRH7ye
 rzrwaRfiwlRt9dp7Zlo8o01ANg==
X-Google-Smtp-Source: APBJJlFkujDJqHf+XhSC3dGTeqUXhbgeutYq/nGrPpy5ViqSJe9W7kSOCeeUdQEDlgegCCQmcHWLRQ==
X-Received: by 2002:aa7:88c3:0:b0:687:20d6:faea with SMTP id
 k3-20020aa788c3000000b0068720d6faeamr6727330pff.15.1690805462016; 
 Mon, 31 Jul 2023 05:11:02 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a62bd0a000000b005d22639b577sm7385690pff.165.2023.07.31.05.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 05:11:01 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v3 3/5] vhost: move and rename the conn retry times
Date: Mon, 31 Jul 2023 20:10:08 +0800
Message-ID: <20230731121018.2856310-4-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731121018.2856310-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230731121018.2856310-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42e.google.com
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


