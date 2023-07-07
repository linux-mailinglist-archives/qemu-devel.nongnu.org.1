Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B2F74B44B
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnNB-0000Ut-Rn; Fri, 07 Jul 2023 11:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnN2-0000Rq-Qs
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:45 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnN0-000757-7m
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:43 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-262ef07be72so1131492a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688743661; x=1691335661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbPDnDvXZ1jM7wSAre9NYEyzAMjFpX5GahcGVkR6sow=;
 b=LYizImPp984a/iy50pZAmS/YFWO3NHYTqx1Ns9UrjNhmeafqRVAAm1K0pDVcEwCIyC
 IpLztQnKXhMFLXEwvDSyg+XZbIqiORQw3xAl2K8h1iHtsTasRSVSBlxiq85eL96FvcVV
 fXYpy79geo8RWku8seMlaHxQ0q6ZPbeBG+MBQvESwgiTmE9s8ZrnOF/vM80BNoUyYM7d
 xb3ODSGOJYEmv8TCCM6scUR6VfHtfWc+XAuSPENi5jXI7Dv+zIUNDbmvsecnrnRwnUZt
 SOj530XM2m8EZu2SsUlgvANiC+onoLR7Zd4N+DbLTaAx89kIKjHmIXn1rrI6oPjjZGSL
 kr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743661; x=1691335661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbPDnDvXZ1jM7wSAre9NYEyzAMjFpX5GahcGVkR6sow=;
 b=QKUImj931lXJe1ZUpP7IaaNMGFyQ4veThqfvP/5rc1exrNvBwQHGQ179lrvxY+Fq03
 V0WvVorm/4sr8+Ovh0ZzWNSQAa6sTAD0afvR/TF1jCZ8vARWW1V4b5//DyBtricXlvMi
 3WMAfZQC/w6KeFQ4MphQI+61VfmMHFOIeqEjUu5VJByWoxTiaurC4T3HtQEaXoWWb1JP
 u57wKy/cKPTno3ayAHGUQjx483asJmmf3Polr78b5pE4xYmKl2xuahJgq+DzjSsyTaLf
 c04UaOl3VtLfmPwfB6NJaafGVjqHaF1ZRvyYVIrX8oj7NQ8fTJPoRqpvfndd4EShLk2M
 AiPQ==
X-Gm-Message-State: ABy/qLb9dbq3k7CN5EHsbKgHC8J3uA+/0jZoIsxf5+MzwgDcqWOIiHTe
 ymQEGFbMBxn366ycvJ5b2lA=
X-Google-Smtp-Source: APBJJlFLSk9Qf+U3VClxm+5cjqSOzr/DFHmaMNuop+7ps6WoxJITicMZQzFjStjg5/AmlQcjbZXErg==
X-Received: by 2002:a17:90a:ca08:b0:25e:d013:c22c with SMTP id
 x8-20020a17090aca0800b0025ed013c22cmr4185789pjt.47.1688743660508; 
 Fri, 07 Jul 2023 08:27:40 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 w4-20020a17090aea0400b00263e59c1a9fsm1685397pjy.34.2023.07.07.08.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 08:27:40 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 1/7] vdpa: Use iovec for vhost_vdpa_net_load_cmd()
Date: Fri,  7 Jul 2023 23:27:28 +0800
Message-Id: <3482cc50eebd13db4140b8b5dec9d0cc25b20b1b.1688743107.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688743107.git.yin31149@gmail.com>
References: <cover.1688743107.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x102c.google.com
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
---
v3:
  - rename argument name to `data_sg` and `data_num`
  - use iov_to_buf() suggested by Eugenio

v2: https://lore.kernel.org/all/6d3dc0fc076564a03501e222ef1102a6a7a643af.1688051252.git.yin31149@gmail.com/
  - refactor vhost_vdpa_load_cmd() to accept iovec suggested by
Eugenio

 net/vhost-vdpa.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 373609216f..31ef6ad6ec 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -620,29 +620,38 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_len,
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
@@ -665,9 +674,13 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
@@ -706,9 +719,13 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
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
2.25.1


