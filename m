Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0CC74E1FC
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwj-0004Fm-LQ; Mon, 10 Jul 2023 19:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwW-0003Ce-P9
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwT-0004q3-Ve
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iZ/Pm5db16b2YRddidlqV+DPQbQWoo36WZiyW4cPnzI=;
 b=EZZXErj7G54yluCUOUxs9XqW9zc9siD60PRAVzn09NjCh/5umnuGBLlkpLs28Q9IyjArcX
 211J0Y/bgxnSsUiav/AHtdiOuCvzY0gnQwNrptnus1Nlfpxx5cvvZ0IR24COMeoPgiqeIb
 jaX89IAXV7ahWkYHmlUsW8Tm8/X1kQQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-DXJDY6boMHCZAH6faCv92A-1; Mon, 10 Jul 2023 19:05:16 -0400
X-MC-Unique: DXJDY6boMHCZAH6faCv92A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbcae05906so33522485e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030315; x=1691622315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZ/Pm5db16b2YRddidlqV+DPQbQWoo36WZiyW4cPnzI=;
 b=LQMpI7AB9zRxiVOZuJoLDEJxdyc+pJJkUPB1K7r3QvIq8PWXJyWPehx2EyUcHvwy1s
 ekfsTzLWVQQ9QFIhiKd156parE86KeAVWx34IrcqW3pTQGer+f4sJn0v2JjfIXQQ3vmT
 bPngD2dfv/j54AY2DLyA7cmy9v8gkzot2JHRuzZ0fRvpvKQ+QaXkfSAsphRFOpf8Y2Wt
 8vMlcrraf1oT9xYP/ELhdYZs+UikkDg6DBoSvWpARsE6BdFqujxuuIFOv/ku41R3GRUU
 agxq+iE3nDN+5KWC2DTw082r2JbJFrltC0I2wXVS4c6v3ko16FeKnfEYgo+d9YVzG42n
 gxkg==
X-Gm-Message-State: ABy/qLa0wEAFx/aoFWRNH7u3YV2hMUc3To90S+djNXAdZXa1upwYEcWy
 bgMM/vAaXK8dIFYrSkUmogSXDf5iikSxLa10wGTqi0hQg7rkEsfBVtqc9xLzUsx4y1G9erPUuYM
 8SEriSj/XqtCoW28ppCEeJhWhSNMH2/XyGrTLxE8euEs955+aD14eDe5oOMJOWdJwqAmr
X-Received: by 2002:a1c:7502:0:b0:3f8:fc96:6bfd with SMTP id
 o2-20020a1c7502000000b003f8fc966bfdmr13196649wmc.17.1689030314936; 
 Mon, 10 Jul 2023 16:05:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFBe2TYTQ72ocKMNMmaT0+ogCql+XXA1vhn6e/WELtDntcREPGdnDknKzWc8PeYTAN4Ybr4iw==
X-Received: by 2002:a1c:7502:0:b0:3f8:fc96:6bfd with SMTP id
 o2-20020a1c7502000000b003f8fc966bfdmr13196628wmc.17.1689030314576; 
 Mon, 10 Jul 2023 16:05:14 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 f19-20020a7bcc13000000b003fa973e6612sm11486226wmh.44.2023.07.10.16.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:14 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 58/66] vdpa: Use iovec for vhost_vdpa_net_load_cmd()
Message-ID: <2848c6aa7536fb48a57f38dabed1dce97fb45c6f.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
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

According to VirtIO standard, "The driver MUST follow
the VIRTIO_NET_CTRL_MAC_TABLE_SET command by a le32 number,
followed by that number of non-multicast MAC addresses,
followed by another le32 number, followed by that number
of multicast addresses."

Considering that these data is not stored in contiguous memory,
this patch refactors vhost_vdpa_net_load_cmd() to accept
scattered data, eliminating the need for an addtional data copy or
packing the data into s->cvq_cmd_out_buffer outside of
vhost_vdpa_net_load_cmd().

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <3482cc50eebd13db4140b8b5dec9d0cc25b20b1b.1688743107.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 5542b47a8f..e192217a96 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -626,29 +626,38 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_len,
 }
 
 static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
-                                       uint8_t cmd, const void *data,
-                                       size_t data_size)
+                                       uint8_t cmd, const struct iovec *data_sg,
+                                       size_t data_num)
 {
     const struct virtio_net_ctrl_hdr ctrl = {
         .class = class,
         .cmd = cmd,
     };
+    size_t data_size = iov_size(data_sg, data_num);
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
 
+    /* pack the CVQ command header */
     memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
-    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
 
-    return vhost_vdpa_net_cvq_add(s, sizeof(ctrl) + data_size,
+    /* pack the CVQ command command-specific-data */
+    iov_to_buf(data_sg, data_num, 0,
+               s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
+
+    return vhost_vdpa_net_cvq_add(s, data_size + sizeof(ctrl),
                                   sizeof(virtio_net_ctrl_ack));
 }
 
 static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
 {
     if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
+        const struct iovec data = {
+            .iov_base = (void *)n->mac,
+            .iov_len = sizeof(n->mac),
+        };
         ssize_t dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MAC,
                                                   VIRTIO_NET_CTRL_MAC_ADDR_SET,
-                                                  n->mac, sizeof(n->mac));
+                                                  &data, 1);
         if (unlikely(dev_written < 0)) {
             return dev_written;
         }
@@ -671,9 +680,13 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
     }
 
     mq.virtqueue_pairs = cpu_to_le16(n->curr_queue_pairs);
+    const struct iovec data = {
+        .iov_base = &mq,
+        .iov_len = sizeof(mq),
+    };
     dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
-                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &mq,
-                                          sizeof(mq));
+                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
+                                          &data, 1);
     if (unlikely(dev_written < 0)) {
         return dev_written;
     }
@@ -712,9 +725,13 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
     }
 
     offloads = cpu_to_le64(n->curr_guest_offloads);
+    const struct iovec data = {
+        .iov_base = &offloads,
+        .iov_len = sizeof(offloads),
+    };
     dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
                                           VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
-                                          &offloads, sizeof(offloads));
+                                          &data, 1);
     if (unlikely(dev_written < 0)) {
         return dev_written;
     }
-- 
MST


