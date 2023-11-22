Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 760177F4BB7
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 16:56:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5pa3-0003Nb-V5; Wed, 22 Nov 2023 10:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5pZy-0003NL-BM
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 10:55:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5pZw-0007SA-Mx
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 10:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700668550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cIr6BK4vCS4o/L52zPrROJ1u8CyNrmZjUOXX7HqMLTE=;
 b=FgEbHEEP9mr8I5VDm0fV66XALV/IAOQOCR57A5RbXQM+5S/4m8Y1jo0fTGeiij5u9m9HC4
 UrKSSq+SMJn23AqEBtA3X5X8GhQeMgLlPmQs0Sqg/YWPC1RjNhPBr0OboDR+JepKkcQKc/
 eyG6uf6NXkmHbq9EiYmIgoW/8VpF+Do=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Rj5dBAKEN3Wy78g9mhn1xw-1; Wed, 22 Nov 2023 10:55:49 -0500
X-MC-Unique: Rj5dBAKEN3Wy78g9mhn1xw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6cba754b041so3844015b3a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 07:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700668548; x=1701273348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIr6BK4vCS4o/L52zPrROJ1u8CyNrmZjUOXX7HqMLTE=;
 b=XikVSqXRCm0iAtDYSLbAYL28YRs9kwnFUInZqr5dXf228iOTjayOw9khxR5W9VTJIM
 UUNEuSHfOaGke0l/yETdgVql3GwBkIUrpxVsQQ35fnVzHAAjHMSIvONvYjTNlvfzcfBO
 tdpfn3eO8ldsKaoCL36hXodX5jW7b+vnYom59k2WfB//9k+Y6k0V1gMBqneiKpPnlSQG
 Qr5fNqPVgxXJGTYaXoK0wawScCx1IqfFk9UCNvOvLqwDNxxXzCaiSSGtfEVfCyySuNYO
 s3JXSolgxdtORKKzL9ED19MpfniqM/rw2P9ETSIGH500aFdgVuric6BOZNwUUrGhf4cT
 NRZQ==
X-Gm-Message-State: AOJu0Ywjlp//4WYFWtYIgCeDYwWlfpvpm+Odt86JJqDl6o4G35rh2nFa
 Rb/JOqEjPlrgXufQqz/Z9zckLk5OD4916fkaNXPovbju/e3hpWrgf1hxryZmOLRnsvb1YvaX1Qu
 bprgX69/c4sTMCNicE8Qhwp37+JUJcNw=
X-Received: by 2002:a05:6a20:e126:b0:187:7917:189d with SMTP id
 kr38-20020a056a20e12600b001877917189dmr2919585pzb.29.1700668548093; 
 Wed, 22 Nov 2023 07:55:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFItzX765T5bba9xqFgImAWGEUNRojqYh5G5SFQoQjnx4x5lsDGvodDoI4Y2y/AtZSKAZY45i6A50Urc4O6kV0=
X-Received: by 2002:a05:6a20:e126:b0:187:7917:189d with SMTP id
 kr38-20020a056a20e12600b001877917189dmr2919569pzb.29.1700668547727; Wed, 22
 Nov 2023 07:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-9-jsnow@redhat.com>
 <87jzqb2nmp.fsf@pond.sub.org>
 <CAFn=p-bHuJsMG=HOdw8kxGwgAFQpvUWeHHD0xXtOV3+ytQfJQw@mail.gmail.com>
 <874jheugz5.fsf@pond.sub.org>
In-Reply-To: <874jheugz5.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 22 Nov 2023 10:55:36 -0500
Message-ID: <CAFn=p-axjksRWSA1G0iXLJFJOXx8Xbry3K6nowmQqVOkgg=r_g@mail.gmail.com>
Subject: Re: [PATCH 08/19] qapi/schema: add static typing and assertions to
 lookup_type()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

On Wed, Nov 22, 2023 at 7:09=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Tue, Nov 21, 2023, 9:21 AM Markus Armbruster <armbru@redhat.com> wro=
te:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > This function is a bit hard to type as-is; mypy needs some assertion=
s to
> >> > assist with the type narrowing.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  scripts/qapi/schema.py | 8 ++++++--
> >> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> >> > index a1094283828..3308f334872 100644
> >> > --- a/scripts/qapi/schema.py
> >> > +++ b/scripts/qapi/schema.py
> >> > @@ -968,8 +968,12 @@ def lookup_entity(self, name, typ=3DNone):
> >> >              return None
> >> >          return ent
> >> >
> >> > -    def lookup_type(self, name):
> >> > -        return self.lookup_entity(name, QAPISchemaType)
> >> > +    def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
> >>
> >> Any particular reason not to delay the type hints until PATCH 16?
> >>
> >
> > I forget. In some cases I did things a little differently so that the t=
ype
> > checking would pass for each patch in the series, which sometimes requi=
red
> > some concessions.
> >
> > Is this one of those cases? Uh, I forget.
> >
> > If it isn't, its almost certainly the case that I just figured I'd type
> > this one function in one place instead of splitting it apart into two
> > patches.
> >
> > I can try to shift the typing later and see what happens if you prefer =
it
> > that way.
>
> Well, you structured the series as "minor code changes to prepare for
> type hints", followed by "add type hints".  So that's what I expect.
> When patches deviate from what I expect, I go "am I missing something?"
>
> Adding type hints along the way could work, too.  But let's try to stick
> to the plan, and add them all in PATCH 16.
>
> >> > +        typ =3D self.lookup_entity(name, QAPISchemaType)
> >> > +        if typ is None:
> >> > +            return None
> >> > +        assert isinstance(typ, QAPISchemaType)
> >> > +        return typ
> >>
> >> Would
> >>
> >>            typ =3D self.lookup_entity(name, QAPISchemaType)
> >>            assert isinstance(typ, Optional[QAPISchemaType])
> >>            return typ
> >>
> >> work?
> >>
> >
> > I don't *think* so, Optional isn't a runtime construct.
>
> Let me try...
>
>     $ python
>     Python 3.11.5 (main, Aug 28 2023, 00:00:00) [GCC 12.3.1 20230508 (Red=
 Hat 12.3.1-1)] on linux
>     Type "help", "copyright", "credits" or "license" for more information=
.
>     >>> from typing import Optional
>     >>> x=3DNone
>     >>> isinstance(x, Optional[str])
>     True
>     >>>

Huh. I ... huh!

Well, this apparently only works in Python 3.10!+

TypeError: Subscripted generics cannot be used with class and instance chec=
ks

>
> >                                                         We can combine =
it
> > into "assert x is None or isinstance(x, foo)" though - I believe that's
> > used elsewhere in the qapi generator.
>
> >> >
> >> >      def resolve_type(self, name, info, what):
> >> >          typ =3D self.lookup_type(name)
> >>
> >>
>


