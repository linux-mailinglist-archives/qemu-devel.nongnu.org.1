Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A55DC7BF123
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq2yJ-000463-OK; Mon, 09 Oct 2023 22:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yH-00045i-Mu
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 22:59:45 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yG-0007wu-1E
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 22:59:45 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-578e33b6fb7so3315594a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 19:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696906782; x=1697511582;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkAG/GLZoDDPnb66RkDvFFcKEopH6dS+RNqnDn3VPwM=;
 b=mgIMM00AAj6C2WUbwxZ6nsgXhmWFW8D8mTJymtbg40EN5J2OmOIT4GCDyqrj5O0gBr
 fRJ7SOtl5q5/rUrlCnLXYGsjqRuGxbhK6gxczwbX0DdabwnZzE9JrbBew3Ka87gCVwTt
 vS9udkO3yMd/fGB7vGeCxYygcVdM4kIsWQDMtmGov8Ei9H5O1zhS6HFw4qvdzDuv4ziY
 VFb+oNYsnjejfI55oxRhpnDlIu1hvlsCeAgMzquXK0U3tofz8G1Ds3oTzbrOqV+BIxo6
 P/KVJQfMn7hH7YWTg6zQHnwKakBHl43jErDmNRQdWGGv4WubDx1JmdyiTYYDgsVtgEuW
 WydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696906782; x=1697511582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkAG/GLZoDDPnb66RkDvFFcKEopH6dS+RNqnDn3VPwM=;
 b=lPctGJaqf4YaNsr/cmDxX8zrq38i9keIbcro8K591X4gvqmiPiIGY70b+2t9dZ4W9k
 yFQHpJRHrc5KnZqeA5/kkfzVr0soO/yrN7VWph5VhyIHL9HApxVHpPXdZv4xqnwpF+lY
 6uDZaMKtyx0iL1MD6lPy15clU6sHEjNI0KQG1kOTQKjRmmCFvwnIyQjcumh13B0JDaG4
 So70/k/Ft8uOCLXJ8/HMrmKEvCBnQWeQojL5FVuPtClV1BE5Vi1ExDjtSC1YeALfRiDX
 KwNj+kI0Y5F/8/FccPstyCz2RKXkJSE/kryLiaJU3OSe/p56hoauSxdOQEWGyjE7S+cF
 HYvA==
X-Gm-Message-State: AOJu0Yw27YIlnpEYntserLbZA63kj9h1QLoaGc5E49GHVPaWg4M5FhFW
 sxfrV8GDdWtwzVV7fAAHhKxks95Kn6luhvqCPFKV0w==
X-Google-Smtp-Source: AGHT+IGHLBxX5BJfYMzV9XIc4U/l7iYjUsRp+JjGbINNW5tqLc+pnWDXFtKvu5AhBTLWCratQJFJMg==
X-Received: by 2002:a17:90a:dc18:b0:26d:11ff:1832 with SMTP id
 i24-20020a17090adc1800b0026d11ff1832mr12752904pjv.27.1696906782592; 
 Mon, 09 Oct 2023 19:59:42 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 k9-20020a170902694900b001c73eace0fesm10391294plt.157.2023.10.09.19.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 19:59:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 2/7] virtio-net: Copy header only when necessary
Date: Tue, 10 Oct 2023 11:59:16 +0900
Message-ID: <20231010025924.14593-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010025924.14593-1-akihiko.odaki@daynix.com>
References: <20231010025924.14593-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
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
index 9a93a2df01..1ba748c964 100644
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


