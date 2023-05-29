Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC4F714A23
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 15:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3clf-0001k3-9n; Mon, 29 May 2023 09:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q3cld-0001je-BP
 for qemu-devel@nongnu.org; Mon, 29 May 2023 09:18:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q3clb-0006QR-OV
 for qemu-devel@nongnu.org; Mon, 29 May 2023 09:18:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d2e8a842cso2473665b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685366310; x=1687958310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4YOrohZ88Ljh4QERVmNsTb3e4rc0UijJsYXUhf2B1k=;
 b=rYWDFTauBBZOC7bBRYzSvf7BDpf6XmlkAwMZimr485LbRGlgAcb/qF64kt0ZLFZbU9
 CV2pcMJA3Bp/+uuK/OUCnFSgtVA9KFkMdA5ELXheiC1LnRs3SpTS2gHs9DCk9zEkP8OB
 +4q+RC7Fn4RQIxMGq6Xr3UWWooRU0suAjAS6VLPUREvsl3RRlgbVp+nDwYUdHqijnlg9
 aBV+vwGAdeMksv8ILGIjd0P9EmUD1X96zNeOUHPydjai/iT1KQd5X7Qkx4X1DCAWshAm
 Wrfy570RbD+8FsLM5IMKYzSMyQmtD8WmWpzzV3SJxmrgPcYc2ccZB8th11E9a8q+eefw
 iv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685366310; x=1687958310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4YOrohZ88Ljh4QERVmNsTb3e4rc0UijJsYXUhf2B1k=;
 b=TLgY9vmH6DyoxyV2y3sWGiWn2LBuy7enauG7IgAkcW0YPoXGW6ab/uDJNnIaGYLfyA
 EEf9BIjUizCuc7k0Y+K2ChG73yuEaIj+mBGym2QY9x/snIsAlRDODl76lgJRUyEKUWbC
 oXwZGoWgfs4DP0Zvm1fPWlFlP8nffh95U3xTPjbkD9gCurY+v4Qy3QOgWfDtmxfVO5w8
 PSdifjQkbLUyde3VTZuzXSNSHGTeoXmikzKJwPwkdqy01C6C+X60WEuzAZ8EdBwpD+B+
 OVtViCxodZi3edLYXZvT0OW1xOau+9Y2cFHptEs1AxjEO1Ix6H74YCnmrzxlL5CLy3re
 dcYQ==
X-Gm-Message-State: AC+VfDyzuZ+U1toNOVxHLkNFaAy7odG9B3eruR5M/19NLAWsA1A5iHQh
 lukqOxII6rC4Pgab4k7OH7aHDJrqmliJZA==
X-Google-Smtp-Source: ACHHUZ5hIdbCcD3NVwRvT4qmdaoPZRKPwlkoQ27cydAnctmF3kjh8dChxyocvEbBST9YoyAEwpbrbg==
X-Received: by 2002:a17:902:db09:b0:1b0:3e2c:53cc with SMTP id
 m9-20020a170902db0900b001b03e2c53ccmr4291644plx.27.1685366310217; 
 Mon, 29 May 2023 06:18:30 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 x7-20020a170902ec8700b001ab1cdb41d6sm8197975plg.235.2023.05.29.06.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 06:18:29 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: eperezma@redhat.com,
	Jason Wang <jasowang@redhat.com>
Cc: yin31149@gmail.com,
	18801353760@163.com,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] vdpa: Add vhost_vdpa_net_load_offloads
Date: Mon, 29 May 2023 21:18:21 +0800
Message-Id: <ab861a8237c5e337bb0f969e1e8e761bc73901d5.1685359572.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685359572.git.yin31149@gmail.com>
References: <cover.1685359572.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x435.google.com
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
 net/vhost-vdpa.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 37cdc84562..682c749b19 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -680,6 +680,28 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
     return *s->status != VIRTIO_NET_OK;
 }
 
+static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
+                                        const VirtIONet *n)
+{
+    uint64_t features, offloads;
+    ssize_t dev_written;
+
+    features = n->parent_obj.guest_features;
+    if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))) {
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
@@ -702,6 +724,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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


