Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E679758F86
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM1up-00007q-FX; Wed, 19 Jul 2023 03:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM1uU-0008UA-QK
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:47:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM1uS-00027L-J4
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:47:45 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-666ed230c81so6629383b3a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689752863; x=1692344863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=749c16VfFqHXoK3rBi9xwn3HY6BMtdWqslVMXDL704I=;
 b=hjJXtBkl31jAZULG8qkGzePGbSQ+D+v/lEmWBQ9KwdMAnhUA2ghwHEZh5GnK6ofi3L
 ccrX/Z/BT72J1oRFr4Ysu0eVqJv0J1HPt0kX1RUqNMZFqam7dTQ9hF/bBGjDyDuivDSv
 j6ri8IdTLVBZG9kLQKAFEOhrTyFJ5Ed7QiVd+7MhVQ6qiU492VkuTtppZpJfdGvcI6HK
 OC/QWnL7UTK3++HfRBwvKBDpq3BThGN19HMwz/FY7/0WZGE2eMKTPym19tjw302crfDN
 q6efgD0pesI16am2nmQbpY5rxzk6MKZhWO7J8ehVpyuhYaPCdh7kimRsw7owy0j/6ZH1
 T94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689752863; x=1692344863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=749c16VfFqHXoK3rBi9xwn3HY6BMtdWqslVMXDL704I=;
 b=mF5Iib6ZDBlzVv3nGPZdvQd6barNg7dSwJDjO3xixzggoXd1hexLG70AHK6GfcxHRy
 F+N+4H+DOdkegj6tmQLzh20WVB9fFBXjxn33i51SoAjoQ3nhZjQrQIYJLYxMMBr5zL7n
 ho1zri4sQTVHCAYrahw7JT+fjmuQD/C+/YAMUqOtKtl9qwQp2kllbSHheZhh+GwjN6y+
 cgqnqbL0mFFtiyvb3pSbOxkFpP7Pi9KespMa5r+CKFwEFPqCTJ4oOSgieSZQ9w5Rszgg
 S36akNdhfYZEJEalUH7/JurMyhZT52TGEYnfgwuFhxslUMFd+p6/ExuaS9e7RLrCJBaH
 a8Sw==
X-Gm-Message-State: ABy/qLYnk1EWsP+eXFKx+HCERVyeyshFn+hgtcEnNiPj/uSRVXpwvjg9
 /uLq2oI21V9+S7RV3gaguXY=
X-Google-Smtp-Source: APBJJlFPaJsaEVOHIq1Wo/xF2GhxvGVjfO7pyikRY3NOdDZ2S6QstFQQWRyzIzX3m1DOnwH0riKocw==
X-Received: by 2002:a05:6a21:3393:b0:137:3b34:93e5 with SMTP id
 yy19-20020a056a21339300b001373b3493e5mr1551631pzb.59.1689752862961; 
 Wed, 19 Jul 2023 00:47:42 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 i15-20020aa787cf000000b0067a6e48b720sm2667962pfo.181.2023.07.19.00.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:47:42 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH 1/4] virtio-net: do not reset vlan filtering at set_features
Date: Wed, 19 Jul 2023 15:47:28 +0800
Message-Id: <966bd98eb6efe1754165f497e44f2de09c64e077.1689690854.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689690854.git.yin31149@gmail.com>
References: <cover.1689690854.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x432.google.com
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

From: Eugenio Pérez <eperezma@redhat.com>

This function is called after virtio_load, so all vlan configuration is
lost in migration case.

Just allow all the vlan-tagged packets if vlan is not configured, and
trust device reset to clear all filtered vlans.

Fixes: 0b1eaa8803 ("virtio-net: Do not filter VLANs without F_CTRL_VLAN")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Hawkins Jiawei <yin31149@gmail.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 hw/net/virtio-net.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7102ec4817..d20d5a63cd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1006,9 +1006,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
-        memset(n->vlans, 0, MAX_VLAN >> 3);
-    } else {
+    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
         memset(n->vlans, 0xff, MAX_VLAN >> 3);
     }
 
-- 
2.25.1


