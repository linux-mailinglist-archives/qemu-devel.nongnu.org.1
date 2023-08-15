Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3CE77D13F
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 19:40:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVy0V-0004TM-CN; Tue, 15 Aug 2023 13:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nospam@kota.moe>) id 1qVy0N-0004Su-Vz
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 13:38:56 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nospam@kota.moe>) id 1qVy0I-0003de-Cq
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 13:38:54 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-589bcdaa8a4so48193827b3.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kota.moe; s=google; t=1692121125; x=1692725925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38+iILPv0eFWaZWWEF4Q9wi5wwZIhLBHvbXBPTw9iSA=;
 b=I6tYo7O+4tVmLeV+pEkoD47X4GuFLEu31DtPelZTZJx5+qheKoSWLHUT7Dm2ngVuYt
 vRFmd67R7t90B3C+Eu7yFzxsOPfXuNwSMSnn+VZyzT5RQ71k+8PnmZlqM538ByIVJEuu
 ULWnyccMxkYWpuwsRXDHIFPhzIwQETeVeKpzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692121125; x=1692725925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38+iILPv0eFWaZWWEF4Q9wi5wwZIhLBHvbXBPTw9iSA=;
 b=Udf5LgAGzWI2duABfb81MO0Py9fMbEoNk7svZYf72hVlNx9igwxqcm1JFB2ISSZffg
 Dt4kZBkTlOzEiFxHkwo73JJZq98fQQQk/vWhzWTVex2RqE7baq74czFm1Aj+ZqSQSlk+
 vrEQTMiRw3SuGHsWWZJjrT1yeEraMNIQNOGTBvskYYMoZKMgtMtk9gizBsSbfKx1+ciN
 x0USiAbuPFxmDxmLn9ZIBAB03ychPebYOWsR2BYHkREKPkdQLtPzWeBOsIwRnbafyXm+
 E+XzD7nRAB6A7nXtYRqPH4XH11L6smFwWPbd0shZ9zgJdicmI7rqxP75NO2DTfqXPh5t
 ULEA==
X-Gm-Message-State: AOJu0YwCt86N0d2M+/ezrLC6K22VjlHR2V1OPcyW+qnQisD4r7jR1HZ8
 YKS9mvG4fwe4rOrBcn8Mc5jpwAGHg+u1ILZ1RKJUVg==
X-Google-Smtp-Source: AGHT+IHIqCuDddU3d32wG5jgNMmqOyfAHO0Fj+2pkevhCdjg6FdOFvcMIyqYxtc0gtzbPdaPgpaUnpchfCKldeAYaO0=
X-Received: by 2002:a81:91c7:0:b0:576:777f:28bc with SMTP id
 i190-20020a8191c7000000b00576777f28bcmr14985597ywg.21.1692121124765; Tue, 15
 Aug 2023 10:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230723185909.441455-1-nospam@kota.moe>
 <80dc2f6b-6cc7-c8fc-44c6-e6529c35d445@intel.com>
 <CACsxjPZ6jJKn54xyK8waLgAaHa9-60qs5p0BqH0hX5ixH0GOdg@mail.gmail.com>
In-Reply-To: <CACsxjPZ6jJKn54xyK8waLgAaHa9-60qs5p0BqH0hX5ixH0GOdg@mail.gmail.com>
From: =?UTF-8?B?4oCN5bCP5aSq?= <nospam@kota.moe>
Date: Wed, 16 Aug 2023 03:38:08 +1000
Message-ID: <CACsxjPYm_abSb375g3=Lnf09_CsRqqw395WFkNBOcbD9rYq8Ow@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Fix reporting of CPU dies when
 nr_cores=nr_threads=1
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, babu.moger@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=nospam@kota.moe; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 27 Jul 2023 at 19:16, =E2=80=8D=E5=B0=8F=E5=A4=AA <nospam@kota.moe>=
 wrote:
>
> On Thu, 27 Jul 2023 at 11:25, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> >
> > On 7/24/2023 2:59 AM, =E5=B0=8F=E5=A4=AA wrote:
> > > When QEMU is started with `-smp D,sockets=3D1,dies=3DD,cores=3D1,thre=
ads=3D1` (that
> > > is, 1 socket with D dies but each die contains just a single thread),=
 both
> > > Linux and Windows guests incorrectly interprets the system as having =
D
> > > sockets with 1 die each
> > >
> > > Ultimately this is caused by various CPUID leaves not being die-aware=
 in
> > > their "threads per socket" calculations, so this patch fixes that
> > >
> > > These changes are referenced to the AMD PPR for Family 19h Model 01h =
(Milan)
> > > and Family 17h Model 01h (Naples) manuals:
> > >   - CPUID_Fn00000001_EBX[23:16]: Number of threads in the processor
> > >                                  (Core::X86::Cpuid::SizeId[NC] + 1)
> > >   - CPUID_Fn0000000B_EBX_x01[15:0]: Number of logical cores in proces=
sor
> > >                                     socket (not present until Rome)
> > >   - CPUID_Fn80000001_ECX[1]: Multi core product
> > >                              (Core::X86::Cpuid::SizeId[NC] !=3D 0)
> > >   - CPUID_Fn80000008_ECX[7:0]: The number of threads in the package -=
 1
> > >                                (Core::X86::Cpuid::SizeId[NC])
> > >
> > > Note there are two remaining occurences that I didn't touch:
> > >   - CPUID_Fn8000001E_ECX[10:8]: Always 0 (1 node per processor) for M=
ilan.
> > >                                 But for Naples, it can also be 2 or 4=
 nodes
> > >                                 where each node is defined as one or =
two
> > >                                 CCXes (CCD?). But Milan also has mult=
iple
> > >                                 CCXes, so clearly the definition of a=
 node is
> > >                                 different from model to model, so I'v=
e left
> > >                                 it untouched. (QEMU seems to use the =
Naples
> > >                                 definition)
> > >   - MSR_CORE_THREAD_COUNT: This MSR doesn't exist on Milan or Naples
> >
> > Is this patch specific to AMD CPU type? what's situation for Intel CPU?
>
> I don't have a MCM Intel CPU to confirm against, but according to "Intel
> Architectures Software Developer=E2=80=99s Manual":
>  - 01h EBX[23:16]: Maximum number of addressable IDs for logical processo=
rs in
>                    this physical package
>  - 0Bh EBX[15:0]: The number of logical processors across all instances o=
f this
>                   domain within the next higher-scoped domain. Note: The =
0Bh
>                   leaf caps at the "core" domain, so Intel prefers using =
the 1Fh
>                   leaf instead which supports modules/tiles/dies/sockets.=
 But
>                   AMD doesn't support the 1Fh leaf yet
>  - 80000001h ECX[1]: Reserved
>  - 80000008h ECX: Reserved =3D 0
>  - 8000001Eh: Unsupported
>  - MSR_CORE_THREAD_COUNT[31:16]: The number of processor cores that are
>                                  currently enabled in the physical packag=
e
>
> So the changes seem compatible with Intel, though MSR_CORE_THREAD_COUNT s=
hould
> be updated to support dies as well. But in the absence of a MCM Intel CPU=
 to
> test with, I don't feel comfortable making that change

Friendly ping on this patch
(patchew link: https://patchew.org/QEMU/20230723185909.441455-1-nospam@kota=
.moe/)

