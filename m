Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D20637CB98A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbPJ-0007So-ST; Tue, 17 Oct 2023 00:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPG-0007SY-7p
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:10 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPD-0004Ko-Cj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b201a93c9cso3026256b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515806; x=1698120606;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwJY41Y5Ssd2yodd2ldhaOgM4YyGsLPHPwk9ht/SrrY=;
 b=vZ1ZDFAptsLoDIfxnadMpaqnAGSwyIXsv+qrfe/e07oEDuowydp939xnkdihSF+44d
 O4eRKI3j4TVCP9jHVHmSJPrptJfdO27FPGLR6D0DqWXOyv3leHW3m+I+YAKYCwXNTvce
 S8VW6BFjHMUgP3yjho02CJ7rqUo84HxaVg+S+opmPHotbGKeBgHCQbsFyJ8FKmbPYdx1
 2CqeYj08DCfvOYSx6b/dwlphUudoncp4rN2lYgSXbdcQV5+HxPdOImhS5+fxlQNf7wW0
 y1CZD+QzO9vlYlFwS5JTIPC4p/ny5cpz8f5oS2LfQrJnZlU+a7AwsTCme2HMfWs9wUCZ
 D+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515806; x=1698120606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwJY41Y5Ssd2yodd2ldhaOgM4YyGsLPHPwk9ht/SrrY=;
 b=kEbGecp7U9nOoe0DeQ9uUYoAwd/RLmXIFOEMQYFsOL7nyWglKADaseZguqQikwpELm
 ImpbH53HVXhnSQmKJIehRZHibmLxQwYN0qKs7ZZgIXfjE9gBc2mVq4eaGx/KFnL6GboU
 8v+x38SLDnZlR4NL/u13frswlxgb2Ml+tjniXF/M/yChXDfj/fb3qV2Ut40g6/PcvQ4D
 7KAHLfBpSxGyyEgPIfJd8Yku60Wu2J+fNhJm73tgv1SAM3wAvOdcOHRywmF5DhlUfIQz
 /YHmgWRHKfQJdZrBn0EFOfNC1JifGxsSpyOE2ngKF5c8QyHf98re0zy+nWtDzC7Weudp
 lA3A==
X-Gm-Message-State: AOJu0Yy29LQcBtPe0xPwZROGbe/P5WXeCBOsBUVuS+IgVx/LETYawZ+u
 6DZKac2OrqdUxWklEYjwjocX9nhthFiIFHJdOXtnTQ==
X-Google-Smtp-Source: AGHT+IEWi2W1b9wnVpjpQwj5J1Hzz44FiU9NGfSRBWWakyGgyCfzSvi/CzZEYSd8OHGnf2tYmR5EnQ==
X-Received: by 2002:a05:6a20:54a6:b0:130:7803:57bd with SMTP id
 i38-20020a056a2054a600b00130780357bdmr1158797pzk.3.1697515806065; 
 Mon, 16 Oct 2023 21:10:06 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 n14-20020a170902e54e00b001c444106bcasm398484plf.46.2023.10.16.21.10.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:10:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 08/21] virtio-net: Copy header only when necessary
Date: Tue, 17 Oct 2023 13:09:14 +0900
Message-ID: <20231017040932.62997-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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


