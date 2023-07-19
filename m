Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 352ED758F7C
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM1up-00007p-Gj; Wed, 19 Jul 2023 03:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM1uY-0008UM-Dn
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:47:53 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM1uW-00027u-Ph
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:47:50 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b9ecf0cb4cso40906745ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689752867; x=1692344867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQXPMit78wxXOLwUXAdy/5EGNJNucIHi6SIpfnSqqAI=;
 b=WvhYJEm27ZNlSgl7NGonGEMJ7Lsgu+4o+UsrZueMrdvsVUrUVZ3PLtJTyspR8AxDdz
 pCROssillsbTAIw0nhajuoy+KGA0MGQ8yMhd8qSZKkCYHiVHop70jvtbISHx27BJ/Nzb
 0w2MyWs8+f8uPVmnRmPEgy9KfvW6hzUZdcftHYTuW2GiE4YTK7yynLm8nLtJeIuQRa80
 E2wGRfKH+HKaU/xOJtntNiOQeCRK8oiXLR0NcQfjG2CniPw5JHoTiVIKj/3dtL2E8DK6
 0LE05dprL0Xx1XL5i8vMkutfgiGBIbDxRiM7aB8MV3IzURtZ0h0E31g6f5jBjznWE60Z
 dICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689752867; x=1692344867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQXPMit78wxXOLwUXAdy/5EGNJNucIHi6SIpfnSqqAI=;
 b=gI8orso0gjZCH+65P7jnZGvqElXOEysNBYAcErsk+HjqSpla24enVh1j3fER7Pi0hV
 GyVS0o+WGFSlmX0ebUdqqdMw8PrRIhzqrG8R4sL+R3FxO3yYO0CL3OcdS6rWDzd0JEaO
 bZfBLLitWM1xH30yVT5p7TpCN3hvAzJjFMZj4kqfRvDgj3EWm7Msv1FM0d8pcSLqJEz8
 +cgthy8I1etQ6f7Dx3/G2iSvAwlizyw4viKS+vvQEWOeOyIpP3l0QElnPAE3CzQTu2fI
 JelG99ZNEb2b5CcvVNK4q7JwjFJ03aaLQSAT7K8kxato/nW2PwTqYr/qnjIUFU9SmUza
 dbtQ==
X-Gm-Message-State: ABy/qLYHD2OGcTWbw9Ox/xUwLsuoQGAAhLObh9qE99o4p/bPAHzTCTYA
 BOEJh6s14W+oBwk+mCO7RkM=
X-Google-Smtp-Source: APBJJlGgBiyU96KqNmR6NqfgWimiqfVkl/pvQM77pvJz7i2mGAZruMCwfTbwuKFm/fv+tdiLIwkKQw==
X-Received: by 2002:a17:902:e810:b0:1b6:8a99:4979 with SMTP id
 u16-20020a170902e81000b001b68a994979mr2307598plg.22.1689752867339; 
 Wed, 19 Jul 2023 00:47:47 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 je19-20020a170903265300b001b8528da516sm3216400plb.116.2023.07.19.00.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:47:47 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH 2/4] virtio-net: Expose MAX_VLAN
Date: Wed, 19 Jul 2023 15:47:29 +0800
Message-Id: <9106e247646f3808d0b0c4be948f2217bbfd8fd1.1689690854.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689690854.git.yin31149@gmail.com>
References: <cover.1689690854.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x634.google.com
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

vhost-vdpa shadowed CVQ needs to know the maximum number of
vlans supported by the virtio-net device, so QEMU can restore
the VLAN state in a migration.

Co-developed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 hw/net/virtio-net.c            | 2 --
 include/hw/virtio/virtio-net.h | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d20d5a63cd..a32672039d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -49,8 +49,6 @@
 
 #define VIRTIO_NET_VM_VERSION    11
 
-#define MAX_VLAN    (1 << 12)   /* Per 802.1Q definition */
-
 /* previously fixed value */
 #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
 #define VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE 256
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5f5dcb4572..93f3bb5d97 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -38,6 +38,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIONet, VIRTIO_NET)
 /* Maximum VIRTIO_NET_CTRL_MAC_TABLE_SET unicast + multicast entries. */
 #define MAC_TABLE_ENTRIES    64
 
+/*
+ * The maximum number of VLANs in the VLAN filter table
+ * added by VIRTIO_NET_CTRL_VLAN_ADD
+ */
+#define MAX_VLAN    (1 << 12)   /* Per 802.1Q definition */
+
 typedef struct virtio_net_conf
 {
     uint32_t txtimer;
-- 
2.25.1


