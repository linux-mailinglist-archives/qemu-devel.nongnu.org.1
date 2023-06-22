Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A147395AF
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 05:03:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCAaJ-0002T8-I5; Wed, 21 Jun 2023 23:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCAaF-0002SU-NL
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 23:02:07 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCAaE-00016j-5O
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 23:02:07 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6687446eaccso3640382b3a.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687402925; x=1689994925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGgU1VjcNeGya6YM+UOz4L9JIVFCsGHPFNHnhTmf+vc=;
 b=ogFj0ofnIqiOePL2jtxNmvn9zTLWB6ZH13nuVyHgoNyoMuKkolaapRHxf0e7vsxC55
 CTTMDFUoTdJ9gXUWU1fPXBSgCUId8R329h7EVnMhi+RTibOYsqfJi85uBWZLBYC9YlsL
 M1AzpDKxLha9fv68Ye8jGnBrChnK+LPoTd9Q4Pk5Sgr4RYDbHNqcpbMr+EVCr5kSMO2k
 TGOxPPkyh3EdV17ATqqcjXsVSpMV42STEO9w5jVLVM9Nzg9hn1EgNncKm7Suys7xItLQ
 i9NQOavp1UqJannezfRI/u5L/FqzQhu25RZSxvA/sISx6jpSesJ8NFzUVdbsCka8cFKh
 gKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687402925; x=1689994925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IGgU1VjcNeGya6YM+UOz4L9JIVFCsGHPFNHnhTmf+vc=;
 b=hYtyWyIPVcz8FlLOmew0WgvlWM7bAt3OwJq/hP+0bRt0UG5CkG2podFGzqdKAewIBU
 e+ygUnP5Zs72yI5j6zBbGrWs3KdQNKGS6d4Ya/aKfoh/AwSjKF535YEOJggh3dmbebFt
 PdyLPuU7YVjY0DWx3brhPcghUC/H28pHkI20nFyHTOvL6tfvGnFonC2XZ5csbWjKWM8r
 kpkI33EpgmBIuu0jhtSUnmN9GhMI+y0w0JmMehJ6qU85/UZLpoiRP1uZivMr6l1xcGcu
 IUUQUvofvfYnFF8iFe+4K59FjdZbWtg/Cm/97A7q9sizfZYiiNmCGBY5/w29GevOB9h8
 UewA==
X-Gm-Message-State: AC+VfDwGBGmD0qYfnn2v77naGXNppksPVLSC++WpjTf0vwVqrYQSg/6Q
 1uyYcJWoDRuuTWtu6WX6ydk=
X-Google-Smtp-Source: ACHHUZ7eOd+njWzk6twHLJLM6fd6MRF81dXURXpwKpvvkvUPNllE3wYyRmHb7Wem+yFUdyomnv8yVw==
X-Received: by 2002:a05:6a00:15ca:b0:66a:4fc7:ad04 with SMTP id
 o10-20020a056a0015ca00b0066a4fc7ad04mr2629910pfu.14.1687402924541; 
 Wed, 21 Jun 2023 20:02:04 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 t9-20020aa79389000000b00643889e30c2sm3517500pfe.180.2023.06.21.20.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 20:02:04 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC 1/3] vdpa: Restore MAC address filtering state
Date: Thu, 22 Jun 2023 11:01:42 +0800
Message-Id: <00f72fe154a882fd6dc15bc39e3a1ac63f9dadce.1687402580.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687402580.git.yin31149@gmail.com>
References: <cover.1687402580.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42e.google.com
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

This patch refactors vhost_vdpa_net_load_mac() to
restore the MAC address filtering state at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index ecfa8852b5..10264d3e96 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -651,8 +651,45 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
         if (unlikely(dev_written < 0)) {
             return dev_written;
         }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EINVAL;
+        }
+    }
+
+    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
+        /* Load the MAC address filtering */
+        uint32_t uni_entries = n->mac_table.first_multi,
+                 uni_macs_size = uni_entries * ETH_ALEN,
+                 uni_size = sizeof(struct virtio_net_ctrl_mac) + uni_macs_size,
+                 mul_entries = n->mac_table.in_use - uni_entries,
+                 mul_macs_size = mul_entries * ETH_ALEN,
+                 mul_size = sizeof(struct virtio_net_ctrl_mac) + mul_macs_size,
+                 data_size = uni_size + mul_size;
+        void *data = g_malloc(data_size);
+        struct virtio_net_ctrl_mac *ctrl_mac;
+
+        /* Pack the non-multicast(unicast) MAC addresses */
+        ctrl_mac = data;
+        ctrl_mac->entries = cpu_to_le32(uni_entries);
+        memcpy(ctrl_mac->macs, n->mac_table.macs, uni_macs_size);
+
+        /* Pack the multicast MAC addresses */
+        ctrl_mac = data + uni_size;
+        ctrl_mac->entries = cpu_to_le32(mul_entries);
+        memcpy(ctrl_mac->macs, &n->mac_table.macs[uni_macs_size],
+               mul_macs_size);
+
+        ssize_t dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MAC,
+                                                  VIRTIO_NET_CTRL_MAC_TABLE_SET,
+                                                  data, data_size);
+        g_free(data);
 
-        return *s->status != VIRTIO_NET_OK;
+        if (unlikely(dev_written < 0)) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EINVAL;
+        }
     }
 
     return 0;
-- 
2.25.1


