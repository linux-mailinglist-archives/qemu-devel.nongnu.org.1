Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C06867218
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 11:53:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZH-0002ne-3f; Mon, 26 Feb 2024 05:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYg-0002ba-FK
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYa-0003iy-8p
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZFRSAdSZWmsUT3rCIgBsqGoAo8qw2YkRWizVDHUWmx0=;
 b=WGiRguGB7Mh+rlqyBRxPIcO4SOKJe9F5oIIkN/UNQI5b1aP97FrJpHK5mqPnU791fqaDLt
 jr3aL3TCtdUW/hT85NyuLckPiDTxjE6yVmfKaM7PJPJLTzgyfCmbhMa2rbFV4RP3FWv9OA
 D/i+DNPsu7hiqiC+ZYDczBuxElMVEno=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-oqheQmOkMYCHZQM3YvHQbA-1; Mon,
 26 Feb 2024 05:49:57 -0500
X-MC-Unique: oqheQmOkMYCHZQM3YvHQbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E14E83C000B2;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE0F5112132A;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97F2121E60F4; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/17] qapi: Improve error position for bogus invalid "Returns"
 section
Date: Mon, 26 Feb 2024 11:49:44 +0100
Message-ID: <20240226104954.3781985-8-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

When something other than a command has a "Returns" section, the error
message points to the beginning of the definition comment.  Point to
the "Returns" section instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-7-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/qapi/parser.py                   | 10 +++++++---
 tests/qapi-schema/doc-invalid-return.err |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 82db595dcf..a771013959 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -759,9 +759,13 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
         self.features[feature.name].connect(feature)
 
     def check_expr(self, expr: QAPIExpression) -> None:
-        if self.has_section('Returns') and 'command' not in expr:
-            raise QAPISemError(self.info,
-                               "'Returns:' is only valid for commands")
+        if 'command' not in expr:
+            sec = next((sec for sec in self.sections
+                        if sec.name == 'Returns'),
+                       None)
+            if sec:
+                raise QAPISemError(sec.info,
+                                   "'Returns:' is only valid for commands")
 
     def check(self) -> None:
 
diff --git a/tests/qapi-schema/doc-invalid-return.err b/tests/qapi-schema/doc-invalid-return.err
index 2ad89c5941..bc5826de20 100644
--- a/tests/qapi-schema/doc-invalid-return.err
+++ b/tests/qapi-schema/doc-invalid-return.err
@@ -1 +1 @@
-doc-invalid-return.json:3: 'Returns:' is only valid for commands
+doc-invalid-return.json:5: 'Returns:' is only valid for commands
-- 
2.43.0


