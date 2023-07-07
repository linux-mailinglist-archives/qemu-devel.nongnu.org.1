Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7267974B44F
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:29:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnND-0000YH-PS; Fri, 07 Jul 2023 11:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnN8-0000VW-47
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:51 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnN6-00075q-Aw
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:49 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-55b83ae9be2so1412071a12.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688743666; x=1691335666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wwNQrzfRieQAWwm33vW9G94BVnPYPQ6wP7L8s8G+8E=;
 b=AasuUtEIEhanRSougg4WYz3NL7SV13kCFYMOHFHDQrjJG45JBb3OE+WPciRAVKYCUG
 G5DJXt/ftDIEvaorJZEUpkIy84f9yRfDsc5FhACDTkOfMMnP0bv+MFoBFX69rTsLSz82
 MlmNkjhYAo9bnM6PJeWRtlft2amDZcKwdLoNNSnkD50A5y/YSetLQct7n30E7Dd0X+mo
 lXdDjV4UbT+KDYGd1oaR+xNbisRaLNnGrnTEVbOwVpsJ8Zyiz5v0vTRcjV+uLx3MeB7H
 H1N9/TPyRzg3j+foIc/CP6KGrvAK9+2b4JxQQsmpmc6/Kpwjiwxd+yRwAE96QcJfUL7W
 Sy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743666; x=1691335666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wwNQrzfRieQAWwm33vW9G94BVnPYPQ6wP7L8s8G+8E=;
 b=RvL2ttAANZVKn43A8IpBnVDsJEpEIo1vH4TgQjBREgT/G5JnqHqUd5KZ5l3+VwN4nK
 kjW4yQ1ksuXJ2cEBvvn4hx/H9vMns7BcbBdkMwFsE32FO6QfErJj9izmt6ScoDhM0JFt
 qJQia5OJcPmu8okxa5gcqzreNtqCJLMJiuImyzS5GPkIku2qfxI4KODGSbidfwYdSq0k
 4OHMUpWAaMuCSPiiMBMYfww7ow2AqrYqmI64DpPRtM1LjCJd/iOi4OvddL4CUuFiUzgx
 +FZdyuz5X5g2fM+bocQ/im4axHGuaX4s5Gl3Ylje/zq8rCQlyTVVYCOP+16xszo88QRQ
 njfw==
X-Gm-Message-State: ABy/qLa47qGHkfBerSXwNRbuiwc8Add90Q+EwaO7VPl+Tf4Rmded/uVc
 DBqXotK/nWX9gvcO8dqxWnM=
X-Google-Smtp-Source: APBJJlEM36AiyJmA41JLOsCUaZhQnZLwt002aWyuffi0nP1lCFXE2l37e3vtsTbzNKZlMLWOjz/qkw==
X-Received: by 2002:a05:6a21:6d92:b0:12f:9e13:12b1 with SMTP id
 wl18-20020a056a216d9200b0012f9e1312b1mr6517320pzb.15.1688743666115; 
 Fri, 07 Jul 2023 08:27:46 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 a2-20020aa780c2000000b0064389eab4c8sm3026361pfn.126.2023.07.07.08.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 08:27:45 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 3/7] vdpa: Restore packet receive filtering state relative
 with _F_CTRL_RX feature
Date: Fri,  7 Jul 2023 23:27:30 +0800
Message-Id: <804cedac93e19ba3b810d52b274ca5ec11469f09.1688743107.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688743107.git.yin31149@gmail.com>
References: <cover.1688743107.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x529.google.com
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
v3:
  - return early if mismatch the condition suggested by Eugenio
  - remove the `on` variable suggested by Eugenio

v2: https://lore.kernel.org/all/d9d7641ef25d7a4477f8fc4df8cba026380dab76.1688051252.git.yin31149@gmail.com/
  - avoid sending CVQ command in default state suggested by Eugenio

v1: https://lore.kernel.org/all/86eeddcd6f6b04e5c1e44e901ddea3b1b8b6c183.1687402580.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7189ccafaf..e80d4b4ef3 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -788,6 +788,87 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
     return 0;
 }
 
+static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
+                                       uint8_t cmd,
+                                       uint8_t on)
+{
+    const struct iovec data = {
+        .iov_base = &on,
+        .iov_len = sizeof(on),
+    };
+    return vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
+                                   cmd, &data, 1);
+}
+
+static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
+                                  const VirtIONet *n)
+{
+    ssize_t dev_written;
+
+    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
+        return 0;
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns promiscuous mode
+     * on by default.
+     *
+     * Addtionally, according to VirtIO standard, "Since there are
+     * no guarantees, it can use a hash filter or silently switch to
+     * allmulti or promiscuous mode if it is given too many addresses.".
+     * QEMU marks `n->mac_table.uni_overflow` if guest sets too many
+     * non-multicast MAC addresses, indicating that promiscuous mode
+     * should be enabled.
+     *
+     * Therefore, QEMU should only send this CVQ command if the
+     * `n->mac_table.uni_overflow` is not marked and `n->promisc` is off,
+     * which sets promiscuous mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (!n->mac_table.uni_overflow && !n->promisc) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_PROMISC, 0);
+        if (unlikely(dev_written < 0)) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns all-multicast mode
+     * off by default.
+     *
+     * According to VirtIO standard, "Since there are no guarantees,
+     * it can use a hash filter or silently switch to allmulti or
+     * promiscuous mode if it is given too many addresses.". QEMU marks
+     * `n->mac_table.multi_overflow` if guest sets too many
+     * non-multicast MAC addresses.
+     *
+     * Therefore, QEMU should only send this CVQ command if the
+     * `n->mac_table.multi_overflow` is marked or `n->allmulti` is on,
+     * which sets all-multicast mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (n->mac_table.multi_overflow || n->allmulti) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_ALLMULTI, 1);
+        if (unlikely(dev_written < 0)) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
+    return 0;
+}
+
 static int vhost_vdpa_net_load(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -814,6 +895,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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


