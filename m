Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA0582953D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:36:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNU4L-0001m8-D2; Wed, 10 Jan 2024 03:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNU4J-0001jW-2o
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:36:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNU4F-00026g-HB
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704875766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3PWsrQiz24sDlhwFm/MMQzEoOs/bcLxKVEEiP9b+FaE=;
 b=UC4kByrYbZzZVFeZwjmCmOaigAtDSs5SO8Snw98E+YxS+XaKj+SMn/jYTFg2YoYy3kkEro
 +431bL5RK+K4qYbM+mDA0eQzkKibSN7sTtJV/tfQPLPvXaWIcueKozaGNaEYqi0IaWzRDc
 /kl9YgFbsSGubS7Fox8hNymu96zE8xU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-jilqCza5NFm1FDVeWth7eg-1; Wed, 10 Jan 2024 03:36:05 -0500
X-MC-Unique: jilqCza5NFm1FDVeWth7eg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5cdacf76cb0so1121125a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704875763; x=1705480563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PWsrQiz24sDlhwFm/MMQzEoOs/bcLxKVEEiP9b+FaE=;
 b=YcPGvZ0AZbadAbHNta4V1wT0PZIyf69LI8b3tnGhsF8w/xwz1bll8kN8T+hwn+8kcI
 ON2yzP4tXKWW2zTgF+ZH7mNQs2NkZD2qTxwYk4ix8/ZU+ztwnoK2uh9I1SnXqUa74FF0
 k0YbF0G6R4bSerPH7ZcR1rbeYGiSlEJqf4KFp29ISCkESxuhDyRTTxCLGyjIAcIJjEz3
 S7HNkpbyy/iHjak1OA75h1QeW/wFcg34DljAVLVqI7SH9YYpP/goHN0Ek+yX4nSAzkQz
 xvRowsq61wNxHiJOBwJlh+DHta8gUwmmPwQJtfZS9eHW2iK3pUu8iu7FJXNQ3Zmu5JhU
 X71Q==
X-Gm-Message-State: AOJu0YzV3rArg4CEluEvOudM+yLMZ0NKdqNWvTFSEkBsEg/vdqbCHYay
 WpdakOjOs8cafbx8d6ThX/zZZ7eMj6V7TA047ibOePPURp8C1wtTuemqK2xPNITcdvRDXDWEZ95
 09mPC0hgdeFQCvwXZ2EHWFz3pv9aLbSU6Ei0TRbP0KDk7ymM=
X-Received: by 2002:a17:90a:6ba4:b0:286:6cc1:865f with SMTP id
 w33-20020a17090a6ba400b002866cc1865fmr322990pjj.68.1704875763504; 
 Wed, 10 Jan 2024 00:36:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZ274ORR3S5tY5eK/LnR9UViwJINla6xqDC7sz/MLHyGj/y8ssq9yzyeVTH8ceHtNm5+1oSWU5kLxrnrObphI=
X-Received: by 2002:a17:90a:6ba4:b0:286:6cc1:865f with SMTP id
 w33-20020a17090a6ba400b002866cc1865fmr322985pjj.68.1704875763172; Wed, 10 Jan
 2024 00:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-14-jsnow@redhat.com>
 <87zfz5c28s.fsf@pond.sub.org>
 <CAFn=p-bZPJNU9uLBOW1Uqts7kX-+9+dvSNRxwf+VD5hoCHJq9A@mail.gmail.com>
 <CAFn=p-bky_eAv9Z2V0zQ-_J7EygvYANa4UnxLTB9omMN-AbvbA@mail.gmail.com>
 <87bk9tfwvb.fsf@pond.sub.org>
In-Reply-To: <87bk9tfwvb.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 10 Jan 2024 03:35:51 -0500
Message-ID: <CAFn=p-ZsQnwMtDEN70UdTz75bN6FgzxPbM0yNicOoULpPtV97A@mail.gmail.com>
Subject: Re: [PATCH 13/19] qapi/schema: fix typing for
 QAPISchemaVariants.tag_member
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

On Wed, Jan 10, 2024 at 2:53=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Wed, Nov 22, 2023 at 11:02=E2=80=AFAM John Snow <jsnow@redhat.com> w=
rote:
> >>
> >> On Wed, Nov 22, 2023 at 9:05=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
> >> >
> >> > John Snow <jsnow@redhat.com> writes:
> >> >
> >> > > There are two related changes here:
> >> > >
> >> > > (1) We need to perform type narrowing for resolving the type of
> >> > >     tag_member during check(), and
> >> > >
> >> > > (2) tag_member is a delayed initialization field, but we can hide =
it
> >> > >     behind a property that raises an Exception if it's called too
> >> > >     early. This simplifies the typing in quite a few places and av=
oids
> >> > >     needing to assert that the "tag_member is not None" at a dozen
> >> > >     callsites, which can be confusing and suggest the wrong thing =
to a
> >> > >     drive-by contributor.
> >> > >
> >> > > Signed-off-by: John Snow <jsnow@redhat.com>
> >> >
> >> > Without looking closely: review of PATCH 10 applies, doesn't it?
> >> >
> >>
> >> Yep!
> >
> > Hm, actually, maybe not quite as cleanly.
> >
> > The problem is we *are* initializing that field immediately with
> > whatever we were passed in during __init__, which means the field is
> > indeed Optional. Later, during check(), we happen to eliminate that
> > usage of None.
>
> You're right.
>
> QAPISchemaVariants.__init__() takes @tag_name and @tag_member.  Exactly
> one of them must be None.  When creating a union's QAPISchemaVariants,
> it's tag_member, and when creating an alternate's, it's tag_name.
>
> Why?
>
> A union's tag is an ordinary member selected by name via
> 'discriminator': TAG_NAME.  We can't resolve the name at this time,
> because it may be buried arbitrarily deep in the base type chain.
>
> An alternate's tag is an implicitly created "member" of type 'QType'.
> "Member" in scare-quotes, because is special: it exists in C, but not on
> the wire, and not in introspection.
>
> Historical note: simple unions also had an implictly created tag member,
> and its type was the implicit enum type enumerating the branches.
>
> So _def_union_type() passes TAG_NAME to .__init__(), and
> _def_alternate_type() creates and passes the implicit tag member.
> Hardly elegant, but it works.
>
> > To remove the use of the @property trick here, we could:
> >
> > ... declare the field, then only initialize it if we were passed a
> > non-None value. But then check() would need to rely on something like
> > hasattr to check if it was set or not, which is maybe an unfortunate
> > code smell.
> > So I think you'd still wind up needing a ._tag_member field which is
> > Optional and always gets set during __init__, then setting a proper
> > .tag_member field during check().
> >
> > Or I could just leave this one as-is. Or something else. I think the
> > dirt has to get swept somewhere, because we don't *always* have enough
> > information to fully initialize it at __init__ time, it's a
> > conditional delayed initialization, unlike the others which are
> > unconditionally delayed.
>
> Yes.
>
> Here's a possible "something else":
>
> 1. Drop parameter .__init__() parameter @tag_member, and leave
> .tag_member unset there.
>
> 2. Set .tag_member in .check(): if .tag_name, look up that member (no
> change).  Else, it's an alternate; create the alternate's implicit tag
> member.
>
> Drawback: before, we create AST in just one place, namely
> QAPISchema._def_exprs().  Now we also create some in .check().

I suppose I don't have a concrete argument against this beyond "It
doesn't seem prettier than using the @property getter."

>
> Here's another "something else":
>
> 1. Fuse parameters .__init__() @tag_member and @tag_name.  The type
> becomes Union.  Store for .check().
>
> 2. Set .tag_member in .check(): if we stored a name, look up that
> member, else we must have stored an implicit member, so use that.
>
> 3. We check "is this a union?" like if self._tag_name.  Needs
> adjustment.
>
> Feels a bit awkward to me.

Yeah, a little. Mechanically simple, though, I think.

>
> We can also do nothing, as you said.  We don't *have* to express
> ".check() resolves unresolved tag member" in the type system.  We can
> just live with .tag_member remaining Optional.

This is the only option I'm sure I don't want - it's misleading to
users of the API for the purposes of new generators using a fully
realized schema object. I think it's important to remove Optional[]
where possible to avoid the question "When will this be set to None?"
if the answer is just "For your purposes, never."

It's an implementation detail of object initialization leaking out.

(Also, I just counted and leaving the field as Optional adds 22 new
type errors; that's a lot of callsites to bandage with new conditions.
nah.)

The *other* way to not do anything is to just leave the @property
solution in O:-)

>
> Differently awkward, I guess.
>
> Thoughts?

Partial to the getter, unless option 1 or 2 leads to simplification of
the check() code, which I haven't really experimented with. If that's
something you'd really rather avoid, I might ask for you to decide on
your preferred alternative - I don't have strong feelings between 'em.

(Not helpful, oops. Thanks for your feedback and review, though.
You've successfully talked me down to a much smaller series over time
:p)

--js


