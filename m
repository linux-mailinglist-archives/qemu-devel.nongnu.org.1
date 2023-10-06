Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 914447BB6B7
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:42:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9D-00054s-0L; Fri, 06 Oct 2023 07:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8o-0004zF-6t
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8h-00006X-9G
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XhY21QmsLLBiVXGuXCgzmBB9K8MxYLcevoy4YO0rk0=;
 b=FBknR52YyktRNH3DSebHPnDSx8kfBZ2E6wRaJsog+PSfop5rrWPK6didPoW+KQMzG0qiBd
 WHZQPY7RdHSsE0VpKC0Le4g5g97bh8OfXYkCQTxbxBdbas/XzW4UoBGQ/vir8KKUSSEuyF
 f2YQUfLw0SGPThyzGV/yPbiHoAUBR5s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-wtQLLq7eMdWAajxZ6aTfEw-1; Fri, 06 Oct 2023 07:36:59 -0400
X-MC-Unique: wtQLLq7eMdWAajxZ6aTfEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC9B7811E8D
 for <qemu-devel@nongnu.org>; Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C67340C6EC1
 for <qemu-devel@nongnu.org>; Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6615821E690F; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Thomas Huth <thuth@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 06/32] hw/net/vhost_net: Silence compiler warning when
 compiling with -Wshadow
Date: Fri,  6 Oct 2023 13:36:31 +0200
Message-ID: <20231006113657.3803180-7-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

Rename the innermost local variables to avoid compiler warnings
with "-Wshadow".

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231004084939.96349-1-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


