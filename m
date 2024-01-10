Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC61E829489
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 08:54:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNTOb-0006k5-P6; Wed, 10 Jan 2024 02:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNTOZ-0006jw-MJ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:53:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNTOX-0007sV-J3
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704873180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/hSojYpxZaFoHWcPlh0CYlGwSlAOdGhJWNP0LYCIoY=;
 b=P+j5WiEhgBZ4ClTf/L3OUf5Zz2jHC1ypIf9KCvu2+roHLJd+npfASuYxDQrmqgBgturESu
 LqouoGuvdLplynnMddIsHSnevNstG8qhutStEl27U2X1s/qsk0I9jh6gwosSbzmpD8RLWE
 WB3JRZZaR5eISTT1UVrY1yuSJ6FK1Ac=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-wvayx-hyNJCcIvO9COsTMw-1; Wed,
 10 Jan 2024 02:52:58 -0500
X-MC-Unique: wvayx-hyNJCcIvO9COsTMw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E9FC1C0513B;
 Wed, 10 Jan 2024 07:52:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBBD2492BC7;
 Wed, 10 Jan 2024 07:52:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E6C7021E6740; Wed, 10 Jan 2024 08:52:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 13/19] qapi/schema: fix typing for
 QAPISchemaVariants.tag_member
In-Reply-To: <CAFn=p-bky_eAv9Z2V0zQ-_J7EygvYANa4UnxLTB9omMN-AbvbA@mail.gmail.com>
 (John Snow's message of "Tue, 9 Jan 2024 20:47:24 -0500")
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-14-jsnow@redhat.com>
 <87zfz5c28s.fsf@pond.sub.org>
 <CAFn=p-bZPJNU9uLBOW1Uqts7kX-+9+dvSNRxwf+VD5hoCHJq9A@mail.gmail.com>
 <CAFn=p-bky_eAv9Z2V0zQ-_J7EygvYANa4UnxLTB9omMN-AbvbA@mail.gmail.com>
Date: Wed, 10 Jan 2024 08:52:56 +0100
Message-ID: <87bk9tfwvb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

John Snow <jsnow@redhat.com> writes:

> On Wed, Nov 22, 2023 at 11:02=E2=80=AFAM John Snow <jsnow@redhat.com> wro=
te:
>>
>> On Wed, Nov 22, 2023 at 9:05=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>> >
>> > John Snow <jsnow@redhat.com> writes:
>> >
>> > > There are two related changes here:
>> > >
>> > > (1) We need to perform type narrowing for resolving the type of
>> > >     tag_member during check(), and
>> > >
>> > > (2) tag_member is a delayed initialization field, but we can hide it
>> > >     behind a property that raises an Exception if it's called too
>> > >     early. This simplifies the typing in quite a few places and avoi=
ds
>> > >     needing to assert that the "tag_member is not None" at a dozen
>> > >     callsites, which can be confusing and suggest the wrong thing to=
 a
>> > >     drive-by contributor.
>> > >
>> > > Signed-off-by: John Snow <jsnow@redhat.com>
>> >
>> > Without looking closely: review of PATCH 10 applies, doesn't it?
>> >
>>
>> Yep!
>
> Hm, actually, maybe not quite as cleanly.
>
> The problem is we *are* initializing that field immediately with
> whatever we were passed in during __init__, which means the field is
> indeed Optional. Later, during check(), we happen to eliminate that
> usage of None.

You're right.

QAPISchemaVariants.__init__() takes @tag_name and @tag_member.  Exactly
one of them must be None.  When creating a union's QAPISchemaVariants,
it's tag_member, and when creating an alternate's, it's tag_name.

Why?

A union's tag is an ordinary member selected by name via
'discriminator': TAG_NAME.  We can't resolve the name at this time,
because it may be buried arbitrarily deep in the base type chain.

An alternate's tag is an implicitly created "member" of type 'QType'.
"Member" in scare-quotes, because is special: it exists in C, but not on
the wire, and not in introspection.

Historical note: simple unions also had an implictly created tag member,
and its type was the implicit enum type enumerating the branches.

So _def_union_type() passes TAG_NAME to .__init__(), and
_def_alternate_type() creates and passes the implicit tag member.
Hardly elegant, but it works.

> To remove the use of the @property trick here, we could:
>
> ... declare the field, then only initialize it if we were passed a
> non-None value. But then check() would need to rely on something like
> hasattr to check if it was set or not, which is maybe an unfortunate
> code smell.
> So I think you'd still wind up needing a ._tag_member field which is
> Optional and always gets set during __init__, then setting a proper
> .tag_member field during check().
>
> Or I could just leave this one as-is. Or something else. I think the
> dirt has to get swept somewhere, because we don't *always* have enough
> information to fully initialize it at __init__ time, it's a
> conditional delayed initialization, unlike the others which are
> unconditionally delayed.

Yes.

Here's a possible "something else":

1. Drop parameter .__init__() parameter @tag_member, and leave
.tag_member unset there.

2. Set .tag_member in .check(): if .tag_name, look up that member (no
change).  Else, it's an alternate; create the alternate's implicit tag
member.

Drawback: before, we create AST in just one place, namely
QAPISchema._def_exprs().  Now we also create some in .check().

Here's another "something else":

1. Fuse parameters .__init__() @tag_member and @tag_name.  The type
becomes Union.  Store for .check().

2. Set .tag_member in .check(): if we stored a name, look up that
member, else we must have stored an implicit member, so use that.

3. We check "is this a union?" like if self._tag_name.  Needs
adjustment.

Feels a bit awkward to me.

We can also do nothing, as you said.  We don't *have* to express
".check() resolves unresolved tag member" in the type system.  We can
just live with .tag_member remaining Optional.

Differently awkward, I guess.

Thoughts?


