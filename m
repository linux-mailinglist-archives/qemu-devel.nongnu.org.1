Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F30E7FEDB9
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 12:24:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8f84-00015V-HI; Thu, 30 Nov 2023 06:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r8f82-00015N-6r
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 06:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r8f80-0004jH-0q
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 06:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701343362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZaCl1GGneC8tumT997mcoDkSm3R+M1Ff6XIYrRha7U=;
 b=KwToZZPdJjk0qYekt7/0EWK1l2DtZCcPe9YurXUqzArwELPwwJ5j/OZt1MDEw4bm2+2L15
 Rchd/1gQK398AASJ7rwYt/30co4g/Qpe28ZOsUMCm9znXPoKgLFvf3KAaikRxqw618DpKl
 Kv9/QuSHxgyl20j1oyFSN26EXNPK12E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-cbUWCNXuNcaBNNG-VC3ALA-1; Thu, 30 Nov 2023 06:22:41 -0500
X-MC-Unique: cbUWCNXuNcaBNNG-VC3ALA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40a4c765d3bso5779495e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 03:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701343360; x=1701948160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZaCl1GGneC8tumT997mcoDkSm3R+M1Ff6XIYrRha7U=;
 b=qiJPNRgs2M96GVjvquU9w0mZsU6bCuW5MD8HKQ/4pk7kF0X1Etb6c7fWy8DrnT2Mvl
 N4fdKZWKCvV4SeiT8ahIxGxFUV67Uf9yAZ8XmuoUXbwZolJXMS0MjxmVPsUGI/z98Uki
 0YUdZchWFs6W+TGLzWgh7F0NtSO5Ynnp+tkBmCe0GIkGSzQccNP56Fz0pIZe0cdSkMGT
 J5AZBK8HDepfISOXf0eVbbvq7o4VIexChI94EbnVHESR8vLVss9OtvNXosHA0nnO24/5
 XwxaqHJXgCdMJp1tUrLOQD6Q3TcuKyNv4zVv57CZob4d7JrAt3S64GOrvQ81QZWXd36t
 P2Og==
X-Gm-Message-State: AOJu0Yz6M+CNV7xhrlIKtQEUzMdYH/ULVNdz6NKZbVM9D/PpM2kZJkuB
 s10qa40WfFioTCr9L2CnTI0ibR3IjF/FRrW+7sD/mFBsJaY4fHzTZfSC5kLQmxWfQW1Udi4fGGw
 P1yCjQswQ9uZroBs=
X-Received: by 2002:a05:600c:228e:b0:40b:53d3:7563 with SMTP id
 14-20020a05600c228e00b0040b53d37563mr3211547wmf.20.1701343360078; 
 Thu, 30 Nov 2023 03:22:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrfxGImWgL6gf/Q3zCaCqmgeMvE5hsxZHd7kg8lQ+eOuSan1k5RwFmkAji/XQKdhbK/Ba3iA==
X-Received: by 2002:a05:600c:228e:b0:40b:53d3:7563 with SMTP id
 14-20020a05600c228e00b0040b53d37563mr3211520wmf.20.1701343359690; 
 Thu, 30 Nov 2023 03:22:39 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-u.redhat.com.
 [213.175.37.12]) by smtp.gmail.com with ESMTPSA id
 iv11-20020a05600c548b00b0040b4cb14d40sm5357251wmb.19.2023.11.30.03.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 03:22:39 -0800 (PST)
Date: Thu, 30 Nov 2023 12:22:37 +0100
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
Message-ID: <20231130122237.3a5f79b2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231129110107.7993894d@imammedo.users.ipa.redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <59c230dab17176f798fb938ba4318543d9cf31d8.1687782442.git.mst@redhat.com>
 <bb7a62d4-886b-4887-94f7-c41659bfc6f6@proxmox.com>
 <ZWX1n7OWh81Dd2tJ@redhat.com>
 <76e8060f-ad71-4aa7-a675-baa735c9c2f2@proxmox.com>
 <20231128105920-mutt-send-email-mst@kernel.org>
 <20231129110107.7993894d@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 29 Nov 2023 11:01:07 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 28 Nov 2023 11:00:29 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Tue, Nov 28, 2023 at 03:53:21PM +0100, Fiona Ebner wrote: =20
> > > Am 28.11.23 um 15:13 schrieb Daniel P. Berrang=C3=A9:   =20
> > > > On Tue, Nov 28, 2023 at 02:57:17PM +0100, Fiona Ebner wrote:   =20
> > > >> we received some reports about the new default causing issues for
> > > >> certain guest OSes [0][1]. Namely, for Juniper vSRX, where boot fa=
ils
> > > >> and Microsoft Windows, where querying an UUID set via QEMU cmdline
> > > >> -smbios 'type=3D1,uuid=3Da4656bd0-a07d-48e0-9dfd-bdc84667a8d0'
> > > >> in Powershell with
> > > >> get-wmiobject win32_computersystemproduct | Select-Object
> > > >> -expandProperty UUID
> > > >> doesn't return any value anymore and can trip up some guest
> > > >> applications. The original report is about Windows 10 and I reprod=
uced
> > > >> this with Windows Server 2019 and the German (but I hope it doesn't
> > > >> matter this time) version of Windows Server 2022.
> > > >>
> > > >> Using machine type 8.0 or the machine option smbios-entry-point-ty=
pe=3D32
> > > >> are workarounds.
> > > >>
> > > >> Since Windows is widely used, that seems a bit unfortunate. Just w=
anted
> > > >> to ask if you are aware of the issue and if there is something els=
e that
> > > >> can be done other than specifying the more specific machine comman=
dline
> > > >> for those OSes?   =20
> > > >=20
> > > > I don't recall seeing this issue mentioned before. Could you file a
> > > > bug at https://gitlab.com/qemu-project/qemu
> > > >    =20
> > >=20
> > > I made one for the Windows issue:
> > > https://gitlab.com/qemu-project/qemu/-/issues/2008
> > >=20
> > > It's not clear to me if this is a bug in QEMU or just a bug/limitation
> > > of the guest OS when 64 bit entry is used by SMBIOS.
> > >=20
> > > I didn't create one for vSRX, because I'm not using it myself and sin=
ce
> > > it's based on FreeBSD and FreeBSD 13.1 can boot just fine with both 32
> > > and 64 bit entry, it might be an issue on their side.
> > >=20
> > > Best Regards,
> > > Fiona   =20
> >=20
> > I would be inclined to limit this to when we have too many VCPUs then.
> > Igor WDYT? =20
>=20
> Let me try to reproduce and see if Windows debug logs would provide some =
clue.

Nothing notable in debug output on Windows side, but it looks like Windows
doesn't see SMBIOS tables at all.

However it affects VMs with Seabios only, UEFI based VMs work just fine.
My guess would be it's not QEMU issue, but Seabios one.
I'm still looking at it,
but CCing Gerd, who might have an idea what's going wrong from firmware pov=
.=20


