Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B427778BE15
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 07:57:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qarhw-00057t-Cb; Tue, 29 Aug 2023 01:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhf-00056M-NM
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:55 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhX-0002gc-57
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:48 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-44e84fbaab9so1837390137.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 22:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693288541; x=1693893341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnxO3AVYBE3MPDyI+VnjPw/50xQhfE7VGLY4FZl8BkU=;
 b=f/XKOebEjVFgaSEY/JA70g0U/A8L3zsaaHhDqFqVrSWFb1GiZBfNMWC49HMIXiBJ1s
 2bkRWEmc+8MItjjyX1CVWfCK0xtNuyrqgXRX2q96mZb+NrfVxypBbq8SWu+ByJ86N3qw
 3J4egVW19v6X4J7d94xtyuO/pNrHsuOfvUWCVYHctt40LTcM22ozWrM38BdkVpQ6uTMs
 9ZsaEJIoK+Z+d4ixenmIUtEy/+8ND7A3RdhCUAxrBziN+tmAEklt3SrV4O9IYrz5kLu4
 UMyojjEYD9kZx25qPjzcAIiWsNCw4Vy8Tfg80EuXSyT3nR/Dwg57utJ6eUWFJ3ZqmR8X
 zxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693288541; x=1693893341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QnxO3AVYBE3MPDyI+VnjPw/50xQhfE7VGLY4FZl8BkU=;
 b=FGUwritcXpJF7+Ft2v90NkA7SQCdc/eSsQA/LAt4J5sdI1oXapuh4oQJaJ16HhCiPf
 LUANQeEaPfp4kxl/4DKJwUjS97pxrmaIZJpieXut1dV8fdOWYpImZhUinT2WvJ0U1QiX
 W8LzGKfkRGNRiqK4RC2n9/ac0HVjzAB9++5mkrS5rjPqPmeMvy+A/z5ylwcjy/HwrJRW
 y3J0WPgJgOJg3nznU1AxhRkaJ6PYxekmgOCue7vJzZfyNJW34eofQoQWs5Rvw9+EZIcX
 fwmejeV6f4n0GHapnD7cQUi/egyDcO4O2HHQTloY+HnuuCRB++4vyPeC0jQlTXJ+vsuz
 Ca9A==
X-Gm-Message-State: AOJu0YwOjogv3ssFrSH6ON4ynd0qNGwJvtYE5yZyb5MPh1sy1OQWaPOv
 E2iD+bV7KS9+LhesKoAtp8M=
X-Google-Smtp-Source: AGHT+IEVr6RWUnnHHmHPDQdS288aVXh86hRCmcDqu6VbKbaK/PMY6jY3ovqrH4IsHsJBW+8mgqfWJA==
X-Received: by 2002:a67:f98d:0:b0:44d:4d7f:bcc2 with SMTP id
 b13-20020a67f98d000000b0044d4d7fbcc2mr21392714vsq.12.1693288541246; 
 Mon, 28 Aug 2023 22:55:41 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 ne11-20020a17090b374b00b0026fb228fafasm4567532pjb.18.2023.08.28.22.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 22:55:40 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, leiyang@redhat.com,
 18801353760@163.com
Subject: [PATCH v4 6/8] vdpa: Move vhost_svq_poll() to the caller of
 vhost_vdpa_net_cvq_add()
Date: Tue, 29 Aug 2023 13:54:48 +0800
Message-Id: <496c542c22ae1b4222175d5576c949621c7c2fc0.1693287885.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693287885.git.yin31149@gmail.com>
References: <cover.1693287885.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=yin31149@gmail.com; helo=mail-vs1-xe32.google.com
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
v4:
  - always check the return value of vhost_vdpa_net_svq_poll()
suggested Eugenio

v3: https://lore.kernel.org/all/152177c4e7082236fba9d31d535e40f8c2984349.1689748694.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 53 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 116a06cc45..d9b8b3cf6c 100644
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
@@ -1150,6 +1166,15 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
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
@@ -1269,10 +1294,18 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
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


