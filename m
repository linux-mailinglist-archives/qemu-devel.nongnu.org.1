Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9283B830B62
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:45:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ92n-00047C-Fx; Wed, 17 Jan 2024 11:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rQ92W-00042n-FB
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:45:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rQ92U-0000rS-7f
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705509917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kK5abgZWOsFzhybew+mWrMC9rUgDmiXZdbrMlPHIRPA=;
 b=KXfNh19NTehWcv1I6ioaiyDuAtNj2wzvspD8sePgTKUNPsK39hyI7mmCm6n0GO/7k4IPgH
 3r7axxHnAs5Khv6gQzWN9NET9SCSvlTOa/xDZT7VkenATo1KBORK4TRRuxNxpzY96D7RU5
 vNd3tBXMm6utWJzIUuam7aQ0gdJWakA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-98aJcQJLO2ydmiuKv27scQ-1; Wed, 17 Jan 2024 11:45:10 -0500
X-MC-Unique: 98aJcQJLO2ydmiuKv27scQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28c5c622a3cso7642630a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 08:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705509909; x=1706114709;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kK5abgZWOsFzhybew+mWrMC9rUgDmiXZdbrMlPHIRPA=;
 b=A8WFBs2i38tSU6cwl3xOCZDTMe2CdtzC55ip6ox7y9KvIzM8RLepXFE2Xexu7Ll/bT
 6HOVAJs7NI/iPLlzVGTzwXuxbSf7DkcWNKgkOBsFzvWV+Y0nY6x9Sp08aK/oPhsqWNi2
 Tm5zt5LVcoHyMfpMR6ahKiQ+hg0upfWr8IAkBM/6NKwCdM15irY0X4Amqv5WEOCMVK9C
 aQ6G1YRtjMxiPPUoTFO9V4/tO1UCPYOG1DhigEVncIHBUGMJi8LMWEEVZ8B0DUagKDOB
 JnEtqaWVHasl7Ev/CFfxtR5gQArDKAxyIFQop+5+CRLm/Ttm9yGzIuk/Uk2aRGUH1ptd
 Yk6w==
X-Gm-Message-State: AOJu0YxqeozPJ2lYSWRL5xhFl4WcMQJ4IHAB2cTdti2WHVbeCM5SrRMG
 PeUjNhlRSmQF5whMck8R/oBtxluQZSnMTWZtRSAyJaSz/Gf7lyCtqa66fBTZLr1OYvEzyYl2q/8
 9KRMmj+f6SRpDxt34EdSsCPPMAAl0jW2H4rdgQok=
X-Received: by 2002:a17:90b:110e:b0:28f:ef6c:7608 with SMTP id
 gi14-20020a17090b110e00b0028fef6c7608mr1258191pjb.51.1705509908791; 
 Wed, 17 Jan 2024 08:45:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8BzXmoVKAsoGXKEzin+8JQ12NLk2vMcVdii0hz0yZ8NyG/SpBnRnKAdg176HoAcWdIiAA/w0kdim5nZV/8Ys=
X-Received: by 2002:a17:90b:110e:b0:28f:ef6c:7608 with SMTP id
 gi14-20020a17090b110e00b0028fef6c7608mr1258178pjb.51.1705509908438; Wed, 17
 Jan 2024 08:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-10-jsnow@redhat.com>
 <87cyu15yc2.fsf@pond.sub.org>
In-Reply-To: <87cyu15yc2.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 Jan 2024 11:44:57 -0500
Message-ID: <CAFn=p-YTYuRsSLPS7A46Esq-R-OZDPFNKo8QHc4caTRv-NmC_A@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] qapi/schema: allow resolve_type to be used for
 built-in types
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

On Tue, Jan 16, 2024 at 6:09=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > allow resolve_type to be used for both built-in and user-specified
> > type definitions. In the event that the type cannot be resolved, assert
> > that 'info' and 'what' were both provided in order to create a usable
> > QAPISemError.
> >
> > In practice, 'info' will only be None for built-in definitions, which
> > *should not fail* type lookup.
> >
> > As a convenience, allow the 'what' and 'info' parameters to be elided
> > entirely so that it can be used as a can-not-fail version of
> > lookup_type.
>
> The convenience remains unused until the next patch.  It should be added
> there.

Okie-ducky.

>
> > Note: there are only three callsites to resolve_type at present where
> > "info" is perceived to be possibly None:
> >
> >     1) QAPISchemaArrayType.check()
> >     2) QAPISchemaObjectTypeMember.check()
> >     3) QAPISchemaEvent.check()
> >
> >     Of those three, only the first actually ever passes None;
>
> Yes.  More below.

Scary...

>
> >                                                               the other=
 two
> >     are limited by their base class initializers which accept info=3DNo=
ne, but
>
> They do?
>

In the case of QAPISchemaObjectTypeMember, the parent class
QAPISchemaMember allows initialization with info=3DNone. I can't fully
trace all of the callsites, but one of them at least is in types.py:

>     enum_members =3D members + [QAPISchemaEnumMember('_MAX', None)]

which necessitates, for now, info-less QAPISchemaEnumMember, which
necessitates info-less QAPISchemaMember. There are others, etc.

> >     neither actually use it in practice.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Hmm.

Scary.

>
> We look up types by name in two ways:
>
> 1. Failure is a semantic error
>
>    Use .resolve_type(), passing real @info and @what.
>
>    Users:
>
>    * QAPISchemaArrayType.check() resolving the element type
>
>      Fine print: when the array type is built-in, we pass None @info and
>      @what.  The built-in array type's element type must exist for
>      .resolve_type() to work.  This commit changes .resolve_type() to
>      assert it does.
>
>    * QAPISchemaObjectType.check() resolving the base type
>
>    * QAPISchemaObjectTypeMember.check() resolving the member type
>
>    * QAPISchemaCommand.check() resolving argument type (if named) and
>      return type (which is always named).
>
>    * QAPISchemaEvent.check() resolving argument type (if named).
>
>    Note all users are in .check() methods.  That's where type named get
>    resolved.
>
> 2. Handle failure
>
>    Use .lookup_type(), which returns None when the named type doesn't
>    exist.
>
>    Users:
>
>    * QAPISchemaVariants.check(), to look up the base type containing the
>      tag member for error reporting purposes.  Failure would be a
>      programming error.
>
>    * .resolve_type(), which handles failure as semantic error
>
>    * ._make_array_type(), which uses it as "type exists already"
>       predicate.
>
>    * QAPISchemaGenIntrospectVisitor._use_type(), to look up certain
>      built-in types.  Failure would be a programming error.
>
> The next commit switches the uses where failure would be a programming
> error from .lookup_type() to .resolve_type() without @info and @what, so
> failure trips its assertion.  I don't like it, because it overloads
> .resolve_type() to serve two rather different use cases:
>
> 1. Failure is a semantic error; pass @info and @what
>
> 2. Failure is a programming error; don't pass @info and what
>
> The odd one out is of course QAPISchemaArrayType.check(), which wants to
> use 1. for the user's types and 2. for built-in types.  Let's ignore it
> for a second.

"Let's ignore what motivated this patch" aww...

>
> I prefer to do 2. like typ =3D .lookup_type(); assert typ.  We can factor
> this out into its own helper if that helps (pardon the pun).
>
> Back to QAPISchemaArrayType.check().  Its need to resolve built-in
> element types, which have no info, necessitates .resolve_type() taking
> Optional[QAPISourceInfo].  This might bother you.  It doesn't bother me,
> unless it leads to mypy complications I can't see.

Well, with this patch I allowed it to take Optional[QAPISourceInfo] -
just keep in mind that QAPISemError *requires* an info object, even
though the typing there is also Optional[QAPISourceInfo] ... It will
assert that info is present in __str__.

Actually, I'd love to change that too - and make it fully required -
but since built-in types have no info, there's too many places I'd
need to change to enforce this as a static type.

Still.

>
> We can simply leave it as is.  Adding the assertion to .resolve_type()
> is fine.
>
> Ot we complicate QAPISchemaArrayType.check() to simplify
> .resolve_type()'s typing, roughly like this:
>
>             if self.info:
>                 self.element_type =3D schema.resolve_type(
>                     self._element_type_name,
>                     self.info, self.info.defn_meta)
>             else:               # built-in type
>                 self.element_type =3D schema.lookup_type(
>                     self._element_type_name)
>                 assert self.element_type
>
> Not sure it's worth the trouble.  Thoughts?

I suppose it's your call, ultimately. This patch exists primarily to
help in two places:

(A) QAPISchemaArrayType.check(), as you've noticed, because it uses
the same path for both built-in and user-defined types. This is the
only place in the code where this occurs *at the moment*, but I can't
predict the future.

(B) Calls to lookup_type in introspect.py which look up built-in types
and must-not-fail. It was cumbersome in the old patchset, but this one
makes it simpler.

I suppose at the moment, having the assert directly in resolve_type
just means we get to use the same helper/pathway for both user-defined
and built-in types, which matches the infrastructure we already have,
which doesn't differentiate between the two. (By which I mean, all of
the Schema classes are not split into built-in and user-defined types,
so it is invisible to the type system.)

I could add conditional logic to the array check, and leave the
lookup_type calls in introspect.py being a little cumbersome - my main
concern with that solution is that I might be leaving a nasty
booby-trap in the future if someone wants to add a new built-in type
or something gets refactored to share more code pathways. Maybe that's
not fully rational, but it's why I went the way I did.

(P.S. I still violently want to create an info object that represents
built-in definitions so I can just get rid of all the
Optional[QAPISourceInfo] types from everywhere. I know I tried to do
it before and you vetoed it, but the desire lives on in my heart.)

>
> > ---
> >  scripts/qapi/schema.py | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 66a78f28fd4..a77b51d1b96 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -1001,9 +1001,10 @@ def lookup_type(self, name):
> >          assert typ is None or isinstance(typ, QAPISchemaType)
> >          return typ
> >
> > -    def resolve_type(self, name, info, what):
> > +    def resolve_type(self, name, info=3DNone, what=3DNone):
> >          typ =3D self.lookup_type(name)
> >          if not typ:
> > +            assert info and what  # built-in types must not fail looku=
p
> >              if callable(what):
> >                  what =3D what(info)
> >              raise QAPISemError(
>


