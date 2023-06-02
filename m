Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 532347200EE
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:54:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53Kd-0008I6-Bu; Fri, 02 Jun 2023 07:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53Ka-0008AK-Vw
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:33 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53KZ-0007FV-3d
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:32 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2562cc85d3dso1527260a91.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 04:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685706750; x=1688298750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdZEvGS5pKAdDP2r/hDEuoCh9mnMaQgfKyqI6O8cGcY=;
 b=p8LJ9BDno+yEuj5xP028CMjuuna28eKkdocFl1RLW18K95ELqDpPyytuxtnoCpKeSv
 P75U36//icEGoFnZwB01gVh7HrUIBWLxHEzfl0HB/iTVLMutEEmQXgrN+FhG4n96KbuG
 urTGsJ7cetA0SkIy0Tv7eP+Actmg2+HpDA/8htlFei2SC7j9E6J95OvV8GjpvRU7s+Y2
 khQB8sehnCgzn6testzH+VtT1F0C3SizbgO6RPjUAOYgrccuoZVa4+U/chnWToIbuk85
 46y+CuydHaK3OUyGrK9y0dMzDYSMqu7bMAv0Q3mrRRK8rsRZmaYj71hI2RfmVsHVjLsC
 XGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685706750; x=1688298750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdZEvGS5pKAdDP2r/hDEuoCh9mnMaQgfKyqI6O8cGcY=;
 b=fDIUn+CppJFzVicN3Tpd4lssRZu30ebbmAZ02nIwZwKHTYd5XH0VyF92kna0zzBYSJ
 iK8uWkV2GozEM4HFgoynbSESnbJwg2yGVRcjj4/PUmHI5AlOSGtzCFdKCfxR0nW2OZnG
 C9COoB0BNQM1De/w6bcHBsviYTZV2COm6xi0s4iWSExz25DGw9w7dFzqc/yNdnBLIlD2
 gyYs8AROfRDKJfyXG6ebSvx04HOow42+wj2sFrj22BLxwlcU8alZ4QUW56lLmHWHoXUJ
 lzI/xMiDFvxo0kXExKuv+BYM2sqPUk3u2AQ5Et9YSRc/ZsUUS3XoRo88nkn4uijXhoTV
 8l8A==
X-Gm-Message-State: AC+VfDxuZn13TMkd85XZ7t4rGIr9VG7pf+zHxQo2Lo8VTTq1zwVta/L0
 KEZMOTWZy1teZkgStQLABoo=
X-Google-Smtp-Source: ACHHUZ5DbV/YPQ279tFs5KMUnqA5JgQy43eEChxP5EkaS1sjIXYBQMHjZ0IzwuaXvQj8grFFnhLT6A==
X-Received: by 2002:a17:90b:f0a:b0:255:afdd:2e7 with SMTP id
 br10-20020a17090b0f0a00b00255afdd02e7mr2215045pjb.7.1685706749628; 
 Fri, 02 Jun 2023 04:52:29 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 27-20020a17090a031b00b002567501040csm3112275pje.42.2023.06.02.04.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:52:29 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 2/6] vdpa: reuse virtio_vdev_has_feature()
Date: Fri,  2 Jun 2023 19:52:14 +0800
Message-Id: <ff838d30206209fd865511b16ffb34cc0d5e8d8f.1685704856.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685704856.git.yin31149@gmail.com>
References: <cover.1685704856.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x102d.google.com
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
Acked-by: Eugenio Pérez <eperezma@redhat.com>
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


