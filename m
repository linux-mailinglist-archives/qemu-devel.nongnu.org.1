Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 746BA7B9A56
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:46:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFHb-0004U7-Ht; Wed, 04 Oct 2023 23:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHL-00048x-IU
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHI-0000Bs-RG
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=px/NIHIU5yx2rY5OSFOtW4f6DdL5xcRfB3kvq/fso7Y=;
 b=MCQ5Yiz/IokpphMy67codvWZbSwYlFhp7RMQOdjGKn1myE3l+pIg67IjIM8BHFEost5U4g
 DAk/mfC78PGAUQwSI0TAf/vNdog/f7F7CmklCpnG+zXbzpG7phQ4O/Nzu5Gr6xtZDmKQxR
 LEXIzrbaIViuO6BBXbGa92sdNSFGqFo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-rYDFiNFPP9Ok6_019dE7PA-1; Wed, 04 Oct 2023 23:43:49 -0400
X-MC-Unique: rYDFiNFPP9Ok6_019dE7PA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40652e8cb57so3848105e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477428; x=1697082228;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=px/NIHIU5yx2rY5OSFOtW4f6DdL5xcRfB3kvq/fso7Y=;
 b=eD2UkUWHqvKV2H3qtoPk5nVUeESurlGOr8az54nyqMv0NJgwiQbUUFpRUV0+T0ADSR
 85NdgFSVQYHFNdhgeZIC/hQ/pPJ36qYsPvBcsGapdctECdDX5ExpEaEVehuFiRkBA3M9
 kkomwl3TzJRv4dsGf98lDtaiER9nS38Sh9ZdnFYf5Ui+H0jaUNCqTCYFyGuq21kWoHjI
 Go3QXcB1sxSLfQX6LfJkc757g5bqw+3JV4ym+evMm06R6Yll1Up27OibbmPdalaSh/B0
 9wP4jQxL8EXKHVIp/tbie8i5AVqqd3rrGV788rxkkNZ0xkR4K0KSQmlqt4iI7aYT5dkO
 /O4g==
X-Gm-Message-State: AOJu0YwsJIRUqMd3eZnbSi8Z73Kzve4xz5UkVtgZdK3AA7ghsxdcyorv
 954gxuDLvX5vNi7rJTf5H0lKS9dfl62nmeGJ0JSTTBX+aZmxc1ybuM2wd5xYitjlJZ5CRxjZdmK
 2yCLwH9HyQNqLGPRuW3hiKidsJMHYMehrwZ8l/1o9KNNKoldqAL2Da20/RvLVL/DVgjNa
X-Received: by 2002:a05:600c:ad6:b0:3fc:7eb:1119 with SMTP id
 c22-20020a05600c0ad600b003fc07eb1119mr3740490wmr.15.1696477428067; 
 Wed, 04 Oct 2023 20:43:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERUUrgccmSFpvnvagau9oaRIGrdt7ehuc984oR4/yUgbtQkdbbku+CDbdi31GWPM5vKvbl5g==
X-Received: by 2002:a05:600c:ad6:b0:3fc:7eb:1119 with SMTP id
 c22-20020a05600c0ad600b003fc07eb1119mr3740474wmr.15.1696477427683; 
 Wed, 04 Oct 2023 20:43:47 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 fl16-20020a05600c0b9000b00406847c988asm2727261wmb.12.2023.10.04.20.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:43:46 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:43:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 20/53] vhost: Add count argument to vhost_svq_poll()
Message-ID: <b0de17a2e28de477e09e77a587fcbeafbbc897c4.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hawkins Jiawei <yin31149@gmail.com>

Next patches in this series will no longer perform an
immediate poll and check of the device's used buffers
for each CVQ state load command. Instead, they will
send CVQ state load commands in parallel by polling
multiple pending buffers at once.

To achieve this, this patch refactoring vhost_svq_poll()
to accept a new argument `num`, which allows vhost_svq_poll()
to wait for the device to use multiple elements,
rather than polling for a single element.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <950b3bfcfc5d446168b9d6a249d554a013a691d4.1693287885.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.h |  2 +-
 hw/virtio/vhost-shadow-virtqueue.c | 36 ++++++++++++++++++------------
 net/vhost-vdpa.c                   |  2 +-
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 6efe051a70..5bce67837b 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -119,7 +119,7 @@ void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
 int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
                   size_t out_num, const struct iovec *in_sg, size_t in_num,
                   VirtQueueElement *elem);
-size_t vhost_svq_poll(VhostShadowVirtqueue *svq);
+size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num);
 
 void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd);
 void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd);
diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 49e5aed931..e731b1d2ea 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -514,29 +514,37 @@ static void vhost_svq_flush(VhostShadowVirtqueue *svq,
 }
 
 /**
- * Poll the SVQ for one device used buffer.
+ * Poll the SVQ to wait for the device to use the specified number
+ * of elements and return the total length written by the device.
  *
  * This function race with main event loop SVQ polling, so extra
  * synchronization is needed.
  *
- * Return the length written by the device.
+ * @svq: The svq
+ * @num: The number of elements that need to be used
  */
-size_t vhost_svq_poll(VhostShadowVirtqueue *svq)
+size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
 {
-    int64_t start_us = g_get_monotonic_time();
-    uint32_t len = 0;
+    size_t len = 0;
+    uint32_t r;
 
-    do {
-        if (vhost_svq_more_used(svq)) {
-            break;
-        }
+    while (num--) {
+        int64_t start_us = g_get_monotonic_time();
 
-        if (unlikely(g_get_monotonic_time() - start_us > 10e6)) {
-            return 0;
-        }
-    } while (true);
+        do {
+            if (vhost_svq_more_used(svq)) {
+                break;
+            }
+
+            if (unlikely(g_get_monotonic_time() - start_us > 10e6)) {
+                return len;
+            }
+        } while (true);
+
+        vhost_svq_get_buf(svq, &r);
+        len += r;
+    }
 
-    vhost_svq_get_buf(svq, &len);
     return len;
 }
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 90beda42e0..5808d1b60c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -645,7 +645,7 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_len,
      * descriptor. Also, we need to take the answer before SVQ pulls by itself,
      * when BQL is released
      */
-    return vhost_svq_poll(svq);
+    return vhost_svq_poll(svq, 1);
 }
 
 static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
-- 
MST


