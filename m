Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A90F67DE047
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 12:25:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy9L3-00079G-CS; Wed, 01 Nov 2023 07:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qy9Ky-000790-Ao
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 07:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qy9Ku-0006v2-NQ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 07:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698837875;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4u1LCBhCQ2ngvR171tWSPGJvOXM0giZVNHWRomDkQok=;
 b=XdMc9k6JB/i8U5oc6GKyu/4IAtAuGN37pX2Zh0U42TwusIjB3sE8p2B5pV5Q4cH62PGDET
 5tz3kK7t93g+U4Pf/SqfEPeVlfMLLBkxWzvx7876lmKSoMKi8ydMj9pMkRplHZmnkrwZlM
 Hru1K9hs4ZD21C8BYY3EptUNiz7w3+E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-6UlysqfdP_q-0F1u5r28qg-1; Wed, 01 Nov 2023 07:24:33 -0400
X-MC-Unique: 6UlysqfdP_q-0F1u5r28qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E131185A781
 for <qemu-devel@nongnu.org>; Wed,  1 Nov 2023 11:24:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 810042026D4C;
 Wed,  1 Nov 2023 11:24:32 +0000 (UTC)
Date: Wed, 1 Nov 2023 11:24:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com
Subject: Re: [PATCH v2 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <ZUI1bm58U0tX+wjv@redhat.com>
References: <20231031144605.64822-1-aharivel@redhat.com>
 <20231031144605.64822-4-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231031144605.64822-4-aharivel@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Oct 31, 2023 at 03:46:03PM +0100, Anthony Harivel wrote:
> Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
> interface (Running Average Power Limit) for advertising the accumulated
> energy consumption of various power domains (e.g. CPU packages, DRAM,
> etc.).
> 
> The consumption is reported via MSRs (model specific registers) like
> MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
> 64 bits registers that represent the accumulated energy consumption in
> micro Joules. They are updated by microcode every ~1ms.
> 
> For now, KVM always returns 0 when the guest requests the value of
> these MSRs. Use the KVM MSR filtering mechanism to allow QEMU handle
> these MSRs dynamically in userspace.
> 
> To limit the amount of system calls for every MSR call, create a new
> thread in QEMU that updates the "virtual" MSR values asynchronously.
> 
> Each vCPU has its own vMSR to reflect the independence of vCPUs. The
> thread updates the vMSR values with the ratio of energy consumed of
> the whole physical CPU package the vCPU thread runs on and the
> thread's utime and stime values.
> 
> All other non-vCPU threads are also taken into account. Their energy
> consumption is evenly distributed among all vCPUs threads running on
> the same physical CPU package.
> 
> To overcome the problem that reading the RAPL MSR requires priviliged
> access, a socket communication between QEMU and the qemu-vmsr-helper is
> mandatory. You can specified the socket path in the parameter.
> 
> This feature is activated with -accel kvm,rapl=true,path=/path/sock.sock
> 
> Actual limitation:
> - Works only on Intel host CPU because AMD CPUs are using different MSR
>   adresses.
> 
> - Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at
>   the moment.
> 
> - Since each vCPU has an independent vMSR value, the vCPU topology must
>   be changed to match that reality. There must be a single vCPU per
>   virtual socket (e.g.: -smp 4,sockets=4). Accessing pkg-0 energy will
>   give vCPU 0 energy, pkg-1 will give vCPU 1 energy, etc.
> 
> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> 
>  accel/kvm/kvm-all.c           |  26 +++
>  docs/specs/index.rst          |   1 +
>  docs/specs/rapl-msr.rst       | 131 +++++++++++++++
>  include/sysemu/kvm_int.h      |  12 ++
>  target/i386/cpu.h             |   8 +
>  target/i386/kvm/kvm.c         | 308 ++++++++++++++++++++++++++++++++++
>  target/i386/kvm/meson.build   |   1 +
>  target/i386/kvm/vmsr_energy.c | 278 ++++++++++++++++++++++++++++++
>  target/i386/kvm/vmsr_energy.h |  82 +++++++++
>  9 files changed, 847 insertions(+)
>  create mode 100644 docs/specs/rapl-msr.rst
>  create mode 100644 target/i386/kvm/vmsr_energy.c
>  create mode 100644 target/i386/kvm/vmsr_energy.h
> 


> @@ -3840,6 +3856,16 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
>      object_class_property_set_description(oc, "dirty-ring-size",
>          "Size of KVM dirty page ring buffer (default: 0, i.e. use bitmap)");
>  
> +    object_class_property_add_bool(oc, "rapl",
> +                                   NULL,
> +                                   kvm_set_kvm_rapl);
> +    object_class_property_set_description(oc, "rapl",
> +        "Allow energy related MSRs for RAPL interface in Guest");
> +
> +    object_class_property_add_str(oc, "path", NULL,
> +                                  kvm_set_kvm_rapl_socket_path);

"path" is an awfully generic property name to be setting on the
KVM accelerator. This needs to be something like "rapl-helper-socket"

> +    object_class_property_set_description(oc, "path",
> +        "Socket Path for comminucating with the Virtual MSR helper daemon");
>      kvm_arch_accel_class_init(oc);
>  }
>  

> diff --git a/docs/specs/rapl-msr.rst b/docs/specs/rapl-msr.rst
> new file mode 100644
> index 000000000000..ec62a8206337
> --- /dev/null
> +++ b/docs/specs/rapl-msr.rst
> @@ -0,0 +1,131 @@
> +================
> +RAPL MSR support
> +================
> +
> +The RAPL interface (Running Average Power Limit) is advertising the accumulated
> +energy consumption of various power domains (e.g. CPU packages, DRAM, etc.).
> +
> +The consumption is reported via MSRs (model specific registers) like
> +MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are 64 bits
> +registers that represent the accumulated energy consumption in micro Joules.

> +The MSR_PKG_ENERGY_STATUS is a counter; it represents the total amount of
> +energy consumed since the last time the register was cleared. If you multiply
> +it with the UNIT provided above you'll get the power in micro-joules. This
> +counter is always increasing and it increases more or less faster depending on
> +the consumption of the package. This counter is supposed to overflow at some
> +point.

What happens when we live migrate the guest.

This is just as likely to result in values decreasing as increasing, on
the new host. You could call it "overflow" if the new host has a value
lower than the old host, but is there risk that whatever consumes this
data gets confused, if it overflows with an insanely large jump ?

Are there any other consequences of live migration that could cause
problems, requiring a blocker ?


> +High level implementation
> +-------------------------
> +
> +In order to update the value of the virtual MSR, a QEMU thread is created.
> +The thread is basically just an infinity loop that does:
> +
> +1. Snapshot of the time metrics of all QEMU threads (Time spent scheduled in
> +   Userspace and System)
> +
> +2. Snapshot of the actual MSR_PKG_ENERGY_STATUS counter of all packages where
> +   the QEMU threads are running on.
> +
> +3. Sleep for 1 second - During this pause the vcpu and other non-vcpu threads
> +   will do what they have to do and so the energy counter will increase.
> +
> +4. Repeat 2. and 3. and calculate the delta of every metrics representing the
> +   time spent scheduled for each QEMU thread *and* the energy spent by the
> +   packages during the pause.
> +
> +5. Filter the vcpu threads and the non-vcpu threads.
> +
> +6. The total energy spent by the non-vcpu threads is divided by the number
> +   of vcpu threads so that each vcpu thread will get an equal part of the
> +   energy spent by the QEMU workers.
> +
> +7. Calculate the ratio of energy spent per vcpu threads.
> +
> +8. The virtual MSRs are updated for each vcpu by adding for each vcpu the
> +   energy spent + the quote part of the non-vcpu.

This appears to be assuming that each vCPU is 1:1 pinned to a
specific host pCPU. If the vCPU is floating across different
pCPUs, then surely the energy readings will be going forwards
and backwards every time the host moves a vCPU ?

> +
> +9. loop back to 1.
> +
> +Ratio calculation
> +-----------------
> +
> +In Linux, a process has an execution time associated with it. The scheduler is
> +dividing the time in clock ticks. The number of clock ticks per second can be
> +found by the sysconf system call. A typical value of clock ticks per second is
> +100. So a core can run a process at the maximum of 100 ticks per second. If a
> +package has 4 cores, 400 ticks maximum can be scheduled on all the cores
> +of the package for a period of 1 second.
> +
> +The /proc/[pid]/stat [#b]_ is a sysfs file that can give the executed time of a
> +process with the [pid] as the process ID. It gives the amount of ticks the
> +process has been scheduled in userspace (utime) and kernel space (stime).
> +
> +By reading those metrics for a thread, one can calculate the ratio of time the
> +package has spent executing the thread.
> +
> +Example:
> +
> +A 4 cores package can schedule a maximum of 400 ticks per second with 100 ticks
> +per second per core. If a thread was scheduled for 100 ticks between a second
> +on this package, that means my thread has been scheduled for 1/4 of the whole
> +package. With that, the calculation of the energy spent by the thread on this
> +package during this whole second is 1/4 of the total energy spent by the
> +package.

/proc/$PID/stat reports the execution time across all host CPUs
for the process. To cope with vCPUs floating across host pCPUs,
we surely need to sum the energy usage across all packages,
and scale that by the execution time. We can't scale energy of
the individual packages in isolation if we don't have execution
time specific to each package

> +Current Limitations
> +-------------------
> +
> +- Works only on Intel host CPUs because AMD CPUs are using different MSR
> +  addresses.

What about the relation with guest CPU model too ?

If we're exposing MSRs to the guest that are only defined for Intel CPUs,
then we should only expose them, if the guest CPU model vendor == Intel
too. 

> +- Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at the
> +  moment.
> +
> +- Since each vCPU has an independent vMSR value, the vCPU topology must be
> +  changed to match that reality. There must be a single vCPU per virtual socket
> +  (e.g.: -smp 4,sockets=4). Accessing pkg-0 energy will give vCPU 0 energy,
> +  pkg-1 will give vCPU 1 energy, etc.

This is quite unfortunate, as in general it is a bad idea to expose
large socket counts to guests. Some OS have punative licensing rules
for large sockets. Generally real world hardware has small socket
counts, with large core counts which is why QEMU changed to expose
cores by default and we recommend mgmt apps todo this too.

The most obvious & accurate scenario to use this functionality is
when doing host CPU passthrough, with strict CPU pinning, and
matching host/guest topology. So I think removing this limitation
is critical to making this feature useful.


> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index e7c054cc160b..6dd8576b6ef6 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c

> @@ -2558,6 +2607,225 @@ static void register_smram_listener(Notifier *n, void *unused)
>                                   &smram_address_space, 1, "kvm-smram");
>  }
>  
> +static void *kvm_msr_energy_thread(void *data)
> +{
> +    KVMState *s = data;
> +    struct KVMMsrEnergy *vmsr = &s->msr_energy;
> +    unsigned int maxpkgs, maxcpus, maxticks;
> +    package_energy_stat *pkg_stat;
> +    int num_threads, tmp_num_threads = 0;
> +    thread_stat *thd_stat;

  g_autofree

> +    CPUState *cpu;
> +    pid_t pid, *thread_ids;

 g_autofree  pid_t *thread_ids;

> +
> +    rcu_register_thread();
> +
> +    /* Get QEMU PID*/
> +    pid = getpid();
> +
> +    /* Assuming those values are the same accross physical system/packages */
> +    /* Nb of CPUS per packages */
> +    maxcpus = vmsr_get_maxcpus(0);
> +    /* Nb of Physical Packages on the system */
> +    maxpkgs = vmsr_get_max_physical_package(maxcpus);
> +
> +    if (maxpkgs == 0) {
> +        return NULL;
> +    }
> +
> +    /* Those MSR values should not change as well */
> +    vmsr->msr_unit  = vmsr_read_msr(MSR_RAPL_POWER_UNIT, 0, pid,
> +                                    s->msr_energy.socket_path);
> +    vmsr->msr_limit = vmsr_read_msr(MSR_PKG_POWER_LIMIT, 0, pid,
> +                                    s->msr_energy.socket_path);
> +    vmsr->msr_info  = vmsr_read_msr(MSR_PKG_POWER_INFO, 0, pid,
> +                                    s->msr_energy.socket_path);
> +
> +    /* Allocate memory for each package energy status */
> +    pkg_stat = (package_energy_stat *)
> +        g_malloc0(maxpkgs * sizeof(package_energy_stat));

Use g_new0(package_energy_stat, maxpkgs)

> +
> +    /* Pre-allocate memory for thread stats */
> +    thd_stat = g_new0(thread_stat, 1);
> +
> +    /*
> +     * Max numbers of ticks per package
> +     * time in second * number of ticks/second * Number of cores / package
> +     * ex: for 100 ticks/second/CPU, 12 CPUs per Package gives 1200 ticks max
> +     */
> +    maxticks = (MSR_ENERGY_THREAD_SLEEP_US / 1000000)
> +                    * sysconf(_SC_CLK_TCK) * maxcpus;
> +
> +    while (true) {
> +
> +        /* Get all qemu threads id */
> +        thread_ids = vmsr_get_thread_ids(pid, &num_threads);
> +
> +        if (thread_ids == NULL) {
> +            goto clean;
> +        }
> +
> +        if (tmp_num_threads < num_threads) {
> +
> +            void *tmp_ptr;
> +
> +            tmp_ptr = g_realloc(thd_stat, num_threads * sizeof(thread_stat));

g_renew(thread_stat, thd_stat, num_threads)

> +            thd_stat = (thread_stat *) tmp_ptr;
> +        }
> +
> +        tmp_num_threads = num_threads;
> +
> +        /* Populate all the thread stats */
> +        for (int i = 0; i < num_threads; i++) {
> +            thd_stat[i].utime = calloc(2, sizeof(unsigned long long));
> +            thd_stat[i].stime = calloc(2, sizeof(unsigned long long));

g_new0

> +            thd_stat[i].thread_id = thread_ids[i];
> +            vmsr_read_thread_stat(&thd_stat[i], pid, 0);
> +            thd_stat[i].numa_node_id = numa_node_of_cpu(thd_stat[i].cpu_id);
> +        }
> +
> +        /* Retrieve all packages power plane energy counter */
> +        for (int i = 0; i <= maxpkgs; i++) {
> +            for (int j = 0; j < num_threads; j++) {
> +                /*
> +                 * Use the first thread we found that ran on the CPU
> +                 * of the package to read the packages energy counter
> +                 */
> +                if (thd_stat[j].numa_node_id == i) {
> +                    pkg_stat[i].e_start =
> +                    vmsr_read_msr(MSR_PKG_ENERGY_STATUS, i, pid,
> +                                  s->msr_energy.socket_path);
> +                    break;
> +                }
> +            }
> +        }
> +
> +        /* Sleep a short period while the other threads are working */
> +        usleep(MSR_ENERGY_THREAD_SLEEP_US);
> +
> +        /*
> +         * Retrieve all packages power plane energy counter
> +         * Calculate the delta of all packages
> +         */
> +        for (int i = 0; i <= maxpkgs; i++) {
> +            for (int j = 0; j < num_threads; j++) {
> +                /*
> +                 * Use the first thread we found that ran on the CPU
> +                 * of the package to read the packages energy counter
> +                 */
> +                if (thd_stat[j].numa_node_id == i) {
> +                    pkg_stat[i].e_end =
> +                       vmsr_read_msr(MSR_PKG_ENERGY_STATUS,
> +                                     thd_stat[j].cpu_id,
> +                                     thd_stat[j].thread_id,
> +                                     s->msr_energy.socket_path);
> +                    pkg_stat[i].e_delta =
> +                        pkg_stat[i].e_end - pkg_stat[i].e_start;
> +                    break;
> +                }
> +            }
> +        }
> +
> +        /* Delta of ticks spend by each thread between the sample */
> +        for (int i = 0; i < num_threads; i++) {
> +            if (vmsr_read_thread_stat(&thd_stat[i], pid, 1) != 0) {
> +                /*
> +                 * We don't count the dead thread
> +                 * i.e threads that existed before the sleep
> +                 * and not anymore
> +                 */
> +                thd_stat[i].delta_ticks = 0;
> +            } else {
> +                vmsr_delta_ticks(thd_stat, i);
> +            }
> +        }
> +
> +        /*
> +         * Identify the vCPU threads
> +         * Calculate the Number of vCPU per package
> +         */
> +        CPU_FOREACH(cpu) {
> +            for (int i = 0; i < num_threads; i++) {
> +                if (cpu->thread_id == thd_stat[i].thread_id) {
> +                    thd_stat[i].is_vcpu = true;
> +                    thd_stat[i].vcpu_id = cpu->cpu_index;
> +                    pkg_stat[thd_stat[i].numa_node_id].nb_vcpu++;
> +                    break;
> +                }
> +            }
> +        }
> +
> +        /* Calculate the total energy of all non-vCPU thread */
> +        for (int i = 0; i < num_threads; i++) {
> +            double temp;
> +            if ((thd_stat[i].is_vcpu != true) &&
> +                (thd_stat[i].delta_ticks > 0)) {
> +                temp = vmsr_get_ratio(pkg_stat, thd_stat, maxticks, i);
> +                pkg_stat[thd_stat[i].numa_node_id].e_ratio
> +                    += (uint64_t)lround(temp);
> +            }
> +        }
> +
> +        /* Calculate the ratio per non-vCPU thread of each package */
> +        for (int i = 0; i <= maxpkgs; i++) {
> +            if (pkg_stat[i].nb_vcpu > 0) {
> +                pkg_stat[i].e_ratio = pkg_stat[i].e_ratio / pkg_stat[i].nb_vcpu;
> +            }
> +        }
> +
> +        /* Calculate the energy for each vCPU thread */
> +        for (int i = 0; i < num_threads; i++) {
> +            double temp;
> +
> +            if ((thd_stat[i].is_vcpu == true) &&
> +                (thd_stat[i].delta_ticks > 0)) {
> +                temp = vmsr_get_ratio(pkg_stat, thd_stat, maxticks, i);
> +                vmsr->msr_value[thd_stat[i].vcpu_id] += (uint64_t)lround(temp);
> +                vmsr->msr_value[thd_stat[i].vcpu_id] \
> +                    += pkg_stat[thd_stat[i].numa_node_id].e_ratio;
> +            }
> +        }
> +
> +        /* free all memory */
> +        for (int i = 0; i < num_threads; i++) {
> +            memset(thd_stat[i].utime, 0, 2 * sizeof(unsigned long long));
> +            memset(thd_stat[i].stime, 0, 2 * sizeof(unsigned long long));
> +        }
> +        /* Zero out the memory */

This comment should be further up, as 'free all memory' is inaccurate

> +        memset(thd_stat, 0, num_threads * sizeof(thread_stat));
> +        memset(thread_ids, 0, sizeof(pid_t));
> +    }
> +
> +clean:
> +    /* free all memory */
> +    for (int i = 0; i < num_threads; i++) {
> +        g_free(thd_stat[i].utime);
> +        g_free(thd_stat[i].stime);
> +    }
> +    g_free(thd_stat);
> +    g_free(thread_ids);

Redundat if using g_aitofree

> +
> +    rcu_unregister_thread();
> +    return NULL;
> +}
> +
> +static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
> +{
> +    struct KVMMsrEnergy *r = &s->msr_energy;
> +
> +    /* Retrieve the number of vCPU */
> +    r->cpus = ms->smp.cpus;
> +
> +    /* Allocate register memory (MSR_PKG_STATUS) for each vCPU */
> +    r->msr_value = calloc(r->cpus, sizeof(r->msr_value));

g_new0 please.

> +
> +    qemu_thread_create(&r->msr_thr, "kvm-msr",
> +                       kvm_msr_energy_thread,
> +                       s, QEMU_THREAD_JOINABLE);
> +
> +    return 0;
> +}
> +
>  int kvm_arch_get_default_type(MachineState *ms)
>  {
>      return 0;
> @@ -2774,6 +3042,46 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>                           strerror(-ret));
>              exit(1);
>          }
> +
> +        if (s->msr_energy.enable == true) {
> +
> +            r = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
> +                               kvm_rdmsr_rapl_power_unit, NULL);
> +            if (!r) {
> +                error_report("Could not install MSR_RAPL_POWER_UNIT \
> +                                handler: %s",
> +                             strerror(-ret));
> +                exit(1);
> +            }
> +
> +            r = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
> +                               kvm_rdmsr_pkg_power_limit, NULL);
> +            if (!r) {
> +                error_report("Could not install MSR_PKG_POWER_LIMIT \
> +                                handler: %s",
> +                             strerror(-ret));
> +                exit(1);
> +            }
> +
> +            r = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
> +                               kvm_rdmsr_pkg_power_info, NULL);
> +            if (!r) {
> +                error_report("Could not install MSR_PKG_POWER_INFO \
> +                                handler: %s",
> +                             strerror(-ret));
> +                exit(1);
> +            }
> +            r = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
> +                               kvm_rdmsr_pkg_energy_status, NULL);
> +            if (!r) {
> +                error_report("Could not install MSR_PKG_ENERGY_STATUS \
> +                                handler: %s",
> +                             strerror(-ret));
> +                exit(1);
> +            } else {
> +                kvm_msr_energy_thread_init(s, ms);
> +            }
> +        }

Presumably something here should be validating that we're on an Intel
host, and using an Intel guest CPU model.

>      }
>  
>      return 0;

> diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
> new file mode 100644
> index 000000000000..9f21ef2250a4
> --- /dev/null
> +++ b/target/i386/kvm/vmsr_energy.c
> @@ -0,0 +1,278 @@
> +/*
> + * QEMU KVM support -- x86 virtual energy-related MSR.
> + *
> + * Copyright 2023 Red Hat, Inc. 2023
> + *
> + *  Author:
> + *      Anthony Harivel <aharivel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "vmsr_energy.h"
> +#include <stdint.h>
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "io/channel.h"
> +#include "io/channel-socket.h"
> +
> +#define MAX_PATH_LEN 50
> +#define MAX_LINE_LEN 500
> +
> +static char *compute_default_paths(void)
> +{
> +    g_autofree char *state = qemu_get_local_state_dir();
> +
> +    return g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
> +}
> +
> +static int vmsr_helper_socket_read(QIOChannel *ioc,
> +                                  void *buf, int sz, Error **errp)
> +{
> +    ssize_t r = qio_channel_read_all(ioc, buf, sz, errp);
> +
> +    if (r < 0) {
> +        object_unref(OBJECT(ioc));
> +        ioc = NULL;
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vmsr_helper_socket_write(QIOChannel *ioc,
> +                                   int fd,
> +                                   const void *buf, int sz, Error **errp)
> +{
> +    size_t nfds = (fd != -1);
> +    while (sz > 0) {
> +        struct iovec iov;
> +        ssize_t n_written;
> +
> +        iov.iov_base = (void *)buf;
> +        iov.iov_len = sz;
> +        n_written = qio_channel_writev_full(QIO_CHANNEL(ioc), &iov, 1,
> +                                            nfds ? &fd : NULL, nfds, 0, errp);
> +
> +        if (n_written <= 0) {
> +            assert(n_written != QIO_CHANNEL_ERR_BLOCK);
> +            object_unref(OBJECT(ioc));
> +            ioc = NULL;
> +            return n_written < 0 ? -EINVAL : 0;
> +        }
> +
> +        nfds = 0;
> +        buf += n_written;
> +        sz -= n_written;
> +    }

There is only one caller and it is pass -1 for fd. So this entire
method can be deleted. Just call qio_channel_writev_all().


> +uint64_t vmsr_read_msr(uint32_t reg, unsigned int cpu_id, uint32_t tid,
> +                       const char *path)
> +{
> +    uint64_t data = 0;
> +    char *socket_path = NULL;

g_autofree

> +    unsigned int buffer[3];

The server side is expecting strictly 'uint32_t' sized data.

> +
> +    if (path == NULL) {
> +        socket_path = compute_default_paths();
> +    } else {
> +        socket_path = g_strdup(path);
> +    }
> +
> +    SocketAddress saddr = {
> +        .type = SOCKET_ADDRESS_TYPE_UNIX,
> +        .u.q_unix.path = socket_path
> +    };
> +    QIOChannelSocket *sioc = qio_channel_socket_new();
> +    Error *local_err = NULL;
> +
> +    int r;
> +
> +    qio_channel_set_name(QIO_CHANNEL(sioc), "vmsr-helper");
> +    qio_channel_socket_connect_sync(sioc,
> +                                    &saddr,
> +                                    &local_err);
> +    g_free(socket_path);
> +    if (local_err) {
> +        goto out_close;
> +    }
> +
> +    /*
> +     * Send the required arguments:
> +     * 1. RAPL MSR register to read
> +     * 2. On which CPU ID
> +     * 3. From which vCPU (Thread ID)
> +     */
> +    buffer[0] = reg;
> +    buffer[1] = cpu_id;
> +    buffer[2] = tid;
> +
> +    r = vmsr_helper_socket_write(QIO_CHANNEL(sioc),
> +                                 -1,
> +                                 &buffer, sizeof(buffer),
> +                                 &local_err);
> +    if (r < 0) {
> +        goto out_close;
> +    }
> +
> +    r = vmsr_helper_socket_read(QIO_CHANNEL(sioc),
> +                                &data, sizeof(data),
> +                                &local_err);
> +    if (r < 0) {
> +        data = 0;
> +        goto out_close;
> +    }
> +
> +out_close:
> +    /* Close socket. */
> +    qio_channel_close(QIO_CHANNEL(sioc), NULL);
> +    object_unref(OBJECT(sioc));
> +    return data;
> +}

> +/* Retrieve the maximum number of physical package */
> +unsigned int vmsr_get_max_physical_package(unsigned int max_cpus)
> +{
> +    unsigned int packageCount = 0;
> +    int *uniquePackages;

g_autofree int *uniquePackages = NULL;

> +
> +    char filePath[256];
> +    FILE *file;
> +
> +    uniquePackages = g_malloc0(max_cpus * sizeof(int));
> +
> +    for (int i = 0; ; i++) {
> +        snprintf(filePath, sizeof(filePath),
> +            "/sys/devices/system/cpu/cpu%d/topology/physical_package_id", i);

g_build_filename please.

> +        file = fopen(filePath, "r");
> +
> +        if (file == NULL) {
> +            break;
> +        }
> +
> +        char packageId[10];
> +        if (fgets(packageId, sizeof(packageId), file) == NULL) {
> +            packageCount = 0;
> +        }
> +        fclose(file);

Can be simplified with the fixed buffer size removed:

   g_autofree char *packageid = NULL;
   GError err;
   if (!g_file_get_contents(filePath, &packageid, NULL, gerr)) {
       ....report some with 'err'....
   }

> +
> +        int currentPackageId = atoi(packageId);
> +
> +        bool isUnique = true;
> +        for (int j = 0; j < packageCount; j++) {
> +            if (uniquePackages[j] == currentPackageId) {
> +                isUnique = false;
> +                break;
> +            }
> +        }
> +
> +        if (isUnique) {
> +            uniquePackages[packageCount] = currentPackageId;
> +            packageCount++;
> +        }
> +    }
> +
> +    g_free(uniquePackages);

Remove with g_autofree

> +    return packageCount;
> +}
> +
> +int vmsr_read_thread_stat(struct thread_stat *thread, int pid, int index)
> +{
> +    char path[MAX_PATH_LEN];
> +    snprintf(path, MAX_PATH_LEN, "/proc/%u/task/%d/stat", pid, \
> +             thread->thread_id);

g_build_filename

> +
> +    FILE *file = fopen(path, "r");
> +    if (file == NULL) {
> +        return -1;
> +    }
> +
> +    if (fscanf(file, "%*d (%*[^)]) %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u"
> +        " %llu %llu %*d %*d %*d %*d %*d %*d %*u %*u %*d %*u %*u"
> +        " %*u %*u %*u %*u %*u %*u %*u %*u %*u %*d %*u %*u %u",
> +           &thread->utime[index], &thread->stime[index], &thread->cpu_id) != 3)
> +        return -1;
> +
> +    fclose(file);
> +    return 0;
> +}
> +
> +/* Read QEMU stat task folder to retrieve all QEMU threads ID */
> +pid_t *vmsr_get_thread_ids(pid_t pid, int *num_threads)
> +{
> +    char path[100];
> +    sprintf(path, "/proc/%d/task", pid);

g_build_filename

> +
> +    DIR *dir = opendir(path);
> +    if (dir == NULL) {
> +        perror("opendir");
> +        return NULL;
> +    }
> +
> +    pid_t *thread_ids = NULL;
> +    int thread_count = 0;
> +
> +    struct dirent *ent;
> +    while ((ent = readdir(dir)) != NULL) {
> +        if (ent->d_name[0] == '.') {
> +            continue;
> +        }
> +        pid_t tid = atoi(ent->d_name);
> +        if (pid != tid) {
> +            thread_ids = g_realloc(thread_ids,
> +                                 (thread_count + 1) * sizeof(pid_t));

g_renew

> +            thread_ids[thread_count] = tid;
> +            thread_count++;
> +        }
> +    }
> +
> +    closedir(dir);
> +
> +    *num_threads = thread_count;
> +    return thread_ids;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


