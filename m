Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E772378BE16
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 07:57:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qarhZ-0004x6-Gh; Tue, 29 Aug 2023 01:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhB-0004wX-BJ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:23 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarh8-0002Xc-16
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:21 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34b0f3b792dso14932025ab.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 22:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693288515; x=1693893315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bW9X2gfDq+rHa1NbQsYZnS5A64KvEMz2YU5bZSkWvzE=;
 b=VWS3Z4UUWZ9cNv7E+oaVDpnxfJXQiHd3BgIVPgleqCLGIfbuyN+M02QsmTLyjBkKHq
 2EqlXA3srqKpVUdsrU7tRmqiisyI8Nuf6r4nC7RMC9HByRM2Gz7eKUtPU4ybvhrHxlVa
 O5WfktGK2+Edy0uM4RhnqQVnNKR9rOT7TdBdacIu545qWx1ZO82Vx2k9wGZT9OI2tvWD
 b5Xra+xlXKarsCM+bp2FWYGzyAGb4SIusBgM5M0AMlPvQwmu2DRCOQo3+kyDKqKRxpCV
 N+/1uBXxAvwAmHmbmjLkycrw4WR80sMxRe/cgAWa8FiEKx1BJiHf4QWf8ig61hEX4JM1
 wZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693288515; x=1693893315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bW9X2gfDq+rHa1NbQsYZnS5A64KvEMz2YU5bZSkWvzE=;
 b=d63XtcdGJ1wsLpfbwytAdSzW1JMv+mfD+WxGvyGNKd22+LbHRrkQY28yPmII9xEbIG
 GXWSsGqAXRrn6RJbmmodHY+gtj+26bDgirfaDJ1tjU0/sO6sUTddecFh8iz8jCODAUCY
 PtSmRqjZCf+KOFn2wbYODDfq9tXHDB67nUDCMd+M9oa8wccvtFmzqAjeRF9MrEHT90Cb
 h4H1QMWK2MUajLnuIkKlvujaFxDRxplWZvRYzUSahGaIEe3Phqy5ftP+W7k3gNNuYLWn
 YhUuApjmtZOtVttAonONU73nxEPJCVmQNKR42D7XJbTsZOjSh1MLaFY/8PSskfsONqGP
 YvZw==
X-Gm-Message-State: AOJu0YyeCiv1GcrSDLruBloMzKVM/GsvB9goxMfHa4Yjfi0YW3Pjgy9w
 9Wx1ra4bpQGvOeT25bOHmqA=
X-Google-Smtp-Source: AGHT+IH7+IhZETOX2Il9UxdMRppEQTVkjigAk8PfsLuk0lAniF/hUCH/CFdZZVecyVb8euttZLiJ2w==
X-Received: by 2002:a05:6e02:1c89:b0:340:79ff:c1b6 with SMTP id
 w9-20020a056e021c8900b0034079ffc1b6mr23240631ill.4.1693288514960; 
 Mon, 28 Aug 2023 22:55:14 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 m185-20020a633fc2000000b005642314f05fsm8021175pga.1.2023.08.28.22.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 22:55:14 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, leiyang@redhat.com,
 18801353760@163.com
Subject: [PATCH v4 1/8] vhost: Add count argument to vhost_svq_poll()
Date: Tue, 29 Aug 2023 13:54:43 +0800
Message-Id: <950b3bfcfc5d446168b9d6a249d554a013a691d4.1693287885.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693287885.git.yin31149@gmail.com>
References: <cover.1693287885.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=yin31149@gmail.com; helo=mail-il1-x135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
v4:
  - refactor subject line suggested by Eugenio

v3: https://lore.kernel.org/all/77c1d8b358644b49992e6dbca55a5c9e62c941a8.1689748694.git.yin31149@gmail.com/

 hw/virtio/vhost-shadow-virtqueue.c | 36 ++++++++++++++++++------------
 hw/virtio/vhost-shadow-virtqueue.h |  2 +-
 net/vhost-vdpa.c                   |  2 +-
 3 files changed, 24 insertions(+), 16 deletions(-)

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
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 73e9063fa0..3acda8591a 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -625,7 +625,7 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_len,
      * descriptor. Also, we need to take the answer before SVQ pulls by itself,
      * when BQL is released
      */
-    return vhost_svq_poll(svq);
+    return vhost_svq_poll(svq, 1);
 }
 
 static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
-- 
2.25.1


