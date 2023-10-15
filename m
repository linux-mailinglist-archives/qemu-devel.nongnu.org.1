Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DF07C994D
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:04:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1iW-0001Sd-A3; Sun, 15 Oct 2023 10:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iU-0001SN-Fx
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:38 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iT-0007l3-01
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:38 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c88b46710bso23202495ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378615; x=1697983415;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwJY41Y5Ssd2yodd2ldhaOgM4YyGsLPHPwk9ht/SrrY=;
 b=czJ7fMGArjgTp0CLkMQ9uCYlVLkhHXU6ZJ7EGpwBCKEw3K7B2RvYM0E4PBJnxb3TRs
 upx7lO/o+Q/7bshTHr1Tr4+dH6tdtuJaDvdq72N2SUjYMV8fzt8vCK+HQoMOLkX6G/5b
 tmPuwwJhiEcFwVwlLYa5GohRN17wg1GC8IS6Dt14U062v+j73dsUiqgknpCXD62sccAP
 4RLlKc10/mZCn1A+hz6o5xcN87WG6j1EhF+WQii/vOlYHarWj2Vf6loMpFxXjdd0E5B7
 EkA1PoV1EnJuErG4Asv9kykrLQ77G5O+ah5B0B9pYzEfVjE4c6x2yuvU9QUUakf3FlWs
 xv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378615; x=1697983415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwJY41Y5Ssd2yodd2ldhaOgM4YyGsLPHPwk9ht/SrrY=;
 b=RMgKklQwGLV9riQ+WPO7/DIIS7lROx6O0HaLsSScDeK+virII0obuQo3TUo2SE0nY6
 9iN63IllL2rZ3uXLHYu5fCw5qAOmruAPEFV7YWb+ycxrBljbFu/7uvxPc2x+rWHlWdZG
 //LUjp0fBsUdYWzj4gTrQqe/q6ZKjSDFac0YhkQMCcm3oIuXUKxi63rXjhMxQyzaqbqO
 JJCYnY3et1699gl4ZikIMkFjlf1g6tYuE7grn+HoeLXMqSrZn5lyznLSh5CwzsOZjFux
 j3RKHm6J9XaXqE8NkkkBNIVzyVK1gF+NUjJxu9BdPxdz9+7DCfiGyNi28jy+zgey3IYD
 1RSQ==
X-Gm-Message-State: AOJu0YyH7xRtrmPyOwfAsrVa/OAjwtCTqC14BCBqms2izznESGWgLB/R
 tEIenuY5UNjFRe/eI7/4/rk2Pm2QfasKQDpY6of0XA==
X-Google-Smtp-Source: AGHT+IHu5LpqjY8urx2INBkOMqnDvUvXYRd/B9rTgpKsvH0jdccmv6hPCik04pZ6K4/hVkOGbzFJaw==
X-Received: by 2002:a17:902:904c:b0:1c6:2ae1:dc28 with SMTP id
 w12-20020a170902904c00b001c62ae1dc28mr24747159plz.36.1697378615585; 
 Sun, 15 Oct 2023 07:03:35 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 l18-20020a170902eb1200b001c5fc291ef9sm6861775plb.209.2023.10.15.07.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 08/20] virtio-net: Copy header only when necessary
Date: Sun, 15 Oct 2023 23:02:40 +0900
Message-ID: <20231015140259.259434-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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


