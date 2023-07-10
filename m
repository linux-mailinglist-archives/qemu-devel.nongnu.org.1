Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC574E1E7
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:08:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwn-0004Xd-Jy; Mon, 10 Jul 2023 19:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwk-0004Ts-St
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwi-0004ua-Pd
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NFfTVSt523EXMOANw1qtqt3SiBZHXYJa2ZzCOv5S19A=;
 b=ftNg+F+Y97/t2cqiG2YQTkPmdI1lHZvLXK7cam2RHLrvIHrmuXzth1+dKimYr83hKE0yL2
 cKWAnKTJWMpQOzCivVh6YhAynx0QL3pX5EksbxqhsmEBP8zlAeDl9d44A1JFPhxRDliXDC
 dD+Gwd0Pzz6yDzoIcM7FLzKzTSeIOSM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-DBB_zOGjOq67zDFZUn4PzA-1; Mon, 10 Jul 2023 19:05:29 -0400
X-MC-Unique: DBB_zOGjOq67zDFZUn4PzA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fc08035926so10307085e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030327; x=1691622327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFfTVSt523EXMOANw1qtqt3SiBZHXYJa2ZzCOv5S19A=;
 b=lY+aufp1x1pL/hSnsn0d01Bk2sJbi+NMalkecoMN4xGYqQkX0OEORpkBnXlnESqF8w
 w+HaLFY9cdR7NZbJXEN+8eVByWAWc6qERg5OU295hMJkyAnwwyIezVrszTnpoPdPBGx3
 BgxfsWJLVYC9EeIg5+ZvtZyU+U3B1+tnDHlFDDc0SzcBOVzsDwbXqab84Ii3tFIITvNT
 sVQP4AOOkTqaiCf2kh2xZATbspCjkSmln5oBCxREgTcvIBalW4djJkPajs/FxYxo1jhJ
 zcHl5cjTRBt4iYL/oIgyvXwgraO0x4gGPGp15PFd4Kz5NxxlOIxpP3z2PUQZ7KNApksV
 4W7g==
X-Gm-Message-State: ABy/qLZPN0eUzkyinsobjwOWPlegw5mQqFSKP7+S+jm+XJuEK3R1ayoi
 XCA+JP5JJ1x4VBiuarJH9maBKvAbevRpmOM3EIVi56+7O/d1LOkTWQJReSx0+xhwOcPVYIV6BZT
 Iq7kwhMXZjAOVvNE4Was2U3R+0YTCcvTLU1YQTV3PT2nAleMpF7nDGCeE7zOUvq228AWx
X-Received: by 2002:a05:600c:20c:b0:3fa:aeac:e978 with SMTP id
 12-20020a05600c020c00b003faaeace978mr12983745wmi.0.1689030327568; 
 Mon, 10 Jul 2023 16:05:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGhL5cZ4Le644R0qu2u0pBv9FW0wdavjb6HTKxakQ8D7fionCfWsoIUDZSnYJQ+smRB1oagWg==
X-Received: by 2002:a05:600c:20c:b0:3fa:aeac:e978 with SMTP id
 12-20020a05600c020c00b003faaeace978mr12983734wmi.0.1689030327220; 
 Mon, 10 Jul 2023 16:05:27 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003fbfc61d36asm978132wmr.5.2023.07.10.16.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:26 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 63/66] vdpa: Avoid forwarding large CVQ command failures
Message-ID: <fee364e4b1ad82a78929f3eed114321f77b6f916.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Hawkins Jiawei <yin31149@gmail.com>

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
Message-Id: <267e15e4eed2d7aeb9887f193da99a13d22a2f1d.1688743107.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index eee4b2a09e..7610589a60 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -922,6 +922,148 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
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
@@ -949,7 +1091,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
 
     out.iov_len = iov_to_buf(elem->out_sg, elem->out_num, 0,
                              s->cvq_cmd_out_buffer,
-                             vhost_vdpa_net_cvq_cmd_len());
+                             vhost_vdpa_net_cvq_cmd_page_len());
 
     ctrl = s->cvq_cmd_out_buffer;
     if (ctrl->class == VIRTIO_NET_CTRL_ANNOUNCE) {
@@ -959,6 +1101,24 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
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
MST


