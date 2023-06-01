Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F7719604
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:49:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dzg-0002Y4-GC; Thu, 01 Jun 2023 04:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dzQ-0002Qp-Hl
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:49:00 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dzO-0006II-Qj
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:49:00 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2562cc85d3dso392007a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 01:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685609337; x=1688201337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ued2PGntEbVyYE+XZjWv3o98NO0iI/oUAsMZR1ODtOU=;
 b=I4D0laUO/QcxW5eeovEw4NoWI5cXqNZwHZgrWkH5OshUvD6zpoLG3nOdaMWMG61h4U
 EjK/XPUWBWTRNY98r6rx7XZ0E47SL2b1kwDYWRpkQXuPt1e/FP//5EhPWhJTE4Ue1+qB
 3qIcFw2SvUmM1/EbQFN9VQ06cEktbwC2jXBZNDk4ZObTiENp6FiVHy6m9CaMkshSMIPe
 iJwSg7FR2sg2wgL07R+2b/sxO7ImiSUHtnuPf+52/vegyKat9WL+LTmsdKykRgdk5GYL
 egBWYkhtPezt3B2syh4ALPOA1r4W8eMWd3zZPcxTMGwN08xHHux2bq3wqRV8aB1hD/lf
 +gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685609337; x=1688201337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ued2PGntEbVyYE+XZjWv3o98NO0iI/oUAsMZR1ODtOU=;
 b=NTxbJzWuwV3uPfXUKmw3kdBnQ5KKfv5fA5u2Wt34LCkx/FlSAjBec2+vQG+3DXS2up
 a6vZjjFxfN5C6+2kyxjFjfbYW7D4UD820Dd0MlJCeZMGnUHp5chU4UDuBoGl7HN2AS4O
 8LJlfXdLr0UZT/GIfrmEE6Gpfk5K54NYkMx8GEYYX+qW0VjW4LuADdZxu0YwgMUb/7WJ
 Bamss9TvBaAZySXIiSu54mp0zOlMHE8ReZMoQOBSyR7U0vJbnMbewEK+mwg3Cw3zV9A3
 Nss9Z90iGKO8VBGMuAgYH7guuJ7ygxw1IP5+lv3hrmMqI1PalGgB4mpLb/sd/9l9Mom3
 g7cQ==
X-Gm-Message-State: AC+VfDzQWQSUwG6p7U+AW6AtnwfOa93Te0huE7w6oXhNOx9uxjMcyGms
 bp2S9/Qy0MARqkjGFzjqUce1UHT0BfJkxRYI89A=
X-Google-Smtp-Source: ACHHUZ5FFc6VCsvQ12WtnSqk6cuUcw02N+21njFkA9pxkKYkWO+1VKGsSDQlZ6o3bIMBxdKCpLejjw==
X-Received: by 2002:a17:90b:4f85:b0:256:87f4:432a with SMTP id
 qe5-20020a17090b4f8500b0025687f4432amr7625270pjb.18.1685609336753; 
 Thu, 01 Jun 2023 01:48:56 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 g129-20020a636b87000000b0051f14839bf3sm2681038pgc.34.2023.06.01.01.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 01:48:56 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com
Subject: [PATCH v2 5/6] vdpa: Add vhost_vdpa_net_load_offloads()
Date: Thu,  1 Jun 2023 16:48:19 +0800
Message-Id: <b98884174e18f525c4d7b3c84839fbbe333fcd51.1685584543.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685584543.git.yin31149@gmail.com>
References: <cover.1685584543.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x102f.google.com
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
 net/vhost-vdpa.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e907a3c792..0e647886d1 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -678,6 +678,40 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
+    offloads = cpu_to_le64(n->curr_guest_offloads);
+
+    if (offloads == virtio_net_supported_guest_offloads(n)) {
+        /*
+         * According to VirtIO standard, "Upon feature negotiation
+         * corresponding offload gets enabled to preserve
+         * backward compatibility."
+         * So we do not need to send this CVQ command if the guest
+         * also enables all supported offloads.
+         */
+        return 0;
+    }
+
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
@@ -700,6 +734,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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


