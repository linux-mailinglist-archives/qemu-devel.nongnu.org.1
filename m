Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E73E579D2FB
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:57:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3so-0002Vq-D9; Tue, 12 Sep 2023 09:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qg3sF-0002Qv-Np
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qg3sB-0007gc-UV
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694526970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h1Tqh9lg9MDHgSThzupRVMeYp+41rV7toTnjZQAQVvA=;
 b=dJrJf33DQPeK76oMlAPqWIlbHGUNmkzQtLE2m26XS4gsJYLjbB0yeVKxXe8luZHEcskNBE
 3XAT/T5AH07V3e2j8Q08rMv2yGLL2Anidc6ehJUyRGcr9MVaV50vY8d13PGLUS3kX19Sj5
 ode/Uu4A1MzBM3wdSHkVOkVvRDPwYfA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-SRxNtEByOWS2gajMCWwGuQ-1; Tue, 12 Sep 2023 09:56:07 -0400
X-MC-Unique: SRxNtEByOWS2gajMCWwGuQ-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-34decd3eee3so33569095ab.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694526967; x=1695131767;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h1Tqh9lg9MDHgSThzupRVMeYp+41rV7toTnjZQAQVvA=;
 b=o/Dg8KmH6p0WYxvXXmbD7JkvhylF0+fGnQcLoO4ve47chhMT8eAJ/KYlmgvnsY6iUI
 1aS/AuesUhKSlYhYXd1LY0PCbGuXxHK940lyPn8iMuDLoIWBSzXPvo20eGq/Totz0dF0
 0HUPk+z69qlsrgBDwsfps2NNg1/1Xv8fA6mlqNRpel+qiTdRy+YDLq4ESn91ZaOS2GdW
 Kxm/0j8Axp1NXHBoshpJmZvDDT5JNkVSnhyxhBVSnoeo1aaP2KMem/cdtY2CAGdFX0hA
 6moniGfOsmFSL37kr4GCEnIYVjHrv/ui8fPAFgVx17k0wsByOozAnHQmCS1AveMElsoX
 x0NA==
X-Gm-Message-State: AOJu0Ywv8FPThqlUc6rZaBBzanyjXrpYrcLI2UyqWK/4qwllRiONyUgG
 TbJjVneSUZCXEAu8XUpZjKsehiZpbK9ZdjZMUgTzRglfhY3omD+UrOhtH9fXnBK534wo/+2vTs/
 lmMIiOW2o6/4XnAo=
X-Received: by 2002:a05:6e02:180b:b0:34f:75cb:7f0 with SMTP id
 a11-20020a056e02180b00b0034f75cb07f0mr7587949ilv.12.1694526966099; 
 Tue, 12 Sep 2023 06:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/n13ghZ9TG9kXrmrp02I24XrcmAii+Xzw5ew/vN66kTGYfT7zfIv1UvcWR1fn/XGEv2rwhw==
X-Received: by 2002:a05:6e02:180b:b0:34f:75cb:7f0 with SMTP id
 a11-20020a056e02180b00b0034f75cb07f0mr7587937ilv.12.1694526965855; 
 Tue, 12 Sep 2023 06:56:05 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 z5-20020a92da05000000b003492dfb8a02sm3040757ilm.8.2023.09.12.06.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 06:56:05 -0700 (PDT)
Date: Tue, 12 Sep 2023 07:56:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shlomo Pongratz <shlomopongratz@gmail.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-discuss
 <qemu-discuss@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric
 Auger <eric.auger@redhat.com>
Subject: Re: Usage of vfio-pci without KVM.
Message-ID: <20230912075603.116e5d7e.alex.williamson@redhat.com>
In-Reply-To: <CAHzK-V2JxX7Gur_dDN2JtUbV=vWVaNefcinwLbKfu+AML2pE8A@mail.gmail.com>
References: <CAHzK-V2a-tW8BQBJNurf0QogTNYH3_oEg7HAfi-dSU_3D626Tw@mail.gmail.com>
 <be58faf9-8218-e085-7dc3-b9c2858adac8@linaro.org>
 <20230912065753.37de2393.alex.williamson@redhat.com>
 <CAHzK-V2JxX7Gur_dDN2JtUbV=vWVaNefcinwLbKfu+AML2pE8A@mail.gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 12 Sep 2023 16:22:27 +0300
Shlomo Pongratz <shlomopongratz@gmail.com> wrote:

> Hi,
> What can I as a user do to honor this requirement.
> Are you suggesting that I should patch the QEMU code as it is not
> supported out of the box?

You can reduce the VM memory, for example the mapping is starting at
1GB so using 2GB for the VM memory size would avoid the issue.
Understood that this isn't a very practical solution, but neither is
the original problem of needing to assign a high performance I/O device
to an emulated VM.  Support for such configurations is not a high
priority.  Thanks,

Alex

> On Tue, Sep 12, 2023 at 3:58=E2=80=AFPM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Tue, 12 Sep 2023 14:47:41 +0200
> > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> > =20
> > > Cc'ing VFIO maintainers.
> > >
> > > On 12/9/23 14:39, Shlomo Pongratz wrote: =20
> > > > Hi,
> > > > I'm running qemu-system-aarch64 (QEMU emulator version 7.0.93) on
> > > > Ubuntu 20.04.4 LTS i with Intel's i7.
> > > > I'm trying to pass a Samsung NVME device using vfio-pci. I detached
> > > > the device from the nvme driver and attached it to the vfio-pci.
> > > > Using lspci I can see "Kernel driver in use: vfio-pci"
> > > > In QEMU script I've written "-device vfio-pci,host=3D0000:03:00.0" =
where
> > > > 0000:03:00.0 is the device PCI address.
> > > > I get the error
> > > > qemu-system-aarch64: -device vfio-pci,host=3D0000:03:00.0: VFIO_MAP=
_DMA
> > > > failed: Invalid argument
> > > > qemu-system-aarch64: -device vfio-pci,host=3D0000:03:00.0: vfio
> > > > 0000:03:00.0: failed to setup container for group 15: memory listen=
er
> > > > initialization failed: Region mach-virt.ram:
> > > > vfio_dma_map(0x55855c75bf00, 0x40000000, 0x100000000, 0x7f5197e0000=
0)
> > > > =3D -22 (Invalid argument
> > > >
> > > > My question is vfio-pci is supported with cross architecture? =20
> >
> > It does, but reserved address ranges need to be honored.  x86 has a
> > reserved range at 0xfee00000 for MSI mapping, so the VM address space
> > needs to be such that it avoids trying to place mappings there.  Thanks,
> >
> > Alex
> > =20
>=20


