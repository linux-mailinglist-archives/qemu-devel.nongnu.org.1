Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07723742990
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:26:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtX2-0001fj-7B; Thu, 29 Jun 2023 11:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qEtWp-0001Yr-FN
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:25:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qEtWn-0007QA-Ol
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:25:51 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b80f2ed810so4739825ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 08:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688052348; x=1690644348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i11pe/SEBYjDzJQtCf8AUd0eYtADDXrqqVh5YnGpr5E=;
 b=bGEZCXPzCBb4Vz7e6f5EInUm1qfXhdlKS/k5gaUCq9o2DHM4MOOZxYv2qB6loq646X
 nX8iYCp1gdS8o1+rFil/oeJ68X8D2xmJfsvqqPJbn+ONhmM6JmVX/FFUUwrYPubHQHME
 jv2B3eez3q87MRxflXZbaahvx35lYh8qfyKtCsy3nnqSrklcYo3pXTlzsi73XQmiBvVr
 9Igt3kxVsTX3Jh6M9V1aJi7g80zVmLVMOZrrjZMDUSrvVCaLUwU2+oJymH/4J5xeGUtZ
 PhRdfzlfDgVAa3EMDHiUGOyS0u7aBqDfDDTk11TSsGTp8dreQRRlIYFF4wlgxdKfkj/g
 l2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688052348; x=1690644348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i11pe/SEBYjDzJQtCf8AUd0eYtADDXrqqVh5YnGpr5E=;
 b=ayfbpLNpAd+lWoSeaKg1Ufm3gvVz/eYBKUZuDrJqoxbGcyCyvlgHGOmG0Vm5qEMDIA
 2/fzg9Z4NYVTnIKfmstVR/bxRXyriTnNtCvDeyE+Dpk75A/ANty51KmCBAQGbfpe9aeS
 Ad6gtqqn0IuLfQNY3goVNBvka0N9xwgW66Fp2RxdPyNEWsofO20kGnQzVZD2e+k4jP/b
 cK4ggUNbB9YS0xKM7EfF6yOmFJGhpvOovWY/bRcZPgOgfB9QtPO7S6+d3C8ozjqtk7//
 fWQaxH6x/mJLdqPlh0BORWlNRHKj7GRgMqEMDOVmhXBszgBvO6jsQOA6v3FZhha7XFFP
 9rmg==
X-Gm-Message-State: AC+VfDwvQu6envlDwDfrnvCipMsTu6ERLvSh+rYBIagfrABUwyyrmTGc
 EcrHDYan/foXcb62gDsb/QE=
X-Google-Smtp-Source: ACHHUZ58o17eCz2U5/0iwRxhApEFIjZAmAgyCFq5sqfzJIBfSbUw60F5mA+FD/u5M8rF6fXyTtIMsQ==
X-Received: by 2002:a17:902:7289:b0:1b6:80f0:d969 with SMTP id
 d9-20020a170902728900b001b680f0d969mr10150355pll.11.1688052347623; 
 Thu, 29 Jun 2023 08:25:47 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 jd22-20020a170903261600b001b3c66f806bsm6892537plb.217.2023.06.29.08.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 08:25:47 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC v2 1/4] vdpa: Use iovec for vhost_vdpa_net_load_cmd()
Date: Thu, 29 Jun 2023 23:25:32 +0800
Message-Id: <6d3dc0fc076564a03501e222ef1102a6a7a643af.1688051252.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688051252.git.yin31149@gmail.com>
References: <cover.1688051252.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62a.google.com
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
v2:
  - refactor vhost_vdpa_load_cmd() to accept iovec suggested by
Eugenio

 net/vhost-vdpa.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 6f6a5c6df6..0bd1c7817c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -620,29 +620,43 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_len,
 }
 
 static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
-                                       uint8_t cmd, const void *data,
-                                       size_t data_size)
+                                       uint8_t cmd, const struct iovec *data,
+                                       size_t data_len)
 {
     const struct virtio_net_ctrl_hdr ctrl = {
         .class = class,
         .cmd = cmd,
     };
+    void *cursor = s->cvq_cmd_out_buffer;
 
-    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
+    /* pack the CVQ command header */
+    assert(sizeof(ctrl) < vhost_vdpa_net_cvq_cmd_page_len() -
+                          (cursor - s->cvq_cmd_out_buffer));
+    memcpy(cursor, &ctrl, sizeof(ctrl));
+    cursor += sizeof(ctrl);
 
-    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
-    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
+    /* pack the CVQ command command-specific-data */
+    for (int i = 0; i < data_len; ++i) {
+        assert(data[i].iov_len < vhost_vdpa_net_cvq_cmd_page_len() -
+                                 (cursor - s->cvq_cmd_out_buffer));
+        memcpy(cursor, data[i].iov_base, data[i].iov_len);
+        cursor += data[i].iov_len;
+    }
 
-    return vhost_vdpa_net_cvq_add(s, sizeof(ctrl) + data_size,
+    return vhost_vdpa_net_cvq_add(s, cursor - s->cvq_cmd_out_buffer,
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
@@ -665,9 +679,13 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
@@ -706,9 +724,13 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
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


