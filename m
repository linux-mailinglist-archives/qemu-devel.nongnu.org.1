Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F269F01EE
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Dec 2024 02:18:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuFv-0005ak-GE; Thu, 12 Dec 2024 20:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFt-0005aQ-AR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFr-0000Sq-CX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LiK5xtEugF+udTlcuqdL8tZt1K7Z4AIDbXrBiQVqcs0=;
 b=MfWdjAMShA22HNEot8B2lWSJ7lyikvSjRpG7Ym0urs/lntfbbvom3JJUVoCDj9XFKuVZ0/
 /YRumtzGhGWuxM6+UzxDm3nScPdHowpBQzu+yIl6cBp+CoP9BP1NCmKsqWxM000pk+O0QN
 ZxruU3zkmHjcI6yXctqk3dsMTn8aDq8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-AP7i7sCLO0u3O4R_nraV2g-1; Thu,
 12 Dec 2024 20:14:03 -0500
X-MC-Unique: AP7i7sCLO0u3O4R_nraV2g-1
X-Mimecast-MFC-AGG-ID: AP7i7sCLO0u3O4R_nraV2g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B77319560A3; Fri, 13 Dec 2024 01:14:02 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85AAF1956086; Fri, 13 Dec 2024 01:13:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 11/35] docs/qapi-domain: add qapi:command directive
Date: Thu, 12 Dec 2024 20:12:40 -0500
Message-ID: <20241213011307.2942030-12-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This commit adds a generic QAPIObject class for use in documenting
various QAPI entities in the Sphinx ecosystem.

It also adds a stubbed version of QAPICommand that utilizes the
QAPIObject class; along with the qapi:command directive, the
:qapi:cmd: cross-reference role, and the "command" object type in the
QAPI object registry.

They don't do anything *particularly* interesting yet, but that will
come in forthcoming commits.

Note: some versions of mypy get a little confused over the difference
between class and instance variables; because sphinx's ObjectDescription
does not declare option_spec as a ClassVar (even though it's obvious
that it is), mypy may produce this error:

qapi-domain.py:125: error: Cannot override instance variable (previously
declared on base class "ObjectDescription") with class variable [misc]

I can't control that; so silence the error with a pragma.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 144 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index e4f822bbcbd..dd4e218a1a0 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -20,9 +20,10 @@
 from docutils import nodes
 from docutils.parsers.rst import directives
 
-from compat import nested_parse
+from compat import keyword_node, nested_parse, space_node
 from sphinx import addnodes
-from sphinx.addnodes import pending_xref
+from sphinx.addnodes import desc_signature, pending_xref
+from sphinx.directives import ObjectDescription
 from sphinx.domains import (
     Domain,
     Index,
@@ -82,6 +83,142 @@ def process_link(
         return title, target
 
 
+# Alias for the return of handle_signature(), which is used in several places.
+# (In the Python domain, this is Tuple[str, str] instead.)
+Signature = str
+
+
+class QAPIObject(ObjectDescription[Signature]):
+    """
+    Description of a generic QAPI object.
+
+    It's not used directly, but is instead subclassed by specific directives.
+    """
+
+    # Inherit some standard options from Sphinx's ObjectDescription
+    option_spec: OptionSpec = (  # type:ignore[misc]
+        ObjectDescription.option_spec.copy()
+    )
+    option_spec.update(
+        {
+            # Borrowed from the Python domain:
+            "module": directives.unchanged,  # Override contextual module name
+        }
+    )
+
+    def get_signature_prefix(self, sig: str) -> List[nodes.Node]:
+        """Returns a prefix to put before the object name in the signature."""
+        assert self.objtype
+        return [
+            keyword_node("", self.objtype.title()),
+            space_node(" "),
+        ]
+
+    def get_signature_suffix(self, sig: str) -> list[nodes.Node]:
+        """Returns a suffix to put after the object name in the signature."""
+        return []
+
+    def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
+        """
+        Transform a QAPI definition name into RST nodes.
+
+        This method was originally intended for handling function
+        signatures. In the QAPI domain, however, we only pass the
+        definition name as the directive argument and handle everything
+        else in the content body with field lists.
+
+        As such, the only argument here is "sig", which is just the QAPI
+        definition name.
+        """
+        modname = self.options.get(
+            "module", self.env.ref_context.get("qapi:module")
+        )
+
+        signode["fullname"] = sig
+        signode["module"] = modname
+        sig_prefix = self.get_signature_prefix(sig)
+        if sig_prefix:
+            signode += addnodes.desc_annotation(
+                str(sig_prefix), "", *sig_prefix
+            )
+        signode += addnodes.desc_name(sig, sig)
+        signode += self.get_signature_suffix(sig)
+
+        return sig
+
+    def _object_hierarchy_parts(
+        self, sig_node: desc_signature
+    ) -> Tuple[str, ...]:
+        if "fullname" not in sig_node:
+            return ()
+        modname = sig_node.get("module")
+        fullname = sig_node["fullname"]
+
+        if modname:
+            return (modname, *fullname.split("."))
+        else:
+            return tuple(fullname.split("."))
+
+    def get_index_text(self, modname: str, name: Signature) -> str:
+        """Return the text for the index entry of the object."""
+        # NB this is used for the global index, not the QAPI index.
+        return f"{name} (QMP {self.objtype})"
+
+    def add_target_and_index(
+        self, name: Signature, sig: str, signode: desc_signature
+    ) -> None:
+        # Called by ObjectDescription.run with the result of
+        # handle_signature; name is the return value of handle_signature
+        # where sig is the original argument to handle_signature. In our
+        # case, they're the same for now.
+        assert self.objtype
+
+        modname = self.options.get(
+            "module", self.env.ref_context.get("qapi:module")
+        )
+        # Here, sphinx decides to prepend the module name. OK.
+        fullname = (modname + "." if modname else "") + name
+        node_id = make_id(self.env, self.state.document, "", fullname)
+        signode["ids"].append(node_id)
+        self.state.document.note_explicit_target(signode)
+
+        domain = cast(QAPIDomain, self.env.get_domain("qapi"))
+        domain.note_object(fullname, self.objtype, node_id, location=signode)
+
+        if "no-index-entry" not in self.options:
+            indextext = self.get_index_text(modname, name)
+            assert self.indexnode is not None
+            if indextext:
+                self.indexnode["entries"].append(
+                    ("single", indextext, node_id, "", None)
+                )
+
+    def _toc_entry_name(self, sig_node: desc_signature) -> str:
+        # This controls the name in the TOC and on the sidebar.
+
+        # This is the return type of _object_hierarchy_parts().
+        toc_parts = cast(Tuple[str, ...], sig_node.get("_toc_parts", ()))
+        if not toc_parts:
+            return ""
+
+        config = self.env.app.config
+        *parents, name = toc_parts
+        if config.toc_object_entries_show_parents == "domain":
+            return sig_node.get("fullname", name)
+        if config.toc_object_entries_show_parents == "hide":
+            return name
+        if config.toc_object_entries_show_parents == "all":
+            return ".".join(parents + [name])
+        return ""
+
+
+class QAPICommand(QAPIObject):
+    """Description of a QAPI Command."""
+
+    # Nothing unique for now! Changed in later commits O:-)
+    pass
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -237,12 +374,14 @@ class QAPIDomain(Domain):
     # for each object type.
     object_types: Dict[str, ObjType] = {
         "module": ObjType(_("module"), "mod", "obj"),
+        "command": ObjType(_("command"), "cmd", "obj"),
     }
 
     # Each of these provides a rST directive,
     # e.g. .. qapi:module:: block-core
     directives = {
         "module": QAPIModule,
+        "command": QAPICommand,
     }
 
     # These are all cross-reference roles; e.g.
@@ -250,6 +389,7 @@ class QAPIDomain(Domain):
     # the object_types table values above.
     roles = {
         "mod": QAPIXRefRole(),
+        "cmd": QAPIXRefRole(),
         "obj": QAPIXRefRole(),  # reference *any* type of QAPI object.
     }
 
-- 
2.47.0


