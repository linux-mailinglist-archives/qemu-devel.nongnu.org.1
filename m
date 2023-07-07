Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBB174B44C
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:28:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnNJ-0000da-Vw; Fri, 07 Jul 2023 11:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnNH-0000a6-O8
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:59 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnNE-00077H-H8
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:58 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6687096c6ddso1269240b3a.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688743675; x=1691335675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qd7RgTKYTk7V0UIptPykhZEpoDmFVii1d1O8+wOy5+g=;
 b=aZgle8yWYZFo79b4yuE5u6DMS55DmELySsCF9AbZnvLIFegDKm+gW5dcEHL8heqCmq
 wDKrOCdWNeMd4aALCaYR8NIce1vRb7LGf0RmmpCL0dOg3hVk0OT2vx4rH+aIHnWgoxU6
 Xd4Nx8fY6ypopb3fOhp9YUjQCSCgIkTHXRUdEBBVY2mDYiWzcG3bZSNeO7Kr2Z+jb4JU
 5fBilj0gbDfOlzWSo6QhleExq+nEKalOk4r39Oi8sF762NphYonaf526Z2Ja3iRLHGXy
 QiYbC96AxD4kGdGx+1Ya3IHNi8+9UhPju+SXRMZDFMyqK4B7XFjYJWHy5ImWSoNgUmsd
 K5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743675; x=1691335675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qd7RgTKYTk7V0UIptPykhZEpoDmFVii1d1O8+wOy5+g=;
 b=RU9qwJt2V9Pw92c2QUtO4DvZHbfUS2CrhYJ1TtcOI4reKa+td+4FI+Y5LhtVEc9aws
 SJDQJj2zRG5SAErHB878t+wIPMl9b9FeCqmVAujRfxSodyZazZMzBBx81IHEMP91IDBR
 75ZzJz9APmMj6yCRmAqmCAyxmH+Rw8FOwXtMcBJ7O+EtmUIcJbGSzYogQXmFxgVIIyCF
 Ws1kNsm+WF0BTGIj4+jOKU2poOGWKWzRjYHScjAs+W7E99vtrTJAinj8ABkZ+HFLUnOd
 HKCVxz1bL0nC9IPN7MUhWe1KBeWI+m9ysUjda8flxcXevfVBK595YN7HRjgX8HRWc6dC
 pkHg==
X-Gm-Message-State: ABy/qLa06V57UI7ge6xnK+yBngRvcaSgi2Y2yU/MhnDo0pJbuxerbnuU
 ebwHbk5P+W9qCJEBLTbalHE=
X-Google-Smtp-Source: APBJJlGzLixN4YlhKWC9giFzXVVOIAf7YL6q7bgDuBc57hgHsSAZUMXvxwHud3P/ca+ZystO6OH5sQ==
X-Received: by 2002:a05:6a00:39a2:b0:666:66c0:fd5b with SMTP id
 fi34-20020a056a0039a200b0066666c0fd5bmr5039611pfb.18.1688743674829; 
 Fri, 07 Jul 2023 08:27:54 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 v7-20020a62a507000000b0063d24fcc2b7sm3057080pfm.1.2023.07.07.08.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 08:27:54 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 6/7] vdpa: Avoid forwarding large CVQ command failures
Date: Fri,  7 Jul 2023 23:27:33 +0800
Message-Id: <267e15e4eed2d7aeb9887f193da99a13d22a2f1d.1688743107.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688743107.git.yin31149@gmail.com>
References: <cover.1688743107.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42c.google.com
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

Due to the size limitation of the out buffer sent to the vdpa device,
which is determined by vhost_vdpa_net_cvq_cmd_len(), excessive CVQ
command is truncated in QEMU. As a result, the vdpa device rejects
this flawd CVQ command.

However, the problem is that, the VIRTIO_NET_CTRL_MAC_TABLE_SET
CVQ command has a variable length, which may exceed
vhost_vdpa_net_cvq_cmd_len() if the guest sets more than
`MAC_TABLE_ENTRIES` MAC addresses for the filter table.

This patch solves this problem by following steps:

  * Increase the out buffer size to vhost_vdpa_net_cvq_cmd_page_len(),
which represents the size of the buffer that is allocated and mmaped.
This ensures that everything works correctly as long as the guest
sets fewer than `(vhost_vdpa_net_cvq_cmd_page_len() -
sizeof(struct virtio_net_ctrl_hdr)
- 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC addresses.
    Considering the highly unlikely scenario for the guest setting
more than that number of MAC addresses for the filter table, this
should work fine for the majority of cases.

  * If the CVQ command exceeds vhost_vdpa_net_cvq_cmd_page_len(),
instead of directly sending this CVQ command, QEMU should send
a VIRTIO_NET_CTRL_RX_PROMISC CVQ command to vdpa device. Addtionally,
a fake VIRTIO_NET_CTRL_MAC_TABLE_SET command including
(`MAC_TABLE_ENTRIES` + 1) non-multicast MAC addresses and
(`MAC_TABLE_ENTRIES` + 1) multicast MAC addresses should be provided
to the device model.
    By doing so, the vdpa device turns promiscuous mode on, aligning
with the VirtIO standard. The device model marks
`n->mac_table.uni_overflow` and `n->mac_table.multi_overflow`,
which aligns with the state of the vdpa device.

Note that the bug cannot be triggered at the moment, since
VIRTIO_NET_F_CTRL_RX feature is not enabled for SVQ.

Fixes: 7a7f87e94c ("vdpa: Move command buffers map to start of net device")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a84eb088a0..a4ff6c52b7 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -916,6 +916,148 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .check_peer_type = vhost_vdpa_check_peer_type,
 };
 
+/*
+ * Forward the excessive VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command to
+ * vdpa device.
+ *
+ * Considering that QEMU cannot send the entire filter table to the
+ * vdpa device, it should send the VIRTIO_NET_CTRL_RX_PROMISC CVQ
+ * command to enable promiscuous mode to receive all packets,
+ * according to VirtIO standard, "Since there are no guarantees,
+ * it can use a hash filter or silently switch to allmulti or
+ * promiscuous mode if it is given too many addresses.".
+ *
+ * Since QEMU ignores MAC addresses beyond `MAC_TABLE_ENTRIES` and
+ * marks `n->mac_table.x_overflow` accordingly, it should have
+ * the same effect on the device model to receive
+ * (`MAC_TABLE_ENTRIES` + 1) or more non-multicast MAC addresses.
+ * The same applies to multicast MAC addresses.
+ *
+ * Therefore, QEMU can provide the device model with a fake
+ * VIRTIO_NET_CTRL_MAC_TABLE_SET command with (`MAC_TABLE_ENTRIES` + 1)
+ * non-multicast MAC addresses and (`MAC_TABLE_ENTRIES` + 1) multicast
+ * MAC addresses. This ensures that the device model marks
+ * `n->mac_table.uni_overflow` and `n->mac_table.multi_overflow`,
+ * allowing all packets to be received, which aligns with the
+ * state of the vdpa device.
+ */
+static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
+                                                       VirtQueueElement *elem,
+                                                       struct iovec *out)
+{
+    struct virtio_net_ctrl_mac mac_data, *mac_ptr;
+    struct virtio_net_ctrl_hdr *hdr_ptr;
+    uint32_t cursor;
+    ssize_t r;
+
+    /* parse the non-multicast MAC address entries from CVQ command */
+    cursor = sizeof(*hdr_ptr);
+    r = iov_to_buf(elem->out_sg, elem->out_num, cursor,
+                   &mac_data, sizeof(mac_data));
+    if (unlikely(r != sizeof(mac_data))) {
+        /*
+         * If the CVQ command is invalid, we should simulate the vdpa device
+         * to reject the VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command
+         */
+        *s->status = VIRTIO_NET_ERR;
+        return sizeof(*s->status);
+    }
+    cursor += sizeof(mac_data) + le32_to_cpu(mac_data.entries) * ETH_ALEN;
+
+    /* parse the multicast MAC address entries from CVQ command */
+    r = iov_to_buf(elem->out_sg, elem->out_num, cursor,
+                   &mac_data, sizeof(mac_data));
+    if (r != sizeof(mac_data)) {
+        /*
+         * If the CVQ command is invalid, we should simulate the vdpa device
+         * to reject the VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command
+         */
+        *s->status = VIRTIO_NET_ERR;
+        return sizeof(*s->status);
+    }
+    cursor += sizeof(mac_data) + le32_to_cpu(mac_data.entries) * ETH_ALEN;
+
+    /* validate the CVQ command */
+    if (iov_size(elem->out_sg, elem->out_num) != cursor) {
+        /*
+         * If the CVQ command is invalid, we should simulate the vdpa device
+         * to reject the VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command
+         */
+        *s->status = VIRTIO_NET_ERR;
+        return sizeof(*s->status);
+    }
+
+    /*
+     * According to VirtIO standard, "Since there are no guarantees,
+     * it can use a hash filter or silently switch to allmulti or
+     * promiscuous mode if it is given too many addresses.".
+     *
+     * Therefore, considering that QEMU is unable to send the entire
+     * filter table to the vdpa device, it should send the
+     * VIRTIO_NET_CTRL_RX_PROMISC CVQ command to enable promiscuous mode
+     */
+    r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 1);
+    if (unlikely(r < 0)) {
+        return r;
+    }
+    if (*s->status != VIRTIO_NET_OK) {
+        return sizeof(*s->status);
+    }
+
+    /*
+     * QEMU should also send a fake VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ
+     * command to the device model, including (`MAC_TABLE_ENTRIES` + 1)
+     * non-multicast MAC addresses and (`MAC_TABLE_ENTRIES` + 1)
+     * multicast MAC addresses.
+     *
+     * By doing so, the device model can mark `n->mac_table.uni_overflow`
+     * and `n->mac_table.multi_overflow`, enabling all packets to be
+     * received, which aligns with the state of the vdpa device.
+     */
+    cursor = 0;
+    uint32_t fake_uni_entries = MAC_TABLE_ENTRIES + 1,
+             fake_mul_entries = MAC_TABLE_ENTRIES + 1,
+             fake_cvq_size = sizeof(struct virtio_net_ctrl_hdr) +
+                             sizeof(mac_data) + fake_uni_entries * ETH_ALEN +
+                             sizeof(mac_data) + fake_mul_entries * ETH_ALEN;
+
+    assert(fake_cvq_size < vhost_vdpa_net_cvq_cmd_page_len());
+    out->iov_len = fake_cvq_size;
+
+    /* pack the header for fake CVQ command */
+    hdr_ptr = out->iov_base + cursor;
+    hdr_ptr->class = VIRTIO_NET_CTRL_MAC;
+    hdr_ptr->cmd = VIRTIO_NET_CTRL_MAC_TABLE_SET;
+    cursor += sizeof(*hdr_ptr);
+
+    /*
+     * Pack the non-multicast MAC addresses part for fake CVQ command.
+     *
+     * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
+     * addresses provieded in CVQ command. Therefore, only the entries
+     * field need to be prepared in the CVQ command.
+     */
+    mac_ptr = out->iov_base + cursor;
+    mac_ptr->entries = cpu_to_le32(fake_uni_entries);
+    cursor += sizeof(*mac_ptr) + fake_uni_entries * ETH_ALEN;
+
+    /*
+     * Pack the multicast MAC addresses part for fake CVQ command.
+     *
+     * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
+     * addresses provieded in CVQ command. Therefore, only the entries
+     * field need to be prepared in the CVQ command.
+     */
+    mac_ptr = out->iov_base + cursor;
+    mac_ptr->entries = cpu_to_le32(fake_mul_entries);
+
+    /*
+     * Simulating QEMU poll a vdpa device used buffer
+     * for VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command
+     */
+    return sizeof(*s->status);
+}
+
 /**
  * Validate and copy control virtqueue commands.
  *
@@ -943,7 +1085,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
 
     out.iov_len = iov_to_buf(elem->out_sg, elem->out_num, 0,
                              s->cvq_cmd_out_buffer,
-                             vhost_vdpa_net_cvq_cmd_len());
+                             vhost_vdpa_net_cvq_cmd_page_len());
 
     ctrl = s->cvq_cmd_out_buffer;
     if (ctrl->class == VIRTIO_NET_CTRL_ANNOUNCE) {
@@ -953,6 +1095,24 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
          */
         dev_written = sizeof(status);
         *s->status = VIRTIO_NET_OK;
+    } else if (unlikely(ctrl->class == VIRTIO_NET_CTRL_MAC &&
+                        ctrl->cmd == VIRTIO_NET_CTRL_MAC_TABLE_SET &&
+                        iov_size(elem->out_sg, elem->out_num) > out.iov_len)) {
+        /*
+         * Due to the size limitation of the out buffer sent to the vdpa device,
+         * which is determined by vhost_vdpa_net_cvq_cmd_page_len(), excessive
+         * MAC addresses set by the driver for the filter table can cause
+         * truncation of the CVQ command in QEMU. As a result, the vdpa device
+         * rejects the flawed CVQ command.
+         *
+         * Therefore, QEMU must handle this situation instead of sending
+         * the CVQ command direclty.
+         */
+        dev_written = vhost_vdpa_net_excessive_mac_filter_cvq_add(s, elem,
+                                                                  &out);
+        if (unlikely(dev_written < 0)) {
+            goto out;
+        }
     } else {
         dev_written = vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(status));
         if (unlikely(dev_written < 0)) {
-- 
2.25.1


