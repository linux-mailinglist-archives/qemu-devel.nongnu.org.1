Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1124982923A
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 02:49:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNNh8-0008Qo-Nb; Tue, 09 Jan 2024 20:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNNh6-0008Pw-OD
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 20:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rNNh1-0007LU-Th
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 20:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704851259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tlc8v96DZBM6dkLwGNX44S7stKN12fUNSJL4TkTyfgI=;
 b=WSuCCnDjuIctSQrGy163eJ2kWEQdWBVCbWe6jVS044LK/TiN9wppsFhky0VG0l69FUYBzI
 yyGqGH9X2/H+WHYqMTLVVC8/yx0tXlOg9g7QO/Eg9mkayslHNVLnEX26ww/Ei1QpFIzODc
 1w/FbFz1fOd0V0seJnWDbLa1v74VkBE=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-3jvQ6qY-Oj2yrb0ncgPdew-1; Tue, 09 Jan 2024 20:47:37 -0500
X-MC-Unique: 3jvQ6qY-Oj2yrb0ncgPdew-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5985e220bb1so2589817eaf.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 17:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704851256; x=1705456056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tlc8v96DZBM6dkLwGNX44S7stKN12fUNSJL4TkTyfgI=;
 b=SOxiBDk11vjRGxadgQbUT9ypl12CKZ0oJIBk6FNMJ2q/tyRY5DOAzenKd7/ILhHW4Y
 UjJxZe7yG3PptcsZjlsTVkZeCfLZnIb7a9fevSoqfUeKMaoa58sO0XK1rPkSOGygtXqH
 3wP9IXis+iwGmLpAG4KvMuIzqFjS03vbBtIiBbOiISduxp9ftb+vHspHTQ409zvF0eVp
 Jye9MqTgnuYLkc+vh5RalP0j/OvOBXIhpSXQz5SI8+7/+kRpkr7oBRkc7rGbp0QkbMWn
 j1U8Wt68hwxj6JNmCmKOT3nXwEDI8NsZXnbPZWZsmzAhkMRoRkOIY9TeZeQFnLnnD8S/
 oZpg==
X-Gm-Message-State: AOJu0YwTF1rRtQYjtMUgpOXFYUEnrfOGbXsOQwPV6Zo3Tc1yeaDL1ZSv
 u+HftFhWTQ5zdhsuOQrYLSUWGe1+D9rwfsErGKCI+dzbvJsFPHgAnxF59FADgmRE070fyYGIX3t
 jz1n+MgXeNS4ELHWUp01t/9JFOpsabxnIxLN77OY=
X-Received: by 2002:a05:6358:27a8:b0:170:c1a7:254 with SMTP id
 l40-20020a05635827a800b00170c1a70254mr320391rwb.2.1704851256331; 
 Tue, 09 Jan 2024 17:47:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEu2CksaWrFk24VKLZlLbRzId/6RoMZdSGXHcAMGpZmlA/bhOfaF8CSEQ4H7RzBeDI8rEGzr52FeaWgm9iZWXA=
X-Received: by 2002:a05:6358:27a8:b0:170:c1a7:254 with SMTP id
 l40-20020a05635827a800b00170c1a70254mr320384rwb.2.1704851255990; Tue, 09 Jan
 2024 17:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-14-jsnow@redhat.com>
 <87zfz5c28s.fsf@pond.sub.org>
 <CAFn=p-bZPJNU9uLBOW1Uqts7kX-+9+dvSNRxwf+VD5hoCHJq9A@mail.gmail.com>
In-Reply-To: <CAFn=p-bZPJNU9uLBOW1Uqts7kX-+9+dvSNRxwf+VD5hoCHJq9A@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Jan 2024 20:47:24 -0500
Message-ID: <CAFn=p-bky_eAv9Z2V0zQ-_J7EygvYANa4UnxLTB9omMN-AbvbA@mail.gmail.com>
Subject: Re: [PATCH 13/19] qapi/schema: fix typing for
 QAPISchemaVariants.tag_member
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

On Wed, Nov 22, 2023 at 11:02=E2=80=AFAM John Snow <jsnow@redhat.com> wrote=
:
>
> On Wed, Nov 22, 2023 at 9:05=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
> >
> > John Snow <jsnow@redhat.com> writes:
> >
> > > There are two related changes here:
> > >
> > > (1) We need to perform type narrowing for resolving the type of
> > >     tag_member during check(), and
> > >
> > > (2) tag_member is a delayed initialization field, but we can hide it
> > >     behind a property that raises an Exception if it's called too
> > >     early. This simplifies the typing in quite a few places and avoid=
s
> > >     needing to assert that the "tag_member is not None" at a dozen
> > >     callsites, which can be confusing and suggest the wrong thing to =
a
> > >     drive-by contributor.
> > >
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> >
> > Without looking closely: review of PATCH 10 applies, doesn't it?
> >
>
> Yep!

Hm, actually, maybe not quite as cleanly.

The problem is we *are* initializing that field immediately with
whatever we were passed in during __init__, which means the field is
indeed Optional. Later, during check(), we happen to eliminate that
usage of None.

To remove the use of the @property trick here, we could:

... declare the field, then only initialize it if we were passed a
non-None value. But then check() would need to rely on something like
hasattr to check if it was set or not, which is maybe an unfortunate
code smell.
So I think you'd still wind up needing a ._tag_member field which is
Optional and always gets set during __init__, then setting a proper
.tag_member field during check().

Or I could just leave this one as-is. Or something else. I think the
dirt has to get swept somewhere, because we don't *always* have enough
information to fully initialize it at __init__ time, it's a
conditional delayed initialization, unlike the others which are
unconditionally delayed.

--js


