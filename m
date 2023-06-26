Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1953C73E129
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNa-0006P9-Oo; Mon, 26 Jun 2023 08:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLr-00038t-RQ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLq-00039z-5s
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J650xI4G9TbYj30OOeoyARfbG5oUdRxwp2CGxYRPG7o=;
 b=R4rb6wF+8zcpF7fwHc17nwZj5fNqHM0ySWI+B43vGwsLUjN7x0G/Ub1KCWOQ6pQMxmQeTD
 qaYcnNQk9CN4jzZYdK/zoJmsnUs7mr1QvDM1zb51n9UNleM+O2gpjih0pMpgh6NtS676hC
 wZUPC2AdYomW56/CBWP7s1hAALxAfVs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-vZvDKhLJPriFwCuE-3FG_g-1; Mon, 26 Jun 2023 08:29:47 -0400
X-MC-Unique: vZvDKhLJPriFwCuE-3FG_g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so15664035e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782585; x=1690374585;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J650xI4G9TbYj30OOeoyARfbG5oUdRxwp2CGxYRPG7o=;
 b=MEpQ+PYiLzXzu200TB5blu93BF6YeS8ba4NFa/2mLdSCNLxlnE2I723HlRw3KiRbEi
 MH36xCctXbSaUPEcTtboz288hthtX7E5+TYIzNle3TYBURTO7upBuNFiP5vaZd1Ff2Bb
 0Iynf79+9u5SasGhUXReiXrc+V6tw/u2ZMtnCdCa2fsweqmsaA4LUguaqEhEPnJ44hR/
 UgU/RV7e0HFKZzLuUQDAPiPdV8CZx8o7z0IYD8Z9ImJXPUAmQptF7fqQBhMexQ6uWC76
 8QPvbFNUrBSs31YgaleOqAKVhQWjeGVbFVYJRZEe5Tv85J6FWMz/SagRn5TYjKjuWTgb
 xWJw==
X-Gm-Message-State: AC+VfDzkpUOQCBLksO62sTkNE3/zWJrtBcasJ7fxpOfBO8RpbieC8GyX
 8R8g+GnvYMIQazKwBfJFyQH9+zzOdwV6aXW9JMYY3voLW1mFND7eLB16APEiK3tqn5l4NId5oS8
 qJeGvlmneCZBZ9LCbwuhw4lcAo4pvUn1Hofonu5MpOTfMttO7SjDJG8l2d1aLHkLNYQuK
X-Received: by 2002:a7b:c411:0:b0:3f7:ee69:869f with SMTP id
 k17-20020a7bc411000000b003f7ee69869fmr19500960wmi.5.1687782585488; 
 Mon, 26 Jun 2023 05:29:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7M0i38svu/cKxe4E1BdDOXhvDq6vFC+FAnnZIL1VkAl3x2DJdp+VdgKe97HPF0AP03eEtVTw==
X-Received: by 2002:a7b:c411:0:b0:3f7:ee69:869f with SMTP id
 k17-20020a7bc411000000b003f7ee69869fmr19500947wmi.5.1687782585184; 
 Mon, 26 Jun 2023 05:29:45 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c219100b003f809461162sm7534131wme.16.2023.06.26.05.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:44 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 38/53] vdpa: reuse virtio_vdev_has_feature()
Message-ID: <056827a6f832498b4d5513df51ffbeaafe91a6da.1687782442.git.mst@redhat.com>
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

We can use virtio_vdev_has_feature() instead of manually
accessing the features.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <ff838d30206209fd865511b16ffb34cc0d5e8d8f.1685704856.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 8840ca2ea4..c3ef0139a6 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -629,8 +629,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
 
 static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
 {
-    uint64_t features = n->parent_obj.guest_features;
-    if (features & BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR)) {
+    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
         ssize_t dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MAC,
                                                   VIRTIO_NET_CTRL_MAC_ADDR_SET,
                                                   n->mac, sizeof(n->mac));
@@ -648,10 +647,9 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
                                   const VirtIONet *n)
 {
     struct virtio_net_ctrl_mq mq;
-    uint64_t features = n->parent_obj.guest_features;
     ssize_t dev_written;
 
-    if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
+    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_MQ)) {
         return 0;
     }
 
-- 
MST


