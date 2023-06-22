Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 986B37395B1
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 05:03:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCAad-0002UB-G5; Wed, 21 Jun 2023 23:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCAaN-0002Ta-H0
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 23:02:16 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCAaL-000191-6Z
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 23:02:14 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1a28de15c8aso6670382fac.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 20:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687402932; x=1689994932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHV0woOZfxgxwTcmm6qjynWroBSQmAsAohHPX7OsYtI=;
 b=VHu1lUG+LmlSKM4KcnvjLJgoYHjNei0YakSZRRbhZca1VLLVg+eu6LNXK7aHgkcrXK
 QObJoR0P4PFyso0KicdIkNYpU4f2SxW2SGHNe66BGtzOaqZ+5BlrPEI3HUcR+1Xfq+f6
 kZFAnEja2UCxiX+WwaRKyW/4uXu++jEO/f15RFv8TyKDVPaM6Zf1f9611FHoW3HCl3/l
 lGaSVPK5GJ8w618kPVsgcy1WfdMqJA4KCbJNn0QnG+BFc9O743Uoc/H2xrcSUhH3oHzl
 UO9XL6Ju1fIB46lc1d7wAn7vHnXuUGWfycfR8x2XZbXb37HXry/HpYTwJqlH7/ZP/w6m
 DazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687402932; x=1689994932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHV0woOZfxgxwTcmm6qjynWroBSQmAsAohHPX7OsYtI=;
 b=e8My8zf+peuL2pAnJ0FcQ5deIZpBsr9NQu0d7mJMRo8LoDy7Ia7EoMhZcXDiWQoMC8
 I1i6kxFUIg0hzwXuqPFpNyx/wPqdCQ5LouoZe4ohY2IXEjVNqzTyFoiMzSAXy5o4BBI3
 YXHN2xAK1IR577dJ4MOArrULsFq8C1QOXU0g7oYhBDHp8t2MSjpks02Pwdy9KP6hyUFn
 3IyRSOhRDbp9K98PvkkMO5W4Jtj4v2psYVb7qmhbmPO+17NVb24+ahBKpxZAjt3niOwE
 Z3pXdZ7g0zXE5Z/LR6vZm0egnD+n2PrXqYB45s71Pcm74SoFo4FWoBR762dHYTNmvdrF
 6SmA==
X-Gm-Message-State: AC+VfDxxsykbpvXE5HdAPNe19v+gh6Bg4zMSM5aHQPYMo/xlCcBl6Xok
 RqUG3Bq3/E4ZiGJgGlefenU=
X-Google-Smtp-Source: ACHHUZ5jar53Ifmx4hssZqtSflyCvlT0Yxl9ncns/rz6nEoW7/z+mDI5i6UHtfp70t8h9Vuvistpzg==
X-Received: by 2002:a05:6870:c799:b0:19f:9f91:fa4a with SMTP id
 dy25-20020a056870c79900b0019f9f91fa4amr15025080oab.55.1687402931588; 
 Wed, 21 Jun 2023 20:02:11 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 d28-20020a630e1c000000b00528da88275bsm3777202pgl.47.2023.06.21.20.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 20:02:11 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC 2/3] vdpa: Restore packet receive filtering state relative
 with _F_CTRL_RX feature
Date: Thu, 22 Jun 2023 11:01:43 +0800
Message-Id: <86eeddcd6f6b04e5c1e44e901ddea3b1b8b6c183.1687402580.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687402580.git.yin31149@gmail.com>
References: <cover.1687402580.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=yin31149@gmail.com; helo=mail-oa1-x36.google.com
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

This patch introduces vhost_vdpa_net_load_rx_mode()
and vhost_vdpa_net_load_rx() to restore the packet
receive filtering state in relation to
VIRTIO_NET_F_CTRL_RX feature at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 10264d3e96..355a6aef15 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -754,6 +754,76 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
     return *s->status != VIRTIO_NET_OK;
 }
 
+static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
+                                       uint8_t cmd,
+                                       uint8_t on)
+{
+    ssize_t dev_written;
+    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
+                                          cmd, &on, sizeof(on));
+    if (unlikely(dev_written < 0)) {
+        return dev_written;
+    }
+    if (*s->status != VIRTIO_NET_OK) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
+                                  const VirtIONet *n)
+{
+    uint8_t on;
+    int r;
+
+    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
+        /* Load the promiscous mode */
+        if (n->mac_table.uni_overflow) {
+            /*
+             * According to VirtIO standard, "Since there are no guarantees,
+             * it can use a hash filter or silently switch to
+             * allmulti or promiscuous mode if it is given too many addresses."
+             *
+             * QEMU ignores non-multicast(unicast) MAC addresses and
+             * marks `uni_overflow` for the device internal state
+             * if guest sets too many non-multicast(unicast) MAC addresses.
+             * Therefore, we should turn promiscous mode on in this case.
+             */
+            on = 1;
+        } else {
+            on = n->promisc;
+        }
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, on);
+        if (r < 0) {
+            return r;
+        }
+
+        /* Load the all-multicast mode */
+        if (n->mac_table.multi_overflow) {
+            /*
+             * According to VirtIO standard, "Since there are no guarantees,
+             * it can use a hash filter or silently switch to
+             * allmulti or promiscuous mode if it is given too many addresses."
+             *
+             * QEMU ignores multicast MAC addresses and
+             * marks `multi_overflow` for the device internal state
+             * if guest sets too many multicast MAC addresses.
+             * Therefore, we should turn all-multicast mode on in this case.
+             */
+            on = 1;
+        } else {
+            on = n->allmulti;
+        }
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLMULTI, on);
+        if (r < 0) {
+            return r;
+        }
+    }
+
+    return 0;
+}
+
 static int vhost_vdpa_net_load(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -780,6 +850,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
     if (unlikely(r)) {
         return r;
     }
+    r = vhost_vdpa_net_load_rx(s, n);
+    if (unlikely(r)) {
+        return r;
+    }
 
     return 0;
 }
-- 
2.25.1


