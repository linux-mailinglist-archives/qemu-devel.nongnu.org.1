Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD617C800A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:23:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDFi-0007ak-14; Fri, 13 Oct 2023 04:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDFQ-0007Eo-AU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:10:16 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDFO-0001mS-DA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:10:16 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9a1762b43so15194895ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697184611; x=1697789411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IDKITTbgc/cUnDaHPYmgtL0QhMPD6TOubiMOIIaJts=;
 b=MPOhNsWqZ8/pv3vH1PyzhJV5MDU/EK9MxVXgYBqa7votb45PMSvuJeGa7YAXblW2+f
 by++X+7bAu/xvSTj2HzyhCumWVOjcCOuhoRsCoYWI+fKvT7ebmTnHdLZDh+LpHu5oU6R
 3rFJdvCVuE5sWs0w7/vjMJd3uplwlJ32VkDKAgcaur/S/LVJlFSjIdIAbWZoytx9hMLh
 Y2t3UmPZT66OmTcIkXA3WI0FzPNkqBqixCBEENrkov/gQNIykUwGTa3HqXOFyetyLXqj
 o+kgo5j3d1PV4Pk+z1bLkF00Qmih4baQG+8yoTghIC88cxA8Ftnk//5bZ86KMrsPsmMG
 ichw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184611; x=1697789411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IDKITTbgc/cUnDaHPYmgtL0QhMPD6TOubiMOIIaJts=;
 b=LiIhdsOshylXJ0BAPDDYNfXQv+0fvgc58KLh7POY0W8Vods2vOCaiXHFHXYeAj/hxc
 qZdiprNe+Rhp98vUYqALd6ptiPr1VvKq7KVmn3XgZ+LqwiJMQqoZCUzBfbUQU8vLtGXn
 BjxPwlOo+M5C1aDY5eQjB5cJn22m1oElDLL6nCm4/+420ciYbTNFSW/nEyBanr1MX1jS
 HunTDPTKDauSeFmlZRV82QEfDTbAnnKeu3PR24q0soz45fd+01t6R4zXg5Iy/cGgsdmG
 +IVCc80T19NjdixwaY+p3fMm5CWR/rBMBjKPjpoCD94AwpRTXuyGgf3X+OYN9g06O7JJ
 c4vQ==
X-Gm-Message-State: AOJu0YzQjlZ9wnrmP+QG1gfMWfPWNVr7cYvZ88evxZCsMbxi1SR9UCOE
 gVtxtlpJn6PRywUV0U0iJnM=
X-Google-Smtp-Source: AGHT+IEJAy+PPMpy66/fAxe2EOJYkRJHfBU4Q9NMI68/G80auw3V0JKrQ4m4A7qcHnNDf8QsCuTNJg==
X-Received: by 2002:a17:902:e749:b0:1c5:e00f:2 with SMTP id
 p9-20020a170902e74900b001c5e00f0002mr32026268plf.28.1697184610672; 
 Fri, 13 Oct 2023 01:10:10 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 p11-20020a170902c70b00b001b0358848b0sm3301933plp.161.2023.10.13.01.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:10:10 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v5 4/7] vdpa: Move vhost_svq_poll() to the caller of
 vhost_vdpa_net_cvq_add()
Date: Fri, 13 Oct 2023 16:09:39 +0800
Message-Id: <196cadb55175a75275660c6634a538289f027ae3.1697165821.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697165821.git.yin31149@gmail.com>
References: <cover.1697165821.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62e.google.com
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

This patch moves vhost_svq_poll() to the caller of
vhost_vdpa_net_cvq_add() and introduces a helper funtion.

By making this change, next patches in this series is
able to refactor vhost_vdpa_net_load_x() only to delay
the polling and checking process until either the SVQ
is full or control commands shadow buffers are full.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v5:
  - no change

v4: https://lore.kernel.org/all/496c542c22ae1b4222175d5576c949621c7c2fc0.1693287885.git.yin31149@gmail.com/
  - always check the return value of vhost_vdpa_net_svq_poll()
suggested Eugenio

v3: https://lore.kernel.org/all/152177c4e7082236fba9d31d535e40f8c2984349.1689748694.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 53 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 36a4e57c0d..ea73e3c410 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -631,15 +631,21 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s,
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
 
 static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
@@ -660,6 +666,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
         .iov_base = s->status,
         .iov_len = sizeof(*s->status),
     };
+    ssize_t r;
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
 
@@ -670,7 +677,16 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
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
@@ -1165,6 +1181,15 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
     if (unlikely(r < 0)) {
         return r;
     }
+
+    /*
+     * We can poll here since we've had BQL from the time
+     * we sent the descriptor.
+     */
+    r = vhost_vdpa_net_svq_poll(s, 1);
+    if (unlikely(r < sizeof(*s->status))) {
+        return r;
+    }
     if (*s->status != VIRTIO_NET_OK) {
         return sizeof(*s->status);
     }
@@ -1284,10 +1309,18 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
             goto out;
         }
     } else {
-        dev_written = vhost_vdpa_net_cvq_add(s, &out, 1, &vdpa_in, 1);
-        if (unlikely(dev_written < 0)) {
+        ssize_t r;
+        r = vhost_vdpa_net_cvq_add(s, &out, 1, &vdpa_in, 1);
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


