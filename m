Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74257758FAB
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:54:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM20h-0004cA-7H; Wed, 19 Jul 2023 03:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20e-0004be-9n
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:08 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20b-0003Kw-LK
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-67ef5af0ce8so6615135b3a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689753244; x=1692345244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44dnXMtDUhHeXA9lT48wQSwH+ZuRhBQiZncUCa72Y0E=;
 b=n3eyh3579R+nhcGBEqy/1xM7wVgV7OZihShX1jHCr+QrxMnR+a0iXefFXoKaNdaVTI
 C4hpDnjFaUKFZBgSYzXzKmUXJ2H6flGOtxuPANLEXiL2+W9en5iqn7huXRSsTrRfajPu
 ni+U58zYUmgAAr/h3vV+Jd8RQS5f0Dlg2qSUCuPx7fdIGHRgtJIZ7gGlr8wwTyDwJB/D
 n1CEf2LhWo3FZOqVOS6W6k5V6mkioiyWu1d3dJbGUlyZKx3Gs2peVUiQJGMjkXuY4938
 QqtR6XBIDArpw+DmsNW/OVomsvoGfQoViyeWarb8w4rwKYAe1Kdy1yoIT64ICUbmorQc
 1g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689753244; x=1692345244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44dnXMtDUhHeXA9lT48wQSwH+ZuRhBQiZncUCa72Y0E=;
 b=W9xSVcL4vCKTaeeuL0flL7zSZplW8g7I/aV4OxRKR/nvVyuxi9GCItFqRw03zhHazA
 nXnZjdA3t7PVG4v0WS3S7/MVNGJEAuN0IV92IjsFyZd4rbW09gNRT/FmEiavBN1n4YwD
 2PdhMmVT4JU0T4J0t8pahcIj6pu+ZnFXGhaRu0Ro9E6VIGb5uwIbXR0qqLyMRBT8KcOE
 ValnYcGN4QcC/frbuoD0YDL3Vsn1zgDU87KSry1+BS3ty6xHv7Ci1hblyo1Hcu2/3vI4
 JR73KoE6Ro7DTXDgb08V5LZmnjg4//4fRGnv3uObt+VrFJDdPjYOZ1pbY+7YnLIthKcM
 J4Yw==
X-Gm-Message-State: ABy/qLb8ei46D36RX7X2pxJ4B6XafxG/iw1XT8I0z2SPJjHrM5x9qYh7
 ZB/WKZoCcPUxtGw6OiyNttI=
X-Google-Smtp-Source: APBJJlEt5ehx3Qrpf4/NXGZJTp6IPM2m6KApIE+OctgmlMPBdEuLZPp3ChK/5TJxBw8P2+K3LzmdPw==
X-Received: by 2002:a05:6a20:9684:b0:11f:c1a1:8c with SMTP id
 hp4-20020a056a20968400b0011fc1a1008cmr1430773pzc.54.1689753244055; 
 Wed, 19 Jul 2023 00:54:04 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 k67-20020a632446000000b0056001f43726sm2865791pgk.92.2023.07.19.00.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:54:03 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 1/8] vhost: Add argument to vhost_svq_poll()
Date: Wed, 19 Jul 2023 15:53:46 +0800
Message-Id: <77c1d8b358644b49992e6dbca55a5c9e62c941a8.1689748694.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689748694.git.yin31149@gmail.com>
References: <cover.1689748694.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
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
index dfd271c456..d1dd140bf6 100644
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


