Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 085BC7ED90A
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:48:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQK-0005GD-79; Wed, 15 Nov 2023 20:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQH-0005Eo-S8
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQC-0001zP-EL
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08it7JyTmlqZ2qYMjBMaLdaRQndHwtSJh7g5239FHgk=;
 b=JhmnLFXY9Kn8PsH5BTcQbnEVheP+vf/r0l2+cCZt/UHKtklw8uOo64C2HTSB49oIY4b/Pu
 RoeGGUx6C3DpCz15idzHfxtEPHfGkOEJe8ikzvo2ytTkP/bTxy2q+qTcYdQJ9D9njBGv14
 GnvaQzNZeflj+g2GCqUTr7kI9FWK/FE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-4VQTjWjoPiWX20yeV7hLDw-1; Wed,
 15 Nov 2023 20:43:52 -0500
X-MC-Unique: 4VQTjWjoPiWX20yeV7hLDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC51C1C05EC3;
 Thu, 16 Nov 2023 01:43:51 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A946CC15881;
 Thu, 16 Nov 2023 01:43:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 02/19] qapi/schema: add pylint suppressions
Date: Wed, 15 Nov 2023 20:43:33 -0500
Message-ID: <20231116014350.653792-3-jsnow@redhat.com>
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

With this, pylint is happy with the file, so enable it in the
configuration.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/pylintrc  | 5 -----
 scripts/qapi/schema.py | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
index 90546df5345..aafddd3d8d0 100644
--- a/scripts/qapi/pylintrc
+++ b/scripts/qapi/pylintrc
@@ -1,10 +1,5 @@
 [MASTER]
 
-# Add files or directories matching the regex patterns to the ignore list.
-# The regex matches against base names, not paths.
-ignore-patterns=schema.py,
-
-
 [MESSAGES CONTROL]
 
 # Disable the message, report, category or checker with the given id(s). You
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index c79747b2a15..153e703e0ef 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -13,6 +13,7 @@
 # See the COPYING file in the top-level directory.
 
 # TODO catching name collisions in generated code would be nice
+# pylint: disable=too-many-lines
 
 from collections import OrderedDict
 import os
@@ -82,6 +83,7 @@ def c_name(self):
         return c_name(self.name)
 
     def check(self, schema):
+        # pylint: disable=unused-argument
         assert not self._checked
         seen = {}
         for f in self.features:
@@ -116,6 +118,7 @@ def is_implicit(self):
         return not self.info
 
     def visit(self, visitor):
+        # pylint: disable=unused-argument
         assert self._checked
 
     def describe(self):
@@ -134,6 +137,7 @@ def visit_module(self, name):
         pass
 
     def visit_needed(self, entity):
+        # pylint: disable=unused-argument
         # Default to visiting everything
         return True
 
-- 
2.41.0


