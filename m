Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 057CAA5B76B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 04:47:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqZG-0007qG-KJ; Mon, 10 Mar 2025 23:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqY9-0006UX-BD
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqY7-0002Om-GZ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bfzNyLtW3ph70CiEZf+s4qCwlojzWGR8wU9QTIyQR4=;
 b=LcqO/SGQaEPvqmF3IH93+041R05xCcQ8h5XQw76xDVW4vq1ip6yzZiZdGcgOwxVZPXW5lm
 DEbTrNnY++3xoYNspuB27I2nvk4gFn06Bp+r7KXi9BIMru6FoOXOhpFSCLFCLJensSlDhU
 VUkiFP8iyh0XTHstGKl3lK95U0sqO0M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-UiBWmG7BP1itqBsCk0DMjA-1; Mon,
 10 Mar 2025 23:44:57 -0400
X-MC-Unique: UiBWmG7BP1itqBsCk0DMjA-1
X-Mimecast-MFC-AGG-ID: UiBWmG7BP1itqBsCk0DMjA_1741664696
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E98B1956050; Tue, 11 Mar 2025 03:44:56 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C88E1800373; Tue, 11 Mar 2025 03:44:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 31/63] docs/qapi-domain: Fix error context reporting in
 Sphinx 5.x and 6.x
Date: Mon, 10 Mar 2025 23:42:29 -0400
Message-ID: <20250311034303.75779-32-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Sphinx 5.3.0 to Sphinx 6.2.0 has a bug where nested content in an
ObjectDescription content block has its error position reported
incorrectly due to an oversight when they added nested section support
to this directive.

(This bug is present in Sphinx's own Python and C domains; test it
yourself by creating a py:func directive and creating a syntax error in
the directive's content block. The reporting will be incorrect.)

To avoid overriding and re-implementing the entirety of the run()
method, a workaround is employed where we parse the content block
ourselves in before_content(), then null the content block to make
Sphinx's own parsing a no-op. Then, in transform_content (which occurs
after Sphinx's nested parse), we simply swap our own parsed content tree
back in for Sphinx's.

It appears a little tricky, but it's the nicest solution I can find.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py      | 56 ++++++++++++++++++++++++++++++++++++++
 docs/sphinx/qapi_domain.py | 15 ++++++----
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
index f068d70388d..9cf7fe006e4 100644
--- a/docs/sphinx/compat.py
+++ b/docs/sphinx/compat.py
@@ -4,6 +4,7 @@
 
 import re
 from typing import (
+    TYPE_CHECKING,
     Any,
     Callable,
     Optional,
@@ -12,9 +13,11 @@
 
 from docutils import nodes
 from docutils.nodes import Element, Node, Text
+from docutils.statemachine import StringList
 
 import sphinx
 from sphinx import addnodes, util
+from sphinx.directives import ObjectDescription
 from sphinx.environment import BuildEnvironment
 from sphinx.roles import XRefRole
 from sphinx.util import docfields
@@ -172,3 +175,56 @@ class CompatGroupedField(docfields.GroupedField):
 class CompatTypedField(docfields.TypedField):
     if MAKE_XREF_WORKAROUND:
         make_xref = _compat_make_xref
+
+
+# ################################################################
+# Nested parsing error location fix for Sphinx 5.3.0 < x < 6.2.0 #
+# ################################################################
+
+# When we require Sphinx 4.x, the TYPE_CHECKING hack where we avoid
+# subscripting ObjectDescription at runtime can be removed in favor of
+# just always subscripting the class.
+
+# When we require Sphinx > 6.2.0, the rest of this compatibility hack
+# can be dropped and QAPIObject can just inherit directly from
+# ObjectDescription[Signature].
+
+SOURCE_LOCATION_FIX = (5, 3, 0) <= sphinx.version_info[:3] < (6, 2, 0)
+
+Signature = str
+
+
+if TYPE_CHECKING:
+    _BaseClass = ObjectDescription[Signature]
+else:
+    _BaseClass = ObjectDescription
+
+
+class ParserFix(_BaseClass):
+
+    _temp_content: StringList
+    _temp_offset: int
+    _temp_node: Optional[addnodes.desc_content]
+
+    def before_content(self) -> None:
+        # Work around a sphinx bug and parse the content ourselves.
+        self._temp_content = self.content
+        self._temp_offset = self.content_offset
+        self._temp_node = None
+
+        if SOURCE_LOCATION_FIX:
+            self._temp_node = addnodes.desc_content()
+            self.state.nested_parse(
+                self.content, self.content_offset, self._temp_node
+            )
+            # Sphinx will try to parse the content block itself,
+            # Give it nothingness to parse instead.
+            self.content = StringList()
+            self.content_offset = 0
+
+    def transform_content(self, content_node: addnodes.desc_content) -> None:
+        # Sphinx workaround: Inject our parsed content and restore state.
+        if self._temp_node:
+            content_node += self._temp_node.children
+            self.content = self._temp_content
+            self.content_offset = self._temp_offset
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index b23db1eba26..ca3f3a7e2d5 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -29,6 +29,8 @@
     CompatGroupedField,
     CompatTypedField,
     KeywordNode,
+    ParserFix,
+    Signature,
     SpaceNode,
 )
 from sphinx import addnodes
@@ -147,12 +149,7 @@ def result_nodes(
         return results, []
 
 
-# Alias for the return of handle_signature(), which is used in several places.
-# (In the Python domain, this is Tuple[str, str] instead.)
-Signature = str
-
-
-class QAPIDescription(ObjectDescription[Signature]):
+class QAPIDescription(ParserFix):
     """
     Generic QAPI description.
 
@@ -422,6 +419,10 @@ def _validate_field(self, field: nodes.field) -> None:
             logger.warning(msg, location=field)
 
     def transform_content(self, content_node: addnodes.desc_content) -> None:
+        # This hook runs after before_content and the nested parse, but
+        # before the DocFieldTransformer is executed.
+        super().transform_content(content_node)
+
         self._add_infopips(content_node)
 
         # Validate field lists.
@@ -519,10 +520,12 @@ class QAPIObjectWithMembers(QAPIObject):
 
 
 class QAPIEvent(QAPIObjectWithMembers):
+    # pylint: disable=too-many-ancestors
     """Description of a QAPI Event."""
 
 
 class QAPIJSONObject(QAPIObjectWithMembers):
+    # pylint: disable=too-many-ancestors
     """Description of a QAPI Object: structs and unions."""
 
 
-- 
2.48.1


