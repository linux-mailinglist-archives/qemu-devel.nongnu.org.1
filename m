Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2967083EA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:27:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeav-0005GW-QU; Thu, 18 May 2023 10:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1pzear-0005GI-Ph
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1pzeao-0008VO-Px
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684420017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8W9neSaOXbNojdm9hfH+tNNy21v4G/vKsHzXQeO/BE=;
 b=LB/T0iVbux1oizPpzHsAl8UTI+d1GEEcXhOTn4b1jxQj/EePLOG5Das0IaN+7VFdbJctgQ
 HJnzYNR8sF9Jp/DkcZf7cRkufSgZCHNqWE29AFKQ4nHw7PUz56gOAZOZRLdCopGUnd0/fE
 TeYRhjWSOv+pzzUpJeDRoSvQPn/4G9Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-y4_oRvOGOECDG9TXQsn70A-1; Thu, 18 May 2023 10:26:55 -0400
X-MC-Unique: y4_oRvOGOECDG9TXQsn70A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30479b764f9so847803f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 07:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684420013; x=1687012013;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f8W9neSaOXbNojdm9hfH+tNNy21v4G/vKsHzXQeO/BE=;
 b=ECpR4ItJ34w8L2+nFjTyHcQXIIMili8fInmQ0wVjYDADFoJOI6n4m9WrKEsrZndj8a
 rkuuUu7zDyj9emQiEE2JWw2Zb+IlAiemqfyQR4b9lHrZJkN9Xn1GDO2fEIDmp9C8c2EU
 T7bjMxhIGBr8o/H/ATebXmmjZ9sMopKzFY0iSHmPW1qyohkvJzs3SepHS33WfvgkN0jA
 W9Vl6i1X3pb8Wj80qxVouvtVywa+I9s759r0JfxBUfOXr1DE9A3UVfoMr+ebaZ9nqamY
 Kxm88X0Msk1HrgXrcZEBrsAxkkBDjhb0wI9QoZqDJgR0C/asr12lFsxOSxx7HZhkEaVa
 BbUg==
X-Gm-Message-State: AC+VfDwmEwbRyIbOHG+wg24X4biBZnlIm0d4Z2mdDJ2J4o1KgtnZJkBJ
 g9MXW3XBCpBSv8WAAqR27eEBHpr23XEfgFgmcvQdiSSi2Lbg0g2kFSww+mD2Gmxll1HNjeoO3q0
 b4Txtawtm+4W/E+cINzTR98Y=
X-Received: by 2002:adf:f28a:0:b0:309:42f3:4c3a with SMTP id
 k10-20020adff28a000000b0030942f34c3amr1629418wro.32.1684420013581; 
 Thu, 18 May 2023 07:26:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZolbP42dzz3FXSwpTLSEvVGeg9MAoGMEzo0zC4xstP4kri5AlH/pjm5kuFRAN/o3nvId1Wg==
X-Received: by 2002:adf:f28a:0:b0:309:42f3:4c3a with SMTP id
 k10-20020adff28a000000b0030942f34c3amr1629405wro.32.1684420013062; 
 Thu, 18 May 2023 07:26:53 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:ada2:6df5:d1b0:21e])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a5d4531000000b002ffbf2213d4sm2335479wra.75.2023.05.18.07.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 07:26:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 May 2023 16:26:51 +0200
Message-Id: <CSPH26VYAHPT.174M4SDQV1XT0@fedora>
Cc: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: "Marcelo Tosatti" <mtosatti@redhat.com>
X-Mailer: aerc/0.13.0-123-g2937830491b5
References: <20230517130730.85469-1-aharivel@redhat.com>
 <ZGT2P6FNoUahrWxT@tpad>
In-Reply-To: <ZGT2P6FNoUahrWxT@tpad>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Marcelo Tosatti, May 17, 2023 at 17:43:

Hi Marcelo,

> On Wed, May 17, 2023 at 03:07:30PM +0200, Anthony Harivel wrote:
 > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 8504aaac6807..14f9c2901680 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -396,6 +396,10 @@ typedef enum X86Seg {
> >  #define MSR_IA32_TSX_CTRL		0x122
> >  #define MSR_IA32_TSCDEADLINE            0x6e0
> >  #define MSR_IA32_PKRS                   0x6e1
> > +#define MSR_RAPL_POWER_UNIT             0x00000606
> > +#define MSR_PKG_POWER_LIMIT             0x00000610
> > +#define MSR_PKG_ENERGY_STATUS           0x00000611
> > +#define MSR_PKG_POWER_INFO              0x00000614
>
> Why only PKG and not all domains?
>

Package domains are the only ones you can find accross different CPU
segments (client and server platforms).
Processor cores domains are only available on client platform while
DRAM domains only on server platform.

I figured out that Package domains would be a good start to validate the
implementation and the rest could technically be added later on.=20


> > +    /* Assuming those values are the same accross physical system/pack=
ages */
> > +    maxcpus =3D get_maxcpus(0); /* Number of CPUS per packages */
> > +    maxpkgs =3D numa_max_node(); /* Number of Packages on the system *=
/
> > +    /* Those MSR values should not change as well */
> > +    vmsr->msr_unit =3D read_msr(MSR_RAPL_POWER_UNIT, 0);
> > +    vmsr->msr_limit =3D read_msr(MSR_PKG_POWER_LIMIT, 0);
>
> Power limit - MSR interfaces to specify power limit, time window; lock bi=
t, clamp bit etc
>
> This one can change, right? And why expose the power limit to the guest?
>

Right.
Because it belongs to the non-optional RAPL interfaces MSRs, I added it
with the thought that it was mandatory for the RAPL driver to mount
insite the guest.=20
Either it is not and can be removed, or we can set the "lock bit" to
inform the guest that power limit settings are static and un-modifiable.
I will correct that.=20


> > +    vmsr->msr_info =3D read_msr(MSR_PKG_POWER_INFO, 0);
> > +
> > +    /* Allocate memory for each package energy status */
> > +    pkg_stat =3D (package_energy_stat *) calloc(maxpkgs + 1,
> > +                                              sizeof(package_energy_st=
at));
> > +
> > +    /*
> > +     * Max numbers of ticks per package
> > +     * time in second * number of ticks/second * Number of cores / pac=
kage
> > +     * ex: for 100 ticks/second/CPU, 12 CPUs per Package gives 1200 ti=
cks max
> > +     */
> > +    maxticks =3D (MSR_ENERGY_THREAD_SLEEP_US / 1000000)
> > +                    * sysconf(_SC_CLK_TCK) * maxcpus;
> > +
> > +    while (true) {
> > +
> > +        /* Get all qemu threads id */
> > +        pid_t *thread_ids =3D get_thread_ids(pid, &num_threads);
> > +
> > +        if (thread_ids =3D=3D NULL) {
> > +            return NULL;
> > +        }
> > +
> > +        /* Allocate memory for each thread stats */
> > +        thd_stat =3D (thread_stat *) calloc(num_threads, sizeof(thread=
_stat));
> > +
> > +        /* Populate all the thread stats */
> > +        for (int i =3D 0; i < num_threads; i++) {
> > +            thd_stat[i].thread_id =3D thread_ids[i];
> > +            thd_stat[i].utime =3D calloc(2, sizeof(unsigned long long)=
);
> > +            thd_stat[i].stime =3D calloc(2, sizeof(unsigned long long)=
);
> > +            read_thread_stat(&thd_stat[i], pid, 0);
> > +            thd_stat[i].numa_node_id =3D numa_node_of_cpu(thd_stat[i].=
cpu_id);
> > +        }
> > +
> > +        /* Retrieve all packages power plane energy counter */
> > +        for (int i =3D 0; i <=3D maxpkgs; i++) {
> > +            for (int j =3D 0; j < num_threads; j++) {
> > +                /*
> > +                 * Use the first thread we found that ran on the CPU
> > +                 * of the package to read the packages energy counter
> > +                 */
> > +                if (thd_stat[j].numa_node_id =3D=3D i) {
> > +                    pkg_stat[i].e_start =3D read_msr(MSR_PKG_ENERGY_ST=
ATUS, i);
> > +                    break;
> > +                }
> > +            }
> > +        }
> > +
> > +        /* Sleep a short period while the other threads are working */
> > +        usleep(MSR_ENERGY_THREAD_SLEEP_US);
> > +
> > +        /*
> > +         * Retrieve all packages power plane energy counter
> > +         * Calculate the delta of all packages
> > +         */
> > +        for (int i =3D 0; i <=3D maxpkgs; i++) {
> > +            for (int j =3D 0; j < num_threads; j++) {
> > +                /*
> > +                 * Use the first thread we found that ran on the CPU
> > +                 * of the package to read the packages energy counter
> > +                 */
> > +                if (thd_stat[j].numa_node_id =3D=3D i) {
> > +                    pkg_stat[i].e_end =3D
> > +                        read_msr(MSR_PKG_ENERGY_STATUS, thd_stat[j].cp=
u_id);
> > +                    pkg_stat[i].e_delta =3D
> > +                        pkg_stat[i].e_end - pkg_stat[i].e_start;
> > +                    break;
> > +                }
> > +            }
> > +        }
>
> Don't get this: can you do a high level overview of how the emulated
> value is calculated? (fail to see what is the relation between whether
> a QEMU thread ran and whether to read or not MSR_PKG_ENERGY_STATUS).
>
> It seems this might be simplified, and reading every 1ms might be
> excessive overhead.
>
> Independent of this question (for whatever implementation): how
> accurate is the power information exposed to the guest vs actual
> power consumed (might be nice to have some notion of it).
>
> In general i think its useful to expose the information to guests.
>

No problem, let me try to explain:=20
a QEMU process is composed of vCPU thread(s) and non-vCPU thread(s) (IO,
emulated device,...). Each of those threads can run on different cores
that can belongs to the same Package or not.=20
The MSR_PKG_ENERGY_STATUS is a counter that increment for the whole
Package domain. If you read this MSR from any core that belongs to the=20
package, you will retrieve the same number.
So when I need to read the MSR, I only need to read once for all the
threads that are running on cores of each Package.

Now let's talk about the implementation of the emulated value.=20
I've created a thread that does in an infinite loop the following:
- Retrieve all the QEMU threads + statistics about them=20
- Read the energy counter of each Package involved=20
- Sleep for 1sec (1sec is arbitrary)
- Calculate the delta of ticks for each threads so that we know how much
  time each threads has been scheduled during the Sleep period
- Read again the energy counter of each Package involved and calculate
  the delta of the counter so that we know how much the counter has
  increased during the Sleep period
- Calculate the ratio for each vCPU thread and deduct the energy spent
  for each vCPU
- Calculate the amount of energy spent for all non-vCPU and evenly
  spread it to the vCPU
- Update each virtual MSR for each vCPU

Obviously, this is working better and more consistently with vCPU pinning=
=20
and proper isolation of the cores in the package.=20

So those virtual MSRs are updated roughly each second (could be changed
by updating MSR_ENERGY_THREAD_SLEEP_US). Compared to the real MSRs which=20
are updated by the microcode every 1ms.

Concerning the "real" power consumption, we have to not forget that the
RAPL interface energy data is not the result of a physical measurement.=20
It is a set of architectural events from each core, processor
graphic, IO, etc. and combines them with energy weights to predict the
package's active power consumption.

IMO it is not really important because the idea behind this patch is to
give estimated values to the guests so that software running inside
VM can make use of power tools which are all reading those MSRs (or the
RAPL driver sys interface) to retrieve power consumption.


> > +
> > +        /* Delta of ticks spend by each thread between the sample */
> > +        for (int i =3D 0; i < num_threads; i++) {
> > +            if (read_thread_stat(&thd_stat[i], pid, 1) !=3D 0) {
> > +                /*
> > +                 * We don't count the dead thread
> > +                 * i.e threads that existed before the sleep
> > +                 * and not anymore
> > +                 */
> > +                thd_stat[i].delta_ticks =3D 0;
> > +            } else {
> > +                delta_ticks(thd_stat, i);
> > +            }
> > +        }
> > +
> > +        /*
> > +         * Identify the vCPU threads
> > +         * Calculate the Number of vCPU per package
> > +         */
> > +        CPU_FOREACH(cpu) {
> > +            for (int i =3D 0; i < num_threads; i++) {
> > +                if (cpu->thread_id =3D=3D thd_stat[i].thread_id) {
> > +                    thd_stat[i].is_vcpu =3D true;
> > +                    thd_stat[i].vcpu_id =3D cpu->cpu_index;
> > +                    pkg_stat[thd_stat[i].numa_node_id].nb_vcpu++;
> > +                    break;
> > +                }
> > +            }
> > +        }
> > +
> > +        /* Calculate the total energy of all non-vCPU thread */
> > +        for (int i =3D 0; i < num_threads; i++) {
> > +            double temp;
> > +            if ((thd_stat[i].is_vcpu !=3D true) &&
> > +                (thd_stat[i].delta_ticks > 0)) {
> > +                temp =3D get_ratio(pkg_stat, thd_stat, maxticks, i);
> > +                pkg_stat[thd_stat[i].numa_node_id].e_ratio
> > +                    +=3D (uint64_t)lround(temp);
> > +            }
> > +        }
> > +
> > +        /* Calculate the ratio per non-vCPU thread of each package */
> > +        for (int i =3D 0; i <=3D maxpkgs; i++) {
> > +            if (pkg_stat[i].nb_vcpu > 0) {
> > +                pkg_stat[i].e_ratio =3D pkg_stat[i].e_ratio / pkg_stat=
[i].nb_vcpu;
> > +            }
> > +        }
> > +
> > +        /* Calculate the energy for each vCPU thread */
> > +        for (int i =3D 0; i < num_threads; i++) {
> > +            double temp;
> > +
> > +            if ((thd_stat[i].is_vcpu =3D=3D true) &&
> > +                (thd_stat[i].delta_ticks > 0)) {
> > +                temp =3D get_ratio(pkg_stat, thd_stat, maxticks, i);
> > +                vmsr->msr_value[thd_stat[i].vcpu_id] +=3D (uint64_t)lr=
ound(temp);
> > +                vmsr->msr_value[thd_stat[i].vcpu_id] \
> > +                    +=3D pkg_stat[thd_stat[i].numa_node_id].e_ratio;
> > +            }
> > +        }
> > +
> > +        /* free all memory */
> > +        for (int i =3D 0; i < num_threads; i++) {
> > +            free(thd_stat[i].utime);
> > +            free(thd_stat[i].stime);
> > +        }
> > +        free(thd_stat);
> > +        free(thread_ids);
> > +    }
> > +
> > +    rcu_unregister_thread();
> > +    return NULL;
> > +}
> > +
> > +static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
> > +{
> > +    struct KVMMsrEnergy *r =3D &s->msr_energy;
> > +
> > +    /* Retrieve the number of vCPU */
> > +    r->cpus =3D ms->smp.cpus;
> > +
> > +    /* Allocate register memory (MSR_PKG_STATUS) for each vCPU */
> > +    r->msr_value =3D calloc(r->cpus, sizeof(r->msr_value));
> > +
> > +    qemu_thread_create(&r->msr_thr, "kvm-msr",
> > +                       kvm_msr_energy_thread,
> > +                       s, QEMU_THREAD_JOINABLE);
> > +
> > +    return 0;
> > +}
> > +
> >  int kvm_arch_init(MachineState *ms, KVMState *s)
> >  {
> >      uint64_t identity_base =3D 0xfffbc000;
> > @@ -2765,6 +2998,46 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >                           strerror(-ret));
> >              exit(1);
> >          }
> > +
> > +        if (s->msr_energy.enable =3D=3D true) {
> > +
> > +            r =3D kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
> > +                               kvm_rdmsr_rapl_power_unit, NULL);
> > +            if (!r) {
> > +                error_report("Could not install MSR_RAPL_POWER_UNIT \
> > +                                handler: %s",
> > +                             strerror(-ret));
> > +                exit(1);
> > +            }
> > +
> > +            r =3D kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
> > +                               kvm_rdmsr_pkg_power_limit, NULL);
> > +            if (!r) {
> > +                error_report("Could not install MSR_PKG_POWER_LIMIT \
> > +                                handler: %s",
> > +                             strerror(-ret));
> > +                exit(1);
> > +            }
> > +
> > +            r =3D kvm_filter_msr(s, MSR_PKG_POWER_INFO,
> > +                               kvm_rdmsr_pkg_power_info, NULL);
> > +            if (!r) {
> > +                error_report("Could not install MSR_PKG_POWER_INFO \
> > +                                handler: %s",
> > +                             strerror(-ret));
> > +                exit(1);
> > +            }
> > +            r =3D kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
> > +                               kvm_rdmsr_pkg_energy_status, NULL);
> > +            if (!r) {
> > +                error_report("Could not install MSR_PKG_ENERGY_STATUS =
\
> > +                                handler: %s",
> > +                             strerror(-ret));
> > +                exit(1);
> > +            } else {
> > +                kvm_msr_energy_thread_init(s, ms);
> > +            }
> > +        }
> >      }
> > =20
> >      return 0;
> > diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
> > index 322272091bce..9cdc93c6c439 100644
> > --- a/target/i386/kvm/meson.build
> > +++ b/target/i386/kvm/meson.build
> > @@ -5,6 +5,7 @@ i386_softmmu_kvm_ss =3D ss.source_set()
> >  i386_softmmu_kvm_ss.add(files(
> >    'kvm.c',
> >    'kvm-cpu.c',
> > +  'vmsr_energy.c',
> >  ))
> > =20
> >  i386_softmmu_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-em=
u.c'))
> > diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energ=
y.c
> > new file mode 100644
> > index 000000000000..8bd86b32becf
> > --- /dev/null
> > +++ b/target/i386/kvm/vmsr_energy.c
> > @@ -0,0 +1,132 @@
> > +/*
> > + * QEMU KVM support -- x86 virtual energy-related MSR.
> > + *
> > + * Copyright 2023 Red Hat, Inc. 2023
> > + *
> > + *  Author:
> > + *      Anthony Harivel <aharivel@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "vmsr_energy.h"
> > +
> > +#define MAX_PATH_LEN 50
> > +#define MAX_LINE_LEN 500
> > +
> > +uint64_t read_msr(uint32_t reg, unsigned int cpu_id)
> > +{
> > +    int fd;
> > +    uint64_t data;
> > +
> > +    char path[MAX_PATH_LEN];
> > +    snprintf(path, MAX_PATH_LEN, "/dev/cpu/%u/msr", cpu_id);
> > +
> > +    fd =3D open(path , O_RDONLY);
> > +    if (fd < 0) {
> > +        return 0;
> > +    }
> > +    if (pread(fd, &data, sizeof data, reg) !=3D sizeof data) {
> > +        data =3D 0;
> > +    }
> > +
> > +    close(fd);
> > +    return data;
> > +}
> > +
> > +/* Retrieve the number of physical CPU on the package */
> > +unsigned int get_maxcpus(unsigned int package_num)
> > +{
> > +    int k, ncpus;
> > +    unsigned int maxcpus;
> > +    struct bitmask *cpus;
> > +
> > +    cpus =3D numa_allocate_cpumask();
> > +    ncpus =3D cpus->size;
> > +
> > +    if (numa_node_to_cpus(package_num, cpus) < 0) {
> > +        printf("node %u failed to convert\n", package_num);
> > +    }
> > +
> > +    maxcpus =3D 0;
> > +    for (k =3D 0; k < ncpus; k++) {
> > +        if (numa_bitmask_isbitset(cpus, k)) {
> > +            maxcpus++;
> > +        }
> > +    }
> > +
> > +    return maxcpus;
> > +}
> > +
> > +int read_thread_stat(struct thread_stat *thread, int pid, int index)
> > +{
> > +    char path[MAX_PATH_LEN];
> > +    snprintf(path, MAX_PATH_LEN, "/proc/%u/task/%d/stat", pid, \
> > +             thread->thread_id);
> > +
> > +    FILE *file =3D fopen(path, "r");
> > +    if (file =3D=3D NULL) {
> > +        return -1;
> > +    }
> > +
> > +    if (fscanf(file, "%*d (%*[^)]) %*c %*d %*d %*d %*d %*d %*u %*u %*u=
 %*u %*u"
> > +        " %llu %llu %*d %*d %*d %*d %*d %*d %*u %*u %*d %*u %*u"
> > +        " %*u %*u %*u %*u %*u %*u %*u %*u %*u %*d %*u %*u %u",
> > +           &thread->utime[index], &thread->stime[index], &thread->cpu_=
id) !=3D 3)
> > +        return -1;
> > +
> > +    fclose(file);
> > +    return 0;
> > +}
> > +
> > +/* Read QEMU stat task folder to retrieve all QEMU threads ID */
> > +pid_t *get_thread_ids(pid_t pid, int *num_threads)
> > +{
> > +    char path[100];
> > +    sprintf(path, "/proc/%d/task", pid);
> > +
> > +    DIR *dir =3D opendir(path);
> > +    if (dir =3D=3D NULL) {
> > +        perror("opendir");
> > +        return NULL;
> > +    }
> > +
> > +    pid_t *thread_ids =3D NULL;
> > +    int thread_count =3D 0;
> > +
> > +    struct dirent *ent;
> > +    while ((ent =3D readdir(dir)) !=3D NULL) {
> > +        if (ent->d_name[0] =3D=3D '.') {
> > +            continue;
> > +        }
> > +        pid_t tid =3D atoi(ent->d_name);
> > +        if (pid !=3D tid) {
> > +            thread_ids =3D realloc(thread_ids,
> > +                                 (thread_count + 1) * sizeof(pid_t));
> > +            thread_ids[thread_count] =3D tid;
> > +            thread_count++;
> > +        }
> > +    }
> > +
> > +    closedir(dir);
> > +
> > +    *num_threads =3D thread_count;
> > +    return thread_ids;
> > +}
> > +
> > +void delta_ticks(thread_stat *thd_stat, int i)
> > +{
> > +    thd_stat[i].delta_ticks =3D (thd_stat[i].utime[1] + thd_stat[i].st=
ime[1])
> > +                            - (thd_stat[i].utime[0] + thd_stat[i].stim=
e[0]);
> > +}
> > +
> > +double get_ratio(package_energy_stat *pkg_stat,
> > +                        thread_stat *thd_stat,
> > +                        int maxticks, int i) {
> > +
> > +    return (pkg_stat[thd_stat[i].numa_node_id].e_delta / 100.0)
> > +            * ((100.0 / maxticks) * thd_stat[i].delta_ticks);
> > +}
> > +
> > diff --git a/target/i386/kvm/vmsr_energy.h b/target/i386/kvm/vmsr_energ=
y.h
> > new file mode 100644
> > index 000000000000..5f79d2cbe00d
> > --- /dev/null
> > +++ b/target/i386/kvm/vmsr_energy.h
> > @@ -0,0 +1,80 @@
> > +/*
> > + * QEMU KVM support -- x86 virtual energy-related MSR.
> > + *
> > + * Copyright 2023 Red Hat, Inc. 2023
> > + *
> > + *  Author:
> > + *      Anthony Harivel <aharivel@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef VMSR_ENERGY_H
> > +#define VMSR_ENERGY_H
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include <numa.h>
> > +
> > +/*
> > + * Define the interval time in micro seconds between 2 samples of
> > + * energy related MSRs
> > + */
> > +#define MSR_ENERGY_THREAD_SLEEP_US 1000000.0
> > +
> > +/*
> > + * Thread statistic
> > + * @ thread_id: TID (thread ID)
> > + * @ is_vcpu: true is thread is vCPU thread
> > + * @ cpu_id: CPU number last executed on
> > + * @ vcpu_id: vCPU ID
> > + * @ numa_node_id:node number of the CPU
> > + * @ utime: amount of clock ticks the thread
> > + *          has been scheduled in User mode
> > + * @ stime: amount of clock ticks the thread
> > + *          has been scheduled in System mode
> > + * @ delta_ticks: delta of utime+stime between
> > + *          the two samples (before/after sleep)
> > + */
> > +struct thread_stat {
> > +    unsigned int thread_id;
> > +    bool is_vcpu;
> > +    unsigned int cpu_id;
> > +    unsigned int vcpu_id;
> > +    unsigned int numa_node_id;
> > +    unsigned long long *utime;
> > +    unsigned long long *stime;
> > +    unsigned long long delta_ticks;
> > +};
> > +
> > +/*
> > + * Package statistic
> > + * @ e_start: package energy counter before the sleep
> > + * @ e_end: package energy counter after the sleep
> > + * @ e_delta: delta of package energy counter
> > + * @ e_ratio: store the energy ratio of non-vCPU thread
> > + * @ nb_vcpu: number of vCPU running on this package
> > + */
> > +struct packge_energy_stat {
> > +    uint64_t e_start;
> > +    uint64_t e_end;
> > +    uint64_t e_delta;
> > +    uint64_t e_ratio;
> > +    unsigned int nb_vcpu;
> > +};
> > +
> > +typedef struct thread_stat thread_stat;
> > +typedef struct packge_energy_stat package_energy_stat;
> > +
> > +uint64_t read_msr(uint32_t reg, unsigned int cpu_id);
> > +void delta_ticks(thread_stat *thd_stat, int i);
> > +unsigned int get_maxcpus(unsigned int package_num);
> > +int read_thread_stat(struct thread_stat *thread, int pid, int index);
> > +pid_t *get_thread_ids(pid_t pid, int *num_threads);
> > +double get_ratio(package_energy_stat *pkg_stat,
> > +                        thread_stat *thd_stat,
> > +                        int maxticks, int i);
> > +
> > +#endif /* VMSR_ENERGY_H */
> > --=20
> > 2.40.1
> >=20
> >=20


