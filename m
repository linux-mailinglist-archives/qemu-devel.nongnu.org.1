Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0540B79ABAF
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 23:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qforu-00008D-NT; Mon, 11 Sep 2023 17:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qforp-00007E-1t
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfork-0005Ch-6n
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694469280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b2Cxk50eA7XRIZtzLAYQHZUYqh+tFzV36P5QSHsORuw=;
 b=hUpFVxL8AnclCcC4mDBw1NmSQ66bPFUwgftgf/R9iU1eIouIZFyxjwMKN6NXNf+ExKY7M6
 OdBbCJuJyOkiT4y/g+8bokcdPCk0mhCxXnuTDnZtX8WZTVhMV1DlbqRNzrH4LtXPHCCZuN
 M9lZXXKib4icaWwgT5129fif7RpiulU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-PoUoszn_MRqXlfonlTFpEg-1; Mon, 11 Sep 2023 17:54:38 -0400
X-MC-Unique: PoUoszn_MRqXlfonlTFpEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C86A181792A
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 21:54:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80BFC2026D4B;
 Mon, 11 Sep 2023 21:54:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] vdpa: fix gcc cvq_isolated uninitialized variable warning
Date: Mon, 11 Sep 2023 17:54:35 -0400
Message-ID: <20230911215435.4156314-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

gcc 13.2.1 emits the following warning:

  net/vhost-vdpa.c: In function ‘net_vhost_vdpa_init.constprop’:
  net/vhost-vdpa.c:1394:25: error: ‘cvq_isolated’ may be used uninitialized [-Werror=maybe-uninitialized]
   1394 |         s->cvq_isolated = cvq_isolated;
        |         ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
  net/vhost-vdpa.c:1355:9: note: ‘cvq_isolated’ was declared here
   1355 |     int cvq_isolated;
        |         ^~~~~~~~~~~~
  cc1: all warnings being treated as errors

Cc: Eugenio Pérez <eperezma@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 net/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 34202ca009..7eaee841aa 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1352,7 +1352,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     VhostVDPAState *s;
     int ret = 0;
     assert(name);
-    int cvq_isolated;
+    int cvq_isolated = 0;
 
     if (is_datapath) {
         nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device,
-- 
2.41.0


