Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F547200E9
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53Kk-0008L0-9I; Fri, 02 Jun 2023 07:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53Ki-0008KU-5Y
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:40 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53Kg-0007Gy-Is
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:39 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2565a896d07so872618a91.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685706757; x=1688298757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qcxgCXtqBx5DBEK6YoQwk5QCMI9bRJjdZFLaUSr1gU=;
 b=Nxr2+7qVUpB5uF7RnTyKkmmC94rXebELBQKlIfU5AyiBxdEXE2neKFJcvqaJlfrDzw
 lqglVSI9APADRVlkMK79V3+MUC3FmghqaB5IB5BY6LmzwkRE3xzQHyV7HkT14zDjPLPJ
 XGlwe1Rcohux46KiATwMOQJxrqnBF6vB/16hZv/OF05Yuo4jAqBJHvq/MUkDuaSbx+hF
 4DK7qEfxGqjI0dqXHn+WqdRMwS0tyxDWppEyX7UVfGQRkmCcabLTSDayzL+2Vre4DgjW
 T/Hf+3yTqRbL87DhIPVfra6ZuJr6TAIrH7jUolumTv3qOEX3YZWUkZH0LH6rSHF2bUrl
 UBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685706757; x=1688298757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0qcxgCXtqBx5DBEK6YoQwk5QCMI9bRJjdZFLaUSr1gU=;
 b=bepoclif0lAfxhTW1VBg7NGZBeZweLm2gLOnDAUd+xivK1Krobzr0GmtTlzrbtAMLD
 /2lpm+1pj3+xIzoTMyJOpjCJWydUphOmL9uRmaFozmHXv47zcSL55kLX1DiT6S7wa3nd
 vciX8lonk7RC7sJ7VhQA2uPRB3SwJL+Y2FKgpeRu3GIGOU5Mi2cBcpBAJhPsX10Yy5Fy
 YVKC8kBBW7JdT785IR/tpcW+qgLvT71pTzg+R/mS9SRSbfhcrtRC8yD75l4o+M1sAr3d
 z0MQzJJH72VjsDuYLwGHI7kFnoY5a4bxcOjmz/CNy3kqcoECP3KGckP9CcMPhLHAUUw2
 qXDw==
X-Gm-Message-State: AC+VfDzBHMY//9XG7Elns8mxVpDSWRJcjYN2DVLbA/GS0JBfZPc1HU9k
 c60rCfD7zQG+qk5AjeULmN0=
X-Google-Smtp-Source: ACHHUZ5BCxtdpuzf5wM99YT0OO+7im0id+W2mxzMcX4PZm+Xyh3Ln2pWeORzikcA/T2xZm0uJgT+cg==
X-Received: by 2002:a17:90a:3b0b:b0:256:4246:d94d with SMTP id
 d11-20020a17090a3b0b00b002564246d94dmr1161051pjc.3.1685706757026; 
 Fri, 02 Jun 2023 04:52:37 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 g13-20020a17090a290d00b00256799877ffsm1123319pjd.47.2023.06.02.04.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:52:36 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 5/6] vdpa: Add vhost_vdpa_net_load_offloads()
Date: Fri,  2 Jun 2023 19:52:17 +0800
Message-Id: <7e2b5cad9c48c917df53d80dec27dbfeb513e1a3.1685704856.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685704856.git.yin31149@gmail.com>
References: <cover.1685704856.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x1036.google.com
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

This patch introduces vhost_vdpa_net_load_offloads() to
restore offloads state at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e907a3c792..1a295af51d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -678,6 +678,44 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
     return *s->status != VIRTIO_NET_OK;
 }
 
+static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
+                                        const VirtIONet *n)
+{
+    uint64_t offloads;
+    ssize_t dev_written;
+
+    if (!virtio_vdev_has_feature(&n->parent_obj,
+                                 VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
+        return 0;
+    }
+
+    if (n->curr_guest_offloads == virtio_net_supported_guest_offloads(n)) {
+        /*
+         * According to VirtIO standard, "Upon feature negotiation
+         * corresponding offload gets enabled to preserve
+         * backward compatibility.".
+         *
+         * Therefore, there is no need to send this CVQ command if the
+         * driver also enables all supported offloads, which aligns with
+         * the device's defaults.
+         *
+         * Note that the device's defaults can mismatch the driver's configuration
+         * only at live migration.
+         */
+        return 0;
+    }
+
+    offloads = cpu_to_le64(n->curr_guest_offloads);
+    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
+                                          VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
+                                          &offloads, sizeof(offloads));
+    if (unlikely(dev_written < 0)) {
+        return dev_written;
+    }
+
+    return *s->status != VIRTIO_NET_OK;
+}
+
 static int vhost_vdpa_net_load(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -700,6 +738,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
     if (unlikely(r)) {
         return r;
     }
+    r = vhost_vdpa_net_load_offloads(s, n);
+    if (unlikely(r)) {
+        return r;
+    }
 
     return 0;
 }
-- 
2.25.1


