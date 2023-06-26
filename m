Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4846A73E11D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:54:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNE-0005s9-QX; Mon, 26 Jun 2023 08:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlM2-0004LR-IA
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLz-0003Bb-Lb
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Rnc7xHoIJYK78sghEjyDjdFks1hD1FeSLcyQu3JIt4=;
 b=REqqO87xTkrp02syi2eXqxm4jjg6J0v3BoPfQAB/U9uHi/QLrM1GNdnC7V8TuSVDZvMjPC
 i3vNI/I8Qd3TB8PdmpyryX8dN160k1MKspDOk8s7fjMmuFHh25IKy02R1n3G0YcJBcR4li
 BrAMP6YG3CUYvjeFuQsD8Ica0g71Z74=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-J_HYQ2TPNTqVY5HnSnXlAQ-1; Mon, 26 Jun 2023 08:29:55 -0400
X-MC-Unique: J_HYQ2TPNTqVY5HnSnXlAQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fa96b67ac1so20460775e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782594; x=1690374594;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Rnc7xHoIJYK78sghEjyDjdFks1hD1FeSLcyQu3JIt4=;
 b=gxvXvsavhLfwEZydUrnS6P5+pK2PjRb+HscJeOvorXzJYhhsQ9f21HXsNj1T/Sqeny
 2Hgo8SWBXVa/xl4xkrZE0GJufudSeVjy6s/aBfBkuymq6g3IJAV7KM6yT3JMEeA6Ax7g
 1+LEu+HVmQ76ln3e0BCyqGRFTIAny2smo87BBji2+HuJcGnxwnx/kudJUa66cIQPWsKK
 LNWVjwr2UNKZ+3iGlBZcH8UBZy/3GfuTOhQ3guf+J6KJ/4R1qtdp8fRLyzJPrK4AkWrR
 PBnvz+2klnUFCDca2H5MMi0z1aGuF6/dZY5uSP3IN0kQiL3IZe84vFeuxG4wUTmNt4fD
 5Uhw==
X-Gm-Message-State: AC+VfDxV+Cj6wSvDDy+ZUaNh5cIi98KMqgmTawZYR2YzmSv5LqizJN1X
 vxyz0GjuEwlzyLxhYGmbhZW8Zaq6z5WI1P76yKazx5wjlzDjK0Riip8quFAkaFP5nrFr3TeA4Vw
 ejTjWIYxb9jdws0cK94XHJilsywF6uzADLs3ye6OxdW5oGQz6+zh44s02EG9Eh8yXxdH+
X-Received: by 2002:a05:600c:22c6:b0:3f9:b244:c294 with SMTP id
 6-20020a05600c22c600b003f9b244c294mr25415778wmg.35.1687782594247; 
 Mon, 26 Jun 2023 05:29:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7AuRyQX94iFaK4IMfPFyqnrXvfpMkWiZyF1nFy0OOfaAdrErIh7hpPdNec5xKBiJ0WAW5lig==
X-Received: by 2002:a05:600c:22c6:b0:3f9:b244:c294 with SMTP id
 6-20020a05600c22c600b003f9b244c294mr25415762wmg.35.1687782593982; 
 Mon, 26 Jun 2023 05:29:53 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003f90ab2fff9sm7571794wmi.9.2023.06.26.05.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:53 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Lei Yang <leiyang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 41/53] vdpa: Add vhost_vdpa_net_load_offloads()
Message-ID: <e75db550c1526f963c9cf2196a29c0907207d619.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Hawkins Jiawei <yin31149@gmail.com>

This patch introduces vhost_vdpa_net_load_offloads() to
restore offloads state at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <7e2b5cad9c48c917df53d80dec27dbfeb513e1a3.1685704856.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index c3ef0139a6..99d0445d90 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -664,6 +664,44 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
+         * Note that the device's defaults can mismatch the driver's
+         * configuration only at live migration.
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
@@ -686,6 +724,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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
MST


