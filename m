Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D673B8C1
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:27:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgoD-0008Ry-MT; Fri, 23 Jun 2023 09:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCgoA-0008Qr-G9
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:26:39 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCgo8-00032M-Ts
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:26:38 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-54f75f85a17so459513a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687526795; x=1690118795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xz65ivos5efdQCVkhB+8sSNd3tQI1XsOWnhkB2JOmVw=;
 b=Rhdzb+9khfYEJfZXainc0+eIlpA9SpydmP/lm0N58LPSzbWTXsK0/Rx0wFrmDZan3u
 ebPaghsaa6uXhZIDj8KP5nIZz1xpRNLAR7G4QLZGFdzIC0+9MRhy+D2roTGBLtFfeXOu
 z/wP+cEGZxLat0PmOaXYf9eagdI9yrOpQRr0FJBfcAulmDt4Owap88XQ8tTgBVzbxns6
 LXMGWG6AVmSV7cthZhE13ttUugK1aEvXg4nLOSoj9cc79Oh28+J41/s0oVJ6xEiZfN+C
 M4O/MvSeoWINl1w8l1juSadz7hGfN618p27aVNPwW8BeXU8dNUZ8YT38m71FZFLqtECC
 aIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526795; x=1690118795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xz65ivos5efdQCVkhB+8sSNd3tQI1XsOWnhkB2JOmVw=;
 b=lLC+o17Z2vvXmSksQBqNc0q7a/rBUKTQ3DZwn0WXpftinA7EwrQy1BxCFpIyZh0GBq
 G2aCjz2OCbCcGeyOKjXJ9+CYtxR1xb4JPQhru/MjpGf+BHL2cMAyUN+Zk2EIoA2mfQx2
 mESouzUzBsahyy7ZYXObCViFXhxKfxfOT+/WHuvas784UKazJcGNsxAEFboyroCotKZh
 YieT+8LNToX/+8gDM+tkujQRHQ0GgFiZymWo+GKOWvSaH7TykX10nt8ifrXYDvPEJn0q
 OiKEfMhy7/HanvzEGNbBWgP1qJmWBXzY6RXUmJeVNw7gcCqVaAInquyNN6zncI/aZ15L
 RKWA==
X-Gm-Message-State: AC+VfDy5dqYcS2WTMctyvnoVxAcNnlbr/eD5KXWpf5+nnOHHoRu5f4MV
 o0Hi5it7HWHjrMHlKLuew2TK4FIhVMQPWA==
X-Google-Smtp-Source: ACHHUZ748d7rNElQnnGF0/Ibrd0KgDr8MUSD0m2OUAIriIIWsEVAfsLRrSSx+KUYGbzxuj+ievLlSA==
X-Received: by 2002:a05:6a20:2449:b0:10d:5390:eadb with SMTP id
 t9-20020a056a20244900b0010d5390eadbmr18311792pzc.2.1687526795421; 
 Fri, 23 Jun 2023 06:26:35 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c20d00b001b6a37c49a6sm4261047pll.268.2023.06.23.06.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:26:35 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC 2/2] vdpa: Allow VIRTIO_NET_F_CTRL_RX_EXTRA in SVQ
Date: Fri, 23 Jun 2023 21:26:26 +0800
Message-Id: <c070a6a0f17afa6d1a00481d076b2e6fdb4d13f1.1687524532.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687524532.git.yin31149@gmail.com>
References: <cover.1687524532.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x52e.google.com
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
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9b929762c5..cdfe8e454e 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -100,6 +100,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
-- 
2.25.1


