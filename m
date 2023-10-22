Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A587D224C
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:30:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUij-0008El-KK; Sun, 22 Oct 2023 05:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUif-00089h-Um
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUid-0000uM-MP
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mAx5U6tzoPzE/iLbJKJIpH55yxbW14JSXW+iIiHFWOE=;
 b=aPBVmY18kdVYKkPxtlXH6Dsvp4dvw36RJqB9I1rBoRuEiUdiDs7IPMY7ZLL+FGBTzExfZp
 g+AnURw7BY4CRGMEhu8S18aJ/uRKM/9z/JQ/kdTvhyPfYFeO0M6cdJiI4hZnHT96fEduxm
 xDH8Sn3aM339vBDrHe7QiSKJIBrU1KQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-CKiT2dOZPmq8N-fVeWGXhw-1; Sun, 22 Oct 2023 05:25:51 -0400
X-MC-Unique: CKiT2dOZPmq8N-fVeWGXhw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507d0e4eedaso2189019e87.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966749; x=1698571549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAx5U6tzoPzE/iLbJKJIpH55yxbW14JSXW+iIiHFWOE=;
 b=HZ7IcoxuUojzdqOBP7WWcVAvB/Aj4qDrypEDg6DvGxSni1WJKdkojOkLEDtPnADHft
 veWFo8wE4JtZks4nx4vJh56zenRuhXFSC0S78N0XHnwbHYYEoyb2bSAyESBGXogSlO99
 C4hYYbbxLOs90PnKz0C58KXjytv8Q6bnjkTBTi/yYonHHN7Rfx4V2aMleKPSc7dvr5Gx
 RLHsLT0ujUGfx1qVF18wmilxAwXXqR6/ocDD9+IzAH/nqUe2euKBYKf8Vb61CiCK90e0
 7+20rUdVA+TRtnrIGmT7iLvjLhJxldE19tkt8J+A0gC2jJx+A5Zwn2Re1LfOlBswvoLr
 aq3g==
X-Gm-Message-State: AOJu0YwBmZedjKlK4+nZ44ycLQOHxdTBNmLmja2xTQumAt1JcbwiW6jA
 kVdi4lLbtNfmcdGuiWfv8g0P3XwES2ynMZxKH2FC1/Dq0hekiOEd7aPFWDjzjnQf8sVYpJvQUW5
 HsWcZwVG3VpT+L2zFOX/uqvYl0kn7G3+GJtoyHNcyb6LZ1PgkpaCrnhxUckuw5ytQgkbK
X-Received: by 2002:ac2:4c0b:0:b0:4fb:911b:4e19 with SMTP id
 t11-20020ac24c0b000000b004fb911b4e19mr4174224lfq.35.1697966749650; 
 Sun, 22 Oct 2023 02:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNYUMiuKJ1DXp2nmYkwzu9Vl0zQjAEadTjm8O/U4kwsCkJ/AJZGbgDRfSt5OR4BMAZ9WLgzg==
X-Received: by 2002:ac2:4c0b:0:b0:4fb:911b:4e19 with SMTP id
 t11-20020ac24c0b000000b004fb911b4e19mr4174211lfq.35.1697966749340; 
 Sun, 22 Oct 2023 02:25:49 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 j13-20020a5d452d000000b0032d8eecf901sm5322104wra.3.2023.10.22.02.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:25:48 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:25:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, qemu-block@nongnu.org
Subject: [PULL v3 52/62] vhost: move and rename the conn retry times
Message-ID: <4dfcc09f48c4f81a9a4e2300065edbe6b589a6ce.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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


