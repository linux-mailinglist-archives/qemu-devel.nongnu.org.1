Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C458ABC51A
	for <lists+qemu-devel@lfdr.de>; Mon, 19 May 2025 19:03:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3rp-0007A8-2G; Mon, 19 May 2025 13:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH3rX-00078d-M9
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH3rV-0000GP-Kr
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747674072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PfvMmpiH74ETfKF0gYAIqykF4EKJoqp2DIO9IuZE8rg=;
 b=KVUHtQC5sH++6Qs/yALUQ5Rlz+Z6jIprFvowpHjikl7f+hfVumuoGERqpGo6CDDITjAVsF
 23N7Qc+7yjiVOT3GI3gC8zdvVzS9STa1Wdn8V82xTrYBTPTzUeFTXfcomiVdPRAl+sehmc
 tnw6yNlA3n1ZOknJw2+8zeyex9252dc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-LqZ9bc3RO8u0RG56E8kxgQ-1; Mon,
 19 May 2025 13:01:04 -0400
X-MC-Unique: LqZ9bc3RO8u0RG56E8kxgQ-1
X-Mimecast-MFC-AGG-ID: LqZ9bc3RO8u0RG56E8kxgQ_1747674063
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 251311800256; Mon, 19 May 2025 17:01:03 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.235])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E1C41956095; Mon, 19 May 2025 17:01:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/6] docs/qapidoc: linting fixes
Date: Mon, 19 May 2025 13:00:51 -0400
Message-ID: <20250519170055.3693275-3-jsnow@redhat.com>
In-Reply-To: <20250519170055.3693275-1-jsnow@redhat.com>
References: <20250519170055.3693275-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This restores the linting baseline in qapidoc. The order of some imports
change slightly here due to configuring isort a little better:
previously, isort was having difficulty understanding that "compat" and
"qapidoc_legacy" were local modules because docs/sphinx "isn't a python
package". Configuring this manually, isort chooses a different import
ordering, which _is_ intentional here.

Also: extra ignores are added for pylint. The most recent versions of
pylint don't require these ignores, but the oldest versions we support
do, so in the extra ignores go.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20250512193357.3388514-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 25 ++++++++++++++-----------
 docs/sphinx/qapidoc.py     |  5 +++--
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index c94af5719ca..ebc46a72c61 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -20,16 +20,6 @@
 
 from docutils import nodes
 from docutils.parsers.rst import directives
-
-from compat import (
-    CompatField,
-    CompatGroupedField,
-    CompatTypedField,
-    KeywordNode,
-    ParserFix,
-    Signature,
-    SpaceNode,
-)
 from sphinx import addnodes
 from sphinx.directives import ObjectDescription
 from sphinx.domains import (
@@ -44,6 +34,16 @@
 from sphinx.util.docutils import SphinxDirective
 from sphinx.util.nodes import make_id, make_refnode
 
+from compat import (
+    CompatField,
+    CompatGroupedField,
+    CompatTypedField,
+    KeywordNode,
+    ParserFix,
+    Signature,
+    SpaceNode,
+)
+
 
 if TYPE_CHECKING:
     from typing import (
@@ -56,7 +56,6 @@
     )
 
     from docutils.nodes import Element, Node
-
     from sphinx.addnodes import desc_signature, pending_xref
     from sphinx.application import Sphinx
     from sphinx.builders import Builder
@@ -168,6 +167,8 @@ class QAPIDescription(ParserFix):
     """
 
     def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
+        # pylint: disable=unused-argument
+
         # Do nothing. The return value here is the "name" of the entity
         # being documented; for QAPI, this is the same as the
         # "signature", which is just a name.
@@ -210,6 +211,8 @@ def _get_fqn(self, name: Signature) -> str:
     def add_target_and_index(
         self, name: Signature, sig: str, signode: desc_signature
     ) -> None:
+        # pylint: disable=unused-argument
+
         # name is the return value of handle_signature.
         # sig is the original, raw text argument to handle_signature.
         # For QAPI, these are identical, currently.
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 661b2c4ed0e..8011ac9efaf 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -27,6 +27,7 @@
 
 from __future__ import annotations
 
+
 __version__ = "2.0"
 
 from contextlib import contextmanager
@@ -56,8 +57,6 @@
     QAPISchemaVisitor,
 )
 from qapi.source import QAPISourceInfo
-
-from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
 from sphinx import addnodes
 from sphinx.directives.code import CodeBlock
 from sphinx.errors import ExtensionError
@@ -65,6 +64,8 @@
 from sphinx.util.docutils import SphinxDirective, switch_source_input
 from sphinx.util.nodes import nested_parse_with_titles
 
+from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
+
 
 if TYPE_CHECKING:
     from typing import (
-- 
2.48.1


