Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13B742995
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtXX-00024Z-4J; Thu, 29 Jun 2023 11:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qEtWz-0001m5-60
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:26:06 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qEtWt-0007Ru-5W
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:25:56 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55b1238a024so652662a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688052353; x=1690644353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMQffePhn6GAVPNczkmSxl17glAAwF+BiBZrL06id/o=;
 b=CmgNvUrVOGq3FlWfVLkVX2NnW/9fr/DzPSe2P+cBRTa17uc2FHWwRx02HbLsyuAZGf
 2JgP1GkrJPbkTiRXS8LUpS4HJ52Rdwuz+vrQqJ0ANRHq9pn94JF1q/sptXsXiCdrUc8H
 TK3X1omdj0ezvhkNiVvp0Z65/TQCsKrecdysZfzxNpDjpgu5rdFSd4QK6pkov+RQH3SM
 8MVwjPad4sB2EEKXrs9SW7zXjHLmxSxWgBweVyFGNpoKKNH5PPjsc3ZI3s84vXw8OZi6
 AkKDAhZb+tODq+M1oXoJpe1w64fUbvkXa01uKm6TzLamRMzGlDPvyieOJCbswckhwp6L
 nyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688052353; x=1690644353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMQffePhn6GAVPNczkmSxl17glAAwF+BiBZrL06id/o=;
 b=QgC9ViKN9l3zalChXJ7YqrNZJcSsJHcAauCeShPP2ebnbBCheXL9ItugyW/DS/RN6i
 gniBmIXB0brJxpeTGesubbNf+V2re747oXAi9FzIN/F9s7//+gVHEtKz4Zip+4Mt8g1+
 pRQYK4iYqEPG3tcGVame3ixctimyt0nCLL/fJQPykvycEafwhkl6d6wfWC9oPxep0Ud0
 93pNgy8aMnEE88JfWnfB6mM7VM5Ry2JM4Oywn7AGUKAm2LYyxSiURU8NP0dPspco/InX
 PqMsJOGfluQR/NC2PwQZ59zlBCGzJcPhcDB+KQ6tvT+S+PwWNRjdj4qgIztOJKRcK2ae
 lueg==
X-Gm-Message-State: AC+VfDybeUpJydoSy3E6sts2SzUdGGeHvmy38AYDAf4FGCSmL74IJIIX
 eOabJRRxyVuZIZp1e+0SPqQ=
X-Google-Smtp-Source: ACHHUZ5KKq8cltJIsOYGZdLixdPdAHTZwjxMECcxlHAsodE4OOO+T8vX7qJR60Uzlttd6z3FLyNTeg==
X-Received: by 2002:a05:6a20:659:b0:12c:8871:26df with SMTP id
 25-20020a056a20065900b0012c887126dfmr23060pzm.18.1688052353447; 
 Thu, 29 Jun 2023 08:25:53 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 x8-20020a62fb08000000b0064d6f4c8b05sm8807335pfm.93.2023.06.29.08.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 08:25:53 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC v2 3/4] vdpa: Restore packet receive filtering state
 relative with _F_CTRL_RX feature
Date: Thu, 29 Jun 2023 23:25:34 +0800
Message-Id: <d9d7641ef25d7a4477f8fc4df8cba026380dab76.1688051252.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688051252.git.yin31149@gmail.com>
References: <cover.1688051252.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x52b.google.com
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
v2:
  - avoid sending CVQ command in default state suggested by Eugenio

v1: https://lore.kernel.org/all/86eeddcd6f6b04e5c1e44e901ddea3b1b8b6c183.1687402580.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index cb45c84c88..9d5d88756c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -792,6 +792,106 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
     return 0;
 }
 
+static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
+                                       uint8_t cmd,
+                                       uint8_t on)
+{
+    ssize_t dev_written;
+    const struct iovec data = {
+        .iov_base = &on,
+        .iov_len = sizeof(on),
+    };
+    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
+                                          cmd, &data, 1);
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
+        if (on != 1) {
+            /*
+             * According to virtio_net_reset(), device turns promiscuous mode on
+             * by default.
+             *
+             * Therefore, there is no need to send this CVQ command if the
+             * driver also sets promiscuous mode on, which aligns with
+             * the device's defaults.
+             *
+             * Note that the device's defaults can mismatch the driver's
+             * configuration only at live migration.
+             */
+            r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, on);
+            if (r < 0) {
+                return r;
+            }
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
+        if (on != 0) {
+            /*
+             * According to virtio_net_reset(), device turns all-multicast mode
+             * off by default.
+             *
+             * Therefore, there is no need to send this CVQ command if the
+             * driver also sets all-multicast mode off, which aligns with
+             * the device's defaults.
+             *
+             * Note that the device's defaults can mismatch the driver's
+             * configuration only at live migration.
+             */
+            r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLMULTI, on);
+            if (r < 0) {
+                return r;
+            }
+        }
+    }
+
+    return 0;
+}
+
 static int vhost_vdpa_net_load(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -818,6 +918,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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


