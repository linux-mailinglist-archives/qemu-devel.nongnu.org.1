Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27189712997
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:34:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ZRj-0005xt-3B; Fri, 26 May 2023 11:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1q2ZRg-0005sL-QM
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1q2ZRd-0003hw-E2
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685115212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WOXBNMFhVkv+9mQyy6nys7QuAYiNqkWfbcMjTJem0fU=;
 b=ZVh4HQqih/COw0TS8qsXNcO5W3sLn9BcW2c593Fd8TZu5JGevP4EHc0RhQXC+L8r3u4qVm
 DEChbzcMpadfPzjMgpd9tE6jAbXRXuY8nmPXrPASn3YGtrdjgXw/AvYXUmeWOSbLZymx+f
 d0VVU7azEKR0zhoKurdJpYyYgtFggBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-1SvnRH4gNuy8kBbjWfgKtw-1; Fri, 26 May 2023 11:33:30 -0400
X-MC-Unique: 1SvnRH4gNuy8kBbjWfgKtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8577A185A78B
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 15:33:30 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8D1A1121314;
 Fri, 26 May 2023 15:33:29 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
 id 24752401030C3; Fri, 26 May 2023 12:23:00 -0300 (-03)
Date: Fri, 26 May 2023 12:23:00 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [RFC PATCH] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <ZHDO1OCxmiP05J8M@tpad>
References: <20230517130730.85469-1-aharivel@redhat.com>
 <ZGT2P6FNoUahrWxT@tpad> <CSPH26VYAHPT.174M4SDQV1XT0@fedora>
 <ZGe/1pldPtX1AYch@tpad> <CSULE3VM2E5G.1A33KNMW7ULRT@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CSULE3VM2E5G.1A33KNMW7ULRT@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mtosatti@redhat.com;
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

On Wed, May 24, 2023 at 04:53:49PM +0200, Anthony Harivel wrote:
> set=UTF-8
> Status: RO
> Content-Length: 24102
> Lines: 667
> 
> Marcelo Tosatti, May 19, 2023 at 20:28:
> 
> Hi Marcelo,
> 
> > > > > +    /* Assuming those values are the same accross physical system/packages */
> > > > > +    maxcpus = get_maxcpus(0); /* Number of CPUS per packages */
> > > > > +    maxpkgs = numa_max_node(); /* Number of Packages on the system */
> >
> > numa_max_node() returns the highest node number available on the current system. 
> > (See the node numbers in /sys/devices/system/node/ ). Also see numa_num_configured_nodes().
> >
> > One can find package topology information from
> > /sys/devices/system/cpu/cpuX/topology/
> >
> 
> Good point. 
> I will find a better solution to identify the topology using your hint. 
> 
>  > > > +        /* Allocate memory for each thread stats */
> > > > > +        thd_stat = (thread_stat *) calloc(num_threads, sizeof(thread_stat));
> >
> > Can you keep this pre-allocated ? And all other data as well.
> 
> Ok no problem.
> 
>  > > > +        /* Retrieve all packages power plane energy counter */
> > > > > +        for (int i = 0; i <= maxpkgs; i++) {
> > > > > +            for (int j = 0; j < num_threads; j++) {
> > > > > +                /*
> > > > > +                 * Use the first thread we found that ran on the CPU
> > > > > +                 * of the package to read the packages energy counter
> > > > > +                 */
> > > > > +                if (thd_stat[j].numa_node_id == i) {
> > > > > +                    pkg_stat[i].e_start = read_msr(MSR_PKG_ENERGY_STATUS, i);
> > > > > +                    break;
> > > > > +                }
> > > > > +            }
> > > > > +        }
> >
> > NUMA node does not map necessarily to one package.
> 
> True. I will update this part at the same time with the topology info
> discussed above. 
> 
> >
> > > > > +        /* Sleep a short period while the other threads are working */
> > > > > +        usleep(MSR_ENERGY_THREAD_SLEEP_US);
> > > > > +
> > > > > +        /*
> > > > > +         * Retrieve all packages power plane energy counter
> > > > > +         * Calculate the delta of all packages
> > > > > +         */
> > > > > +        for (int i = 0; i <= maxpkgs; i++) {
> > > > > +            for (int j = 0; j < num_threads; j++) {
> > > > > +                /*
> > > > > +                 * Use the first thread we found that ran on the CPU
> > > > > +                 * of the package to read the packages energy counter
> > > > > +                 */
> > > > > +                if (thd_stat[j].numa_node_id == i) {
> > > > > +                    pkg_stat[i].e_end =
> > > > > +                        read_msr(MSR_PKG_ENERGY_STATUS, thd_stat[j].cpu_id);
> >
> > This is excessive (to read the MSRs of each package in the system).
> >
> > Consider 100 Linux guests all of them with this enabled, on a system with
> > 4 packages. How many times you'll be reading MSR of each package?
> 
> The problem here is that you can have vCPUs that are running on different
> packages. However the energy counter of the different packages are
> increasing independently. 
> Either we "force" somehow users to run only on the same package, either I'm
> afraid we are obliged to read all the packages energy counter (when they
> are involved in the VM).
> 
> Imagine this:
> 
> |----pkg-0----|----pkg-1----|
> |0|1|2|3|4|5|6|0|1|2|3|4|5|6|
> |       |       |       |
> | vm-0  |  vm-1 |  vm-2 |
> 
> Only vm-1 that has cores from pkg-0 and pkg-1 would have to read both
> pkg energy. vm-0 would only read pkg-0 and vm-2 only pkg-1.
> 
> 
> >
> > Moreover, don't want to readmsr on an isolated CPU.
> >
> 
> Could you explain me why ?

Nevermind, its a separate topic.

> > > No problem, let me try to explain: 
> > > a QEMU process is composed of vCPU thread(s) and non-vCPU thread(s) (IO,
> > > emulated device,...). Each of those threads can run on different cores
> > > that can belongs to the same Package or not.
> > > The MSR_PKG_ENERGY_STATUS is a counter that increment for the whole
> > > Package domain. If you read this MSR from any core that belongs to the 
> > > package, you will retrieve the same number.
> > > So when I need to read the MSR, I only need to read once for all the
> > > threads that are running on cores of each Package.
> >
> > T=0	read p1v0 (== MSR_PKG_ENERGY_STATUS)
> > T=1	vcpu-1 executing in core1
> > 	vcpu-2 executing in core2
> > 	vcpu-3 executing in core2
> > T=2	read p1v1
> >
> > Won't you be exposing (p1v1-p1v0)/3 by 3 in this case, to the 
> > virtual MSR_PKG_ENERGY_STATUS?
> >
> 
> No, because if we take for exemple a 4 cores per package with 100 ticks per second,
> the maximum number of ticks for all the cores in this packages would be
> 400 ticks per second. 
> So if 2 or more vcpus are sharing the same core, they will be maxout by the
> 100 ticks per second anyway and so ratio will still be ok. 
> 
> 
> > > Now let's talk about the implementation of the emulated value. 
> > > I've created a thread that does in an infinite loop the following:
> > > - Retrieve all the QEMU threads + statistics about them 
> > > - Read the energy counter of each Package involved 
> > > - Sleep for 1sec (1sec is arbitrary)
> > > - Calculate the delta of ticks for each threads so that we know how much
> > >   time each threads has been scheduled during the Sleep period
> >
> > Intel docs mention the counter can overflow (faster with higher 
> > energy consumption). Are you handling the overflow case?
> >
> 
> Should we ? On baremetal, anyone reading the MSRs should handle the
> overflow case, I guess on a guest this should be the same.
> But I'll make sure *not* to output negative energy value for sure!

I mean to handle overflow in the emulation code, yes.

> 
> > > - Read again the energy counter of each Package involved and calculate
> > >   the delta of the counter so that we know how much the counter has
> > >   increased during the Sleep period
> > > - Calculate the ratio for each vCPU thread and deduct the energy spent
> > >   for each vCPU
> > > - Calculate the amount of energy spent for all non-vCPU and evenly
> > >   spread it to the vCPU
> > > - Update each virtual MSR for each vCPU
> > > 
> > > Obviously, this is working better and more consistently with vCPU pinning 
> > > and proper isolation of the cores in the package. 
> >
> > Do you really need to measure the consumption for QEMU threads? I'd say
> > only measuring for the vcpus is sufficient.
> >
> 
> What if a process in the guest is actually doing a lot of IO ?
> The QEMU workers managing those IO would be consumming, no ?
> But if this is unsignicant I can remove it.

On a second thought, i am not sure. Perhaps makes sense to keep 
the non-vcpu threads.

> 
> > > So those virtual MSRs are updated roughly each second (could be changed
> > > by updating MSR_ENERGY_THREAD_SLEEP_US). Compared to the real MSRs which 
> > > are updated by the microcode every 1ms.
> >
> > How useful are the measurements for the guest, then? (I mean, doesnt a
> > 1 second interval render the measurements less useful).
> >
> 
> We can always reduce the sleeping time. 
> I guess we can also set it with a parameter like:
> -accel kvm,rapl=true,update-period=500
> 
> with update-period, the interval in milliseconds between updates. 

And that would increase the CPU time for emulation significantly
(for higher granularity the consumption goes way up).
Which perhaps limits the use-cases.

I think what would be useful is explanation, on a document, of the behaviour of MSR emulation
in QEMU (how MSR value is emulated, low update rate, etc).
Including some example measurements.

Also consumption of energy by threads does not map 1<->1 to time spent
executing (different instructions have different consumption).

> > > Concerning the "real" power consumption, we have to not forget that the
> > > RAPL interface energy data is not the result of a physical measurement. 
> > > It is a set of architectural events from each core, processor
> > > graphic, IO, etc. and combines them with energy weights to predict the
> > > package's active power consumption.
> > > 
> > > IMO it is not really important because the idea behind this patch is to
> > > give estimated values to the guests so that software running inside
> > > VM can make use of power tools which are all reading those MSRs (or the
> > > RAPL driver sys interface) to retrieve power consumption.
> >
> > Can you describe some use-cases... Because what seems to be useful
> > (actually, what seem to be possible) is for users to measure the 
> > energy consumption of a package. 
> >
> 
> Yes and here they will do the same. Except that for the moment I don't
> have any solution to overcome the fact that each vcpu will have his own
> package. 
> When a software will read MSR_PKG_ENERGY_STATUS of pkg-0, it will also
> read the energy of the vcpu-0 because we are in single vcpu per virtual
> socket.
> I would say it might give better granularity of the power consumption:
> If a process in guest is running only on one isolated vcpu, reading the
> package MSR of this vcpu would theorically gives the consumption of this
> process directly. Whereas in baremetal, we need to take the other cores
> of the package into account.
> 
> > So if you think, OK i can read the energy consumption information
> > from within a guest, but i know its the energy consumption divided
> > by the amount of time the qemu threads executed, how useful that
> > measure is ?
> 
> It gives what the guest has actually consume 

This is not necessarily true due to per-instruction consumption.

So a vcpu executing the same sequence of instructions, in a package, 
sharing a core with a thread executing power hungry instructions, will
have exposed consumption different than if that power hungry thread is
not executing.

I think AVX512 instructions are a good example of power hungry
instructions.

> and inside the guest there
> are processes that are running.
> There are many tools [1][2][3] that use thoses MSRs for metrics to calculate
> the power consumption of applications/processes in order to optimize
> their code. 
> 
> What I'm trying to achieve here is enabling this possibilities inside VM. 

OK.

> 
> >
> > Why not expose the actual delta from the MSRs, rather than diving
> > by amount of time the qemu threads execute.
> >
> 
> Imagine 2 identical VMs on the same package: 
> VM-1 is hogging cores and VM-2 is doing nothing. 
> If we only report delta of the MSRs, both VM would consume the same
> which is wrong. 

Yeah. So having the emulation described in a document allows users to
know what to expect.

> This is why I'm doing ratio of the energy depending on the QEMU threads. 
> because a vCPU is just a thread and the /proc/<pid>/stat can give us 
> the amount of time spend by each thread on the cores.  
> 
> Thanks a lot for your input,
> 
> Anthony

Thanks!

This is a nice investigation into RAPL:
https://helda.helsinki.fi/bitstream/handle/10138/321707/RAPL_in_Action_Experiences_in_Using_RAPL_for_Power_Measurements.pdf?sequence=1

> 
> 
> 
> [1]: https://github.com/sustainable-computing-io/kepler
> [2]: https://powerapi.org/
> [3]: https://github.com/hubblo-org/scaphandre
> 
> 
> 
> > > > > +
> > > > > +        /* Delta of ticks spend by each thread between the sample */
> > > > > +        for (int i = 0; i < num_threads; i++) {
> > > > > +            if (read_thread_stat(&thd_stat[i], pid, 1) != 0) {
> > > > > +                /*
> > > > > +                 * We don't count the dead thread
> > > > > +                 * i.e threads that existed before the sleep
> > > > > +                 * and not anymore
> > > > > +                 */
> > > > > +                thd_stat[i].delta_ticks = 0;
> > > > > +            } else {
> > > > > +                delta_ticks(thd_stat, i);
> > > > > +            }
> > > > > +        }
> > > > > +
> > > > > +        /*
> > > > > +         * Identify the vCPU threads
> > > > > +         * Calculate the Number of vCPU per package
> > > > > +         */
> > > > > +        CPU_FOREACH(cpu) {
> > > > > +            for (int i = 0; i < num_threads; i++) {
> > > > > +                if (cpu->thread_id == thd_stat[i].thread_id) {
> > > > > +                    thd_stat[i].is_vcpu = true;
> > > > > +                    thd_stat[i].vcpu_id = cpu->cpu_index;
> > > > > +                    pkg_stat[thd_stat[i].numa_node_id].nb_vcpu++;
> > > > > +                    break;
> > > > > +                }
> > > > > +            }
> > > > > +        }
> > > > > +
> > > > > +        /* Calculate the total energy of all non-vCPU thread */
> > > > > +        for (int i = 0; i < num_threads; i++) {
> > > > > +            double temp;
> > > > > +            if ((thd_stat[i].is_vcpu != true) &&
> > > > > +                (thd_stat[i].delta_ticks > 0)) {
> > > > > +                temp = get_ratio(pkg_stat, thd_stat, maxticks, i);
> > > > > +                pkg_stat[thd_stat[i].numa_node_id].e_ratio
> > > > > +                    += (uint64_t)lround(temp);
> > > > > +            }
> > > > > +        }
> > > > > +
> > > > > +        /* Calculate the ratio per non-vCPU thread of each package */
> > > > > +        for (int i = 0; i <= maxpkgs; i++) {
> > > > > +            if (pkg_stat[i].nb_vcpu > 0) {
> > > > > +                pkg_stat[i].e_ratio = pkg_stat[i].e_ratio / pkg_stat[i].nb_vcpu;
> > > > > +            }
> > > > > +        }
> > > > > +
> > > > > +        /* Calculate the energy for each vCPU thread */
> > > > > +        for (int i = 0; i < num_threads; i++) {
> > > > > +            double temp;
> > > > > +
> > > > > +            if ((thd_stat[i].is_vcpu == true) &&
> > > > > +                (thd_stat[i].delta_ticks > 0)) {
> > > > > +                temp = get_ratio(pkg_stat, thd_stat, maxticks, i);
> > > > > +                vmsr->msr_value[thd_stat[i].vcpu_id] += (uint64_t)lround(temp);
> > > > > +                vmsr->msr_value[thd_stat[i].vcpu_id] \
> > > > > +                    += pkg_stat[thd_stat[i].numa_node_id].e_ratio;
> > > > > +            }
> > > > > +        }
> > > > > +
> > > > > +        /* free all memory */
> > > > > +        for (int i = 0; i < num_threads; i++) {
> > > > > +            free(thd_stat[i].utime);
> > > > > +            free(thd_stat[i].stime);
> > > > > +        }
> > > > > +        free(thd_stat);
> > > > > +        free(thread_ids);
> > > > > +    }
> > > > > +
> > > > > +    rcu_unregister_thread();
> > > > > +    return NULL;
> > > > > +}
> > > > > +
> > > > > +static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
> > > > > +{
> > > > > +    struct KVMMsrEnergy *r = &s->msr_energy;
> > > > > +
> > > > > +    /* Retrieve the number of vCPU */
> > > > > +    r->cpus = ms->smp.cpus;
> > > > > +
> > > > > +    /* Allocate register memory (MSR_PKG_STATUS) for each vCPU */
> > > > > +    r->msr_value = calloc(r->cpus, sizeof(r->msr_value));
> > > > > +
> > > > > +    qemu_thread_create(&r->msr_thr, "kvm-msr",
> > > > > +                       kvm_msr_energy_thread,
> > > > > +                       s, QEMU_THREAD_JOINABLE);
> > > > > +
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > >  int kvm_arch_init(MachineState *ms, KVMState *s)
> > > > >  {
> > > > >      uint64_t identity_base = 0xfffbc000;
> > > > > @@ -2765,6 +2998,46 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> > > > >                           strerror(-ret));
> > > > >              exit(1);
> > > > >          }
> > > > > +
> > > > > +        if (s->msr_energy.enable == true) {
> > > > > +
> > > > > +            r = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
> > > > > +                               kvm_rdmsr_rapl_power_unit, NULL);
> > > > > +            if (!r) {
> > > > > +                error_report("Could not install MSR_RAPL_POWER_UNIT \
> > > > > +                                handler: %s",
> > > > > +                             strerror(-ret));
> > > > > +                exit(1);
> > > > > +            }
> > > > > +
> > > > > +            r = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
> > > > > +                               kvm_rdmsr_pkg_power_limit, NULL);
> > > > > +            if (!r) {
> > > > > +                error_report("Could not install MSR_PKG_POWER_LIMIT \
> > > > > +                                handler: %s",
> > > > > +                             strerror(-ret));
> > > > > +                exit(1);
> > > > > +            }
> > > > > +
> > > > > +            r = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
> > > > > +                               kvm_rdmsr_pkg_power_info, NULL);
> > > > > +            if (!r) {
> > > > > +                error_report("Could not install MSR_PKG_POWER_INFO \
> > > > > +                                handler: %s",
> > > > > +                             strerror(-ret));
> > > > > +                exit(1);
> > > > > +            }
> > > > > +            r = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
> > > > > +                               kvm_rdmsr_pkg_energy_status, NULL);
> > > > > +            if (!r) {
> > > > > +                error_report("Could not install MSR_PKG_ENERGY_STATUS \
> > > > > +                                handler: %s",
> > > > > +                             strerror(-ret));
> > > > > +                exit(1);
> > > > > +            } else {
> > > > > +                kvm_msr_energy_thread_init(s, ms);
> > > > > +            }
> > > > > +        }
> > > > >      }
> > > > >  
> > > > >      return 0;
> > > > > diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
> > > > > index 322272091bce..9cdc93c6c439 100644
> > > > > --- a/target/i386/kvm/meson.build
> > > > > +++ b/target/i386/kvm/meson.build
> > > > > @@ -5,6 +5,7 @@ i386_softmmu_kvm_ss = ss.source_set()
> > > > >  i386_softmmu_kvm_ss.add(files(
> > > > >    'kvm.c',
> > > > >    'kvm-cpu.c',
> > > > > +  'vmsr_energy.c',
> > > > >  ))
> > > > >  
> > > > >  i386_softmmu_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
> > > > > diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
> > > > > new file mode 100644
> > > > > index 000000000000..8bd86b32becf
> > > > > --- /dev/null
> > > > > +++ b/target/i386/kvm/vmsr_energy.c
> > > > > @@ -0,0 +1,132 @@
> > > > > +/*
> > > > > + * QEMU KVM support -- x86 virtual energy-related MSR.
> > > > > + *
> > > > > + * Copyright 2023 Red Hat, Inc. 2023
> > > > > + *
> > > > > + *  Author:
> > > > > + *      Anthony Harivel <aharivel@redhat.com>
> > > > > + *
> > > > > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > > > > + * See the COPYING file in the top-level directory.
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +#include "vmsr_energy.h"
> > > > > +
> > > > > +#define MAX_PATH_LEN 50
> > > > > +#define MAX_LINE_LEN 500
> > > > > +
> > > > > +uint64_t read_msr(uint32_t reg, unsigned int cpu_id)
> > > > > +{
> > > > > +    int fd;
> > > > > +    uint64_t data;
> > > > > +
> > > > > +    char path[MAX_PATH_LEN];
> > > > > +    snprintf(path, MAX_PATH_LEN, "/dev/cpu/%u/msr", cpu_id);
> > > > > +
> > > > > +    fd = open(path , O_RDONLY);
> > > > > +    if (fd < 0) {
> > > > > +        return 0;
> > > > > +    }
> > > > > +    if (pread(fd, &data, sizeof data, reg) != sizeof data) {
> > > > > +        data = 0;
> > > > > +    }
> > > > > +
> > > > > +    close(fd);
> > > > > +    return data;
> > > > > +}
> > > > > +
> > > > > +/* Retrieve the number of physical CPU on the package */
> > > > > +unsigned int get_maxcpus(unsigned int package_num)
> > > > > +{
> > > > > +    int k, ncpus;
> > > > > +    unsigned int maxcpus;
> > > > > +    struct bitmask *cpus;
> > > > > +
> > > > > +    cpus = numa_allocate_cpumask();
> > > > > +    ncpus = cpus->size;
> > > > > +
> > > > > +    if (numa_node_to_cpus(package_num, cpus) < 0) {
> > > > > +        printf("node %u failed to convert\n", package_num);
> > > > > +    }
> > > > > +
> > > > > +    maxcpus = 0;
> > > > > +    for (k = 0; k < ncpus; k++) {
> > > > > +        if (numa_bitmask_isbitset(cpus, k)) {
> > > > > +            maxcpus++;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    return maxcpus;
> > > > > +}
> > > > > +
> > > > > +int read_thread_stat(struct thread_stat *thread, int pid, int index)
> > > > > +{
> > > > > +    char path[MAX_PATH_LEN];
> > > > > +    snprintf(path, MAX_PATH_LEN, "/proc/%u/task/%d/stat", pid, \
> > > > > +             thread->thread_id);
> > > > > +
> > > > > +    FILE *file = fopen(path, "r");
> > > > > +    if (file == NULL) {
> > > > > +        return -1;
> > > > > +    }
> > > > > +
> > > > > +    if (fscanf(file, "%*d (%*[^)]) %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u"
> > > > > +        " %llu %llu %*d %*d %*d %*d %*d %*d %*u %*u %*d %*u %*u"
> > > > > +        " %*u %*u %*u %*u %*u %*u %*u %*u %*u %*d %*u %*u %u",
> > > > > +           &thread->utime[index], &thread->stime[index], &thread->cpu_id) != 3)
> > > > > +        return -1;
> > > > > +
> > > > > +    fclose(file);
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > > +/* Read QEMU stat task folder to retrieve all QEMU threads ID */
> > > > > +pid_t *get_thread_ids(pid_t pid, int *num_threads)
> > > > > +{
> > > > > +    char path[100];
> > > > > +    sprintf(path, "/proc/%d/task", pid);
> > > > > +
> > > > > +    DIR *dir = opendir(path);
> > > > > +    if (dir == NULL) {
> > > > > +        perror("opendir");
> > > > > +        return NULL;
> > > > > +    }
> > > > > +
> > > > > +    pid_t *thread_ids = NULL;
> > > > > +    int thread_count = 0;
> > > > > +
> > > > > +    struct dirent *ent;
> > > > > +    while ((ent = readdir(dir)) != NULL) {
> > > > > +        if (ent->d_name[0] == '.') {
> > > > > +            continue;
> > > > > +        }
> > > > > +        pid_t tid = atoi(ent->d_name);
> > > > > +        if (pid != tid) {
> > > > > +            thread_ids = realloc(thread_ids,
> > > > > +                                 (thread_count + 1) * sizeof(pid_t));
> > > > > +            thread_ids[thread_count] = tid;
> > > > > +            thread_count++;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    closedir(dir);
> > > > > +
> > > > > +    *num_threads = thread_count;
> > > > > +    return thread_ids;
> > > > > +}
> > > > > +
> > > > > +void delta_ticks(thread_stat *thd_stat, int i)
> > > > > +{
> > > > > +    thd_stat[i].delta_ticks = (thd_stat[i].utime[1] + thd_stat[i].stime[1])
> > > > > +                            - (thd_stat[i].utime[0] + thd_stat[i].stime[0]);
> > > > > +}
> > > > > +
> > > > > +double get_ratio(package_energy_stat *pkg_stat,
> > > > > +                        thread_stat *thd_stat,
> > > > > +                        int maxticks, int i) {
> > > > > +
> > > > > +    return (pkg_stat[thd_stat[i].numa_node_id].e_delta / 100.0)
> > > > > +            * ((100.0 / maxticks) * thd_stat[i].delta_ticks);
> > > > > +}
> > > > > +
> > > > > diff --git a/target/i386/kvm/vmsr_energy.h b/target/i386/kvm/vmsr_energy.h
> > > > > new file mode 100644
> > > > > index 000000000000..5f79d2cbe00d
> > > > > --- /dev/null
> > > > > +++ b/target/i386/kvm/vmsr_energy.h
> > > > > @@ -0,0 +1,80 @@
> > > > > +/*
> > > > > + * QEMU KVM support -- x86 virtual energy-related MSR.
> > > > > + *
> > > > > + * Copyright 2023 Red Hat, Inc. 2023
> > > > > + *
> > > > > + *  Author:
> > > > > + *      Anthony Harivel <aharivel@redhat.com>
> > > > > + *
> > > > > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > > > > + * See the COPYING file in the top-level directory.
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +#ifndef VMSR_ENERGY_H
> > > > > +#define VMSR_ENERGY_H
> > > > > +
> > > > > +#include "qemu/osdep.h"
> > > > > +
> > > > > +#include <numa.h>
> > > > > +
> > > > > +/*
> > > > > + * Define the interval time in micro seconds between 2 samples of
> > > > > + * energy related MSRs
> > > > > + */
> > > > > +#define MSR_ENERGY_THREAD_SLEEP_US 1000000.0
> > > > > +
> > > > > +/*
> > > > > + * Thread statistic
> > > > > + * @ thread_id: TID (thread ID)
> > > > > + * @ is_vcpu: true is thread is vCPU thread
> > > > > + * @ cpu_id: CPU number last executed on
> > > > > + * @ vcpu_id: vCPU ID
> > > > > + * @ numa_node_id:node number of the CPU
> > > > > + * @ utime: amount of clock ticks the thread
> > > > > + *          has been scheduled in User mode
> > > > > + * @ stime: amount of clock ticks the thread
> > > > > + *          has been scheduled in System mode
> > > > > + * @ delta_ticks: delta of utime+stime between
> > > > > + *          the two samples (before/after sleep)
> > > > > + */
> > > > > +struct thread_stat {
> > > > > +    unsigned int thread_id;
> > > > > +    bool is_vcpu;
> > > > > +    unsigned int cpu_id;
> > > > > +    unsigned int vcpu_id;
> > > > > +    unsigned int numa_node_id;
> > > > > +    unsigned long long *utime;
> > > > > +    unsigned long long *stime;
> > > > > +    unsigned long long delta_ticks;
> > > > > +};
> > > > > +
> > > > > +/*
> > > > > + * Package statistic
> > > > > + * @ e_start: package energy counter before the sleep
> > > > > + * @ e_end: package energy counter after the sleep
> > > > > + * @ e_delta: delta of package energy counter
> > > > > + * @ e_ratio: store the energy ratio of non-vCPU thread
> > > > > + * @ nb_vcpu: number of vCPU running on this package
> > > > > + */
> > > > > +struct packge_energy_stat {
> > > > > +    uint64_t e_start;
> > > > > +    uint64_t e_end;
> > > > > +    uint64_t e_delta;
> > > > > +    uint64_t e_ratio;
> > > > > +    unsigned int nb_vcpu;
> > > > > +};
> > > > > +
> > > > > +typedef struct thread_stat thread_stat;
> > > > > +typedef struct packge_energy_stat package_energy_stat;
> > > > > +
> > > > > +uint64_t read_msr(uint32_t reg, unsigned int cpu_id);
> > > > > +void delta_ticks(thread_stat *thd_stat, int i);
> > > > > +unsigned int get_maxcpus(unsigned int package_num);
> > > > > +int read_thread_stat(struct thread_stat *thread, int pid, int index);
> > > > > +pid_t *get_thread_ids(pid_t pid, int *num_threads);
> > > > > +double get_ratio(package_energy_stat *pkg_stat,
> > > > > +                        thread_stat *thd_stat,
> > > > > +                        int maxticks, int i);
> > > > > +
> > > > > +#endif /* VMSR_ENERGY_H */
> > > > > --=2


