Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C377182912C
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 01:16:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNMFP-0003un-HM; Tue, 09 Jan 2024 19:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNMFM-0003uV-7L
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 19:15:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNMFJ-0006SY-Tw
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 19:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704845699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gb68bVCK9BYQYeORF7aiNFMo0yD+fNaoHS5e0JOpY+4=;
 b=QFKffSMhmB3UB1WtkXjSWfokiCzYhUfmGy1asGFP/uQJtL/xRXkXzfiZ0vDagUgNLQkj48
 lSwgyvx6Hodef9jTUc7UUDDEH0vYFcLJ8FDect0zIYPCwtXxyDPRM+m4D+h4EW3oYy1HwL
 hIS62pIPs0PV14IBMnjNvms/gIipTKY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-GIilcdFLODGiiyIUrr8D7A-1; Tue, 09 Jan 2024 19:14:52 -0500
X-MC-Unique: GIilcdFLODGiiyIUrr8D7A-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6d9ba60e1c1so2334946b3a.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 16:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704845691; x=1705450491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gb68bVCK9BYQYeORF7aiNFMo0yD+fNaoHS5e0JOpY+4=;
 b=lQGhPGJGUVaBDGh1wVgsRuulrbGZpxYqiKfv5/wNGa2BsUI1a/cwW9yVE3nlSNqT8C
 14DlNRSF6UzWWIh/S1ADPmohmPcCIeRvHqE/c2OQ+ibUUgXhO1rFxBH5p86JgcwhaThG
 RZb0g0exx0F5P0VtXB2U+WXrCm8cmNMdwUQrH4J/Wt/0/6W3Fi0hmKy0UzaUt8FH3IJq
 ugcSg20BNPTKT9KELgXRlCmw7VKpCCb+L3GPcyYROFZTXDZxabAlfuEAjE0MvKMD7rXN
 OvqTxDmRJhEL7YY0hMKLcQ3/y0UANS3sUmUTdZgdUEeFekCz8wSWvAq3ZdfxrPgmMn2x
 0EcQ==
X-Gm-Message-State: AOJu0Yw335lRh5Exm9lzoNbkl4DVRO/Y3kDXyzONPwUR5yztYQDaDwzJ
 nRM72ANXnViN46PjdEAKic/ElLZ8xCATvbPs6pRbt1JET1fLWMf8b+GqcvzAm2I5YNrcnTcArbk
 dESjDI5HVRuSE8sSF+v2xRzMfQLAHcaoDwrLcIR+k5SYC8S4=
X-Received: by 2002:a05:6a20:3946:b0:199:f47c:6a90 with SMTP id
 r6-20020a056a20394600b00199f47c6a90mr97777pzg.116.1704845690967; 
 Tue, 09 Jan 2024 16:14:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaeBZ1S0GKsBeL9WJwduMRaLBN8zG3vqQr5Dhs1LQOZHFtGV+mcaIxAwXFpMSPF42TVKLcEj1lrAlcrRSjGvk=
X-Received: by 2002:a05:6a20:3946:b0:199:f47c:6a90 with SMTP id
 r6-20020a056a20394600b00199f47c6a90mr97771pzg.116.1704845690536; Tue, 09 Jan
 2024 16:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-16-jsnow@redhat.com>
 <8734ww4kz4.fsf@pond.sub.org>
In-Reply-To: <8734ww4kz4.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Jan 2024 19:14:39 -0500
Message-ID: <CAFn=p-bD5h2h8p=Fre1y5pdKWEQ_Y9GX3vwNJCTAZwz9KpUuiA@mail.gmail.com>
Subject: Re: [PATCH 15/19] qapi/parser: demote QAPIExpression to Dict[str, Any]
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

On Thu, Nov 23, 2023 at 9:12=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Dict[str, object] is a stricter type, but with the way that code is
> > currently arranged, it is infeasible to enforce this strictness.
> >
> > In particular, although expr.py's entire raison d'=C3=AAtre is normaliz=
ation
> > and type-checking of QAPI Expressions, that type information is not
> > "remembered" in any meaningful way by mypy because each individual
> > expression is not downcast to a specific expression type that holds all
> > the details of each expression's unique form.
> >
> > As a result, all of the code in schema.py that deals with actually
> > creating type-safe specialized structures has no guarantee (myopically)
> > that the data it is being passed is correct.
> >
> > There are two ways to solve this:
> >
> > (1) Re-assert that the incoming data is in the shape we expect it to be=
, or
> > (2) Disable type checking for this data.
> >
> > (1) is appealing to my sense of strictness, but I gotta concede that it
> > is asinine to re-check the shape of a QAPIExpression in schema.py when
> > expr.py has just completed that work at length. The duplication of code
> > and the nightmare thought of needing to update both locations if and
> > when we change the shape of these structures makes me extremely
> > reluctant to go down this route.
> >
> > (2) allows us the chance to miss updating types in the case that types
> > are updated in expr.py, but it *is* an awful lot simpler and,
> > importantly, gets us closer to type checking schema.py *at
> > all*. Something is better than nothing, I'd argue.
> >
> > So, do the simpler dumber thing and worry about future strictness
> > improvements later.
>
> Yes.
>

(You were right, again.)

> While Dict[str, object] is stricter than Dict[str, Any], both are miles
> away from the actual, recursive type.
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index bf31018aef0..b7f08cf36f2 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -19,6 +19,7 @@
> >  import re
> >  from typing import (
> >      TYPE_CHECKING,
> > +    Any,
> >      Dict,
> >      List,
> >      Mapping,
> > @@ -43,7 +44,7 @@
> >  _ExprValue =3D Union[List[object], Dict[str, object], str, bool]
> >
> >
> > -class QAPIExpression(Dict[str, object]):
> > +class QAPIExpression(Dict[str, Any]):
> >      # pylint: disable=3Dtoo-few-public-methods
> >      def __init__(self,
> >                   data: Mapping[str, object],
>
> There are several occurences of Dict[str, object] elsewhere.  Would your
> argument for dumbing down QAPIExpression apply to (some of) them, too?

When and if they piss me off, sure. I'm just wary of making the types
too permissive because it can obscure typing errors; by using Any, you
really disable any further checks and might lead to false confidence
in the static checker. I still have a weird grudge against Any and
would like to fully eliminate it from any statically checked Python
code, but it's just not always feasible and I have to admit that "good
enough" is good enough. Doesn't have me running to lessen the
strictness in areas that didn't cause me pain, though...

> Skimming them, I found this in introspect.py:
>
>     # These types are based on structures defined in QEMU's schema, so we
>     # lack precise types for them here. Python 3.6 does not offer
>     # TypedDict constructs, so they are broadly typed here as simple
>     # Python Dicts.
>     SchemaInfo =3D Dict[str, object]
>     SchemaInfoEnumMember =3D Dict[str, object]
>     SchemaInfoObject =3D Dict[str, object]
>     SchemaInfoObjectVariant =3D Dict[str, object]
>     SchemaInfoObjectMember =3D Dict[str, object]
>     SchemaInfoCommand =3D Dict[str, object]
>
> Can we do better now we have 3.8?

A little bit, but it involves reproducing these types -- which are
ultimately meant to represent QAPI types defined in introspect.json --
with "redundant" type info. i.e. I have to reproduce the existing type
definitions in Python-ese, and then we have the maintenance burden of
making sure they match.

Maybe too much work to come up with a crazy dynamic definition thing
where we take the QAPI definition and build Python types from them ...
without some pretty interesting work to avoid the Ouroboros that'd
result. introspection.py wants static types based on types defined
dynamically by the schema definition; but we are not guaranteed to
have a suitable schema with these types at all. I'm not sure how to
express this kind of dependency without some interesting re-work. This
is a rare circumstance of the QAPI generator relying on the contents
of the Schema to provide static type assistance.

Now, I COULD do it statically, since I don't expect these types to
change much, but I'm wary of how quickly it might get out of hand
trying to achieve better type specificity.

General impression: "Not worth the hassle for this series, but we can
discuss proposals for future improvements"


