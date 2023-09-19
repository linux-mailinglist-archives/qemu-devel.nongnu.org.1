Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C59357A59E2
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 08:20:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiU4e-00087x-Om; Tue, 19 Sep 2023 02:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiU4d-00087F-A0
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiU4b-0007Az-NH
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695104340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1geUhetgdoBhDve7uyHbUVznjOi4Dhwj4aSeYWMYJFI=;
 b=f7MA5pWuz7c8BCP+1cXwlgb3VQTzuXMVzTtLZJVbo9RG8UjCTTQeG0i8HJ4Cd/dvgGhIpx
 BFjxAybtzGv4EXmm+xnFLEc1J+uLxCd458H2P2A6SVAslSzkhX9EoBNSAvywlbafG9Z+TX
 U3fi1AIwEFchIqDNsRYKb2NN1huY2VI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-ZQEyDn64MpqxQliwdXB7ew-1; Tue, 19 Sep 2023 02:18:58 -0400
X-MC-Unique: ZQEyDn64MpqxQliwdXB7ew-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bfb9db0397so65920951fa.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 23:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695104337; x=1695709137;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1geUhetgdoBhDve7uyHbUVznjOi4Dhwj4aSeYWMYJFI=;
 b=FYiBICse5mUGHgztYzLVl8PYNZXgrPjg0uA9omi2yoFqtaWjX0Xa4CkjdUyeFlUiS4
 m7HjgKIF9CHu9sZEMAA5uJLYDBaQ9G7J5IkLZaua5vPo6Of8NXoeSQ8Oh4uZuYXrYpZG
 7gximf641IVlK2Z6c0VajIh8adS77YbIAmXxJrQYBKrjId3eHVA3S5QJoNON1ePkaftR
 OD0koiG4O2OZ5KPYYsRxjeaQeU1eor2TjtFnZF9ycl2N7ookPM1Mlm4ibl5XTgLlU/iI
 O6BvIGZqudDqHpza5+hCd6Mtz+5YGLx7nDmBFwDHRf+0l/HCBovjLa4tT0Dez/GGNSFa
 /5LA==
X-Gm-Message-State: AOJu0Yzjc9luVHME1LwPIzju5XXBR3zOR832fvWbU8MSRGzro/PAmroc
 uq73BqeL+DAa0sQp9bodGbogvUrI7HrdBG+w210DuFKAUxLbfGLrPsWJUNarR/DDPYnNcrsjDCu
 USbRLQ2sJT+TC1L/9BwaCyXMjwedYvew=
X-Received: by 2002:a05:651c:1207:b0:2bf:aba1:d951 with SMTP id
 i7-20020a05651c120700b002bfaba1d951mr9932004lja.10.1695104337475; 
 Mon, 18 Sep 2023 23:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk5NVD+sTpKiZav9RqNkHTWRN2PkDNKpK4DiNov1enz6qEBr0v7MIWj4Yt8/hnZZvK3e2qtZHJfkAv/V33YYI=
X-Received: by 2002:a05:651c:1207:b0:2bf:aba1:d951 with SMTP id
 i7-20020a05651c120700b002bfaba1d951mr9931987lja.10.1695104337012; Mon, 18 Sep
 2023 23:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135448.90963-1-anisinha@redhat.com>
 <CAK3XEhOMqdfyPBm0ZgkirrcaBhOwQt_eOZ7=bbdW8OJpz3hWHg@mail.gmail.com>
 <ceea0d9d-19d6-29e7-cb84-81f85936b8c2@redhat.com>
 <CAK3XEhNETZBGtzpv2vBzygQtYuzTrsihzQNRdK8kp3+_u590Rg@mail.gmail.com>
 <3a3b5c4a-afad-8362-088c-a531d6998c23@redhat.com>
 <CAK3XEhPYPaJfeK5hcq+EktSn9iFVrv05H=TJ4VJNARddK1jYOA@mail.gmail.com>
 <CAK3XEhP5dyn5bORreJSt7U_QANh2oWG2Tn9UKttbAxEKTSmEfg@mail.gmail.com>
In-Reply-To: <CAK3XEhP5dyn5bORreJSt7U_QANh2oWG2Tn9UKttbAxEKTSmEfg@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 19 Sep 2023 11:48:44 +0530
Message-ID: <CAK3XEhN-x3NdPBknpM=7ORMOdKMzRX6dMn=dY5x=ajf9+tZkSg@mail.gmail.com>
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

On Tue, Sep 19, 2023 at 9:53=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> On Tue, Sep 19, 2023 at 9:20=E2=80=AFAM Ani Sinha <anisinha@redhat.com> w=
rote:
> >
> > On Mon, Sep 18, 2023 at 9:28=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> > >
> > > On 18.09.23 17:56, Ani Sinha wrote:
> > > > On Mon, Sep 18, 2023 at 8:59=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> > > >>
> > > >> On 18.09.23 17:22, Ani Sinha wrote:
> > > >>> On Mon, Sep 18, 2023 at 7:25=E2=80=AFPM Ani Sinha <anisinha@redha=
t.com> wrote:
> > > >>>>
> > > >>>> 32-bit systems do not have a reserved memory for hole64 but they=
 may have a
> > > >>>> reserved memory space for memory hotplug. Since, hole64 starts a=
fter the
> > > >>>> reserved hotplug memory, the unaligned hole64 start address give=
s us the
> > > >>>> end address for this memory hotplug region that the processor ma=
y use.
> > > >>>> Fix this. This ensures that the physical address space bound che=
cking works
> > > >>>> correctly for 32-bit systems as well.
> > > >>>
> > > >>> This patch breaks some unit tests. I am not sure why it did not c=
atch
> > > >>> it when I tested it before sending.
> > > >>> Will have to resend after fixing the tests.
> > > >>
> > > >> Probably because they supply more memory than the system can actua=
lly
> > > >> handle? (e.g., -m 4g on 32bit)?
> > > >
> > > > cxl tests are failing for example.
> > > >
> > > > $ ./qemu-system-i386 -display none -machine q35,cxl=3Don
> > > > qemu-system-i386: Address space limit 0xffffffff < 0x1000fffff
> > > > phys-bits too low (32)
> >
> > also another thing is:
> >
> > ./qemu-system-i386 -machine pc -m 128
> > works but ...
> >
> > $ ./qemu-system-i386 -machine pc -m 128,slots=3D3,maxmem=3D1G
> > qemu-system-i386: Address space limit 0xffffffff < 0x1f7ffffff
> > phys-bits too low (32)
> >
> > or
> >
> > $ ./qemu-system-i386 -machine pc-i440fx-8.2 -accel kvm -m 128,slots=3D3=
,maxmem=3D1G
> > qemu-system-i386: Address space limit 0xffffffff < 0x1f7ffffff
> > phys-bits too low (32)
> >
> > but of course after the compat knob older pc machines work fine using
> > the old logic :
> >
> > $ ./qemu-system-i386 -machine pc-i440fx-8.1 -accel kvm -m 128,slots=3D3=
,maxmem=3D1G
> > VNC server running on ::1:5900
> > ^Cqemu-system-i386: terminating on signal 2
>
> I dpn't know if we always need to do this but this code adds 1 GiB per
> slot for device memory :
>
>     if (pcmc->enforce_aligned_dimm) {
>          /* size device region assuming 1G page max alignment per slot */
>          size +=3D (1 * GiB) * machine->ram_slots;
>      }
>
> For a 32-bit machine that is a lot of memory consumed in just alignment.

Let's look at an example when we get rid of all alignment stuff.

$ ./qemu-system-i386 -machine pc-i440fx-8.2 -m 512M,slots=3D1,maxmem=3D1G
above 4G start: 0x100000000,above 4G size: 0x0
qemu-system-i386: Address space limit 0xffffffff < 0x11ffffffe
phys-bits too low (32)

So basically, above_4g_start =3D 4GiB. size =3D 0.
Then it is adding the device memory which is 1GiB - 0.5 GiB =3D 0.5 GiB.
So the  0x11ffffffe is exactly 4.5 GiB.

Anything above 4 GiB is beyond 32 bits.


