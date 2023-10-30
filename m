Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B215B7DB2B6
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:17:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKbs-000266-5s; Mon, 30 Oct 2023 01:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbq-00025T-6u
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:42 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbo-0001kC-OB
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:41 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d84f18e908aso3379959276.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642879; x=1699247679;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEajd2ZNPpR7fDLwYFMa85UI8O/Hr3pWlhMaQ0l2NHM=;
 b=ZWfNIFqPQE6DSdSvSUa3IQSkZRjzC5AeOXYp3UharOx3Ya1N6KNutzSwve0MvDAs3B
 DYT6jkLrLyA5UJNURBSWz3AkUzBpjiUIwuh1WzzM/yaqLDpyoZARMyEslyDGY1Jv1qC0
 4/YGDtLKYZopkowC6PmL1SPtwXCYsK57c9UDVKC2mgIUDcZmXqAv0XAUseOVWd74bpdu
 VtguLqZgWIvGLNIFqyJzPFUYAV2oct0CZDldLUsu54GbYTB6JOkdIESa1cOgPHN9Gncx
 z48c3Y4J98e8ZmeycD+025omd2F/EHkZJ+zWUpZQBrjsycBKJRzjhdRu3GBbLV6E6lZ0
 1KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642879; x=1699247679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZEajd2ZNPpR7fDLwYFMa85UI8O/Hr3pWlhMaQ0l2NHM=;
 b=cRU1lulaBEJ5Mnv7jDxakoLabI2qA0y/1+caeroRpewlreRh7dhD4x/bi2HgskXUaf
 n/IHbuL2+08akIGX4tGiSwLxI56D/lX0Oiu4YxzSo74VQODkooT91szuZ0uKwtKAMDzj
 SOe3xypyplOJBUQwNZvo8Uc3aMJFKV5IT3A38G67FfGUTfOzp33V+dG90IyuBlB9L0ai
 ERjj4GYyy/7hyRKm8XyUdOCQ60u7bJLbwWEh8h8qp0l6p3C1Ztd+ddZZVCMv9HRiMqlT
 JfMoNfCipsAEIOeSUdYT0MMxaTLoGTf9ExXjaOx1C0+hkZNSSbinPDHzE37txvr85y0z
 f6Pw==
X-Gm-Message-State: AOJu0Yz2pVbQgZU1z6H1DbeANpnTKhnu3ySL5GOujEXbekAGCaMd74ix
 12Z/3EJ0nQCWWGz0FTJJFNfBk0UKnUcVUZ2Af0oXag==
X-Google-Smtp-Source: AGHT+IHfUK9hW0oiTbrIBbHd0V/uMX3SrLhV8Ve5ddv+v/a7D8lbISjkgOaP8rlh3Qc1uGTl0/HDyA==
X-Received: by 2002:a25:2649:0:b0:da0:cb1f:286c with SMTP id
 m70-20020a252649000000b00da0cb1f286cmr7525224ybm.41.1698642879677; 
 Sun, 29 Oct 2023 22:14:39 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 n26-20020aa78a5a000000b0068ff0a633fdsm5042196pfa.131.2023.10.29.22.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:14:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 08/21] virtio-net: Copy header only when necessary
Date: Mon, 30 Oct 2023 14:12:29 +0900
Message-ID: <20231030051356.33123-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::b29;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-yb1-xb29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

It is necessary to copy the header only for byte swapping. Worse, when
byte swapping is not needed, the header can be larger than the buffer
due to VIRTIO_NET_F_HASH_REPORT, which results in buffer overflow.

Copy the header only when byte swapping is needed.

Fixes: e22f0603fb ("virtio-net: reference implementation of hash report")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e12176acb1..b6223031e1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -359,7 +359,8 @@ static void virtio_net_vnet_endian_status(VirtIONet *n, uint8_t status)
          * can't do it, we fallback onto fixing the headers in the core
          * virtio-net code.
          */
-        n->needs_vnet_hdr_swap = virtio_net_set_vnet_endian(vdev, n->nic->ncs,
+        n->needs_vnet_hdr_swap = n->has_vnet_hdr &&
+                                 virtio_net_set_vnet_endian(vdev, n->nic->ncs,
                                                             queue_pairs, true);
     } else if (virtio_net_started(n, vdev->status)) {
         /* After using the device, we need to reset the network backend to
@@ -2709,7 +2710,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
             return -EINVAL;
         }
 
-        if (n->has_vnet_hdr) {
+        if (n->needs_vnet_hdr_swap) {
             if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
                 virtio_error(vdev, "virtio-net header incorrect");
@@ -2717,19 +2718,16 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
                 g_free(elem);
                 return -EINVAL;
             }
-            if (n->needs_vnet_hdr_swap) {
-                virtio_net_hdr_swap(vdev, (void *) &mhdr);
-                sg2[0].iov_base = &mhdr;
-                sg2[0].iov_len = n->guest_hdr_len;
-                out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1,
-                                   out_sg, out_num,
-                                   n->guest_hdr_len, -1);
-                if (out_num == VIRTQUEUE_MAX_SIZE) {
-                    goto drop;
-                }
-                out_num += 1;
-                out_sg = sg2;
+            virtio_net_hdr_swap(vdev, (void *) &mhdr);
+            sg2[0].iov_base = &mhdr;
+            sg2[0].iov_len = n->guest_hdr_len;
+            out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1, out_sg, out_num,
+                               n->guest_hdr_len, -1);
+            if (out_num == VIRTQUEUE_MAX_SIZE) {
+                goto drop;
             }
+            out_num += 1;
+            out_sg = sg2;
         }
         /*
          * If host wants to see the guest header as is, we can
-- 
2.42.0


