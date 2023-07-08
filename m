Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD5474BD1B
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 11:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI4Ce-0002QG-1w; Sat, 08 Jul 2023 05:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qI4Ca-0002Nn-D5
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 05:26:04 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qI4CY-0001AK-Hs
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 05:26:04 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-55b66ca1c80so1436994a12.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 02:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688808361; x=1691400361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YS54aOZ4UTlUbA4dn/Pd1uNd43qqED1ZdNbpnBRTruw=;
 b=f36P/e2zyNBEUUWy1iGnZvy/7Dmtv7VTpvpkm20TxF9Vuci/lJP0zJeXT271nRdd7N
 UqTjpEVEzHjWPO2p2v+ddLXBLGixVX4wZlQUW36ys8nSrV61mShvmWpvK3AYefuHV4Nv
 HrHr5IEu6sk0tOUfuYz2/O/TX5Dg7ypgVaWSxc9PZ3MvQSc+Ejh7TVq0YOvsHvj9P/C8
 M/Niti5H8if9T0BdC3+7RkDOgNeiJP/mborbpAFgARr/zGoQiiC837uuJHEKmkUA4ito
 T7PDMBJvA7J+flfR1Azcw2HKFQJTUBq4yfq8D0ZNaEoEFPt2nvWcPb6jd+F03XnE8XgW
 2Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688808361; x=1691400361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YS54aOZ4UTlUbA4dn/Pd1uNd43qqED1ZdNbpnBRTruw=;
 b=XSOGZeqDl4IPsCN7gJFb4UCda4eECdy8oDYrPNSuAYHWzUb3u8wE2uXjPrD/l0nM5U
 zYhWhamT7w+BE5LBMLfzf2q1jkSP77yObll4IGjSqjgIg4CY2G2qWw0eWo2oHnQxayBw
 dRZpPvasasjJ/T/ZVxhnLpnVTqtT7lsObDM8+v4IxmAcTEWJ/x2yxFTayfdQp8mgAVUO
 ppidK9bgRJ0Qp/m5EzKH9sKUIb92wWmw+TnyP9cRgjPe0ZhQDn9EetYRo9Nfyyfx5U+G
 JF2ZoiQOHyCvdMBoSZGj6xfz7l0Ejdy/tQbDl/G8tbnPeon4CzA5mKLqmwXMfGAu8+06
 cisw==
X-Gm-Message-State: ABy/qLbUuldZnxwG3flETLICMd/beOyE9LAoPeglZo01rYtGH03LOxCB
 VRJKji0J06nJ6Ktyn6VAbu8=
X-Google-Smtp-Source: APBJJlGLI1hlxndyuKXkT2XPeAUP7YPIFABaKofOI95K7zGqP9XHYKo57UVxHz4buxadsu/i+AaS9A==
X-Received: by 2002:a17:903:230e:b0:1b5:47fc:5864 with SMTP id
 d14-20020a170903230e00b001b547fc5864mr6271285plh.56.1688808361089; 
 Sat, 08 Jul 2023 02:26:01 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 jj21-20020a170903049500b001b891259eddsm4513519plb.197.2023.07.08.02.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jul 2023 02:26:00 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 1/2] vdpa: Restore packet receive filtering state relative
 with _F_CTRL_RX_EXTRA feature
Date: Sat,  8 Jul 2023 17:24:51 +0800
Message-Id: <abddc477a476f756de6e3d24c0e9f7b21c99a4c1.1688797728.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688797728.git.yin31149@gmail.com>
References: <cover.1688797728.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x532.google.com
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

This patch refactors vhost_vdpa_net_load_rx() to
restore the packet receive filtering state in relation to
VIRTIO_NET_F_CTRL_RX_EXTRA feature at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v3:
  - return early if mismatch the condition suggested by Eugenio
  - remove the `on` variable suggested by Eugenio

v2: https://lore.kernel.org/all/66ec4d7e3a680de645043d0331ab65940154f2b8.1688365324.git.yin31149@gmail.com/
  - avoid sending CVQ command in default state suggested by Eugenio

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg04957.html

 net/vhost-vdpa.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0994836f8c..9a1905fddd 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -867,6 +867,94 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
         }
     }
 
+    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX_EXTRA)) {
+        return 0;
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns all-unicast mode
+     * off by default.
+     *
+     * Therefore, QEMU should only send this CVQ command if the driver
+     * sets all-unicast mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (n->alluni) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_ALLUNI, 1);
+        if (dev_written < 0) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns non-multicast mode
+     * off by default.
+     *
+     * Therefore, QEMU should only send this CVQ command if the driver
+     * sets non-multicast mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (n->nomulti) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_NOMULTI, 1);
+        if (dev_written < 0) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns non-unicast mode
+     * off by default.
+     *
+     * Therefore, QEMU should only send this CVQ command if the driver
+     * sets non-unicast mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (n->nouni) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_NOUNI, 1);
+        if (dev_written < 0) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns non-broadcast mode
+     * off by default.
+     *
+     * Therefore, QEMU should only send this CVQ command if the driver
+     * sets non-broadcast mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (n->nobcast) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_NOBCAST, 1);
+        if (dev_written < 0) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
     return 0;
 }
 
-- 
2.25.1


