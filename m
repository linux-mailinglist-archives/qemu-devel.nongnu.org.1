Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636F7C584A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:41:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbKR-0003Ga-OK; Wed, 11 Oct 2023 11:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbJr-0002Rd-Bv
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:23 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbJp-0001za-Mt
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:19 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6c4e30a3604so4688180a34.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697038816; x=1697643616;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwJY41Y5Ssd2yodd2ldhaOgM4YyGsLPHPwk9ht/SrrY=;
 b=tcP728AignOeG1iD6Vk4CDxl/sYPXKOq5NFJ+30KSc0vIIm/Nv9fxW/VgcteCwWmW/
 Bd+szpxKY8jjKNxEvb9s7lgBzyfE21xoxT15NI69DYys8UFkwcMma7I4/NNPbgRIdYcu
 MpqriGfyEOK6VP+J0peXjnhXHFKG9NfQ9LajDfBYas3uAjhLCEdtHiMFxjgXJ1WdUQh1
 Icc6S03AHHqSO03xosu02QtcIbCWNinhN/QTiTyIn2UspK+JBe3pAMj04EiLDYS6qlDw
 qoiHtWGuC5p1tmxbDdIOR2KxPWGcRkz3p51vAbufxTbm9A9HHt5z7gxMaJqENwSVf93Y
 qEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038816; x=1697643616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwJY41Y5Ssd2yodd2ldhaOgM4YyGsLPHPwk9ht/SrrY=;
 b=m7xMt+OCj3eYuZj3Zaqx8m8zYMPYMywU6PHkG0ebhoVnBzcFzmRh7IfbJ1tTRg+K+M
 CiE73EsQVOckzS2CXN5uE2s5jO+c8hCyy7k2q3UIhm8FqR9QBLvrgMHmmV+mFWdGY6r9
 iPCzBHlruE0kWYPcJN4GVD669bQmUhVKSFwzkoDcCWdKJ99B2HQvnOK5DfvTVA5goFzg
 YXhB/5uHfV7IOVBpSDUYiyjdYzw/y+r0wBSRGiku8pmDjJQktXvOlzx0W4iV1Re50w9z
 bgGtIKDzEJug06QIxgq4AwqBfwZ36jufCm5b5b6PTG6dBq0l0E31ErUYrk2ogbq7VpV/
 m+CQ==
X-Gm-Message-State: AOJu0YzD33EglVNz4W4e4t6HTYThMhKMc7sOpjDOGewXieQjm2WrSCOY
 6gKGGVNwafdrGSzOM3X/q/pRlG0JUO4thX6AkgXcAg==
X-Google-Smtp-Source: AGHT+IFvBzIOZcDTq+yc9ColzTw7lmuf6a7ZmL5XOcKRxnHrx4Wk1mW1RWJKW1oFbUKjWPgXxVcAYQ==
X-Received: by 2002:a05:6830:22f2:b0:6bc:b8d9:476e with SMTP id
 t18-20020a05683022f200b006bcb8d9476emr23366613otc.16.1697038816499; 
 Wed, 11 Oct 2023 08:40:16 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 x20-20020a62fb14000000b00682d79199e7sm10201209pfm.200.2023.10.11.08.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:40:16 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 06/11] virtio-net: Copy header only when necessary
Date: Thu, 12 Oct 2023 00:39:37 +0900
Message-ID: <20231011153944.39572-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011153944.39572-1-akihiko.odaki@daynix.com>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x329.google.com
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
index cab79f19cb..b1cc74881a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -361,7 +361,8 @@ static void virtio_net_vnet_endian_status(VirtIONet *n, uint8_t status)
          * can't do it, we fallback onto fixing the headers in the core
          * virtio-net code.
          */
-        n->needs_vnet_hdr_swap = virtio_net_set_vnet_endian(vdev, n->nic->ncs,
+        n->needs_vnet_hdr_swap = n->has_vnet_hdr &&
+                                 virtio_net_set_vnet_endian(vdev, n->nic->ncs,
                                                             queue_pairs, true);
     } else if (virtio_net_started(n, vdev->status)) {
         /* After using the device, we need to reset the network backend to
@@ -2690,7 +2691,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
             return -EINVAL;
         }
 
-        if (n->has_vnet_hdr) {
+        if (n->needs_vnet_hdr_swap) {
             if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
                 virtio_error(vdev, "virtio-net header incorrect");
@@ -2698,19 +2699,16 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
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


