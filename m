Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C8D9F01E4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Dec 2024 02:17:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuGW-0006dN-W4; Thu, 12 Dec 2024 20:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGL-0006KT-FY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGJ-0000gD-BN
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RjR6Dh3llFPbmI/ayJ4ez1ETl3X50WyFlceVILBfRUE=;
 b=EXNfiBGnfVaHwLuhUunSYTD7tY/OiBFKmVwyLmlYILX7mKp1isR6Omlg/lHmsd5BXw77DN
 wrMDnEB1MZ60nkMKnmMCthyVorj8YIwnjDivZ7kqgJwIKbPGL5OT1jsqSl2UAQI49BmILZ
 6opQT3rm6LLNPTN6AFqzqKfs4whXDKU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-Z2fGFwFDNaqE99usK9--Zg-1; Thu,
 12 Dec 2024 20:14:31 -0500
X-MC-Unique: Z2fGFwFDNaqE99usK9--Zg-1
X-Mimecast-MFC-AGG-ID: Z2fGFwFDNaqE99usK9--Zg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9336B195608C; Fri, 13 Dec 2024 01:14:30 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B4741956086; Fri, 13 Dec 2024 01:14:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 20/35] docs/qapi-domain: add qapi:event directive
Date: Thu, 12 Dec 2024 20:12:49 -0500
Message-ID: <20241213011307.2942030-21-jsnow@redhat.com>
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

Adds the .. qapi:event:: directive, object, and :qapi:event:`name`
cross-referencing role.

Adds the :memb type name: field list syntax for documenting event data
members. As this syntax and phrasing will be shared with Structs and
Unions as well, add the field list definition to a shared abstract
class.

As per usual, QAPI cross-referencing for types in the member field list
will be added in a forthcoming commit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index e0c31b2ee4d..e042421016f 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -321,6 +321,29 @@ class QAPIAlternate(QAPIObject):
     )
 
 
+class QAPIObjectWithMembers(QAPIObject):
+    """Base class for Events/Structs/Unions"""
+
+    doc_field_types = QAPIObject.doc_field_types.copy()
+    doc_field_types.extend(
+        [
+            # :member type name: descr
+            TypedField(
+                "member",
+                label=_("Members"),
+                names=("memb",),
+                can_collapse=False,
+            ),
+        ]
+    )
+
+
+class QAPIEvent(QAPIObjectWithMembers):
+    """Description of a QAPI Event."""
+
+    pass
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -481,6 +504,7 @@ class QAPIDomain(Domain):
     object_types: Dict[str, ObjType] = {
         "module": ObjType(_("module"), "mod", "obj"),
         "command": ObjType(_("command"), "cmd", "obj"),
+        "event": ObjType(_("event"), "event", "obj"),
         "enum": ObjType(_("enum"), "enum", "obj", "type"),
         "alternate": ObjType(_("alternate"), "alt", "obj", "type"),
     }
@@ -490,6 +514,7 @@ class QAPIDomain(Domain):
     directives = {
         "module": QAPIModule,
         "command": QAPICommand,
+        "event": QAPIEvent,
         "enum": QAPIEnum,
         "alternate": QAPIAlternate,
     }
@@ -500,6 +525,7 @@ class QAPIDomain(Domain):
     roles = {
         "mod": QAPIXRefRole(),
         "cmd": QAPIXRefRole(),
+        "event": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
         "alt": QAPIXRefRole(),
         # reference any data type (excludes modules, commands, events)
-- 
2.47.0


