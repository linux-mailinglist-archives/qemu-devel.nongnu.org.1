Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA9E78BE1C
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 07:58:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qarhm-00051R-9I; Tue, 29 Aug 2023 01:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhG-0004ws-7a
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:27 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhB-0002ZM-Qk
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:26 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-26b41112708so2551537a91.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 22:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693288520; x=1693893320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGqGjKW8GJyKckG6Bxbu9YLJZ6tT1uqiiMBtfQmiWrA=;
 b=WTEmoohPyFE7PYs3Iblvwl2JOtijdVbniez45k/QCuj2PkXTfO1wro1oaBZ/MY5lQ0
 Ki6RSXHcSZpjahDFfEFO/74zHd1md9tfpvYMcfx7dNzIe8kSRjZcfqd4HjMmGJTLjLU3
 uZMPksDsdrZ7+GDlSF4kpQLijFd6b/mgZqQYF5tlZY4DJyeNqBfu6xgtDM/zj+usgviV
 QmMa/R0Se5SiEoSfBUnapZrvVPOC2p5pg29EnPwu96N04bAq0lFfUrSjjQXHf9PlL4Kc
 D6Nn6shlJ9E9qjL6/VyA74Kf3Qnb/UrpSmnxRm8BXjQmJw/VslQi0LQsTUwvWRMa7kny
 LufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693288520; x=1693893320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGqGjKW8GJyKckG6Bxbu9YLJZ6tT1uqiiMBtfQmiWrA=;
 b=Es1Y/Yvy6Bdqq1ROhC43nvAEUeX/EU2a7xhYQOI3Vn+1B6CrPkDq3mJSFThgyURWsx
 wcTPu6gDYR1RytWqdKGnJypMJT6U6sngcjS4lB8mecCbsYIkCXG7CbI4G6Nt9De+ZL3O
 ITpZ+9ZNKUVFSLclEU7qdm4qksmVY35+GTtFq37NwqR2+1Yt50E/wOfkAeVUZqOKBsm3
 kyUR25nuIf9IfzdcW7chWPQLCHgJ7+iwEZKfMsQmbMxq35ejh0AcymqttHopEDrzzMeb
 wmVzBzOdiCIbdPtlGKuC256OBXfEglnv7+hWilEdS8PdfndBlqoGNYXpWhnYyp+pB8E2
 ZIkg==
X-Gm-Message-State: AOJu0YyHDnQ7t7zuvYhJsdJuP0QEv8Z2HCbi5I0kSnFrGQ6C6hUelaCv
 7vS6vkKf6IiBmLR6JzNL0SM=
X-Google-Smtp-Source: AGHT+IGAG0LBK9pFPpdROa8m2VtIPG9l2mca4l0b6LVJ0q9c4JnyCqiTsdU6ZcSGsr3QmLEIQC3QfA==
X-Received: by 2002:a17:90b:14d:b0:26d:17d6:399d with SMTP id
 em13-20020a17090b014d00b0026d17d6399dmr26922805pjb.38.1693288519866; 
 Mon, 28 Aug 2023 22:55:19 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 j23-20020a17090ae61700b002696aeb72e5sm10119770pjy.2.2023.08.28.22.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 22:55:19 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, leiyang@redhat.com,
 18801353760@163.com
Subject: [PATCH v4 2/8] vdpa: Use iovec for vhost_vdpa_net_cvq_add()
Date: Tue, 29 Aug 2023 13:54:44 +0800
Message-Id: <5e090c2af922192f5897ba7072df4d9e4754e1e0.1693287885.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693287885.git.yin31149@gmail.com>
References: <cover.1693287885.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x1033.google.com
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
---
v4:
  - split `in` to `vdpa_in` and `model_in` instead of reusing `in`
in vhost_vdpa_net_handle_ctrl_avail() suggested by Eugenio

v3: https://lore.kernel.org/all/b1d473772ec4bcb254ab0d12430c9b1efe758606.1689748694.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3acda8591a..a875767ee9 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -596,22 +596,14 @@ static void vhost_vdpa_net_cvq_stop(NetClientState *nc)
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
@@ -637,6 +629,15 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
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
 
@@ -647,8 +648,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
     iov_to_buf(data_sg, data_num, 0,
                s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
 
-    return vhost_vdpa_net_cvq_add(s, data_size + sizeof(ctrl),
-                                  sizeof(virtio_net_ctrl_ack));
+    return vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
 }
 
 static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
@@ -1222,10 +1222,15 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
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
@@ -1259,7 +1264,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
             goto out;
         }
     } else {
-        dev_written = vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(status));
+        dev_written = vhost_vdpa_net_cvq_add(s, &out, 1, &vdpa_in, 1);
         if (unlikely(dev_written < 0)) {
             goto out;
         }
@@ -1275,7 +1280,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
     }
 
     status = VIRTIO_NET_ERR;
-    virtio_net_handle_ctrl_iov(svq->vdev, &in, 1, &out, 1);
+    virtio_net_handle_ctrl_iov(svq->vdev, &model_in, 1, &out, 1);
     if (status != VIRTIO_NET_OK) {
         error_report("Bad CVQ processing in model");
     }
-- 
2.25.1


