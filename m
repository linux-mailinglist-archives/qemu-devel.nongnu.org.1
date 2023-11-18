Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027D7EFEB0
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:27:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Hb9-0006KN-UF; Sat, 18 Nov 2023 04:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hb7-0006E2-R7
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:41 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hb6-0003it-D4
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:41 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2809a824bbbso2118403a91.3
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299599; x=1700904399;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rS2eseUCEbFcqMJ5u5vWaUCi/cZtheDdVfcMVOjXvDI=;
 b=I8yC3wKnPYRMs5znNBjTROUGl6glVcMByQl84B7tq5t3mbEo0uuJSt6GyCQvyJhrHK
 8sBG1kWDHcT+wnDYvBXoB0bDV/IzVSVlYfj7i5L1dsvptWshoa/pmPeYl6dbe6J0ma9U
 xSqmmdY6JExdUoowIkGN3JheXekUD0D2z5dxijMuncHX75u0sgfdYWztTX6y7taiSyRM
 dEfo6J9P8xKpj/htd+vRWK35/2DsxqE7ZeX1wQNu/r7dECzr/1bl6lzIeesHPVFo4pt/
 sAmSF+19141OpS+CBnLi7Lxzu9Pl2fXoRIwp2Mg4QNjU9z0udHG5CAxCOVoCbCcYFxRa
 j39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299599; x=1700904399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rS2eseUCEbFcqMJ5u5vWaUCi/cZtheDdVfcMVOjXvDI=;
 b=POyH3nZiBK8766LUSsTHdTB9f6Adkr6N4KfnxlVh2G4/eKWhR9JMQftBqdfNfkkejY
 K9TB6QqdJPtLZVQNRyewO5roOdIOQ9eYANu07dMD5snHMfW8MYiWDI1606n8TF2n0fBE
 vKVFI0uBj6Uz6BPRN/kgzGf9NqA6d9WqZTOWIkw8KrUXQiZA1NCv63gFOWe7fBPyjtuK
 /t/nE048RZqPRFzkGWQ7hz4GGvlE/S4+sRjvFnVYG+LlDSvuVLbROWHOiU3Q7w2ytIoR
 L9UCpG+VSHIQ41MlT+VDDg3S8ZGqEHQcc3ADzf0L6ubtbRnN8ugNgdUrWKCS7Lzxddav
 VoGw==
X-Gm-Message-State: AOJu0Yx9Sd0Q3JxuhGLF3FJ5YR7d/Z6Kml9xzSCARqVvJfk9LCGbuK+X
 MXV+1YqNz6pueyVepR7eTbSpQNjAzR901880ae4=
X-Google-Smtp-Source: AGHT+IHEZSuEO+hbJEbKgUyLdo0KifqtaMli9amDx0qe70zw/P1yS1wjGzut6yYjO9/x509vUSupJg==
X-Received: by 2002:a17:90b:4b42:b0:280:2438:120 with SMTP id
 mi2-20020a17090b4b4200b0028024380120mr1842696pjb.45.1700299599088; 
 Sat, 18 Nov 2023 01:26:39 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 f22-20020a17090a639600b00285139b71cdsm294193pjj.11.2023.11.18.01.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:26:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v7 07/19] virtio-net: Copy header only when necessary
Date: Sat, 18 Nov 2023 18:25:47 +0900
Message-ID: <20231118092601.7132-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
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
2.42.1


