Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8196182A22E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 21:22:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNf4o-0000aA-C3; Wed, 10 Jan 2024 15:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNf4l-0000Zy-VQ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 15:21:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNf4i-00072p-74
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 15:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704918078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBN0wKdF7H3wM6KygriLil2IQG3KmDkeHMb93ZHcOoI=;
 b=LuLo8zY4HmCNBOASIX1GE1GhM9w5R+BEDUYcJwEUqJ3aAhCAcK2WYhCnBJzPOeJRsemZZ/
 8Co4QBwVUVPfa3w5zpZdMbr8uGada6wF/qANV2bINEF/pYQOY+BSAQ1vd+K3N/zIBy3eHe
 7fIt4WBbo3ye4SEcgiMtWK7Xi/0QAcE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-IzwQ5c1dOPyobwuOx4lmQA-1; Wed, 10 Jan 2024 15:21:16 -0500
X-MC-Unique: IzwQ5c1dOPyobwuOx4lmQA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28b6d5de7f8so2156941a91.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 12:21:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704918075; x=1705522875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CBN0wKdF7H3wM6KygriLil2IQG3KmDkeHMb93ZHcOoI=;
 b=HrYiOOedKPHTuGd5p6x7RqN0ce5cTCMWqmzkndJSjO9ubwYl7NNE9l9tblw/X95k2/
 Nw6eHpxYQ7E6DLySSl/3SzvbHd06oxOFRM4V82O74vqb7RATFsI8Hy8TOyQZVGh4Pjuw
 4gy8/Gz2c0fTlYjbZaR0kT5efokyNuqKCwx92gdZNFJA4eCWDTqGX2cFWivGL+faWTVZ
 VYI/InJSoGFL8Tv7/dyuoZcCYs/mRxV47uL2HJMY3NmOSeNROWK/Z7eL7SuWg3NgPafL
 ntapPzwxsvgaGbFQvlDG4f8fTqMTj9Mq5jw+19oPH31yASE8e/wvpBEHj6ryjplkbJ6G
 rJ1w==
X-Gm-Message-State: AOJu0YxONAHQHJRnEu2xPBSgpuo1K5G8zqBEH2jVaPV++T0j2d/tT10u
 ljNB+Bm1ENfZ3qf+QP5ecl79yeXkT1VG+awRnwF0dvyayrChz78U/nbi0JtuOqJUzlPRBOrrRah
 gxVVNH8bOK7gTO830jHTvQrbUSZHY/uZ4DkgGX/E=
X-Received: by 2002:a17:90a:8b94:b0:28d:2757:6dd2 with SMTP id
 z20-20020a17090a8b9400b0028d27576dd2mr71339pjn.53.1704918075319; 
 Wed, 10 Jan 2024 12:21:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq20BD+n9/vxRMTxIiCE8JqZFRjM17LNsqCrLQ32iqSW1BBFPT0Sf9pQDWQ+xexzjR5f7MGlcVwVbUMHOGjI4=
X-Received: by 2002:a17:90a:8b94:b0:28d:2757:6dd2 with SMTP id
 z20-20020a17090a8b9400b0028d27576dd2mr71330pjn.53.1704918074918; Wed, 10 Jan
 2024 12:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-13-jsnow@redhat.com>
 <874jhddgxt.fsf@pond.sub.org>
In-Reply-To: <874jhddgxt.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 10 Jan 2024 15:21:03 -0500
Message-ID: <CAFn=p-bvAcej5vgc4N=WtTrQ1B0dUP5SDy6nhs4eADhQATbxRA@mail.gmail.com>
Subject: Re: [PATCH 12/19] qapi/schema: split "checked" field into "checking"
 and "checked"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000003a2343060e9d2c86"
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

--0000000000003a2343060e9d2c86
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 22, 2023, 9:02 AM Markus Armbruster <armbru@redhat.com> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Differentiate between "actively in the process of checking" and
> > "checking has completed". This allows us to clean up the types of some
> > internal fields such as QAPISchemaObjectType's members field which
> > currently uses "None" as a canary for determining if check has
> > completed.
>
> Certain members become valid only after .check().  Two ways to code
> that:
>
> 1. Assign to such members only in .check().  If you try to use them
> before .check(), AttributeError.  Nice.  Drawback: pylint is unhappy,
> W0201 attribute-defined-outside-init.
>

Can be overcome by declaring the field in __init__, which satisfies both
the linter and my developer usability sense (Classes should be easy to have
their properties enumerated by looking in one well known place.)


> 2. Assign None in .__init__(), and the real value in .check().  If you
> try to use them before .check(), you get None, which hopefully leads to
> an error.  Meh, but pylint is happy.
>
> I picked 2. because pylint's warning made me go "when in Rome..."
>

Yep, this is perfectly cromulent dynamically typed Python. It's not the
Roman's fault I'm packing us up to go to another empire.


> With type hints, we can declare in .__init__(), and assign in .check().
> Gives me the AttributeError I like, and pylint remains happy.  What do
> you think?
>

Sounds good to me in general, I already changed this for 2/3 of my other
uses of @property.

(I'm only reluctant because I don't really like that it's a "lie", but in
this case, without potentially significant rewrites, it's a reasonable type
band-aid. Once we're type checked, we can refactor more confidently if we
so desire, to make certain patterns less prominent or landmine-y.)


> Splitting .checked feels like a separate change, though.  I can't quite
> see why we need it.  Help me out: what problem does it solve?
>

Mechanically, I wanted to eliminate the Optional type from the members
field, but you have conditionals in the code that use the presence or
absence of this field as a query to determine if we had run check or not
yet.

So I did the stupidest possible thing and added a "checked" variable to
explicitly represent it.


> > This simplifies the typing from a cumbersome Optional[List[T]] to merely
> > a List[T], which is more pythonic: it is safe to iterate over an empty
> > list with "for x in []" whereas with an Optional[List[T]] you have to
> > rely on the more cumbersome "if L: for x in L: ..."
>
> Yes, but when L is None, it's *invalid*, and for i in L *should* fail
> when L is invalid.
>

Sure, but it's so invalid that it causes static typing errors.

You can't write "for x in None" in a way that makes mypy happy, None is not
iterable.

If you want to preserve the behavior of "iterating an empty collection is
an Assertion", you need a custom iterator that throws an exception when the
collection is empty. I can do that, if you'd like, but I think it's
actually fine to just allow the collection to be empty and to just catch
the error in check() with either an assertion (oops, something went wrong
and the list is empty, this should never happen) or a QAPISemError (oops,
you didn't specify any members, which is illegal.)

I'd prefer to catch this in check and just allow the iterator to permit
empty iterators at the callsite, knowing it'll never happen.


> I think the actual problem is something else.  By adding the type hint
> Optional[List[T]], the valid uses of L become type errors.  We really
> want L to be a List[T].  Doesn't mean we have to (or want to) make uses
> of invalid L "work".
>

I didn't think I did allow for invalid uses to work - if the list should
semantically never be empty, I think it's fine to enforce that in schema.py
during construction of the schema object and to assume all uses of "for x
in L: ..." are inherently valid.


> > RFC: are we guaranteed to have members here? can we just use "if
> > members" without adding the new field?
>
> I'm afraid I don't understand these questions.
>

I think you answered this one for me; I was asking if it was ever valid in
any circumstance to have an empty members list, but I think you've laid out
in your response that it isn't.

And I think with that knowledge I can simplify this patch, but don't quite
recall. (On my mobile again, please excuse my apparent laziness.)


> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 164d86c4064..200bc0730d6 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -18,7 +18,7 @@
> >  from collections import OrderedDict
> >  import os
> >  import re
> > -from typing import List, Optional
> > +from typing import List, Optional, cast
> >
> >  from .common import (
> >      POINTER_SUFFIX,
> > @@ -447,22 +447,24 @@ def __init__(self, name, info, doc, ifcond,
> features,
> >          self.base = None
> >          self.local_members = local_members
> >          self.variants = variants
> > -        self.members = None
> > +        self.members: List[QAPISchemaObjectTypeMember] = []
>
> Can we do
>
>            self.members: List[QAPISchemaObjectTypeMember]
>
> ?
>

Possibly, but also possibly I can just initialize it to an empty list.


> > +        self._checking = False
> >
> >      def check(self, schema):
> >          # This calls another type T's .check() exactly when the C
> >          # struct emitted by gen_object() contains that T's C struct
> >          # (pointers don't count).
> > -        if self.members is not None:
> > -            # A previous .check() completed: nothing to do
> > -            return
> > -        if self._checked:
> > +        if self._checking:
> >              # Recursed: C struct contains itself
> >              raise QAPISemError(self.info,
> >                                 "object %s contains itself" % self.name)
> > +        if self._checked:
> > +            # A previous .check() completed: nothing to do
> > +            return
> >
> > +        self._checking = True
> >          super().check(schema)
> > -        assert self._checked and self.members is None
> > +        assert self._checked and not self.members
>
> If we assign only in .check(), we can't read self.members to find out
> whether it's valid.  We could perhaps mess with .__dict__() instead.
> Not sure it's worthwhile.  Dumb down the assertion?
>

If I initialize to an empty list (and don't mess with the checked member)
maybe

assert self._checked and not self.members

would be perfectly acceptable.


> >
> >          seen = OrderedDict()
> >          if self._base_name:
> > @@ -479,13 +481,17 @@ def check(self, schema):
> >          for m in self.local_members:
> >              m.check(schema)
> >              m.check_clash(self.info, seen)
> > -        members = seen.values()
> > +
> > +        # check_clash is abstract, but local_members is asserted to be
> > +        # List[QAPISchemaObjectTypeMember]. Cast to the narrower type.
> > +        members = cast(List[QAPISchemaObjectTypeMember],
> list(seen.values()))
> >
> >          if self.variants:
> >              self.variants.check(schema, seen)
> >              self.variants.check_clash(self.info, seen)
> >
> > -        self.members = members  # mark completed
> > +        self.members = members
> > +        self._checking = False  # mark completed
> >
> >      # Check that the members of this type do not cause duplicate JSON
> members,
> >      # and update seen to track the members seen so far. Report any
> errors
>
>

--0000000000003a2343060e9d2c86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Nov 22, 2023, 9:02 AM Markus Armbruster &lt;<a=
 href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; write=
s:<br>
<br>
&gt; Differentiate between &quot;actively in the process of checking&quot; =
and<br>
&gt; &quot;checking has completed&quot;. This allows us to clean up the typ=
es of some<br>
&gt; internal fields such as QAPISchemaObjectType&#39;s members field which=
<br>
&gt; currently uses &quot;None&quot; as a canary for determining if check h=
as<br>
&gt; completed.<br>
<br>
Certain members become valid only after .check().=C2=A0 Two ways to code<br=
>
that:<br>
<br>
1. Assign to such members only in .check().=C2=A0 If you try to use them<br=
>
before .check(), AttributeError.=C2=A0 Nice.=C2=A0 Drawback: pylint is unha=
ppy,<br>
W0201 attribute-defined-outside-init.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Can be overcome by declaring the fiel=
d in __init__, which satisfies both the linter and my developer usability s=
ense (Classes should be easy to have their properties enumerated by looking=
 in one well known place.)</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
2. Assign None in .__init__(), and the real value in .check().=C2=A0 If you=
<br>
try to use them before .check(), you get None, which hopefully leads to<br>
an error.=C2=A0 Meh, but pylint is happy.<br>
<br>
I picked 2. because pylint&#39;s warning made me go &quot;when in Rome...&q=
uot;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Yep, this is perfectly cromulent dynamically typed Python. It&#39;s not=
 the Roman&#39;s fault I&#39;m packing us up to go to another empire.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
With type hints, we can declare in .__init__(), and assign in .check().<br>
Gives me the AttributeError I like, and pylint remains happy.=C2=A0 What do=
<br>
you think?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Sounds good to me in general, I already changed this for 2/3 of m=
y other uses of @property.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">(I&#39;m only reluctant because I don&#39;t really like that it&#39;s a =
&quot;lie&quot;, but in this case, without potentially significant rewrites=
, it&#39;s a reasonable type band-aid. Once we&#39;re type checked, we can =
refactor more confidently if we so desire, to make certain patterns less pr=
ominent or landmine-y.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Splitting .checked feels like a separate change, though.=C2=A0 I can&#39;t =
quite<br>
see why we need it.=C2=A0 Help me out: what problem does it solve?<br></blo=
ckquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Mechanica=
lly, I wanted to eliminate the Optional type from the members field, but yo=
u have conditionals in the code that use the presence or absence of this fi=
eld as a query to determine if we had run check or not yet.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">So I did the stupidest possible thing=
 and added a &quot;checked&quot; variable to explicitly represent it.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
&gt; This simplifies the typing from a cumbersome Optional[List[T]] to mere=
ly<br>
&gt; a List[T], which is more pythonic: it is safe to iterate over an empty=
<br>
&gt; list with &quot;for x in []&quot; whereas with an Optional[List[T]] yo=
u have to<br>
&gt; rely on the more cumbersome &quot;if L: for x in L: ...&quot;<br>
<br>
Yes, but when L is None, it&#39;s *invalid*, and for i in L *should* fail<b=
r>
when L is invalid.<br></blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Sure, but it&#39;s so invalid that it causes static typin=
g errors.</div><div dir=3D"auto"><br></div><div dir=3D"auto">You can&#39;t =
write &quot;for x in None&quot; in a way that makes mypy happy, None is not=
 iterable.</div><div dir=3D"auto"><br></div><div dir=3D"auto">If you want t=
o preserve the behavior of &quot;iterating an empty collection is an Assert=
ion&quot;, you need a custom iterator that throws an exception when the col=
lection is empty. I can do that, if you&#39;d like, but I think it&#39;s ac=
tually fine to just allow the collection to be empty and to just catch the =
error in check() with either an assertion (oops, something went wrong and t=
he list is empty, this should never happen) or a QAPISemError (oops, you di=
dn&#39;t specify any members, which is illegal.)</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">I&#39;d prefer to catch this in check and just all=
ow the iterator to permit empty iterators at the callsite, knowing it&#39;l=
l never happen.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
I think the actual problem is something else.=C2=A0 By adding the type hint=
<br>
Optional[List[T]], the valid uses of L become type errors.=C2=A0 We really<=
br>
want L to be a List[T].=C2=A0 Doesn&#39;t mean we have to (or want to) make=
 uses<br>
of invalid L &quot;work&quot;.<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">I didn&#39;t think I did allow for invalid us=
es to work - if the list should semantically never be empty, I think it&#39=
;s fine to enforce that in schema.py during construction of the schema obje=
ct and to assume all uses of &quot;for x in L: ...&quot; are inherently val=
id.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br>
&gt; RFC: are we guaranteed to have members here? can we just use &quot;if<=
br>
&gt; members&quot; without adding the new field?<br>
<br>
I&#39;m afraid I don&#39;t understand these questions.<br></blockquote></di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto">I think you answered =
this one for me; I was asking if it was ever valid in any circumstance to h=
ave an empty members list, but I think you&#39;ve laid out in your response=
 that it isn&#39;t.</div><div dir=3D"auto"><br></div><div dir=3D"auto">And =
I think with that knowledge I can simplify this patch, but don&#39;t quite =
recall. (On my mobile again, please excuse my apparent laziness.)</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/schema.py | 24 +++++++++++++++---------<br>
&gt;=C2=A0 1 file changed, 15 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; index 164d86c4064..200bc0730d6 100644<br>
&gt; --- a/scripts/qapi/schema.py<br>
&gt; +++ b/scripts/qapi/schema.py<br>
&gt; @@ -18,7 +18,7 @@<br>
&gt;=C2=A0 from collections import OrderedDict<br>
&gt;=C2=A0 import os<br>
&gt;=C2=A0 import re<br>
&gt; -from typing import List, Optional<br>
&gt; +from typing import List, Optional, cast<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from .common import (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 POINTER_SUFFIX,<br>
&gt; @@ -447,22 +447,24 @@ def __init__(self, name, info, doc, ifcond, feat=
ures,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.base =3D None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.local_members =3D local_members=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.variants =3D variants<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.members =3D None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.members: List[QAPISchemaObjectTypeMe=
mber] =3D []<br>
<br>
Can we do<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.members: List[QAPISchemaObjec=
tTypeMember]<br>
<br>
?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Possibly, but also possibly I can just initialize it to an empty list.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._checking =3D False<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def check(self, schema):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This calls another type T&#39;s .c=
heck() exactly when the C<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # struct emitted by gen_object() con=
tains that T&#39;s C struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # (pointers don&#39;t count).<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.members is not None:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # A previous .check() compl=
eted: nothing to do<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._checked:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._checking:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Recursed: C struct c=
ontains itself<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISemError(<a =
href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_blank">s=
elf.info</a>,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;object %s contains it=
self&quot; % <a href=3D"http://self.name" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">self.name</a>)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._checked:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # A previous .check() compl=
eted: nothing to do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._checking =3D True<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked and self.members is =
None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked and not self.members=
<br>
<br>
If we assign only in .check(), we can&#39;t read self.members to find out<b=
r>
whether it&#39;s valid.=C2=A0 We could perhaps mess with .__dict__() instea=
d.<br>
Not sure it&#39;s worthwhile.=C2=A0 Dumb down the assertion?<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">If I initialize=
 to an empty list (and don&#39;t mess with the checked member) maybe</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">assert self._checked and not s=
elf.members</div><div dir=3D"auto"><br></div><div dir=3D"auto">would be per=
fectly acceptable.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seen =3D OrderedDict()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._base_name:<br>
&gt; @@ -479,13 +481,17 @@ def check(self, schema):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for m in self.local_members:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m.check(schema)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m.check_clash(<a href=
=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.=
info</a>, seen)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 members =3D seen.values()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check_clash is abstract, but local_memb=
ers is asserted to be<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # List[QAPISchemaObjectTypeMember]. Cast =
to the narrower type.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 members =3D cast(List[QAPISchemaObjectTyp=
eMember], list(seen.values()))<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.variants:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.variants.check(sc=
hema, seen)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.variants.check_cl=
ash(<a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_b=
lank">self.info</a>, seen)<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.members =3D members=C2=A0 # mark com=
pleted<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.members =3D members<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._checking =3D False=C2=A0 # mark com=
pleted<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 # Check that the members of this type do not cause=
 duplicate JSON members,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # and update seen to track the members seen so far=
. Report any errors<br>
<br>
</blockquote></div></div></div>

--0000000000003a2343060e9d2c86--


