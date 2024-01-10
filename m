Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA282A110
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:34:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNeKP-0001NI-Lh; Wed, 10 Jan 2024 14:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNeKN-0001Mu-Oc
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNeKK-0007r5-4H
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704915202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NjSQ5KLN0K0E082PvDvuAqjXvGu4//QU9m0R4zAiTs4=;
 b=LR9FRcCW+6yAgiS3eleMuWUqT+2FiX2/ZdKR3UEI4idp3IzmKpDToASDHBiPABwhsLXGIP
 hQ4gEW/8OqdB/wLzWWPIX9FKfFN5ofo48PM5T+QwstmLA9FOYkTJCZwAKT2tpftvyTxHIK
 J3ieXbYj5B9Phv5pgX5l1pHRQKQiO80=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-sWjs8zPaO9uouDy2dRtRxw-1; Wed, 10 Jan 2024 14:33:18 -0500
X-MC-Unique: sWjs8zPaO9uouDy2dRtRxw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cf1c5f68dcso782600a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704915197; x=1705519997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NjSQ5KLN0K0E082PvDvuAqjXvGu4//QU9m0R4zAiTs4=;
 b=op6eK+Dv/8qyVwL0nXK4pkOa53A2BqmKUezr0+fcgsPkJnwM7Qv13W0rSFKvAv9Xfb
 xw+I3l0Te+CXrsvv0VsPnyJdDfffSoCVpCqLyGn5c72PwrzkmGrbySsbZbDstT8XneE9
 PiQCt683oKbBJIyeCjWgyAwcoPDAXSSwkf7EweCW9a1Gc7dPnZULBCbGYD7s5YsMVUzi
 nAoekvL2qT+aFNT3Eak1UU1u1H5OviKyWjlEUzMYvK3J64gUXwCtyo/wWThdJ2+c9zwI
 AYVfN+q6cjQMs5zEV7Vpw6Cg0E/QhzooGuK6dKq3OtxFd3yfCfYgLOPMaXxWzRDbWCnl
 dOoQ==
X-Gm-Message-State: AOJu0Yzju3u1be/Pg5gyD08/juwdmVZqRWi6dgZWu10DFB/ftR8H/ciG
 /HP3ns6y2iPIwwTkw7P6r010jQCcYylrur4Tm1J8nCLsxKLOgdJR866cVyRVU96uMFHoGKHSity
 UKIncbmQpq0QHdkt1+ERuvSTL9zzieEUsAgifDQs=
X-Received: by 2002:a17:90a:df8b:b0:28b:b4d5:c3e9 with SMTP id
 p11-20020a17090adf8b00b0028bb4d5c3e9mr12537pjv.11.1704915197363; 
 Wed, 10 Jan 2024 11:33:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtpTUCM9fdwD3q38Ln8aCVd1keesAYP596lNuGqZ3P1AQNb8cWpD1Bl6cbHnQOV+4AytyZGduKrpkHWCdzD78=
X-Received: by 2002:a17:90a:df8b:b0:28b:b4d5:c3e9 with SMTP id
 p11-20020a17090adf8b00b0028bb4d5c3e9mr12527pjv.11.1704915197015; Wed, 10 Jan
 2024 11:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-12-jsnow@redhat.com>
 <874jhedjv0.fsf@pond.sub.org>
 <CAFn=p-YZAZtX1SKAs2mFpGL7XhFPvsr68ipFqv+E_ZM_wV_Kig@mail.gmail.com>
 <87wmu84o6a.fsf@pond.sub.org>
In-Reply-To: <87wmu84o6a.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 10 Jan 2024 14:33:05 -0500
Message-ID: <CAFn=p-aFOhQ8+96cRasYmnF64g1CH_bdH0LiUAa98rkV9cbZXA@mail.gmail.com>
Subject: Re: [PATCH 11/19] qapi/schema: fix QAPISchemaArrayType.check's call
 to resolve_type
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000b0d004060e9c8039"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000b0d004060e9c8039
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023, 8:03 AM Markus Armbruster <armbru@redhat.com> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Wed, Nov 22, 2023 at 7:59=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >>
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > There's more conditionals in here than we can reasonably pack into a
> >> > terse little statement, so break it apart into something more
> explicit.
> >> >
> >> > (When would a built-in array ever cause a QAPISemError? I don't know=
,
> >> > maybe never - but the type system wasn't happy all the same.)
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  scripts/qapi/schema.py | 11 +++++++++--
> >> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> >> > index 462acb2bb61..164d86c4064 100644
> >> > --- a/scripts/qapi/schema.py
> >> > +++ b/scripts/qapi/schema.py
> >> > @@ -384,9 +384,16 @@ def need_has_if_optional(self):
> >> >
> >> >      def check(self, schema):
> >> >          super().check(schema)
> >> > +
> >> > +        if self.info:
> >> > +            assert self.info.defn_meta  # guaranteed to be set by
> expr.py
> >> > +            what =3D self.info.defn_meta
> >> > +        else:
> >> > +            what =3D 'built-in array'
> >> > +
> >> >          self._element_type =3D schema.resolve_type(
> >> > -            self._element_type_name, self.info,
> >> > -            self.info and self.info.defn_meta)
> >> > +            self._element_type_name, self.info, what
> >> > +        )
> 0>> >          assert not isinstance(self.element_type,
> QAPISchemaArrayType)
> >> >
> >> >      def set_module(self, schema):
> >>
> >> What problem are you solving here?
> >>
> >
> > 1. "self.info and self.info.defn_meta" is the wrong type ifn't self.inf=
o
>
> self.info is Optional[QAPISourceInfo].
>
> When self.info, then self.info.defn_meta is is Optional[str].
>
> Naive me expects self.info and self.info.defn_meta to be Optional[str].
> Playing with mypy...  it seems to be Union[QAPISourceInfo, None, str].
> Type inference too weak.
>

I think my expectations match yours: "x and y" should return either x or y,
so the resulting type would naively be Union[X | Y], which would indeed be
Union[QAPISourceInfo | None | str], but:

If QAPISourceInfo is *false-y*, but not None, it'd be possible for the
expression to yield a QAPISourceInfo. mypy does not understand that
QAPISourceInfo can never be false-y.

(That I know of. Maybe there's a trick to annotate it. I like your solution
below better anyway, just curious about the exact nature of this
limitation.)


> > 2. self.info.defn_meta is *also* not guaranteed by static types
>
> Yes.  We know it's not None ("guaranteed to be set by expr.py"), but the
> type system doesn't.
>

Mmhmm.


> > ultimately: we need to assert self.info and self.info.defn_meta both;
> > but it's possible (?) that we don't have self.info in the case that
> > we're a built-in array, so I handle that.
>
> This bring us back to the question in your commit message: "When would a
> built-in array ever cause a QAPISemError?"  Short answer: never.
>

Right, okay. I just couldn't guarantee it statically. I knew this patch was
a little bananas, sorry for tossing you the stinkbomb.


> Long answer.  We're dealing with a *specific* QAPISemError here, namely
> .resolve_type()'s "uses unknown type".  If this happens for a built-in
> array, it's a programming error.
>
> Let's commit such an error to see what happens: stick
>
>         self._make_array_type('xxx', None)
>
> Dies like this:
>
>     Traceback (most recent call last):
>       File "/work/armbru/qemu/scripts/qapi/main.py", line 94, in main
>         generate(args.schema,
>       File "/work/armbru/qemu/scripts/qapi/main.py", line 50, in generate
>         schema =3D QAPISchema(schema_file)
>                  ^^^^^^^^^^^^^^^^^^^^^^^
>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 938, in
> __init__
>         self.check()
>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 1225, in chec=
k
>         ent.check(self)
>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 373, in check
>         self.element_type =3D schema.resolve_type(
>                             ^^^^^^^^^^^^^^^^^^^^
>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 973, in
> resolve_type
>         raise QAPISemError(
>     qapi.error.QAPISemError: <exception str() failed>
>
>     During handling of the above exception, another exception occurred:
>
>     Traceback (most recent call last):
>       File "/work/armbru/qemu/scripts/qapi-gen.py", line 19, in <module>
>         sys.exit(main.main())
>                  ^^^^^^^^^^^
>       File "/work/armbru/qemu/scripts/qapi/main.py", line 101, in main
>         print(err, file=3Dsys.stderr)
>       File "/work/armbru/qemu/scripts/qapi/error.py", line 41, in __str__
>         assert self.info is not None
>                ^^^^^^^^^^^^^^^^^^^^^
>     AssertionError
>
> Same before and after your patch.  The patch's change of what=3DNone to
> what=3D'built-in array' has no effect.
>
> Here's a slightly simpler patch:
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 46004689f0..feb0023d25 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -479,7 +479,7 @@ def check(self, schema: QAPISchema) -> None:
>          super().check(schema)
>          self._element_type =3D schema.resolve_type(
>              self._element_type_name, self.info,
> -            self.info and self.info.defn_meta)
> +            self.info.defn_meta if self.info else None)
>

Yep.

         assert not isinstance(self.element_type, QAPISchemaArrayType)
>
>      def set_module(self, schema: QAPISchema) -> None:
> @@ -1193,7 +1193,7 @@ def resolve_type(
>          self,
>          name: str,
>          info: Optional[QAPISourceInfo],
> -        what: Union[str, Callable[[Optional[QAPISourceInfo]], str]],
> +        what: Union[None, str, Callable[[Optional[QAPISourceInfo]], str]=
],
>      ) -> QAPISchemaType:
>          typ =3D self.lookup_type(name)
>          if not typ:
>
> The first hunk works around mypy's type inference weakness.  It rewrites
>
>     A and B
>
> as
>
>     B if A else A
>
> and then partially evaluates to
>
>     B if A else None
>
> exploiting the fact that falsy A can only be None.  It replaces this
> patch.
>

Sounds good to me!


> The second hunk corrects .resolve_type()'s typing to accept what=3DNone.
> It's meant to be squashed into PATCH 16.
>
> What do you think?
>

I'm on my mobile again, but at a glance I like it. Except that I'm a little
reluctant to allow what to be None if this is the *only* caller known to
possibly do it, and only in a circumstance that we assert elsewhere that it
should never happen.

Can we do:

what =3D self.info.defn_meta if self.info else None
assert what [is not None]  # Depending on taste

instead?

No sem error, no new unit test needed, assertion provides the correct frame
of mind (programmer error), stronger typing on resolve_type.

(I really love eliminating None when I can as a rule because I like how
much more it tells you about the nature of all callers, it's a much
stronger decree. Worth pursuing where you can, IMO, but I'm not gonna die
on the hill for a patch like this - just sharing my tendencies for
discussion.)

--js

>

--000000000000b0d004060e9c8039
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Nov 23, 2023, 8:03 AM Markus Armbruster &lt;<a=
 href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; write=
s:<br>
<br>
&gt; On Wed, Nov 22, 2023 at 7:59=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; There&#39;s more conditionals in here than we can reasonably =
pack into a<br>
&gt;&gt; &gt; terse little statement, so break it apart into something more=
 explicit.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; (When would a built-in array ever cause a QAPISemError? I don=
&#39;t know,<br>
&gt;&gt; &gt; maybe never - but the type system wasn&#39;t happy all the sa=
me.)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/schema.py | 11 +++++++++--<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 9 insertions(+), 2 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<=
br>
&gt;&gt; &gt; index 462acb2bb61..164d86c4064 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/schema.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/schema.py<br>
&gt;&gt; &gt; @@ -384,9 +384,16 @@ def need_has_if_optional(self):<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def check(self, schema):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://self.info" =
rel=3D"noreferrer noreferrer" target=3D"_blank">self.info</a>:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.info.d=
efn_meta=C2=A0 # guaranteed to be set by expr.py<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 what =3D self.info=
.defn_meta<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 what =3D &#39;buil=
t-in array&#39;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._element_type =3D sche=
ma.resolve_type(<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._element_type=
_name, <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D=
"_blank">self.info</a>,<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://=
self.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.info</a> an=
d self.info.defn_meta)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._element_type=
_name, <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D=
"_blank">self.info</a>, what<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
0&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert not isinstance(self=
.element_type, QAPISchemaArrayType)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def set_module(self, schema):<br>
&gt;&gt;<br>
&gt;&gt; What problem are you solving here?<br>
&gt;&gt;<br>
&gt;<br>
&gt; 1. &quot;<a href=3D"http://self.info" rel=3D"noreferrer noreferrer" ta=
rget=3D"_blank">self.info</a> and self.info.defn_meta&quot; is the wrong ty=
pe ifn&#39;t <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">self.info</a><br>
<br>
<a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_blank=
">self.info</a> is Optional[QAPISourceInfo].<br>
<br>
When <a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_=
blank">self.info</a>, then self.info.defn_meta is is Optional[str].<br>
<br>
Naive me expects <a href=3D"http://self.info" rel=3D"noreferrer noreferrer"=
 target=3D"_blank">self.info</a> and self.info.defn_meta to be Optional[str=
].<br>
Playing with mypy...=C2=A0 it seems to be Union[QAPISourceInfo, None, str].=
<br>
Type inference too weak.<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">I think my expectations match yours: &quot;x and y&=
quot; should return either x or y, so the resulting type would naively be U=
nion[X | Y], which would indeed be Union[QAPISourceInfo | None | str], but:=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">If QAPISourceInfo is *f=
alse-y*, but not None, it&#39;d be possible for the expression to yield a Q=
APISourceInfo. mypy does not understand that QAPISourceInfo can never be fa=
lse-y.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(That I know of. =
Maybe there&#39;s a trick to annotate it. I like your solution below better=
 anyway, just curious about the exact nature of this limitation.)</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
&gt; 2. self.info.defn_meta is *also* not guaranteed by static types<br>
<br>
Yes.=C2=A0 We know it&#39;s not None (&quot;guaranteed to be set by expr.py=
&quot;), but the<br>
type system doesn&#39;t.<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Mmhmm.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; ultimately: we need to assert <a href=3D"http://self.info" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">self.info</a> and self.info.defn_meta =
both;<br>
&gt; but it&#39;s possible (?) that we don&#39;t have <a href=3D"http://sel=
f.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.info</a> in th=
e case that<br>
&gt; we&#39;re a built-in array, so I handle that.<br>
<br>
This bring us back to the question in your commit message: &quot;When would=
 a<br>
built-in array ever cause a QAPISemError?&quot;=C2=A0 Short answer: never.<=
br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">R=
ight, okay. I just couldn&#39;t guarantee it statically. I knew this patch =
was a little bananas, sorry for tossing you the stinkbomb.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
Long answer.=C2=A0 We&#39;re dealing with a *specific* QAPISemError here, n=
amely<br>
.resolve_type()&#39;s &quot;uses unknown type&quot;.=C2=A0 If this happens =
for a built-in<br>
array, it&#39;s a programming error.<br>
<br>
Let&#39;s commit such an error to see what happens: stick<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._make_array_type(&#39;xxx&#39;, None)<br>
<br>
Dies like this:<br>
<br>
=C2=A0 =C2=A0 Traceback (most recent call last):<br>
=C2=A0 =C2=A0 =C2=A0 File &quot;/work/armbru/qemu/scripts/qapi/main.py&quot=
;, line 94, in main<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 generate(args.schema,<br>
=C2=A0 =C2=A0 =C2=A0 File &quot;/work/armbru/qemu/scripts/qapi/main.py&quot=
;, line 50, in generate<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 schema =3D QAPISchema(schema_file)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^=
^^^^^^^^^^<br>
=C2=A0 =C2=A0 =C2=A0 File &quot;/work/armbru/qemu/scripts/qapi/schema.py&qu=
ot;, line 938, in __init__<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check()<br>
=C2=A0 =C2=A0 =C2=A0 File &quot;/work/armbru/qemu/scripts/qapi/schema.py&qu=
ot;, line 1225, in check<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ent.check(self)<br>
=C2=A0 =C2=A0 =C2=A0 File &quot;/work/armbru/qemu/scripts/qapi/schema.py&qu=
ot;, line 373, in check<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.element_type =3D schema.resolve_type(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^^^^^<br>
=C2=A0 =C2=A0 =C2=A0 File &quot;/work/armbru/qemu/scripts/qapi/schema.py&qu=
ot;, line 973, in resolve_type<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISemError(<br>
=C2=A0 =C2=A0 qapi.error.QAPISemError: &lt;exception str() failed&gt;<br>
<br>
=C2=A0 =C2=A0 During handling of the above exception, another exception occ=
urred:<br>
<br>
=C2=A0 =C2=A0 Traceback (most recent call last):<br>
=C2=A0 =C2=A0 =C2=A0 File &quot;/work/armbru/qemu/scripts/qapi-gen.py&quot;=
, line 19, in &lt;module&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(main.main())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^<b=
r>
=C2=A0 =C2=A0 =C2=A0 File &quot;/work/armbru/qemu/scripts/qapi/main.py&quot=
;, line 101, in main<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(err, file=3Dsys.stderr)<br>
=C2=A0 =C2=A0 =C2=A0 File &quot;/work/armbru/qemu/scripts/qapi/error.py&quo=
t;, line 41, in __str__<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert <a href=3D"http://self.info" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">self.info</a> is not None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^=
^<br>
=C2=A0 =C2=A0 AssertionError<br>
<br>
Same before and after your patch.=C2=A0 The patch&#39;s change of what=3DNo=
ne to<br>
what=3D&#39;built-in array&#39; has no effect.<br>
<br>
Here&#39;s a slightly simpler patch:<br>
<br>
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
index 46004689f0..feb0023d25 100644<br>
--- a/scripts/qapi/schema.py<br>
+++ b/scripts/qapi/schema.py<br>
@@ -479,7 +479,7 @@ def check(self, schema: QAPISchema) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().check(schema)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._element_type =3D schema.resolve_typ=
e(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._element_type_name, <a=
 href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_blank">=
self.info</a>,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=
=3D"noreferrer noreferrer" target=3D"_blank">self.info</a> and self.info.de=
fn_meta)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.info.defn_meta if <a href=
=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.=
info</a> else None)<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Yep.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert not isinstance(self.element_type, =
QAPISchemaArrayType)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def set_module(self, schema: QAPISchema) -&gt; None:<br=
>
@@ -1193,7 +1193,7 @@ def resolve_type(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name: str,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info: Optional[QAPISourceInfo],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 what: Union[str, Callable[[Optional[QAPISource=
Info]], str]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 what: Union[None, str, Callable[[Optional[QAPI=
SourceInfo]], str]],<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; QAPISchemaType:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0typ =3D self.lookup_type(name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not typ:<br>
<br>
The first hunk works around mypy&#39;s type inference weakness.=C2=A0 It re=
writes<br>
<br>
=C2=A0 =C2=A0 A and B<br>
<br>
as<br>
<br>
=C2=A0 =C2=A0 B if A else A<br>
<br>
and then partially evaluates to<br>
<br>
=C2=A0 =C2=A0 B if A else None<br>
<br>
exploiting the fact that falsy A can only be None.=C2=A0 It replaces this<b=
r>
patch.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Sounds good to me!</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
The second hunk corrects .resolve_type()&#39;s typing to accept what=3DNone=
.<br>
It&#39;s meant to be squashed into PATCH 16.<br>
<br>
What do you think?<br></blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">I&#39;m on my mobile again, but at a glance I like it. Ex=
cept that I&#39;m a little reluctant to allow what to be None if this is th=
e *only* caller known to possibly do it, and only in a circumstance that we=
 assert elsewhere that it should never happen.=C2=A0</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Can we do:</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">what =3D self.info.defn_meta if=C2=A0<a href=3D"http://self=
.info/">self.info</a>=C2=A0else None</div><div dir=3D"auto">assert what [is=
 not None]=C2=A0 # Depending on taste</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">instead?</div><div dir=3D"auto"><br></div><div dir=3D"auto">N=
o sem error, no new unit test needed, assertion provides the correct frame =
of mind (programmer error), stronger typing on resolve_type.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">(I really love eliminating None when =
I can as a rule because I like how much more it tells you about the nature =
of all callers, it&#39;s a much stronger decree. Worth pursuing where you c=
an, IMO, but I&#39;m not gonna die on the hill for a patch like this - just=
 sharing my tendencies for discussion.)</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">--js</div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000b0d004060e9c8039--


