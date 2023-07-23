Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8330375E1B6
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 14:10:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNXuC-0006fj-BH; Sun, 23 Jul 2023 08:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNXu6-0006eg-Fd
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 08:09:38 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNXu4-00084d-LA
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 08:09:38 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-666edfc50deso2193211b3a.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690114175; x=1690718975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mruzh5CY/l/MhA8f7XCTVPhhFsQd/B3p25trO/Qstzk=;
 b=cFXpO5sQIHVGl7LQRzUxduh9UMuevktIYTKAMx5Xl86E+Jld16xqid5jJa22eN+iWa
 jajbmjtetVWPA3d8bmR+CwCS9eR7T7FbFgQQa6uIxQqMQ10W0w2PImk/51KH5LfJTI/K
 j1BXU+KhYAQJ+gavK0Sy8o8RlxeeHbGHY17tfFV8NvFlHLC3GH6Dd8+TUtytDs363NQ7
 twMhJbcry6shluQU87AEoBaCCM5iy6P488TKBjRxRvYxNEdosh/RNPKHjOze+4dnVSFY
 moSQvamupgng/HPPYOeDgQa+juml/dOlSBJXstBlEWgwCn0azKBdqehiAGYuAHUhQ46F
 t1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690114175; x=1690718975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mruzh5CY/l/MhA8f7XCTVPhhFsQd/B3p25trO/Qstzk=;
 b=RfnGIf7Ehk6+CnwZHKJRFGIKVNDjHq8+UX/drYb4mIB8BQthNYgbxafYksDF8YAwwL
 XgMg99FkHsQ5biSJ8d+M0b+kZYQzxuvH2STKPOA3YIIrs5/9HVxomTFzdxhZvtSA51Zy
 lDr13twP2xG+s0vlx3mxmIH/xGobj5BmmIxWl50b9qhfBHQ7nfL/0D8W9puFgVxUhcar
 GpPU5lSb7SII32q6YemLGkN0GNOi+N5HDNawDpyBhmreBNUIZsd1GzY1MASobr9buBJx
 gtvYf93LIdk0zf/70rpcG9t5uv7wRdPMPyVgaTlA12ZHtDZVTXJNBuOQnam8Ee90rSwO
 +G8w==
X-Gm-Message-State: ABy/qLbWgiabMUXVpxQ4W4GEWpah2O4iqMlqURkrLGjldm+W9gmnnYfQ
 sJ3c5YzxouwCsABElXnBiEQ=
X-Google-Smtp-Source: APBJJlFBNsd5Z8wqOwsQ3dcJdrl3U8YrX4JCsL0BBs+E9Gb4zMMleLRmH7Z95s2IzJoc/omRnIIZYQ==
X-Received: by 2002:a17:90b:3b51:b0:263:f3d0:7ea2 with SMTP id
 ot17-20020a17090b3b5100b00263f3d07ea2mr10460565pjb.8.1690114174721; 
 Sun, 23 Jul 2023 05:09:34 -0700 (PDT)
Received: from localhost ([223.104.38.215]) by smtp.gmail.com with ESMTPSA id
 y13-20020a17090aca8d00b00263b4b1255esm6604457pjt.51.2023.07.23.05.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 05:09:34 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 1/4] virtio-net: do not reset vlan filtering at set_features
Date: Sun, 23 Jul 2023 20:09:11 +0800
Message-Id: <95af0d013281282f48ad3f47f6ad1ac4ca9e52eb.1690106284.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690106284.git.yin31149@gmail.com>
References: <cover.1690106284.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x435.google.com
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

This function is called after virtio_load, so all vlan configuration is
lost in migration case.

Just allow all the vlan-tagged packets if vlan is not configured, and
trust device reset to clear all filtered vlans.

Fixes: 0b1eaa8803 ("virtio-net: Do not filter VLANs without F_CTRL_VLAN")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Hawkins Jiawei <yin31149@gmail.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v3:
 - remove the extra "From" line

v2: https://lore.kernel.org/all/95af0d013281282f48ad3f47f6ad1ac4ca9e52eb.1690100802.git.yin31149@gmail.com/

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


