Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E036A5BF11
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 12:33:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxqJ-00039d-OW; Tue, 11 Mar 2025 07:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq6-00033H-R9
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxpx-0006SJ-7R
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Is6a5N00uknZIelzF2+id8m4QFd+3awuhN/SWIJn9Y8=;
 b=M3crRN6GD+z/j5roukZhxCOIQ6nElePUqkcd0H3b69w5mF4TuorHZomTuMLs3wZKGMVDtk
 KT2/PfhG87pdPcWE+rv0bprsrnoQQJW2s4uk9+F5ogA0XAmzbzBcffEHmPrXIhzJlgLOzA
 QHABkUxj11gGSmjFI2FjRwApNeNy5t8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-CdvwFVmGMNKwrOJnS-xWfQ-1; Tue,
 11 Mar 2025 07:31:49 -0400
X-MC-Unique: CdvwFVmGMNKwrOJnS-xWfQ-1
X-Mimecast-MFC-AGG-ID: CdvwFVmGMNKwrOJnS-xWfQ_1741692708
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C592818007E1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FA291828A92
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C953421E65DD; Tue, 11 Mar 2025 12:31:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 06/61] docs/qapi-domain: add QAPI xref roles
Date: Tue, 11 Mar 2025 12:30:42 +0100
Message-ID: <20250311113137.1277125-7-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

Add domain-specific cross-reference syntax. As of this commit, that
means new :qapi:any:`block-core` referencing syntax.

The :any: role will find anything registered to the QAPI domain,
including modules, commands, events, etc.

Creating the cross-references is powered by the QAPIXRefRole class;
resolving them is handled by QAPIDomain.resolve_xref().

QAPIXrefRole is based heavily on Sphinx's own PyXrefRole, with
modifications necessary for QAPI features.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-9-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 88 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index f05c2cadf0..49d42c0921 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -26,6 +26,7 @@
     ObjType,
 )
 from sphinx.locale import _, __
+from sphinx.roles import XRefRole
 from sphinx.util import logging
 from sphinx.util.nodes import make_refnode
 
@@ -47,6 +48,54 @@ class ObjectEntry(NamedTuple):
     aliased: bool
 
 
+class QAPIXRefRole(XRefRole):
+
+    def process_link(
+        self,
+        env: BuildEnvironment,
+        refnode: Element,
+        has_explicit_title: bool,
+        title: str,
+        target: str,
+    ) -> tuple[str, str]:
+        refnode["qapi:module"] = env.ref_context.get("qapi:module")
+
+        # Cross-references that begin with a tilde adjust the title to
+        # only show the reference without a leading module, even if one
+        # was provided. This is a Sphinx-standard syntax; give it
+        # priority over QAPI-specific type markup below.
+        hide_module = False
+        if target.startswith("~"):
+            hide_module = True
+            target = target[1:]
+
+        # Type names that end with "?" are considered optional
+        # arguments and should be documented as such, but it's not
+        # part of the xref itself.
+        if target.endswith("?"):
+            refnode["qapi:optional"] = True
+            target = target[:-1]
+
+        # Type names wrapped in brackets denote lists. strip the
+        # brackets and remember to add them back later.
+        if target.startswith("[") and target.endswith("]"):
+            refnode["qapi:array"] = True
+            target = target[1:-1]
+
+        if has_explicit_title:
+            # Don't mess with the title at all if it was explicitly set.
+            # Explicit title syntax for references is e.g.
+            # :qapi:type:`target <explicit title>`
+            # and this explicit title overrides everything else here.
+            return title, target
+
+        title = target
+        if hide_module:
+            title = target.split(".")[-1]
+
+        return title, target
+
+
 class QAPIIndex(Index):
     """
     Index subclass to provide the QAPI definition index.
@@ -118,7 +167,13 @@ class QAPIDomain(Domain):
     object_types: Dict[str, ObjType] = {}
 
     directives = {}
-    roles = {}
+
+    # These are all cross-reference roles; e.g.
+    # :qapi:cmd:`query-block`. The keys correlate to the names used in
+    # the object_types table values above.
+    roles = {
+        "any": QAPIXRefRole(),  # reference *any* type of QAPI object.
+    }
 
     # Moved into the data property at runtime;
     # this is the internal index of reference-able objects.
@@ -252,6 +307,37 @@ def find_obj(
             matches = [m for m in matches if not m[1].aliased]
         return matches
 
+    def resolve_xref(
+        self,
+        env: BuildEnvironment,
+        fromdocname: str,
+        builder: Builder,
+        typ: str,
+        target: str,
+        node: pending_xref,
+        contnode: Element,
+    ) -> nodes.reference | None:
+        modname = node.get("qapi:module")
+        matches = self.find_obj(modname, target, typ)
+
+        if not matches:
+            return None
+
+        if len(matches) > 1:
+            logger.warning(
+                __("more than one target found for cross-reference %r: %s"),
+                target,
+                ", ".join(match[0] for match in matches),
+                type="ref",
+                subtype="qapi",
+                location=node,
+            )
+
+        name, obj = matches[0]
+        return make_refnode(
+            builder, fromdocname, obj.docname, obj.node_id, contnode, name
+        )
+
     def resolve_any_xref(
         self,
         env: BuildEnvironment,
-- 
2.48.1


