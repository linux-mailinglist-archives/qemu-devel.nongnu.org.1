Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F055EA92CB7
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 23:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Wph-0007MX-L4; Thu, 17 Apr 2025 17:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u5WpW-0007M0-N4
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u5WpU-0000W0-Vl
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744925488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/b85gJL7xVHanuZJX/dXUtQRv8HVdyerj2fpryzRbk=;
 b=ad6FZOwPR9vVAV0R/KaT4SScCBIBdaX0Eud7D01MxoREZqObLJJrmlIffCGHjXi5GLMn/R
 zAGbKqc2nyUXL3dbIEAOQpQnybUbrNXmFDAHteOnFEko5Y3rSoWX5aFyiFJxTyqDnG1c/l
 vEN5+ovz9DR3MAbrdtiVw87a6UfknXM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-VirdACRqPDmLjXwO60e9CA-1; Thu,
 17 Apr 2025 17:31:25 -0400
X-MC-Unique: VirdACRqPDmLjXwO60e9CA-1
X-Mimecast-MFC-AGG-ID: VirdACRqPDmLjXwO60e9CA_1744925484
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01A0D18004A7; Thu, 17 Apr 2025 21:31:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.220])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19F3619560A3; Thu, 17 Apr 2025 21:31:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 2/5] docs/qapidoc: linting fixes
Date: Thu, 17 Apr 2025 17:31:11 -0400
Message-ID: <20250417213114.2336239-3-jsnow@redhat.com>
In-Reply-To: <20250417213114.2336239-1-jsnow@redhat.com>
References: <20250417213114.2336239-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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


