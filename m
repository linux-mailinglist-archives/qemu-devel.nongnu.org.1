Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 026B878D58E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:33:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJRD-0002sC-Ow; Wed, 30 Aug 2023 07:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qbJRB-0002rn-3L
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qbJR7-0000QY-QY
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693395156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FAdKzqJgCTGzzld99/DX9PIXmOHFZxiiS+UDo5q7pzc=;
 b=U+7tKDPQNBPLNa2y+6UU1O/mHy1Q/MzCOxZ+fHwVzGOW/e1NWjm9C+tIYbIINrqH3peHeM
 K+l2HzuClS81gMYMHsH0WNuKz5ZffN95k5FGG8PnnelyF9b1sKl3MT1peczL9xTNuOChZY
 j3sGr8mGymuQnTHOZvAGcoFv2cXAuUs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-59a_R0ipMdGTBjjlIvRk3g-1; Wed, 30 Aug 2023 07:32:34 -0400
X-MC-Unique: 59a_R0ipMdGTBjjlIvRk3g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-52bdadd5497so806505a12.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 04:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693395154; x=1693999954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAdKzqJgCTGzzld99/DX9PIXmOHFZxiiS+UDo5q7pzc=;
 b=kXdDRN4vtpuqm4lAk400Uq2sPlQjewRBFJWyWSffOUh8upNsWpD8QCc8tVc1Hsnz0t
 1kvI4l2KvST4EGkwSXv/XgfQ8wbHSD/2A472JAs7+jd1q23qeGl1Vy/J1kvDsD4KgJh0
 2vneAZYXwWP6xOMVrSRCyoln6ztBYGviaYu0VkBvzOy2LzGNK3EKn1+haZ4VPlEgbB8m
 Vxh1PTihhznxfag6Ijmdebfx5shClMhJ9hRRcfSCHcreFEFlUHN92JS3MpMTTeYUAQI6
 VULvf8lv3qbg4I5EorBYnAr1BZC9iVISzo106j/t6dk/vK+7cjlpWPLsx4tgK7gyNdi6
 Ccww==
X-Gm-Message-State: AOJu0YxBQnfgMbowZ8TPpbXZY2lFpsMUHtCnp5RXqjQBA/4x8noOI+1w
 BuuhB6tu2j8ILa361QobrsM0iy7IU2oUDATpQO1e4JKCtYqB+BMMLx5Aw3DxyuKWb7Liv3BTkaY
 Kq3Id1r5W9p9V0P449o6AA5JR8zyNFVs=
X-Received: by 2002:aa7:d603:0:b0:52b:c980:43f3 with SMTP id
 c3-20020aa7d603000000b0052bc98043f3mr1826142edr.28.1693395153882; 
 Wed, 30 Aug 2023 04:32:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY57X9r+OXREyBdMp+RQbF3npGkzXVEvxnQwD5tvuj0k38gV1Ajpxk4EndB/FfMSOq8CKXeYeZ6LXIDuHHpi0=
X-Received: by 2002:aa7:d603:0:b0:52b:c980:43f3 with SMTP id
 c3-20020aa7d603000000b0052bc98043f3mr1826128edr.28.1693395153600; Wed, 30 Aug
 2023 04:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <740c7ad9-1c6f-ec7f-29d5-153bfc5f68ab@redhat.com>
 <CAMxuvazwReV-_W-DAGNc46xRck5OofnB60xVPSUW1BeacVahYA@mail.gmail.com>
 <ZO8mIo+xdXK022k/@redhat.com>
In-Reply-To: <ZO8mIo+xdXK022k/@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 30 Aug 2023 15:32:21 +0400
Message-ID: <CAMxuvawVvfAwTLSm8HMCUv194hVNa=A8YFuOa2qcogPzKtSCJg@mail.gmail.com>
Subject: Re: [PATCH 00/67] Make pixman an optional dependency
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Aug 30, 2023 at 3:21=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Aug 30, 2023 at 03:01:27PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Aug 30, 2023 at 2:53=E2=80=AFPM Thomas Huth <thuth@redhat.com> =
wrote:
> > >
> > > On 30/08/2023 11.37, marcandre.lureau@redhat.com wrote:
> > > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > >
> > > > Hi,
> > > >
> > > > QEMU system emulators can be made to compile and work without pixma=
n.
> > > >
> > > > Given how pervasively pixman types and API is used in all the code =
base, it was
> > > > a bit difficult to figure out how to cut the dependency.
> > > >
> > > > I decided that it was important to keep VGA and graphics device wor=
king for
> > > > compatibility reasons, although some devices, such as xlnx Display =
Port, have
> > > > stronger dependency and have to be disabled. The ui/console code al=
so has a lot
> > > > of pixman usage and a bit of a mess to deal with. I made large refa=
ctoring to
> > > > allow to compile out the VC code.
> > > >
> > > > The series can be roughly divded as:
> > > > - a few related preliminary cleanups
> > > > - ui/console refactoring to allow ui/vc split
> > > > - add a 'pixman' option, and a minimal pixman-compat.h
> > > > - make some parts depend on 'pixman'
> > > >
> > > > Graphic -display still work, although with some caveats. For ex, -d=
isplay sdl or
> > > > cocoa don't have VCs, so starting QEMU will print the following war=
nings when
> > > > pixman is disabled:
> > >
> > > I just had a quick look at the series, but for me it looks like this =
is
> > > adding a lot of additional complexity to the code (adds lots of #ifde=
fs, and
> > > adds a subset of the pixman library to the code base), which seems so=
mewhat
> >
> > The #ifdef aren't so bad (at least I can bare it). Just a quick stat:
> >
> > $ git diff origin/master | grep "+#ifdef CONFIG_PIXMAN" | wc -l
> > 11
> >
> > > unfortunate for such a marginal feature request. What's really so bad=
 about
> > > requiring pixman for building QEMU?
> >
> > Not that a good part of the series is cleaning up ui/console.c code
> > that really deserved it. It makes it use QOM, and split VC code. It's
> > still worth it regardless of the outcome for pixman.
>
> I've done a review of the start and like the cleanup patches, and the
> adaption to make sane use of inheritance in QOM rather than the poor
> man's inheritance via the console type field. I agree that's worthwhile
> regardless of what we think about pixman optionality.
>
> > > IMHO, if we really want to go down this path, I think we should rathe=
r
> > > disable all graphic related stuff in QEMU instead, i.e. disable VGA c=
ards,
> > > Spice, SDL, etc. completely. I think this is also what has been reque=
sted in
> > >
> >
> > The various features and devices can be disabled by other means. I
> > think we should aim at making the different configure options
> > orthogonal, so QEMU without pixman can still provide most gfx/vga/UI
> > experience too, by default.
>
> To me where this series becomes dubious is roughly around the patch
> that adds pixman-compat.h providing a bunch of pixman API as stubs.

Not stubs actually... this shows that you haven't looked at it enough :)

It's really stupid, nothing like pixman! it just provides a few types.

See my reply on the patch.

Completely removing those few pixman types from QEMU will lead to a
very unpleasant and complicated result.

I can give it another try, or you may also play with it and prove me
wrong. At least, I can come up with a better list of arguments.


