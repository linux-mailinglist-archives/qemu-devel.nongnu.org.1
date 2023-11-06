Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D07FE7E1E03
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:12:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwaH-0007e2-Bm; Mon, 06 Nov 2023 05:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzwaC-0007bQ-Uz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:11:48 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzwaB-0002da-8m
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:11:48 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54394328f65so7048443a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 02:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699265505; x=1699870305; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rF+LwVl6ym/Lmp8o0AVuSwtcAV8h/oI3adg/ZE+VdP8=;
 b=UhBLkrBUQCDBxKWZPjg1cTa/Jq6oFen35Nmm1fuUGPprM/7/EjKx3N/LTpArrVJA4P
 9W5J7K1w/V6qHweGFtRhA9MFQrKIhlchBdSeCiZqrJrSbv+DFhbCqAxgagfndiRs2jzS
 Cu/llqQcsIeLyAiiETyTGjIJ+icTgxGqbUQfG2IMAOcdbeU5YYOO9lUkwh1t+180vPdw
 tqcj3IyaWpWBaWKpnBQIX8CQzpZBFFguR8t9il1DZ6AmYYMAB1QxXZSrTKJ4qv0i1+H5
 h7HMo2h44meB6NDaSLF6vBzFI7cGUW72wzLE/KyUx3RWkbSKd4ddgsEdz3Ggl+ho4zF7
 AuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699265505; x=1699870305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rF+LwVl6ym/Lmp8o0AVuSwtcAV8h/oI3adg/ZE+VdP8=;
 b=C9c6zSxZAYHdY9nijQbTD3Z6XudOqmCYvLhiha58lF4uSHRIAQYmRqDiC8SYMdsqJW
 u8OLF8hUCQxVxl1He/5/2L99TE7MFBWn+1NTQ9JH65i1LU9uuuPllPuEtbjF6s/YoyE2
 ZCEdYi4iAyvrfnyPvhfnTQ/c1Yy8ldYuT4hnxzURo7PBuzKNxrCMkWflYbv7KpsRTjM1
 gPQwt1v2ngrLvk+pHofgbZTykgNt/kbJdRcAssKczHDLhpd9XrnkgkwxU06A4vlbKsnG
 I+XiXYbMI3YBkNeqBR4xgK6pRXgo02l4fGfBECZreFFuue6aSJDgtVOoLQMA6snmBPux
 mtyw==
X-Gm-Message-State: AOJu0YxuI4BfgZfkjv3XCjaZsWthMlvsgFhopqYOh5pJonx9cJjWhh8v
 SYzDDB+m5AaHeBWbqhHM/uV1KZr2WQwEHXZsV60=
X-Google-Smtp-Source: AGHT+IGyDg7WzwubkJN9Or9PKm2filrSTh0d8y0iJOIF4LQ8pHmjq1JTWeju1kUV97/2O4QnICFsw+TVNYOhWIYNks0=
X-Received: by 2002:a17:907:25cb:b0:9e0:727a:e491 with SMTP id
 ae11-20020a17090725cb00b009e0727ae491mr2095622ejc.35.1699265504858; Mon, 06
 Nov 2023 02:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
 <20231106095542.1852973-23-marcandre.lureau@redhat.com>
 <4da573ce-756e-d31b-5c13-4e0f8245dd08@linaro.org>
In-Reply-To: <4da573ce-756e-d31b-5c13-4e0f8245dd08@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Nov 2023 14:11:32 +0400
Message-ID: <CAJ+F1C+c73Aura=JEWyp7z4_3eiNzV1Z8BOeURjJ+2YUucatCA@mail.gmail.com>
Subject: Re: [PULL v2 22/24] hw/display: make ATI_VGA depend on PIXMAN
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x52d.google.com
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

Hi Philippe

On Mon, Nov 6, 2023 at 2:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> Cc'ing Fuloong maintainers,
>
> On 6/11/23 10:55, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > To avoid a kconfig cycle, change "depends on PCI" to "select PCI".
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
> > ---
> >   configs/devices/mips64el-softmmu/default.mak | 3 +--
> >   hw/display/Kconfig                           | 3 ++-
> >   hw/display/meson.build                       | 2 +-
> >   hw/mips/Kconfig                              | 2 ++
> >   4 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/configs/devices/mips64el-softmmu/default.mak b/configs/dev=
ices/mips64el-softmmu/default.mak
> > index d5188f7ea5..4d80d60511 100644
> > --- a/configs/devices/mips64el-softmmu/default.mak
> > +++ b/configs/devices/mips64el-softmmu/default.mak
> > @@ -1,9 +1,8 @@
> >   # Default configuration for mips64el-softmmu
> >
> >   include ../mips-softmmu/common.mak
> > -CONFIG_FULOONG=3Dy
> > +#CONFIG_FULOONG=3Dy
>
> Why is the justification to disable this board? From the
> bare "avoid a kconfig cycle" commit message, it is not
> obvious to me.

It's not actually disabled, it's enabled by default in kconfig.

>
> >   CONFIG_LOONGSON3V=3Dy
> > -CONFIG_ATI_VGA=3Dy
> >   CONFIG_RTL8139_PCI=3Dy
> >   CONFIG_JAZZ=3Dy
> >   CONFIG_VT82C686=3Dy
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 1aafe1923d..8219225a1c 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -125,7 +125,8 @@ config DPCD
> >   config ATI_VGA
> >       bool
> >       default y if PCI_DEVICES
> > -    depends on PCI
> > +    depends on PIXMAN
> > +    select PCI
> >       select VGA
> >       select BITBANG_I2C
> >       select DDC
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index 9c06aaee20..344dfe3d8c 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -62,7 +62,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_tru=
e: files('xlnx_dp.c'))
> >
> >   system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
> >
> > -system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c'=
, 'ati_2d.c', 'ati_dbg.c'))
> > +system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d=
.c', 'ati_dbg.c'), pixman])
> >
> >
> >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> > diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> > index ac1eb06a51..5d40795c0b 100644
> > --- a/hw/mips/Kconfig
> > +++ b/hw/mips/Kconfig
> > @@ -32,7 +32,9 @@ config JAZZ
> >
> >   config FULOONG
> >       bool
> > +    default y if MIPS64

It's now enabled here by default for mips64

> >       select PCI_BONITO
> > +    depends on ATI_VGA
> >
> >   config LOONGSON3V
> >       bool
>
>


--=20
Marc-Andr=C3=A9 Lureau

