Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 182097C7FEF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:21:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDFO-0006sH-P7; Fri, 13 Oct 2023 04:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDF8-0006eG-J1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:10:00 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDF6-0001XT-MW
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:09:58 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57bab4e9e1aso1054060eaf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697184595; x=1697789395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBBVQtIzyB6lcv+H22SmqBtB6k05lp7dOPID3f7Tk/k=;
 b=Fsny6DIZ36fsEtFfhN55jjoSl7DdGePmvyG7fuYqEPTY2LXq4Tk43acKdVOfdqb7x+
 mCnru5alPvxupswgoMo8SF4peTj+33HRW032+pG0aLWGyPoK+jymPWGpweHHYN4m5zND
 L6pFjBxzoU6FUutN8iyLvqChwnmYnHNJCTotl18CruepkVh2QFSGa9GCgbFkIiddRQSf
 3++fxml41Tcc4y3b3Uamq1jk/+1xnbHay8qvGbuQa0piEYHYE/2VV/EeL7OqRb4KCnf5
 Th6d42xSR3Siq84SBRIuWLdjMtLqb71URMA20UZkU2AKvZ7rraEpT9VfzH4z2FukZAGK
 Gv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184595; x=1697789395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hBBVQtIzyB6lcv+H22SmqBtB6k05lp7dOPID3f7Tk/k=;
 b=UGU1uU9GyOEOBbZc0vNmLjz2Y9Ozy8rp+aNrymxzlrdULC+Og/Qh1sK0O5OdVK8cUl
 WzIXYyCDqlkLdpO9A86hVWthiV3RzRPf8aheuVO+xwi5ZiBR+XLUYacPk5QZC7Evy6do
 4N8tfrZ0liMLYY9I9VG6//qYXZ5PVmdeHZ3dNfVRX0n7cKavd0U8q2VINuSCaCryX/VT
 DMpMygC0NdrRFjCdqhyXkjrjeKSiPH7nAE4qaSmwE80QO2NR2O6eW78/EBUU3hdH807S
 jFXtkH7JInlYZN/XepVf6jh1x+8UpkqZ1jEUEpumsCmdwzY+Y05ew3SLWrSfts4Nq0n5
 +dvA==
X-Gm-Message-State: AOJu0Yw9VhzlNBv+hOAdaSI0Bglf12qH+1ZG60Li9k8Kin/VcH7Jic+S
 Dym4P66hn1lTQwRilw4kNn4=
X-Google-Smtp-Source: AGHT+IG6ixcgG6RKO2/ggEK5TwsP5FG/x0AGoQAlXktZW27BohtHpFyo69DP2vThLPL8dmxIv+HJIw==
X-Received: by 2002:a05:6358:7e49:b0:134:e603:116e with SMTP id
 p9-20020a0563587e4900b00134e603116emr28356192rwm.6.1697184594504; 
 Fri, 13 Oct 2023 01:09:54 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 r19-20020aa78453000000b00688965c5227sm13020573pfn.120.2023.10.13.01.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:09:54 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v5 1/7] vdpa: Use iovec for vhost_vdpa_net_cvq_add()
Date: Fri, 13 Oct 2023 16:09:36 +0800
Message-Id: <8a328f146fb043f34edb75ba6d043d2d6de88f99.1697165821.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697165821.git.yin31149@gmail.com>
References: <cover.1697165821.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=yin31149@gmail.com; helo=mail-oo1-xc32.google.com
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
for each CVQ state load command. Consequently, there
will be multiple pending buffers in the shadow VirtQueue,
making it a must for every control command to have its
own buffer.

To achieve this, this patch refactor vhost_vdpa_net_cvq_add()
to accept `struct iovec`, which eliminates the coupling of
control commands to `s->cvq_cmd_out_buffer` and `s->status`,
allowing them to use their own buffer.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
v5:
  - no change

v4: https://lore.kernel.org/all/5e090c2af922192f5897ba7072df4d9e4754e1e0.1693287885.git.yin31149@gmail.com/
  - split `in` to `vdpa_in` and `model_in` instead of reusing `in`
in vhost_vdpa_net_handle_ctrl_avail() suggested by Eugenio

v3: https://lore.kernel.org/all/b1d473772ec4bcb254ab0d12430c9b1efe758606.1689748694.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 939c984d5b..618758596a 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -618,22 +618,14 @@ static void vhost_vdpa_net_cvq_stop(NetClientState *nc)
     vhost_vdpa_net_client_stop(nc);
 }
 
-static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_len,
-                                      size_t in_len)
+static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s,
+                                    const struct iovec *out_sg, size_t out_num,
+                                    const struct iovec *in_sg, size_t in_num)
 {
-    /* Buffers for the device */
-    const struct iovec out = {
-        .iov_base = s->cvq_cmd_out_buffer,
-        .iov_len = out_len,
-    };
-    const struct iovec in = {
-        .iov_base = s->status,
-        .iov_len = sizeof(virtio_net_ctrl_ack),
-    };
     VhostShadowVirtqueue *svq = g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
     int r;
 
-    r = vhost_svq_add(svq, &out, 1, &in, 1, NULL);
+    r = vhost_svq_add(svq, out_sg, out_num, in_sg, in_num, NULL);
     if (unlikely(r != 0)) {
         if (unlikely(r == -ENOSPC)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device queue\n",
@@ -659,6 +651,15 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
         .cmd = cmd,
     };
     size_t data_size = iov_size(data_sg, data_num);
+    /* Buffers for the device */
+    const struct iovec out = {
+        .iov_base = s->cvq_cmd_out_buffer,
+        .iov_len = sizeof(ctrl) + data_size,
+    };
+    const struct iovec in = {
+        .iov_base = s->status,
+        .iov_len = sizeof(*s->status),
+    };
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
 
@@ -669,8 +670,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
     iov_to_buf(data_sg, data_num, 0,
                s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
 
-    return vhost_vdpa_net_cvq_add(s, data_size + sizeof(ctrl),
-                                  sizeof(virtio_net_ctrl_ack));
+    return vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
 }
 
 static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
@@ -1248,10 +1248,15 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
         .iov_base = s->cvq_cmd_out_buffer,
     };
     /* in buffer used for device model */
-    const struct iovec in = {
+    const struct iovec model_in = {
         .iov_base = &status,
         .iov_len = sizeof(status),
     };
+    /* in buffer used for vdpa device */
+    const struct iovec vdpa_in = {
+        .iov_base = s->status,
+        .iov_len = sizeof(*s->status),
+    };
     ssize_t dev_written = -EINVAL;
 
     out.iov_len = iov_to_buf(elem->out_sg, elem->out_num, 0,
@@ -1285,7 +1290,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
             goto out;
         }
     } else {
-        dev_written = vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(status));
+        dev_written = vhost_vdpa_net_cvq_add(s, &out, 1, &vdpa_in, 1);
         if (unlikely(dev_written < 0)) {
             goto out;
         }
@@ -1301,7 +1306,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
     }
 
     status = VIRTIO_NET_ERR;
-    virtio_net_handle_ctrl_iov(svq->vdev, &in, 1, &out, 1);
+    virtio_net_handle_ctrl_iov(svq->vdev, &model_in, 1, &out, 1);
     if (status != VIRTIO_NET_OK) {
         error_report("Bad CVQ processing in model");
     }
-- 
2.25.1


