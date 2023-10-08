Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC437BCD75
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 11:14:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPqS-0001oz-Gv; Sun, 08 Oct 2023 05:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPqQ-0001oQ-AS
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 05:13:02 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPqO-0002F9-JZ
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 05:13:02 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1dd0526b5easo2665156fac.2
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696756379; x=1697361179;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flzDQE1QokZHW+hOGv8gceXlgLhnm4s9nj6hmmZpjyU=;
 b=kd4nd0bz7nwvnO8riBuxItF5pYns0BqmyEyEAXwB8QlO3uBSk9VZ/V4qA/l6xvM0Xj
 bqHOTdhxzwG6xAe+Cw5wT2CywZRETTVKwhNBxd2UozOKl3i4fssFwyFkkje56FCHycgw
 jt0dYuwfTW7EkKFxbDOUTEhwV8Y7/gXW6MscchLuewDITMzWiDHRIITii5jj+1vhU4Ta
 AIh5FdcpbnrDQ/3mKAWmh1zR1t5xLWHgXcKXmjZ9hbVuHt/WVMcX71KAr1djK+vLkyFu
 bRPZ6x14H3Ajd9xdWcM8Qfz0p2Wy9wYstm7csslKTItGPpiO6DtzC+QLwdx4+0tMAiB7
 U6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696756379; x=1697361179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flzDQE1QokZHW+hOGv8gceXlgLhnm4s9nj6hmmZpjyU=;
 b=ia9swhfO4xBNn88clKIR96xgqnBObU6kqTAvBS1sAraDcAGp0KpPq+AmpUTRkSNrJY
 cdJSlrIbIbDKiPE0J1I+k1aj8JIx1TliT/jnLdFYt8arP1GjUrplIBDWWZ1s+kD6pdra
 DiQflJfRAFXb7cu5YFJghAzlp56RHOkOt+OQv1VhR8yMRbfJ2LNk1eE8DI3Ny7dw4yEE
 6qizIRNtLkAik6MgPR6DStPl+hW9bnyJn9CLPdwNFtBN1rZ+ZK/RINtl46ZoOAAqGZDy
 q9POCOnPY6vH70zSd0JpfboagPedB59HAr6vhiCdjuZ/qTcfPAn4CY0S7YVddbHruNff
 f9Iw==
X-Gm-Message-State: AOJu0YzC1hr08QVt9AxtOutLOGGYbSxOboNeRnRTU55iwkl+v911lmYb
 CvPVKef7jM+noDjmnRNXEQa6Kg==
X-Google-Smtp-Source: AGHT+IH3e7RcEtzZbdxvibUthCX9bMwDv9vVMTT4YRhgCPI//2hDfJbgomWS/BmuQvpGBbJ2ZgOYhg==
X-Received: by 2002:a05:6870:898c:b0:1d7:1533:6869 with SMTP id
 f12-20020a056870898c00b001d715336869mr14792038oaq.31.1696756379070; 
 Sun, 08 Oct 2023 02:12:59 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a17090301c800b001b8a3e2c241sm7118084plh.14.2023.10.08.02.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 02:12:58 -0700 (PDT)
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
Subject: [PATCH v7 2/5] vhost: move and rename the conn retry times
Date: Sun,  8 Oct 2023 17:12:02 +0800
Message-ID: <20231008091220.870171-3-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008091220.870171-1-fengli@smartx.com>
References: <20231008091220.870171-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::29;
 envelope-from=fengli@smartx.com; helo=mail-oa1-x29.google.com
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


