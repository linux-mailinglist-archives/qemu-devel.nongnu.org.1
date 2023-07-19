Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E9758FB0
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:54:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM20u-0005AX-2y; Wed, 19 Jul 2023 03:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20r-00054P-CC
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20p-0003NI-Q5
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:21 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b9c5e07c1bso52119775ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689753258; x=1692345258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1AR3/MDpipxhoPzV6bjNpu4TYaX+Mc8H1OEub4GIXs=;
 b=WgRe7+E9mgqhAAbxkLAISMm5H+IzXLol7EgX50QnHYRAYUUMs+UY8wMyXOCOF4gyTr
 Bbj/19I017ynfcKJcAFSQ0WfBUINt/L+FB1Wbx4y1ZjxaRr3GFe9vliWlzxcQYswlfzW
 FvkI554ne06uNvL9Qx0mkRBYib29shkHMZfNk5hEooHTaiHk2jOxWWwe9IM99KZHvjJM
 OFMa7+cEI0PjA0HriJM0Zic7zZC+vth1sN3bM3kPG9uUnz3fr1PeVvhnhCUeaTFYU8fU
 vtOagSxIm9TBsfMjwvDxTeg183Nc/pVXeIZJCHgB8+bUznCiakfub0shwZojdLQo5DqO
 IKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689753258; x=1692345258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1AR3/MDpipxhoPzV6bjNpu4TYaX+Mc8H1OEub4GIXs=;
 b=i6FYBaSRTofxvSeJW4TM41uIQG8oys7EY1XNWA5hgtId7tNpAKj62+/TvUS3M4Nznr
 F8r7YyEK9j6hGY5u1wcoffohfLTlFa9RGtRNEuUBy688AignK3LZzxRIZr7+Psqq/l72
 /S81AVGy4+wdITgA0V/WohC7LH5QKrfv8qzUg0njvX7X5/vdXzUem57DyfZ6US10barw
 eGmOiMLSbTpIEtC/HSKM3oxW639HEAt2UeDM6z26OqKq21QOkwint0OiY/Q46/Onwwlq
 eDMLf2PvJOWKS3aK0wB9+It3nWm5poH0e9l/cbvy78kORiIYfu1rIyY94XIESDuSuSF0
 mqCQ==
X-Gm-Message-State: ABy/qLbTs3oTbJUx0b4YEHpgS+VxxczveBuX92RV99tTqwQfRXO01T+o
 Nq1VKlyg81+SBy7FxU5mVqdt6BEJZ+rbMA==
X-Google-Smtp-Source: APBJJlGISrIVHqtTzJmEoKkCFdkh312yOWIdofe97DP3L31i57YHpfR5kv90CKG6be0yr/8D4UtRMQ==
X-Received: by 2002:a17:902:e88d:b0:1b0:f8:9b2d with SMTP id
 w13-20020a170902e88d00b001b000f89b2dmr19979122plg.29.1689753258128; 
 Wed, 19 Jul 2023 00:54:18 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 i4-20020a17090332c400b001b1c3542f57sm3236847plr.103.2023.07.19.00.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:54:17 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 4/8] vdpa: Avoid using vhost_vdpa_net_load_*() outside
 vhost_vdpa_net_load()
Date: Wed, 19 Jul 2023 15:53:49 +0800
Message-Id: <428a8fac2a29b37757fa15ca747be93c0226cb1f.1689748694.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689748694.git.yin31149@gmail.com>
References: <cover.1689748694.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62d.google.com
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

Next patches in this series will refactor vhost_vdpa_net_load_cmd()
to iterate through the control commands shadow buffers, allowing QEMU
to send CVQ state load commands in parallel at device startup.

Considering that QEMU always forwards the CVQ command serialized
outside of vhost_vdpa_net_load(), it is more elegant to send the
CVQ commands directly without invoking vhost_vdpa_net_load_*() helpers.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index dd71008e08..ae8f59adaa 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1098,12 +1098,14 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
  */
 static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
                                                        VirtQueueElement *elem,
-                                                       struct iovec *out)
+                                                       struct iovec *out,
+                                                       struct iovec *in)
 {
     struct virtio_net_ctrl_mac mac_data, *mac_ptr;
     struct virtio_net_ctrl_hdr *hdr_ptr;
     uint32_t cursor;
     ssize_t r;
+    uint8_t on = 1;
 
     /* parse the non-multicast MAC address entries from CVQ command */
     cursor = sizeof(*hdr_ptr);
@@ -1151,7 +1153,16 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      * filter table to the vdpa device, it should send the
      * VIRTIO_NET_CTRL_RX_PROMISC CVQ command to enable promiscuous mode
      */
-    r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 1);
+    cursor = 0;
+    hdr_ptr = out->iov_base;
+    out->iov_len = sizeof(*hdr_ptr) + sizeof(on);
+    assert(out->iov_len < vhost_vdpa_net_cvq_cmd_page_len());
+
+    hdr_ptr->class = VIRTIO_NET_CTRL_RX;
+    hdr_ptr->cmd = VIRTIO_NET_CTRL_RX_PROMISC;
+    cursor += sizeof(*hdr_ptr);
+    *(uint8_t *)(out->iov_base + cursor) = on;
+    r = vhost_vdpa_net_cvq_add(s, out, 1, in, 1);
     if (unlikely(r < 0)) {
         return r;
     }
@@ -1264,7 +1275,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
          * the CVQ command direclty.
          */
         dev_written = vhost_vdpa_net_excessive_mac_filter_cvq_add(s, elem,
-                                                                  &out);
+                                                                  &out, &in);
         if (unlikely(dev_written < 0)) {
             goto out;
         }
-- 
2.25.1


