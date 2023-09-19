Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 470187A5D89
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:15:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWoM-0002VN-7Y; Tue, 19 Sep 2023 05:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiWoJ-0002V9-GK
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiWoH-0006u4-Sl
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695114860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEa0BELCEGfXHta8vyUb0U40MiUQindzBX2lkJJnc8g=;
 b=ae24MrqdqNcRqBVw4KCU/52HRamByoHp9uo1cLNHCqr2cwyL2csNtQQwO45DRcMUCiYRHH
 TsxVLItZOFg7VmBEKGOW4pVCtl5Mew1W4QASQeCNh314UrlIANB0NVihQCEQiZEw8NM4kf
 hD9xM/RYqAg46AcsqHhmkGcQMb13Vbg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-L797KaB7NzmXylEK5ROCcw-1; Tue, 19 Sep 2023 05:14:11 -0400
X-MC-Unique: L797KaB7NzmXylEK5ROCcw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-993eeb3a950so424958666b.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 02:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695114850; x=1695719650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEa0BELCEGfXHta8vyUb0U40MiUQindzBX2lkJJnc8g=;
 b=ASii/ng7ZLf3LZ5kVVaJkjMNPzYHndPimrHD2kmzLpNkhHNbG43U9oi5vxVLUOzXKp
 LogP7LE9jfbl7d45GCNEWPv44tNgPkWC3KGKnh26ghTjuJWR6Prk9WEXNtCtcJOF7E/G
 /IuFnP3xlHe3mcheDka2ROp78KWmH6qxPco/qTPCQlgnXsBhQ8A/vp+5BHOxHrRPcSzM
 QHHS2nglmtLA5o6UqDt41hTWKMH+VufjQQJpl//7zN0R6/zIVPrgbt9CIfsMH+qQEhoN
 HndINM/l8dX8+ATB6Kz4RooBlNw6S0xASqGr//rk1kQegdYZsF8qvRu+ltmm32+x9Bvl
 npMg==
X-Gm-Message-State: AOJu0Yys6TSq8seIgTnZTmOCUno7I230S3+MweCdmhTa7JAlcGdS2YCI
 D1o4PCHi5WDUwa+Fjd9D1qlNOnKWYOnIbWunZ6Uw77lKjcWdG7MWRNNmdSPspqOmVQnb8ExORKG
 C9HD1abtFoPgkdkThK6ugsVfIDD+U5Jw=
X-Received: by 2002:a17:906:5dae:b0:9a1:891b:6eed with SMTP id
 n14-20020a1709065dae00b009a1891b6eedmr9867095ejv.76.1695114850474; 
 Tue, 19 Sep 2023 02:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0pKduVYsLpWb3mhZjeO9WF2bvXtD+YPRNVUGtGGQYI1xAF7r7J3fUWLMyWfw+E6V8NWt3vOFEs1JHa6D/J1M=
X-Received: by 2002:a17:906:5dae:b0:9a1:891b:6eed with SMTP id
 n14-20020a1709065dae00b009a1891b6eedmr9867084ejv.76.1695114850116; Tue, 19
 Sep 2023 02:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135448.90963-1-anisinha@redhat.com>
 <CAK3XEhOMqdfyPBm0ZgkirrcaBhOwQt_eOZ7=bbdW8OJpz3hWHg@mail.gmail.com>
 <ceea0d9d-19d6-29e7-cb84-81f85936b8c2@redhat.com>
 <CAK3XEhNETZBGtzpv2vBzygQtYuzTrsihzQNRdK8kp3+_u590Rg@mail.gmail.com>
 <3a3b5c4a-afad-8362-088c-a531d6998c23@redhat.com>
 <CAK3XEhPYPaJfeK5hcq+EktSn9iFVrv05H=TJ4VJNARddK1jYOA@mail.gmail.com>
 <CAK3XEhP5dyn5bORreJSt7U_QANh2oWG2Tn9UKttbAxEKTSmEfg@mail.gmail.com>
 <CAK3XEhN-x3NdPBknpM=7ORMOdKMzRX6dMn=dY5x=ajf9+tZkSg@mail.gmail.com>
 <7eab0019-f4e7-f3a1-f9a6-46acc4b3d2d1@redhat.com>
In-Reply-To: <7eab0019-f4e7-f3a1-f9a6-46acc4b3d2d1@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 19 Sep 2023 14:43:58 +0530
Message-ID: <CAK3XEhPX86x8S4hN3oG5tyQjYGkKZ1dCL7sDS1ZZdzfw3u77WA@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, philmd@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 19, 2023 at 1:13=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 19.09.23 08:18, Ani Sinha wrote:
> > On Tue, Sep 19, 2023 at 9:53=E2=80=AFAM Ani Sinha <anisinha@redhat.com>=
 wrote:
> >>
> >> On Tue, Sep 19, 2023 at 9:20=E2=80=AFAM Ani Sinha <anisinha@redhat.com=
> wrote:
> >>>
> >>> On Mon, Sep 18, 2023 at 9:28=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>> On 18.09.23 17:56, Ani Sinha wrote:
> >>>>> On Mon, Sep 18, 2023 at 8:59=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> >>>>>>
> >>>>>> On 18.09.23 17:22, Ani Sinha wrote:
> >>>>>>> On Mon, Sep 18, 2023 at 7:25=E2=80=AFPM Ani Sinha <anisinha@redha=
t.com> wrote:
> >>>>>>>>
> >>>>>>>> 32-bit systems do not have a reserved memory for hole64 but they=
 may have a
> >>>>>>>> reserved memory space for memory hotplug. Since, hole64 starts a=
fter the
> >>>>>>>> reserved hotplug memory, the unaligned hole64 start address give=
s us the
> >>>>>>>> end address for this memory hotplug region that the processor ma=
y use.
> >>>>>>>> Fix this. This ensures that the physical address space bound che=
cking works
> >>>>>>>> correctly for 32-bit systems as well.
> >>>>>>>
> >>>>>>> This patch breaks some unit tests. I am not sure why it did not c=
atch
> >>>>>>> it when I tested it before sending.
> >>>>>>> Will have to resend after fixing the tests.
> >>>>>>
> >>>>>> Probably because they supply more memory than the system can actua=
lly
> >>>>>> handle? (e.g., -m 4g on 32bit)?
> >>>>>
> >>>>> cxl tests are failing for example.
> >>>>>
> >>>>> $ ./qemu-system-i386 -display none -machine q35,cxl=3Don
> >>>>> qemu-system-i386: Address space limit 0xffffffff < 0x1000fffff
> >>>>> phys-bits too low (32)
> >>>
> >>> also another thing is:
> >>>
> >>> ./qemu-system-i386 -machine pc -m 128
> >>> works but ...
> >>>
> >>> $ ./qemu-system-i386 -machine pc -m 128,slots=3D3,maxmem=3D1G
> >>> qemu-system-i386: Address space limit 0xffffffff < 0x1f7ffffff
> >>> phys-bits too low (32)
> >>>
> >>> or
> >>>
> >>> $ ./qemu-system-i386 -machine pc-i440fx-8.2 -accel kvm -m 128,slots=
=3D3,maxmem=3D1G
> >>> qemu-system-i386: Address space limit 0xffffffff < 0x1f7ffffff
> >>> phys-bits too low (32)
> >>>
> >>> but of course after the compat knob older pc machines work fine using
> >>> the old logic :
> >>>
> >>> $ ./qemu-system-i386 -machine pc-i440fx-8.1 -accel kvm -m 128,slots=
=3D3,maxmem=3D1G
> >>> VNC server running on ::1:5900
> >>> ^Cqemu-system-i386: terminating on signal 2
> >>
> >> I dpn't know if we always need to do this but this code adds 1 GiB per
> >> slot for device memory :
> >>
> >>      if (pcmc->enforce_aligned_dimm) {
> >>           /* size device region assuming 1G page max alignment per slo=
t */
> >>           size +=3D (1 * GiB) * machine->ram_slots;
> >>       }
> >>
> >> For a 32-bit machine that is a lot of memory consumed in just alignmen=
t.
> >
> > Let's look at an example when we get rid of all alignment stuff.
> >
> > $ ./qemu-system-i386 -machine pc-i440fx-8.2 -m 512M,slots=3D1,maxmem=3D=
1G
> > above 4G start: 0x100000000,above 4G size: 0x0
> > qemu-system-i386: Address space limit 0xffffffff < 0x11ffffffe
> > phys-bits too low (32)
> >
> > So basically, above_4g_start =3D 4GiB. size =3D 0.
> > Then it is adding the device memory which is 1GiB - 0.5 GiB =3D 0.5 GiB=
.
> > So the  0x11ffffffe is exactly 4.5 GiB.
> >
> > Anything above 4 GiB is beyond 32 bits.
> >
>
> It's not worth worrying about memory devices for 32bit at all. For
> example Linux doesn't support memory hotplug on any 32bit system (not
> even with PAE and friends).
>

Ok fair enough. The existing scheme clearly does not support 32-bit
memory hotplug.

We do have a slight improvement with our original test case. I will
send an updated patch that passed all unit tests :

$ ./qemu-system-x86_64 -machine pc-i440fx-8.2 -cpu pentium -m
size=3D10G, -monitor stdio -qmp tcp:0:5555,server,nowait
QEMU 8.1.50 monitor - type 'help' for more information
qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff
phys-bits too low (32)

[anisinha@rhel9-box build]$ ./qemu-system-x86_64 -machine
pc-i440fx-8.1 -cpu pentium -m size=3D10G, -monitor stdio -qmp
tcp:0:5555,server,nowait
QEMU 8.1.50 monitor - type 'help' for more information
VNC server running on ::1:5900
(qemu)


