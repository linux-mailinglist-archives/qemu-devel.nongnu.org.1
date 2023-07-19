Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B01AA758FB6
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:55:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM20o-0004jl-Fk; Wed, 19 Jul 2023 03:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20i-0004eZ-2P
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20g-0003MO-9y
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:11 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-666eef03ebdso4397565b3a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689753248; x=1692345248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQZe+3Ij+Tfx5OUTUv/4byPqpfQF2gQ9QsUZav2/M0A=;
 b=VdgUet2TCT08Gb793Mjmm7WaUcZqRnYEnoV2mFFOeDjZKjYAPJvQDWge/uvNzYU+Aa
 2h6G2Wcm851dnjUI5B6i8d8xzqW2p3QY3s3z0bBBwvuGvmMFcxOaP3BiNivFE0RPz1TA
 GUaAP151jbkJPKkLMT4Agx4OtQjwJLPUSl5l/SF4S0LUoIamtvz0woTwRSXeQcS6PBCa
 Whotpn2QMGlGg2JXyqwtqWGSMxVk9fov55mZyrKKNng/E9aofbpJ0PAsFk33oydr/WT9
 itSXc1Ck+Ry1shzwewHrNLsNKFGakPOy6YXmbpqbOva/UInT1IeSXk/FZtORFe9X9Sbg
 ZECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689753248; x=1692345248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQZe+3Ij+Tfx5OUTUv/4byPqpfQF2gQ9QsUZav2/M0A=;
 b=gFXsQhUmAfYzxkgFJyKhs1ynwKuMTw03NiTlEH9VGt6pT8W4dKK1xI/WB0F9Pj0H7G
 8oEV8HM85SJAgC6in/2v1bjnmEl9DvdFP8cDrxbZsiijz6RrJTFiNe1lRW3lmV+nxoT/
 UTpcSaoz/fpx6h6MbrtR73d+g2y3JVzbpQNj/Ac+AtrAyCXU1E9gm571hXdjEu3g1ESO
 BRkcG0NjDlMAFE//Uhf7Aa2eZ7PhZLA59X/vYjM1AsOQ7xiEEcOSTc3coKIBm32kAs32
 aGEx64Pgd3kOJ0ytspEuE7uii6Lnoexi0+bt2qG33aaaa9szRswB+pV1fos11bZdfP+e
 Is4g==
X-Gm-Message-State: ABy/qLaJ0IIqGpCh/L6HwzYU9bBEUy0UpV8CXZwLMYcIT51pKuJyLy/I
 f1jNgOEK6zUtmetAF6BBpuW+anfhkuLoFw==
X-Google-Smtp-Source: APBJJlGKPuyFs85ql0g7vMjtmV8ThfxA832UXY4EDJQ8N8vC5MGFKBV2o5zSs/HlFD8O0zBBUCVQkg==
X-Received: by 2002:a05:6a20:12ca:b0:135:8a04:9045 with SMTP id
 v10-20020a056a2012ca00b001358a049045mr4362331pzg.1.1689753248328; 
 Wed, 19 Jul 2023 00:54:08 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 j24-20020aa78d18000000b006732786b5f1sm2638962pfe.213.2023.07.19.00.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:54:08 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 2/8] vdpa: Use iovec for vhost_vdpa_net_cvq_add()
Date: Wed, 19 Jul 2023 15:53:47 +0800
Message-Id: <b1d473772ec4bcb254ab0d12430c9b1efe758606.1689748694.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689748694.git.yin31149@gmail.com>
References: <cover.1689748694.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x429.google.com
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
 net/vhost-vdpa.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index d1dd140bf6..6b16c8ece0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -596,22 +596,14 @@ static void vhost_vdpa_net_cvq_stop(NetClientState *nc)
     vhost_vdpa_net_client_stop(nc);
 }
 
-static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_len,
-                                      size_t in_len)
+static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s,
+                                      struct iovec *out_sg, size_t out_num,
+                                      struct iovec *in_sg, size_t in_num)
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
+    struct iovec out = {
+        .iov_base = s->cvq_cmd_out_buffer,
+        .iov_len = sizeof(ctrl) + data_size,
+    };
+    struct iovec in = {
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
@@ -1222,9 +1222,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
     struct iovec out = {
         .iov_base = s->cvq_cmd_out_buffer,
     };
-    /* in buffer used for device model */
-    const struct iovec in = {
-        .iov_base = &status,
+    struct iovec in = {
         .iov_len = sizeof(status),
     };
     ssize_t dev_written = -EINVAL;
@@ -1232,6 +1230,8 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
     out.iov_len = iov_to_buf(elem->out_sg, elem->out_num, 0,
                              s->cvq_cmd_out_buffer,
                              vhost_vdpa_net_cvq_cmd_page_len());
+    /* In buffer used for the vdpa device */
+    in.iov_base = s->status;
 
     ctrl = s->cvq_cmd_out_buffer;
     if (ctrl->class == VIRTIO_NET_CTRL_ANNOUNCE) {
@@ -1260,7 +1260,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
             goto out;
         }
     } else {
-        dev_written = vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(status));
+        dev_written = vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
         if (unlikely(dev_written < 0)) {
             goto out;
         }
@@ -1276,6 +1276,8 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
     }
 
     status = VIRTIO_NET_ERR;
+    /* In buffer used for the device model */
+    in.iov_base = &status;
     virtio_net_handle_ctrl_iov(svq->vdev, &in, 1, &out, 1);
     if (status != VIRTIO_NET_OK) {
         error_report("Bad CVQ processing in model");
-- 
2.25.1


