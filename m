Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F8719602
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dz8-0001xx-Gg; Thu, 01 Jun 2023 04:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dz6-0001xm-Sx
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:48:40 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dz5-0006Fx-Fk
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:48:40 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5289cf35eeaso1419256a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 01:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685609318; x=1688201318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB4+H7dHId7zALwS3Cq9afyCMbzCC+JyaNMHxJm0Ij8=;
 b=MOtkfrMTy/Z4XMPzEXHzeTWMxYPd7QrD+syDHkTQ+SxtlW4YmTUXde2MpWnRGbIieH
 g/J1p2gg8ZDcu+D0gqkSAHxenoi4FMpqtU2E54j1Ic71xF0cuw915yyxH+eKbemgrNlB
 fbG1kmFJdQ9JmBv/2j8rQUFncXYCVw/o5Di/0oiwymkMZ6mO/VQ+sk8tIj2R/+qcbvN0
 La6bJPtOwN4BEbBqeGZM6bTzXCOcjgZhHzShw1vlSRbmh+YzhTIvvo74t6j6JcLf05zb
 ieS9xxxcz/w43AiDXQqxVcozpEgss8FONlglce8IOFs2zCwlEJoEDZqlNT9WgMQHtKR4
 G3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685609318; x=1688201318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lB4+H7dHId7zALwS3Cq9afyCMbzCC+JyaNMHxJm0Ij8=;
 b=LFMhRgfZRfAtUqPNqAt9YGE4aDQwvREkhoE9QBrdNjngD8mEV630WD4btcEje1/GZu
 0Jk1jY0EDF1LC9F3AMMwcUUxhOUJix2TV3iI7wMeweAvnmBSudn0JL+Rmi5f+/mSGWcy
 CMqKcDEyDMKi2vB1UbdOIVdbeL9NkjXA/oUo44H0b9f9tQYVnY/tCf0MmR2l9D1RwUMQ
 v1fNvGTyYXNGjwyOM1owNGlr0hODKkD9ByTKvlELo1p0PUGIEErUgPKFD6N2LZie6dTH
 owBE9KoTNqVELmCjEiH1kJ0ML2SFe523jR2FCKBgOL4mRsIPj1RRqQcP8jf0eCYpqtkC
 VLRQ==
X-Gm-Message-State: AC+VfDx6zhf6j86Mq6JBgOrRkFSN3ZqLO+avoLCivat+KNIaFjhLzvJh
 VirGeEAgYQnsKoWC1J5NGRX/qAqSNYDpv423nes=
X-Google-Smtp-Source: ACHHUZ4+V9UAYGrNKpXIH4+q5Izi5FZeMHsPlZT8Qe4qaVT48ypFXmEspcAPZDr4U5+e0TM99qlDrw==
X-Received: by 2002:a17:902:ea0b:b0:1b0:7cc:982a with SMTP id
 s11-20020a170902ea0b00b001b007cc982amr1651271plg.5.1685609317767; 
 Thu, 01 Jun 2023 01:48:37 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 jh22-20020a170903329600b001b03a1a3151sm2884858plb.70.2023.06.01.01.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 01:48:37 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com
Subject: [PATCH v2 2/6] vdpa: reuse virtio_vdev_has_feature()
Date: Thu,  1 Jun 2023 16:48:16 +0800
Message-Id: <dc0477a7ce8bd9c1b07c99251908aadecea66c89.1685584543.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685584543.git.yin31149@gmail.com>
References: <cover.1685584543.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x535.google.com
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

We can use virtio_vdev_has_feature() instead of manually
accessing the features.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 37cdc84562..e907a3c792 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -643,8 +643,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
 
 static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
 {
-    uint64_t features = n->parent_obj.guest_features;
-    if (features & BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR)) {
+    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
         ssize_t dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MAC,
                                                   VIRTIO_NET_CTRL_MAC_ADDR_SET,
                                                   n->mac, sizeof(n->mac));
@@ -662,10 +661,9 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
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
2.25.1


