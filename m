Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E076758FB5
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:55:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM20r-00052Q-W6; Wed, 19 Jul 2023 03:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20n-0004q8-7a
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20l-0003Mz-Bj
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:16 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b89bc52cd1so37227535ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689753254; x=1692345254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXg2eGLSXh1jDorZn4NnX3a2Wq1PPpMjkHiWexWxLa0=;
 b=LzdYdP57YMKCpRIhgFXpMVf41uhMofbDV1NpRTDYS7FbXk6ilBNzx1OaHPXUQzVKNC
 G77DzIi1ykx+cxX17cotO8OnPzRFyDEscuqAFH1it3BKTXGjtNWxOjqbUYLuUWlQVC7D
 db49LX/Q7iZqXppOOr6JMc435OwnYcdcNn6GvtD1O0BwF3CbCdNGDNIXUuNvBZARyueG
 641cmCXCDFY16vJf+tXrO4Ep821zgd2HqfSAVrenb8XLMbV5zXZiBAeTJGKCLPV042bx
 gXWYgOIzvkO46BTtuj8vvPtojwDd3ff7r50UtYHwwQ/+/H0PEkYpeAQNv5asEFlroUVo
 xT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689753254; x=1692345254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXg2eGLSXh1jDorZn4NnX3a2Wq1PPpMjkHiWexWxLa0=;
 b=G1jBe12TanpZ7FHmeJ2EvIUL+t69ec+E7AZeFia2Kf2m9l7gTUnRfwu+4VPEG2Y1jE
 MDBSqJIZ0pGVRJnG2DdSW09lUPUxQF82Qf2sREpqe3mR3AQQHt72xeXE8UsZ+e+vQdFV
 S4r31QjM6v8nWhj0iGUTe16Na5Qv0T6rWyxspamPldvbbtXQHELsC44XVqidrucKDVPW
 7ojQoYgiiFUoW1lvWCZlL23/4MFSOBMIzV1frqYyuH5WZV2boEt54eu3MlhMI6cc2a8J
 If3RxYUppBiTP/6jWpu7BRmInAtiFy+QbhBkHmrt7MJo6uXRTNExKYxwJKnwWP7CNIBH
 fnzw==
X-Gm-Message-State: ABy/qLbowrCKS4KPQMERJV0c5gqeW9No2F1Q8RJAeSBBtejVAdeiHxU8
 eWzpH8ISLrkXMVuXxD2pGIk=
X-Google-Smtp-Source: APBJJlF+pCCcdzSY4TdhpPEyUt4CqdJnQAhlLE8hQyE/Q93dBPGfsP66CRcoAoMRaZ1RVjnO9pUtHQ==
X-Received: by 2002:a17:902:b20b:b0:1b1:9272:55f3 with SMTP id
 t11-20020a170902b20b00b001b1927255f3mr13280691plr.66.1689753253724; 
 Wed, 19 Jul 2023 00:54:13 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 iw10-20020a170903044a00b001b9ce2c3baesm3202094plb.143.2023.07.19.00.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:54:13 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 3/8] vhost: Expose vhost_svq_available_slots()
Date: Wed, 19 Jul 2023 15:53:48 +0800
Message-Id: <110db78638438360da7e049343b06ea58af2a195.1689748694.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689748694.git.yin31149@gmail.com>
References: <cover.1689748694.git.yin31149@gmail.com>
MIME-Version: 1.0
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

Next patches in this series will delay the polling
and checking of buffers until either the SVQ is
full or control commands shadow buffers are full,
no longer perform an immediate poll and check of
the device's used buffers for each CVQ state load command.

To achieve this, this patch exposes
vhost_svq_available_slots() and introduces a helper function,
allowing QEMU to know whether the SVQ is full.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 2 +-
 hw/virtio/vhost-shadow-virtqueue.h | 1 +
 net/vhost-vdpa.c                   | 9 +++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index e731b1d2ea..fc5f408f77 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -66,7 +66,7 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
  *
  * @svq: The svq
  */
-static uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
+uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
 {
     return svq->num_free;
 }
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 5bce67837b..19c842a15b 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -114,6 +114,7 @@ typedef struct VhostShadowVirtqueue {
 
 bool vhost_svq_valid_features(uint64_t features, Error **errp);
 
+uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq);
 void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
                          const VirtQueueElement *elem, uint32_t len);
 int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 6b16c8ece0..dd71008e08 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -620,6 +620,13 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s,
     return vhost_svq_poll(svq, 1);
 }
 
+/* Convenience wrapper to get number of available SVQ descriptors */
+static uint16_t vhost_vdpa_net_svq_available_slots(VhostVDPAState *s)
+{
+    VhostShadowVirtqueue *svq = g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
+    return vhost_svq_available_slots(svq);
+}
+
 static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
                                        uint8_t cmd, const struct iovec *data_sg,
                                        size_t data_num)
@@ -640,6 +647,8 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
     };
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
+    /* Each CVQ command has one out descriptor and one in descriptor */
+    assert(vhost_vdpa_net_svq_available_slots(s) >= 2);
 
     /* pack the CVQ command header */
     memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
-- 
2.25.1


