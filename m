Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A775E1B3
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 14:10:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNXuM-0006h2-W0; Sun, 23 Jul 2023 08:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNXuK-0006gT-Px
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 08:09:52 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNXuJ-0008AC-3A
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 08:09:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-668704a5b5bso3268182b3a.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 05:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690114189; x=1690718989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6MNpmpr0JlX5y+mb1RZNWk8OhHa3Y3TekRln1LZnlY=;
 b=j2Ae9eIX2HvP5H6ZT4RwrclRcn0N4TkZ6oazKAJXeuZIvit4sPFUsSJCoI6720L4fs
 YaBACw28dCk7ik3HQaCzGi1BojkogLwFPe90GsKGvuRoajK7SpIJWEdKOqKVUVntkUzq
 cWh9VTZdsUcnCLwtNE83lfI+Jvbj9c7YbjzyhaGIlmAAazzun3gsaPdHCGz+nnxocoyE
 BbHBv699Q+Qy1hH1IJOj21T6inaXx9a+5JqdB42jsVcClfsJOI6R0AVa3Re+KEXRWVrw
 gOUVcRBTJJ5LJhMuxoNFc94CWDfN6oCZ5MmPIq11hQh+yLu90sfuUbtn3ShHDADGVQyf
 wBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690114189; x=1690718989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6MNpmpr0JlX5y+mb1RZNWk8OhHa3Y3TekRln1LZnlY=;
 b=LsiI7vCddVKUyAVbKjzl6xCgx17+IdtRWUiOuVwO3lHYigkRZa+CJ+Uj03PjNZaSTR
 lbldxheBAReAMGSeEZLa+qP8xDHlv/jFS9vB1Q/VhbKqsEqu9EWzIc4J5PF72z9zcZB1
 wn76uZYMbQu6RZC9gN/y8u3xnCSHkEh+QKe0ngjh9DGQ/pPydMc/g+ZJ90DXMYEJvHkn
 OHKokj62Yk1fXwxhUbQhwJ+148vAewvVLQEXuoA8ybGApLrXTRTLOrecDNP7bJLmJvK+
 LMzilbo99pYOq5u8uRl/NJ01kAA7BShOs0/8Txou6fyGRKD8I4ANrNvpZMvOEnsTn1xX
 6bVQ==
X-Gm-Message-State: ABy/qLYpHhGgVHyV7+nRRWgAfFE2J94IlNisAgd9sBk7TPcce2daX+2K
 z8N4R9KT/4eJ+QlIZiYHORerSjar2bCLiEKcXqU=
X-Google-Smtp-Source: APBJJlHAfcmTeeXWdn49nlBfySMjzPPORdHr50Pc4/RescHgFX/AQGiqp3hieM+16E+mMqFualdw1w==
X-Received: by 2002:a05:6a00:844:b0:67b:8602:aa1e with SMTP id
 q4-20020a056a00084400b0067b8602aa1emr7852582pfk.28.1690114189403; 
 Sun, 23 Jul 2023 05:09:49 -0700 (PDT)
Received: from localhost ([223.104.38.215]) by smtp.gmail.com with ESMTPSA id
 p6-20020aa78606000000b00640dbbd7830sm6095937pfn.18.2023.07.23.05.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 05:09:49 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 3/4] vdpa: Restore vlan filtering state
Date: Sun, 23 Jul 2023 20:09:13 +0800
Message-Id: <e76a29f77bb3f386e4a643c8af94b77b775d1752.1690106284.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690106284.git.yin31149@gmail.com>
References: <cover.1690106284.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x434.google.com
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
v2:
 - remove the extra line pointed out by Eugenio

v1: https://lore.kernel.org/all/0a568cc8a8d2b750c2e09b2237e9f05cece07c3f.1689690854.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9795306742..347241796d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -965,6 +965,50 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
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
 static int vhost_vdpa_net_load(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -995,6 +1039,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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


