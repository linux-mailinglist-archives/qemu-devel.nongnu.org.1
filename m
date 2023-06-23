Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C8F73B8C3
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:27:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgo9-0008Q7-Np; Fri, 23 Jun 2023 09:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCgo7-0008O7-LM
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:26:35 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCgo6-00031e-3o
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:26:35 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-39ca120c103so439681b6e.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687526793; x=1690118793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JABNvxjcWneM93hp82dP7+d30/clFEb9V1vOyEdjZQU=;
 b=O3mqZbM0808e8uyaSI3ECt6RVcueEm66CAdZISFz8khbR+JOtZn9maYK/XX/7SauAF
 rR6F6nq1jfxCh9MrobmrMQedvrVG3oe2luJBnc3iXgWewXPkBgRoXyL4KYQOR9aG/oXe
 7X+6K7a53Ed1WQb2BLX7B9Z0F1xsnV1CuO6gYpYqIHrR6Zw6mHAfQ1bFJRRVv2goW0Ee
 LMvws4BiTphEIbe4UAgzIoCrotaUvcdd8OE5ZO56Xm9+NNDcCOANITYQHnRSl4N6KSGR
 RJS7779FXHFXc8Xs/nuxCwUCRvZu5oN/z4VXoNtSL/OkHVxmSeBPzU1uK89uSsulMsWw
 ap1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526793; x=1690118793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JABNvxjcWneM93hp82dP7+d30/clFEb9V1vOyEdjZQU=;
 b=EYHVBXMASA6MiQGJRy6RBeoueyeHa2ido67KFaJLo1PfPr/3h8aawhb/IKj5mL6xQg
 WwIgxhs/r3o3kv1ppz0qaGRC9OeZ2x59INyuq6MaIIpYNasxlrK+XF6ghCkhVK1JWHMf
 Ao+3tGqlfFq7X5URZxnB2oQAfbL0mw7F/4k0qLsF6epV00Vc4bNgdALEgQAo135iMWoT
 KaNt9cUCG0IwBs1kELo3ubH/7KAXlXcrrqzUpeEgkd9PmSf0pn9vgcMAINLi/lnJrzOd
 +Q9eGjSUz/FcOcFVafJDt29dEZkqv8RA9XoPdU/j8jf1cbzuzkZDESh6kN6OgZrlE/de
 gYUg==
X-Gm-Message-State: AC+VfDz2iSymqrSJrX3nKIiAD0GOu3knJtGDHaX/atK+8nLjaPy8mYUf
 9KxsJ1jirce97P7jggYzgmM=
X-Google-Smtp-Source: ACHHUZ4OOOeCsVZl8ijdXP6eT0PNKA63CyT5jtmYRvkTVk6YoIQqQd0hnEHm3qW85pndY/5RLCQlEw==
X-Received: by 2002:a05:6808:1287:b0:39e:ffc5:c450 with SMTP id
 a7-20020a056808128700b0039effc5c450mr17072905oiw.47.1687526792673; 
 Fri, 23 Jun 2023 06:26:32 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 26-20020a17090a031a00b0025e0bea16eesm1554365pje.42.2023.06.23.06.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:26:32 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC 1/2] vdpa: Restore packet receive filtering state relative
 with _F_CTRL_RX_EXTRA feature
Date: Fri, 23 Jun 2023 21:26:25 +0800
Message-Id: <e88a774a47c19ca85ae838b30b75dac549446f5b.1687524532.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687524532.git.yin31149@gmail.com>
References: <cover.1687524532.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=yin31149@gmail.com; helo=mail-oi1-x22c.google.com
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

This patch refactors vhost_vdpa_net_load_rx() to
restore the packet receive filtering state in relation to
VIRTIO_NET_F_CTRL_RX_EXTRA feature at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index ca800f97e2..9b929762c5 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -822,6 +822,36 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
         }
     }
 
+    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX_EXTRA)) {
+        /* Load the all-unicast mode */
+        on = n->alluni;
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLUNI, on);
+        if (r < 0) {
+            return r;
+        }
+
+        /* Load the non-multicast mode */
+        on = n->nomulti;
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOMULTI, on);
+        if (r < 0) {
+            return r;
+        }
+
+        /* Load the non-unicast mode */
+        on = n->nouni;
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOUNI, on);
+        if (r < 0) {
+            return r;
+        }
+
+        /* Load the non-broadcast mode */
+        on = n->nobcast;
+        r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOBCAST, on);
+        if (r < 0) {
+            return r;
+        }
+    }
+
     return 0;
 }
 
-- 
2.25.1


