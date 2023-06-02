Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF077204A7
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:40:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q55vm-0003ur-6C; Fri, 02 Jun 2023 10:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q55vj-0003uC-U1
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q55vi-0001dT-C8
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685716740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ThbOUsTAsNZ4pyUDNXkUbz3MNNn8R3IdsxJGkjRCjTQ=;
 b=T8/peFfw8TrJm1xR4YPaVFoFVkuJsiZcbzX1sEmLMJERzllOOkngME/AiytmFCOXbP0alL
 DAKpAuhzUi/AuafZaYGz+/espV/pMAAKMZAspOkb/P6Bhbw8KIR7zDyLXhiCiU6V3Qg0lp
 VR1xLwzspMCvoaS/Hmw8+KKuv6ungD0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-Q7VozZ70OIyb7Me2TB5yoA-1; Fri, 02 Jun 2023 10:38:58 -0400
X-MC-Unique: Q7VozZ70OIyb7Me2TB5yoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 668DF3802143
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 14:38:58 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7360814171BB;
 Fri,  2 Jun 2023 14:38:57 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PATCH v2 1/3] vdpa: do not block migration if device has cvq and
 x-svq=on
Date: Fri,  2 Jun 2023 16:38:52 +0200
Message-Id: <20230602143854.1879091-2-eperezma@redhat.com>
In-Reply-To: <20230602143854.1879091-1-eperezma@redhat.com>
References: <20230602143854.1879091-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

It was a mistake to forbid in all cases, as SVQ is already able to send
all the CVQ messages before start forwarding data vqs.  It actually
caused a regression, making impossible to migrate device previously
migratable.

Fixes: 36e4647247f2 ("vdpa: add vhost_vdpa_net_valid_svq_features")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 37cdc84562..c63456ff7c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -837,13 +837,16 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         s->vhost_vdpa.shadow_vq_ops_opaque = s;
 
         /*
-         * TODO: We cannot migrate devices with CVQ as there is no way to set
-         * the device state (MAC, MQ, etc) before starting the datapath.
+         * TODO: We cannot migrate devices with CVQ and no x-svq enabled as
+         * there is no way to set the device state (MAC, MQ, etc) before
+         * starting the datapath.
          *
          * Migration blocker ownership now belongs to s->vhost_vdpa.
          */
-        error_setg(&s->vhost_vdpa.migration_blocker,
-                   "net vdpa cannot migrate with CVQ feature");
+        if (!svq) {
+            error_setg(&s->vhost_vdpa.migration_blocker,
+                       "net vdpa cannot migrate with CVQ feature");
+        }
     }
     ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index, nvqs);
     if (ret) {
-- 
2.31.1


