Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7A27B6400
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:24:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnagc-0003kl-3a; Tue, 03 Oct 2023 04:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qnagZ-0003kH-1n
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:23:19 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qnagX-0007Bs-2b
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:23:18 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4181bd07f25so5201321cf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696321395; x=1696926195; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSDU7QEL4ZZlzJvG0gdFawzElY5cEeu/P+ejx7y3vkY=;
 b=E4BmBSj6ZvbybbU73pgnRpQIMkxeXt/fCSNxBLzOb0l8+Bq7jmLpOBFwv9dZ1oi082
 7abcYM3h4VVOiGveEsZsLKJKrV541C5LrKMjLmpxxGDMCvvGnaYKJpjZFeUYvD5UOdPt
 8sVsgC1018WljhwZCbe3emAZlwdqMLFgs1vn/Jq2oOwsK9dFnhzQr9oYSf9xUeUkIa4L
 SxeZisY8uDuPfgHFjq3J5E2cRVFr1mrxemUltstobupz99FccNbvMJrYTvqb/O57+j22
 R+meIo2iQf735MlZr8vpc+Zs06r4sWGdHZ8z5UgJ1tQJh3NXLjSEKcM8eS2w5gpYc+18
 pvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321395; x=1696926195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSDU7QEL4ZZlzJvG0gdFawzElY5cEeu/P+ejx7y3vkY=;
 b=hIC/GEumwlkXF6UW/yPelmhVUrjs2IOE/HNvlWeWNsAJl93TsduMLk7GEgl0467sUe
 8vPfQvc53Ch1uVFE3s8oAAyMmYplhGJu16H+8liGDWr6EI4XRVcH+Oswu9+9k1r0wsXH
 QBN2KFPAAZGeWZyIpMyF17xbuEf58uWWfiwImJqbWi3u8gYxWk/iexcDbPyStVcfu9XO
 Ua0VlDOYY/+1f9EWxh0S01fFdQN3twI+9FCL9a365WYMh+tt7rl3NIXEkhFfVNN9KDar
 7mOQTo+WDqOSiWP6sK62z7IWSb+GfdWBHjCbV3a36WGkwfHYPUiqADU7jozz8mKguJX5
 4Iig==
X-Gm-Message-State: AOJu0Ywk1rlmoutTP4U8HV/dTaGbY7kLNvzukzBsWX2I83KAJgK8z5eu
 /l0Fpk0bJ542zgTsj1kCc1QQck2vtGFB/XY8Fok=
X-Google-Smtp-Source: AGHT+IH7X3KWcDAlgOHbYUbbQSFfI/PN1fgYMFxyFSXFvj6SnkstV2zzwYAstiPU4j0TqhjAv4L7z4or1TxfvwgETcI=
X-Received: by 2002:a05:622a:308:b0:419:51be:6b5f with SMTP id
 q8-20020a05622a030800b0041951be6b5fmr15397058qtw.42.1696321395442; Tue, 03
 Oct 2023 01:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-5-marcandre.lureau@redhat.com>
 <f0e4b89b-b88b-edfa-7855-fa41d5c72b69@redhat.com>
 <20231002084134.22fee251.alex.williamson@redhat.com>
 <05c80aca-8134-49b8-286b-853a02359ed6@redhat.com>
 <20231002132631.669de736.alex.williamson@redhat.com>
 <a8817c8e-8d8f-c713-b6f7-ba048aef3504@redhat.com>
 <20231002143844.122edadf.alex.williamson@redhat.com>
 <68475685-f82d-3b4b-0632-f7cf324fe563@redhat.com>
In-Reply-To: <68475685-f82d-3b4b-0632-f7cf324fe563@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Oct 2023 12:23:03 +0400
Message-ID: <CAJ+F1CJdVCg-20WOKYFGgQ-Ecvr3jYYk7Ss8KEcQzwuDsWAxQA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ramfb: make migration conditional
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, 
 kraxel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 3, 2023 at 11:43=E2=80=AFAM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> On 10/2/23 22:38, Alex Williamson wrote:
> > On Mon, 2 Oct 2023 21:41:55 +0200
> > Laszlo Ersek <lersek@redhat.com> wrote:
> >
> >> On 10/2/23 21:26, Alex Williamson wrote:
> >>> On Mon, 2 Oct 2023 20:24:11 +0200
> >>> Laszlo Ersek <lersek@redhat.com> wrote:
> >>>
> >>>> On 10/2/23 16:41, Alex Williamson wrote:
> >>>>> On Mon, 2 Oct 2023 15:38:10 +0200
> >>>>> C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> >>>>>
> >>>>>> On 10/2/23 13:11, marcandre.lureau@redhat.com wrote:
> >>>>>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>>>>>
> >>>>>>> RAMFB migration was unsupported until now, let's make it conditio=
nal.
> >>>>>>> The following patch will prevent machines <=3D 8.1 to migrate it.
> >>>>>>>
> >>>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m>
> >>>>>> Maybe localize the new 'ramfb_migrate' attribute close to 'enable_=
ramfb'
> >>>>>> in VFIOPCIDevice. Anyhow,
> >>>>>
> >>>>> Shouldn't this actually be tied to whether the device is migratable
> >>>>> (which for GVT-g - the only ramfb user afaik - it's not)?  What doe=
s it
> >>>>> mean to have a ramfb-migrate=3Dtrue property on a device that doesn=
't
> >>>>> support migration, or false on a device that does support migration=
.  I
> >>>>> don't understand why this is a user controllable property.  Thanks,
> >>>>
> >>>> The comments in <https://bugzilla.redhat.com/show_bug.cgi?id=3D18594=
24>
> >>>> (which are unfortunately not public :/ ) suggest that ramfb migratio=
n
> >>>> was simply forgotten when vGPU migration was implemented. So, "now
> >>>> that vGPU migration is done", this should be added.
> >>>>
> >>>> Comment 8 suggests that the following domain XML snippet
> >>>>
> >>>>      <hostdev mode=3D'subsystem' type=3D'mdev' managed=3D'no'
> >>>> model=3D'vfio-pci' display=3D'on' ramfb=3D'on'> <source>
> >>>>          <address uuid=3D'b155147a-663a-4009-ae7f-e9a96805b3ce'/>
> >>>>        </source>
> >>>>        <alias name=3D'ua-b155147a-663a-4009-ae7f-e9a96805b3ce'/>
> >>>>        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x07' slot=3D'=
0x00'
> >>>> function=3D'0x0'/> </hostdev>
> >>>>
> >>>> is migratable, but the ramfb device malfunctions on the destination
> >>>> host.
> >>>>
> >>>> There's also a huge QEMU cmdline in comment#0 of the bug; I've not
> >>>> tried to read that.
> >>>>
> >>>> AIUI BTW the property is not for the user to control, it's just a
> >>>> compat knob for versioned machine types. AIUI those are usually
> >>>> implemented with such (user-visible / -tweakable) device properties.
> >>>
> >>> If it's not for user control it's unfortunate that we expose it to th=
e
> >>> user at all, but should it at least use the "x-" prefix to indicate t=
hat
> >>> it's not intended to be an API?
> >>
> >> I *think* it was your commit db32d0f43839 ("vfio/pci: Add option to
> >> disable GeForce quirks", 2018-02-06) that hda introduced me to the "x-=
"
> >> prefixed properties!
> >>
> >> For some reason though, machine type compat knobs are never named like
> >> that, AFAIR.
> >
> > Maybe I'm misunderstanding your comment, but it appears quite common to
> > use "x-" prefix things in the compat tables...
> >
> > GlobalProperty hw_compat_8_0[] =3D {
> >      { "migration", "multifd-flush-after-each-section", "on"},
> >      { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> >      { TYPE_VIRTIO_NET, "host_uso", "off"},
> >      { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> >      { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> > };
> > const size_t hw_compat_8_0_len =3D G_N_ELEMENTS(hw_compat_8_0);
> >
> > GlobalProperty hw_compat_7_2[] =3D {
> >      { "e1000e", "migrate-timadj", "off" },
> >      { "virtio-mem", "x-early-migration", "false" },
> >      { "migration", "x-preempt-pre-7-2", "true" },
> >      { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
> > };
> > const size_t hw_compat_7_2_len =3D G_N_ELEMENTS(hw_compat_7_2);
> > [etc]
> >
> >>> It's still odd to think that we can
> >>> have scenarios of a non-migratable vfio device registering a migratab=
le
> >>> ramfb, and vice versa, but I suppose in the end it doesn't matter.
> >>
> >> I do think it matters! For one, if migration is not possible with
> >> vfio-pci-nohotplug, then how can QE (or anyone else) *test* the patch
> >> (i.e. that it makes a difference)? In that case, the ramfb_setup() cal=
l
> >> from vfio-pci-nohotplug should just open-code "false" for the
> >> "migratable" parameter.
> >
> > Some vfio devices support migration, most don't.  I was thinking
> > ramfb_setup might be called with something like:
> >
> >       (vdev->ramfb_migrate && vdev->enable_migration)
> >
> > so that at least the ramfb migration state matches the device, but I
> > think ultimately it only saves a little bit of overhead in registering
> > the vmstate, either one not supporting migration should block migration=
.
> >
> > Hmm, since enable_migration is auto/on/off, it seems like device
> > realize should fail if set to 'on' and ramfb_migrate is false.  I think
> > that's the only way the device options don't become self contradictory.
>
> Why isn't VFIODisplay a QOM object ? vfio_display_probe() is more or
> less a realize routine, and we have a reset and finalize handlers for it.
>
> (thinking aloud) the "ramfb-migrate" property could then be moved
> down VFIODisplay, along with the other specific display properties.
> Compatibility could be handled with property aliases. "enable_migration"
> could set "ramfb-migrate".This looks like it would be nice model cleanup.
>
> May be not the right time ?

Yes, I thought about some similar changes (though I am not sure QOM is
necessary).

Now I am trying to test my changes that add a VFIODisplay migration
subsection, but I don't think I have a GVT-g GPU (TGL GT1). When I try
with a random PCI device, I get "VFIO migration is not supported in
kernel". I can try to comment out some code, but that seems hazardous.





--
Marc-Andr=C3=A9 Lureau

