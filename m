Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF84792F4E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 21:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdc5K-0004n3-S7; Tue, 05 Sep 2023 15:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qdc5F-0004lt-RJ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qdc5D-0007Uz-Gf
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693943490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZAQU+jfcX5vQmnPXvtMJx14PmghJ2LIOO4NjyKI3Bk=;
 b=W1CdBH3C7VkPcY5cO78XifjussSYikbOveB94702nSS9Ji0NzxvZ45co4DHDRes0uQhORR
 bsSkNZa9U//Y94koXeInzgDKAJIgwYyKI0/YD+L+22FEvqhR2SgK6jpEyKJs2V792aJWzv
 xFQkYQ05eJ0WR2BIq27ExrLH8r3ZZxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-PQWTLfLKPd-oIwPeEPEGcw-1; Tue, 05 Sep 2023 15:48:57 -0400
X-MC-Unique: PQWTLfLKPd-oIwPeEPEGcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37FC48A4366
 for <qemu-devel@nongnu.org>; Tue,  5 Sep 2023 19:48:57 +0000 (UTC)
Received: from tapioca.wind3.hub (unknown [10.45.225.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D09AC15BB8;
 Tue,  5 Sep 2023 19:48:56 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v1 7/7] qapi: fix example of NETDEV_STREAM_CONNECTED event
Date: Tue,  5 Sep 2023 21:48:46 +0200
Message-ID: <20230905194846.169530-8-victortoso@redhat.com>
In-Reply-To: <20230905194846.169530-1-victortoso@redhat.com>
References: <20230905194846.169530-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Example output was using single quotes. Fix it.

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 qapi/net.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 313c8a606e..81988e499a 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -930,9 +930,9 @@
 #
 # Example:
 #
-# <- { 'event': 'NETDEV_STREAM_DISCONNECTED',
-#      'data': {'netdev-id': 'netdev0'},
-#      'timestamp': {'seconds': 1663330937, 'microseconds': 526695} }
+# <- { "event": "NETDEV_STREAM_DISCONNECTED",
+#      "data": {"netdev-id": "netdev0"},
+#      "timestamp": {"seconds": 1663330937, "microseconds": 526695} }
 ##
 { 'event': 'NETDEV_STREAM_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
-- 
2.41.0


