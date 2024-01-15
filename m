Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B86582E231
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 22:24:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPUQo-0001tL-IG; Mon, 15 Jan 2024 16:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rPUQn-0001tD-DK
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 16:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rPUQi-0002II-M7
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 16:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705353815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=za2ZHU2k7rEdNduv1KE+xAVBqhJ4ttczoMLAihCAfZw=;
 b=DHygVt45ytpxu6skBIjUyquMhcw8x5SWLAjFCiluwmBi8uiPU0K1/x37YekcADvJzg55EX
 RGvBPfm+fgjWWE8kAPsqzmDh+z2DkhQvl1vjotedfuKEglsZ2hPbE8eliTCGCDlRLsu6zA
 /gn1otNH6f5LPGdkkZQwOE8MaTWJLwg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-bczXnM2nNKqMNzovPmE8Ng-1; Mon, 15 Jan 2024 16:23:24 -0500
X-MC-Unique: bczXnM2nNKqMNzovPmE8Ng-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-598b720ca14so4994133eaf.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 13:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705353804; x=1705958604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=za2ZHU2k7rEdNduv1KE+xAVBqhJ4ttczoMLAihCAfZw=;
 b=pQEEwLHh3qWFExvUnIZRPVkjbcV0iVCB6bckXld8afIDJAG+NKpfN59uzOaiUf/h7V
 9NPodZGQ9/lsiKYMb7Gr3TMFm8P0ARKX1v4tJ7aATKQLPlKWv+jGa2SmAXVxfBEJfBas
 n5VvTifjyTm+cRt3T+6oMRovgxOA1himHfo/2XEWRbut6qCLyR/AT10q6obygyw+3fwi
 19fsb4du3RRTNRrGu8z0LaXAsjWjGYVqOhb5nne1n22MJicN5TFflmXPz3FbVaM2hIX6
 ecZevaxTs7awq25+EXn646g1s/6+jlOHEp757mOXFztj1LhE4VjMF83kKkGGhq1cRtFl
 j1cQ==
X-Gm-Message-State: AOJu0Yyb41tXPz4EBrCnEZlAcoXHn+GfGluGVvdBUarQHass0S5SjDD+
 jrZvz15bFFB85ntpRrTca0djelZeNsKKwh3rUQEYoNLKb2Zz9M/CPqVuYFO5lJq1N27eXkqFvtl
 56BezxhnC0l7X8WpfrukZqKXoNTt+W67HDE694gY=
X-Received: by 2002:a05:6820:612:b0:594:1b74:dafe with SMTP id
 e18-20020a056820061200b005941b74dafemr4149604oow.13.1705353802055; 
 Mon, 15 Jan 2024 13:23:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH00Mko78E5H9vmAyH1Cch9YXitaSqKhEJp0qmgdRmCeF6z22puqFapxlr8QUwBssyYq9hZZDsrYU58y5Y/mMk=
X-Received: by 2002:a05:6820:612:b0:594:1b74:dafe with SMTP id
 e18-20020a056820061200b005941b74dafemr4149597oow.13.1705353801670; Mon, 15
 Jan 2024 13:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-4-jsnow@redhat.com>
 <87edeid9e3.fsf@pond.sub.org>
In-Reply-To: <87edeid9e3.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 15 Jan 2024 16:23:10 -0500
Message-ID: <CAFn=p-bgv185=LMrHzWrMYL1_TyOATnoX+K1x0_nf_=U=42x+w@mail.gmail.com>
Subject: Re: [PATCH v2 03/19] qapi: create QAPISchemaDefinition
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

On Mon, Jan 15, 2024 at 8:16=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Include entities don't have names, but we generally expect "entities" t=
o
> > have names. Reclassify all entities with names as *definitions*, leavin=
g
> > the nameless include entities as QAPISchemaEntity instances.
> >
> > This is primarily to help simplify typing around expectations of what
> > callers expect for properties of an "entity".
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 117 ++++++++++++++++++++++++-----------------
> >  1 file changed, 70 insertions(+), 47 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index b7830672e57..e39ed972a80 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -55,14 +55,14 @@ def is_present(self):
> >
> >
> >  class QAPISchemaEntity:
> > -    meta: Optional[str] =3D None
> > +    """
> > +    QAPISchemaEntity represents all schema entities.
> >
> > -    def __init__(self, name: str, info, doc, ifcond=3DNone, features=
=3DNone):
> > -        assert name is None or isinstance(name, str)
> > -        for f in features or []:
> > -            assert isinstance(f, QAPISchemaFeature)
> > -            f.set_defined_in(name)
> > -        self.name =3D name
> > +    Notably, this includes both named and un-named entities, such as
> > +    include directives. Entities with names are represented by the
> > +    more specific sub-class `QAPISchemaDefinition` instead.
> > +    """
>
> Hmm.  What about:
>
>        """
>        A schema entity.
>
>        This is either a directive, such as include, or a definition.
>        The latter use sub-class `QAPISchemaDefinition`.
>        """
>

Sure. Key point was just the cookie crumb to the sub-class.

> > +    def __init__(self, info):
> >          self._module =3D None
> >          # For explicitly defined entities, info points to the (explici=
t)
> >          # definition.  For builtins (and their arrays), info is None.
> > @@ -70,14 +70,50 @@ def __init__(self, name: str, info, doc, ifcond=3DN=
one, features=3DNone):
> >          # triggered the implicit definition (there may be more than on=
e
> >          # such place).
> >          self.info =3D info
> > +        self._checked =3D False
> > +
> > +    def __repr__(self):
> > +        return "<%s at 0x%x>" % (type(self).__name__, id(self))
> > +
> > +    def check(self, schema):
> > +        # pylint: disable=3Dunused-argument
> > +        self._checked =3D True
> > +
> > +    def connect_doc(self, doc=3DNone):
> > +        pass
> > +
> > +    def check_doc(self):
> > +        pass
> > +
> > +    def _set_module(self, schema, info):
> > +        assert self._checked
> > +        fname =3D info.fname if info else QAPISchemaModule.BUILTIN_MOD=
ULE_NAME
> > +        self._module =3D schema.module_by_fname(fname)
> > +        self._module.add_entity(self)
> > +
> > +    def set_module(self, schema):
> > +        self._set_module(schema, self.info)
> > +
> > +    def visit(self, visitor):
> > +        # pylint: disable=3Dunused-argument
> > +        assert self._checked
> > +
> > +
> > +class QAPISchemaDefinition(QAPISchemaEntity):
> > +    meta: Optional[str] =3D None
> > +
> > +    def __init__(self, name: str, info, doc, ifcond=3DNone, features=
=3DNone):
> > +        assert isinstance(name, str)
> > +        super().__init__(info)
> > +        for f in features or []:
> > +            assert isinstance(f, QAPISchemaFeature)
> > +            f.set_defined_in(name)
> > +        self.name =3D name
> >          self.doc =3D doc
> >          self._ifcond =3D ifcond or QAPISchemaIfCond()
> >          self.features =3D features or []
> > -        self._checked =3D False
> >
> >      def __repr__(self):
> > -        if self.name is None:
> > -            return "<%s at 0x%x>" % (type(self).__name__, id(self))
> >          return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
> >                                      id(self))
> >
> > @@ -102,15 +138,6 @@ def check_doc(self):
>        def check(self, schema):
>            # pylint: disable=3Dunused-argument
>            assert not self._checked
>            seen =3D {}
>            for f in self.features:
>                f.check_clash(self.info, seen)
>            self._checked =3D True
>
>        def connect_doc(self, doc=3DNone):
>            doc =3D doc or self.doc
>            if doc:
>                for f in self.features:
>                    doc.connect_feature(f)
>
>        def check_doc(self):
> >          if self.doc:
> >              self.doc.check()
>
> No super().FOO()?
>

Ah, just an oversight. It worked out because the super method doesn't
do anything anyway. check() and connect_doc() should also use the
super call, probably.

> >
> > -    def _set_module(self, schema, info):
> > -        assert self._checked
> > -        fname =3D info.fname if info else QAPISchemaModule.BUILTIN_MOD=
ULE_NAME
> > -        self._module =3D schema.module_by_fname(fname)
> > -        self._module.add_entity(self)
> > -
> > -    def set_module(self, schema):
> > -        self._set_module(schema, self.info)
> > -
> >      @property
> >      def ifcond(self):
> >          assert self._checked
> > @@ -119,10 +146,6 @@ def ifcond(self):
> >      def is_implicit(self):
> >          return not self.info
> >
> > -    def visit(self, visitor):
> > -        # pylint: disable=3Dunused-argument
> > -        assert self._checked
> > -
> >      def describe(self):
> >          assert self.meta
> >          return "%s '%s'" % (self.meta, self.name)
> > @@ -222,7 +245,7 @@ def visit(self, visitor):
> >
> >  class QAPISchemaInclude(QAPISchemaEntity):
> >      def __init__(self, sub_module, info):
> > -        super().__init__(None, info, None)
> > +        super().__init__(info)
> >          self._sub_module =3D sub_module
> >
> >      def visit(self, visitor):
> > @@ -230,7 +253,7 @@ def visit(self, visitor):
> >          visitor.visit_include(self._sub_module.name, self.info)
> >
> >
> > -class QAPISchemaType(QAPISchemaEntity):
> > +class QAPISchemaType(QAPISchemaDefinition):
> >      # Return the C type for common use.
> >      # For the types we commonly box, this is a pointer type.
> >      def c_type(self):
> > @@ -801,7 +824,7 @@ def __init__(self, name, info, typ, ifcond=3DNone):
> >          super().__init__(name, info, typ, False, ifcond)
> >
> >
> > -class QAPISchemaCommand(QAPISchemaEntity):
> > +class QAPISchemaCommand(QAPISchemaDefinition):
> >      meta =3D 'command'
> >
> >      def __init__(self, name, info, doc, ifcond, features,
> > @@ -872,7 +895,7 @@ def visit(self, visitor):
> >              self.coroutine)
> >
> >
> > -class QAPISchemaEvent(QAPISchemaEntity):
> > +class QAPISchemaEvent(QAPISchemaDefinition):
> >      meta =3D 'event'
> >
> >      def __init__(self, name, info, doc, ifcond, features, arg_type, bo=
xed):
> > @@ -943,11 +966,12 @@ def __init__(self, fname):
> >          self.check()
> >
> >      def _def_entity(self, ent):
> > +        self._entity_list.append(ent)
> > +
> > +    def _def_definition(self, ent):
>
> Name the argument @defn instead of @ent?
>

OK. (Was aiming for less diffstat, but yes.)

> >          # Only the predefined types are allowed to not have info
> >          assert ent.info or self._predefining
> > -        self._entity_list.append(ent)
> > -        if ent.name is None:
> > -            return
> > +        self._def_entity(ent)
> >          # TODO reject names that differ only in '_' vs. '.'  vs. '-',
> >          # because they're liable to clash in generated C.
> >          other_ent =3D self._entity_dict.get(ent.name)
> > @@ -1001,7 +1025,7 @@ def _def_include(self, expr: QAPIExpression):
> >              QAPISchemaInclude(self._make_module(include), expr.info))
> >
> >      def _def_builtin_type(self, name, json_type, c_type):
> > -        self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type=
))
> > +        self._def_definition(QAPISchemaBuiltinType(name, json_type, c_=
type))
> >          # Instantiating only the arrays that are actually used would
> >          # be nice, but we can't as long as their generated code
> >          # (qapi-builtin-types.[ch]) may be shared by some other
> > @@ -1027,15 +1051,15 @@ def _def_predefineds(self):
> >              self._def_builtin_type(*t)
> >          self.the_empty_object_type =3D QAPISchemaObjectType(
> >              'q_empty', None, None, None, None, None, [], None)
> > -        self._def_entity(self.the_empty_object_type)
> > +        self._def_definition(self.the_empty_object_type)
> >
> >          qtypes =3D ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlis=
t',
> >                    'qbool']
> >          qtype_values =3D self._make_enum_members(
> >              [{'name': n} for n in qtypes], None)
> >
> > -        self._def_entity(QAPISchemaEnumType('QType', None, None, None,=
 None,
> > -                                            qtype_values, 'QTYPE'))
> > +        self._def_definition(QAPISchemaEnumType('QType', None, None, N=
one,
> > +                                                None, qtype_values, 'Q=
TYPE'))
>
> The long identifiers squeeze the (also long) argument list against the
> right margin.  What about:
>
>            self._def_definition(QAPISchemaEnumType(
>                'QType', None, None, None, None, qtype_values, 'QTYPE'))

This is fine to my eyes.

>
> or
>
>            self._def_definition(
>                QAPISchemaEnumType('QType', None, None, None, None,
>                                   qtype_values, 'QTYPE'))
>
> We already use the former style elsewhere, visible below.
>
> You add one in the latter style in the second to last hunk.
>
> Pick one style and stick ot it?

Yeah. I might try to run the black formatter in the end and just stick
to that, if you don't mind a bit of churn in exchange for having it be
a bit more mindless. It would be a big hassle to run it at the
beginning of the series now, though... but I'll fix this instance for
now.

>
> >
> >      def _make_features(self, features, info):
> >          if features is None:
> > @@ -1057,7 +1081,7 @@ def _make_enum_members(self, values, info):
> >      def _make_array_type(self, element_type, info):
> >          name =3D element_type + 'List'    # reserved by check_defn_nam=
e_str()
> >          if not self.lookup_type(name):
> > -            self._def_entity(QAPISchemaArrayType(name, info, element_t=
ype))
> > +            self._def_definition(QAPISchemaArrayType(name, info, eleme=
nt_type))
>
>                self._def_definition(QAPISchemaArrayType(
>                    name, info, element_type))
>
> or
>
>                self._def_definition(
>                    QAPISchemaArrayType(name, info, element_type))
>

OK. (79 columns too long for ya?)

> >          return name
> >
> >      def _make_implicit_object_type(self, name, info, ifcond, role, mem=
bers):
> > @@ -1072,7 +1096,7 @@ def _make_implicit_object_type(self, name, info, =
ifcond, role, members):
> >              # later.
> >              pass
> >          else:
> > -            self._def_entity(QAPISchemaObjectType(
> > +            self._def_definition(QAPISchemaObjectType(
> >                  name, info, None, ifcond, None, None, members, None))
> >          return name
> >
> > @@ -1083,7 +1107,7 @@ def _def_enum_type(self, expr: QAPIExpression):
> >          ifcond =3D QAPISchemaIfCond(expr.get('if'))
> >          info =3D expr.info
> >          features =3D self._make_features(expr.get('features'), info)
> > -        self._def_entity(QAPISchemaEnumType(
> > +        self._def_definition(QAPISchemaEnumType(
> >              name, info, expr.doc, ifcond, features,
> >              self._make_enum_members(data, info), prefix))
> >
> > @@ -1111,7 +1135,7 @@ def _def_struct_type(self, expr: QAPIExpression):
> >          info =3D expr.info
> >          ifcond =3D QAPISchemaIfCond(expr.get('if'))
> >          features =3D self._make_features(expr.get('features'), info)
> > -        self._def_entity(QAPISchemaObjectType(
> > +        self._def_definition(QAPISchemaObjectType(
> >              name, info, expr.doc, ifcond, features, base,
> >              self._make_members(data, info),
> >              None))
> > @@ -1141,7 +1165,7 @@ def _def_union_type(self, expr: QAPIExpression):
> >                                 info)
> >              for (key, value) in data.items()]
> >          members: List[QAPISchemaObjectTypeMember] =3D []
> > -        self._def_entity(
> > +        self._def_definition(
> >              QAPISchemaObjectType(name, info, expr.doc, ifcond, feature=
s,
> >                                   base, members,
> >                                   QAPISchemaVariants(
> > @@ -1160,7 +1184,7 @@ def _def_alternate_type(self, expr: QAPIExpressio=
n):
> >                                 info)
> >              for (key, value) in data.items()]
> >          tag_member =3D QAPISchemaObjectTypeMember('type', info, 'QType=
', False)
> > -        self._def_entity(
> > +        self._def_definition(
> >              QAPISchemaAlternateType(
> >                  name, info, expr.doc, ifcond, features,
> >                  QAPISchemaVariants(None, info, tag_member, variants)))
> > @@ -1185,11 +1209,10 @@ def _def_command(self, expr: QAPIExpression):
> >          if isinstance(rets, list):
> >              assert len(rets) =3D=3D 1
> >              rets =3D self._make_array_type(rets[0], info)
> > -        self._def_entity(QAPISchemaCommand(name, info, expr.doc, ifcon=
d,
> > -                                           features, data, rets,
> > -                                           gen, success_response,
> > -                                           boxed, allow_oob, allow_pre=
config,
> > -                                           coroutine))
> > +        self._def_definition(
> > +            QAPISchemaCommand(name, info, expr.doc, ifcond, features, =
data,
> > +                              rets, gen, success_response, boxed, allo=
w_oob,
> > +                              allow_preconfig, coroutine))
> >
> >      def _def_event(self, expr: QAPIExpression):
> >          name =3D expr['event']
> > @@ -1202,8 +1225,8 @@ def _def_event(self, expr: QAPIExpression):
> >              data =3D self._make_implicit_object_type(
> >                  name, info, ifcond,
> >                  'arg', self._make_members(data, info))
> > -        self._def_entity(QAPISchemaEvent(name, info, expr.doc, ifcond,
> > -                                         features, data, boxed))
> > +        self._def_definition(QAPISchemaEvent(name, info, expr.doc, ifc=
ond,
> > +                                             features, data, boxed))
> >
> >      def _def_exprs(self, exprs):
> >          for expr in exprs:
>
> Slightly more code, but with slightly fewer conditionals.  Feels a bit
> cleaner.
>

Probably a few more asserts and things that can come out, too. It's
nicer for static types at the expense of more OO boilerplate.


