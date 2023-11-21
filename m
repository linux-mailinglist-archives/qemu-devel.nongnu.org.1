Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A987F2E6E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 14:36:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5QtX-0003Iz-A4; Tue, 21 Nov 2023 08:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5QtS-0003Ge-To
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 08:34:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5QtD-0006Kd-K5
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 08:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700573646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WcI4q2Ka0lr8sACL3gYnqpkm7So5BoHu7mRHlSf5WkA=;
 b=d1WXAeyqgMxBmnxtrmY9JCF+Qy2vQshWYQcTZyqSmaQTARkOUx62HcZiiLoQm+iff/Y+jR
 5JbX6Vl4Kbq90e82nD71GSlIwNsSLsquN5FjLQqhUJ8wWsiK9seH1JpuyeMbYEYsRllkp+
 4Ud1sRu+DjfTE1hlGlZRb+0F19PAVUI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-gXSlXoxGO0GMehmm7W0oBQ-1; Tue,
 21 Nov 2023 08:34:00 -0500
X-MC-Unique: gXSlXoxGO0GMehmm7W0oBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F95328EA6EE;
 Tue, 21 Nov 2023 13:33:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8DA720268D5;
 Tue, 21 Nov 2023 13:33:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABF0521E6A1F; Tue, 21 Nov 2023 14:33:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 03/19] qapi/schema: name QAPISchemaInclude entities
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-4-jsnow@redhat.com>
Date: Tue, 21 Nov 2023 14:33:37 +0100
In-Reply-To: <20231116014350.653792-4-jsnow@redhat.com> (John Snow's message
 of "Wed, 15 Nov 2023 20:43:34 -0500")
Message-ID: <87o7fn44em.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

John Snow <jsnow@redhat.com> writes:

> It simplifies typing to mandate that entities will always have a name;
> to achieve this we can occasionally assign an internal name. This
> alleviates errors such as:
>
> qapi/schema.py:287: error: Argument 1 to "__init__" of
> "QAPISchemaEntity" has incompatible type "None"; expected "str"
> [arg-type]
>
> Trying to fix it the other way by allowing entities to only have
> optional names opens up a nightmare portal of whackamole to try and
> audit that every other pathway doesn't actually pass a None name when we
> expect it to; this is the simpler direction of consitifying the typing.

Arguably, that nightmare is compile-time proof of "we are not mistaking
QAPISchemaInclude for a named entity".

When I added the include directive, I shoehorned it into the existing
representation of the QAPI schema as "list of QAPISchemaEntity" by
making it a subtype of QAPISchemaEntity.  That was a somewhat lazy hack.

Note that qapi-code-gen.rst distinguishes between definitions and
directives.

The places where mypy gripes that .name isn't 'str' generally want
something with a name (what qapi-code-gen.rst calls a definition).  If
we somehow pass them an include directive, they'll use None for a name,
which is no good.  mypy is pointing out this problem.

What to do about it?

1. Paper it over: give include directives some made-up name (this
patch).  Now the places use the made-up name instead of None, and mypy
can't see the problem anymore.

2. Assert .name is not None until mypy is happy.  I guess that's what
you called opening "a nightmare portal of whackamole".

3. Clean up the typing: have a type for top-level expression (has no
name), and a subtype for definition (has a name).  Rough sketch
appended.  Thoughts?

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 153e703e0ef..0fb44452dd5 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -220,7 +220,9 @@ def visit(self, visitor):
>  
>  class QAPISchemaInclude(QAPISchemaEntity):
>      def __init__(self, sub_module, info):
> -        super().__init__(None, info, None)
> +        # Includes are internal entity objects; and may occur multiple times
> +        name = f"q_include_{info.fname}:{info.line}"
> +        super().__init__(name, info, None)
>          self._sub_module = sub_module
>  
>      def visit(self, visitor):

There are two instances of .name is None:

    def __repr__(self) -> str:
        if self.name is None:
            return "<%s at 0x%x>" % (type(self).__name__, id(self))
        return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
                                    id(self))

and

    def _def_entity(self, ent: QAPISchemaEntity) -> None:
        # Only the predefined types are allowed to not have info
        assert ent.info or self._predefining
        self._entity_list.append(ent)
        if ent.name is None:
            return
        [...]

Don't they need to be updated?



diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 24ad166d52..eaff1df534 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -70,6 +70,45 @@ def is_present(self) -> bool:
 
 
 class QAPISchemaEntity:
+    def __init__(self, info: Optional[QAPISourceInfo]):
+        # For explicitly defined entities, info points to the (explicit)
+        # definition.  For builtins (and their arrays), info is None.
+        # For implicitly defined entities, info points to a place that
+        # triggered the implicit definition (there may be more than one
+        # such place).
+        self.info = info
+        self._module: Optional[QAPISchemaModule] = None
+        self._checked = False
+
+    def __repr__(self) -> str:
+        return "<%s at 0x%x>" % (type(self).__name__, id(self))
+
+    def check(self, schema: QAPISchema) -> None:
+        self._checked = True
+
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
+        pass
+
+    def check_doc(self) -> None:
+        pass
+
+    def _set_module(
+        self, schema: QAPISchema, info: Optional[QAPISourceInfo]
+    ) -> None:
+        assert self._checked
+        fname = info.fname if info else QAPISchemaModule.BUILTIN_MODULE_NAME
+        self._module = schema.module_by_fname(fname)
+        self._module.add_entity(self)
+
+    def set_module(self, schema: QAPISchema) -> None:
+        self._set_module(schema, self.info)
+
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
+        # pylint: disable=unused-argument
+        assert self._checked
+
+
+class QAPISchemaDefinition(QAPISchemaEntity):
     meta: str
 
     def __init__(
@@ -80,24 +119,16 @@ def __init__(
         ifcond: Optional[QAPISchemaIfCond] = None,
         features: Optional[List[QAPISchemaFeature]] = None,
     ):
+        super().__init__(info)
         for f in features or []:
             f.set_defined_in(name)
         self.name = name
-        self._module: Optional[QAPISchemaModule] = None
-        # For explicitly defined entities, info points to the (explicit)
-        # definition.  For builtins (and their arrays), info is None.
-        # For implicitly defined entities, info points to a place that
-        # triggered the implicit definition (there may be more than one
-        # such place).
-        self.info = info
         self.doc = doc
         self._ifcond = ifcond or QAPISchemaIfCond()
         self.features = features or []
         self._checked = False
-
+        
     def __repr__(self) -> str:
-        if self.name is None:
-            return "<%s at 0x%x>" % (type(self).__name__, id(self))
         return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
                                     id(self))
 
@@ -122,17 +153,6 @@ def check_doc(self) -> None:
         if self.doc:
             self.doc.check()
 
-    def _set_module(
-        self, schema: QAPISchema, info: Optional[QAPISourceInfo]
-    ) -> None:
-        assert self._checked
-        fname = info.fname if info else QAPISchemaModule.BUILTIN_MODULE_NAME
-        self._module = schema.module_by_fname(fname)
-        self._module.add_entity(self)
-
-    def set_module(self, schema: QAPISchema) -> None:
-        self._set_module(schema, self.info)
-
     @property
     def ifcond(self) -> QAPISchemaIfCond:
         assert self._checked
@@ -141,10 +161,6 @@ def ifcond(self) -> QAPISchemaIfCond:
     def is_implicit(self) -> bool:
         return not self.info
 
-    def visit(self, visitor: QAPISchemaVisitor) -> None:
-        # pylint: disable=unused-argument
-        assert self._checked
-
     def describe(self) -> str:
         return "%s '%s'" % (self.meta, self.name)
 
@@ -301,9 +317,7 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
 
 class QAPISchemaInclude(QAPISchemaEntity):
     def __init__(self, sub_module: QAPISchemaModule, info: QAPISourceInfo):
-        # Includes are internal entity objects; and may occur multiple times
-        name = f"q_include_{info.fname}:{info.line}"
-        super().__init__(name, info, None)
+        super().__init__(info)
         self._sub_module = sub_module
 
     def visit(self, visitor: QAPISchemaVisitor) -> None:
@@ -311,7 +325,7 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
         visitor.visit_include(self._sub_module.name, self.info)
 
 
-class QAPISchemaType(QAPISchemaEntity):
+class QAPISchemaType(QAPISchemaDefinition):
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
     def c_type(self) -> str:
@@ -977,7 +991,7 @@ def __init__(
         super().__init__(name, info, typ, False, ifcond)
 
 
-class QAPISchemaCommand(QAPISchemaEntity):
+class QAPISchemaCommand(QAPISchemaDefinition):
     meta = 'command'
 
     def __init__(
@@ -1059,7 +1073,7 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
             self.coroutine)
 
 
-class QAPISchemaEvent(QAPISchemaEntity):
+class QAPISchemaEvent(QAPISchemaDefinition):
     meta = 'event'
 
     def __init__(
@@ -1133,7 +1147,7 @@ def __init__(self, fname: str):
         exprs = check_exprs(parser.exprs)
         self.docs = parser.docs
         self._entity_list: List[QAPISchemaEntity] = []
-        self._entity_dict: Dict[str, QAPISchemaEntity] = {}
+        self._entity_dict: Dict[str, QAPISchemaDefinition] = {}
         self._module_dict: Dict[str, QAPISchemaModule] = OrderedDict()
         self._schema_dir = os.path.dirname(fname)
         self._make_module(QAPISchemaModule.BUILTIN_MODULE_NAME)
@@ -1145,9 +1159,12 @@ def __init__(self, fname: str):
         self.check()
 
     def _def_entity(self, ent: QAPISchemaEntity) -> None:
+        self._entity_list.append(ent)
+
+    def _def_definition(self, ent: QAPISchemaDefinition) -> None:
         # Only the predefined types are allowed to not have info
         assert ent.info or self._predefining
-        self._entity_list.append(ent)
+        self._def_entity(ent)
         if ent.name is None:
             return
         # TODO reject names that differ only in '_' vs. '.'  vs. '-',
@@ -1163,7 +1180,7 @@ def _def_entity(self, ent: QAPISchemaEntity) -> None:
                 ent.info, "%s is already defined" % other_ent.describe())
         self._entity_dict[ent.name] = ent
 
-    def get_entity(self, name: str) -> Optional[QAPISchemaEntity]:
+    def get_definition(self, name: str) -> Optional[QAPISchemaDefinition]:
         return self._entity_dict.get(name)
 
     def get_typed_entity(
@@ -1171,7 +1188,7 @@ def get_typed_entity(
         name: str,
         typ: Type[_EntityType]
     ) -> Optional[_EntityType]:
-        ent = self.get_entity(name)
+        ent = self.get_definition(name)
         if ent is not None and not isinstance(ent, typ):
             etype = type(ent).__name__
             ttype = typ.__name__
@@ -1225,7 +1242,7 @@ def _def_include(self, expr: QAPIExpression) -> None:
     def _def_builtin_type(
         self, name: str, json_type: str, c_type: str
     ) -> None:
-        self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
+        self._def_definition(QAPISchemaBuiltinType(name, json_type, c_type))
         # Instantiating only the arrays that are actually used would
         # be nice, but we can't as long as their generated code
         # (qapi-builtin-types.[ch]) may be shared by some other
@@ -1251,14 +1268,14 @@ def _def_predefineds(self) -> None:
             self._def_builtin_type(*t)
         self.the_empty_object_type = QAPISchemaObjectType(
             'q_empty', None, None, None, None, None, [], None)
-        self._def_entity(self.the_empty_object_type)
+        self._def_definition(self.the_empty_object_type)
 
         qtypes = ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist',
                   'qbool']
         qtype_values = self._make_enum_members(
             [{'name': n} for n in qtypes], None)
 
-        self._def_entity(QAPISchemaEnumType('QType', None, None, None, None,
+        self._def_definition(QAPISchemaEnumType('QType', None, None, None, None,
                                             qtype_values, 'QTYPE'))
 
     def _make_features(
@@ -1294,8 +1311,8 @@ def _make_array_type(
         self, element_type: str, info: Optional[QAPISourceInfo]
     ) -> str:
         name = element_type + 'List'    # reserved by check_defn_name_str()
-        if not self.get_entity(name):
-            self._def_entity(QAPISchemaArrayType(name, info, element_type))
+        if not self.get_definition(name):
+            self._def_definition(QAPISchemaArrayType(name, info, element_type))
         return name
 
     def _make_implicit_object_type(
@@ -1317,7 +1334,7 @@ def _make_implicit_object_type(
             # later.
             pass
         else:
-            self._def_entity(QAPISchemaObjectType(
+            self._def_definition(QAPISchemaObjectType(
                 name, info, None, ifcond, None, None, members, None))
         return name
 
@@ -1328,7 +1345,7 @@ def _def_enum_type(self, expr: QAPIExpression) -> None:
         ifcond = QAPISchemaIfCond(expr.get('if'))
         info = expr.info
         features = self._make_features(expr.get('features'), info)
-        self._def_entity(QAPISchemaEnumType(
+        self._def_definition(QAPISchemaEnumType(
             name, info, expr.doc, ifcond, features,
             self._make_enum_members(data, info), prefix))
 
@@ -1367,7 +1384,7 @@ def _def_struct_type(self, expr: QAPIExpression) -> None:
         info = expr.info
         ifcond = QAPISchemaIfCond(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
-        self._def_entity(QAPISchemaObjectType(
+        self._def_definition(QAPISchemaObjectType(
             name, info, expr.doc, ifcond, features, base,
             self._make_members(data, info),
             None))
@@ -1403,7 +1420,7 @@ def _def_union_type(self, expr: QAPIExpression) -> None:
                                info)
             for (key, value) in data.items()]
         members: List[QAPISchemaObjectTypeMember] = []
-        self._def_entity(
+        self._def_definition(
             QAPISchemaObjectType(name, info, expr.doc, ifcond, features,
                                  base, members,
                                  QAPISchemaVariants(
@@ -1422,7 +1439,7 @@ def _def_alternate_type(self, expr: QAPIExpression) -> None:
                                info)
             for (key, value) in data.items()]
         tag_member = QAPISchemaObjectTypeMember('type', info, 'QType', False)
-        self._def_entity(
+        self._def_definition(
             QAPISchemaAlternateType(
                 name, info, expr.doc, ifcond, features,
                 QAPISchemaVariants(None, info, tag_member, variants)))
@@ -1447,7 +1464,7 @@ def _def_command(self, expr: QAPIExpression) -> None:
         if isinstance(rets, list):
             assert len(rets) == 1
             rets = self._make_array_type(rets[0], info)
-        self._def_entity(QAPISchemaCommand(name, info, expr.doc, ifcond,
+        self._def_definition(QAPISchemaCommand(name, info, expr.doc, ifcond,
                                            features, data, rets,
                                            gen, success_response,
                                            boxed, allow_oob, allow_preconfig,
@@ -1464,7 +1481,7 @@ def _def_event(self, expr: QAPIExpression) -> None:
             data = self._make_implicit_object_type(
                 name, info, ifcond,
                 'arg', self._make_members(data, info))
-        self._def_entity(QAPISchemaEvent(name, info, expr.doc, ifcond,
+        self._def_definition(QAPISchemaEvent(name, info, expr.doc, ifcond,
                                          features, data, boxed))
 
     def _def_exprs(self, exprs: List[QAPIExpression]) -> None:


