Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B117ED8FD
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:48:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQW-0005LE-EA; Wed, 15 Nov 2023 20:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQJ-0005GJ-Kf
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQD-0001zf-SM
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LUNYTwKFIURIMs3zNQb1pL4DzA4DI1sItK09tnGDlGw=;
 b=hClPuCE7FahmpbYZyBjgPrB0WoE4fX3GiK1F4eLP7X7XrDqEPETUnpYyPe1IeOBaJfepAW
 d/z4E+Dr6Eqz1DQFcaLKS+RueSDYxHsA13+2q4t5LgtAAJLJXIk1a3jdyNVSyCBWuPMdeM
 SxDUpvoBdkjyLZ21UZMFN2mHbxXO5+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-7-V9uUfdNq--p_dRs5O1Zg-1; Wed, 15 Nov 2023 20:43:53 -0500
X-MC-Unique: 7-V9uUfdNq--p_dRs5O1Zg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBED3828B20;
 Thu, 16 Nov 2023 01:43:52 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACA21C15881;
 Thu, 16 Nov 2023 01:43:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 05/19] qapi/schema: make c_type() and json_type() abstract
 methods
Date: Wed, 15 Nov 2023 20:43:36 -0500
Message-ID: <20231116014350.653792-6-jsnow@redhat.com>
In-Reply-To: <20231116014350.653792-1-jsnow@redhat.com>
References: <20231116014350.653792-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

These methods should always return a str, it's only the default abstract
implementation that doesn't. They can be marked "abstract" by raising
NotImplementedError(), which requires subclasses to override the method
with the proper return type.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index c5fdd625452..4600a566005 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -233,8 +233,8 @@ def visit(self, visitor):
 class QAPISchemaType(QAPISchemaEntity):
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
-    def c_type(self):
-        pass
+    def c_type(self) -> str:
+        raise NotImplementedError()
 
     # Return the C type to be used in a parameter list.
     def c_param_type(self):
@@ -244,8 +244,8 @@ def c_param_type(self):
     def c_unboxed_type(self):
         return self.c_type()
 
-    def json_type(self):
-        pass
+    def json_type(self) -> str:
+        raise NotImplementedError()
 
     def alternate_qtype(self):
         json2qtype = {
-- 
2.41.0


