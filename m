Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C45AC8106EA
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 01:48:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDDOD-0006NL-1E; Tue, 12 Dec 2023 19:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rDDO8-0006Ml-Po
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 19:46:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rDDO6-0002rk-Vp
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 19:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702428369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJWYJUEB3jEM4xEp/xceX6l+8zxF+4OK0aj/EVluFwc=;
 b=Tf05ry/21oaMAPg52ZvbX5CjzcKEvwDKtd6j65mcuyaCkRcEjJiDD6BVQ3MRbAkFMLL4BQ
 RyWubFuIUPhzCJlkK8ejVbioML+9sa43A8uZHCgUkwqx+V0ayph2AFAjWbwvgYvJWuCu0v
 /7mCBShV8PSas9HEzpwUTI42E4dXnJo=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-pRfkgTIFPa6jZLM1-gzjfQ-1; Tue, 12 Dec 2023 19:46:07 -0500
X-MC-Unique: pRfkgTIFPa6jZLM1-gzjfQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-591129c72d6so3050225eaf.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 16:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702428366; x=1703033166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJWYJUEB3jEM4xEp/xceX6l+8zxF+4OK0aj/EVluFwc=;
 b=cTC2YboAZrB+jxl4HfH6xI54yHcoNgWr9liTqM5R41udb9xjF13X8+aB6nGOXHx3aB
 rGtz/WMITOd9ayOQGmTvCyBLsXoichG9C/e4YYH4rRKBVPCdX6adkr6ObWrSWP96MMGW
 aJ0hKCfp5iMcjrg6k0LDHinyXoEeWhbm78KXZN3s1jtVSlvDGfpqkNBWe0kaTw4CTmPE
 5BXTKocTAikxZmE0Ky5pkTs4ap4SOkYVK2xrEuq61DdEvxI8e8nV4PXZEfCnIDjuoFnw
 wzP7NPYUweqFlSZ9I2UPIAcTi8BY+8wU2k1WYMnlnk0gLl10sy9VnzKpzcf3tj3scOmt
 uRBA==
X-Gm-Message-State: AOJu0YyKnz7c6Y3NcDDihTFRnAQWSlU9BVx5F++2pJC/ksxhV5WR1A0r
 fnNuf+OIqCu7lKTT901fmLhxCUYQOQIEdN+aSp2/beFORhnfrACPNxHjwkSCm5DT3ZElcLRQjJ3
 QI3ywa2XsafNcfoCz/ggnvQMc+Vk0Avw=
X-Received: by 2002:a05:6358:9389:b0:16b:c63d:5dfe with SMTP id
 h9-20020a056358938900b0016bc63d5dfemr9148710rwb.16.1702428366499; 
 Tue, 12 Dec 2023 16:46:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/to82zTmPWjeoPioFw/mlTyW7kOABc7mwgxQa/63YT6l9mTR5H7i//Xs2802erEdyu+5LCdaPOyDKjVzYNrE=
X-Received: by 2002:a05:6358:9389:b0:16b:c63d:5dfe with SMTP id
 h9-20020a056358938900b0016bc63d5dfemr9148699rwb.16.1702428366150; Tue, 12 Dec
 2023 16:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-4-jsnow@redhat.com>
 <87o7fn44em.fsf@pond.sub.org>
 <CAFn=p-Zeu0O9Jvo6AvK0a5jC8VW94sSutv8S7v7_N4tkfLEr_A@mail.gmail.com>
 <87o7fmw2kp.fsf@pond.sub.org>
In-Reply-To: <87o7fmw2kp.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Dec 2023 19:45:55 -0500
Message-ID: <CAFn=p-bc2R+=jy1J18d=eeHwo6XFjAeFaNcpdTAZcU9YbvxVVg@mail.gmail.com>
Subject: Re: [PATCH 03/19] qapi/schema: name QAPISchemaInclude entities
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Nov 22, 2023 at 4:38=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Tue, Nov 21, 2023, 8:33 AM Markus Armbruster <armbru@redhat.com> wro=
te:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > It simplifies typing to mandate that entities will always have a nam=
e;
> >> > to achieve this we can occasionally assign an internal name. This
> >> > alleviates errors such as:
> >> >
> >> > qapi/schema.py:287: error: Argument 1 to "__init__" of
> >> > "QAPISchemaEntity" has incompatible type "None"; expected "str"
> >> > [arg-type]
> >> >
> >> > Trying to fix it the other way by allowing entities to only have
> >> > optional names opens up a nightmare portal of whackamole to try and
> >> > audit that every other pathway doesn't actually pass a None name whe=
n we
> >> > expect it to; this is the simpler direction of consitifying the typi=
ng.
> >>
> >> Arguably, that nightmare is compile-time proof of "we are not mistakin=
g
> >> QAPISchemaInclude for a named entity".
> >>
> >> When I added the include directive, I shoehorned it into the existing
> >> representation of the QAPI schema as "list of QAPISchemaEntity" by
> >> making it a subtype of QAPISchemaEntity.  That was a somewhat lazy hac=
k.
> >>
> >> Note that qapi-code-gen.rst distinguishes between definitions and
> >> directives.
> >>
> >> The places where mypy gripes that .name isn't 'str' generally want
> >> something with a name (what qapi-code-gen.rst calls a definition).  If
> >> we somehow pass them an include directive, they'll use None for a name=
,
> >> which is no good.  mypy is pointing out this problem.
> >>
> >> What to do about it?
> >>
> >> 1. Paper it over: give include directives some made-up name (this
> >> patch).  Now the places use the made-up name instead of None, and mypy
> >> can't see the problem anymore.
> >>
> >> 2. Assert .name is not None until mypy is happy.  I guess that's what
> >> you called opening "a nightmare portal of whackamole".
> >>
> >
> > Yep.
> >
> >
> >> 3. Clean up the typing: have a type for top-level expression (has no
> >> name), and a subtype for definition (has a name).  Rough sketch
> >> appended.  Thoughts?
> >>
> >
> > Oh, that'll work. I tried to keep to "minimal SLOC" but where you want =
to
> > see deeper fixes, I'm happy to deviate. I'll give it a shot.
>
> I do appreciate the minimal fix!  I *like* exploring "minimal" first.
> In this case, the exploration led me to not like my lazy hack anymore :)
>
> [...]
>
> > I'll try the refactor out in a patch at the end of my series and see ho=
w
> > feasible it is.
> >
> > (I haven't reviewed it deeply yet, so if there's an obvious problem I'l=
l
> > find it when I go to implement this. conceptually it seems fine.)
>
> Thanks!
>

Got this working with minor changes to sphinx's qapidox extension,
which isn't typechecked so it escaped notice. I'm going to continue
working through your feedback as-is, then when I get to the end of the
series, I'll attempt to float this patch forward to replace this patch
under discussion.

Thanks!

--js


