Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10511A5B761
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 04:44:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqWq-0003op-Ej; Mon, 10 Mar 2025 23:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWo-0003nq-C0
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWm-0002BY-OM
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47kDV8pslVfnI/PhY1qudd7KTC5xlcRsFLPBPKcti7g=;
 b=PGMXErhv2bTtbJokepQdrKHq3o3GXxqstgQB5Eb+Z+QGq/k51TnHYFqkOx7AQL2w3y6++S
 5P5Z4rpW1JaZIP4dRgjnF+MEFkg4Bg/CbuakBSdh9WutEb2oR7nnL9qwWQIPMeTddhMKxV
 /XXZqVskqZ3ekg2omngefyh/lhd+/aA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-4BO8PCPDNcSaELq77jUuMA-1; Mon,
 10 Mar 2025 23:43:32 -0400
X-MC-Unique: 4BO8PCPDNcSaELq77jUuMA-1
X-Mimecast-MFC-AGG-ID: 4BO8PCPDNcSaELq77jUuMA_1741664611
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3624A1955D4B; Tue, 11 Mar 2025 03:43:31 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F5C81800366; Tue, 11 Mar 2025 03:43:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 06/63] docs/qapi-domain: add QAPI index
Date: Mon, 10 Mar 2025 23:42:04 -0400
Message-ID: <20250311034303.75779-7-jsnow@redhat.com>
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

Use the QAPI object registry to generate a special index just for QAPI
definitions. The index can show entries both by definition type and all
together, alphabetically.

The index can be linked from anywhere in the QEMU manual by using the
reference `qapi-index`.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 73 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index f3ece42bc2a..3e7718d32d1 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -9,12 +9,20 @@
     AbstractSet,
     Any,
     Dict,
+    Iterable,
+    List,
     NamedTuple,
+    Optional,
     Tuple,
 )
 
-from sphinx.domains import Domain, ObjType
-from sphinx.locale import __
+from sphinx.domains import (
+    Domain,
+    Index,
+    IndexEntry,
+    ObjType,
+)
+from sphinx.locale import _, __
 from sphinx.util import logging
 
 
@@ -31,6 +39,62 @@ class ObjectEntry(NamedTuple):
     aliased: bool
 
 
+class QAPIIndex(Index):
+    """
+    Index subclass to provide the QAPI definition index.
+    """
+
+    # pylint: disable=too-few-public-methods
+
+    name = "index"
+    localname = _("QAPI Index")
+    shortname = _("QAPI Index")
+
+    def generate(
+        self,
+        docnames: Optional[Iterable[str]] = None,
+    ) -> Tuple[List[Tuple[str, List[IndexEntry]]], bool]:
+        assert isinstance(self.domain, QAPIDomain)
+        content: Dict[str, List[IndexEntry]] = {}
+        collapse = False
+
+        # list of all object (name, ObjectEntry) pairs, sorted by name
+        # (ignoring the module)
+        objects = sorted(
+            self.domain.objects.items(),
+            key=lambda x: x[0].split(".")[-1].lower(),
+        )
+
+        for objname, obj in objects:
+            if docnames and obj.docname not in docnames:
+                continue
+
+            # Strip the module name out:
+            objname = objname.split(".")[-1]
+
+            # Add an alphabetical entry:
+            entries = content.setdefault(objname[0].upper(), [])
+            entries.append(
+                IndexEntry(
+                    objname, 0, obj.docname, obj.node_id, obj.objtype, "", ""
+                )
+            )
+
+            # Add a categorical entry:
+            category = obj.objtype.title() + "s"
+            entries = content.setdefault(category, [])
+            entries.append(
+                IndexEntry(objname, 0, obj.docname, obj.node_id, "", "", "")
+            )
+
+        # alphabetically sort categories; type names first, ABC entries last.
+        sorted_content = sorted(
+            content.items(),
+            key=lambda x: (len(x[0]) == 1, x[0]),
+        )
+        return sorted_content, collapse
+
+
 class QAPIDomain(Domain):
     """QAPI language domain."""
 
@@ -54,7 +118,10 @@ class QAPIDomain(Domain):
         "objects": {},  # fullname -> ObjectEntry
     }
 
-    indices = []
+    # Index pages to generate; each entry is an Index class.
+    indices = [
+        QAPIIndex,
+    ]
 
     @property
     def objects(self) -> Dict[str, ObjectEntry]:
-- 
2.48.1


