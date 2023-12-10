Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F4780B8FF
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:31:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCOl-00022b-N8; Sun, 10 Dec 2023 00:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOg-00021X-20
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:34 -0500
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOe-00035W-EU
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:33 -0500
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7b45ab9e084so139114939f.2
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186231; x=1702791031;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SrYF1cHj4idOAu9wlWQ3md7xek6TfL1aVSYJbGl10cM=;
 b=CNEDjwLCt3OKy/Eo2EtWBVH4bMYKaW+SGeiUqfDlGZNQD2g10og3PZ8JAIkK6yFSsk
 ejqqeZN+dgvRofHf4rvZj9811105VfMM3AHn4GVjCEWToZZJCcK4p5VxbvCYOSArQhdT
 KsaLYAudQaVgqu9nOm6d1ORUMUgXjHPtCdpuTK2dddH+ZPxKXYS9aiAIEpoP3VxWKFU3
 i6AjUsEJeY0EVeFZPj6O6bh2dMaSV7rXskSkCzsUXjcYay+9ILucVbpMLx+Xg6BocTEw
 1eJ6onbrgcWrUKIyLLjKh7oHpTgTqvL9wdJEWFMyC//P4+t48Y0b/ia6a1Ee22khjhxx
 +xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186231; x=1702791031;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrYF1cHj4idOAu9wlWQ3md7xek6TfL1aVSYJbGl10cM=;
 b=sF2lornmGyiU2zJjABqto0LAyPus1YCKyOIGR6b5+ZM8G773kK0c5nvCNH0fhAlL8b
 3s5gjciuKq/gC7CXpBaZabEERhtI70gjg+9omz0kF7vZlc2BOu5gvohTs4h2UltIBStr
 WdvaVETT/DMTnEZfntBarpLtXld8xlAXyhn/8J3MDnpF1hbPmwCIkegJbpOgzTKwPobj
 VtTJnvnS9IWNgRGYeY+6+e/hqQUKSooD+lXVNXaW4Ba3pvhQIycSktyu3bI3FnjESyN7
 gsXyPybYPtPIIfjJGfdPV/UvQ23LjKIRmk4DbuA/1xZPLUsJ9x/XthLgBnPq6S7dYLc3
 wFPg==
X-Gm-Message-State: AOJu0YzZxl+SHriHCx0h/oo8zYddWMnoGL3l17Y/3WfrBUpjd+j8WgAH
 CD6JPvHYdTp98/kCQkPO4QSsqw==
X-Google-Smtp-Source: AGHT+IFwUBA0ZnFIsquSsGMVAuHAmJ0NgoQy6Tl+4VllK6igXO+29ch6P9EnWWVUXuUgUsB6F+4rsQ==
X-Received: by 2002:a05:6602:2be4:b0:7b3:942e:2df9 with SMTP id
 d4-20020a0566022be400b007b3942e2df9mr3349716ioy.6.1702186231241; 
 Sat, 09 Dec 2023 21:30:31 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 e10-20020a170902b78a00b001d07f28461esm4171956pls.279.2023.12.09.21.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:45 +0900
Subject: [PATCH v8 07/19] virtio-net: Copy header only when necessary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-7-9553ee714d38@daynix.com>
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
In-Reply-To: <20231210-rss-v8-0-9553ee714d38@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
2.43.0


