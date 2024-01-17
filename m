Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88683012A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:19:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ18y-00046v-5H; Wed, 17 Jan 2024 03:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQ18o-00043K-FF
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:19:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQ18l-0005Wk-HJ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705479554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYeI0te+vX9aMJ5jhMX094rk6uxTqUe9ErsZAgtJRTA=;
 b=i9CMm4EawzTrqEaXSrouM/KIOEFF496s/+LbPPuHn2Rm4CPp5kvQS1QvgqpKJmOD/ZeVYS
 l1010X46ICcID3dUDt8zb0099f5ufUKiPxFOLRG9zNZG/SC2Cb6ZhlZUPjfbeCjaIT9Qr7
 92kJxzS8tgPsW9NL+AhO6LpK7B15Jug=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-ADtu75sOPEy0zgrgdpqj6w-1; Wed,
 17 Jan 2024 03:19:12 -0500
X-MC-Unique: ADtu75sOPEy0zgrgdpqj6w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14AAD3C0F663;
 Wed, 17 Jan 2024 08:19:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB4AA492BC7;
 Wed, 17 Jan 2024 08:19:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 751B921E6806; Wed, 17 Jan 2024 09:19:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 13/19] qapi/schema: fix typing for
 QAPISchemaVariants.tag_member
In-Reply-To: <CAFn=p-ZsQnwMtDEN70UdTz75bN6FgzxPbM0yNicOoULpPtV97A@mail.gmail.com>
 (John Snow's message of "Wed, 10 Jan 2024 03:35:51 -0500")
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-14-jsnow@redhat.com>
 <87zfz5c28s.fsf@pond.sub.org>
 <CAFn=p-bZPJNU9uLBOW1Uqts7kX-+9+dvSNRxwf+VD5hoCHJq9A@mail.gmail.com>
 <CAFn=p-bky_eAv9Z2V0zQ-_J7EygvYANa4UnxLTB9omMN-AbvbA@mail.gmail.com>
 <87bk9tfwvb.fsf@pond.sub.org>
 <CAFn=p-ZsQnwMtDEN70UdTz75bN6FgzxPbM0yNicOoULpPtV97A@mail.gmail.com>
Date: Wed, 17 Jan 2024 09:19:04 +0100
Message-ID: <87le8onzif.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

> On Wed, Jan 10, 2024 at 2:53=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Wed, Nov 22, 2023 at 11:02=E2=80=AFAM John Snow <jsnow@redhat.com> =
wrote:
>> >>
>> >> On Wed, Nov 22, 2023 at 9:05=E2=80=AFAM Markus Armbruster <armbru@red=
hat.com> wrote:
>> >> >
>> >> > John Snow <jsnow@redhat.com> writes:
>> >> >
>> >> > > There are two related changes here:
>> >> > >
>> >> > > (1) We need to perform type narrowing for resolving the type of
>> >> > >     tag_member during check(), and
>> >> > >
>> >> > > (2) tag_member is a delayed initialization field, but we can hide=
 it
>> >> > >     behind a property that raises an Exception if it's called too
>> >> > >     early. This simplifies the typing in quite a few places and a=
voids
>> >> > >     needing to assert that the "tag_member is not None" at a dozen
>> >> > >     callsites, which can be confusing and suggest the wrong thing=
 to a
>> >> > >     drive-by contributor.
>> >> > >
>> >> > > Signed-off-by: John Snow <jsnow@redhat.com>
>> >> >
>> >> > Without looking closely: review of PATCH 10 applies, doesn't it?
>> >> >
>> >>
>> >> Yep!
>> >
>> > Hm, actually, maybe not quite as cleanly.
>> >
>> > The problem is we *are* initializing that field immediately with
>> > whatever we were passed in during __init__, which means the field is
>> > indeed Optional. Later, during check(), we happen to eliminate that
>> > usage of None.
>>
>> You're right.
>>
>> QAPISchemaVariants.__init__() takes @tag_name and @tag_member.  Exactly
>> one of them must be None.  When creating a union's QAPISchemaVariants,
>> it's tag_member, and when creating an alternate's, it's tag_name.
>>
>> Why?
>>
>> A union's tag is an ordinary member selected by name via
>> 'discriminator': TAG_NAME.  We can't resolve the name at this time,
>> because it may be buried arbitrarily deep in the base type chain.
>>
>> An alternate's tag is an implicitly created "member" of type 'QType'.
>> "Member" in scare-quotes, because is special: it exists in C, but not on
>> the wire, and not in introspection.
>>
>> Historical note: simple unions also had an implictly created tag member,
>> and its type was the implicit enum type enumerating the branches.
>>
>> So _def_union_type() passes TAG_NAME to .__init__(), and
>> _def_alternate_type() creates and passes the implicit tag member.
>> Hardly elegant, but it works.
>>
>> > To remove the use of the @property trick here, we could:
>> >
>> > ... declare the field, then only initialize it if we were passed a
>> > non-None value. But then check() would need to rely on something like
>> > hasattr to check if it was set or not, which is maybe an unfortunate
>> > code smell.
>> > So I think you'd still wind up needing a ._tag_member field which is
>> > Optional and always gets set during __init__, then setting a proper
>> > .tag_member field during check().
>> >
>> > Or I could just leave this one as-is. Or something else. I think the
>> > dirt has to get swept somewhere, because we don't *always* have enough
>> > information to fully initialize it at __init__ time, it's a
>> > conditional delayed initialization, unlike the others which are
>> > unconditionally delayed.
>>
>> Yes.
>>
>> Here's a possible "something else":
>>
>> 1. Drop parameter .__init__() parameter @tag_member, and leave
>> .tag_member unset there.
>>
>> 2. Set .tag_member in .check(): if .tag_name, look up that member (no
>> change).  Else, it's an alternate; create the alternate's implicit tag
>> member.
>>
>> Drawback: before, we create AST in just one place, namely
>> QAPISchema._def_exprs().  Now we also create some in .check().
>
> I suppose I don't have a concrete argument against this beyond "It
> doesn't seem prettier than using the @property getter."
>
>>
>> Here's another "something else":
>>
>> 1. Fuse parameters .__init__() @tag_member and @tag_name.  The type
>> becomes Union.  Store for .check().
>>
>> 2. Set .tag_member in .check(): if we stored a name, look up that
>> member, else we must have stored an implicit member, so use that.
>>
>> 3. We check "is this a union?" like if self._tag_name.  Needs
>> adjustment.
>>
>> Feels a bit awkward to me.
>
> Yeah, a little. Mechanically simple, though, I think.
>
>> We can also do nothing, as you said.  We don't *have* to express
>> ".check() resolves unresolved tag member" in the type system.  We can
>> just live with .tag_member remaining Optional.
>
> This is the only option I'm sure I don't want - it's misleading to
> users of the API for the purposes of new generators using a fully
> realized schema object. I think it's important to remove Optional[]
> where possible to avoid the question "When will this be set to None?"
> if the answer is just "For your purposes, never."
>
> It's an implementation detail of object initialization leaking out.
>
> (Also, I just counted and leaving the field as Optional adds 22 new
> type errors; that's a lot of callsites to bandage with new conditions.
> nah.)
>
> The *other* way to not do anything is to just leave the @property
> solution in O:-)
>
>>
>> Differently awkward, I guess.
>>
>> Thoughts?
>
> Partial to the getter, unless option 1 or 2 leads to simplification of
> the check() code,

Put a pin into that.

>                   which I haven't really experimented with. If that's
> something you'd really rather avoid, I might ask for you to decide on
> your preferred alternative - I don't have strong feelings between 'em.

All the solutions so far give me slight "there has to be a better way"
vibes.  Staring at QAPISchemaVariants, I realized: more than half of the
actual code are under "if union / else" conditionals.  So I tried the
more object-oriented solution: classes instead of conditionals.  Diff
appended.

Shedding the conditionals does lead to slightly simple .check(), so
maybe you like it.

Once this is done, we can narrow .tag_member's type from
Optional[QAPISchemaObjectTypeMember] to QAPISchemaObjectTypeMember the
exact same way as QAPISchemaObjectTypeMember.type: replace
self.tag_member =3D None by self.tag_member: QAPISchemaObjectTypeMember.

Admittedly a bit more churn that your solution, but the result has
slightly less code, and feels slitghly cleaner to me.  Thoughts?

> (Not helpful, oops. Thanks for your feedback and review, though.
> You've successfully talked me down to a much smaller series over time
> :p)


diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index c38df61a6d..e5cea8004e 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -26,6 +26,7 @@
 from .gen import QAPISchemaMonolithicCVisitor
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternatives,
     QAPISchemaArrayType,
     QAPISchemaBuiltinType,
     QAPISchemaEntity,
@@ -343,12 +344,12 @@ def visit_object_type_flat(self, name: str, info: Opt=
ional[QAPISourceInfo],
     def visit_alternate_type(self, name: str, info: Optional[QAPISourceInf=
o],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaVariants) -> None:
+                             alternatives: QAPISchemaAlternatives) -> None:
         self._gen_tree(
             name, 'alternate',
             {'members': [Annotated({'type': self._use_type(m.type)},
                                    m.ifcond)
-                         for m in variants.variants]},
+                         for m in alternatives.variants]},
             ifcond, features
         )
=20
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 0d9a70ab4c..949ee6bfd4 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -563,8 +563,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
=20
     def __init__(self, name, info, doc, ifcond, features, variants):
         super().__init__(name, info, doc, ifcond, features)
-        assert isinstance(variants, QAPISchemaVariants)
-        assert variants.tag_member
+        assert isinstance(variants, QAPISchemaAlternatives)
         variants.set_defined_in(name)
         variants.tag_member.set_defined_in(self.name)
         self.variants =3D variants
@@ -625,19 +624,12 @@ def visit(self, visitor):
             self.name, self.info, self.ifcond, self.features, self.variant=
s)
=20
=20
-class QAPISchemaVariants:
-    def __init__(self, tag_name, info, tag_member, variants):
-        # Unions pass tag_name but not tag_member.
-        # Alternates pass tag_member but not tag_name.
-        # After check(), tag_member is always set.
-        assert bool(tag_member) !=3D bool(tag_name)
-        assert (isinstance(tag_name, str) or
-                isinstance(tag_member, QAPISchemaObjectTypeMember))
+class QAPISchemaVariantsBase:
+    def __init__(self, info, variants):
         for v in variants:
             assert isinstance(v, QAPISchemaVariant)
-        self._tag_name =3D tag_name
         self.info =3D info
-        self.tag_member =3D tag_member
+        self.tag_member =3D None
         self.variants =3D variants
=20
     def set_defined_in(self, name):
@@ -645,48 +637,6 @@ def set_defined_in(self, name):
             v.set_defined_in(name)
=20
     def check(self, schema, seen):
-        if self._tag_name:      # union
-            self.tag_member =3D seen.get(c_name(self._tag_name))
-            base =3D "'base'"
-            # Pointing to the base type when not implicit would be
-            # nice, but we don't know it here
-            if not self.tag_member or self._tag_name !=3D self.tag_member.=
name:
-                raise QAPISemError(
-                    self.info,
-                    "discriminator '%s' is not a member of %s"
-                    % (self._tag_name, base))
-            # Here we do:
-            base_type =3D schema.resolve_type(self.tag_member.defined_in)
-            if not base_type.is_implicit():
-                base =3D "base type '%s'" % self.tag_member.defined_in
-            if not isinstance(self.tag_member.type, QAPISchemaEnumType):
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must be of enum type"
-                    % (self._tag_name, base))
-            if self.tag_member.optional:
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must not be optional"
-                    % (self._tag_name, base))
-            if self.tag_member.ifcond.is_present():
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must not be condition=
al"
-                    % (self._tag_name, base))
-        else:                   # alternate
-            assert isinstance(self.tag_member.type, QAPISchemaEnumType)
-            assert not self.tag_member.optional
-            assert not self.tag_member.ifcond.is_present()
-        if self._tag_name:      # union
-            # branches that are not explicitly covered get an empty type
-            cases =3D {v.name for v in self.variants}
-            for m in self.tag_member.type.members:
-                if m.name not in cases:
-                    v =3D QAPISchemaVariant(m.name, self.info,
-                                          'q_empty', m.ifcond)
-                    v.set_defined_in(self.tag_member.defined_in)
-                    self.variants.append(v)
         if not self.variants:
             raise QAPISemError(self.info, "union has no branches")
         for v in self.variants:
@@ -713,6 +663,65 @@ def check_clash(self, info, seen):
             v.type.check_clash(info, dict(seen))
=20
=20
+class QAPISchemaVariants(QAPISchemaVariantsBase):
+    def __init__(self, info, variants, tag_name):
+        assert isinstance(tag_name, str)
+        super().__init__(info, variants)
+        self._tag_name =3D tag_name
+
+    def check(self, schema, seen):
+        self.tag_member =3D seen.get(c_name(self._tag_name))
+        base =3D "'base'"
+        # Pointing to the base type when not implicit would be
+        # nice, but we don't know it here
+        if not self.tag_member or self._tag_name !=3D self.tag_member.name:
+            raise QAPISemError(
+                self.info,
+                "discriminator '%s' is not a member of %s"
+                % (self._tag_name, base))
+        # Here we do:
+        base_type =3D schema.resolve_type(self.tag_member.defined_in)
+        if not base_type.is_implicit():
+            base =3D "base type '%s'" % self.tag_member.defined_in
+        if not isinstance(self.tag_member.type, QAPISchemaEnumType):
+            raise QAPISemError(
+                self.info,
+                "discriminator member '%s' of %s must be of enum type"
+                % (self._tag_name, base))
+        if self.tag_member.optional:
+            raise QAPISemError(
+                self.info,
+                "discriminator member '%s' of %s must not be optional"
+                % (self._tag_name, base))
+        if self.tag_member.ifcond.is_present():
+            raise QAPISemError(
+                self.info,
+                "discriminator member '%s' of %s must not be conditional"
+                % (self._tag_name, base))
+        # branches that are not explicitly covered get an empty type
+        cases =3D {v.name for v in self.variants}
+        for m in self.tag_member.type.members:
+            if m.name not in cases:
+                v =3D QAPISchemaVariant(m.name, self.info,
+                                      'q_empty', m.ifcond)
+                v.set_defined_in(self.tag_member.defined_in)
+                self.variants.append(v)
+        super().check(schema, seen)
+
+
+class QAPISchemaAlternatives(QAPISchemaVariantsBase):
+    def __init__(self, info, variants, tag_member):
+        assert isinstance(tag_member, QAPISchemaObjectTypeMember)
+        super().__init__(info, variants)
+        self.tag_member =3D tag_member
+
+    def check(self, schema, seen):
+        assert isinstance(self.tag_member.type, QAPISchemaEnumType)
+        assert not self.tag_member.optional
+        assert not self.tag_member.ifcond.is_present()
+        super().check(schema, seen)
+
+
 class QAPISchemaMember:
     """ Represents object members, enum members and features """
     role =3D 'member'
@@ -1184,7 +1193,7 @@ def _def_union_type(self, expr: QAPIExpression):
             QAPISchemaObjectType(name, info, expr.doc, ifcond, features,
                                  base, members,
                                  QAPISchemaVariants(
-                                     tag_name, info, None, variants)))
+                                     info, variants, tag_name)))
=20
     def _def_alternate_type(self, expr: QAPIExpression):
         name =3D expr['alternate']
@@ -1202,7 +1211,7 @@ def _def_alternate_type(self, expr: QAPIExpression):
         self._def_definition(
             QAPISchemaAlternateType(
                 name, info, expr.doc, ifcond, features,
-                QAPISchemaVariants(None, info, tag_member, variants)))
+                QAPISchemaAlternatives(info, variants, tag_member)))
=20
     def _def_command(self, expr: QAPIExpression):
         name =3D expr['command']
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index c39d054d2c..05da30b855 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -23,6 +23,7 @@
 )
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternatives,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
     QAPISchemaIfCond,
@@ -369,11 +370,11 @@ def visit_alternate_type(self,
                              info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaVariants) -> None:
+                             alternatives: QAPISchemaAlternatives) -> None:
         with ifcontext(ifcond, self._genh):
             self._genh.preamble_add(gen_fwd_object_or_array(name))
         self._genh.add(gen_object(name, ifcond, None,
-                                  [variants.tag_member], variants))
+                                  [alternatives.tag_member], alternatives))
         with ifcontext(ifcond, self._genh, self._genc):
             self._gen_type_cleanup(name)
=20
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index c56ea4d724..725bfcef50 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -28,6 +28,7 @@
 )
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternatives,
     QAPISchemaEnumMember,
     QAPISchemaEnumType,
     QAPISchemaFeature,
@@ -222,7 +223,8 @@ def gen_visit_enum(name: str) -> str:
                  c_name=3Dc_name(name))
=20
=20
-def gen_visit_alternate(name: str, variants: QAPISchemaVariants) -> str:
+def gen_visit_alternate(name: str,
+                        alternatives: QAPISchemaAlternatives) -> str:
     ret =3D mcgen('''
=20
 bool visit_type_%(c_name)s(Visitor *v, const char *name,
@@ -244,7 +246,7 @@ def gen_visit_alternate(name: str, variants: QAPISchema=
Variants) -> str:
 ''',
                 c_name=3Dc_name(name))
=20
-    for var in variants.variants:
+    for var in alternatives.variants:
         ret +=3D var.ifcond.gen_if()
         ret +=3D mcgen('''
     case %(case)s:
@@ -414,10 +416,10 @@ def visit_alternate_type(self,
                              info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaVariants) -> None:
+                             alternatives: QAPISchemaAlternatives) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name))
-            self._genc.add(gen_visit_alternate(name, variants))
+            self._genc.add(gen_visit_alternate(name, alternatives))
=20
=20
 def gen_visit(schema: QAPISchema,


