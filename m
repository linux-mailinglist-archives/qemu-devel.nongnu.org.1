Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2113674B447
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:28:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnNC-0000Y3-Sk; Fri, 07 Jul 2023 11:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnN4-0000T6-JA
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:48 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnN2-00075K-SX
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:46 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-55ba5bb0bf3so1378992a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688743663; x=1691335663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfZfag1JfSDpKsrmVxXiIq1XR8AXvbuoqO5vmNYxwj4=;
 b=AAQ7NeqH06r+Qm2mcDIktt5ZumaRY0byL8xJL5M2eiCy2hlnGv8M9OwB8zv8dXwYWV
 beJaPEWdQqtJmtwEf4AFYsYu/ZQnEYzz/i4KwH6L/kO20UhuTWt9vYXgJnvbFqFGtm/L
 t9mSNq2PAaBD3tzjeVZGAwD4Neoe8eG+ORfNLWbFaJ8s0dkHS3DnyH/f3YX3V+mP7qLU
 dSeuCQU9tqu7lT/MYr1T6+iU0j0dMQ3RC0s4mtjQqgGr4HBT5svOzdNYMF9RcnSIlUvj
 BavbzNSitcnS+3Wo5Mf+mfGutXC+qCiUVVr7bPuQdckmNXRYfg3mgixg8VkxVuMMsweN
 2ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743663; x=1691335663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfZfag1JfSDpKsrmVxXiIq1XR8AXvbuoqO5vmNYxwj4=;
 b=RY8AdFjpFEK/O8yyykb9mYpVcaAamZLZ22jJGgtsFYgMnqxDkyz7od+4ZSkQGtMRsP
 tFElfQ8vS0Z65uRDDQSZuJ4VkFjbc/cLEejmAjdGf9usKMI5nB1XSK3YEfkCHvMOFond
 FjjdL8DXz3bA4EEwl89OSEYUOijaWQS/pqxylYGLAAR4vOb+dr0GTvHtAYBjR+QUtvZZ
 nMyRs1nzpdtIaki+OHKcnKEPtMbb8k/78EkseakgZH4KN5PE/+zthJ+Hees9IgK0nS0K
 EHqwNzlkZ7VerkolILKp9b+ow26ECTOYOQwIDcNvzSQeQp/NS44uUho4+fn6Mzri9Nrd
 WzsQ==
X-Gm-Message-State: ABy/qLbdA9eXJEZH8cqLLRjym1AKUvCzT5QVgDKHFq/h70mvWmUFLneB
 vPxzC/ztvAMDA43ft/xlRpWSsB8UqETJGQ==
X-Google-Smtp-Source: APBJJlGi1acLqrUwF1N6tuouJQZ5Rgt6aMWeEGa1z/gafk/Apcl+bi4uF2N0UiBu+Y1WTSN9/zcPWA==
X-Received: by 2002:a05:6a20:9390:b0:12a:f4d2:3e25 with SMTP id
 x16-20020a056a20939000b0012af4d23e25mr8614423pzh.29.1688743663022; 
 Fri, 07 Jul 2023 08:27:43 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 u12-20020aa7848c000000b0065da94fe921sm3021526pfn.50.2023.07.07.08.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 08:27:42 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 2/7] vdpa: Restore MAC address filtering state
Date: Fri,  7 Jul 2023 23:27:29 +0800
Message-Id: <4b9550c14bc8c98c8f48e04dbf3d3ac41489d3fd.1688743107.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688743107.git.yin31149@gmail.com>
References: <cover.1688743107.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x535.google.com
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
v3:
  - return early if mismatch the condition suggested by Eugenio

v2: https://lore.kernel.org/all/2f2560f749186c0eb1055f9926f464587e419eeb.1688051252.git.yin31149@gmail.com/
  - use iovec suggested by Eugenio
  - avoid sending CVQ command in default state

v1: https://lore.kernel.org/all/00f72fe154a882fd6dc15bc39e3a1ac63f9dadce.1687402580.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 31ef6ad6ec..7189ccafaf 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -660,6 +660,58 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
         }
     }
 
+    /*
+     * According to VirtIO standard, "The device MUST have an
+     * empty MAC filtering table on reset.".
+     *
+     * Therefore, there is no need to send this CVQ command if the
+     * driver also sets an empty MAC filter table, which aligns with
+     * the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX) ||
+        n->mac_table.in_use == 0) {
+        return 0;
+    }
+
+    uint32_t uni_entries = n->mac_table.first_multi,
+             uni_macs_size = uni_entries * ETH_ALEN,
+             mul_entries = n->mac_table.in_use - uni_entries,
+             mul_macs_size = mul_entries * ETH_ALEN;
+    struct virtio_net_ctrl_mac uni = {
+        .entries = cpu_to_le32(uni_entries),
+    };
+    struct virtio_net_ctrl_mac mul = {
+        .entries = cpu_to_le32(mul_entries),
+    };
+    const struct iovec data[] = {
+        {
+            .iov_base = &uni,
+            .iov_len = sizeof(uni),
+        }, {
+            .iov_base = n->mac_table.macs,
+            .iov_len = uni_macs_size,
+        }, {
+            .iov_base = &mul,
+            .iov_len = sizeof(mul),
+        }, {
+            .iov_base = &n->mac_table.macs[uni_macs_size],
+            .iov_len = mul_macs_size,
+        },
+    };
+    ssize_t dev_written = vhost_vdpa_net_load_cmd(s,
+                                VIRTIO_NET_CTRL_MAC,
+                                VIRTIO_NET_CTRL_MAC_TABLE_SET,
+                                data, ARRAY_SIZE(data));
+    if (unlikely(dev_written < 0)) {
+        return dev_written;
+    }
+    if (*s->status != VIRTIO_NET_OK) {
+        return -EIO;
+    }
+
     return 0;
 }
 
-- 
2.25.1


