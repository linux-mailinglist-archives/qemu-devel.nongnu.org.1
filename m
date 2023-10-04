Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E213E7B7A9E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUv-0005E8-FK; Wed, 04 Oct 2023 04:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUG-0003L4-EH
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxU2-00011p-Re
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0n/b+8AZz3jcidGbH0sE58APwKjUxPw2/iP69uivWYc=;
 b=f8lUPXQkwbMF13Be5DEikUqz1/7wyNCGd149lcI3fg4tVTtI+lgt/txXtzghT+5JxJiWzf
 hKy8avATfxG/0IZg3m70EHCgiX/SGUFni1pFE/ygZTcLesePMt2/biXBTFvMmDk3CUVQQd
 bcSuG48sjdeQaHeIyoT4KesH1TE3sLA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-01e4wyOcMMSPXfHP1yNviQ-1; Wed, 04 Oct 2023 04:43:51 -0400
X-MC-Unique: 01e4wyOcMMSPXfHP1yNviQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4055ce1e8c4so2937455e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409029; x=1697013829;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0n/b+8AZz3jcidGbH0sE58APwKjUxPw2/iP69uivWYc=;
 b=Jv8ezn3ngfLdoSUe1DJFk+qVmVccJIu8v5pzy81cZyBxImIsQX5iZrSQSlXt8mHXff
 8VgyPOYZ2g+BjZcrubLGUC2ec78voynhbF6vJ3VdcExCRPi5Q12XKcBb7sbz0ViRmdd0
 XLdwVtvRHTQtYbnROKeVErtrvywuzeSDBfQJ7pWpW1NthGWcB2QSMJ2QIxm8nzDOCEyE
 MwjV7pgIw5GJduMavELr/q+YS4oJpfDcDo5pqoHqzZYIyghucFeJEWhFOWV0N/iSP+/f
 gl4VuyYf/Ww8buSzuFHs6MB09ob7nkvqfTRBs2M0WB9LP+IrFIJzN9DalGC6NvJeyvb0
 wHlQ==
X-Gm-Message-State: AOJu0Yyvx9G1tXxwNybdyF6xn+2T9dmY5UaAbN8+ONGUvf+I48NoGQNI
 PqGJl85Cc2dPLZddlJsXe8pRhdwkTFcFHdGTXVT7Mz4ZzplXfwhX4abmuJR4ohXQvJYTxqhbSx9
 DOeiXSvQo+8YoCCFO6g7ovd94gFgswMVSPub+fIrIB0DUw7/foAie1EcPIxrHoBqjypCq
X-Received: by 2002:a05:600c:4f4b:b0:403:aced:f7f4 with SMTP id
 m11-20020a05600c4f4b00b00403acedf7f4mr4040306wmq.12.1696409029777; 
 Wed, 04 Oct 2023 01:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjFpPkq4DuL2b3lKh6dUy9bBhTDXXwyYdtH3WOjmDWStTSDQWHJH5gP5iQGWlBEUBRf5nfJg==
X-Received: by 2002:a05:600c:4f4b:b0:403:aced:f7f4 with SMTP id
 m11-20020a05600c4f4b00b00403acedf7f4mr4040290wmq.12.1696409029536; 
 Wed, 04 Oct 2023 01:43:49 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 x2-20020a1c7c02000000b003fe23b10fdfsm928723wmc.36.2023.10.04.01.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:48 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 12/63] vdpa: Restore vlan filtering state
Message-ID: <4073c19d4496dbd5de4a998375aa60871497c36a.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


