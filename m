Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C2D7B5C2C
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 22:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnPh1-0002DY-TT; Mon, 02 Oct 2023 16:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qnPh0-0002DQ-31
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qnPgy-0002Ww-Av
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696279139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/aV54WJQJRqGarRwAr8xPMYSBdn+7soO5x3+SHP+I4=;
 b=DZC6eu17ga+kBwk7TtIg7EhRvI0MdNDxoe80u5rBGFun3iV0DvMLmI/ePiPxh9sdVIIqiI
 H9L2gBzIIjbVS5MqKWUKYP4CzOTtOb0JzhwT5KLCzzKXBpzG22SFVixy26wSq8D0xjKMrC
 cSgYTIBwoypqnRRXtYvRkAbBPZjuzf8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-GMAobrNFPL-HlvUknhdlbw-1; Mon, 02 Oct 2023 16:38:48 -0400
X-MC-Unique: GMAobrNFPL-HlvUknhdlbw-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-35129e6494aso981015ab.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 13:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696279127; x=1696883927;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/aV54WJQJRqGarRwAr8xPMYSBdn+7soO5x3+SHP+I4=;
 b=Fcuw136GC0pPTVoFXlC2eRWSGu04nNIBtzScYB1WdKOUuRSgkX+DJmKevwJ4jsTiRZ
 nCXAl70LtIxuGbdI/zVoUo5STpnUGNgUwbzUCREmsyJtlC6spuuSbtt/X24+LyolPcb5
 9PghkAtddtbT90my39yFi3h8qNr32M+GGobp0Hk1d5JkxdtPijcWj7upPLZTgV/ixvQL
 8ITFu8OvDwYCaCXLiEcjc3S+BkvazxF2+XOEjDhVrHRwyET326a0k/s2h+aA2m86lC5x
 33Xy0GOSv+CmVKnlFzn7+Yrv6aOt8v7qT5SEvP2ptGKV34jKZFWpzVnQsYkDocwKzQBS
 QANw==
X-Gm-Message-State: AOJu0YzxljsnnQnaIuWyx40zE/KxqkifSv/jrBTCEotOH34sNTokKfUq
 xQ6N7YN8KrjG4DgCxmCTyEZNnTsWqACB9AHyXH0w6xMKZdSReyFoxtLrLpXUabOewelSkdpHQ7f
 AKcVrdcJDvfefIZ5//aR0SQs=
X-Received: by 2002:a92:c541:0:b0:351:526a:4ac with SMTP id
 a1-20020a92c541000000b00351526a04acmr15726735ilj.2.1696279127097; 
 Mon, 02 Oct 2023 13:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWGtRHC8UW2EfOSSy2awiyaaLiYsa+stsc37vQWCZK6OMz6STpiNGuPeOwUovBIs+e0FxLxg==
X-Received: by 2002:a92:c541:0:b0:351:526a:4ac with SMTP id
 a1-20020a92c541000000b00351526a04acmr15726716ilj.2.1696279126811; 
 Mon, 02 Oct 2023 13:38:46 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 t13-20020a02ccad000000b0042b451aa95esm6976028jap.150.2023.10.02.13.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 13:38:46 -0700 (PDT)
Date: Mon, 2 Oct 2023 14:38:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/5] ramfb: make migration conditional
Message-ID: <20231002143844.122edadf.alex.williamson@redhat.com>
In-Reply-To: <a8817c8e-8d8f-c713-b6f7-ba048aef3504@redhat.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-5-marcandre.lureau@redhat.com>
 <f0e4b89b-b88b-edfa-7855-fa41d5c72b69@redhat.com>
 <20231002084134.22fee251.alex.williamson@redhat.com>
 <05c80aca-8134-49b8-286b-853a02359ed6@redhat.com>
 <20231002132631.669de736.alex.williamson@redhat.com>
 <a8817c8e-8d8f-c713-b6f7-ba048aef3504@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Mon, 2 Oct 2023 21:41:55 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 10/2/23 21:26, Alex Williamson wrote:
> > On Mon, 2 Oct 2023 20:24:11 +0200
> > Laszlo Ersek <lersek@redhat.com> wrote:
> >  =20
> >> On 10/2/23 16:41, Alex Williamson wrote: =20
> >>> On Mon, 2 Oct 2023 15:38:10 +0200
> >>> C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> >>>    =20
> >>>> On 10/2/23 13:11, marcandre.lureau@redhat.com wrote:   =20
> >>>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>>>
> >>>>> RAMFB migration was unsupported until now, let's make it conditiona=
l.
> >>>>> The following patch will prevent machines <=3D 8.1 to migrate it.
> >>>>>
> >>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=
     =20
> >>>> Maybe localize the new 'ramfb_migrate' attribute close to 'enable_ra=
mfb'
> >>>> in VFIOPCIDevice. Anyhow,   =20
> >>>
> >>> Shouldn't this actually be tied to whether the device is migratable
> >>> (which for GVT-g - the only ramfb user afaik - it's not)?  What does =
it
> >>> mean to have a ramfb-migrate=3Dtrue property on a device that doesn't
> >>> support migration, or false on a device that does support migration. =
 I
> >>> don't understand why this is a user controllable property.  Thanks,  =
 =20
> >>
> >> The comments in <https://bugzilla.redhat.com/show_bug.cgi?id=3D1859424>
> >> (which are unfortunately not public :/ ) suggest that ramfb migration
> >> was simply forgotten when vGPU migration was implemented. So, "now
> >> that vGPU migration is done", this should be added.
> >>
> >> Comment 8 suggests that the following domain XML snippet
> >>
> >>     <hostdev mode=3D'subsystem' type=3D'mdev' managed=3D'no'
> >> model=3D'vfio-pci' display=3D'on' ramfb=3D'on'> <source>
> >>         <address uuid=3D'b155147a-663a-4009-ae7f-e9a96805b3ce'/>
> >>       </source>
> >>       <alias name=3D'ua-b155147a-663a-4009-ae7f-e9a96805b3ce'/>
> >>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x07' slot=3D'0x0=
0' =20
> >> function=3D'0x0'/> </hostdev> =20
> >>
> >> is migratable, but the ramfb device malfunctions on the destination
> >> host.
> >>
> >> There's also a huge QEMU cmdline in comment#0 of the bug; I've not
> >> tried to read that.
> >>
> >> AIUI BTW the property is not for the user to control, it's just a
> >> compat knob for versioned machine types. AIUI those are usually
> >> implemented with such (user-visible / -tweakable) device properties. =
=20
> >=20
> > If it's not for user control it's unfortunate that we expose it to the
> > user at all, but should it at least use the "x-" prefix to indicate that
> > it's not intended to be an API? =20
>=20
> I *think* it was your commit db32d0f43839 ("vfio/pci: Add option to
> disable GeForce quirks", 2018-02-06) that hda introduced me to the "x-"
> prefixed properties!
>=20
> For some reason though, machine type compat knobs are never named like
> that, AFAIR.

Maybe I'm misunderstanding your comment, but it appears quite common to
use "x-" prefix things in the compat tables...

GlobalProperty hw_compat_8_0[] =3D {
    { "migration", "multifd-flush-after-each-section", "on"},
    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
    { TYPE_VIRTIO_NET, "host_uso", "off"},
    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
};
const size_t hw_compat_8_0_len =3D G_N_ELEMENTS(hw_compat_8_0);

GlobalProperty hw_compat_7_2[] =3D {
    { "e1000e", "migrate-timadj", "off" },
    { "virtio-mem", "x-early-migration", "false" },
    { "migration", "x-preempt-pre-7-2", "true" },
    { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
};
const size_t hw_compat_7_2_len =3D G_N_ELEMENTS(hw_compat_7_2);
[etc]

> > It's still odd to think that we can
> > have scenarios of a non-migratable vfio device registering a migratable
> > ramfb, and vice versa, but I suppose in the end it doesn't matter. =20
>=20
> I do think it matters! For one, if migration is not possible with
> vfio-pci-nohotplug, then how can QE (or anyone else) *test* the patch
> (i.e. that it makes a difference)? In that case, the ramfb_setup() call
> from vfio-pci-nohotplug should just open-code "false" for the
> "migratable" parameter.

Some vfio devices support migration, most don't.  I was thinking
ramfb_setup might be called with something like:

	(vdev->ramfb_migrate && vdev->enable_migration)

so that at least the ramfb migration state matches the device, but I
think ultimately it only saves a little bit of overhead in registering
the vmstate, either one not supporting migration should block migration.

Hmm, since enable_migration is auto/on/off, it seems like device
realize should fail if set to 'on' and ramfb_migrate is false.  I think
that's the only way the device options don't become self contradictory.
Thanks,

Alex


