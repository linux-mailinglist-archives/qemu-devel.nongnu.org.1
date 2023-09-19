Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1027A6C3E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qihC2-0001uh-6Q; Tue, 19 Sep 2023 16:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qihBj-0001rv-Hq
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 16:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qihBi-0003aT-6S
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 16:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695154753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNFyZN88nrgtZzZcG0YQR6CAWMg+fRmP3W5q8h6ZJFE=;
 b=AQNYMxHVqzF7POa9zGy/Qh32EgENYDod1EIDCV5BIgkN5kRd38rBFUZeyKo/vtjrXnKVQs
 gXH24PJJN0sjL60ZOugyCE6dRtXCmvcSjlqcMnhHKhx8ED8L9mBtQRliFLrkQOlJWjZac9
 lmrkde3oLcVPTkLT7PkvTFc1MPWzsWY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-oT-M4v83PxeHQVFhW6fcxQ-1; Tue, 19 Sep 2023 16:19:11 -0400
X-MC-Unique: oT-M4v83PxeHQVFhW6fcxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88544811E7B
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 20:19:11 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47D87140E950;
 Tue, 19 Sep 2023 20:19:10 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 06/10] qapi: fix example of NETDEV_STREAM_CONNECTED event
Date: Tue, 19 Sep 2023 22:18:53 +0200
Message-ID: <20230919201857.675913-7-victortoso@redhat.com>
In-Reply-To: <20230919201857.675913-1-victortoso@redhat.com>
References: <20230919201857.675913-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

Example output was using single quotes. Fix it.

Signed-off-by: Victor Toso <victortoso@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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


