Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A81AB1A418
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Aug 2025 16:09:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uivrb-0002cY-OJ; Mon, 04 Aug 2025 10:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uiutM-0005e5-LV
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uiutJ-0002UQ-KR
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754312771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1Io7ICaKXD0t6o23Ob3du1lHWfA5rxyqziAlwCmmSw0=;
 b=ECOxDd0Ik3+Hc4FdtB5Nyg+ZDASd0Pt6nMiSrdGgb2gHu1Cds6gQHz5WULzQhNiUtsJfAh
 Zk2WK0yzLEsQ+Sn0irfITYd+SUQnzY94HCBaTslJRsEmjYS5/5NNNIQpq4be5izTA1HVVI
 CV6/QVubOfHhZ7t/7ipeYzocYibNzKc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-Ydiv7ve9MdS5ftF125UDZg-1; Mon,
 04 Aug 2025 09:06:07 -0400
X-MC-Unique: Ydiv7ve9MdS5ftF125UDZg-1
X-Mimecast-MFC-AGG-ID: Ydiv7ve9MdS5ftF125UDZg_1754312766
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DBDF1800989; Mon,  4 Aug 2025 13:06:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E6F530002C5; Mon,  4 Aug 2025 13:06:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EAB721E6A27; Mon, 04 Aug 2025 15:06:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com
Subject: [PATCH] qapi/command: Avoid generating unused qmp_marshal_output_T()
Date: Mon,  4 Aug 2025 15:06:02 +0200
Message-ID: <20250804130602.903904-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qmp_marshal_output_T() is only ever called by qmp_marshal_C() for a
command C that returns type T.

We've always generated it as a static function on demand, i.e. when we
generate a call.

Since we split up monolithic generated code into modules (commit
252dc3105fc "qapi: Generate separate .h, .c for each module"), we do
this per module.  As noted in the commit message, this can result in
identical (static) qmp_marshal_output_T() in several modules.  Was
deemed not worth avoiding.

A bit later, we added 'if' conditionals to the schema language (merge
commit 5dafaf4fbce).

When a conditional definition uses a type, then its condition must
imply the type's condition.  We made this the user's responsibility.
Hasn't been an issue in practice.

However, the sharing of qmp_marshal_output_T() among commands
complicates matters.  To avoid both undefined function errors and
unused function warnings, qmp_marshal_output_T() must be defined
exactly when it's used.  It is used when any of the qmp_marshal_C()
calling it is defined, i.e. when any C's condition holds.

The generator uses T's condition instead.  To avoid both error and
warning, T's condition must be the conjunction of all C's conditions.

Unfortunately, this can be impossible:

* Conditional command returning a builtin type

  A builtin type cannot be conditional.  This is noted in a FIXME
  comment.

* Commands in multiple modules where the conjunction differs between
  modules

  An instance of this came up recenrly.  we have unconditional
  commands returning HumanReadableText.  If we add a conditional one
  to a module that does not have unconditional ones, compilation fails
  with "defined but not used".  If we make HumanReadableText
  conditional to fix this module, we break the others.

Instead of complicating the code to compute the conjunction, simplify
it: generate the output marshalling code right into qmp_marshal_C().

This duplicates it when multiple commands return the same type.  The
impact on code size is negligible: qemu-system-x86_64's text segment
grows by 1448 bytes.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 25 ++++++++------------
 scripts/qapi/commands.py     | 44 ++++++++----------------------------
 2 files changed, 19 insertions(+), 50 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index dfdbeac5a5..091e4f6f4a 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1804,27 +1804,13 @@ Example::
     $ cat qapi-generated/example-qapi-commands.c
     [Uninteresting stuff omitted...]
 
-    static void qmp_marshal_output_UserDefOne(UserDefOne *ret_in,
-                                    QObject **ret_out, Error **errp)
-    {
-        Visitor *v;
-
-        v = qobject_output_visitor_new_qmp(ret_out);
-        if (visit_type_UserDefOne(v, "unused", &ret_in, errp)) {
-            visit_complete(v, ret_out);
-        }
-        visit_free(v);
-        v = qapi_dealloc_visitor_new();
-        visit_type_UserDefOne(v, "unused", &ret_in, NULL);
-        visit_free(v);
-    }
-
     void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp)
     {
         Error *err = NULL;
         bool ok = false;
         Visitor *v;
         UserDefOne *retval;
+        Visitor *ov;
         q_obj_my_command_arg arg = {0};
 
         v = qobject_input_visitor_new_qmp(QOBJECT(args));
@@ -1852,7 +1838,14 @@ Example::
             goto out;
         }
 
-        qmp_marshal_output_UserDefOne(retval, ret, errp);
+        ov = qobject_output_visitor_new_qmp(ret);
+        if (visit_type_UserDefOne(ov, "unused", &retval, errp)) {
+            visit_complete(ov, ret);
+        }
+        visit_free(ov);
+        ov = qapi_dealloc_visitor_new();
+        visit_type_UserDefOne(ov, "unused", &retval, NULL);
+        visit_free(ov);
 
         if (trace_event_get_state_backends(TRACE_QMP_EXIT_MY_COMMAND)) {
             g_autoptr(GString) ret_json = qobject_to_json(*ret);
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 7914227382..a82b5a2a5e 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -14,15 +14,12 @@
 """
 
 from typing import (
-    Dict,
     List,
     Optional,
-    Set,
 )
 
 from .common import c_name, mcgen
 from .gen import (
-    QAPIGenC,
     QAPISchemaModularCVisitor,
     build_params,
     gen_features,
@@ -112,11 +109,7 @@ def gen_call(name: str,
 ''')
 
     if ret_type:
-        ret += mcgen('''
-
-    qmp_marshal_output_%(c_name)s(retval, ret, errp);
-''',
-                     c_name=ret_type.c_name())
+        ret += gen_marshal_output(ret_type)
 
     if gen_tracing:
         if ret_type:
@@ -142,22 +135,16 @@ def gen_call(name: str,
 def gen_marshal_output(ret_type: QAPISchemaType) -> str:
     return mcgen('''
 
-static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
-                                QObject **ret_out, Error **errp)
-{
-    Visitor *v;
-
-    v = qobject_output_visitor_new_qmp(ret_out);
-    if (visit_type_%(c_name)s(v, "unused", &ret_in, errp)) {
-        visit_complete(v, ret_out);
+    ov = qobject_output_visitor_new_qmp(ret);
+    if (visit_type_%(c_name)s(ov, "unused", &retval, errp)) {
+        visit_complete(ov, ret);
     }
-    visit_free(v);
-    v = qapi_dealloc_visitor_new();
-    visit_type_%(c_name)s(v, "unused", &ret_in, NULL);
-    visit_free(v);
-}
+    visit_free(ov);
+    ov = qapi_dealloc_visitor_new();
+    visit_type_%(c_name)s(ov, "unused", &retval, NULL);
+    visit_free(ov);
 ''',
-                 c_type=ret_type.c_type(), c_name=ret_type.c_name())
+                 c_name=ret_type.c_name())
 
 
 def build_marshal_proto(name: str,
@@ -209,6 +196,7 @@ def gen_marshal(name: str,
     if ret_type:
         ret += mcgen('''
     %(c_type)s retval;
+    Visitor *ov;
 ''',
                      c_type=ret_type.c_type())
 
@@ -308,11 +296,9 @@ def __init__(self, prefix: str, gen_tracing: bool):
             prefix, 'qapi-commands',
             ' * Schema-defined QAPI/QMP commands', None, __doc__,
             gen_tracing=gen_tracing)
-        self._visited_ret_types: Dict[QAPIGenC, Set[QAPISchemaType]] = {}
         self._gen_tracing = gen_tracing
 
     def _begin_user_module(self, name: str) -> None:
-        self._visited_ret_types[self._genc] = set()
         commands = self._module_basename('qapi-commands', name)
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
@@ -386,16 +372,6 @@ def visit_command(self,
                       coroutine: bool) -> None:
         if not gen:
             return
-        # FIXME: If T is a user-defined type, the user is responsible
-        # for making this work, i.e. to make T's condition the
-        # conjunction of the T-returning commands' conditions.  If T
-        # is a built-in type, this isn't possible: the
-        # qmp_marshal_output_T() will be generated unconditionally.
-        if ret_type and ret_type not in self._visited_ret_types[self._genc]:
-            self._visited_ret_types[self._genc].add(ret_type)
-            with ifcontext(ret_type.ifcond,
-                           self._genh, self._genc):
-                self._genc.add(gen_marshal_output(ret_type))
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_command_decl(name, arg_type, boxed,
                                             ret_type, coroutine))
-- 
2.49.0


