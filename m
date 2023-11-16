Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5573C7ED8F8
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:46:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQL-0005Gv-7X; Wed, 15 Nov 2023 20:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQI-0005Ew-6k
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQD-0001zc-RI
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pizuQG2VKmmCYLJ6GmUnliG1sq7KBbVuRhIS3gCZAzg=;
 b=BzR1Ov3+mHHR3hCsl0FDCGPhaWR1UdLz6RWxdFurZi0AOLlgl/+kZe6ENPZXMH6HX9A7zD
 vBRentjjBV5Dt3Gh1XUxUL9qPjgR1hq8KOxaFJ4zL9weRlF4alCS805nF8z731GXkL1ZMg
 Q8chcpfGaEcaBnwmyi+z45QaYALk4QQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-7GvnHjE4N3KMuACPqNLOLw-1; Wed, 15 Nov 2023 20:43:52 -0500
X-MC-Unique: 7GvnHjE4N3KMuACPqNLOLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DCFF185A782;
 Thu, 16 Nov 2023 01:43:52 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09159C15881;
 Thu, 16 Nov 2023 01:43:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 03/19] qapi/schema: name QAPISchemaInclude entities
Date: Wed, 15 Nov 2023 20:43:34 -0500
Message-ID: <20231116014350.653792-4-jsnow@redhat.com>
In-Reply-To: <20231116014350.653792-1-jsnow@redhat.com>
References: <20231116014350.653792-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It simplifies typing to mandate that entities will always have a name;
to achieve this we can occasionally assign an internal name. This
alleviates errors such as:

qapi/schema.py:287: error: Argument 1 to "__init__" of
"QAPISchemaEntity" has incompatible type "None"; expected "str"
[arg-type]

Trying to fix it the other way by allowing entities to only have
optional names opens up a nightmare portal of whackamole to try and
audit that every other pathway doesn't actually pass a None name when we
expect it to; this is the simpler direction of consitifying the typing.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 153e703e0ef..0fb44452dd5 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -220,7 +220,9 @@ def visit(self, visitor):
 
 class QAPISchemaInclude(QAPISchemaEntity):
     def __init__(self, sub_module, info):
-        super().__init__(None, info, None)
+        # Includes are internal entity objects; and may occur multiple times
+        name = f"q_include_{info.fname}:{info.line}"
+        super().__init__(name, info, None)
         self._sub_module = sub_module
 
     def visit(self, visitor):
-- 
2.41.0


