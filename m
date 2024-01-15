Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 346EA82D9E3
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 14:18:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPMq3-0007AS-PT; Mon, 15 Jan 2024 08:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPMpo-00079b-U0
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:17:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPMpj-0002us-Jw
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705324614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FfoQO/d9jHAqGxjURpftTBxpDDvacibgSjxdsMSwlo0=;
 b=hxzHMaCLo8gbpFXdkOYuXej9OXjt/gcQjFT+kM432ZZJkeNOYdVJQ1fu0/qpGJe+z/9pOs
 N7S4SzizMKfIp/+DgELsdovmICRnjyhHHjk6cOr8d4cJXfYZU4jmUnKM4c9k6yPSkQF176
 7FrCKnx8Dlbi6GXza8IdcTNyvHFiQZg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-rpunFmllMV2jVHcE4LDjuQ-1; Mon,
 15 Jan 2024 08:16:41 -0500
X-MC-Unique: rpunFmllMV2jVHcE4LDjuQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B01C63C0ED43;
 Mon, 15 Jan 2024 13:16:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54EA3492BFA;
 Mon, 15 Jan 2024 13:16:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4FD5A21E680D; Mon, 15 Jan 2024 14:16:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 03/19] qapi: create QAPISchemaDefinition
In-Reply-To: <20240112222945.3033854-4-jsnow@redhat.com> (John Snow's message
 of "Fri, 12 Jan 2024 17:29:29 -0500")
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-4-jsnow@redhat.com>
Date: Mon, 15 Jan 2024 14:16:36 +0100
Message-ID: <87edeid9e3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Include entities don't have names, but we generally expect "entities" to
> have names. Reclassify all entities with names as *definitions*, leaving
> the nameless include entities as QAPISchemaEntity instances.
>
> This is primarily to help simplify typing around expectations of what
> callers expect for properties of an "entity".
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 117 ++++++++++++++++++++++++-----------------
>  1 file changed, 70 insertions(+), 47 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index b7830672e57..e39ed972a80 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -55,14 +55,14 @@ def is_present(self):
>  
>  
>  class QAPISchemaEntity:
> -    meta: Optional[str] = None
> +    """
> +    QAPISchemaEntity represents all schema entities.
>  
> -    def __init__(self, name: str, info, doc, ifcond=None, features=None):
> -        assert name is None or isinstance(name, str)
> -        for f in features or []:
> -            assert isinstance(f, QAPISchemaFeature)
> -            f.set_defined_in(name)
> -        self.name = name
> +    Notably, this includes both named and un-named entities, such as
> +    include directives. Entities with names are represented by the
> +    more specific sub-class `QAPISchemaDefinition` instead.
> +    """

Hmm.  What about:

       """
       A schema entity.

       This is either a directive, such as include, or a definition.
       The latter use sub-class `QAPISchemaDefinition`.
       """

> +    def __init__(self, info):
>          self._module = None
>          # For explicitly defined entities, info points to the (explicit)
>          # definition.  For builtins (and their arrays), info is None.
> @@ -70,14 +70,50 @@ def __init__(self, name: str, info, doc, ifcond=None, features=None):
>          # triggered the implicit definition (there may be more than one
>          # such place).
>          self.info = info
> +        self._checked = False
> +
> +    def __repr__(self):
> +        return "<%s at 0x%x>" % (type(self).__name__, id(self))
> +
> +    def check(self, schema):
> +        # pylint: disable=unused-argument
> +        self._checked = True
> +
> +    def connect_doc(self, doc=None):
> +        pass
> +
> +    def check_doc(self):
> +        pass
> +
> +    def _set_module(self, schema, info):
> +        assert self._checked
> +        fname = info.fname if info else QAPISchemaModule.BUILTIN_MODULE_NAME
> +        self._module = schema.module_by_fname(fname)
> +        self._module.add_entity(self)
> +
> +    def set_module(self, schema):
> +        self._set_module(schema, self.info)
> +
> +    def visit(self, visitor):
> +        # pylint: disable=unused-argument
> +        assert self._checked
> +
> +
> +class QAPISchemaDefinition(QAPISchemaEntity):
> +    meta: Optional[str] = None
> +
> +    def __init__(self, name: str, info, doc, ifcond=None, features=None):
> +        assert isinstance(name, str)
> +        super().__init__(info)
> +        for f in features or []:
> +            assert isinstance(f, QAPISchemaFeature)
> +            f.set_defined_in(name)
> +        self.name = name
>          self.doc = doc
>          self._ifcond = ifcond or QAPISchemaIfCond()
>          self.features = features or []
> -        self._checked = False
>  
>      def __repr__(self):
> -        if self.name is None:
> -            return "<%s at 0x%x>" % (type(self).__name__, id(self))
>          return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
>                                      id(self))
>  
> @@ -102,15 +138,6 @@ def check_doc(self):
       def check(self, schema):
           # pylint: disable=unused-argument
           assert not self._checked
           seen = {}
           for f in self.features:
               f.check_clash(self.info, seen)
           self._checked = True

       def connect_doc(self, doc=None):
           doc = doc or self.doc
           if doc:
               for f in self.features:
                   doc.connect_feature(f)

       def check_doc(self):
>          if self.doc:
>              self.doc.check()

No super().FOO()?

>  
> -    def _set_module(self, schema, info):
> -        assert self._checked
> -        fname = info.fname if info else QAPISchemaModule.BUILTIN_MODULE_NAME
> -        self._module = schema.module_by_fname(fname)
> -        self._module.add_entity(self)
> -
> -    def set_module(self, schema):
> -        self._set_module(schema, self.info)
> -
>      @property
>      def ifcond(self):
>          assert self._checked
> @@ -119,10 +146,6 @@ def ifcond(self):
>      def is_implicit(self):
>          return not self.info
>  
> -    def visit(self, visitor):
> -        # pylint: disable=unused-argument
> -        assert self._checked
> -
>      def describe(self):
>          assert self.meta
>          return "%s '%s'" % (self.meta, self.name)
> @@ -222,7 +245,7 @@ def visit(self, visitor):
>  
>  class QAPISchemaInclude(QAPISchemaEntity):
>      def __init__(self, sub_module, info):
> -        super().__init__(None, info, None)
> +        super().__init__(info)
>          self._sub_module = sub_module
>  
>      def visit(self, visitor):
> @@ -230,7 +253,7 @@ def visit(self, visitor):
>          visitor.visit_include(self._sub_module.name, self.info)
>  
>  
> -class QAPISchemaType(QAPISchemaEntity):
> +class QAPISchemaType(QAPISchemaDefinition):
>      # Return the C type for common use.
>      # For the types we commonly box, this is a pointer type.
>      def c_type(self):
> @@ -801,7 +824,7 @@ def __init__(self, name, info, typ, ifcond=None):
>          super().__init__(name, info, typ, False, ifcond)
>  
>  
> -class QAPISchemaCommand(QAPISchemaEntity):
> +class QAPISchemaCommand(QAPISchemaDefinition):
>      meta = 'command'
>  
>      def __init__(self, name, info, doc, ifcond, features,
> @@ -872,7 +895,7 @@ def visit(self, visitor):
>              self.coroutine)
>  
>  
> -class QAPISchemaEvent(QAPISchemaEntity):
> +class QAPISchemaEvent(QAPISchemaDefinition):
>      meta = 'event'
>  
>      def __init__(self, name, info, doc, ifcond, features, arg_type, boxed):
> @@ -943,11 +966,12 @@ def __init__(self, fname):
>          self.check()
>  
>      def _def_entity(self, ent):
> +        self._entity_list.append(ent)
> +
> +    def _def_definition(self, ent):

Name the argument @defn instead of @ent?

>          # Only the predefined types are allowed to not have info
>          assert ent.info or self._predefining
> -        self._entity_list.append(ent)
> -        if ent.name is None:
> -            return
> +        self._def_entity(ent)
>          # TODO reject names that differ only in '_' vs. '.'  vs. '-',
>          # because they're liable to clash in generated C.
>          other_ent = self._entity_dict.get(ent.name)
> @@ -1001,7 +1025,7 @@ def _def_include(self, expr: QAPIExpression):
>              QAPISchemaInclude(self._make_module(include), expr.info))
>  
>      def _def_builtin_type(self, name, json_type, c_type):
> -        self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
> +        self._def_definition(QAPISchemaBuiltinType(name, json_type, c_type))
>          # Instantiating only the arrays that are actually used would
>          # be nice, but we can't as long as their generated code
>          # (qapi-builtin-types.[ch]) may be shared by some other
> @@ -1027,15 +1051,15 @@ def _def_predefineds(self):
>              self._def_builtin_type(*t)
>          self.the_empty_object_type = QAPISchemaObjectType(
>              'q_empty', None, None, None, None, None, [], None)
> -        self._def_entity(self.the_empty_object_type)
> +        self._def_definition(self.the_empty_object_type)
>  
>          qtypes = ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist',
>                    'qbool']
>          qtype_values = self._make_enum_members(
>              [{'name': n} for n in qtypes], None)
>  
> -        self._def_entity(QAPISchemaEnumType('QType', None, None, None, None,
> -                                            qtype_values, 'QTYPE'))
> +        self._def_definition(QAPISchemaEnumType('QType', None, None, None,
> +                                                None, qtype_values, 'QTYPE'))

The long identifiers squeeze the (also long) argument list against the
right margin.  What about:

           self._def_definition(QAPISchemaEnumType(
               'QType', None, None, None, None, qtype_values, 'QTYPE'))

or

           self._def_definition(
               QAPISchemaEnumType('QType', None, None, None, None,
                                  qtype_values, 'QTYPE'))

We already use the former style elsewhere, visible below.

You add one in the latter style in the second to last hunk.

Pick one style and stick ot it?

>  
>      def _make_features(self, features, info):
>          if features is None:
> @@ -1057,7 +1081,7 @@ def _make_enum_members(self, values, info):
>      def _make_array_type(self, element_type, info):
>          name = element_type + 'List'    # reserved by check_defn_name_str()
>          if not self.lookup_type(name):
> -            self._def_entity(QAPISchemaArrayType(name, info, element_type))
> +            self._def_definition(QAPISchemaArrayType(name, info, element_type))

               self._def_definition(QAPISchemaArrayType(
                   name, info, element_type))

or

               self._def_definition(
                   QAPISchemaArrayType(name, info, element_type))

>          return name
>  
>      def _make_implicit_object_type(self, name, info, ifcond, role, members):
> @@ -1072,7 +1096,7 @@ def _make_implicit_object_type(self, name, info, ifcond, role, members):
>              # later.
>              pass
>          else:
> -            self._def_entity(QAPISchemaObjectType(
> +            self._def_definition(QAPISchemaObjectType(
>                  name, info, None, ifcond, None, None, members, None))
>          return name
>  
> @@ -1083,7 +1107,7 @@ def _def_enum_type(self, expr: QAPIExpression):
>          ifcond = QAPISchemaIfCond(expr.get('if'))
>          info = expr.info
>          features = self._make_features(expr.get('features'), info)
> -        self._def_entity(QAPISchemaEnumType(
> +        self._def_definition(QAPISchemaEnumType(
>              name, info, expr.doc, ifcond, features,
>              self._make_enum_members(data, info), prefix))
>  
> @@ -1111,7 +1135,7 @@ def _def_struct_type(self, expr: QAPIExpression):
>          info = expr.info
>          ifcond = QAPISchemaIfCond(expr.get('if'))
>          features = self._make_features(expr.get('features'), info)
> -        self._def_entity(QAPISchemaObjectType(
> +        self._def_definition(QAPISchemaObjectType(
>              name, info, expr.doc, ifcond, features, base,
>              self._make_members(data, info),
>              None))
> @@ -1141,7 +1165,7 @@ def _def_union_type(self, expr: QAPIExpression):
>                                 info)
>              for (key, value) in data.items()]
>          members: List[QAPISchemaObjectTypeMember] = []
> -        self._def_entity(
> +        self._def_definition(
>              QAPISchemaObjectType(name, info, expr.doc, ifcond, features,
>                                   base, members,
>                                   QAPISchemaVariants(
> @@ -1160,7 +1184,7 @@ def _def_alternate_type(self, expr: QAPIExpression):
>                                 info)
>              for (key, value) in data.items()]
>          tag_member = QAPISchemaObjectTypeMember('type', info, 'QType', False)
> -        self._def_entity(
> +        self._def_definition(
>              QAPISchemaAlternateType(
>                  name, info, expr.doc, ifcond, features,
>                  QAPISchemaVariants(None, info, tag_member, variants)))
> @@ -1185,11 +1209,10 @@ def _def_command(self, expr: QAPIExpression):
>          if isinstance(rets, list):
>              assert len(rets) == 1
>              rets = self._make_array_type(rets[0], info)
> -        self._def_entity(QAPISchemaCommand(name, info, expr.doc, ifcond,
> -                                           features, data, rets,
> -                                           gen, success_response,
> -                                           boxed, allow_oob, allow_preconfig,
> -                                           coroutine))
> +        self._def_definition(
> +            QAPISchemaCommand(name, info, expr.doc, ifcond, features, data,
> +                              rets, gen, success_response, boxed, allow_oob,
> +                              allow_preconfig, coroutine))
>  
>      def _def_event(self, expr: QAPIExpression):
>          name = expr['event']
> @@ -1202,8 +1225,8 @@ def _def_event(self, expr: QAPIExpression):
>              data = self._make_implicit_object_type(
>                  name, info, ifcond,
>                  'arg', self._make_members(data, info))
> -        self._def_entity(QAPISchemaEvent(name, info, expr.doc, ifcond,
> -                                         features, data, boxed))
> +        self._def_definition(QAPISchemaEvent(name, info, expr.doc, ifcond,
> +                                             features, data, boxed))
>  
>      def _def_exprs(self, exprs):
>          for expr in exprs:

Slightly more code, but with slightly fewer conditionals.  Feels a bit
cleaner.


