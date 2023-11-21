Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA57F3396
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:24:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5TWQ-0003Ev-CF; Tue, 21 Nov 2023 11:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5TWO-0003D2-LC
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5TWG-00007W-9y
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700583755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iKrWq8hYNxNitToJJ2FwQguLHu1JtQpMCh0VMxvX1XA=;
 b=LvctjzDnKvTZXzmIk+K8rYw4pY0jmeWQxrqpxZ2aOvQ3l8aAMz1mzTU5GBayTlSkCLM2o4
 sFC83RVDXcEkOdldpgKKJ3lvUB/szUtefO6RjUYJ9LDMMVvvfAWP43rD9g1mfldeFovM8N
 O6gXKbETTEchZCSK/zrKvZNDNsDws1M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-GrV2hoVfM7aEZ6gKc0Tzig-1; Tue, 21 Nov 2023 11:22:29 -0500
X-MC-Unique: GrV2hoVfM7aEZ6gKc0Tzig-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2839e23f151so5775551a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 08:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700583748; x=1701188548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iKrWq8hYNxNitToJJ2FwQguLHu1JtQpMCh0VMxvX1XA=;
 b=i6Ixr2FNgFTaeyglyGNS1G0wWMsH5iULySsEXgoL/DuRghrFfBMgNHRorzSgLDPtBn
 FmP4nbQVcVnjKU9rcOzbT9rvOojnF20O+kkskU3aRtmu4OEiUxcFzPJlOocepAs2BJsF
 e44w5LpU1v142pBlFNyPlPEB6EnrWUvqGOLy6GqqkaMqQGJTnoruiyT9LFycF3e1cVDP
 o0E1TJMV5i7yCH8Fun4NYTAVllfaG8y2kSUQFVG3OqmM0zIu3TjLignmVPhWEU9WJi6K
 UNR80O46MmsQB6br35yftmNbYlV5/dNom3mokevfVDHaWOJpRlzdxmJg+p+pp7ATGMNK
 Sfmg==
X-Gm-Message-State: AOJu0Yyaj+PA1N+dQIs5pLN5QfPj1UOS0r0uiU3uUAReayFw2EORUfuD
 WIzZyjJG4gcM/c0rheZYpsR69u5W0wuiYG5o7UZgoZyBNdNEU2AhkHRL6gt6QIKbyI365nc8Hg5
 INHr0KvUciyZGqFHZWFGX9XbuTufsvzM=
X-Received: by 2002:a17:90a:d18f:b0:280:cd5f:bf90 with SMTP id
 fu15-20020a17090ad18f00b00280cd5fbf90mr9487643pjb.23.1700583748328; 
 Tue, 21 Nov 2023 08:22:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe/JoL52dDfOazaWUh2ClemhhQBtSYoYdSpzIMWzgr+hUt2Uk9GLgjr/Ji28pA/IA4/YcC1aQ+n6tuvNGmGxI=
X-Received: by 2002:a17:90a:d18f:b0:280:cd5f:bf90 with SMTP id
 fu15-20020a17090ad18f00b00280cd5fbf90mr9487619pjb.23.1700583747877; Tue, 21
 Nov 2023 08:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-4-jsnow@redhat.com>
 <87o7fn44em.fsf@pond.sub.org>
In-Reply-To: <87o7fn44em.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 21 Nov 2023 11:22:16 -0500
Message-ID: <CAFn=p-Zeu0O9Jvo6AvK0a5jC8VW94sSutv8S7v7_N4tkfLEr_A@mail.gmail.com>
Subject: Re: [PATCH 03/19] qapi/schema: name QAPISchemaInclude entities
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000341590060aac0238"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000341590060aac0238
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 21, 2023, 8:33 AM Markus Armbruster <armbru@redhat.com> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > It simplifies typing to mandate that entities will always have a name;
> > to achieve this we can occasionally assign an internal name. This
> > alleviates errors such as:
> >
> > qapi/schema.py:287: error: Argument 1 to "__init__" of
> > "QAPISchemaEntity" has incompatible type "None"; expected "str"
> > [arg-type]
> >
> > Trying to fix it the other way by allowing entities to only have
> > optional names opens up a nightmare portal of whackamole to try and
> > audit that every other pathway doesn't actually pass a None name when we
> > expect it to; this is the simpler direction of consitifying the typing.
>
> Arguably, that nightmare is compile-time proof of "we are not mistaking
> QAPISchemaInclude for a named entity".
>
> When I added the include directive, I shoehorned it into the existing
> representation of the QAPI schema as "list of QAPISchemaEntity" by
> making it a subtype of QAPISchemaEntity.  That was a somewhat lazy hack.
>
> Note that qapi-code-gen.rst distinguishes between definitions and
> directives.
>
> The places where mypy gripes that .name isn't 'str' generally want
> something with a name (what qapi-code-gen.rst calls a definition).  If
> we somehow pass them an include directive, they'll use None for a name,
> which is no good.  mypy is pointing out this problem.
>
> What to do about it?
>
> 1. Paper it over: give include directives some made-up name (this
> patch).  Now the places use the made-up name instead of None, and mypy
> can't see the problem anymore.
>
> 2. Assert .name is not None until mypy is happy.  I guess that's what
> you called opening "a nightmare portal of whackamole".
>

Yep.


> 3. Clean up the typing: have a type for top-level expression (has no
> name), and a subtype for definition (has a name).  Rough sketch
> appended.  Thoughts?
>

Oh, that'll work. I tried to keep to "minimal SLOC" but where you want to
see deeper fixes, I'm happy to deviate. I'll give it a shot.


> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 153e703e0ef..0fb44452dd5 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -220,7 +220,9 @@ def visit(self, visitor):
> >
> >  class QAPISchemaInclude(QAPISchemaEntity):
> >      def __init__(self, sub_module, info):
> > -        super().__init__(None, info, None)
> > +        # Includes are internal entity objects; and may occur multiple
> times
> > +        name = f"q_include_{info.fname}:{info.line}"
> > +        super().__init__(name, info, None)
> >          self._sub_module = sub_module
> >
> >      def visit(self, visitor):
>
> There are two instances of .name is None:
>
>     def __repr__(self) -> str:
>         if self.name is None:
>             return "<%s at 0x%x>" % (type(self).__name__, id(self))
>         return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
>                                     id(self))
>
> and
>
>     def _def_entity(self, ent: QAPISchemaEntity) -> None:
>         # Only the predefined types are allowed to not have info
>         assert ent.info or self._predefining
>         self._entity_list.append(ent)
>         if ent.name is None:
>             return
>         [...]
>
> Don't they need to be updated?
>

Oh, yes. I remove some assertions later in the series but I very likely
missed these if cases.


>
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 24ad166d52..eaff1df534 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -70,6 +70,45 @@ def is_present(self) -> bool:
>
>
>  class QAPISchemaEntity:
> +    def __init__(self, info: Optional[QAPISourceInfo]):
> +        # For explicitly defined entities, info points to the (explicit)
> +        # definition.  For builtins (and their arrays), info is None.
> +        # For implicitly defined entities, info points to a place that
> +        # triggered the implicit definition (there may be more than one
> +        # such place).
> +        self.info = info
> +        self._module: Optional[QAPISchemaModule] = None
> +        self._checked = False
> +
> +    def __repr__(self) -> str:
> +        return "<%s at 0x%x>" % (type(self).__name__, id(self))
> +
> +    def check(self, schema: QAPISchema) -> None:
> +        self._checked = True
> +
> +    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
> +        pass
> +
> +    def check_doc(self) -> None:
> +        pass
> +
> +    def _set_module(
> +        self, schema: QAPISchema, info: Optional[QAPISourceInfo]
> +    ) -> None:
> +        assert self._checked
> +        fname = info.fname if info else
> QAPISchemaModule.BUILTIN_MODULE_NAME
> +        self._module = schema.module_by_fname(fname)
> +        self._module.add_entity(self)
> +
> +    def set_module(self, schema: QAPISchema) -> None:
> +        self._set_module(schema, self.info)
> +
> +    def visit(self, visitor: QAPISchemaVisitor) -> None:
> +        # pylint: disable=unused-argument
> +        assert self._checked
> +
> +
> +class QAPISchemaDefinition(QAPISchemaEntity):
>      meta: str
>
>      def __init__(
> @@ -80,24 +119,16 @@ def __init__(
>          ifcond: Optional[QAPISchemaIfCond] = None,
>          features: Optional[List[QAPISchemaFeature]] = None,
>      ):
> +        super().__init__(info)
>          for f in features or []:
>              f.set_defined_in(name)
>          self.name = name
> -        self._module: Optional[QAPISchemaModule] = None
> -        # For explicitly defined entities, info points to the (explicit)
> -        # definition.  For builtins (and their arrays), info is None.
> -        # For implicitly defined entities, info points to a place that
> -        # triggered the implicit definition (there may be more than one
> -        # such place).
> -        self.info = info
>          self.doc = doc
>          self._ifcond = ifcond or QAPISchemaIfCond()
>          self.features = features or []
>          self._checked = False
> -
> +
>      def __repr__(self) -> str:
> -        if self.name is None:
> -            return "<%s at 0x%x>" % (type(self).__name__, id(self))
>          return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
>                                      id(self))
>
> @@ -122,17 +153,6 @@ def check_doc(self) -> None:
>          if self.doc:
>              self.doc.check()
>
> -    def _set_module(
> -        self, schema: QAPISchema, info: Optional[QAPISourceInfo]
> -    ) -> None:
> -        assert self._checked
> -        fname = info.fname if info else
> QAPISchemaModule.BUILTIN_MODULE_NAME
> -        self._module = schema.module_by_fname(fname)
> -        self._module.add_entity(self)
> -
> -    def set_module(self, schema: QAPISchema) -> None:
> -        self._set_module(schema, self.info)
> -
>      @property
>      def ifcond(self) -> QAPISchemaIfCond:
>          assert self._checked
> @@ -141,10 +161,6 @@ def ifcond(self) -> QAPISchemaIfCond:
>      def is_implicit(self) -> bool:
>          return not self.info
>
> -    def visit(self, visitor: QAPISchemaVisitor) -> None:
> -        # pylint: disable=unused-argument
> -        assert self._checked
> -
>      def describe(self) -> str:
>          return "%s '%s'" % (self.meta, self.name)
>
> @@ -301,9 +317,7 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
>
>  class QAPISchemaInclude(QAPISchemaEntity):
>      def __init__(self, sub_module: QAPISchemaModule, info:
> QAPISourceInfo):
> -        # Includes are internal entity objects; and may occur multiple
> times
> -        name = f"q_include_{info.fname}:{info.line}"
> -        super().__init__(name, info, None)
> +        super().__init__(info)
>          self._sub_module = sub_module
>
>      def visit(self, visitor: QAPISchemaVisitor) -> None:
> @@ -311,7 +325,7 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
>          visitor.visit_include(self._sub_module.name, self.info)
>
>
> -class QAPISchemaType(QAPISchemaEntity):
> +class QAPISchemaType(QAPISchemaDefinition):
>      # Return the C type for common use.
>      # For the types we commonly box, this is a pointer type.
>      def c_type(self) -> str:
> @@ -977,7 +991,7 @@ def __init__(
>          super().__init__(name, info, typ, False, ifcond)
>
>
> -class QAPISchemaCommand(QAPISchemaEntity):
> +class QAPISchemaCommand(QAPISchemaDefinition):
>      meta = 'command'
>
>      def __init__(
> @@ -1059,7 +1073,7 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
>              self.coroutine)
>
>
> -class QAPISchemaEvent(QAPISchemaEntity):
> +class QAPISchemaEvent(QAPISchemaDefinition):
>      meta = 'event'
>
>      def __init__(
> @@ -1133,7 +1147,7 @@ def __init__(self, fname: str):
>          exprs = check_exprs(parser.exprs)
>          self.docs = parser.docs
>          self._entity_list: List[QAPISchemaEntity] = []
> -        self._entity_dict: Dict[str, QAPISchemaEntity] = {}
> +        self._entity_dict: Dict[str, QAPISchemaDefinition] = {}
>          self._module_dict: Dict[str, QAPISchemaModule] = OrderedDict()
>          self._schema_dir = os.path.dirname(fname)
>          self._make_module(QAPISchemaModule.BUILTIN_MODULE_NAME)
> @@ -1145,9 +1159,12 @@ def __init__(self, fname: str):
>          self.check()
>
>      def _def_entity(self, ent: QAPISchemaEntity) -> None:
> +        self._entity_list.append(ent)
> +
> +    def _def_definition(self, ent: QAPISchemaDefinition) -> None:
>          # Only the predefined types are allowed to not have info
>          assert ent.info or self._predefining
> -        self._entity_list.append(ent)
> +        self._def_entity(ent)
>          if ent.name is None:
>              return
>          # TODO reject names that differ only in '_' vs. '.'  vs. '-',
> @@ -1163,7 +1180,7 @@ def _def_entity(self, ent: QAPISchemaEntity) -> None:
>                  ent.info, "%s is already defined" % other_ent.describe())
>          self._entity_dict[ent.name] = ent
>
> -    def get_entity(self, name: str) -> Optional[QAPISchemaEntity]:
> +    def get_definition(self, name: str) -> Optional[QAPISchemaDefinition]:
>          return self._entity_dict.get(name)
>
>      def get_typed_entity(
> @@ -1171,7 +1188,7 @@ def get_typed_entity(
>          name: str,
>          typ: Type[_EntityType]
>      ) -> Optional[_EntityType]:
> -        ent = self.get_entity(name)
> +        ent = self.get_definition(name)
>          if ent is not None and not isinstance(ent, typ):
>              etype = type(ent).__name__
>              ttype = typ.__name__
> @@ -1225,7 +1242,7 @@ def _def_include(self, expr: QAPIExpression) -> None:
>      def _def_builtin_type(
>          self, name: str, json_type: str, c_type: str
>      ) -> None:
> -        self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
> +        self._def_definition(QAPISchemaBuiltinType(name, json_type,
> c_type))
>          # Instantiating only the arrays that are actually used would
>          # be nice, but we can't as long as their generated code
>          # (qapi-builtin-types.[ch]) may be shared by some other
> @@ -1251,14 +1268,14 @@ def _def_predefineds(self) -> None:
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
> -        self._def_entity(QAPISchemaEnumType('QType', None, None, None,
> None,
> +        self._def_definition(QAPISchemaEnumType('QType', None, None,
> None, None,
>                                              qtype_values, 'QTYPE'))
>
>      def _make_features(
> @@ -1294,8 +1311,8 @@ def _make_array_type(
>          self, element_type: str, info: Optional[QAPISourceInfo]
>      ) -> str:
>          name = element_type + 'List'    # reserved by
> check_defn_name_str()
> -        if not self.get_entity(name):
> -            self._def_entity(QAPISchemaArrayType(name, info,
> element_type))
> +        if not self.get_definition(name):
> +            self._def_definition(QAPISchemaArrayType(name, info,
> element_type))
>          return name
>
>      def _make_implicit_object_type(
> @@ -1317,7 +1334,7 @@ def _make_implicit_object_type(
>              # later.
>              pass
>          else:
> -            self._def_entity(QAPISchemaObjectType(
> +            self._def_definition(QAPISchemaObjectType(
>                  name, info, None, ifcond, None, None, members, None))
>          return name
>
> @@ -1328,7 +1345,7 @@ def _def_enum_type(self, expr: QAPIExpression) ->
> None:
>          ifcond = QAPISchemaIfCond(expr.get('if'))
>          info = expr.info
>          features = self._make_features(expr.get('features'), info)
> -        self._def_entity(QAPISchemaEnumType(
> +        self._def_definition(QAPISchemaEnumType(
>              name, info, expr.doc, ifcond, features,
>              self._make_enum_members(data, info), prefix))
>
> @@ -1367,7 +1384,7 @@ def _def_struct_type(self, expr: QAPIExpression) ->
> None:
>          info = expr.info
>          ifcond = QAPISchemaIfCond(expr.get('if'))
>          features = self._make_features(expr.get('features'), info)
> -        self._def_entity(QAPISchemaObjectType(
> +        self._def_definition(QAPISchemaObjectType(
>              name, info, expr.doc, ifcond, features, base,
>              self._make_members(data, info),
>              None))
> @@ -1403,7 +1420,7 @@ def _def_union_type(self, expr: QAPIExpression) ->
> None:
>                                 info)
>              for (key, value) in data.items()]
>          members: List[QAPISchemaObjectTypeMember] = []
> -        self._def_entity(
> +        self._def_definition(
>              QAPISchemaObjectType(name, info, expr.doc, ifcond, features,
>                                   base, members,
>                                   QAPISchemaVariants(
> @@ -1422,7 +1439,7 @@ def _def_alternate_type(self, expr: QAPIExpression)
> -> None:
>                                 info)
>              for (key, value) in data.items()]
>          tag_member = QAPISchemaObjectTypeMember('type', info, 'QType',
> False)
> -        self._def_entity(
> +        self._def_definition(
>              QAPISchemaAlternateType(
>                  name, info, expr.doc, ifcond, features,
>                  QAPISchemaVariants(None, info, tag_member, variants)))
> @@ -1447,7 +1464,7 @@ def _def_command(self, expr: QAPIExpression) -> None:
>          if isinstance(rets, list):
>              assert len(rets) == 1
>              rets = self._make_array_type(rets[0], info)
> -        self._def_entity(QAPISchemaCommand(name, info, expr.doc, ifcond,
> +        self._def_definition(QAPISchemaCommand(name, info, expr.doc,
> ifcond,
>                                             features, data, rets,
>                                             gen, success_response,
>                                             boxed, allow_oob,
> allow_preconfig,
> @@ -1464,7 +1481,7 @@ def _def_event(self, expr: QAPIExpression) -> None:
>              data = self._make_implicit_object_type(
>                  name, info, ifcond,
>                  'arg', self._make_members(data, info))
> -        self._def_entity(QAPISchemaEvent(name, info, expr.doc, ifcond,
> +        self._def_definition(QAPISchemaEvent(name, info, expr.doc, ifcond,
>                                           features, data, boxed))
>
>      def _def_exprs(self, exprs: List[QAPIExpression]) -> None:
>

I'll try the refactor out in a patch at the end of my series and see how
feasible it is.

(I haven't reviewed it deeply yet, so if there's an obvious problem I'll
find it when I go to implement this. conceptually it seems fine.)

>

--000000000000341590060aac0238
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Nov 21, 2023, 8:33 AM Markus Armbruster &lt;<a=
 href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; write=
s:<br>
<br>
&gt; It simplifies typing to mandate that entities will always have a name;=
<br>
&gt; to achieve this we can occasionally assign an internal name. This<br>
&gt; alleviates errors such as:<br>
&gt;<br>
&gt; qapi/schema.py:287: error: Argument 1 to &quot;__init__&quot; of<br>
&gt; &quot;QAPISchemaEntity&quot; has incompatible type &quot;None&quot;; e=
xpected &quot;str&quot;<br>
&gt; [arg-type]<br>
&gt;<br>
&gt; Trying to fix it the other way by allowing entities to only have<br>
&gt; optional names opens up a nightmare portal of whackamole to try and<br=
>
&gt; audit that every other pathway doesn&#39;t actually pass a None name w=
hen we<br>
&gt; expect it to; this is the simpler direction of consitifying the typing=
.<br>
<br>
Arguably, that nightmare is compile-time proof of &quot;we are not mistakin=
g<br>
QAPISchemaInclude for a named entity&quot;.<br>
<br>
When I added the include directive, I shoehorned it into the existing<br>
representation of the QAPI schema as &quot;list of QAPISchemaEntity&quot; b=
y<br>
making it a subtype of QAPISchemaEntity.=C2=A0 That was a somewhat lazy hac=
k.<br>
<br>
Note that qapi-code-gen.rst distinguishes between definitions and<br>
directives.<br>
<br>
The places where mypy gripes that .name isn&#39;t &#39;str&#39; generally w=
ant<br>
something with a name (what qapi-code-gen.rst calls a definition).=C2=A0 If=
<br>
we somehow pass them an include directive, they&#39;ll use None for a name,=
<br>
which is no good.=C2=A0 mypy is pointing out this problem.<br>
<br>
What to do about it?<br>
<br>
1. Paper it over: give include directives some made-up name (this<br>
patch).=C2=A0 Now the places use the made-up name instead of None, and mypy=
<br>
can&#39;t see the problem anymore.<br>
<br>
2. Assert .name is not None until mypy is happy.=C2=A0 I guess that&#39;s w=
hat<br>
you called opening &quot;a nightmare portal of whackamole&quot;.<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yep.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<br>
3. Clean up the typing: have a type for top-level expression (has no<br>
name), and a subtype for definition (has a name).=C2=A0 Rough sketch<br>
appended.=C2=A0 Thoughts?<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Oh, that&#39;ll work. I tried to keep to &quot;min=
imal SLOC&quot; but where you want to see deeper fixes, I&#39;m happy to de=
viate. I&#39;ll give it a shot.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/schema.py | 4 +++-<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; index 153e703e0ef..0fb44452dd5 100644<br>
&gt; --- a/scripts/qapi/schema.py<br>
&gt; +++ b/scripts/qapi/schema.py<br>
&gt; @@ -220,7 +220,9 @@ def visit(self, visitor):<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class QAPISchemaInclude(QAPISchemaEntity):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def __init__(self, sub_module, info):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(None, info, None)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Includes are internal entity objects; a=
nd may occur multiple times<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D f&quot;q_include_{info.fname}:{i=
nfo.line}&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(name, info, None)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._sub_module =3D sub_module<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit(self, visitor):<br>
<br>
There are two instances of .name is None:<br>
<br>
=C2=A0 =C2=A0 def __repr__(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://self.name" rel=3D"noreferr=
er noreferrer" target=3D"_blank">self.name</a> is None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;&lt;%s at 0x%x&gt;&q=
uot; % (type(self).__name__, id(self))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;&lt;%s:%s at 0x%x&gt;&quot; % (typ=
e(self).__name__, <a href=3D"http://self.name" rel=3D"noreferrer noreferrer=
" target=3D"_blank">self.name</a>,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id(self))<br>
<br>
and<br>
<br>
=C2=A0 =C2=A0 def _def_entity(self, ent: QAPISchemaEntity) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Only the predefined types are allowed to not =
have info<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert <a href=3D"http://ent.info" rel=3D"noref=
errer noreferrer" target=3D"_blank">ent.info</a> or self._predefining<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._entity_list.append(ent)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://ent.name" rel=3D"noreferre=
r noreferrer" target=3D"_blank">ent.name</a> is None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [...]<br>
<br>
Don&#39;t they need to be updated?<br></blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Oh, yes. I remove some assertions later i=
n the series but I very likely missed these if cases.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
<br>
<br>
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
index 24ad166d52..eaff1df534 100644<br>
--- a/scripts/qapi/schema.py<br>
+++ b/scripts/qapi/schema.py<br>
@@ -70,6 +70,45 @@ def is_present(self) -&gt; bool:<br>
<br>
<br>
=C2=A0class QAPISchemaEntity:<br>
+=C2=A0 =C2=A0 def __init__(self, info: Optional[QAPISourceInfo]):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # For explicitly defined entities, info points=
 to the (explicit)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # definition.=C2=A0 For builtins (and their ar=
rays), info is None.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # For implicitly defined entities, info points=
 to a place that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # triggered the implicit definition (there may=
 be more than one<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # such place).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">self.info</a> =3D info<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._module: Optional[QAPISchemaModule] =3D N=
one<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._checked =3D False<br>
+<br>
+=C2=A0 =C2=A0 def __repr__(self) -&gt; str:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;&lt;%s at 0x%x&gt;&quot; % (type(=
self).__name__, id(self))<br>
+<br>
+=C2=A0 =C2=A0 def check(self, schema: QAPISchema) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._checked =3D True<br>
+<br>
+=C2=A0 =C2=A0 def connect_doc(self, doc: Optional[QAPIDoc] =3D None) -&gt;=
 None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
+<br>
+=C2=A0 =C2=A0 def check_doc(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
+<br>
+=C2=A0 =C2=A0 def _set_module(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, schema: QAPISchema, info: Optional[QAPIS=
ourceInfo]<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fname =3D info.fname if info else QAPISchemaMo=
dule.BUILTIN_MODULE_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._module =3D schema.module_by_fname(fname)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._module.add_entity(self)<br>
+<br>
+=C2=A0 =C2=A0 def set_module(self, schema: QAPISchema) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_module(schema, <a href=3D"http://sel=
f.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.info</a>)<br>
+<br>
+=C2=A0 =C2=A0 def visit(self, visitor: QAPISchemaVisitor) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # pylint: disable=3Dunused-argument<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked<br>
+<br>
+<br>
+class QAPISchemaDefinition(QAPISchemaEntity):<br>
=C2=A0 =C2=A0 =C2=A0meta: str<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __init__(<br>
@@ -80,24 +119,16 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ifcond: Optional[QAPISchemaIfCond] =3D No=
ne,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0features: Optional[List[QAPISchemaFeature=
]] =3D None,<br>
=C2=A0 =C2=A0 =C2=A0):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for f in features or []:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.set_defined_in(name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.name" rel=3D"noref=
errer noreferrer" target=3D"_blank">self.name</a> =3D name<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._module: Optional[QAPISchemaModule] =3D N=
one<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # For explicitly defined entities, info points=
 to the (explicit)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # definition.=C2=A0 For builtins (and their ar=
rays), info is None.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # For implicitly defined entities, info points=
 to a place that<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # triggered the implicit definition (there may=
 be more than one<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # such place).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">self.info</a> =3D info<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.doc =3D doc<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._ifcond =3D ifcond or QAPISchemaIfCo=
nd()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.features =3D features or []<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._checked =3D False<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0def __repr__(self) -&gt; str:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://self.name" rel=3D"norefer=
rer noreferrer" target=3D"_blank">self.name</a> is None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;&lt;%s at 0x%x&gt;&=
quot; % (type(self).__name__, id(self))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;&lt;%s:%s at 0x%x&gt;&quot; =
% (type(self).__name__, <a href=3D"http://self.name" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">self.name</a>,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id(self))<br>
<br>
@@ -122,17 +153,6 @@ def check_doc(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.doc:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.doc.check()<br>
<br>
-=C2=A0 =C2=A0 def _set_module(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, schema: QAPISchema, info: Optional[QAPIS=
ourceInfo]<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fname =3D info.fname if info else QAPISchemaMo=
dule.BUILTIN_MODULE_NAME<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._module =3D schema.module_by_fname(fname)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._module.add_entity(self)<br>
-<br>
-=C2=A0 =C2=A0 def set_module(self, schema: QAPISchema) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_module(schema, <a href=3D"http://sel=
f.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.info</a>)<br>
-<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
=C2=A0 =C2=A0 =C2=A0def ifcond(self) -&gt; QAPISchemaIfCond:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert self._checked<br>
@@ -141,10 +161,6 @@ def ifcond(self) -&gt; QAPISchemaIfCond:<br>
=C2=A0 =C2=A0 =C2=A0def is_implicit(self) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return not <a href=3D"http://self.info" r=
el=3D"noreferrer noreferrer" target=3D"_blank">self.info</a><br>
<br>
-=C2=A0 =C2=A0 def visit(self, visitor: QAPISchemaVisitor) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # pylint: disable=3Dunused-argument<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked<br>
-<br>
=C2=A0 =C2=A0 =C2=A0def describe(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;%s &#39;%s&#39;&quot; % (sel=
f.meta, <a href=3D"http://self.name" rel=3D"noreferrer noreferrer" target=
=3D"_blank">self.name</a>)<br>
<br>
@@ -301,9 +317,7 @@ def visit(self, visitor: QAPISchemaVisitor) -&gt; None:=
<br>
<br>
=C2=A0class QAPISchemaInclude(QAPISchemaEntity):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, sub_module: QAPISchemaModule, info: =
QAPISourceInfo):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Includes are internal entity objects; and ma=
y occur multiple times<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D f&quot;q_include_{info.fname}:{info.l=
ine}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(name, info, None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._sub_module =3D sub_module<br>
<br>
=C2=A0 =C2=A0 =C2=A0def visit(self, visitor: QAPISchemaVisitor) -&gt; None:=
<br>
@@ -311,7 +325,7 @@ def visit(self, visitor: QAPISchemaVisitor) -&gt; None:=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0visitor.visit_include(self._<a href=3D"ht=
tp://sub_module.name" rel=3D"noreferrer noreferrer" target=3D"_blank">sub_m=
odule.name</a>, <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" =
target=3D"_blank">self.info</a>)<br>
<br>
<br>
-class QAPISchemaType(QAPISchemaEntity):<br>
+class QAPISchemaType(QAPISchemaDefinition):<br>
=C2=A0 =C2=A0 =C2=A0# Return the C type for common use.<br>
=C2=A0 =C2=A0 =C2=A0# For the types we commonly box, this is a pointer type=
.<br>
=C2=A0 =C2=A0 =C2=A0def c_type(self) -&gt; str:<br>
@@ -977,7 +991,7 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__(name, info, typ, False, =
ifcond)<br>
<br>
<br>
-class QAPISchemaCommand(QAPISchemaEntity):<br>
+class QAPISchemaCommand(QAPISchemaDefinition):<br>
=C2=A0 =C2=A0 =C2=A0meta =3D &#39;command&#39;<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __init__(<br>
@@ -1059,7 +1073,7 @@ def visit(self, visitor: QAPISchemaVisitor) -&gt; Non=
e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.coroutine)<br>
<br>
<br>
-class QAPISchemaEvent(QAPISchemaEntity):<br>
+class QAPISchemaEvent(QAPISchemaDefinition):<br>
=C2=A0 =C2=A0 =C2=A0meta =3D &#39;event&#39;<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __init__(<br>
@@ -1133,7 +1147,7 @@ def __init__(self, fname: str):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exprs =3D check_exprs(parser.exprs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.docs =3D parser.docs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._entity_list: List[QAPISchemaEntity]=
 =3D []<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._entity_dict: Dict[str, QAPISchemaEntity]=
 =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._entity_dict: Dict[str, QAPISchemaDefinit=
ion] =3D {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._module_dict: Dict[str, QAPISchemaMo=
dule] =3D OrderedDict()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._schema_dir =3D os.path.dirname(fnam=
e)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._make_module(QAPISchemaModule.BUILTI=
N_MODULE_NAME)<br>
@@ -1145,9 +1159,12 @@ def __init__(self, fname: str):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.check()<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _def_entity(self, ent: QAPISchemaEntity) -&gt; None=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._entity_list.append(ent)<br>
+<br>
+=C2=A0 =C2=A0 def _def_definition(self, ent: QAPISchemaDefinition) -&gt; N=
one:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Only the predefined types are allowed t=
o not have info<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert <a href=3D"http://ent.info" rel=3D=
"noreferrer noreferrer" target=3D"_blank">ent.info</a> or self._predefining=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._entity_list.append(ent)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(ent)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if <a href=3D"http://ent.name" rel=3D"nor=
eferrer noreferrer" target=3D"_blank">ent.name</a> is None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# TODO reject names that differ only in &=
#39;_&#39; vs. &#39;.&#39;=C2=A0 vs. &#39;-&#39;,<br>
@@ -1163,7 +1180,7 @@ def _def_entity(self, ent: QAPISchemaEntity) -&gt; No=
ne:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"ht=
tp://ent.info" rel=3D"noreferrer noreferrer" target=3D"_blank">ent.info</a>=
, &quot;%s is already defined&quot; % other_ent.describe())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._entity_dict[<a href=3D"http://ent.n=
ame" rel=3D"noreferrer noreferrer" target=3D"_blank">ent.name</a>] =3D ent<=
br>
<br>
-=C2=A0 =C2=A0 def get_entity(self, name: str) -&gt; Optional[QAPISchemaEnt=
ity]:<br>
+=C2=A0 =C2=A0 def get_definition(self, name: str) -&gt; Optional[QAPISchem=
aDefinition]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._entity_dict.get(name)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def get_typed_entity(<br>
@@ -1171,7 +1188,7 @@ def get_typed_entity(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name: str,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0typ: Type[_EntityType]<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; Optional[_EntityType]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ent =3D self.get_entity(name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ent =3D self.get_definition(name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ent is not None and not isinstance(ent=
, typ):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0etype =3D type(ent).__name_=
_<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttype =3D typ.__name__<br>
@@ -1225,7 +1242,7 @@ def _def_include(self, expr: QAPIExpression) -&gt; No=
ne:<br>
=C2=A0 =C2=A0 =C2=A0def _def_builtin_type(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self, name: str, json_type: str, c_type: =
str<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(QAPISchemaBuiltinType(name, j=
son_type, c_type))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_definition(QAPISchemaBuiltinType(nam=
e, json_type, c_type))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Instantiating only the arrays that are =
actually used would<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# be nice, but we can&#39;t as long as th=
eir generated code<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# (qapi-builtin-types.[ch]) may be shared=
 by some other<br>
@@ -1251,14 +1268,14 @@ def _def_predefineds(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._def_builtin_type(*t)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.the_empty_object_type =3D QAPISchema=
ObjectType(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;q_empty&#39;, None, No=
ne, None, None, None, [], None)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(self.the_empty_object_type)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_definition(self.the_empty_object_typ=
e)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qtypes =3D [&#39;none&#39;, &#39;qnull&#3=
9;, &#39;qnum&#39;, &#39;qstring&#39;, &#39;qdict&#39;, &#39;qlist&#39;,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;q=
bool&#39;]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qtype_values =3D self._make_enum_members(=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[{&#39;name&#39;: n} for n =
in qtypes], None)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(QAPISchemaEnumType(&#39;QType=
&#39;, None, None, None, None,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_definition(QAPISchemaEnumType(&#39;Q=
Type&#39;, None, None, None, None,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0qtype_values, &#39;QTYPE&#39;))<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _make_features(<br>
@@ -1294,8 +1311,8 @@ def _make_array_type(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self, element_type: str, info: Optional[Q=
APISourceInfo]<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D element_type + &#39;List&#39;=C2=
=A0 =C2=A0 # reserved by check_defn_name_str()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.get_entity(name):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(QAPISchemaArray=
Type(name, info, element_type))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.get_definition(name):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_definition(QAPISchemaA=
rrayType(name, info, element_type))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return name<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _make_implicit_object_type(<br>
@@ -1317,7 +1334,7 @@ def _make_implicit_object_type(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# later.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(QAPISchemaObjec=
tType(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_definition(QAPISchemaO=
bjectType(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name, info, N=
one, ifcond, None, None, members, None))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return name<br>
<br>
@@ -1328,7 +1345,7 @@ def _def_enum_type(self, expr: QAPIExpression) -&gt; =
None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ifcond =3D QAPISchemaIfCond(expr.get(&#39=
;if&#39;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info =3D <a href=3D"http://expr.info" rel=
=3D"noreferrer noreferrer" target=3D"_blank">expr.info</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0features =3D self._make_features(expr.get=
(&#39;features&#39;), info)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(QAPISchemaEnumType(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_definition(QAPISchemaEnumType(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name, info, expr.doc, ifcon=
d, features,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._make_enum_members(dat=
a, info), prefix))<br>
<br>
@@ -1367,7 +1384,7 @@ def _def_struct_type(self, expr: QAPIExpression) -&gt=
; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info =3D <a href=3D"http://expr.info" rel=
=3D"noreferrer noreferrer" target=3D"_blank">expr.info</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ifcond =3D QAPISchemaIfCond(expr.get(&#39=
;if&#39;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0features =3D self._make_features(expr.get=
(&#39;features&#39;), info)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(QAPISchemaObjectType(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_definition(QAPISchemaObjectType(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name, info, expr.doc, ifcon=
d, features, base,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._make_members(data, in=
fo),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0None))<br>
@@ -1403,7 +1420,7 @@ def _def_union_type(self, expr: QAPIExpression) -&gt;=
 None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (key, value) in data.it=
ems()]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0members: List[QAPISchemaObjectTypeMember]=
 =3D []<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_definition(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QAPISchemaObjectType(name, =
info, expr.doc, ifcond, features,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base, members,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPISchemaVariants(<br>
@@ -1422,7 +1439,7 @@ def _def_alternate_type(self, expr: QAPIExpression) -=
&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (key, value) in data.it=
ems()]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tag_member =3D QAPISchemaObjectTypeMember=
(&#39;type&#39;, info, &#39;QType&#39;, False)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_definition(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QAPISchemaAlternateType(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name, info, e=
xpr.doc, ifcond, features,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QAPISchemaVar=
iants(None, info, tag_member, variants)))<br>
@@ -1447,7 +1464,7 @@ def _def_command(self, expr: QAPIExpression) -&gt; No=
ne:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if isinstance(rets, list):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert len(rets) =3D=3D 1<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rets =3D self._make_array_t=
ype(rets[0], info)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(QAPISchemaCommand(name, info,=
 expr.doc, ifcond,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_definition(QAPISchemaCommand(name, i=
nfo, expr.doc, ifcond,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 features, data, rets,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 gen, success_response,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 boxed, allow_oob, allow_preconfig,<br>
@@ -1464,7 +1481,7 @@ def _def_event(self, expr: QAPIExpression) -&gt; None=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D self._make_implici=
t_object_type(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name, info, i=
fcond,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;arg&#39;=
, self._make_members(data, info))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_entity(QAPISchemaEvent(name, info, e=
xpr.doc, ifcond,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_definition(QAPISchemaEvent(name, inf=
o, expr.doc, ifcond,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f=
eatures, data, boxed))<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _def_exprs(self, exprs: List[QAPIExpression]) -&gt;=
 None:<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">I&#39;ll try the refactor out in a patch at the end of my series and =
see how feasible it is.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
(I haven&#39;t reviewed it deeply yet, so if there&#39;s an obvious problem=
 I&#39;ll find it when I go to implement this. conceptually it seems fine.)=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"></blockquote></div></div></div>

--000000000000341590060aac0238--


