Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 262077B7A95
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUu-0004un-RF; Wed, 04 Oct 2023 04:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUR-0004Ns-DN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUP-0001Hs-Li
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2NPGrQYFO7suu/6rLXZ26kV9f2KwiOFOwW2bXOoSQ4=;
 b=Lm9VjHrOpLqRlj3rux7uL/QEtV/R2+RdJ1C1rp/AkHSNST1PPS7T9a1VixKR0TgFEyBDFJ
 fgepcZhBOespSdDbrNBoW7FGpi/BAWbgcfxPdZcMQSuH1NT6B5lDfEvFYHUJicq2sMbBos
 pGldLS+rNmoV2y5Hk+ypXykB4L41vJk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-5Uqg9ke7MayZ7x0mekm9Pw-1; Wed, 04 Oct 2023 04:44:15 -0400
X-MC-Unique: 5Uqg9ke7MayZ7x0mekm9Pw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-504319087d9so1781114e87.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409053; x=1697013853;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C2NPGrQYFO7suu/6rLXZ26kV9f2KwiOFOwW2bXOoSQ4=;
 b=QsXOicfNjiOd1DJiyLOdP9kFyTNXJdbbMwW6XSzCn2rnei2yAw/ejOQV80NTaUZ1+l
 9pElhMF+p/K6ZO5+UTIJ+dQ35cTpnAKAoR/CtwDzzXH17FiNmQY7xE6kvSeMAAa8ia6W
 ctqKME5GjbxYyRjwL9adUjucbaM8HqFy4+pHYf774A1gy8J3wTRBNDsR7l2sPyxPMrmO
 NsQN1kbK4IllEWiY051f5r8LbyXaX2+xL6I4e2GorBAQhrrkGe//AKtL6wBHDC8yKGxf
 5xOgkwl5HuExjoQpiR+ucjviKYav2DZ7ZYaKRRoJ6aJu2wCoxQH9qnVb0KCfsE82sMmV
 v12Q==
X-Gm-Message-State: AOJu0Yxg90og3O5jvJH0kILRyV5UptoSK+mSy0w6N1vlfGqLTFuBX7KH
 DbRH/P+ztM7nL5pKuvMwGMJ5wb/fZJhcSFLUCRU11oHzf6oH9oUYESgUlj7/mc7I11o4kO9Xbo+
 ARcUUUT2tYc/LJVhA1NrML9/kC/nlEHSzNqIZZyrqyZBpcIARlg6nm8JV39ShdWfcLrp0
X-Received: by 2002:a05:6512:532:b0:505:7113:1d12 with SMTP id
 o18-20020a056512053200b0050571131d12mr1165751lfc.3.1696409053562; 
 Wed, 04 Oct 2023 01:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRStNm7A7RGV3ZOF9OmKZc0xc6TiTBPolN9KgYkG/EnEhA6i8GhHnPBHenXAH0OlTYFMqjLQ==
X-Received: by 2002:a05:6512:532:b0:505:7113:1d12 with SMTP id
 o18-20020a056512053200b0050571131d12mr1165737lfc.3.1696409053231; 
 Wed, 04 Oct 2023 01:44:13 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 x16-20020a05600c2a5000b00405c7591b09sm936813wme.35.2023.10.04.01.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:12 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 20/63] vhost: Add count argument to vhost_svq_poll()
Message-ID: <c3790ad6d2ca17420051ee69597e28805de829e9.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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


