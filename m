Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D387455B2
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:01:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGDYV-0007Bg-61; Mon, 03 Jul 2023 03:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGDYJ-00079D-J0
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:00:56 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGDYI-0007HO-2N
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:00:51 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b7fb1a82c4so22482145ad.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688367648; x=1690959648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ha3IkVBd+fUFewyk5DQkD6w2X7LJOGWyyzCNhIUssA4=;
 b=EhSM43kVWAddwl/5Io+M75awcNWxFxmuTPkhkBv9FGlvcES6DZbokYajmTOraqz9Tn
 rAsrZz0HhXliAARg7Bv70bSM7fDYqPwazAEI8pQ/qu1K1ckHsFv5vBs5e1Gh5ZzUov8q
 tenf7CoR+dm3ricrdNKMOzX3DUwhAQH66hzoqpq9F8rUlbTsRoDF0vxNwVIYLRQkeP7Z
 Hex6wtDURKnaOGTY5XCW22uVELq1cq3F+ws8kQhDjKMXnhndzj3KR5Ks/sY9hYwCy4+g
 /PTeynUVbAYMyhD3WT5FiTgzfkRl0i85vCZZHeAH8u7khNLtfwJ+LBwVTKKfdKVryM6Z
 ziGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688367648; x=1690959648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ha3IkVBd+fUFewyk5DQkD6w2X7LJOGWyyzCNhIUssA4=;
 b=dmc09NBPXdL0UpZS40FlSwI5ikSrwuFv9WWy9ukPEPBCPooiScfKIByy7Klmu9svST
 WznVUoMd3FcJ5LFg4GcvQk4jog4PimN8AT6/LPs4H2PF4ilTXzKfOviU5Xqh4V2SmU5i
 NCm5L/EG7iukUfAmJ54OslmvXM478bUaycgZ2Ee4il3PuvIH7SkOWBu/XfbK1dxYWBAQ
 lkfJ3H5/KpgjsXqZncwZndwKrbKPX8ASTDzKr7cy8esQyy4INzgY88jAhJxkbkWORoKl
 5uBAkfzH9i5ar5SWAty8Xg7jqbaq7jM4FXora4PMPYbVVvj6jXDGTDWVuBioQKQcTI+V
 hRrw==
X-Gm-Message-State: ABy/qLZ7LeEC7ky8ILCYDYAt1ep5uCYgoTp8AJoIplNHk3O6iE57FIms
 hBXChN0D2eUXSyZitsZG5ig=
X-Google-Smtp-Source: APBJJlESW0//cl/sjhNNRYIGI8nuFDYpnniIGEuyDWNqO/VGxeoAzABNbeOWUPYt0+zUdCgy0CzzgQ==
X-Received: by 2002:a17:903:244d:b0:1b8:9b1d:d7f1 with SMTP id
 l13-20020a170903244d00b001b89b1dd7f1mr1152614pls.47.1688367648123; 
 Mon, 03 Jul 2023 00:00:48 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b895a9f681sm1204576plb.29.2023.07.03.00.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 00:00:47 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC v2 2/2] vdpa: Allow VIRTIO_NET_F_CTRL_RX_EXTRA in SVQ
Date: Mon,  3 Jul 2023 14:59:53 +0800
Message-Id: <07f600faa258a0673c74854735d71a0a623c3721.1688365324.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688365324.git.yin31149@gmail.com>
References: <cover.1688365324.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62c.google.com
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

Enable SVQ with VIRTIO_NET_F_CTRL_RX_EXTRA feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4919e18208..e10a0128c3 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -105,6 +105,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
-- 
2.25.1


