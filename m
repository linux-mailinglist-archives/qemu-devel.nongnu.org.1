Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BD78D55F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:02:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIxW-0004qg-SS; Wed, 30 Aug 2023 07:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qbIxG-0004nz-9R
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qbIxD-00017v-40
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693393302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ks1npDDI9YOeY8zi10GHsRVE3lxKMB5+1LohIBsLkoI=;
 b=Tpw4CsifdJus6DEh8QfY7JfdciI5Bn1SOXDH3BwtXQTm2TQeu0wMXqbmFqUJn9u27rfV7B
 iKBaCm52k+wow/sQC1Jr3hfcfEwt3/OsDUD7FOGEDtZnyj7FNGU8At6hpv+WKmH7/hh1oo
 bJkF12qezDBUWXJPQPI8DBX3e3daw+w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-P7iSTQrNM9uXYsVy0S8cZA-1; Wed, 30 Aug 2023 07:01:40 -0400
X-MC-Unique: P7iSTQrNM9uXYsVy0S8cZA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99df23d6926so397398166b.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 04:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693393299; x=1693998099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ks1npDDI9YOeY8zi10GHsRVE3lxKMB5+1LohIBsLkoI=;
 b=DVxTfdBWPmUfFW0lZleAT2Uq9uPEMLKX713XyDAIF8G9vroTHsolEBccV/PfVa6Y7H
 IlWU3pbIw09o5cpv3I42pt7++eBGjdt0LULlMKo+dzxUDaTcXqlgRsSCai+GxKNKZF/M
 M8hJCZUGeA7YjfkhtFVhqFI15wa1YmNh7jLScF0LxhViLri043pK6c/FFrmr3IlZDtds
 9qQiIm1/Lkr06qrqhM4L9ej/Ec3iZkL7fjtlYVQOm8zIfnE86DCUzjVysFucCQLTlHTS
 o7d4u1EjIu/Oe3q7P8IoeMcVhEz7s0qX5bH9lHgOVxKIgTK/Bcv9WY7GTwgBRutOYrji
 G3rA==
X-Gm-Message-State: AOJu0YwtDeiPtKSoRXfRMj/ljZ2FE7lXL32brng2ybJU68lVweYFcE03
 9Bf/3crGjRg+EczSfYWdJytAkNBmHabI0jYaNOrIdIPtCmrx3qAomEtki3GoQNfiISjNLu/IQzM
 wnAPeavsT818bZjE/pYZOFPsVmuyZ/hg=
X-Received: by 2002:a17:906:3015:b0:9a2:256a:65cd with SMTP id
 21-20020a170906301500b009a2256a65cdmr1404164ejz.4.1693393299584; 
 Wed, 30 Aug 2023 04:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHUB0CZwCEv2Kzu4pVwMhzf+/P6cu5pybuVGqlJhL9kK7MpJy5iCjIv9LAHVAQ2W3I+BeiA/NJRWar4unNY1A=
X-Received: by 2002:a17:906:3015:b0:9a2:256a:65cd with SMTP id
 21-20020a170906301500b009a2256a65cdmr1404149ejz.4.1693393299309; Wed, 30 Aug
 2023 04:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <740c7ad9-1c6f-ec7f-29d5-153bfc5f68ab@redhat.com>
In-Reply-To: <740c7ad9-1c6f-ec7f-29d5-153bfc5f68ab@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 30 Aug 2023 15:01:27 +0400
Message-ID: <CAMxuvazwReV-_W-DAGNc46xRck5OofnB60xVPSUW1BeacVahYA@mail.gmail.com>
Subject: Re: [PATCH 00/67] Make pixman an optional dependency
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
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

On Wed, Aug 30, 2023 at 2:53=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 30/08/2023 11.37, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > QEMU system emulators can be made to compile and work without pixman.
> >
> > Given how pervasively pixman types and API is used in all the code base=
, it was
> > a bit difficult to figure out how to cut the dependency.
> >
> > I decided that it was important to keep VGA and graphics device working=
 for
> > compatibility reasons, although some devices, such as xlnx Display Port=
, have
> > stronger dependency and have to be disabled. The ui/console code also h=
as a lot
> > of pixman usage and a bit of a mess to deal with. I made large refactor=
ing to
> > allow to compile out the VC code.
> >
> > The series can be roughly divded as:
> > - a few related preliminary cleanups
> > - ui/console refactoring to allow ui/vc split
> > - add a 'pixman' option, and a minimal pixman-compat.h
> > - make some parts depend on 'pixman'
> >
> > Graphic -display still work, although with some caveats. For ex, -displ=
ay sdl or
> > cocoa don't have VCs, so starting QEMU will print the following warning=
s when
> > pixman is disabled:
>
> I just had a quick look at the series, but for me it looks like this is
> adding a lot of additional complexity to the code (adds lots of #ifdefs, =
and
> adds a subset of the pixman library to the code base), which seems somewh=
at

The #ifdef aren't so bad (at least I can bare it). Just a quick stat:

$ git diff origin/master | grep "+#ifdef CONFIG_PIXMAN" | wc -l
11

> unfortunate for such a marginal feature request. What's really so bad abo=
ut
> requiring pixman for building QEMU?

Not that a good part of the series is cleaning up ui/console.c code
that really deserved it. It makes it use QOM, and split VC code. It's
still worth it regardless of the outcome for pixman.

> IMHO, if we really want to go down this path, I think we should rather
> disable all graphic related stuff in QEMU instead, i.e. disable VGA cards=
,
> Spice, SDL, etc. completely. I think this is also what has been requested=
 in
>

The various features and devices can be disabled by other means. I
think we should aim at making the different configure options
orthogonal, so QEMU without pixman can still provide most gfx/vga/UI
experience too, by default.

> the original gitlab issue ticket where the reporter wanted to compile a
> text-mode only QEMU binary...?

So that is not an incompatible goal, further tuning of configure
options can help.


