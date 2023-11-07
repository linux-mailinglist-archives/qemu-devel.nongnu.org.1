Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9B67E324A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 01:36:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0A3G-0002am-HJ; Mon, 06 Nov 2023 19:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0A3E-0002aM-3J
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 19:34:40 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0A3C-0008QK-Bf
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 19:34:39 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5844bc378feso2885095eaf.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 16:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699317277; x=1699922077; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0bPwB8dYEWKEujNXhtm7/5XVsZAMMJhc6gBAZqUj+Y=;
 b=CGRgh6AUEHAc8vpWKTHSjPBnluvlJb9VTPk1yFZ0A5KPIzHcutIaas6AI7Du33iVDX
 6/b4OocK2xj9Px+2dxyjHbokv97i6X2h9YdPYEwBLDnhgFLcDFMytBBZVrfrUrA6uESK
 Ai5kAuitEZsg+0T+0k7I0QozgxJhZenDniMZkC1XGxb2fV8s2Le4btLIJ/7+Ibffeshf
 dPixhpMLSQ2jJY7SOcNSeqXhw7HlS6KmVYKCBno+rQoeKdRL31Bm0xR1LiRzinnj6TeX
 4tg6aZV4HpvItPxPBwbJ7/IKEbd52pz1WG64UPGRaplbY62SmSUbbCEQDj6UxPFzStIt
 TJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699317277; x=1699922077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0bPwB8dYEWKEujNXhtm7/5XVsZAMMJhc6gBAZqUj+Y=;
 b=sKY2nN3oVb3+QTeZWpcXy0So9QpKRrBqxu1o7DDXxcqIJ2XYrnvZtKezag7jaIQQ34
 l8v8uBcX+uiARm9i5IXCpxeTGi7JcpgL66T5Yc+KWBgHSX+llSxRvqtSkBSZ8an8e88i
 SJvyBttGA6aexp+OUdf2kN6ChfjMm/d3zdghb6EJgzbY2iJT0slBNiw7Uz3Pa8fNRLvb
 kiMqiaUl66QBeNOXWzliuRcm9spIYiBz3+7KdYvDXabzDKK9x5w13MRRmhf6+qSB4QFT
 OGAbstsVkkfnVScBP3Mo/PTTo9KfpzbyeLxGrXGfA4BKt64UoEA6auIvGpjX2GPKCMba
 CBdg==
X-Gm-Message-State: AOJu0YzrRZPuQJM7BHHqQSsdeyy9qaFesNFSe52keb2P2/cToCPBvZ9d
 tJoRW4WTzdGWp+ekbPsusuSOhFbeVfgk7RxAG7E=
X-Google-Smtp-Source: AGHT+IHiLnXqlTIlEVmNz6LPpUhwYp59R+Y0PV3p4sDySrRPkEMTf9gPAM+Z9NosDg7+0ZptDEvm1bilvS39m0WGdIw=
X-Received: by 2002:a4a:d68b:0:b0:586:8c18:ddd9 with SMTP id
 i11-20020a4ad68b000000b005868c18ddd9mr28019261oot.9.1699317276648; Mon, 06
 Nov 2023 16:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
 <20231106095542.1852973-23-marcandre.lureau@redhat.com>
 <4da573ce-756e-d31b-5c13-4e0f8245dd08@linaro.org>
 <CAJ+F1C+c73Aura=JEWyp7z4_3eiNzV1Z8BOeURjJ+2YUucatCA@mail.gmail.com>
 <5f8901af-17e7-daec-4e02-ba1df3f5dbb6@linaro.org>
 <eefcde0e-2409-f119-9b00-6746ca3cf819@eik.bme.hu>
 <CAJ+F1C+Z3_iGnnyGNZgqGW511oET=TWb7qZerBWdnkbYxDqjww@mail.gmail.com>
 <22f2b9d8-8893-0a78-a55c-1ecb482bfad2@eik.bme.hu>
In-Reply-To: <22f2b9d8-8893-0a78-a55c-1ecb482bfad2@eik.bme.hu>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 7 Nov 2023 08:34:24 +0800
Message-ID: <CAJSP0QUDDMgoRSZ0bYjhjUo3YScJerUdawSaoNNVWyQ6Up=q+g@mail.gmail.com>
Subject: Re: [PULL v2 22/24] hw/display: make ATI_VGA depend on PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 6 Nov 2023 at 19:04, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Mon, 6 Nov 2023, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Zoltan
> >
> > On Mon, Nov 6, 2023 at 2:53=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.=
hu> wrote:
> >>
> >> On Mon, 6 Nov 2023, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> On 6/11/23 11:11, Marc-Andr=C3=A9 Lureau wrote:
> >>>> Hi Philippe
> >>>>
> >>>> On Mon, Nov 6, 2023 at 2:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <=
philmd@linaro.org>
> >>>> wrote:
> >>>>>
> >>>>> Hi Marc-Andr=C3=A9,
> >>>>>
> >>>>> Cc'ing Fuloong maintainers,
> >>>>>
> >>>>> On 6/11/23 10:55, marcandre.lureau@redhat.com wrote:
> >>>>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>>>>
> >>>>>> To avoid a kconfig cycle, change "depends on PCI" to "select PCI".
> >>>>>>
> >>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com=
>
> >>>>>> Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>>>>> ---
> >>>>>>    configs/devices/mips64el-softmmu/default.mak | 3 +--
> >>>>>>    hw/display/Kconfig                           | 3 ++-
> >>>>>>    hw/display/meson.build                       | 2 +-
> >>>>>>    hw/mips/Kconfig                              | 2 ++
> >>>>>>    4 files changed, 6 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> diff --git a/configs/devices/mips64el-softmmu/default.mak
> >>>>>> b/configs/devices/mips64el-softmmu/default.mak
> >>>>>> index d5188f7ea5..4d80d60511 100644
> >>>>>> --- a/configs/devices/mips64el-softmmu/default.mak
> >>>>>> +++ b/configs/devices/mips64el-softmmu/default.mak
> >>>>>> @@ -1,9 +1,8 @@
> >>>>>>    # Default configuration for mips64el-softmmu
> >>>>>>
> >>>>>>    include ../mips-softmmu/common.mak
> >>>>>> -CONFIG_FULOONG=3Dy
> >>>>>> +#CONFIG_FULOONG=3Dy
> >>>>>
> >>>>> Why is the justification to disable this board? From the
> >>>>> bare "avoid a kconfig cycle" commit message, it is not
> >>>>> obvious to me.
> >>>>
> >>>> It's not actually disabled, it's enabled by default in kconfig.
> >>>
> >>> OK, so let's remove the line entirely, not comment it, please.
> >>
> >> Well it's disabled without pixman... I have a series adding fallbacks =
to
> >> ati-vga similar to sm501 (which is also needed on aarch64 macOS where
> >> pixman does not work) and with that this isn't needed. So I think it's
> >> better to rebase this series on mine then some of this becomes
> >> unnecessary.
> >>
> >
> >
> > It's not ready yet though. We can later revert some of this change
>
> What's not ready about it?
>
> > when your fallback version is applied. In the meantime, this doesn't
> > change the behaviour unless PIXMAN has been disabled, so it should be
> > acceptable. Agree? thanks
>
> I think it would be better to not commit something that should be reverte=
d
> soon. I understand you don't want to rebase yout series but I also don't
> want to revert it later so either do the rebase now or hold off with this
> series until after mine got in please.

QEMU 8.2 soft freeze is today. If you both can resolve this and send
pull requests today, then the changes will make it into 8.2.
Otherwise, asking for this pull request to be rebased has the effect
of delaying it until 8.3.

I'll keep an eye on this series today.

Stefan

