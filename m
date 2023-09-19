Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F38D7A5804
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 05:52:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiRlf-0002gH-2I; Mon, 18 Sep 2023 23:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiRld-0002g9-F3
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 23:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiRlO-0002Mm-Ej
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 23:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695095461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eq3y0WSmlP2oHQb22HjpMVnCQGt7S09qg1iubYNX+fg=;
 b=PJIkGRrgqPSVe4waEE+Ny4HUWxbslVCzqINalIoG5xPGVtGO5Ka5oBllSBvl0YKGsaKjqi
 5gjWOawjmryEHL95ap2pC6YKFKCA9n5ek4xi2fop9V8bCA+omZhJXSHnI+PK2+hkbgmWoL
 p/YQFZAwpuRmjPmMhcSoqfYC1xSyBY4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-aIaIQ6BjMHmepEj2HoN4AQ-1; Mon, 18 Sep 2023 23:50:58 -0400
X-MC-Unique: aIaIQ6BjMHmepEj2HoN4AQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae0bf9c0b4so116950566b.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 20:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695095457; x=1695700257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eq3y0WSmlP2oHQb22HjpMVnCQGt7S09qg1iubYNX+fg=;
 b=QxLNoWpejwmWR6CEdrtbEKyvazEfgmU/ZlJ41EEdKpak2ySyQwzFMzCXcSURm4GSth
 0+HsLPa5LZswhJ0lvBzAoHk6b3IzZc3SaanW2cHJ1E04k3nYitIEbPm9ByIR2wRk1Yhn
 60Tur8dKYYEkiK5bFeBxsu62DqaBtiu1XVPgekP5w/H7PUoUc/dsTrh4JHLPwVZFUCQf
 /wXFrU1kjMgQ5+UiTWBARdFwfqnbA9kf8AO6UkkHjGM6CA7umCWIfuesbvYq+57ni6pA
 mtcGGlDXzirORJ7pqIWeGQwg8vOOYO+sKzBUefOCa0p+n+mNdAXlebRT6jl5HyI8X8q1
 kgXw==
X-Gm-Message-State: AOJu0Yxf6NUEtR/OGbn4FvY45zpyBaSxWYZ9u3tcUs4QB2LdE+DPq37x
 kmitx4c7NuU715HcIjx64i56Cj4OKuZzMGDgYZdUkeatn9RoeWYwPAyIwvOK6i0H42pRiKXUtiJ
 faV/KSGOl0Z6rO91XY8okzAPpnjSMK2g=
X-Received: by 2002:a17:907:77c2:b0:9a9:eef6:434a with SMTP id
 kz2-20020a17090777c200b009a9eef6434amr9487429ejc.36.1695095456890; 
 Mon, 18 Sep 2023 20:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj1U/UNpiYO2EjnYIr6NRKumSMGpIR6hHQWacUxuucRt50dQfa+Jo5ZAo69tK67H5hx8wfljE6LSKRmGy6bak=
X-Received: by 2002:a17:907:77c2:b0:9a9:eef6:434a with SMTP id
 kz2-20020a17090777c200b009a9eef6434amr9487423ejc.36.1695095456613; Mon, 18
 Sep 2023 20:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135448.90963-1-anisinha@redhat.com>
 <CAK3XEhOMqdfyPBm0ZgkirrcaBhOwQt_eOZ7=bbdW8OJpz3hWHg@mail.gmail.com>
 <ceea0d9d-19d6-29e7-cb84-81f85936b8c2@redhat.com>
 <CAK3XEhNETZBGtzpv2vBzygQtYuzTrsihzQNRdK8kp3+_u590Rg@mail.gmail.com>
 <3a3b5c4a-afad-8362-088c-a531d6998c23@redhat.com>
In-Reply-To: <3a3b5c4a-afad-8362-088c-a531d6998c23@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 19 Sep 2023 09:20:45 +0530
Message-ID: <CAK3XEhPYPaJfeK5hcq+EktSn9iFVrv05H=TJ4VJNARddK1jYOA@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, philmd@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Sep 18, 2023 at 9:28=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.09.23 17:56, Ani Sinha wrote:
> > On Mon, Sep 18, 2023 at 8:59=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 18.09.23 17:22, Ani Sinha wrote:
> >>> On Mon, Sep 18, 2023 at 7:25=E2=80=AFPM Ani Sinha <anisinha@redhat.co=
m> wrote:
> >>>>
> >>>> 32-bit systems do not have a reserved memory for hole64 but they may=
 have a
> >>>> reserved memory space for memory hotplug. Since, hole64 starts after=
 the
> >>>> reserved hotplug memory, the unaligned hole64 start address gives us=
 the
> >>>> end address for this memory hotplug region that the processor may us=
e.
> >>>> Fix this. This ensures that the physical address space bound checkin=
g works
> >>>> correctly for 32-bit systems as well.
> >>>
> >>> This patch breaks some unit tests. I am not sure why it did not catch
> >>> it when I tested it before sending.
> >>> Will have to resend after fixing the tests.
> >>
> >> Probably because they supply more memory than the system can actually
> >> handle? (e.g., -m 4g on 32bit)?
> >
> > cxl tests are failing for example.
> >
> > $ ./qemu-system-i386 -display none -machine q35,cxl=3Don
> > qemu-system-i386: Address space limit 0xffffffff < 0x1000fffff
> > phys-bits too low (32)

also another thing is:

./qemu-system-i386 -machine pc -m 128
works but ...

$ ./qemu-system-i386 -machine pc -m 128,slots=3D3,maxmem=3D1G
qemu-system-i386: Address space limit 0xffffffff < 0x1f7ffffff
phys-bits too low (32)

or

$ ./qemu-system-i386 -machine pc-i440fx-8.2 -accel kvm -m 128,slots=3D3,max=
mem=3D1G
qemu-system-i386: Address space limit 0xffffffff < 0x1f7ffffff
phys-bits too low (32)

but of course after the compat knob older pc machines work fine using
the old logic :

$ ./qemu-system-i386 -machine pc-i440fx-8.1 -accel kvm -m 128,slots=3D3,max=
mem=3D1G
VNC server running on ::1:5900
^Cqemu-system-i386: terminating on signal 2




>
> CXL with 32bit CPUs ... it might be reasonably to just disable such
> tests. Certainly does not exist in real HW ... :)
>
> --
> Cheers,
>
> David / dhildenb
>


