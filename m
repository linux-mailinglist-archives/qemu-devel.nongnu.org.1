Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E04A581AC
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 09:37:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trC8n-0000wh-WB; Sun, 09 Mar 2025 04:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC8k-0000vB-Jv
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC8i-00020O-V5
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJ8i3B3IWUv9hwDYZ3ZSUdrZb/ZBpQUf3O+dp/jYjMw=;
 b=iDxPHKOSPebL/h5Hek+pU+cVvzQIhYDdL7HMIcONqso6y4U2t+Xn1hOODU3cOm1Fj/G3DR
 sJsJXB9ATuZUt6WWRawJIZLV7D3xQucgnPngxjwsY4leWKBYPsp9eGC8sCyPI3ftRQD130
 uIoc363bdLZkv/4Zyj6oXNaCFaFko64=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-jYPs6OBvP6C6zFAyLH68hQ-1; Sun,
 09 Mar 2025 04:36:01 -0400
X-MC-Unique: jYPs6OBvP6C6zFAyLH68hQ-1
X-Mimecast-MFC-AGG-ID: jYPs6OBvP6C6zFAyLH68hQ_1741509360
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B08DD1955D66; Sun,  9 Mar 2025 08:35:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A54CB19560AB; Sun,  9 Mar 2025 08:35:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 03/62] docs/sphinx: create QAPI domain extension stub
Date: Sun,  9 Mar 2025 04:34:50 -0400
Message-ID: <20250309083550.5155-4-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

A Sphinx domain is a collection of directive and role extensions meant
to facilitate the documentation of a specific language. For instance,
Sphinx ships with "python" and "cpp" domains. This patch introduces a
stub for the "qapi" language domain.

Please see https://www.sphinx-doc.org/en/master/usage/domains/index.html
for more information.

This stub doesn't really do anything yet, we'll get to it brick-by-brick
in the forthcoming commits to keep the series breezy and the git history
informative.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/conf.py               |  9 +++++-
 docs/sphinx/qapi_domain.py | 56 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 docs/sphinx/qapi_domain.py

diff --git a/docs/conf.py b/docs/conf.py
index 31bb9a37893..49d9de894c0 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -60,7 +60,14 @@
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'qmp_lexer', 'hxtool', 'depfile', 'qapidoc']
+extensions = [
+    'depfile',
+    'hxtool',
+    'kerneldoc',
+    'qapi_domain',
+    'qapidoc',
+    'qmp_lexer',
+]
 
 if sphinx.version_info[:3] > (4, 0, 0):
     tags.add('sphinx4')
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
new file mode 100644
index 00000000000..a1983d94440
--- /dev/null
+++ b/docs/sphinx/qapi_domain.py
@@ -0,0 +1,56 @@
+"""
+QAPI domain extension.
+"""
+
+from __future__ import annotations
+
+from typing import (
+    TYPE_CHECKING,
+    AbstractSet,
+    Any,
+    Dict,
+    Tuple,
+)
+
+from sphinx.domains import Domain, ObjType
+from sphinx.util import logging
+
+
+if TYPE_CHECKING:
+    from sphinx.application import Sphinx
+
+logger = logging.getLogger(__name__)
+
+
+class QAPIDomain(Domain):
+    """QAPI language domain."""
+
+    name = "qapi"
+    label = "QAPI"
+
+    object_types: Dict[str, ObjType] = {}
+    directives = {}
+    roles = {}
+    initial_data: Dict[str, Dict[str, Tuple[Any]]] = {}
+    indices = []
+
+    def merge_domaindata(
+        self, docnames: AbstractSet[str], otherdata: Dict[str, Any]
+    ) -> None:
+        pass
+
+    def resolve_any_xref(self, *args: Any, **kwargs: Any) -> Any:
+        # pylint: disable=unused-argument
+        return []
+
+
+def setup(app: Sphinx) -> Dict[str, Any]:
+    app.setup_extension("sphinx.directives")
+    app.add_domain(QAPIDomain)
+
+    return {
+        "version": "1.0",
+        "env_version": 1,
+        "parallel_read_safe": True,
+        "parallel_write_safe": True,
+    }
-- 
2.48.1


