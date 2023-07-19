Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E6E759981
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:22:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM904-0001F3-VW; Wed, 19 Jul 2023 11:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qM903-0001Ea-13
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:21:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qM901-00037W-EP
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:21:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so73290545e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689780116; x=1690384916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iu/VH6iMKuUxxyQPM1EhE4e/T9vxFBVOqC59TnKMtyQ=;
 b=WUTDKd8TbEhJueZvuOYPwID+DQ2XrsI3a88d9dkXST2jakzPscYXJ81+l/lM3R4Pgz
 w8ddNhRkLouvrBOjSsuoAS0UtZ2GquxPw7GEkyw+/n+3PVqieD/z8Pzp7WudExkyE0f5
 WS2XYC+oxNxPMR2INS6CsXeDP5xvFkKMF5TJ507P2uOmICE5Xb/GgO9xGldBKNQMNy/J
 B1phAr+sl8vviQsY2zCdb3iCfIrJ5XWyPmfp2eX6mxehjFzzwe4zbM4roT8u92w6+FoV
 dZglU1pu0ScG6Hdgr9H4x2hBhKjd8KRlSH1BONtw6OJuYG27cG/U6D79rvZQoiXihLew
 3zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689780116; x=1690384916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iu/VH6iMKuUxxyQPM1EhE4e/T9vxFBVOqC59TnKMtyQ=;
 b=dQPhypq9a8s4np2OHZY+y9UFpb2xNBPyRHlA2TIMUqrFP86mpn0iSm1NvmYkHaBgNA
 Ba/oVTyiUlcmTSfBmOgaNs8eEmMrn59rdmpmmNMg/zv4lw9UposTmUbnjX/RJVh4iuFs
 iHYBxBbnUX1zAv7oNqkfU4bu20OZxtkL7aCFE15rvGZ3J5O4n8M8jAO+o+H+/yabku4p
 bDB5AZbHpf9DBT1cmzJxFY90rfADvZNGTCBJYcUBQBbKmhTCt/k+mpdEFcDIhPiBxYD5
 OoZ7bKgw0VA+XA1Q0lU2APALHlaVadH9oC3YmSAIEIRir/yZTtmIN6JiwnQ1tbmxdJ8G
 vzGA==
X-Gm-Message-State: ABy/qLYFfh/vb4c34BugjX1QbLi/I0jSgumpVN6XZcqhtNT3REqE1P5p
 emG9XvknCzeOXKt6eV4ulfrGBA==
X-Google-Smtp-Source: APBJJlGZqaEpRiGHMCbqve7H9ZjqMygBqShm4J+GH8cSFo/0sbCWkky1HdFMXNTmuUtObKSmEthGDw==
X-Received: by 2002:a1c:7c04:0:b0:3fc:193:734e with SMTP id
 x4-20020a1c7c04000000b003fc0193734emr5196919wmc.32.1689780116062; 
 Wed, 19 Jul 2023 08:21:56 -0700 (PDT)
Received: from localhost.localdomain
 ([2a06:c701:46e6:7e00:c5bb:d943:dc1b:8245])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a5d6349000000b0030e52d4c1bcsm5626775wrw.71.2023.07.19.08.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 08:21:55 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, mst@redhat.com,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: yan@daynix.com,
	andrew@daynix.com
Subject: [PATCH 2/4] virtio-net: Added USO flags to vhost support.
Date: Wed, 19 Jul 2023 18:21:37 +0300
Message-Id: <20230719152139.1316570-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
References: <20230719152139.1316570-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::333;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Andrew Melnychenko <andrew@daynix.com>

New features are subject to check with vhost-user and vdpa.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/vhost_net.c | 3 +++
 net/vhost-vdpa.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b958d6363..57427a3997 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -78,6 +78,9 @@ static const int user_feature_bits[] = {
     VIRTIO_F_RING_RESET,
     VIRTIO_NET_F_RSS,
     VIRTIO_NET_F_HASH_REPORT,
+    VIRTIO_NET_F_GUEST_USO4,
+    VIRTIO_NET_F_GUEST_USO6,
+    VIRTIO_NET_F_HOST_USO,
 
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9795306742..1dca37aae2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -75,11 +75,14 @@ const int vdpa_feature_bits[] = {
     VIRTIO_NET_F_GUEST_TSO4,
     VIRTIO_NET_F_GUEST_TSO6,
     VIRTIO_NET_F_GUEST_UFO,
+    VIRTIO_NET_F_GUEST_USO4,
+    VIRTIO_NET_F_GUEST_USO6,
     VIRTIO_NET_F_HASH_REPORT,
     VIRTIO_NET_F_HOST_ECN,
     VIRTIO_NET_F_HOST_TSO4,
     VIRTIO_NET_F_HOST_TSO6,
     VIRTIO_NET_F_HOST_UFO,
+    VIRTIO_NET_F_HOST_USO,
     VIRTIO_NET_F_MQ,
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_NET_F_MTU,
-- 
2.34.3


