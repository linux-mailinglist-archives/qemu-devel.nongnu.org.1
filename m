Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C42F47D2221
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:23:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUfH-0000Om-Th; Sun, 22 Oct 2023 05:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfE-0000L3-S5
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfD-0000Cs-8L
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQj1+sM1CuS1GDO6GpoEJ5VkqRYFFR3ZZ4DVN4jzDRw=;
 b=FezsOzFv6pTV6IBXvvtybCA3G8b0zW0HuoSBduLPHkuKnos4A5ooQJ3ovjLjN7T8gz/2wK
 x5+Zb58ZdT4zVmiHzpLiWwusGwO/O5H25SC09TZ4q5YqnW6dDbQ2nJNqK0MjGkGgouxtrz
 YVnPEw0xmQe9CPAVrHXDma+rzPujHws=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-8TrMXhI3ODSr3sSh83q-sg-1; Sun, 22 Oct 2023 05:22:14 -0400
X-MC-Unique: 8TrMXhI3ODSr3sSh83q-sg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4083c9b426fso14674615e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966532; x=1698571332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQj1+sM1CuS1GDO6GpoEJ5VkqRYFFR3ZZ4DVN4jzDRw=;
 b=D9NiEc4voVxgOY7QNxETeinD+G8a96yRfwitwccMFtndpww7D/tcr4nZpH4Q7jjF90
 GA+YRk3bFMv2WMR2DtXlKnn53HaE3PG7uQE2b0gxS188Tga3JdOU/Mabc+bFQD0FEb90
 jkMX/1X9V1osxoZ8Zp75kpkv1XvIjnRPAeCIDDnjohc/DcqKVAyEKLVcQMgG+sfvqWP1
 hJnQ/uzI7YYuIq549AcCnwHyyBjFevriHow+8OzwURcBF88M18+TKMK6IOnIb0grHJJm
 7uyF6sIevMI/YfCRj5/gQy9RpIFewHxGafJWoboXvf4bw4swPANN7xbPcHv6Urx7dCxA
 zdFg==
X-Gm-Message-State: AOJu0Ywhtt5TcQBGut/1OAC3yCDSf+KzGd33SXP7eTpGFxQYhhybHNQj
 jRMwmXZ9WExL/TEcJZgGTAkHaOnkEdH3i0gAnxdzos4Rj58fzXztheuEW+vpiJ5NvXnTAbwnjLr
 oUyeX4ASFm1NBrHqWMgGhC1Y0oDz3WI67mvD2j4NyjMHWtYHZ3XlpLjjoMGm159qrfVbl
X-Received: by 2002:adf:f5c8:0:b0:32d:9113:a41b with SMTP id
 k8-20020adff5c8000000b0032d9113a41bmr3898421wrp.66.1697966532118; 
 Sun, 22 Oct 2023 02:22:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3v47ziCWnRG3oRYdadH3Pgq0jEE0qAfUpDFmTUcKU1KxSYjghxRRlPsAqefRsHbx9rwCAVw==
X-Received: by 2002:adf:f5c8:0:b0:32d:9113:a41b with SMTP id
 k8-20020adff5c8000000b0032d9113a41bmr3898414wrp.66.1697966531712; 
 Sun, 22 Oct 2023 02:22:11 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 u14-20020a5d468e000000b00323330edbc7sm5294661wrq.20.2023.10.22.02.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:11 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL v3 04/62] vdpa: Move vhost_svq_poll() to the caller of
 vhost_vdpa_net_cvq_add()
Message-ID: <a864a3219d7e63569583d204c12bff2a0f90463e.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hawkins Jiawei <yin31149@gmail.com>

This patch moves vhost_svq_poll() to the caller of
vhost_vdpa_net_cvq_add() and introduces a helper funtion.

By making this change, next patches in this series is
able to refactor vhost_vdpa_net_load_x() only to delay
the polling and checking process until either the SVQ
is full or control commands shadow buffers are full.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <196cadb55175a75275660c6634a538289f027ae3.1697165821.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
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
MST


