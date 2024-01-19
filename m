Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50551832EBA
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:16:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNN-0001jZ-4Z; Fri, 19 Jan 2024 13:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNL-0001hq-01
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNI-0007hV-A1
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9voIAbYyAwKOHCB3ugMdMW49+CPAUlQc5sS8VazD/s=;
 b=TcAqEGH2mhgbLOeCf5U0EtjrL9HqWINZVJIrDuKBwueZ21RohXedxCo7QMz2x/gt6OfdZp
 XcEW/8S+EwJmtbiRPODdxXKjK5kdz7S38Hau0kjWtmdS6Nm/bjmwfpt9dtoa/a3D02n6Wi
 AgD6N6Fpxyq28ut/Ag4NZ7j8SB3P96w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-h4HxAFeQN7ag4dygb7TWGg-1; Fri, 19 Jan 2024 13:13:37 -0500
X-MC-Unique: h4HxAFeQN7ag4dygb7TWGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE88910665A0;
 Fri, 19 Jan 2024 18:13:36 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FDA32877;
 Fri, 19 Jan 2024 18:13:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/14] iotests: add filter_qmp_generated_node_ids()
Date: Fri, 19 Jan 2024 19:13:18 +0100
Message-ID: <20240119181327.236745-6-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Add a filter function for QMP responses that contain QEMU's
automatically generated node ids. The ids change between runs and must
be masked in the reference output.

The next commit will use this new function.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240118144823.1497953-2-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index e5c5798c71..ea48af4a7b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -651,6 +651,13 @@ def _filter(_key, value):
 def filter_generated_node_ids(msg):
     return re.sub("#block[0-9]+", "NODE_NAME", msg)
 
+def filter_qmp_generated_node_ids(qmsg):
+    def _filter(_key, value):
+        if is_str(value):
+            return filter_generated_node_ids(value)
+        return value
+    return filter_qmp(qmsg, _filter)
+
 def filter_img_info(output: str, filename: str,
                     drop_child_info: bool = True) -> str:
     lines = []
-- 
2.43.0


