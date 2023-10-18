Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3667CE266
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8xF-0001wW-UT; Wed, 18 Oct 2023 11:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8x2-0001aD-8a
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8x0-0007gi-If
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mAx5U6tzoPzE/iLbJKJIpH55yxbW14JSXW+iIiHFWOE=;
 b=coMLRi3ufn+jfC9KShYmdsv1Bl4EPvXODm5etadeYIalPed7WTzmaIOnF5EjTOd0YXTE4H
 iAJCvgQYalexSLwtmgHPSMKm10/n1Qgm6IJMuErNkkqzyk1/cBORKcVbOYQfwPrq5fbjz3
 sS0FUvSSGSVsNiTZLSCiMZw7Hg1SJb0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-W6zS1_ftM5OIE3WX2ZNcCg-1; Wed, 18 Oct 2023 11:59:02 -0400
X-MC-Unique: W6zS1_ftM5OIE3WX2ZNcCg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32d9cd6eb0bso3071504f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644741; x=1698249541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAx5U6tzoPzE/iLbJKJIpH55yxbW14JSXW+iIiHFWOE=;
 b=hz3hhx2PvQGd6VL+CTQNy/AdsjJhIfWG4l9ss17rHVLn6LmN1xJqx4CXH0I8HlFB6t
 EQfOoDdSAzzgnKAglk4Noaa2NkFAtB72QmVp2o8mViGFVdIK2B2S3Hy/EhkQhdBOr6XA
 SFZGNKP7SoKWhZO7PAAKxpceciXcV+VDLyWMX/k5q8dc3u8JLWJHYBM0Jx2F9KcWDqiX
 5t9zNz0mcpUcqB+7b9r4b4X9wjRDilfkma+Xp63Ca6OFk9sd7hcAns01aWCZBobFnHkE
 SokJZVJOnG1zwCirTxVzvoY2nU3sY+DpEWfwSlp6Pib0CIAfiAAfHo8DThPvDt8A7ZlX
 xStA==
X-Gm-Message-State: AOJu0YxBAnQSTCviOlNlbTf3WNOhL2nSiDE2QzyzT7h34BgpAuKbbipn
 pF5Mxdsyz5goDqAcZ6mP/S8+qBi2pyxt+6QXKX2nQ+n9sfyVhO8DPK7pwnvRL/JBIDhVfP35NHn
 Rrog0CWHNTdBIbsTwmnVKHD02gUnCqIkaF1oa2o47Syrzap5gSXeP+vM0ES3nwPnkM76Wlcg=
X-Received: by 2002:a05:6000:1375:b0:32d:a98c:aa1f with SMTP id
 q21-20020a056000137500b0032da98caa1fmr4103760wrz.1.1697644741214; 
 Wed, 18 Oct 2023 08:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPfkjXsO27BGHkyIYtitsoZPuhCAgYuYyX3zkXliBGfvf4dgbobK2sp4UKof5m3XZ+ck07ew==
X-Received: by 2002:a05:6000:1375:b0:32d:a98c:aa1f with SMTP id
 q21-20020a056000137500b0032da98caa1fmr4103740wrz.1.1697644740902; 
 Wed, 18 Oct 2023 08:59:00 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a5d630b000000b00327bf4f2f14sm2392996wru.88.2023.10.18.08.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:59:00 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:58:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, qemu-block@nongnu.org
Subject: [PULL 73/83] vhost: move and rename the conn retry times
Message-ID: <defb50258fc7bc7386c4666f69e9d73590580b6c.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Li Feng <fengli@smartx.com>

Multiple devices need this macro, move it to a common header.

Signed-off-by: Li Feng <fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <20231009044735.941655-3-fengli@smartx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost.h   | 2 ++
 hw/block/vhost-user-blk.c   | 4 +---
 hw/virtio/vhost-user-gpio.c | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 00e0a669b8..5e8183f64a 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -8,6 +8,8 @@
 #define VHOST_F_DEVICE_IOTLB 63
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 
+#define VU_REALIZE_CONN_RETRIES 3
+
 /* Generic structures common for any vhost based device. */
 
 struct vhost_inflight {
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
-- 
MST


