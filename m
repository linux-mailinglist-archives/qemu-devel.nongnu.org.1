Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE9719EC8
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4igU-0005wl-3L; Thu, 01 Jun 2023 09:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igQ-0005gM-Pt
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:42 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igP-0000TQ-1v
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:42 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2562cc85d3dso612303a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685627379; x=1688219379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB4+H7dHId7zALwS3Cq9afyCMbzCC+JyaNMHxJm0Ij8=;
 b=edfyMfL6Vv7rIxGf8RrxDYYTO6aoY2KyfAOcdF+5iDBK+/P5TxCmGHfrWd8E3JZbtg
 C2T4AQEW3HQaKGhAjcf1t4ioU1Q0V+NJ8Oohv85pCJ8mIyHRv1/SO24+ruV6I0LMQoPr
 /gepPzxnwiYtEtQz9aYkC7AX21SK6wjnROnMpU+pfIkwCRzyVqFYcGCSNMuFl7KqAi/S
 rgAIAg0xo6ymFkfuhPZxZkwDuP7uyLtJRJc1JhHN/rJ9pGn6WPYprHptwyRPakPpx6Ev
 DGRKXUeifSL3GdXReaJh5njccY5Rp3WlikJpXq0btxh5MK0qkbrram2AyR0tvFvaMJJ0
 9bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627379; x=1688219379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lB4+H7dHId7zALwS3Cq9afyCMbzCC+JyaNMHxJm0Ij8=;
 b=jSb0cjOe/PO/GNdQ0H2h4aO9RXRiTVoWXWvb20nTM8Ve47FQRVOsBctwtZM6A964om
 a4pws8NbV4Slji3tMIHozaVmMbsUuwtkWmbc/Tsnx3W+12Bn16MRCnsYLHn4i84B2hI+
 se1fhmBtKpgXFJdqYMoUC0hTXezFqgzK6zuTCYMDo0liDwhMMBjocGEUhikXUPBd1HmS
 f6XQRdMwycZaNvlbPS3ifLcopJ3XsZ8ZMupRygS+4O3N1biu14Qp/tGG+RWeOINCUYBG
 GhQWKP70oAWvQlGJzR7NLweWEXd8l4GSk/86Vh23aY/QomrltXuRZjiBchz7xptGxaO0
 YnJg==
X-Gm-Message-State: AC+VfDz+Tv6P6/2LRGQ9cf7Dr7ZDD2PnTBM8Z/9l9J9MkNS7TUlkEICR
 x9EdllwPr5hTgJwaFMyKogw=
X-Google-Smtp-Source: ACHHUZ41RZKJKNK/e6W1Gy6w3b43dv7Zapw9Kl+/Wd9fOtQmdkc+/xlieAFjWZu1os5RpoRNDdv0cg==
X-Received: by 2002:a17:90b:17ca:b0:256:69ac:eb1 with SMTP id
 me10-20020a17090b17ca00b0025669ac0eb1mr9350668pjb.1.1685627379427; 
 Thu, 01 Jun 2023 06:49:39 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 12-20020a17090a1a0c00b0025289bc1ce4sm1497664pjk.17.2023.06.01.06.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:49:39 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 2/6] vdpa: reuse virtio_vdev_has_feature()
Date: Thu,  1 Jun 2023 21:48:21 +0800
Message-Id: <51fcd0b95186ef215825d420efe04e3ab9593936.1685623090.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685623090.git.yin31149@gmail.com>
References: <cover.1685623090.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x102e.google.com
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


