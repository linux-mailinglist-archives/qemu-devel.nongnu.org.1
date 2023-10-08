Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DCF7BCC64
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:30:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMMe-00044x-Rt; Sun, 08 Oct 2023 01:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMMG-000445-3H
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:29:40 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMME-00075G-LJ
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:29:39 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-352308c0799so14096845ab.2
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742977; x=1697347777;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkAG/GLZoDDPnb66RkDvFFcKEopH6dS+RNqnDn3VPwM=;
 b=AV194/uwDW0IWU02ht9oApza0IYnRLHtjuhEZi0HdimFk6ZG/X5fJHcKQtVCCEafIF
 kooNbNdizrZ/uVD/D1wgjDy1p7wJv+O8unZR+IWCRLSFv0qXI+EV3ho6ajzD11h2IO65
 9abrvJndECqHdt895sp2k/PP90FZYjGz6w+6PL4p1AohatpP9djKqzsojZ0A/WFxymDV
 OWnNA7BRzc/5bfyFK74pO01TQmVRgNJqR8tBRw/+AiP/V2kwLayHp6vElTglXLcjUfaR
 qojiM6ubo8AreqiakbmMZhwvYkRKcmvU94IhwSciCNLFKhYm+LP15QPLgB3vLSfSgOhQ
 SyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742977; x=1697347777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkAG/GLZoDDPnb66RkDvFFcKEopH6dS+RNqnDn3VPwM=;
 b=gvdSHlqvSnw3ONpPfCpw8Lz2n6FEf4VF/MMPUXet52LGKlZGxcdv4Pto0ZZZI0+e7/
 rGuKgQNEzMYnuFkZafp8/0p+TUFMqIyf73NzB7hqslD+PVJ7AKz8rLUfb81tIbMPbAFh
 lll+E/G82Z2gMhYZd2dA9sb73IgJIcivGUzBs5LESGTBd3sI0dRwOLnQ3f1dWMXHj3Ag
 IZVozHvoDfVSxCuxRltuDZW0JAaXVqwE5MX/iRsPP8V28yb/R2KG4VRluCr/XlZYhxIY
 RS/ZT3alO9MGypk/tkSqk1qH/n3tbw+Fpv5OAKahBi6vHZdlNV1kvYn0ihqVDrGFydGr
 usWA==
X-Gm-Message-State: AOJu0YzeuG7WDmPKtRb5RlBzloQxVzC2khLuzZ7qED06ItkBfcXFIo2a
 u8f68FzrQDYyyAkkAJcK5gCWdQ==
X-Google-Smtp-Source: AGHT+IGJzeHi33A8j3ljCqADFs65vAMtzFp4XP82t3pOBzrqzg3cEEyj+6kb7iBAecDD8EgAfWZ+ig==
X-Received: by 2002:a05:6e02:1a0a:b0:34f:fe3c:fd8 with SMTP id
 s10-20020a056e021a0a00b0034ffe3c0fd8mr16389967ild.15.1696742977677; 
 Sat, 07 Oct 2023 22:29:37 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 c12-20020aa78e0c000000b006933866fd21sm3984617pfr.117.2023.10.07.22.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 22:29:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 2/6] virtio-net: Copy header only when necessary
Date: Sun,  8 Oct 2023 14:29:11 +0900
Message-ID: <20231008052917.145245-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008052917.145245-1-akihiko.odaki@daynix.com>
References: <20231008052917.145245-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12d.google.com
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


