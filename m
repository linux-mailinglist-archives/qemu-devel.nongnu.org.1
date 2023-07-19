Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F506758FB1
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:54:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM21D-0005VQ-M4; Wed, 19 Jul 2023 03:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM210-0005Jm-QM
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:30 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20y-0003PX-5t
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:29 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3a4875e65a3so5235b6e.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689753267; x=1692345267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBd2+B9vCIc7vkdhzGUOSRbK80lFgHx/r36BXg7Em/I=;
 b=aBcAXbpELndhZ4uX7NTb4HcYTJZPEJ7/Bb1NuqkxoL57bn3lMfZHCluATzHYh5YUMS
 37Mwk1liEOeIKMMJNzZTeZYClIcuTrcdwhFuxVDagg7HlVm9Dq05P1zhVko46WvdefM0
 Mv36X1+h1NTgfpzUHu1UGdunqAnkDZS1dqTqsU3KnL4NIGnAshVl24T9saa2EmM6FAwE
 iKntoLMZHmNxaDshABzolo6x86JsDHYyB/ZPU75BAhdSqxyQgQBkmI+CUH8FEcfnmaKC
 LtNNNjXZcBNh5yPA3IgAN9w1JIGM5QjT8JezZrBRjrhx2ym77nwnxdhnKMbeYRajwUSB
 KeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689753267; x=1692345267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBd2+B9vCIc7vkdhzGUOSRbK80lFgHx/r36BXg7Em/I=;
 b=Ddecs02oJhhS/wPMgCsVPnIBMPdQH4ajZIBGrAJooXcS724vx7z0V1Pl861Y4IARko
 k4GWh/wtnpi1svouG4TkU4jBc2aaJl+5tftTUAKDvthJK6EjZEB/EY5nVkOa8LTDNsgl
 jWI7/hi7iFqx1TyXwM8DYL/Y3LujEAS2lqlYDgTjNHRAMzzlcr+VSsH7SnXdPjXGMQfB
 vIuKja0Gk1+xvwuS/CRmaG2idtRbLSJBQPSS3Buwyl/S323BapZLF7KmzafbUULHf8zX
 /MSoDtVisRgbk/OhdqMX2Ufe0f6Lml7dcko05AfWUMnVZsVvuWe2KkeTNUAVcTdCdrX3
 4JBg==
X-Gm-Message-State: ABy/qLYqhzCMZ6IyTax34zupw68NKwHujG5eaxFiPmEHgHjP/ocKlUlO
 tgqYF2BpYMq5a0KmUpSLL2A=
X-Google-Smtp-Source: APBJJlEwqdTaWGxQzygXj2FAt1UYIaAZGRIft7bwTBt+YsZwbCsO9bzTsJIyLhu+4Pi1+QfQgtoYXg==
X-Received: by 2002:a05:6808:2186:b0:39c:a986:953a with SMTP id
 be6-20020a056808218600b0039ca986953amr2150258oib.34.1689753266767; 
 Wed, 19 Jul 2023 00:54:26 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 e6-20020a17090a818600b00262e485156esm658511pjn.57.2023.07.19.00.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:54:26 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 6/8] vdpa: Move vhost_svq_poll() to the caller of
 vhost_vdpa_net_cvq_add()
Date: Wed, 19 Jul 2023 15:53:51 +0800
Message-Id: <152177c4e7082236fba9d31d535e40f8c2984349.1689748694.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689748694.git.yin31149@gmail.com>
References: <cover.1689748694.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=yin31149@gmail.com; helo=mail-oi1-x22f.google.com
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

This patch moves vhost_svq_poll() to the caller of
vhost_vdpa_net_cvq_add() and introduces a helper funtion.

By making this change, next patches in this series is
able to refactor vhost_vdpa_net_load_x() only to delay
the polling and checking process until either the SVQ
is full or control commands shadow buffers are full.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 50 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index fe0ba19724..d06f38403f 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -609,15 +609,21 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s,
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device queue\n",
                           __func__);
         }
-        return r;
     }
 
-    /*
-     * We can poll here since we've had BQL from the time we sent the
-     * descriptor. Also, we need to take the answer before SVQ pulls by itself,
-     * when BQL is released
-     */
-    return vhost_svq_poll(svq, 1);
+    return r;
+}
+
+/*
+ * Convenience wrapper to poll SVQ for multiple control commands.
+ *
+ * Caller should hold the BQL when invoking this function, and should take
+ * the answer before SVQ pulls by itself when BQL is released.
+ */
+static ssize_t vhost_vdpa_net_svq_poll(VhostVDPAState *s, size_t cmds_in_flight)
+{
+    VhostShadowVirtqueue *svq = g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
+    return vhost_svq_poll(svq, cmds_in_flight);
 }
 
 /* Convenience wrapper to get number of available SVQ descriptors */
@@ -645,6 +651,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
         .iov_base = s->status,
         .iov_len = sizeof(*s->status),
     };
+    ssize_t r;
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
     /* Each CVQ command has one out descriptor and one in descriptor */
@@ -657,7 +664,16 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
     iov_to_buf(data_sg, data_num, 0,
                s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
 
-    return vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
+    r = vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
+    if (unlikely(r < 0)) {
+        return r;
+    }
+
+    /*
+     * We can poll here since we've had BQL from the time
+     * we sent the descriptor.
+     */
+    return vhost_vdpa_net_svq_poll(s, 1);
 }
 
 static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
@@ -1152,6 +1168,12 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
     if (unlikely(r < 0)) {
         return r;
     }
+
+    /*
+     * We can poll here since we've had BQL from the time
+     * we sent the descriptor.
+     */
+    vhost_vdpa_net_svq_poll(s, 1);
     if (*s->status != VIRTIO_NET_OK) {
         return sizeof(*s->status);
     }
@@ -1266,10 +1288,18 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
             goto out;
         }
     } else {
-        dev_written = vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
-        if (unlikely(dev_written < 0)) {
+        ssize_t r;
+        r = vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
+        if (unlikely(r < 0)) {
+            dev_written = r;
             goto out;
         }
+
+        /*
+         * We can poll here since we've had BQL from the time
+         * we sent the descriptor.
+         */
+        dev_written = vhost_vdpa_net_svq_poll(s, 1);
     }
 
     if (unlikely(dev_written < sizeof(status))) {
-- 
2.25.1


