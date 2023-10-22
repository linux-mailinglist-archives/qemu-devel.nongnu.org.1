Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA57D2210
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:22:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUev-0008JW-6y; Sun, 22 Oct 2023 05:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUet-0008JI-8u
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUer-00008a-LV
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aub/+wNbCvirFXr2bctIYe5dvlzn9T6vBOGQpLtPcEM=;
 b=VIHeir8tG6TuvSJBaCqyiCiF8aZV5xWyUO4BZVA/QnHKe20cUzah5yxrb9Srwx47MS66AD
 TdKTXP+YaCNiGzKyK6zCePJV9yYkrUBpdj9tY57TOv5b7EgyAWN8v5GgDhc54vKzKceCca
 9wUbuZxaWQ/Bw0NdnG8DBWPkDqSlV8c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-t05i7cn4NySz8bAsS_6CRA-1; Sun, 22 Oct 2023 05:22:02 -0400
X-MC-Unique: t05i7cn4NySz8bAsS_6CRA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32da7983d20so1125556f8f.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966521; x=1698571321;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aub/+wNbCvirFXr2bctIYe5dvlzn9T6vBOGQpLtPcEM=;
 b=QoTe5KpkUcrevt7dD2NtPjoVv8g7AEI3Uf9qMPGRmFcgH2zAaesZuR5J8tAsASYLmi
 9q/TizOLrbb4eSXvqKDwd50iv/Y1gEL5xmSw62tOjQmu62zJDBjxMXHsE8uYFYTEEnEi
 vWwSmjE84UDcojZta+JDuy6nYok35nB3eXdMxKrnxQO1vvybA4YaJ+9HqcaEKJs5e9gZ
 PLClL63+AcG3ZvSaw4BFSaizq9Dbv3TROAUc8leLtZHwjEyaU3JLYIECEzVZppsyhrc/
 hbgyfrESG9MoChd7VXPqsggidTSTeh/L/cdz/U5hINyUTUl8CwSPNoeOvbi8LJXoEgX/
 klyw==
X-Gm-Message-State: AOJu0YwAhStgfLgHEx1MBoENP+Nnlpky426priOV5bLW23uLzIMdwAG1
 x5+xrRz2CX7cUfVdgK61VG8s9IgIGjIFthQK9CluCK2ekG59aFBrkMfMKJLefICfnnUpbp7jNAs
 c4kty7EonsOeJSgMq1IwzamYv/AW2InVjyxlGwQcO5QW/uQ/MTmL/QAZN56UdcJywDobn
X-Received: by 2002:adf:8bdc:0:b0:32d:c65c:933d with SMTP id
 w28-20020adf8bdc000000b0032dc65c933dmr9189791wra.7.1697966521415; 
 Sun, 22 Oct 2023 02:22:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2FarCuUHy/PgJ/lhuXoMVSSZzENKAaM2sMEdmQswTpaeUd9OaCk/W1BUqd3QiMffKGxBrsQ==
X-Received: by 2002:adf:8bdc:0:b0:32d:c65c:933d with SMTP id
 w28-20020adf8bdc000000b0032dc65c933dmr9189776wra.7.1697966521135; 
 Sun, 22 Oct 2023 02:22:01 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c314e00b003fbe4cecc3bsm11347444wmo.16.2023.10.22.02.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:00 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:21:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL v3 01/62] vdpa: Use iovec for vhost_vdpa_net_cvq_add()
Message-ID: <0e6bff0d43bf04c6e7a16c2775879816ca056b3d.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-Id: <8a328f146fb043f34edb75ba6d043d2d6de88f99.1697165821.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
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
MST


