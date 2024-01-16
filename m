Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F382F4CC
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 20:02:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPogN-00019z-2x; Tue, 16 Jan 2024 14:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rPogB-000189-4d
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 14:00:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rPog9-000411-Kz
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 14:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705431652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gLDzkc7KKVNmxeppPypneb8/SdwIkB4+XfAka8zeSw=;
 b=WzLjvNbxgUzYymVXEs/IvXkG1PC/LVgTbBlAZsZs4bV31jlwKO38EMLSxhnQjXFJGttXSG
 y+v48QUWVEgX2zXrLuRGzr2x7u03bLur6Xj2cwyaN+aBDLbqDgW1cwRvPHggwnTgiQ3o/r
 DK6L3a125/3YxfXuX3T9eJYXU84MQ40=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-4i_5thweN2SAQ7euCLtL6g-1; Tue,
 16 Jan 2024 14:00:48 -0500
X-MC-Unique: 4i_5thweN2SAQ7euCLtL6g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E54E280D207;
 Tue, 16 Jan 2024 19:00:47 +0000 (UTC)
Received: from localhost (unknown [10.39.192.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E18C492BC6;
 Tue, 16 Jan 2024 19:00:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 <qemu-block@nongnu.org>, Fiona Ebner <f.ebner@proxmox.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/3] iotests: add filter_qmp_generated_node_ids()
Date: Tue, 16 Jan 2024 14:00:40 -0500
Message-ID: <20240116190042.1363717-2-stefanha@redhat.com>
In-Reply-To: <20240116190042.1363717-1-stefanha@redhat.com>
References: <20240116190042.1363717-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Add a filter function for QMP responses that contain QEMU's
automatically generated node ids. The ids change between runs and must
be masked in the reference output.

The next commit will use this new function.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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


