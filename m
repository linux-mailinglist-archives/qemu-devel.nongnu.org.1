Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6921975667D
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:34:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLPHq-0003E1-5E; Mon, 17 Jul 2023 10:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLPHk-0003DB-J1
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLPHi-0006Of-VF
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689604389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNCpJAmwgrPSeDRQexGz0QIWYNoG0DOP3OmWchGGEnA=;
 b=a2e02aDfK/UDv+Fpd79OQPqZl7De0jUjXfO7PSQFV/URyz9WB/I0vWGGWDMLyv6wHw2XVM
 XAGX70VO6wyWUpIrIT3uRr+S6Mo4oAdPWBATo9LNZUv5WVxqxTAfcBYdH4IuRKQzb5PLXi
 MU5j+Dcnvpjq/MaH36+hdLXbPwCu46k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-gq2-2hKLOGivZDTbnELA-A-1; Mon, 17 Jul 2023 10:33:05 -0400
X-MC-Unique: gq2-2hKLOGivZDTbnELA-A-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-518676b6d09so2690451a12.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 07:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689604384; x=1692196384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNCpJAmwgrPSeDRQexGz0QIWYNoG0DOP3OmWchGGEnA=;
 b=XvYFlNA/s0cMvLX4f82xMea1HQqXPEyL55p3vEjbqlk9WZ/DUXMkEi9TGeBfj6+8ob
 Oq6N6ErfO8iAEmscCVWTHRoapBnIo11M+D4z74irZUUyIi9JImgWvoeN/0AcynMIqr+1
 RWPXMJw/3xtrGlJsPLmAUZBMy6S5JyDJ43gPgnPMfI9LDrfwSmYFc22j/dgLA1RaXQHm
 t/FkFh/WpSMO4d+BlH8DNP7il3d07VwgnIe/SyijWJG2pJ8K7CGNY9ajhF8RHGvXjZbx
 JgRjdVXSezMWVR34aA9RJUbhofcHV6lGqGE33YWYzsE25pubVrSZWYEAzGAOkVoPAMZC
 2KgA==
X-Gm-Message-State: ABy/qLYXAlsgyhXJ094nAKhxPLGuIwE+Aw0Lu2K0IA+Mq+MtCloQrsoV
 i41q+VnXvJ0GrMTalWdTrcBduWRzyAyS7N+0Khnsh4gydCJw6e/siat1Pg8HtlfJZ2PEiAkgr1Z
 97SxZchX1tU1Ajqo=
X-Received: by 2002:aa7:ce0c:0:b0:51e:26a3:1bad with SMTP id
 d12-20020aa7ce0c000000b0051e26a31badmr12841560edv.16.1689604384086; 
 Mon, 17 Jul 2023 07:33:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGbDq8vUr99z1sZ78oft/Y4qc/OxqdaRvc1+IU8g79nkO3q7bZN+ae93uCpI1JxrtGDYEURnA==
X-Received: by 2002:aa7:ce0c:0:b0:51e:26a3:1bad with SMTP id
 d12-20020aa7ce0c000000b0051e26a31badmr12841543edv.16.1689604383785; 
 Mon, 17 Jul 2023 07:33:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 c21-20020aa7c995000000b0051d9de03516sm10003256edt.52.2023.07.17.07.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 07:33:03 -0700 (PDT)
Date: Mon, 17 Jul 2023 16:33:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Cc: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org, Stefan
 Berger <stefanb@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v2 11/11] tpm_crb: support restoring older vmstate
Message-ID: <20230717163302.1458a9bc@imammedo.users.ipa.redhat.com>
In-Reply-To: <CA+E+eSC_Hg5zxepaeCZTNiYS8oq6hNUqO8Pijft45O7vhD2q6Q@mail.gmail.com>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-12-j@getutm.app>
 <581b037d-ccb7-8df7-8946-df8198cb04e6@linux.ibm.com>
 <fe8ea892-0690-2308-5036-f31e10da0351@linux.ibm.com>
 <CA+E+eSCC2F-2bsO7OiCoS0weo7bh4daL7M5GYxa=6r-6qKcGmg@mail.gmail.com>
 <67a2b78d-8eea-7c9c-cf1b-50444e481006@linux.ibm.com>
 <562ec838-2714-2bb2-d1a5-7b98bb43a60b@linux.ibm.com>
 <CA+E+eSC_Hg5zxepaeCZTNiYS8oq6hNUqO8Pijft45O7vhD2q6Q@mail.gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 14 Jul 2023 11:49:03 -0700
Joelle van Dyne <j@getutm.app> wrote:

> On Fri, Jul 14, 2023 at 11:41=E2=80=AFAM Stefan Berger <stefanb@linux.ibm=
.com> wrote:
> >
> >
> >
> > On 7/14/23 14:22, Stefan Berger wrote: =20
> > > On 7/14/23 13:04, Joelle van Dyne wrote: =20
> > >> On Fri, Jul 14, 2023 at 7:51=E2=80=AFAM Stefan Berger <stefanb@linux=
.ibm.com> wrote: =20
> > >>>
> > >>>
> > >>>
> > >>> On 7/14/23 10:05, Stefan Berger wrote: =20
> > >>>>
> > >>>>
> > >>>> On 7/14/23 03:09, Joelle van Dyne wrote: =20
> > >>>>> When we moved to a single mapping and modified TPM CRB's VMState,=
 it
> > >>>>> broke restoring of VMs that were saved on an older version. This
> > >>>>> change allows those VMs to gracefully migrate to the new memory
> > >>>>> mapping. =20
> > >>>>
> > >>>> Thanks. This has to be in 4/11 though.
> > >>>> =20
> > >>>
> > >>> After applying the whole series and trying to resume state taken wi=
th current git
> > >>> master I cannot restore it but it leads to this error here. I would=
 just leave it
> > >>> completely untouched in 4/11.
> > >>>
> > >>> 2023-07-14T14:46:34.547550Z qemu-system-x86_64: Unknown ramblock "t=
pm-crb-cmd", cannot accept migration
> > >>> 2023-07-14T14:46:34.547799Z qemu-system-x86_64: error while loading=
 state for instance 0x0 of device 'ram'
> > >>> 2023-07-14T14:46:34.547835Z qemu-system-x86_64: load of migration f=
ailed: Invalid argument
> > >>>
> > >>>      Stefan =20
> > >>
> > >> To be clear, you are asking to back out of 4/11? That patch changes
> > >> how the registers are mapped so it's impossible to support the old
> > >> style register mapping. This patch attempts to fix that with a =20
> > >
> > > Why can we not keep the old style register mapping as 'secondary mapp=
ing'? =20
> >
> > I think the first goal should be for existing TPM CRB device not to cha=
nge anything, they
> > keep their .read and .write behaivor as it.
> >
> > If you need different .read behavior for the sysbus device due to AARCH=
64 then it may want to use its own MemoryRegionOps.
> >
> > I am fairly sure that you could refactor the core of the existing tpm_c=
rb_mmio_write() and have it work on s->regs and mmio regs.
> > The former would be used by existing code, the latter for CRB sysbus ca=
lling into this new function from a wrapper.
> >
> >     Stefan =20
>=20
> I agree that new QEMU should be able to read old QEMU state but vice
> versa is not always true. There's been many changes in the past that
> incremented the vmstate's version_id to indicate that the state format
> has changed. Also, we are not changing the .read behavior because in
> the old code, the only field that gets a dynamic update is
> tpmEstablished which we found is never changed. So effectively, .read
> is just doing a memcpy of the `regs` state. This makes it possible to
> map the page as memory while retaining the same behavior as before.
> (We are changing the code but not the behavior).
>=20
> The issue with Windows's buggy tpm.sys driver is that fundamentally it
> cannot work with MemoryRegionOps. The way MMIO is implemented is that
> a hole is left in the guest memory space so when the device registers
> are accessed, the hypervisor traps it and sends it over to QEMU to
> handle. QEMU looks up the address, sees its a valid MMIO mapping, and
> calls into the MemoryRegionOps implementation. When tpm.sys does a LDP
> instruction access to the hole, the information for QEMU to determine
> if it's a valid access is not provided. Other hypervisors like Apple's
> VZ.framework and VMware will read the guest PC, manually decode the
> AArch64 instruction, determine the type of access, read the guest Rn
> registers, does a TLB lookup to determine the physical address, then
> emulate the MMIO. None of this capability currently exists in QEMU's
> ARM64 backend. That's why we decided the easier path is to tell QEMU
> that this mapping is RAM for read purposes and MMIO only for write
> purposes (thankfully Windows does not do a STP or we'd be hosed).

CCing migration and ARM folks for more exposure


