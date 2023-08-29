Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E19C78BE1F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 07:59:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qarhm-00053I-HS; Tue, 29 Aug 2023 01:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhM-0004xH-4v
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:34 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhI-0002aq-68
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:30 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf6ea270b2so24106255ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 22:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693288527; x=1693893327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQf4aZX0Yat08dZQMgxazPmJjmRJS2h+DlnRsBMJrdc=;
 b=F/PyrJJQUe6zBAX4I5oPycAtu+QxBgWVbAW0qqSoYjdNSx4rLEwVaHvqkJFpbb/IY7
 Yh4NEZPqrrKJlBp4g06ZioPm2NLgFiOjr5d5FGY4b4ltoRn5gPP4IPPhgttG8NQxHruh
 KUivjPyULK4ZR6TJ3FpGRe7/lrbKl13hWM3GNynK3NBDu733qL8UR4HUOVRMZ3yXOVmM
 vFZc6IFP5C0VU9c+32cvQ/WaIMJ7oi0+pSVK9tqGMXv/N5POmr0esQbN9TOLZ4mcUioj
 XpCBiTcw38x+WZpRaAJ2RJGnuC+eBQJI5b5FoDFBQtDg9EDdLtWdtdhlP2GQZ3KUnPh4
 u8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693288527; x=1693893327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQf4aZX0Yat08dZQMgxazPmJjmRJS2h+DlnRsBMJrdc=;
 b=eLQgEgGg8NruOUOYGSNId3Ur5lz369B9Fa+FzvvzFqYnuO+RRB/+d7ybj7B9dxjLQW
 GlaGJhbhP2PBFHGEF4zEJY+0FbuFCsITxwkwGpAGXxyZuJjiDHX4SLFfPYVNDi0U0Od7
 CzdBhtYzzTyuijIlAVyK2qdbEfUVi77yvWhp4xdxUeQEGadGspXtjBS1hxz1ZO846o+g
 0yQCob1XlHy4ETRNMC99h63ZnysSDoQ9RO7XZkSwvjAI4uk/kkS7rwnb581XGW2E754T
 T5Yaw2OGZ/HoQw/RYh8ejUP94A5+D/yurdIHQut03Dt7WOwmaDhtrMrH6HCeD7l+/LLQ
 afqg==
X-Gm-Message-State: AOJu0YyJV3XjYckklP7GmvaeXMCaVPovk251CBJHJsQ1jH7J+NDYKgbI
 xr8LtRRvsCzA+zf+8lWOn9s=
X-Google-Smtp-Source: AGHT+IGrjkB67p6VcTuQF8/FIUgJDKFIp8AsUtShmZt0qoIIiniN4klSvLG5eYAbpWtBCmRS0FgOVQ==
X-Received: by 2002:a17:902:7fc6:b0:1b6:b445:36d4 with SMTP id
 t6-20020a1709027fc600b001b6b44536d4mr21176747plb.43.1693288526624; 
 Mon, 28 Aug 2023 22:55:26 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 l5-20020a170902d34500b001b89a6164desm8450495plk.118.2023.08.28.22.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 22:55:26 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, leiyang@redhat.com,
 18801353760@163.com
Subject: [PATCH v4 3/8] vhost: Expose vhost_svq_available_slots()
Date: Tue, 29 Aug 2023 13:54:45 +0800
Message-Id: <13b3a36cc33c443a47525957ea38e80594d90595.1693287885.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693287885.git.yin31149@gmail.com>
References: <cover.1693287885.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Acked-by: Eugenio Pérez <eperezma@redhat.com>
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
index a875767ee9..e6342b213f 100644
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


