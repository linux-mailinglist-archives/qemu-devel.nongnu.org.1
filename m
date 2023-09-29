Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4577B2AE7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 06:16:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm4uX-0005DP-0o; Fri, 29 Sep 2023 00:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm4uV-0005D6-Ht
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 00:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm4uS-0002R1-Tr
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 00:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695960923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J20xDGLTbKuBA30clBAfcVaDmbadwIw635CoZGQ5C3o=;
 b=aVe09MSiZmlOspPy6yHYRKXtMOAt0f+7OhBSnKIKmciKXZuE8tRbA0o5ai1ht/2FeofuVe
 p8rVhyp21OceDSSNa1H8Amb85Obdr+0Ql/0r7oFpPxKiG6+sONM5BMWYYWIzLIg8tuVG+4
 rFOojaUFbALMVgV4EEdzm/ap77ZZ99Q=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-BwLEUmJ8NkmlpVp8rTR3iw-1; Fri, 29 Sep 2023 00:15:21 -0400
X-MC-Unique: BwLEUmJ8NkmlpVp8rTR3iw-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-57b63eba015so24200844eaf.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 21:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695960921; x=1696565721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J20xDGLTbKuBA30clBAfcVaDmbadwIw635CoZGQ5C3o=;
 b=rLI9MgrwRAWK35/+QaazkBfH+UNvUr+JsLjRnfXy613jT4szp6eQqI0ffkj67pxckA
 Po1fkMu8/JWjR6v8PEJg8Cf7TcZfZ5biikOwulg2xO/zLSfZVVKQmRfEeom3Lxm5DowA
 tjN4vKTxxXCmzxG2vNBzvJCoM1+aGbvVNtZftgbe1dmDhnFWLWEjIl1IlxhwhOAqYuhF
 eP928PXhVwbByTW1ahrwnXvJP/rYg/oriIF2yA/GiBHypMrMJhBCJzHgrex0Lgvk3nOR
 u4D/iOddpeUx1Kf1O1/HvO5H2Aln+Ma48SZ0uRSQgdlAj6uJ3scUOTNyXyGfImSkPnCO
 Watw==
X-Gm-Message-State: AOJu0YyQ4ljl8wxC3963urkQ2+gUa4qKgZYsfhZ1H56LGSh2ho/Zvqd4
 wVEem8ywVvc1ski856tNIxKVhKK6S0cW6e6ILj15JPgWC+UbGyM9v7o2tsowavjVMERqDNgy82X
 pAuFX74FzrLee85o=
X-Received: by 2002:a05:6358:339f:b0:142:d1cb:48ab with SMTP id
 i31-20020a056358339f00b00142d1cb48abmr3595562rwd.15.1695960920690; 
 Thu, 28 Sep 2023 21:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKRug+GuO2257v0CbOtHTtArt+K7GZiCVT6Lx22DCZ2xF9Hj0OkNZngVQ2tG9n6IzRFRt5Jw==
X-Received: by 2002:a05:6358:339f:b0:142:d1cb:48ab with SMTP id
 i31-20020a056358339f00b00142d1cb48abmr3595535rwd.15.1695960920169; 
 Thu, 28 Sep 2023 21:15:20 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 x26-20020aa784da000000b0068c0fcb40d3sm14149478pfn.211.2023.09.28.21.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 21:15:19 -0700 (PDT)
Message-ID: <a3ae4b88-6066-4c21-5fe5-cfe74bc58aaa@redhat.com>
Date: Fri, 29 Sep 2023 14:15:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 34/37] target/arm/kvm,tcg: Register/Handle SMCCC
 hypercall exits to VMM/Qemu
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926103654.34424-1-salil.mehta@huawei.com>
 <20230926103654.34424-3-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926103654.34424-3-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Salil,

On 9/26/23 20:36, Salil Mehta wrote:
> From: Author Salil Mehta <salil.mehta@huawei.com>
> 
> Add registration and Handling of HVC/SMC hypercall exits to VMM
> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   target/arm/arm-powerctl.c   | 51 +++++++++++++++++++++++++++++-------
>   target/arm/helper.c         |  2 +-
>   target/arm/internals.h      | 11 --------
>   target/arm/kvm.c            | 52 +++++++++++++++++++++++++++++++++++++
>   target/arm/kvm64.c          | 46 +++++++++++++++++++++++++++++---
>   target/arm/kvm_arm.h        | 13 ++++++++++
>   target/arm/meson.build      |  1 +
>   target/arm/{tcg => }/psci.c |  8 ++++++
>   target/arm/tcg/meson.build  |  4 ---
>   9 files changed, 160 insertions(+), 28 deletions(-)
>   rename target/arm/{tcg => }/psci.c (97%)
> 
> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index 326a03153d..0184c7fb09 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -16,6 +16,7 @@
>   #include "qemu/log.h"
>   #include "qemu/main-loop.h"
>   #include "sysemu/tcg.h"
> +#include "hw/boards.h"
>   
>   #ifndef DEBUG_ARM_POWERCTL
>   #define DEBUG_ARM_POWERCTL 0
> @@ -28,18 +29,37 @@
>           } \
>       } while (0)
>   
> +static CPUArchId *arm_get_archid_by_id(uint64_t id)
> +{
> +    int n;
> +    CPUArchId *arch_id;
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +
> +    /*
> +     * At this point disabled CPUs don't have a CPUState, but their CPUArchId
> +     * exists.
> +     *
> +     * TODO: Is arch_id == mp_affinity? This needs work.
> +     */
> +    for (n = 0; n < ms->possible_cpus->len; n++) {
> +        arch_id = &ms->possible_cpus->cpus[n];
> +
> +        if (arch_id->arch_id == id) {
> +            return arch_id;
> +        }
> +    }
> +    return NULL;
> +}
> +

The @arch_id should be same thing to @mp_affinity except for the boot CPU.
For the boot CPU, its value is fetched from MPIDR, which is determined by
cs->cpu_index, passed to host via ioctl(CREATE_VCPU). Besides, another
similiar function qemu_get_cpu_archid() exists in cpus-common.c. I think
they can be combined. Again, all these information inherited from
ms->possible_cpus may be better to be managed in board level, like the
vCPU states.

>   CPUState *arm_get_cpu_by_id(uint64_t id)
>   {
> -    CPUState *cpu;
> +    CPUArchId *arch_id;
>   
>       DPRINTF("cpu %" PRId64 "\n", id);
>   
> -    CPU_FOREACH(cpu) {
> -        ARMCPU *armcpu = ARM_CPU(cpu);
> -
> -        if (armcpu->mp_affinity == id) {
> -            return cpu;
> -        }
> +    arch_id = arm_get_archid_by_id(id);
> +    if (arch_id && arch_id->cpu) {
> +        return CPU(arch_id->cpu);
>       }
>   
>       qemu_log_mask(LOG_GUEST_ERROR,
> @@ -148,6 +168,7 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
>   {
>       CPUState *target_cpu_state;
>       ARMCPU *target_cpu;
> +    CPUArchId *arch_id;
>       struct CpuOnInfo *info;
>   
>       assert(qemu_mutex_iothread_locked());
> @@ -168,12 +189,24 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
>       }
>   
>       /* Retrieve the cpu we are powering up */
> -    target_cpu_state = arm_get_cpu_by_id(cpuid);
> -    if (!target_cpu_state) {
> +    arch_id = arm_get_archid_by_id(cpuid);
> +    if (!arch_id) {
>           /* The cpu was not found */
>           return QEMU_ARM_POWERCTL_INVALID_PARAM;
>       }
>   
> +    target_cpu_state = CPU(arch_id->cpu);
> +    if (!qemu_enabled_cpu(target_cpu_state)) {
> +        /*
> +         * The cpu is not plugged in or disabled. We should return appropriate
> +         * value as introduced in DEN0022E PSCI 1.2 issue E
                                                        ^^^^^^^
                                                        issue E, which is QEMU_PSCI_RET_DENIED.
> +         */
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "[ARM]%s: Denying attempt to online removed/disabled "
> +                      "CPU%" PRId64"\n", __func__, cpuid);
> +        return QEMU_ARM_POWERCTL_IS_OFF;
> +    }
> +
>       target_cpu = ARM_CPU(target_cpu_state);
>       if (target_cpu->power_state == PSCI_ON) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 272d6ba139..4d396426f2 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11187,7 +11187,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>                         env->exception.syndrome);
>       }
>   
> -    if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
> +    if (arm_is_psci_call(cpu, cs->exception_index)) {
>           arm_handle_psci_call(cpu);
>           qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
>           return;

We may still limit the capability to handle PSCI calls to TCG and KVM,
meaning HVF and QTest won't have this capability.

> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index fe330e89e7..7ffefc2d58 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -305,21 +305,10 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len);
>   /* Callback function for when a watchpoint or breakpoint triggers. */
>   void arm_debug_excp_handler(CPUState *cs);
>   
> -#if defined(CONFIG_USER_ONLY) || !defined(CONFIG_TCG)
> -static inline bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
> -{
> -    return false;
> -}
> -static inline void arm_handle_psci_call(ARMCPU *cpu)
> -{
> -    g_assert_not_reached();
> -}
> -#else
>   /* Return true if the r0/x0 value indicates that this SMC/HVC is a PSCI call. */
>   bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
>   /* Actually handle a PSCI call */
>   void arm_handle_psci_call(ARMCPU *cpu);
> -#endif
>   
>   /**
>    * arm_clear_exclusive: clear the exclusive monitor
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 8e7c68af6a..6f3fd5aecd 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -250,6 +250,7 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
>       int ret = 0;
> +
   ^^^^
Unnecessary change.

>       /* For ARM interrupt delivery is always asynchronous,
>        * whether we are using an in-kernel VGIC or not.
>        */
> @@ -280,6 +281,22 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           }
>       }
>   
> +    /*
> +     * To be able to handle PSCI CPU ON calls in QEMU, we need to install SMCCC
                                         ^^
                                         ON/OFF
> +     * filter in the Host KVM. This is required to support features like
> +     * virtual CPU Hotplug on ARM platforms.
> +     */
> +    if (kvm_arm_set_smccc_filter(PSCI_0_2_FN64_CPU_ON,
> +                                 KVM_SMCCC_FILTER_FWD_TO_USER)) {
> +        error_report("CPU On PSCI-to-user-space fwd filter install failed");
> +        abort();
> +    }
> +    if (kvm_arm_set_smccc_filter(PSCI_0_2_FN_CPU_OFF,
> +                                 KVM_SMCCC_FILTER_FWD_TO_USER)) {
> +        error_report("CPU Off PSCI-to-user-space fwd filter install failed");
> +        abort();
> +    }
> +
>       kvm_arm_init_debug(s);
>   
>       return ret;

The PSCI_ON and PSCI_OFF will be unconditionally handled by QEMU if KVM is
enabled, even vCPU hotplug isn't supported on hw/arm/virt board. Do we need to
enable it only when vCPU hotplug is supported?

> @@ -952,6 +969,38 @@ static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
>       return -1;
>   }
>   
> +static int kvm_arm_handle_hypercall(CPUState *cs, struct kvm_run *run)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    kvm_cpu_synchronize_state(cs);
> +
> +    /*
> +     * hard coding immediate to 0 as we dont expect non-zero value as of now
                                            ^^^^
                                            don't
> +     * This might change in future versions. Hence, KVM_GET_ONE_REG  could be
> +     * used in such cases but it must be enhanced then only synchronize will
> +     * also fetch ESR_EL2 value.
> +     */
> +    if (run->hypercall.flags == KVM_HYPERCALL_EXIT_SMC) {
> +        cs->exception_index = EXCP_SMC;
> +        env->exception.syndrome = syn_aa64_smc(0);
> +    } else {
> +        cs->exception_index = EXCP_HVC;
> +        env->exception.syndrome = syn_aa64_hvc(0);
> +    }
> +    env->exception.target_el = 1;
> +    qemu_mutex_lock_iothread();
> +    arm_cpu_do_interrupt(cs);
> +    qemu_mutex_unlock_iothread();
> +
> +    /*
> +     * For PSCI, exit the kvm_run loop and process the work. Especially
> +     * important if this was a CPU_OFF command and we can't return to the guest.
> +     */
> +    return EXCP_INTERRUPT;
> +}
> +
>   int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>   {
>       int ret = 0;
> @@ -967,6 +1016,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>           ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
>                                          run->arm_nisv.fault_ipa);
>           break;
> +    case KVM_EXIT_HYPERCALL:
> +          ret = kvm_arm_handle_hypercall(cs, run);
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
>                         __func__, run->exit_reason);
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 38de0b4148..efe24e3f90 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -113,6 +113,25 @@ bool kvm_arm_hw_debug_active(CPUState *cs)
>       return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
>   }
>   
> +static bool kvm_arm_set_vm_attr(struct kvm_device_attr *attr, const char *name)
> +{
> +    int err;
> +
> +    err = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, attr);
> +    if (err != 0) {
> +        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
> +        return false;
> +    }
> +
> +    err = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, attr);
> +    if (err != 0) {
> +        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
>                                       const char *name)
>   {
> @@ -183,6 +202,28 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
>       }
>   }
>   
> +int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction)
> +{
> +    struct kvm_smccc_filter filter = {
> +        .base = func,
> +        .nr_functions = 1,
> +        .action = faction,
> +    };
> +    struct kvm_device_attr attr = {
> +        .group = KVM_ARM_VM_SMCCC_CTRL,
> +        .attr = KVM_ARM_VM_SMCCC_FILTER,
> +        .flags = 0,
> +        .addr = (uintptr_t)&filter,
> +    };
> +
> +    if (!kvm_arm_set_vm_attr(&attr, "SMCCC Filter")) {
> +        error_report("failed to set SMCCC filter in KVM Host");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>   static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
>   {
>       uint64_t ret;
> @@ -633,9 +674,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>       }
>   
>       /*
> -     * When KVM is in use, PSCI is emulated in-kernel and not by qemu.
> -     * Currently KVM has its own idea about MPIDR assignment, so we
> -     * override our defaults with what we get from KVM.
> +     * KVM may emulate PSCI in-kernel. Currently KVM has its own idea about
> +     * MPIDR assignment, so we override our defaults with what we get from KVM.
>        */
>       ret = kvm_get_one_reg(cs, ARM64_SYS_REG(ARM_CPU_ID_MPIDR), &mpidr);
>       if (ret) {
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 31408499b3..bf4df54c96 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -388,6 +388,15 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa);
>   
>   int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
>   
> +/**
> + * kvm_arm_set_smccc_filter
> + * @func: funcion
> + * @faction: SMCCC filter action(handle, deny, fwd-to-user) to be deployed
> + *
> + * Sets the ARMs SMC-CC filter in KVM Host for selective hypercall exits
> + */
> +int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction);
> +
>   #else
>   
>   /*
> @@ -462,6 +471,10 @@ static inline uint32_t kvm_arm_sve_get_vls(CPUState *cs)
>       g_assert_not_reached();
>   }
>   
> +static inline int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction)
> +{
> +    g_assert_not_reached();
> +}
>   #endif
>   
>   /**
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index e645e456da..fdfc8b958f 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -23,6 +23,7 @@ arm_system_ss.add(files(
>     'arm-qmp-cmds.c',
>     'cortex-regs.c',
>     'machine.c',
> +  'psci.c',
>     'ptw.c',
>   ))
>   
> diff --git a/target/arm/tcg/psci.c b/target/arm/psci.c
> similarity index 97%
> rename from target/arm/tcg/psci.c
> rename to target/arm/psci.c
> index 6c1239bb96..a8690a16af 100644
> --- a/target/arm/tcg/psci.c
> +++ b/target/arm/psci.c
> @@ -21,7 +21,9 @@
>   #include "exec/helper-proto.h"
>   #include "kvm-consts.h"
>   #include "qemu/main-loop.h"
> +#include "qemu/error-report.h"
>   #include "sysemu/runstate.h"
> +#include "sysemu/tcg.h"
>   #include "internals.h"
>   #include "arm-powerctl.h"
>   
> @@ -157,6 +159,11 @@ void arm_handle_psci_call(ARMCPU *cpu)
>       case QEMU_PSCI_0_1_FN_CPU_SUSPEND:
>       case QEMU_PSCI_0_2_FN_CPU_SUSPEND:
>       case QEMU_PSCI_0_2_FN64_CPU_SUSPEND:
> +       if (!tcg_enabled()) {
> +            warn_report("CPU suspend not supported in non-tcg mode");
> +            break;
> +       }
> +#ifdef CONFIG_TCG
>           /* Affinity levels are not supported in QEMU */
>           if (param[1] & 0xfffe0000) {
>               ret = QEMU_PSCI_RET_INVALID_PARAMS;
> @@ -169,6 +176,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
>               env->regs[0] = 0;
>           }
>           helper_wfi(env, 4);
> +#endif
>           break;
>       case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
>           switch (param[1]) {
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 6fca38f2cc..ad3cfcb3bd 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -51,7 +51,3 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>     'sme_helper.c',
>     'sve_helper.c',
>   ))
> -
> -arm_system_ss.add(files(
> -  'psci.c',
> -))

Thanks,
Gavin


