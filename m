Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB3C82004C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 16:36:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJEtY-0004wx-3T; Fri, 29 Dec 2023 10:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rJEtW-0004wg-5Y
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 10:35:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rJEtU-0003F2-2y
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 10:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703864125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yhbeUSIA3ihX6QlAUEvK+OqJxv2Thtj+Sqsq8BL4fao=;
 b=bus1zAbsHHJA/IWLkKTzDGy3EAXGz8yzLkhFu9UQHlBl4KGf80vRqAzfPf4h+KjcVoIC34
 adiW7lDE78GEjiqEeSTy4HSKjR9cRC0KGJ/bPfb8xtd/LEa/w30z6uUXjrM9wwt73JJmhu
 fPfJ8m83TnukLCyMVuHNkO+tYQw6NbI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-2FXqt15POs6BO6BOFrNhPw-1; Fri, 29 Dec 2023 10:35:18 -0500
X-MC-Unique: 2FXqt15POs6BO6BOFrNhPw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d54db2ab5so46554985e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 07:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703864117; x=1704468917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhbeUSIA3ihX6QlAUEvK+OqJxv2Thtj+Sqsq8BL4fao=;
 b=nzlZqPu2o8ZkL+odCzXpDBWT3rT7d24BesySrkdS3YXdMFAOfvDH/pAX/wD+Qplm8p
 sjduy6wfIbW1TAbxxvfWaR93joSErgozo+pdeMnLqhXAD8CY8yVa3WP47jcj6NwjYZ7G
 s12saDq327Kelcb4lAbXZwimyZTfUGG5tta+BjZETn8zM+0hPdy/6A81sb9PdJ110L21
 cAPOvhBGAjY369QuMzi5YGGmm37EaBsD9PvRPovbWOUpkTy7f6QGfkNgFkmAMqok0Zbv
 s8z5NJhAx8qX0u8/X2Tcq463ZUctTQiS7bjbn1XQk1trus91TG8XFjQ4bkQXP69ExWR5
 H+gQ==
X-Gm-Message-State: AOJu0YxvYZ7s7ccu3yYk1oqgdbLsyHoDMGOmOdq7Ro47e2QsaiLZDSET
 pi3DaJPP70zP9mfHEKi2MGsKfUPvYzUAoTGD1tkq5hre4GeFgtqdbju5Ek1Hmj2EtWrWmfgii+f
 Kq8gZO7RCTaYKs2GFVmJPo2o=
X-Received: by 2002:a05:600c:1c91:b0:40d:5b15:eaff with SMTP id
 k17-20020a05600c1c9100b0040d5b15eaffmr2649898wms.59.1703864117037; 
 Fri, 29 Dec 2023 07:35:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBqNHdG7QW/WLHd0jJXCMX87q4ykwEx4G4jNuBL3nSIJY0gmbFhxU6Rxl9QoKhFRBEuTrDWg==
X-Received: by 2002:a05:600c:1c91:b0:40d:5b15:eaff with SMTP id
 k17-20020a05600c1c9100b0040d5b15eaffmr2649891wms.59.1703864116729; 
 Fri, 29 Dec 2023 07:35:16 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 g15-20020a5d488f000000b00336e43e8e57sm8228770wrq.58.2023.12.29.07.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 07:35:15 -0800 (PST)
Date: Fri, 29 Dec 2023 16:35:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Ani
 Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL 31/53] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <20231229163514.72082dfd@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231130122237.3a5f79b2@imammedo.users.ipa.redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <59c230dab17176f798fb938ba4318543d9cf31d8.1687782442.git.mst@redhat.com>
 <bb7a62d4-886b-4887-94f7-c41659bfc6f6@proxmox.com>
 <ZWX1n7OWh81Dd2tJ@redhat.com>
 <76e8060f-ad71-4aa7-a675-baa735c9c2f2@proxmox.com>
 <20231128105920-mutt-send-email-mst@kernel.org>
 <20231129110107.7993894d@imammedo.users.ipa.redhat.com>
 <20231130122237.3a5f79b2@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.553,
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

On Thu, 30 Nov 2023 12:22:37 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 29 Nov 2023 11:01:07 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > On Tue, 28 Nov 2023 11:00:29 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >  =20
> > > On Tue, Nov 28, 2023 at 03:53:21PM +0100, Fiona Ebner wrote:   =20
> > > > Am 28.11.23 um 15:13 schrieb Daniel P. Berrang=C3=A9:     =20
> > > > > On Tue, Nov 28, 2023 at 02:57:17PM +0100, Fiona Ebner wrote:     =
=20
> > > > >> we received some reports about the new default causing issues for
> > > > >> certain guest OSes [0][1]. Namely, for Juniper vSRX, where boot =
fails
> > > > >> and Microsoft Windows, where querying an UUID set via QEMU cmdli=
ne
> > > > >> -smbios 'type=3D1,uuid=3Da4656bd0-a07d-48e0-9dfd-bdc84667a8d0'
> > > > >> in Powershell with
> > > > >> get-wmiobject win32_computersystemproduct | Select-Object
> > > > >> -expandProperty UUID
> > > > >> doesn't return any value anymore and can trip up some guest
> > > > >> applications. The original report is about Windows 10 and I repr=
oduced
> > > > >> this with Windows Server 2019 and the German (but I hope it does=
n't
> > > > >> matter this time) version of Windows Server 2022.
> > > > >>
> > > > >> Using machine type 8.0 or the machine option smbios-entry-point-=
type=3D32
> > > > >> are workarounds.
> > > > >>
> > > > >> Since Windows is widely used, that seems a bit unfortunate. Just=
 wanted
> > > > >> to ask if you are aware of the issue and if there is something e=
lse that
> > > > >> can be done other than specifying the more specific machine comm=
andline
> > > > >> for those OSes?     =20
> > > > >=20
> > > > > I don't recall seeing this issue mentioned before. Could you file=
 a
> > > > > bug at https://gitlab.com/qemu-project/qemu
> > > > >      =20
> > > >=20
> > > > I made one for the Windows issue:
> > > > https://gitlab.com/qemu-project/qemu/-/issues/2008
> > > >=20
> > > > It's not clear to me if this is a bug in QEMU or just a bug/limitat=
ion
> > > > of the guest OS when 64 bit entry is used by SMBIOS.
> > > >=20
> > > > I didn't create one for vSRX, because I'm not using it myself and s=
ince
> > > > it's based on FreeBSD and FreeBSD 13.1 can boot just fine with both=
 32
> > > > and 64 bit entry, it might be an issue on their side.
> > > >=20
> > > > Best Regards,
> > > > Fiona     =20
> > >=20
> > > I would be inclined to limit this to when we have too many VCPUs then.
> > > Igor WDYT?   =20
> >=20
> > Let me try to reproduce and see if Windows debug logs would provide som=
e clue. =20
>=20
> Nothing notable in debug output on Windows side, but it looks like Windows
> doesn't see SMBIOS tables at all.
>=20
> However it affects VMs with Seabios only, UEFI based VMs work just fine.
> My guess would be it's not QEMU issue, but Seabios one.
> I'm still looking at it,
> but CCing Gerd, who might have an idea what's going wrong from firmware p=
ov.=20
>=20

So running Seabios VM with Win10 as a guest under debugger
(set access breakpoint on SMBIOS anchor string), one can see
that Windows doesn't look for _SM3_ signature during lookup
at all. While after some convincing and making make lookup
code return SMBIOS 3.x entrypoint, the rest of Windows handles
SMBIOS 3.x just fine and shows UUID /using Fiona's reproducer/.

So it's bug in Windows.

As for qemu, I'd guess we'd just have to live with it until MS
fixes it and even after that it won't help with unsupported versions
as they are not likely to get fix.

To that effect, we have 3 options:
   1. make mgmt force 32bit entry point if they are starting Windows VM
   2. unconditionally switch pc|q35 9.0+ machine types to 32bit entry point
      and error out if configuration doesn't fit into SMBIOS 2.0 tables
      (easiest from QEMU pov)
   3. introduce 'auto' value for smbios entry point option, and then
      try to stick with 32bit entry point while it is usable
      (cpu count < 256 and tables still fit in guest's FSEG RAM).
      When that fails switch dynamically to 64bit entry point.

Any opinions on preferable route?

I'm looking into my least favorite option 3 atm, and it's pretty messy
with current SMBIOS code and needs quite a bit of cleanup.


