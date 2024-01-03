Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E9C8229C7
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 09:52:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKwyb-0002n4-9i; Wed, 03 Jan 2024 03:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rKwyZ-0002ms-1c
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 03:51:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rKwyV-0001sz-VG
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 03:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704271902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ya2eV6d5OKUBqjp+5q4eGUJR5QW+y7Bh5OYKEtSQyFE=;
 b=CO9ByE6vJkLHjSrzkEsnTJM1atHeBHq3i4xVR5yO/euBNpmaf/e8O6vwsRLEBGC9aH/XRR
 vtliVU8u88LCY/Rr9EVpRzB9tNNu+bNfTstsjC/MdYIWnwDzYuhDMUo1KE1MPsmf9SSvw7
 feE9nkMdQY8EtYGhOZbJPZ/H/OuwNsY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-Xrmux1y0OLG4DQuItmLHyw-1; Wed, 03 Jan 2024 03:51:39 -0500
X-MC-Unique: Xrmux1y0OLG4DQuItmLHyw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a279cf3ded1so168594666b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 00:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704271898; x=1704876698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ya2eV6d5OKUBqjp+5q4eGUJR5QW+y7Bh5OYKEtSQyFE=;
 b=w+qAUZHBgvElZhzjuKLGLb+nmS2Muyp59noao8PBneqotFPPB116ep3PMAjxkGSbmE
 QxVqHhj1c9byvwLwADlsLOM0eJXJbm7WBc95liYJGT5TIAf71yypqUJNKjCL2TmxYRB9
 8rZF7yA/G2dubpUxQfRLXlB8ISqQaQ9+Lu7/K5H2JgAqG6o2r7rD9s8EY9w9agykZ3J7
 gl6AJ2kmWEeQfsque5gMvTda6kUUu7YYPryv2vwYmlHfGcYE3wpsuupnJjB5YY0KCIMS
 cI2tDM/iY6s3u3G/jzXZCYR9NENvxT0Tq46VPSlg5DLK/Ol1KXN0QnKjmwktWFCNH60O
 sNIw==
X-Gm-Message-State: AOJu0Yx68DKvLFNv9f7ITJjDF8yzc0Le5qy3mfs1MUpCnCpepCuWdY4H
 XS32Srz57EJvErm/HtGdPQH+Zyw8L6slbuTjcJJdmzAGkCu+13AachNClTVZ689rKjwupMgmuLS
 kQHtRCMg4NR5IyVZtqWvrIRc=
X-Received: by 2002:a17:906:4090:b0:a27:fdc1:593f with SMTP id
 u16-20020a170906409000b00a27fdc1593fmr1918960ejj.67.1704271898334; 
 Wed, 03 Jan 2024 00:51:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJEA12UKtYc/nXiZaTpLhaz4IGrhxhJHogdMFKijo2jm3NgKDeKujb03ZQJn4/MIUAxs/Euw==
X-Received: by 2002:a17:906:4090:b0:a27:fdc1:593f with SMTP id
 u16-20020a170906409000b00a27fdc1593fmr1918958ejj.67.1704271898016; 
 Wed, 03 Jan 2024 00:51:38 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a17090625c400b00a26ae76b165sm11762270ejb.115.2024.01.03.00.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 00:51:37 -0800 (PST)
Date: Wed, 3 Jan 2024 09:51:36 +0100
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
Message-ID: <20240103095136.58e37cf6@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231229104428-mutt-send-email-mst@kernel.org>
References: <cover.1687782442.git.mst@redhat.com>
 <59c230dab17176f798fb938ba4318543d9cf31d8.1687782442.git.mst@redhat.com>
 <bb7a62d4-886b-4887-94f7-c41659bfc6f6@proxmox.com>
 <ZWX1n7OWh81Dd2tJ@redhat.com>
 <76e8060f-ad71-4aa7-a675-baa735c9c2f2@proxmox.com>
 <20231128105920-mutt-send-email-mst@kernel.org>
 <20231129110107.7993894d@imammedo.users.ipa.redhat.com>
 <20231130122237.3a5f79b2@imammedo.users.ipa.redhat.com>
 <20231229163514.72082dfd@imammedo.users.ipa.redhat.com>
 <20231229104428-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
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

On Fri, 29 Dec 2023 10:45:08 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Dec 29, 2023 at 04:35:14PM +0100, Igor Mammedov wrote:
> > On Thu, 30 Nov 2023 12:22:37 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >  =20
> > > On Wed, 29 Nov 2023 11:01:07 +0100
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >  =20
> > > > On Tue, 28 Nov 2023 11:00:29 -0500
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >    =20
> > > > > On Tue, Nov 28, 2023 at 03:53:21PM +0100, Fiona Ebner wrote:     =
=20
> > > > > > Am 28.11.23 um 15:13 schrieb Daniel P. Berrang=C3=A9:       =20
> > > > > > > On Tue, Nov 28, 2023 at 02:57:17PM +0100, Fiona Ebner wrote: =
      =20
> > > > > > >> we received some reports about the new default causing issue=
s for
> > > > > > >> certain guest OSes [0][1]. Namely, for Juniper vSRX, where b=
oot fails
> > > > > > >> and Microsoft Windows, where querying an UUID set via QEMU c=
mdline
> > > > > > >> -smbios 'type=3D1,uuid=3Da4656bd0-a07d-48e0-9dfd-bdc84667a8d=
0'
> > > > > > >> in Powershell with
> > > > > > >> get-wmiobject win32_computersystemproduct | Select-Object
> > > > > > >> -expandProperty UUID
> > > > > > >> doesn't return any value anymore and can trip up some guest
> > > > > > >> applications. The original report is about Windows 10 and I =
reproduced
> > > > > > >> this with Windows Server 2019 and the German (but I hope it =
doesn't
> > > > > > >> matter this time) version of Windows Server 2022.
> > > > > > >>
> > > > > > >> Using machine type 8.0 or the machine option smbios-entry-po=
int-type=3D32
> > > > > > >> are workarounds.
> > > > > > >>
> > > > > > >> Since Windows is widely used, that seems a bit unfortunate. =
Just wanted
> > > > > > >> to ask if you are aware of the issue and if there is somethi=
ng else that
> > > > > > >> can be done other than specifying the more specific machine =
commandline
> > > > > > >> for those OSes?       =20
> > > > > > >=20
> > > > > > > I don't recall seeing this issue mentioned before. Could you =
file a
> > > > > > > bug at https://gitlab.com/qemu-project/qemu
> > > > > > >        =20
> > > > > >=20
> > > > > > I made one for the Windows issue:
> > > > > > https://gitlab.com/qemu-project/qemu/-/issues/2008
> > > > > >=20
> > > > > > It's not clear to me if this is a bug in QEMU or just a bug/lim=
itation
> > > > > > of the guest OS when 64 bit entry is used by SMBIOS.
> > > > > >=20
> > > > > > I didn't create one for vSRX, because I'm not using it myself a=
nd since
> > > > > > it's based on FreeBSD and FreeBSD 13.1 can boot just fine with =
both 32
> > > > > > and 64 bit entry, it might be an issue on their side.
> > > > > >=20
> > > > > > Best Regards,
> > > > > > Fiona       =20
> > > > >=20
> > > > > I would be inclined to limit this to when we have too many VCPUs =
then.
> > > > > Igor WDYT?     =20
> > > >=20
> > > > Let me try to reproduce and see if Windows debug logs would provide=
 some clue.   =20
> > >=20
> > > Nothing notable in debug output on Windows side, but it looks like Wi=
ndows
> > > doesn't see SMBIOS tables at all.
> > >=20
> > > However it affects VMs with Seabios only, UEFI based VMs work just fi=
ne.
> > > My guess would be it's not QEMU issue, but Seabios one.
> > > I'm still looking at it,
> > > but CCing Gerd, who might have an idea what's going wrong from firmwa=
re pov.=20
> > >  =20
> >=20
> > So running Seabios VM with Win10 as a guest under debugger
> > (set access breakpoint on SMBIOS anchor string), one can see
> > that Windows doesn't look for _SM3_ signature during lookup
> > at all. While after some convincing and making make lookup
> > code return SMBIOS 3.x entrypoint, the rest of Windows handles
> > SMBIOS 3.x just fine and shows UUID /using Fiona's reproducer/.
> >=20
> > So it's bug in Windows.
> >=20
> > As for qemu, I'd guess we'd just have to live with it until MS
> > fixes it and even after that it won't help with unsupported versions
> > as they are not likely to get fix.
> >=20
> > To that effect, we have 3 options:
> >    1. make mgmt force 32bit entry point if they are starting Windows VM
> >    2. unconditionally switch pc|q35 9.0+ machine types to 32bit entry p=
oint
> >       and error out if configuration doesn't fit into SMBIOS 2.0 tables
> >       (easiest from QEMU pov)
> >    3. introduce 'auto' value for smbios entry point option, and then
> >       try to stick with 32bit entry point while it is usable
> >       (cpu count < 256 and tables still fit in guest's FSEG RAM).
> >       When that fails switch dynamically to 64bit entry point.
> >=20
> > Any opinions on preferable route?
> >=20
> > I'm looking into my least favorite option 3 atm, and it's pretty messy
> > with current SMBIOS code and needs quite a bit of cleanup. =20
>=20
> I like 3 as the least disruptive ... but UEFI works do you know why?
Let me finish it then and see how it turns out.
With UEFI, Windows gets tables from firmware (i.e. it doesn't search,
otherwise they would've gotten bug reports long time ago).


