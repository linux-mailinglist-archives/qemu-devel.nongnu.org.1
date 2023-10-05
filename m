Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 652AC7B9A5A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFGh-0001YB-W5; Wed, 04 Oct 2023 23:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGf-0001Xd-Pj
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGe-0008DE-8d
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0n/b+8AZz3jcidGbH0sE58APwKjUxPw2/iP69uivWYc=;
 b=Dqa9pNlFdkPNeEInU93smJTRhsOhXqMnNGDREyZp8RLRQbbIjGmd+dP4xXLkIEweJaSzJM
 yqOtpHDwmrD3pn96pqyAwaAUP4M1/7FPUnGUifDYMN2rTD6fR4X0rlVEEz/DSOb6JLVa+9
 2Ti8luE4nY7rOQ9mC/cqPuJ3sdXSXcY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-YRGGT-QVNA2hgygPHSXQxw-1; Wed, 04 Oct 2023 23:43:14 -0400
X-MC-Unique: YRGGT-QVNA2hgygPHSXQxw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4063dd6729bso3749165e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477392; x=1697082192;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0n/b+8AZz3jcidGbH0sE58APwKjUxPw2/iP69uivWYc=;
 b=Ztw9/PWOuPsxHcHkCJru3tN+AHnImgHSg0SkgULbly5c6o4VAnOLw3VdjJsb4D8yfD
 rLYs7Hfe8gkZUkbB7AiewxIm+Bm/QK5kMqx8qJQgx1JFETq8Hi2zpi7KzjPO7TqDH7CM
 nXjCcPO2x2CcfTei1gC+RAwDVSnOdeAlf9u/YXcFpEVpODxA4EoDj6Ny4Q0jOlwmSDym
 XThe2cDFiTPNGHsRAumgITFhDyYZOYqm4OxcqyneG72xyZk3L0wkeG4ORjQ45VZJ1AEE
 m7Mz9zdZJHXa1/1EW7ykkJjPCF1/YX6riZo3vBKoR3yjv4M0sX2TYGNilhQyrnQrkAJP
 XLAQ==
X-Gm-Message-State: AOJu0YypcXPWVQfj+Sb3dwOnKXt1I6XqLPIHmVGYJI6RKnvJx0Spdctw
 BxxXRvKBjdmOUbj311ElDJg7rfJzw5uaWsNFzB1ai7vt8A5DvEpTWGDlBrHgjiS9DO9UAS7QmRA
 fLkFSpu/UWYq4KNdX+tZzKHEST4DfPlWpb8Cg666pDAjQ9rZ3uWk2beq/3dj8RyLfqbxm
X-Received: by 2002:a7b:c4d6:0:b0:406:7074:301d with SMTP id
 g22-20020a7bc4d6000000b004067074301dmr4355673wmk.11.1696477392309; 
 Wed, 04 Oct 2023 20:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZbbiZVasm5u+nRwSGWUSOBs1MqAkRTUXiR5ZC8osGGLVOTlMc3sixhg7jWTr75KlfP9GRaw==
X-Received: by 2002:a7b:c4d6:0:b0:406:7074:301d with SMTP id
 g22-20020a7bc4d6000000b004067074301dmr4355656wmk.11.1696477391939; 
 Wed, 04 Oct 2023 20:43:11 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 m16-20020a7bca50000000b004064ac107cfsm534428wml.39.2023.10.04.20.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:43:11 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:43:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 12/53] vdpa: Restore vlan filtering state
Message-ID: <8f7e9967484dec2a727c24a509962ca3a4f5dad4.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hawkins Jiawei <yin31149@gmail.com>

This patch introduces vhost_vdpa_net_load_single_vlan()
and vhost_vdpa_net_load_vlan() to restore the vlan
filtering state at device's startup.

Co-developed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <e76a29f77bb3f386e4a643c8af94b77b775d1752.1690106284.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4e94c50bc7..8648d86f64 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -968,6 +968,50 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
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
@@ -998,6 +1042,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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
MST


