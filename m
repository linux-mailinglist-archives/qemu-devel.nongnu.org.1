Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F19CD719ECA
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:50:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4igf-0007mO-Ix; Thu, 01 Jun 2023 09:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igc-0007Vl-5W
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:54 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4iga-0000Wa-HX
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:53 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b04706c974so7211305ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685627391; x=1688219391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njzkDyjtwOWFxOUUDhj3QrAL+aWZx2wnp3b8e3dX67o=;
 b=OT6SMcJlFKjcdMk7zVlOzIhTfwgnwrQI+PnsnEmNhM8pbRB/WKzVuDQLBx4RPZiZV0
 wMf6AtiEJtKVTQIlL8gSJtO4dDyNn2AeUzpFFc3INAkub0G3ODiCoHfUfRzz7KbGvWQu
 FmIp+EfOrjJAEIa+ZQHa9nW2h75O+4ZrhOhypq4UiSDHuPEGWaQFCOD7Fa3lUEV/6FNc
 eULIhlYfghHrnrbfYcb8nCUMxD2nslR3uIm9bvgTQzQj07i9gWntWhuCXMPdAva+bW6+
 bnggp36G//vNZkITaXvTtSoY3Pod8NPxU6ISJYhdV7QaumLi1hmRJmHtDnSftlfmj33D
 vh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627391; x=1688219391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njzkDyjtwOWFxOUUDhj3QrAL+aWZx2wnp3b8e3dX67o=;
 b=kPdNyUTpMK3OhrcngkBgwmKAHx+66ZS2runbFHlZIzT/o0suFrtixUWt/AHsGzuWd6
 Xb0JxqjqQpsBALwXAZuTDBex25FyJBWInyfu9eqtX4GyYqo6eQPHkHm68BYgRziJkSeu
 XIzBiLpUKfCba9JPzLnBlJr1YkmHMyXYCbgEOOnL/Pj6EVz1hwjqdDeHJlhqVkpVBXSY
 rxDkgdg7jpOhuXqu+kPEIvSZK21uM4gG3Gc9acoW38mEVKTn1yROXcC/yQeZHWRgtkbC
 rK08Ba2Qx0tppFoejGYDhES8eeGiuag+5n6dUHX3e+HgpgzQyqtJ/gLM1sFV5msc2Ofv
 l+Xg==
X-Gm-Message-State: AC+VfDz85ulVq7VFwqxeIOpo29WoDLuTC3Db5VQDJABrIFWK8ZPZWW0L
 xL4CWqbnrRvSM+9YRLCiaRU=
X-Google-Smtp-Source: ACHHUZ6AW/5O6bmFPfnDc88hbCAR/82wWrUX6vTmmhbj4/LjpTRezX4SLKEfhqaIXoM+D8dLjspWjA==
X-Received: by 2002:a17:903:280c:b0:1b0:4502:8547 with SMTP id
 kp12-20020a170903280c00b001b045028547mr7266728plb.35.1685627390757; 
 Thu, 01 Jun 2023 06:49:50 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 jj21-20020a170903049500b001a5fccab02dsm3499296plb.177.2023.06.01.06.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:49:50 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 6/6] vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
Date: Thu,  1 Jun 2023 21:48:25 +0800
Message-Id: <38c7a86e4b1104917d8507b5e6cbe93d682d59ae.1685623090.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685623090.git.yin31149@gmail.com>
References: <cover.1685623090.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x634.google.com
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

Enable SVQ with VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0e647886d1..4cc24a2997 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -85,6 +85,7 @@ const int vdpa_feature_bits[] = {
 static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_CSUM) |
     BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) |
     BIT_ULL(VIRTIO_NET_F_MTU) |
     BIT_ULL(VIRTIO_NET_F_MAC) |
     BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |
-- 
2.25.1


