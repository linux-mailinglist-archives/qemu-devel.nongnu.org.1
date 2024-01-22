Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B089D836422
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 14:13:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRu6N-0005Wt-CE; Mon, 22 Jan 2024 08:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rRu6K-0005WC-3B
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:12:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rRu6F-0002tj-3y
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705929145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWZa+Gacndacc0qSl430mLtCiiLGXVmn0l0963MOIfE=;
 b=EcU01gkbkfQWJGnY9caPQJwKr6XAr0rosBYyoYqtyTvpg4l5busJoSgxbYLWcwe467TUvE
 m89a8ZZ0PhlVbIkRmijeByyIRraOBz5yBUJ4TcblUTZ75jHWDQP7lMNNMMN6aGlTXjS8y/
 bE7PdVyqBHk7q3rGBSmGXqm2sGfFqJI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-kGhIp_AzM4CbZmomL4VeYA-1; Mon,
 22 Jan 2024 08:12:23 -0500
X-MC-Unique: kGhIp_AzM4CbZmomL4VeYA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BDA91C05AE1;
 Mon, 22 Jan 2024 13:12:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFDB8492BE2;
 Mon, 22 Jan 2024 13:12:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CCE2721E66DA; Mon, 22 Jan 2024 14:12:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 09/19] qapi/schema: allow resolve_type to be used for
 built-in types
In-Reply-To: <CAFn=p-YTYuRsSLPS7A46Esq-R-OZDPFNKo8QHc4caTRv-NmC_A@mail.gmail.com>
 (John Snow's message of "Wed, 17 Jan 2024 11:44:57 -0500")
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-10-jsnow@redhat.com>
 <87cyu15yc2.fsf@pond.sub.org>
 <CAFn=p-YTYuRsSLPS7A46Esq-R-OZDPFNKo8QHc4caTRv-NmC_A@mail.gmail.com>
Date: Mon, 22 Jan 2024 14:12:21 +0100
Message-ID: <87zfwxikay.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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

> On Tue, Jan 16, 2024 at 6:09=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > allow resolve_type to be used for both built-in and user-specified
>> > type definitions. In the event that the type cannot be resolved, assert
>> > that 'info' and 'what' were both provided in order to create a usable
>> > QAPISemError.
>> >
>> > In practice, 'info' will only be None for built-in definitions, which
>> > *should not fail* type lookup.
>> >
>> > As a convenience, allow the 'what' and 'info' parameters to be elided
>> > entirely so that it can be used as a can-not-fail version of
>> > lookup_type.
>>
>> The convenience remains unused until the next patch.  It should be added
>> there.
>
> Okie-ducky.
>
>>
>> > Note: there are only three callsites to resolve_type at present where
>> > "info" is perceived to be possibly None:
>> >
>> >     1) QAPISchemaArrayType.check()
>> >     2) QAPISchemaObjectTypeMember.check()
>> >     3) QAPISchemaEvent.check()
>> >
>> >     Of those three, only the first actually ever passes None;
>>
>> Yes.  More below.
>
> Scary...

I know...

>> >                                                               the othe=
r two
>> >     are limited by their base class initializers which accept info=3DN=
one, but
>>
>> They do?
>
> In the case of QAPISchemaObjectTypeMember, the parent class
> QAPISchemaMember allows initialization with info=3DNone. I can't fully
> trace all of the callsites, but one of them at least is in types.py:
>
>>     enum_members =3D members + [QAPISchemaEnumMember('_MAX', None)]

I see.

We may want to do the _MAX thingy differently.  Not now.

> which necessitates, for now, info-less QAPISchemaEnumMember, which
> necessitates info-less QAPISchemaMember. There are others, etc.

Overriding an inherited attribute of type Optional[T] so it's
non-optional T makes mypy unhappy?

>> >     neither actually use it in practice.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> Hmm.
>
> Scary.
>
>>
>> We look up types by name in two ways:
>>
>> 1. Failure is a semantic error
>>
>>    Use .resolve_type(), passing real @info and @what.
>>
>>    Users:
>>
>>    * QAPISchemaArrayType.check() resolving the element type
>>
>>      Fine print: when the array type is built-in, we pass None @info and
>>      @what.  The built-in array type's element type must exist for
>>      .resolve_type() to work.  This commit changes .resolve_type() to
>>      assert it does.
>>
>>    * QAPISchemaObjectType.check() resolving the base type
>>
>>    * QAPISchemaObjectTypeMember.check() resolving the member type
>>
>>    * QAPISchemaCommand.check() resolving argument type (if named) and
>>      return type (which is always named).
>>
>>    * QAPISchemaEvent.check() resolving argument type (if named).
>>
>>    Note all users are in .check() methods.  That's where type named get
>>    resolved.
>>
>> 2. Handle failure
>>
>>    Use .lookup_type(), which returns None when the named type doesn't
>>    exist.
>>
>>    Users:
>>
>>    * QAPISchemaVariants.check(), to look up the base type containing the
>>      tag member for error reporting purposes.  Failure would be a
>>      programming error.
>>
>>    * .resolve_type(), which handles failure as semantic error
>>
>>    * ._make_array_type(), which uses it as "type exists already"
>>       predicate.
>>
>>    * QAPISchemaGenIntrospectVisitor._use_type(), to look up certain
>>      built-in types.  Failure would be a programming error.
>>
>> The next commit switches the uses where failure would be a programming
>> error from .lookup_type() to .resolve_type() without @info and @what, so
>> failure trips its assertion.  I don't like it, because it overloads
>> .resolve_type() to serve two rather different use cases:
>>
>> 1. Failure is a semantic error; pass @info and @what
>>
>> 2. Failure is a programming error; don't pass @info and what
>>
>> The odd one out is of course QAPISchemaArrayType.check(), which wants to
>> use 1. for the user's types and 2. for built-in types.  Let's ignore it
>> for a second.
>
> "Let's ignore what motivated this patch" aww...

Just for a second, I swear!

>> I prefer to do 2. like typ =3D .lookup_type(); assert typ.  We can factor
>> this out into its own helper if that helps (pardon the pun).
>>
>> Back to QAPISchemaArrayType.check().  Its need to resolve built-in
>> element types, which have no info, necessitates .resolve_type() taking
>> Optional[QAPISourceInfo].  This might bother you.  It doesn't bother me,
>> unless it leads to mypy complications I can't see.
>
> Well, with this patch I allowed it to take Optional[QAPISourceInfo] -
> just keep in mind that QAPISemError *requires* an info object, even
> though the typing there is also Optional[QAPISourceInfo] ... It will
> assert that info is present in __str__.
>
> Actually, I'd love to change that too - and make it fully required -
> but since built-in types have no info, there's too many places I'd
> need to change to enforce this as a static type.
>
> Still.

Invariant: no error reports for built-in types.

Checked since forever by asserting info is not None, exploiting the fact
that info is None exactly for built-in types.

This makes info: Optional[QAPISourceInfo] by design.

Works.

Specializing it to just QAPISourceInfo moves the assertion check from
run time to compile time.  Might give a nice feeling, but I don't think
it's practical everywhere, and it doesn't really matter anyway.

Using a special value of QAPISourceInfo instead of None would also get
rid of the Optional, along with the potential of checking at compile
time.  Good trade *if* it simplifies the code.  See also the very end of
my reply.

>> We can simply leave it as is.  Adding the assertion to .resolve_type()
>> is fine.
>>
>> Ot we complicate QAPISchemaArrayType.check() to simplify
>> .resolve_type()'s typing, roughly like this:
>>
>>             if self.info:
>>                 self.element_type =3D schema.resolve_type(
>>                     self._element_type_name,
>>                     self.info, self.info.defn_meta)
>>             else:               # built-in type
>>                 self.element_type =3D schema.lookup_type(
>>                     self._element_type_name)
>>                 assert self.element_type
>>
>> Not sure it's worth the trouble.  Thoughts?
>
> I suppose it's your call, ultimately. This patch exists primarily to
> help in two places:
>
> (A) QAPISchemaArrayType.check(), as you've noticed, because it uses
> the same path for both built-in and user-defined types. This is the
> only place in the code where this occurs *at the moment*, but I can't
> predict the future.
>
> (B) Calls to lookup_type in introspect.py which look up built-in types
> and must-not-fail. It was cumbersome in the old patchset, but this one
> makes it simpler.
>
> I suppose at the moment, having the assert directly in resolve_type
> just means we get to use the same helper/pathway for both user-defined
> and built-in types, which matches the infrastructure we already have,
> which doesn't differentiate between the two. (By which I mean, all of
> the Schema classes are not split into built-in and user-defined types,
> so it is invisible to the type system.)

Yes.

> I could add conditional logic to the array check, and leave the
> lookup_type calls in introspect.py being a little cumbersome - my main
> concern with that solution is that I might be leaving a nasty
> booby-trap in the future if someone wants to add a new built-in type
> or something gets refactored to share more code pathways. Maybe that's
> not fully rational, but it's why I went the way I did.

In my mind, .resolve_type() is strictly for resolving types during
semantic analysis: look up a type by name, report an error if it doesn't
exist.

Before this patch:

(A) QAPISchemaArrayType.check() works.  The invariant check is buried
somewhat deep, in QAPISourceError.

(B) introspect.py works.  The invariant is not checked there.

(C) QAPISchemaVariants.check() works.  A rather losely related invariant
is checked there: the tag member's type exists.

This patch conflates two changes.

One, it adds an invariant check right to .resolve_type().  Impact:

    (A) Adds an invariant check closer to the surface.

    (B) Not touched.

    (C) Not touched.

No objection.

Two, it defaults .resolve_type()'s arguments to None.  Belongs to the
next patch.

The next patch overloads .resolve_type() to serve two use cases,
1. failure is a semantic error, and 2. failure is a programming error.
The first kind passes the arguments, the second doesn't.  Impact:

    (A) Not touched.

    (B) Adds invariant checking, in the callee.

    (C) Pushes the invariant checking into the callee.

I don't like overloading .resolve_type() this way.  Again: in my mind,
it's strictly for resolving the user's type names in semantic analysis.

If I drop this patch and the next one, mypy complains

    scripts/qapi/schema.py:1219: error: Argument 1 has incompatible type "Q=
APISourceInfo | None"; expected "QAPISourceInfo"  [arg-type]
    scripts/qapi/introspect.py:230: error: Incompatible types in assignment=
 (expression has type "QAPISchemaType | None", variable has type "QAPISchem=
aType")  [assignment]
    scripts/qapi/introspect.py:233: error: Incompatible types in assignment=
 (expression has type "QAPISchemaType | None", variable has type "QAPISchem=
aType")  [assignment]

Retaining the assertion added in this patch takes care of the first one.

To get rid of the two in introspect.py, we need to actually check the
invariant:

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 67c7d89aae..4679b1bc2c 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -227,10 +227,14 @@ def _use_type(self, typ: QAPISchemaType) -> str:
=20
         # Map the various integer types to plain int
         if typ.json_type() =3D=3D 'int':
-            typ =3D self._schema.lookup_type('int')
+            type_int =3D self._schema.lookup_type('int')
+            assert type_int
+            typ =3D type_int
         elif (isinstance(typ, QAPISchemaArrayType) and
               typ.element_type.json_type() =3D=3D 'int'):
-            typ =3D self._schema.lookup_type('intList')
+            type_intList =3D self._schema.lookup_type('intList')
+            assert type_intList
+            typ =3D type_intList
         # Add type to work queue if new
         if typ not in self._used_types:
             self._used_types.append(typ)

Straightforward enough, although with a bit of notational overhead.

We use t =3D .lookup_type(...); assert t in three places then.  Feel free
to factor it out into a new helper.

> (P.S. I still violently want to create an info object that represents
> built-in definitions so I can just get rid of all the
> Optional[QAPISourceInfo] types from everywhere. I know I tried to do
> it before and you vetoed it, but the desire lives on in my heart.)

Once everything is properly typed, the cost and benefit of such a change
should be more clearly visible.

For now, let's try to type what we have, unless what we have complicates
typing too much.

[...]


