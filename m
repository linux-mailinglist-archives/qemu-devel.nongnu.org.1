Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B42F74E1D9
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:07:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwq-0004qq-6y; Mon, 10 Jul 2023 19:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwn-0004YB-A3
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwl-0004vV-Nl
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7IFqp1H6rwpWHqy0sAsAkOpjQIWvgkCXKQLg3lFhmnQ=;
 b=O6OGNrIm11Yowt6a+1ws0quehj/jHNaf1EqjbFj/wDptNVQZiISpSIYShsP6+RHbKoNGw/
 QWIlDGVVJR1VfdhQS6zxfxqKHParHBw/8a0SOKErladoS1dJwhAE5o+++brJT1ENliWpTx
 /p6x/LovqIZhrGK5HjRO0ATSLbiQqhg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-YxgyPDhrPpWNX9snPkN0rg-1; Mon, 10 Jul 2023 19:05:33 -0400
X-MC-Unique: YxgyPDhrPpWNX9snPkN0rg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3113da8b778so2713972f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030332; x=1691622332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IFqp1H6rwpWHqy0sAsAkOpjQIWvgkCXKQLg3lFhmnQ=;
 b=LbUixos+P3sxUtv4lBpOtILq2wuK1HvtaioQAYhfZKU9TOIYrGKoCNoj+N7YP9PgcS
 6Sth3mraeypcevGKX+uHtLm/FLQcFZTVX7P3l10OAnBskHl+gS1h49BUuByAuL+wv2ht
 XHKUeW3WjMJbtNfQYm/DFVVCbhINZqm+6cQKzDcCzOnlWNNXCq+ilqEQXemrczAbkjiu
 5FhRRpnmpYh//Zu0Yky2UqSyI9yuZrXYyttYoU0QBcm2Z88sMrFMf1O+WrWiri+UYvRS
 XXBXBWfeB2u3c/8ZfqcKcGbB0LFuI2hDC3UDYRbrUEEyydccE+3717+iaVbvhB/r4VMb
 pTPg==
X-Gm-Message-State: ABy/qLaqnU0Fie+MROk2atH6LK7FahmNkKtDZVadwe4qQkPXJcmXMckO
 o828MsvSrnaHczx4tObnP1dqA6SQJdeZsiaMWN9XrWa3stXjKlVhyxvtky5tT837DU4+c9ZzrNa
 u3tByY1Mb2UINpSOYPNebMaKX1ImhI1Qj8gHUPw+xdOu2RVcFxRLSWOWqTHl29VmFrae3
X-Received: by 2002:a5d:504d:0:b0:314:38e4:259f with SMTP id
 h13-20020a5d504d000000b0031438e4259fmr12382617wrt.37.1689030332363; 
 Mon, 10 Jul 2023 16:05:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcXAgXOwD3VyqE6/cvZAiiXSSEdFZhqHEUDFt6FzIg+tGufiHMRPpr/zwc1B76TYLtuGcNbA==
X-Received: by 2002:a5d:504d:0:b0:314:38e4:259f with SMTP id
 h13-20020a5d504d000000b0031438e4259fmr12382601wrt.37.1689030332143; 
 Mon, 10 Jul 2023 16:05:32 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 c3-20020adffb03000000b0031432f1528csm589189wrr.45.2023.07.10.16.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:31 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 65/66] vdpa: Restore packet receive filtering state relative
 with _F_CTRL_RX_EXTRA feature
Message-ID: <4fd180c7bb476d0793f3849ae4e6c0f932b6e3ab.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Hawkins Jiawei <yin31149@gmail.com>

This patch refactors vhost_vdpa_net_load_rx() to
restore the packet receive filtering state in relation to
VIRTIO_NET_F_CTRL_RX_EXTRA feature at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <abddc477a476f756de6e3d24c0e9f7b21c99a4c1.1688797728.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 5cd671bfb9..0c1c0760a7 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -873,6 +873,94 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
         }
     }
 
+    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX_EXTRA)) {
+        return 0;
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns all-unicast mode
+     * off by default.
+     *
+     * Therefore, QEMU should only send this CVQ command if the driver
+     * sets all-unicast mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (n->alluni) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_ALLUNI, 1);
+        if (dev_written < 0) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns non-multicast mode
+     * off by default.
+     *
+     * Therefore, QEMU should only send this CVQ command if the driver
+     * sets non-multicast mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (n->nomulti) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_NOMULTI, 1);
+        if (dev_written < 0) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns non-unicast mode
+     * off by default.
+     *
+     * Therefore, QEMU should only send this CVQ command if the driver
+     * sets non-unicast mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (n->nouni) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_NOUNI, 1);
+        if (dev_written < 0) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns non-broadcast mode
+     * off by default.
+     *
+     * Therefore, QEMU should only send this CVQ command if the driver
+     * sets non-broadcast mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (n->nobcast) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_NOBCAST, 1);
+        if (dev_written < 0) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
     return 0;
 }
 
-- 
MST


