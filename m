Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4922374E1FE
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzws-00058v-53; Mon, 10 Jul 2023 19:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwq-0004zh-DU
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwo-0004vv-Tf
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SuoEmdvJLF1kbhsp7zcp3gnkEzxAK2svLYwoxlfO4Y=;
 b=aUM82acjs9uxU3X2nRr5HL9QOnbkfwRqJct4/qsA0+MVVTEQDn1a/Mt5jfU1onSenbv20O
 sMRT+ofVAXaFZq98sq65D/phK24/XBvTYCDEVkuuikDKpQMS6NWqWKFCdw1Yg9pzrK/aaq
 OjmuHCdz8IgzFqok0o11nfD64SGfh0U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-JzoOHrggNhuiuth2COv3CQ-1; Mon, 10 Jul 2023 19:05:37 -0400
X-MC-Unique: JzoOHrggNhuiuth2COv3CQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso29885605e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030335; x=1691622335;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8SuoEmdvJLF1kbhsp7zcp3gnkEzxAK2svLYwoxlfO4Y=;
 b=CMwq9Nnae/OpwoQS6rUByS6Zr1VbGjVVdPm44jlbAatK3EEfh25FGXZJhNxLGLJ3O6
 xZwhKHtVwu067ZpfE5Pd1pBXA7XMM+dcLFTB2kr/TMIHnR+n2E6HcXDP3v3GWnmZJl/f
 7VVnOv+6i8i4/ICvJgMHbSEEVbxsb07A5xPQHigrD8aj+2BTP3DdCAiOgkLF0vPisWB7
 j0Lgt1101bj/zytAP8T2iAb9HhbQo7wScrfNdklb+HnhdskANwFWFCg9ktmsB9NpvJrk
 /exvUbEZGGu6GvPCqSQihAlKc0MdM716sKU5YfyxSSv3wI+DYBkBJ7T2cSMAeVlMfHNG
 J5RA==
X-Gm-Message-State: ABy/qLYq0fbQG67g1m38kpT3zvPT+rCk/Z/yziqR6x6riFMABxDHeavT
 870poOII9ZQecJIT64/0hhlEv//ksuHMp/M0LQ0bgHv9a0UI2gzCAeQMqBpXfm3P7Ru3Z0RA8b/
 mQW67HTmff5sK0Q6SmkemVdDT9/F5bNaOZI+eKXcaMUBMxWKtju3kQx4E/FI3xCe00PpM
X-Received: by 2002:a7b:c7d1:0:b0:3fa:9590:a365 with SMTP id
 z17-20020a7bc7d1000000b003fa9590a365mr11036862wmk.17.1689030335028; 
 Mon, 10 Jul 2023 16:05:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEUncl2xjLuAfv79XMuvzE8Uknd8OnTNCC83EDohK2+6D9aazUuIYwNA+Iv8ICsrZJqquvMnA==
X-Received: by 2002:a7b:c7d1:0:b0:3fa:9590:a365 with SMTP id
 z17-20020a7bc7d1000000b003fa9590a365mr11036847wmk.17.1689030334748; 
 Mon, 10 Jul 2023 16:05:34 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 w22-20020a1cf616000000b003faef96ee78sm11348818wmc.33.2023.07.10.16.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:34 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 66/66] vdpa: Allow VIRTIO_NET_F_CTRL_RX_EXTRA in SVQ
Message-ID: <d669b7bba22d45cb9e5926d63541e52bde1655dd.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Enable SVQ with VIRTIO_NET_F_CTRL_RX_EXTRA feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <15ecc49975f9b8d1316ed4296879564a18abf31e.1688797728.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0c1c0760a7..9795306742 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -111,6 +111,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
-- 
MST


