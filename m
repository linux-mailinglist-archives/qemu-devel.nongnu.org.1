Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C8C758F7F
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM1ur-000082-3U; Wed, 19 Jul 2023 03:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM1ud-000061-Lp
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:48:01 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM1ub-00028c-9C
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:47:54 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b8a44ee159so40814915ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689752872; x=1692344872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0dk1wMkxNjWLjUCHUyq+4SMFlPjROSExPsMmBcqpSw=;
 b=IbkW86ohq3FjbdsLYQBVDrJBbL4mQN7HX/jMBHALJUWrlhWy19q6mXVyHaV5//8chk
 ybWaRHqLGgGCIvQDc9GcW8z4lD+6xvs64XFFbpdNdcX501K05eVa4g4LXU2JB0NWX2de
 ZpQlhE2VRdbfiZOYk29H0gMsOhfv7iRoHayLII3ZmK2XStIZg5KrFLtMGb8T/lgGV3RO
 qHh0ANiMyKX70jcg5m6uUBYjj/QSZdPqLSNc3x2PMcc2loKVizBF2aGgC93HheUxYekB
 2LWhOPOFD/OlKEj/aarnjBVbC3/g6henQASwwgGVyzaQsk5HZ4GiLnTVW6dvjph6WPpB
 DWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689752872; x=1692344872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0dk1wMkxNjWLjUCHUyq+4SMFlPjROSExPsMmBcqpSw=;
 b=TbDD2/X+CgqxHtMRc0TC+uZic+Xt2HH9FS+IwjFDesy1xdVjKBQe1XGmfTOVQDEzmw
 xtSjbTeXbCRdu3ihr0vqgvHjKwE/kCZen1c8aP8rgpaNqWwcI3MXZnkudLXCsV3fBeI6
 QKNDY+lSyQ9RYUbq13pMbL/2oAiClZHfe9dYYmVB69hgt8tbrSL7BDgh4kzHJZPQ090p
 1Zk3nXeV3qb1JOKgdovleTcIQTkiB3zUKHoTJZP6hzc2kbVt5/A39C7iYLmJiTfAY8BX
 Lt69zcR8PuQaz4aEx1/tDyEq+3WW7/iHnkAxt42RHZ63G3ISNxPvkDOq34BTPaW7Z+8a
 AQjg==
X-Gm-Message-State: ABy/qLZvAAGpv+ed6AZczWjHugutPads6B1XBaqWnsF9gaD1Y+RUJkbQ
 j9RUoJZmYMA3ePNoYbHE3+c=
X-Google-Smtp-Source: APBJJlEd/D+1UU7fGPreXhyuEpwheKis8Nv8pT/yDoiU8/1A89a5uFwg7CuasBuKPnZNnkJu3eX5hw==
X-Received: by 2002:a17:902:c94c:b0:1b2:4852:9a5f with SMTP id
 i12-20020a170902c94c00b001b248529a5fmr19768475pla.54.1689752871618; 
 Wed, 19 Jul 2023 00:47:51 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 w21-20020a170902a71500b001b9c5e0393csm3156914plq.225.2023.07.19.00.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:47:51 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH 3/4] vdpa: Restore vlan filtering state
Date: Wed, 19 Jul 2023 15:47:30 +0800
Message-Id: <0a568cc8a8d2b750c2e09b2237e9f05cece07c3f.1689690854.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689690854.git.yin31149@gmail.com>
References: <cover.1689690854.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x632.google.com
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

This patch introduces vhost_vdpa_net_load_single_vlan()
and vhost_vdpa_net_load_vlan() to restore the vlan
filtering state at device's startup.

Co-developed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9795306742..0787dd933b 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -965,6 +965,51 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
     return 0;
 }
 
+static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
+                                           const VirtIONet *n,
+                                           uint16_t vid)
+{
+    const struct iovec data = {
+        .iov_base = &vid,
+        .iov_len = sizeof(vid),
+    };
+    ssize_t dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_VLAN,
+                                                  VIRTIO_NET_CTRL_VLAN_ADD,
+                                                  &data, 1);
+    if (unlikely(dev_written < 0)) {
+        return dev_written;
+    }
+    if (unlikely(*s->status != VIRTIO_NET_OK)) {
+        return -EIO;
+    }
+
+    return 0;
+}
+
+static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
+                                    const VirtIONet *n)
+{
+    int r;
+
+    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_VLAN)) {
+        return 0;
+    }
+
+    for (int i = 0; i < MAX_VLAN >> 5; i++) {
+        for (int j = 0; n->vlans[i] && j <= 0x1f; j++) {
+            if (n->vlans[i] & (1U << j)) {
+                r = vhost_vdpa_net_load_single_vlan(s, n, (i << 5) + j);
+                if (unlikely(r != 0)) {
+                    return r;
+                }
+            }
+        }
+    }
+
+    return 0;
+}
+
+
 static int vhost_vdpa_net_load(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -995,6 +1040,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
     if (unlikely(r)) {
         return r;
     }
+    r = vhost_vdpa_net_load_vlan(s, n);
+    if (unlikely(r)) {
+        return r;
+    }
 
     return 0;
 }
-- 
2.25.1


