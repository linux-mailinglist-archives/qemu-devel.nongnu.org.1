Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EAA7E32A2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 02:39:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0B1t-00076q-KJ; Mon, 06 Nov 2023 20:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0B1r-00076f-9t
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 20:37:19 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0B1h-0001ql-El
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 20:37:19 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5875e2b27c5so2685721eaf.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 17:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699321026; x=1699925826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKMk281OOMeMDSF0B4UqA1v7FUyiC36MmqJF7+LtSt4=;
 b=jta5JUj+hju7gb+Rg2bBN6tcKFJx2rwpwFX4JrpfeOrVx1VFI2XYOcmRz8I1/sjUuX
 MAEd2LpBhLaQvzzUgeRfoQo7QTpgcTqereuQu4djYVgQqRUEgDc39BUo9rjrh4+ZyL8c
 eKccDs/wQo7aqhvj+FzRekmDFn0ZnQzplBg8wpKWlYZ88fCguTCd9/SofUhr5hAYS4HY
 sTFlikBeuEIEKRHEMqyJGNYHmq5c9O6pC2tQtjztZDBVVkfSoUkBR331Pzv7AYHgDj4f
 E5W2kbAskPRCqKXgg82+N9wCn7xEpk280lE4rIJ49mcCxHUIxMhioqsHHLxH2MIbLd+s
 VYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699321026; x=1699925826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oKMk281OOMeMDSF0B4UqA1v7FUyiC36MmqJF7+LtSt4=;
 b=EDvnXnY1yOh8U1R+C+8orOBHAJb5MCJgwco3CAi3XAEdmhAF3ER6ce0lS5O2ygpHF/
 iIEcHgESAofhGlUbixTUXiH1vJ5gVwFFZLdr7l6SBNnI8QNqFD4TSB1jH25X9Y91voD7
 ImMgMfh1pkqoF29Dd72tLb24+JgcKhxKCxqt4TQpzOnHfs7IZNL/KNszOqujtzZEyMZn
 FOpy0d5e7lhUkNmId2e0JrQM4zbXcIIQZIVcDHieHtxamvfGineYidtGsn0HNrMsTo53
 Au84Eg3lzCbjaUtIk1lzPPWm8OizU6tsi31Vp+V3eIi0OupZ1Dhc2OwfkfLe+sPE7oCJ
 ovgQ==
X-Gm-Message-State: AOJu0Yx7ZbYCSJ5qj+Ht9m7aRmrKiiEvWCKXv6FFJjn4/Kkrqw5NMlA1
 y3sMV+bNZY4i8CBWX0oyGdDoloehHgT6ROtQsAs=
X-Google-Smtp-Source: AGHT+IE5+1A/ZxCO84sIl6j+Gd1sIbL39P8QNzya3C4TW7aIdrXMNq4GzYPvdMVwue+L+MjTkpExrYzHvR+x3i6li/A=
X-Received: by 2002:a4a:ba06:0:b0:582:99ae:ca47 with SMTP id
 b6-20020a4aba06000000b0058299aeca47mr27807598oop.3.1699321026250; Mon, 06 Nov
 2023 17:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
 <20231106095542.1852973-23-marcandre.lureau@redhat.com>
 <4da573ce-756e-d31b-5c13-4e0f8245dd08@linaro.org>
 <CAJ+F1C+c73Aura=JEWyp7z4_3eiNzV1Z8BOeURjJ+2YUucatCA@mail.gmail.com>
 <5f8901af-17e7-daec-4e02-ba1df3f5dbb6@linaro.org>
 <eefcde0e-2409-f119-9b00-6746ca3cf819@eik.bme.hu>
 <CAJ+F1C+Z3_iGnnyGNZgqGW511oET=TWb7qZerBWdnkbYxDqjww@mail.gmail.com>
 <22f2b9d8-8893-0a78-a55c-1ecb482bfad2@eik.bme.hu>
 <CAJSP0QUDDMgoRSZ0bYjhjUo3YScJerUdawSaoNNVWyQ6Up=q+g@mail.gmail.com>
 <94018b35-7a33-7887-f1a8-13a9ee7b6542@eik.bme.hu>
In-Reply-To: <94018b35-7a33-7887-f1a8-13a9ee7b6542@eik.bme.hu>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 7 Nov 2023 09:36:54 +0800
Message-ID: <CAJSP0QUZcmzecB2QwyRum9mjabNsT=E3UgLLcRmwdkdyow5acA@mail.gmail.com>
Subject: Re: [PULL v2 22/24] hw/display: make ATI_VGA depend on PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2e.google.com
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

On Tue, 7 Nov 2023 at 09:10, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Tue, 7 Nov 2023, Stefan Hajnoczi wrote:
> > On Mon, 6 Nov 2023 at 19:04, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >>
> >> On Mon, 6 Nov 2023, Marc-Andr=C3=A9 Lureau wrote:
> >>> Hi Zoltan
> >>>
> >>> On Mon, Nov 6, 2023 at 2:53=E2=80=AFPM BALATON Zoltan <balaton@eik.bm=
e.hu> wrote:
> >>>>
> >>>> On Mon, 6 Nov 2023, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>> On 6/11/23 11:11, Marc-Andr=C3=A9 Lureau wrote:
> >>>>>> Hi Philippe
> >>>>>>
> >>>>>> On Mon, Nov 6, 2023 at 2:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9=
 <philmd@linaro.org>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> Hi Marc-Andr=C3=A9,
> >>>>>>>
> >>>>>>> Cc'ing Fuloong maintainers,
> >>>>>>>
> >>>>>>> On 6/11/23 10:55, marcandre.lureau@redhat.com wrote:
> >>>>>>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>>>>>>
> >>>>>>>> To avoid a kconfig cycle, change "depends on PCI" to "select PCI=
".
> >>>>>>>>
> >>>>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om>
> >>>>>>>> Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>>>>>>> ---
> >>>>>>>>    configs/devices/mips64el-softmmu/default.mak | 3 +--
> >>>>>>>>    hw/display/Kconfig                           | 3 ++-
> >>>>>>>>    hw/display/meson.build                       | 2 +-
> >>>>>>>>    hw/mips/Kconfig                              | 2 ++
> >>>>>>>>    4 files changed, 6 insertions(+), 4 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/configs/devices/mips64el-softmmu/default.mak
> >>>>>>>> b/configs/devices/mips64el-softmmu/default.mak
> >>>>>>>> index d5188f7ea5..4d80d60511 100644
> >>>>>>>> --- a/configs/devices/mips64el-softmmu/default.mak
> >>>>>>>> +++ b/configs/devices/mips64el-softmmu/default.mak
> >>>>>>>> @@ -1,9 +1,8 @@
> >>>>>>>>    # Default configuration for mips64el-softmmu
> >>>>>>>>
> >>>>>>>>    include ../mips-softmmu/common.mak
> >>>>>>>> -CONFIG_FULOONG=3Dy
> >>>>>>>> +#CONFIG_FULOONG=3Dy
> >>>>>>>
> >>>>>>> Why is the justification to disable this board? From the
> >>>>>>> bare "avoid a kconfig cycle" commit message, it is not
> >>>>>>> obvious to me.
> >>>>>>
> >>>>>> It's not actually disabled, it's enabled by default in kconfig.
> >>>>>
> >>>>> OK, so let's remove the line entirely, not comment it, please.
> >>>>
> >>>> Well it's disabled without pixman... I have a series adding fallback=
s to
> >>>> ati-vga similar to sm501 (which is also needed on aarch64 macOS wher=
e
> >>>> pixman does not work) and with that this isn't needed. So I think it=
's
> >>>> better to rebase this series on mine then some of this becomes
> >>>> unnecessary.
> >>>>
> >>>
> >>>
> >>> It's not ready yet though. We can later revert some of this change
> >>
> >> What's not ready about it?
> >>
> >>> when your fallback version is applied. In the meantime, this doesn't
> >>> change the behaviour unless PIXMAN has been disabled, so it should be
> >>> acceptable. Agree? thanks
> >>
> >> I think it would be better to not commit something that should be reve=
rted
> >> soon. I understand you don't want to rebase yout series but I also don=
't
> >> want to revert it later so either do the rebase now or hold off with t=
his
> >> series until after mine got in please.
> >
> > QEMU 8.2 soft freeze is today. If you both can resolve this and send
> > pull requests today, then the changes will make it into 8.2.
> > Otherwise, asking for this pull request to be rebased has the effect
> > of delaying it until 8.3.
> >
> > I'll keep an eye on this series today.
>
> Marc-Andr=C3=A9 has sent a pull request that contains my ati-vga series:
> https://patchew.org/QEMU/20231106133219.2173660-1-marcandre.lureau@redhat=
.com/
> so I think he intends to rebase this series and send another version toda=
y
> or come back to this later. (8.3 will be called 9.0 by the way).

Excellent, thanks!

Stefan

