Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE237B7AB8
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:52:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxaS-0001pw-Je; Wed, 04 Oct 2023 04:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnxZk-00015F-N5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnxZi-0004bS-Uw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tPESG4d4x/1iw90yTmTXrK+G1kOfr0jRSYDdK9eKeTs=;
 b=U+R9ht8l9Ohu4iu9tMn7YwkKb8+Bm29O3R2epZfZHurfHX7Sct6SmgVdjY27eaESI3QCiO
 QD49u1irqgnptAmWCy3bCTDMG2rfuldwyqjM38VkzhLv7N1G4bB9pPPw/1X0byrs0SKBUL
 vjKaI6UweM6GegTqsWjuSRKoxqXrCiM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-T0wnY_kwNIOOc-QeIUW23w-1; Wed, 04 Oct 2023 04:49:40 -0400
X-MC-Unique: T0wnY_kwNIOOc-QeIUW23w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54559811E93;
 Wed,  4 Oct 2023 08:49:40 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-181.str.redhat.com
 [10.33.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F1D97B62;
 Wed,  4 Oct 2023 08:49:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] hw/net/vhost_net: Silence compiler warning when compiling
 with -Wshadow
Date: Wed,  4 Oct 2023 10:49:39 +0200
Message-ID: <20231004084939.96349-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename the innermost local variables to avoid compiler warnings
with "-Wshadow".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/vhost_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 57427a3997..e8e1661646 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -313,8 +313,8 @@ fail:
                 /* Queue might not be ready for start */
                 continue;
             }
-            int r = vhost_net_set_backend(&net->dev, &file);
-            assert(r >= 0);
+            int ret = vhost_net_set_backend(&net->dev, &file);
+            assert(ret >= 0);
         }
     }
     if (net->nc->info->poll) {
@@ -629,8 +629,8 @@ err_start:
     if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
         file.fd = VHOST_FILE_UNBIND;
         file.index = idx;
-        int r = vhost_net_set_backend(&net->dev, &file);
-        assert(r >= 0);
+        int ret = vhost_net_set_backend(&net->dev, &file);
+        assert(ret >= 0);
     }
 
     vhost_dev_stop(&net->dev, vdev, false);
-- 
2.41.0


