Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F257D0160
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhq-0001g9-69; Thu, 19 Oct 2023 14:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgy-0008Va-S0
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgx-00024s-91
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mAx5U6tzoPzE/iLbJKJIpH55yxbW14JSXW+iIiHFWOE=;
 b=WmSXCfA8qKc9Pk1/wBALzU7jVh2p4P6FdYU/CvAcZ8ctNyOAw0dxf1d/t/K23pVHQNldTb
 6XAze/Qax5weFFLcMO86SgVgtT5q9GI/GTgyuJabs+4YWuIcbSzEV1BVHHaGcb39uoRJZt
 TzMNeQs2pdTqXbvi5nOJqcb0PsNxk20=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-nh_gJUHaMFaQu7O1rIDT8w-1; Thu, 19 Oct 2023 14:24:17 -0400
X-MC-Unique: nh_gJUHaMFaQu7O1rIDT8w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4083865e0b7so15854615e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739855; x=1698344655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAx5U6tzoPzE/iLbJKJIpH55yxbW14JSXW+iIiHFWOE=;
 b=gVBEXphMF/pb0tU9TFltVokxEessNS8uJyg4zM9423VW4fMSmUyRI5BUivakZSJaJI
 5u7T7y6um9Npz4nq0RTzl4ofhJRravjWWkdX24GehAQ/V9kbie4llTxJX7noc1bhkeEy
 28CqN2JKtKnbZzeH72KLzyQDV6PQHpkjgGGN1Qft/YuBec1YoNrY0AmAIbl5CpYP9scA
 gclC9cxcf5v/q2+T7ykPAcWfHY3Kc16Jb9BiNaCROg/JeJuQAiad85GlVJ1272LWQ7Bi
 9uF3W9Ttl5BgHax/kX64FjlT0TBWOZTcl+D9wJaa4YQ/2pDerzYQEFrFGr4ghoLPZnGY
 Nwaw==
X-Gm-Message-State: AOJu0YxolgOuCn2Oi/WV5Pod8b0hZ3D5IRrr67UyTr2WnsY89EurfgB6
 EtbGtOznjnlDRV9aXXe4xguD0spxffH9CJsve65uDZxyAJuxtnf4Uve9c/brSfXCTC0+wrbd3Pl
 qxzZTQGU2rg9LKeerzEJGE/0QAOwNFM55CHKR//u1NiZQoa4/vPi+qVWRF/9W20hYRb9Q
X-Received: by 2002:a5d:5247:0:b0:32c:d7e6:4054 with SMTP id
 k7-20020a5d5247000000b0032cd7e64054mr1935407wrc.53.1697739855351; 
 Thu, 19 Oct 2023 11:24:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6cFhAEbIszq00z+uXEw74SLWyu7oKKc/Bl3JFdynlx6eZpG9i/1g5SL24DQtb0t7QIKLY8g==
X-Received: by 2002:a5d:5247:0:b0:32c:d7e6:4054 with SMTP id
 k7-20020a5d5247000000b0032cd7e64054mr1935392wrc.53.1697739855084; 
 Thu, 19 Oct 2023 11:24:15 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adfa35c000000b0031ad5fb5a0fsm5045789wrb.58.2023.10.19.11.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:14 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, qemu-block@nongnu.org
Subject: [PULL v2 68/78] vhost: move and rename the conn retry times
Message-ID: <0c4f0681bc8e9d18d6d247bbf53754bb09c114e0.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


