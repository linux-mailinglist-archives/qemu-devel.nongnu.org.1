Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FA77E1F07
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:59:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxJG-0003se-Ma; Mon, 06 Nov 2023 05:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzxJ9-0003sI-AI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:58:15 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzxJ7-0002jc-8R
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:58:14 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9df8d0c2505so217273166b.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 02:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699268291; x=1699873091; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgWs01PByhgYlEcdJcUjMOxzuVPiIlilsY/z8b7eR7M=;
 b=Pyv/v3YIiXhsQwwrL9tI8VstkNX1rBKIJ0RS0UZVPpOlEjaRi53O5sOWZ5rmHqlZX7
 Och+10mrbd4frqrnmbRnkZBaCVgD1inpCdELiAoUOOFdN8PRcYLnFqwHyRRSeRnIt91m
 uozrke05F2qGDE+M5b/msba5R+d2uu2cOMZ5hg5v+BjhJjtLqAlPbSOUbmKPQ44G2DD5
 HSO5B/n7fL36h23l7aIU0iXKb5Q8zC+zvsw+Wva9LJAtvH0SaZ7QHmkDTg3h/D4rEMo/
 M3imoCOgslMnzsMiGQkzy85+k4HaqDqkOpl6HFqxFq5jNLcaGBLut4Ok27694zf467TY
 ALJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268291; x=1699873091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgWs01PByhgYlEcdJcUjMOxzuVPiIlilsY/z8b7eR7M=;
 b=b9hWqRqy58Cn8waL8YEZ3Jqf7g9rYXpPI3A5dfsipA0QxBIbN48C23fgBwCU+CznXk
 /rG7JTDe999MW6U4fq7kEb7y2EFhxjpNp8PdWnjXv6kAOaIp7WHODy9MUaxgL6yO06td
 3OWJDFC5xl/u8dWXrvdOWz7WALD+8bd2YY8qv8ss5T5fFNYfGf3ZA8663J70iBW6Pgm0
 wn7MSI0MRH7xZF30jJPz0DzBN4UeJnbJRJRuqq9QHASNj8XYhA/sOZFYR4Zn3oC0yGpA
 qbl/mZx0aG0V5BvEOvO7pE6DHFcgHmL0mIxAvgu2ziE1wvr6+mzin8/XZ2OIKLQFzgis
 +ohg==
X-Gm-Message-State: AOJu0YxR5Di4iqSVyNvTqcSBpldzDWrqOHJZTE2Zvqrj/+gex02HZTVC
 /d3X0v4ZHBAMkl1sx6b7AKsK6h8tqkeZ+w7gHA4=
X-Google-Smtp-Source: AGHT+IEB1smT0tQQZlGQIBlQFW01IfL//S6BO5vrKx37JT3SeT+hMJAyRrimw8Z8BnX2RAT4JH/aIrFCprtym0iVJhM=
X-Received: by 2002:a17:907:2da5:b0:9c3:97d7:2c67 with SMTP id
 gt37-20020a1709072da500b009c397d72c67mr9647450ejc.25.1699268291395; Mon, 06
 Nov 2023 02:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
 <20231106095542.1852973-23-marcandre.lureau@redhat.com>
 <4da573ce-756e-d31b-5c13-4e0f8245dd08@linaro.org>
 <CAJ+F1C+c73Aura=JEWyp7z4_3eiNzV1Z8BOeURjJ+2YUucatCA@mail.gmail.com>
 <5f8901af-17e7-daec-4e02-ba1df3f5dbb6@linaro.org>
 <eefcde0e-2409-f119-9b00-6746ca3cf819@eik.bme.hu>
In-Reply-To: <eefcde0e-2409-f119-9b00-6746ca3cf819@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Nov 2023 14:57:58 +0400
Message-ID: <CAJ+F1C+Z3_iGnnyGNZgqGW511oET=TWb7qZerBWdnkbYxDqjww@mail.gmail.com>
Subject: Re: [PULL v2 22/24] hw/display: make ATI_VGA depend on PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, stefanha@gmail.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x632.google.com
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

Hi Zoltan

On Mon, Nov 6, 2023 at 2:53=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>
> On Mon, 6 Nov 2023, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 6/11/23 11:11, Marc-Andr=C3=A9 Lureau wrote:
> >> Hi Philippe
> >>
> >> On Mon, Nov 6, 2023 at 2:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <ph=
ilmd@linaro.org>
> >> wrote:
> >>>
> >>> Hi Marc-Andr=C3=A9,
> >>>
> >>> Cc'ing Fuloong maintainers,
> >>>
> >>> On 6/11/23 10:55, marcandre.lureau@redhat.com wrote:
> >>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>>
> >>>> To avoid a kconfig cycle, change "depends on PCI" to "select PCI".
> >>>>
> >>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>> Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>>> ---
> >>>>    configs/devices/mips64el-softmmu/default.mak | 3 +--
> >>>>    hw/display/Kconfig                           | 3 ++-
> >>>>    hw/display/meson.build                       | 2 +-
> >>>>    hw/mips/Kconfig                              | 2 ++
> >>>>    4 files changed, 6 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/configs/devices/mips64el-softmmu/default.mak
> >>>> b/configs/devices/mips64el-softmmu/default.mak
> >>>> index d5188f7ea5..4d80d60511 100644
> >>>> --- a/configs/devices/mips64el-softmmu/default.mak
> >>>> +++ b/configs/devices/mips64el-softmmu/default.mak
> >>>> @@ -1,9 +1,8 @@
> >>>>    # Default configuration for mips64el-softmmu
> >>>>
> >>>>    include ../mips-softmmu/common.mak
> >>>> -CONFIG_FULOONG=3Dy
> >>>> +#CONFIG_FULOONG=3Dy
> >>>
> >>> Why is the justification to disable this board? From the
> >>> bare "avoid a kconfig cycle" commit message, it is not
> >>> obvious to me.
> >>
> >> It's not actually disabled, it's enabled by default in kconfig.
> >
> > OK, so let's remove the line entirely, not comment it, please.
>
> Well it's disabled without pixman... I have a series adding fallbacks to
> ati-vga similar to sm501 (which is also needed on aarch64 macOS where
> pixman does not work) and with that this isn't needed. So I think it's
> better to rebase this series on mine then some of this becomes
> unnecessary.
>


It's not ready yet though. We can later revert some of this change
when your fallback version is applied. In the meantime, this doesn't
change the behaviour unless PIXMAN has been disabled, so it should be
acceptable. Agree? thanks

> Regards,
> BALATON Zoltan
>
> > With that,
> >
> > Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >
> >>
> >>>
> >>>>    CONFIG_LOONGSON3V=3Dy
> >>>> -CONFIG_ATI_VGA=3Dy
> >>>>    CONFIG_RTL8139_PCI=3Dy
> >>>>    CONFIG_JAZZ=3Dy
> >>>>    CONFIG_VT82C686=3Dy
> >>>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> >>>> index 1aafe1923d..8219225a1c 100644
> >>>> --- a/hw/display/Kconfig
> >>>> +++ b/hw/display/Kconfig
> >>>> @@ -125,7 +125,8 @@ config DPCD
> >>>>    config ATI_VGA
> >>>>        bool
> >>>>        default y if PCI_DEVICES
> >>>> -    depends on PCI
> >>>> +    depends on PIXMAN
> >>>> +    select PCI
> >>>>        select VGA
> >>>>        select BITBANG_I2C
> >>>>        select DDC
> >>>> diff --git a/hw/display/meson.build b/hw/display/meson.build
> >>>> index 9c06aaee20..344dfe3d8c 100644
> >>>> --- a/hw/display/meson.build
> >>>> +++ b/hw/display/meson.build
> >>>> @@ -62,7 +62,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_=
true:
> >>>> files('xlnx_dp.c'))
> >>>>
> >>>>    system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
> >>>>
> >>>> -system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati=
.c',
> >>>> 'ati_2d.c', 'ati_dbg.c'))
> >>>> +system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c',
> >>>> 'ati_2d.c', 'ati_dbg.c'), pixman])
> >>>>
> >>>>
> >>>>    if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >>>> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> >>>> index ac1eb06a51..5d40795c0b 100644
> >>>> --- a/hw/mips/Kconfig
> >>>> +++ b/hw/mips/Kconfig
> >>>> @@ -32,7 +32,9 @@ config JAZZ
> >>>>
> >>>>    config FULOONG
> >>>>        bool
> >>>> +    default y if MIPS64
> >>
> >> It's now enabled here by default for mips64
> >>
> >>>>        select PCI_BONITO
> >>>> +    depends on ATI_VGA
> >>>>
> >>>>    config LOONGSON3V
> >>>>        bool
> >>>
> >>>
> >>
> >>
> >
> >
> >



--=20
Marc-Andr=C3=A9 Lureau

