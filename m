Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9064FABF8D9
	for <lists+qemu-devel@lfdr.de>; Wed, 21 May 2025 17:08:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHl2u-0003Eb-Qg; Wed, 21 May 2025 11:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHl2h-0003Cc-6q
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:07:39 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHl2X-0001Cr-K8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:07:37 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-742c9563fafso3448002b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747840047; x=1748444847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=abKu3Ha89ViUWNzcVNDRbEhornlsBl77nd4s99Xbpf8=;
 b=CP7xcrcecTr0FjL29/nMQnsg2TmI9KpgF4LAuOEcaRKb23nclo5GOx2cY5i/eruNf4
 udJe9o0kDni2lf+bZzEIq1ZQO0GtCduOjPSvSCPOkQ/gYRBXx2+TukPluk8uzakz8d1O
 Hxdx5Vhi9mV4q1AQjUvxUYTJbxi4zOlZY9Gz7yohP5HsgnaFMzS6SJsJSeGYLqTrQ2uz
 IGYuHBNCaXDjtwWuVEW0rKIKEU0ehiL6hoZgMZXkBY4Ouzl2owwF+yQ4yKuEMUYw5Bba
 BThCnufXutBOzsLbKkBYM07Op/vW81sofUXBdS9MtmqsjJhYgdN8elTkth7cvZawtI2/
 ZU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747840047; x=1748444847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=abKu3Ha89ViUWNzcVNDRbEhornlsBl77nd4s99Xbpf8=;
 b=kPKmwhmGc1jRSmdyDBkT1SIdIsXDfPcxKxB214SlnPiChtfXVsu6IXW8aFQSdeOfec
 KyKlJvYQ4fObZFK3gv5mtS5QSkhVwxPyRU06umDD0DBr9m8vnYC9HkSmEqyBNi8yvHaa
 xZybVYebzjaNC1ZCluu4mllqXD59XeXIZ5WoINgriy50ae51Zv/dToOt8Rze+erh4ycP
 0pbWTp65PPun/4Yv8z54M+68suls7bTaQVf8ucOO1TzX4KYauUdQNOd7t3KSdOFUrUsW
 mygpcFGNtT/PvYhedBLQBDzZAJh0HM23B9KkBF9zUFxzz8dp8r5vdx5npaolWDcYNZl1
 xekA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/jgsy/gtFBe6biwW121aVBbDF4Kohpz7YbfzW15+hOPqSenfFkWPjB1QR/Mb1dR7R/DQGHSmNUq6p@nongnu.org
X-Gm-Message-State: AOJu0Yy4+fhxuQh18RbOCHcz+egCPVlZBG7Tx5WKjwZ465PquR3aR4Sd
 Hszf1DaBHRGQ7X+4XFM89npxoshS1ML0u+HG1yNd4dmP/Qtuh6D439bPhhwJsHV1r3c=
X-Gm-Gg: ASbGncu/yiC0fiplF3L9T+Wlz/CYdlShUVx9sMGfGRN3m1i9GHHQkPNCCtbD2VhsLl6
 vgfl3UulX4ck8wJkA8mDpzfNTx1WKjuNSZ7zAsAOPli2a7ZGmidFFL3KF1izRmoJ9pfSEDwNBJn
 LMffp3skE0dH8EXz0aeqAyUyrKG5THr9IHqcyeyDMpbUWmRDntjDCW5MOAsFf3Rt7xFyfI4LTwB
 76FryXxtLX1aJb21RGNQBhw2kblZ3rNgOrV2UzGVV7pdHnHE4rSkbQiRPkJExN0Xttm+yhqGbbN
 RRgFmyUikI31oh2/pamQCnJhFfJG56T91heP/GwnPmUpydwaUCovv+Cui4jQK9cGiTGpe46du24
 tqSB7nNfZEZt4tehymBZlAwpKQDcuvmNvhcnpkBrr
X-Google-Smtp-Source: AGHT+IH4Ap6IZrJoLy3CZM8B/d6SoWPsV7zwigfUnHEF8LOGWxUVxjm5BasU0E7kpRJ8xYsmVxcKRg==
X-Received: by 2002:a05:6a00:4b10:b0:736:3c6a:be02 with SMTP id
 d2e1a72fcca58-742a97eb61emr27801327b3a.11.1747840044183; 
 Wed, 21 May 2025 08:07:24 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:532e:8fb1:3c49:40da?
 ([2804:7f0:b401:d47f:532e:8fb1:3c49:40da])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a970b7b0sm10021132b3a.51.2025.05.21.08.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 08:07:23 -0700 (PDT)
Message-ID: <429a8131-2b59-4800-891b-bcfbc6e44737@linaro.org>
Date: Wed, 21 May 2025 12:06:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V5 00/30] Support of Virtual CPU Hotplug for ARMv8 Arch
To: Gavin Shan <gshan@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Eric Auger <eauger@redhat.com>
Cc: maz@kernel.org, jean-philippe@linaro.org, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 peterx@redhat.com, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, linuxarm@huawei.com
References: <20241015100012.254223-1-salil.mehta@huawei.com>
 <b65590b1-8a6f-43e5-b367-732d6305c095@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <b65590b1-8a6f-43e5-b367-732d6305c095@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_DOTEDU=0.001 autolearn=ham autolearn_force=no
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

Hi Salil, Gavin, and folks,

On 5/20/25 21:22, Gavin Shan wrote:
> Hi Salil,
> 
> A kindly ping. vCPU hotplug is an important feature and You has put so much
> energies and amazing efforts to enable the feature from QEMU side, but it
> seems it has been stuck recently. I received many messages from Redhat
> internal and external to ask if vCPU hotplug has been supported on aarch64
> in the past. So I'm heading up to check if you have bandwidth to continue
> the effort, any kinds of helps are needed, especially from me.

You can count on me as well, Salil. I'm definitely in a better position now
to help you with the technical review of the series, and I can also weigh in
to help resolve any remaining issues so we can finally get it merged. Don't give up! :)

My suggestion: go ahead and post what you have now. Just highlight the main
points of objection raised in the last review that still need to be addressed.


> Besides, I'm reluctantly to ask if you're fine for some body else to pick this
> up and continue the effort. The credits for all the contributors (Keqian Zhu,
> Jean Philippe, Miguel Luis and you) will be kept.

I don’t want to speak for others, but in my view, Salil should ideally be the
one to complete this work — as you said, he’s already invested a great deal of
time and energy into it.

It would be tremendously helpful if maintainers could support Salil in bringing
this to completion, kindly guiding him toward the path to get it finalized.


Cheers,
Gustavo

> Salil, looking forward to hearing from you :-)
> 
> Thanks,
> Gavin
> 
> On 10/15/24 7:59 PM, Salil Mehta wrote:
>> PROLOGUE
>> ========
>>
>> To assist in review and set the right expectations from this RFC, please first
>> read the sections *APPENDED AT THE END* of this cover letter:
>>
>> 1. Important *DISCLAIMER* [Section (X)]
>> 2. Work presented at KVMForum Conference (slides available) [Section (V)F]
>> 3. Organization of patches [Section (XI)]
>> 4. References [Section (XII)]
>> 5. Detailed TODO list of leftover work or work-in-progress [Section (IX)]
>> 6. Repositories [Section (VII)]
>>
>> The architecture-agnostic patch set was merged into the mainline during the
>> last Qemu cycle. This patch is specific to the ARM architecture and is
>> compatible with the latest Qemu mainline version.
>>
>> SECTIONS [I - XIII] are as follows:
>>
>> (I) Summary of `Recent` Key Changes [details in last section (XIV)]
>> ===================================================================
>>
>> RFC V4 -> RFC V5
>>
>> 1. Dropped patches [PATCH RFC V4 {2,12,19}/33]
>> 2. Separated architecture agnostic ACPI/migration changes in separate patch-set.
>>     Link: https://lore.kernel.org/qemu-devel/20241014192205.253479-1-salil.mehta@huawei.com/#t
>> 3. Dropped qemu{present,enabled}_cpu() APIs.
>> 4. Dropped the `CPUState::disabled` flag
>>
>> RFC V3 -> RFC V4
>>
>> 1. Fixes for TCG. It has been lightly tested but seem to work!
>> 2. Migration related fixes [Both KVM & TCG].
>> 3. Introduction of `gicc_accessble` flag for GICv3 CPU interface
>> 4. Addressed comments from Gavin Shan (RedHat), Nicholas Piggin (IBM),
>>     Alex Bennée's & Gustavo Romero (Linaro)
>> 5. Misc fixes and refatoring.
>>
>>
>> (II) Summary
>> ============
>>
>> This patch set introduces virtual CPU hotplug support for the ARMv8 architecture
>> in QEMU. The idea is to be able to hotplug and hot-unplug vCPUs while the guest
>> VM is running, without requiring a reboot. This does *not* make any assumptions
>> about the physical CPU hotplug availability within the host system but rather
>> tries to solve the problem at the virtualizer/QEMU layer. It introduces ACPI CPU
>> hotplug hooks and event handling to interface with the guest kernel, and code to
>> initialize, plug, and unplug CPUs. No changes are required within the host
>> kernel/KVM except the support of hypercall exit handling in the user-space/Qemu,
>> which has recently been added to the kernel. Corresponding guest kernel changes
>> were posted on the mailing list [3] [4] by James Morse (ARM) and have been
>> recently accepted and are now part of v6.11 mainline kernel.
>>
>> (III) Motivation
>> ================
>>
>> This allows scaling the guest VM compute capacity on-demand, which would be
>> useful for the following example scenarios:
>>
>> 1. Vertical Pod Autoscaling [9][10] in the cloud: Part of the orchestration
>>     framework that could adjust resource requests (CPU and Mem requests) for
>>     the containers in a pod, based on usage.
>> 2. Pay-as-you-grow Business Model: Infrastructure providers could allocate and
>>     restrict the total number of compute resources available to the guest VM
>>     according to the SLA (Service Level Agreement). VM owners could request more
>>     compute to be hot-plugged for some cost.
>>
>> For example, Kata Container VM starts with a minimum amount of resources (i.e.,
>> hotplug everything approach). Why?
>>
>> 1. Allowing faster *boot time* and
>> 2. Reduction in *memory footprint*
>>
>> Kata Container VM can boot with just 1 vCPU, and then later more vCPUs can be
>> hot-plugged as needed. Reducing the number of vCPUs in VM can in general
>> reduce the boot times of the VM esepcially when number of cores are increasing.
>>
>> **[UPCOMING]**
>> I've been working on enhancing the boot times of ARM/VMs using the hotplug
>> infrastructure proposed in this patch set. Stay tuned for upcoming patches that
>> leverage this infrastructure to significantly reduce boot times for
>> *non-hotplug* scenarios. Expect these updates in the next few weeks!
>>
>> (IV) Terminology
>> ================
>>
>> (*) Possible CPUs: Total vCPUs that could ever exist in the VM. This includes
>>                     any cold-booted CPUs plus any CPUs that could be later
>>                     hot-plugged.
>>                     - Qemu parameter (-smp maxcpus=N)
>> (*) Present CPUs:  Possible CPUs that are ACPI 'present'. These might or might
>>                     not be ACPI 'enabled'.
>>                     - Present vCPUs = Possible vCPUs (Always on ARM Arch)
>> (*) Enabled CPUs:  Possible CPUs that are ACPI 'present' and 'enabled' and can
>>                     now be ‘onlined’ (PSCI) for use by the Guest Kernel. All cold-
>>                     booted vCPUs are ACPI 'enabled' at boot. Later, using
>>                     device_add, more vCPUs can be hotplugged and made ACPI
>>                     'enabled'.
>>                     - Qemu parameter (-smp cpus=N). Can be used to specify some
>>            cold-booted vCPUs during VM init. Some can be added using the
>>            '-device' option.
>>
>> (V) Constraints Due to ARMv8 CPU Architecture [+] Other Impediments
>> ===================================================================
>>
>> A. Physical Limitation to Support CPU Hotplug: (Architectural Constraint)
>>     1. ARMv8 CPU architecture does not support the concept of the physical CPU
>>        hotplug.
>>        a. There are many per-CPU components like PMU, SVE, MTE, Arch timers, etc.,
>>           whose behavior needs to be clearly defined when the CPU is
>>      hot(un)plugged. There is no specification for this.
>>
>>     2. Other ARM components like GIC, etc., have not been designed to realize
>>        physical CPU hotplug capability as of now. For example,
>>        a. Every physical CPU has a unique GICC (GIC CPU Interface) by construct.
>>           Architecture does not specify what CPU hot(un)plug would mean in
>>           context to any of these.
>>        b. CPUs/GICC are physically connected to unique GICR (GIC Redistributor).
>>           GIC Redistributors are always part of the always-on power domain. Hence,
>>           they cannot be powered off as per specification.
>>
>> B. Impediments in Firmware/ACPI (Architectural Constraint)
>>
>>     1. Firmware has to expose GICC, GICR, and other per-CPU features like PMU,
>>        SVE, MTE, Arch Timers, etc., to the OS. Due to the architectural constraint
>>        stated in section A1(a), all interrupt controller structures of
>>        MADT describing GIC CPU Interfaces and the GIC Redistributors MUST be
>>        presented by firmware to the OSPM during boot time.
>>     2. Architectures that support CPU hotplug can evaluate the ACPI _MAT method to
>>        get this kind of information from the firmware even after boot, and the
>>        OSPM has the capability to process these. ARM kernel uses information in MADT
>>        interrupt controller structures to identify the number of present CPUs during
>>        boot and hence does not allow to change these after boot. The number of
>>        present CPUs cannot be changed. It is an architectural constraint!
>>
>> C. Impediments in KVM to Support Virtual CPU Hotplug (Architectural Constraint)
>>
>>     1. KVM VGIC:
>>        a. Sizing of various VGIC resources like memory regions, etc., related to
>>           the redistributor happens only once and is fixed at the VM init time
>>           and cannot be changed later after initialization has happened.
>>           KVM statically configures these resources based on the number of vCPUs
>>           and the number/size of redistributor ranges.
>>        b. Association between vCPU and its VGIC redistributor is fixed at the
>>           VM init time within the KVM, i.e., when redistributor iodevs gets
>>           registered. VGIC does not allow to setup/change this association
>>           after VM initialization has happened. Physically, every CPU/GICC is
>>           uniquely connected with its redistributor, and there is no
>>           architectural way to set this up.
>>     2. KVM vCPUs:
>>        a. Lack of specification means destruction of KVM vCPUs does not exist as
>>           there is no reference to tell what to do with other per-vCPU
>>           components like redistributors, arch timer, etc.
>>        b. In fact, KVM does not implement the destruction of vCPUs for any
>>           architecture. This is independent of whether the architecture
>>           actually supports CPU Hotplug feature. For example, even for x86 KVM
>>           does not implement the destruction of vCPUs.
>>
>> D. Impediments in Qemu to Support Virtual CPU Hotplug (KVM Constraints->Arch)
>>
>>     1. Qemu CPU Objects MUST be created to initialize all the Host KVM vCPUs to
>>        overcome the KVM constraint. KVM vCPUs are created and initialized when Qemu
>>        CPU Objects are realized. But keeping the QOM CPU objects realized for
>>        'yet-to-be-plugged' vCPUs can create problems when these new vCPUs shall
>>        be plugged using device_add and a new QOM CPU object shall be created.
>>     2. GICV3State and GICV3CPUState objects MUST be sized over *possible vCPUs*
>>        during VM init time while QOM GICV3 Object is realized. This is because
>>        KVM VGIC can only be initialized once during init time. But every
>>        GICV3CPUState has an associated QOM CPU Object. Later might correspond to
>>        vCPU which are 'yet-to-be-plugged' (unplugged at init).
>>     3. How should new QOM CPU objects be connected back to the GICV3CPUState
>>        objects and disconnected from it in case the CPU is being hot(un)plugged?
>>     4. How should 'unplugged' or 'yet-to-be-plugged' vCPUs be represented in the
>>        QOM for which KVM vCPU already exists? For example, whether to keep,
>>         a. No QOM CPU objects Or
>>         b. Unrealized CPU Objects
>>     5. How should vCPU state be exposed via ACPI to the Guest? Especially for
>>        the unplugged/yet-to-be-plugged vCPUs whose CPU objects might not exist
>>        within the QOM but the Guest always expects all possible vCPUs to be
>>        identified as ACPI *present* during boot.
>>     6. How should Qemu expose GIC CPU interfaces for the unplugged or
>>        yet-to-be-plugged vCPUs using ACPI MADT Table to the Guest?
>>
>> E. Summary of Approach ([+] Workarounds to problems in sections A, B, C & D)
>>
>>     1. At VM Init, pre-create all the possible vCPUs in the Host KVM i.e., even
>>        for the vCPUs which are yet-to-be-plugged in Qemu but keep them in the
>>        powered-off state.
>>     2. After the KVM vCPUs have been initialized in the Host, the KVM vCPU
>>        objects corresponding to the unplugged/yet-to-be-plugged vCPUs are parked
>>        at the existing per-VM "kvm_parked_vcpus" list in Qemu. (similar to x86)
>>     3. GICV3State and GICV3CPUState objects are sized over possible vCPUs during
>>        VM init time i.e., when Qemu GIC is realized. This, in turn, sizes KVM VGIC
>>        resources like memory regions, etc., related to the redistributors with the
>>        number of possible KVM vCPUs. This never changes after VM has initialized.
>>     4. Qemu CPU objects corresponding to unplugged/yet-to-be-plugged vCPUs are
>>        released post Host KVM CPU and GIC/VGIC initialization.
>>     5. Build ACPI MADT Table with the following updates:
>>        a. Number of GIC CPU interface entries (=possible vCPUs)
>>        b. Present Boot vCPU as MADT.GICC.Enabled=1 (Not hot[un]pluggable)
>>        c. Present hot(un)pluggable vCPUs as MADT.GICC.online-capable=1
>>           - MADT.GICC.Enabled=0 (Mutually exclusive) [6][7]
>>      - vCPU can be ACPI enabled+onlined after Guest boots (Firmware Policy)
>>      - Some issues with above (details in later sections)
>>     6. Expose below ACPI Status to Guest kernel:
>>        a. Always _STA.Present=1 (all possible vCPUs)
>>        b. _STA.Enabled=1 (plugged vCPUs)
>>        c. _STA.Enabled=0 (unplugged vCPUs)
>>     7. vCPU hotplug *realizes* new QOM CPU object. The following happens:
>>        a. Realizes, initializes QOM CPU Object & spawns Qemu vCPU thread.
>>        b. Unparks the existing KVM vCPU ("kvm_parked_vcpus" list).
>>           - Attaches to QOM CPU object.
>>        c. Reinitializes KVM vCPU in the Host.
>>           - Resets the core and sys regs, sets defaults, etc.
>>        d. Runs KVM vCPU (created with "start-powered-off").
>>      - vCPU thread sleeps (waits for vCPU reset via PSCI).
>>        e. Updates Qemu GIC.
>>           - Wires back IRQs related to this vCPU.
>>           - GICV3CPUState association with QOM CPU Object.
>>        f. Updates [6] ACPI _STA.Enabled=1.
>>        g. Notifies Guest about the new vCPU (via ACPI GED interface).
>>      - Guest checks _STA.Enabled=1.
>>      - Guest adds processor (registers CPU with LDM) [3].
>>        h. Plugs the QOM CPU object in the slot.
>>           - slot-number = cpu-index {socket, cluster, core, thread}.
>>        i. Guest online's vCPU (CPU_ON PSCI call over HVC/SMC).
>>           - KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
>>           - Qemu powers-on KVM vCPU in the Host.
>>     8. vCPU hot-unplug *unrealizes* QOM CPU Object. The following happens:
>>        a. Notifies Guest (via ACPI GED interface) vCPU hot-unplug event.
>>           - Guest offline's vCPU (CPU_OFF PSCI call over HVC/SMC).
>>        b. KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
>>           - Qemu powers-off the KVM vCPU in the Host.
>>        c. Guest signals *Eject* vCPU to Qemu.
>>        d. Qemu updates [6] ACPI _STA.Enabled=0.
>>        e. Updates GIC.
>>           - Un-wires IRQs related to this vCPU.
>>           - GICV3CPUState association with new QOM CPU Object is updated.
>>        f. Unplugs the vCPU.
>>      - Removes from slot.
>>           - Parks KVM vCPU ("kvm_parked_vcpus" list).
>>           - Unrealizes QOM CPU Object & joins back Qemu vCPU thread.
>>      - Destroys QOM CPU object.
>>        g. Guest checks ACPI _STA.Enabled=0.
>>           - Removes processor (unregisters CPU with LDM) [3].
>>
>> F. Work Presented at KVM Forum Conferences:
>> ==========================================
>>
>> Details of the above work have been presented at KVMForum2020 and KVMForum2023
>> conferences. Slides & video are available at the links below:
>> a. KVMForum 2023
>>     - Challenges Revisited in Supporting Virt CPU Hotplug on architectures that don't Support CPU Hotplug (like ARM64).
>>       https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
>>       https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
>>       https://www.youtube.com/watch?v=hyrw4j2D6I0&t=23970s
>>       https://kvm-forum.qemu.org/2023/talk/9SMPDQ/
>> b. KVMForum 2020
>>     - Challenges in Supporting Virtual CPU Hotplug on SoC Based Systems (like ARM64) - Salil Mehta, Huawei.
>>       https://kvmforum2020.sched.com/event/eE4m
>>
>> (VI) Commands Used
>> ==================
>>
>> A. Qemu launch commands to init the machine:
>>
>> $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3 \
>> -cpu host -smp cpus=4,maxcpus=6 \
>> -m 300M \
>> -kernel Image \
>> -initrd rootfs.cpio.gz \
>> -append "console=ttyAMA0 root=/dev/ram rdinit=/init maxcpus=2 acpi=force" \
>> -nographic \
>> -bios QEMU_EFI.fd \
>>
>> B. Hot-(un)plug related commands:
>>
>> # Hotplug a host vCPU (accel=kvm):
>> $ device_add host-arm-cpu,id=core4,core-id=4
>>
>> # Hotplug a vCPU (accel=tcg):
>> $ device_add cortex-a57-arm-cpu,id=core4,core-id=4
>>
>> # Delete the vCPU:
>> $ device_del core4
>>
>> Sample output on guest after boot:
>>
>>      $ cat /sys/devices/system/cpu/possible
>>      0-5
>>      $ cat /sys/devices/system/cpu/present
>>      0-5
>>      $ cat /sys/devices/system/cpu/enabled
>>      0-3
>>      $ cat /sys/devices/system/cpu/online
>>      0-1
>>      $ cat /sys/devices/system/cpu/offline
>>      2-
>>
>> Sample output on guest after hotplug of vCPU=4:
>>
>>      $ cat /sys/devices/system/cpu/possible
>>      0-5
>>      $ cat /sys/devices/system/cpu/present
>>      0-5
>>      $ cat /sys/devices/system/cpu/enabled
>>      0-4
>>      $ cat /sys/devices/system/cpu/online
>>      0-1,4
>>      $ cat /sys/devices/system/cpu/offline
>>      2-3,5
>>
>>      Note: vCPU=4 was explicitly 'onlined' after hot-plug
>>      $ echo 1 > /sys/devices/system/cpu/cpu4/online
>>
>> (VII) Latest Repository
>> =======================
>>
>> (*) Latest Qemu RFC V5 (Architecture Specific) patch set:
>>      https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v5
>> (*) Latest Architecture Agnostic ACPI changes patch-set:
>>      https://lore.kernel.org/qemu-devel/20241014192205.253479-1-salil.mehta@huawei.com/#t
>> (*) Older QEMU changes for vCPU hotplug can be cloned from below site:
>>      https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-{v1,v2,v3,v4}
>> (*) `Accepted` Qemu Architecture Agnostic patch is present here:
>>      https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v3.arch.agnostic.v16/
>> (*) All Kernel changes are already part of mainline v6.11
>> (*) Original Guest Kernel changes (by James Morse, ARM) are available here:
>>      https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git virtual_cpu_hotplug/rfc/v2
>>
>>
>> (VIII) KNOWN ISSUES
>> ===================
>>
>> 1. HVF and qtest are not supported yet.
>> 2. ACPI MADT Table flags [7] MADT.GICC.Enabled and MADT.GICC.online-capable are
>>     mutually exclusive, i.e., as per the change [6], a vCPU cannot be both
>>     GICC.Enabled and GICC.online-capable. This means:
>>        [ Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3706 ]
>>     a. If we have to support hot-unplug of the cold-booted vCPUs, then these MUST
>>        be specified as GICC.online-capable in the MADT Table during boot by the
>>        firmware/Qemu. But this requirement conflicts with the requirement to
>>        support new Qemu changes with legacy OS that don't understand
>>        MADT.GICC.online-capable Bit. Legacy OS during boot time will ignore this
>>        bit, and hence these vCPUs will not appear on such OS. This is unexpected
>>        behavior.
>>     b. In case we decide to specify vCPUs as MADT.GICC.Enabled and try to unplug
>>        these cold-booted vCPUs from OS (which in actuality should be blocked by
>>        returning error at Qemu), then features like 'kexec' will break.
>>     c. As I understand, removal of the cold-booted vCPUs is a required feature
>>        and x86 world allows it.
>>     d. Hence, either we need a specification change to make the MADT.GICC.Enabled
>>        and MADT.GICC.online-capable Bits NOT mutually exclusive or NOT support
>>        the removal of cold-booted vCPUs. In the latter case, a check can be introduced
>>        to bar the users from unplugging vCPUs, which were cold-booted, using QMP
>>        commands. (Needs discussion!)
>>        Please check the patch part of this patch set:
>>        [hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled].
>>        NOTE: This is definitely not a blocker!
>>
>>
>> (IX) THINGS TO DO
>> =================
>>
>> 1. TCG is now in working state but would need extensive testing to roll out
>>     any corner cases. Any help related to this will be appreciated!
>> 2. Comprehensive Testing is in progress. (Positive feedback from Oracle & Ampere)
>> 3. Qemu Documentation (.rst) needs to be updated.
>> 4. The `is_enabled` and `is_present` ACPI states are now common to all architectures
>>     and should work seemlessely but needs thorough testing with other architectures.
>> 5. Migration has been lightly tested but has been found working.
>> 6. A missing check for PMU state for the hotplugged vCPUs (Reported by: Gavin Shan)
>>     https://lore.kernel.org/qemu-devel/28f3107f-0267-4112-b0ca-da59df2968ae@redhat.com/
>> 7. Need help in Testing with ARM hardware extensions like SVE/SME
>>
>>
>>
>> Best regards,
>> Salil.
>>
>> (X) DISCLAIMER
>> ==============
>>
>> This work is an attempt to present a proof-of-concept of the ARM64 vCPU hotplug
>> implementation to the community. This is *not* production-level code and might
>> have bugs. Comprehensive testing is being done on HiSilicon Kunpeng920 SoC,
>> Oracle, and Ampere servers. We are nearing stable code and a non-RFC
>> version shall be floated soon.
>>
>> This work is *mostly* in the lines of the discussions that have happened in the
>> previous years [see refs below] across different channels like the mailing list,
>> Linaro Open Discussions platform, and various conferences like KVMForum, etc. This
>> RFC is being used as a way to verify the idea mentioned in this cover letter and
>> to get community views. Once this has been agreed upon, a formal patch shall be
>> posted to the mailing list for review.
>>
>> [The concept being presented has been found to work!]
>>
>> (XI) ORGANIZATION OF PATCHES
>> ============================
>> A. ARM Architecture *specific* patches:
>>
>>     [Patch 1-8, 11, 12, 30] logic required during machine init.
>>      (*) Some validation checks.
>>      (*) Introduces core-id property and some util functions required later.
>>      (*) Logic to pre-create vCPUs.
>>      (*) Introduction of the GICv3 CPU Interface `accessibility` interface
>>      (*) GIC initialization pre-sized with possible vCPUs.
>>      (*) Some refactoring to have common hot and cold plug logic together.
>>      (*) Release of disabled QOM CPU objects in post_cpu_init().
>>     [Patch 9-10, 13-15] logic related to ACPI at machine init time.
>>      (*) Changes required to Enable ACPI for CPU hotplug.
>>      (*) Initialization of ACPI GED framework to cater to CPU Hotplug Events.
>>      (*) ACPI DSDT, MADT/MAT changes.
>>     [Patch 17-29] logic required during vCPU hot-(un)plug.
>>      (*) Basic framework changes to support vCPU hot-(un)plug.
>>      (*) ACPI GED changes for hot-(un)plug hooks.
>>      (*) Wire-unwire the IRQs.
>>      (*) GIC notification logic on receiving vCPU hot(un)plug event.
>>      (*) ARMCPU unrealize logic.
>>      (*) Handling of SMCC Hypercall Exits by KVM to Qemu.
>>     [Patch 33] Disable unplug of cold-booted vCPUs
>>
>> (XII) REFERENCES
>> ================
>>
>> [1] https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@huawei.com/
>> [2] https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1-salil.mehta@huawei.com/
>> [3] https://lore.kernel.org/lkml/20230203135043.409192-1-james.morse@arm.com/
>> [4] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
>> [5] https://lore.kernel.org/all/20230404154050.2270077-1-oliver.upton@linux.dev/
>> [6] https://bugzilla.tianocore.org/show_bug.cgi?id=3706
>> [7] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic-cpu-interface-gicc-structure
>> [8] https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
>> [9] https://cloud.google.com/kubernetes-engine/docs/concepts/verticalpodautoscaler
>> [10] https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod-autoscaler.html
>> [11] https://lkml.org/lkml/2019/7/10/235
>> [12] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html
>> [13] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.html
>> [14] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/
>> [15] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01168.html
>> [16] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html
>> [17] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/
>> [18] https://lore.kernel.org/lkml/20210608154805.216869-1-jean-philippe@linaro.org/
>> [19] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
>> [20] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gicc-cpu-interface-flags
>> [21] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/
>> [22] https://lore.kernel.org/qemu-devel/20240607115649.214622-1-salil.mehta@huawei.com/T/#md0887eb07976bc76606a8204614ccc7d9a01c1f7
>> [23] RFC V3: https://lore.kernel.org/qemu-devel/20240613233639.202896-1-salil.mehta@huawei.com/#t
>>
>> (XIII) ACKNOWLEDGEMENTS
>> =======================
>>
>> I would like to thank the following people for various discussions with me over different channels during development:
>>
>> Marc Zyngier (Google), Catalin Marinas (ARM), James Morse (ARM), Will Deacon (Google),
>> Jean-Philippe Brucker (Linaro), Sudeep Holla (ARM), Lorenzo Pieralisi (Linaro),
>> Gavin Shan (RedHat), Jonathan Cameron (Huawei), Darren Hart (Ampere),
>> Igor Mamedov (RedHat), Ilkka Koskinen (Ampere), Andrew Jones (RedHat),
>> Karl Heubaum (Oracle), Keqian Zhu (Huawei), Miguel Luis (Oracle),
>> Xiongfeng Wang (Huawei), Vishnu Pajjuri (Ampere), Shameerali Kolothum (Huawei),
>> Russell King (Oracle), Xuwei/Joy (Huawei), Peter Maydel (Linaro),
>> Zengtao/Prime (Huawei), Nicholas Piggin (IBM) and all those whom I have missed!
>>
>> Many thanks to the following people for their current or past contributions:
>>
>> 1. James Morse (ARM)
>>     (Current Kernel part of vCPU Hotplug Support on AARCH64)
>> 2. Jean-Philippe Brucker (Linaro)
>>     (Prototyped one of the earlier PSCI-based POC [17][18] based on RFC V1)
>> 3. Keqian Zhu (Huawei)
>>     (Co-developed Qemu prototype)
>> 4. Xiongfeng Wang (Huawei)
>>     (Co-developed an earlier kernel prototype with me)
>> 5. Vishnu Pajjuri (Ampere)
>>     (Verification on Ampere ARM64 Platforms + fixes)
>> 6. Miguel Luis (Oracle)
>>     (Verification on Oracle ARM64 Platforms + fixes)
>> 7. Russell King (Oracle) & Jonathan Cameron (Huawei)
>>     (Helping in upstreaming James Morse's Kernel patches).
>>
>> (XIV) Change Log:
>> =================
>>
>> RFC V4 -> RFC V5:
>> -----------------
>> 1. Dropped "[PATCH RFC V4 19/33] target/arm: Force ARM vCPU *present* status ACPI *persistent*"
>>     - Seperated the architecture agnostic ACPI changes required to support vCPU Hotplug
>>       Link: https://lore.kernel.org/qemu-devel/20241014192205.253479-1-salil.mehta@huawei.com/#t
>> 2. Dropped "[PATCH RFC V4 02/33] cpu-common: Add common CPU utility for possible vCPUs"
>>     - Dropped qemu{present,enabled}_cpu() APIs. Commented by Gavin (Redhat), Miguel(Oracle), Igor(Redhat)
>> 3. Added "Reviewed-by: Miguel Luis <miguel.luis@oracle.com>" to [PATCH RFC V4 01/33]
>> 3. Dropped the `CPUState::disabled` flag and introduced `GICv3State::num_smp_cpus` flag
>>     - All `GICv3CPUState' between [num_smp_cpus,num_cpus) are marked as 'inaccessible` during gicv3_common_realize()
>>     - qemu_enabled_cpu() not required - removed!
>>     - removed usage of `CPUState::disabled` from virt.c and hw/cpu64.c
>> 4. Removed virt_cpu_properties() and introduced property `mp-affinity` get accessor
>> 5. Dropped "[PATCH RFC V4 12/33] arm/virt: Create GED device before *disabled* vCPU Objects are destroyed"
>>
>> RFC V3 -> RFC V4:
>> -----------------
>> 1. Addressed Nicholas Piggin's (IBM) comments
>>     - Moved qemu_get_cpu_archid() as a ACPI helper inline acpi/cpu.h
>>       https://lore.kernel.org/qemu-devel/D2GFCLH11HGJ.1IJGANHQ9ZQRL@gmail.com/
>>     - Introduced new macro CPU_FOREACH_POSSIBLE() in [PATCH 12/33]
>>       https://lore.kernel.org/qemu-devel/D2GF9A9AJO02.1G1G8UEXA5AOD@gmail.com/
>>     - Converted CPUState::acpi_persistent into Property. Improved the cover note
>>       https://lore.kernel.org/qemu-devel/D2H62RK48KT7.2BTQEZUOEGG4L@gmail.com/
>>     - Fixed teh cover note of the[PATCH ] and clearly mentioned about KVMParking
>>       https://lore.kernel.org/qemu-devel/D2GFOGQC3HYO.2LKOV306JIU98@gmail.com/
>> 2. Addressed Gavin Shan's (RedHat) comments:
>>     - Introduced the ARM Extensions check. [Looks like I missed the PMU check :( ]
>>       https://lore.kernel.org/qemu-devel/28f3107f-0267-4112-b0ca-da59df2968ae@redhat.com/
>>     - Moved create_gpio() along with create_ged()
>>       https://lore.kernel.org/qemu-devel/143ad7d2-8f45-4428-bed3-891203a49029@redhat.com/
>>     - Improved the logic of the GIC creation and initialization
>>       https://lore.kernel.org/qemu-devel/9b7582f0-8149-4bf0-a1aa-4d4fe0d35e70@redhat.com/
>>     - Removed redundant !dev->realized checks in cpu_hotunplug(_request)
>>       https://lore.kernel.org/qemu-devel/64e9feaa-8df2-4108-9e73-c72517fb074a@redhat.com/
>> 3. Addresses Alex Bennée's + Gustavo Romero (Linaro) comments
>>     - Fixed the TCG support and now it works for all the cases including migration.
>>       https://lore.kernel.org/qemu-devel/87bk1b3azm.fsf@draig.linaro.org/
>>     - Fixed the cpu_address_space_destroy() compilation failuer in user-mode
>>       https://lore.kernel.org/qemu-devel/87v800wkb1.fsf@draig.linaro.org/
>> 4. Fixed crash in .post_gicv3() during migration with asymmetrically *enabled*
>>       vCPUs at destination VM
>>
>> RFC V2 -> RFC V3:
>> -----------------
>> 1. Miscellaneous:
>>     - Split the RFC V2 into arch-agnostic and arch-specific patch sets.
>> 2. Addressed Gavin Shan's (RedHat) comments:
>>     - Made CPU property accessors inline.
>>       https://lore.kernel.org/qemu-devel/6cd28639-2cfa-f233-c6d9-d5d2ec5b1c58@redhat.com/
>>     - Collected Reviewed-bys [PATCH RFC V2 4/37, 14/37, 22/37].
>>     - Dropped the patch as it was not required after init logic was refactored.
>>       https://lore.kernel.org/qemu-devel/4fb2eef9-6742-1eeb-721a-b3db04b1be97@redhat.com/
>>     - Fixed the range check for the core during vCPU Plug.
>>       https://lore.kernel.org/qemu-devel/1c5fa24c-6bf3-750f-4f22-087e4a9311af@redhat.com/
>>     - Added has_hotpluggable_vcpus check to make build_cpus_aml() conditional.
>>       https://lore.kernel.org/qemu-devel/832342cb-74bc-58dd-c5d7-6f995baeb0f2@redhat.com/
>>     - Fixed the states initialization in cpu_hotplug_hw_init() to accommodate previous refactoring.
>>       https://lore.kernel.org/qemu-devel/da5e5609-1883-8650-c7d8-6868c7b74f1c@redhat.com/
>>     - Fixed typos.
>>       https://lore.kernel.org/qemu-devel/eb1ac571-7844-55e6-15e7-3dd7df21366b@redhat.com/
>>     - Removed the unnecessary 'goto fail'.
>>       https://lore.kernel.org/qemu-devel/4d8980ac-f402-60d4-fe52-787815af8a7d@redhat.com/#t
>>     - Added check for hotpluggable vCPUs in the _OSC method.
>>       https://lore.kernel.org/qemu-devel/20231017001326.FUBqQ1PTowF2GxQpnL3kIW0AhmSqbspazwixAHVSi6c@z/
>> 3. Addressed Shaoqin Huang's (Intel) comments:
>>     - Fixed the compilation break due to the absence of a call to virt_cpu_properties() missing
>>       along with its definition.
>>       https://lore.kernel.org/qemu-devel/3632ee24-47f7-ae68-8790-26eb2cf9950b@redhat.com/
>> 4. Addressed Jonathan Cameron's (Huawei) comments:
>>     - Gated the 'disabled vcpu message' for GIC version < 3.
>>       https://lore.kernel.org/qemu-devel/20240116155911.00004fe1@Huawei.com/
>>
>> RFC V1 -> RFC V2:
>> -----------------
>> 1. Addressed James Morse's (ARM) requirement as per Linaro Open Discussion:
>>     - Exposed all possible vCPUs as always ACPI _STA.present and available during boot time.
>>     - Added the _OSC handling as required by James's patches.
>>     - Introduction of 'online-capable' bit handling in the flag of MADT GICC.
>>     - SMCC Hypercall Exit handling in Qemu.
>> 2. Addressed Marc Zyngier's comment:
>>     - Fixed the note about GIC CPU Interface in the cover letter.
>> 3. Addressed issues raised by Vishnu Pajjuru (Ampere) & Miguel Luis (Oracle) during testing:
>>     - Live/Pseudo Migration crashes.
>> 4. Others:
>>     - Introduced the concept of persistent vCPU at QOM.
>>     - Introduced wrapper APIs of present, possible, and persistent.
>>     - Change at ACPI hotplug H/W init leg accommodating initializing is_present and is_enabled states.
>>     - Check to avoid unplugging cold-booted vCPUs.
>>     - Disabled hotplugging with TCG/HVF/QTEST.
>>     - Introduced CPU Topology, {socket, cluster, core, thread}-id property.
>>     - Extract virt CPU properties as a common virt_vcpu_properties() function.
>>
>> Author Salil Mehta (1):
>>    target/arm/kvm,tcg: Handle SMCCC hypercall exits in VMM during
>>      PSCI_CPU_{ON,OFF}
>>
>> Jean-Philippe Brucker (2):
>>    hw/acpi: Make _MAT method optional
>>    target/arm/kvm: Write vCPU's state back to KVM on cold-reset
>>
>> Miguel Luis (1):
>>    tcg/mttcg: Introduce MTTCG thread unregistration leg
>>
>> Salil Mehta (26):
>>    arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}-id
>>      property
>>    hw/arm/virt: Disable vCPU hotplug for *unsupported* Accel or GIC Type
>>    hw/arm/virt: Move setting of common vCPU properties in a function
>>    arm/virt,target/arm: Machine init time change common to vCPU
>>      {cold|hot}-plug
>>    arm/virt,kvm: Pre-create KVM vCPUs for all unplugged QOM vCPUs
>>      @machine init
>>    arm/virt,gicv3: Changes to pre-size GIC with possible vCPUs @machine
>>      init
>>    arm/virt,gicv3: Introduce GICv3 CPU Interface *accessibility* flag and
>>      checks
>>    hw/intc/arm-gicv3*: Changes required to (re)init the GICv3 vCPU
>>      Interface
>>    arm/acpi: Enable ACPI support for vCPU hotplug
>>    arm/virt: Enhance GED framework to handle vCPU hotplug events
>>    arm/virt: Init PMU at host for all possible vCPUs
>>    arm/virt: Release objects for *disabled* possible vCPUs after init
>>    arm/virt/acpi: Update ACPI DSDT Tbl to include CPUs AML with hotplug
>>      support
>>    hw/arm/acpi: MADT Tbl change to size the guest with possible vCPUs
>>    target/arm: Force ARM vCPU *present* status ACPI *persistent*
>>    arm/virt: Add/update basic hot-(un)plug framework
>>    arm/virt: Changes to (un)wire GICC<->vCPU IRQs during hot-(un)plug
>>    hw/arm,gicv3: Changes to notify GICv3 CPU state with vCPU hot-(un)plug
>>      event
>>    hw/arm: Changes required for reset and to support next boot
>>    arm/virt: Update the guest(via GED) about vCPU hot-(un)plug events
>>    target/arm/cpu: Check if hotplugged ARM vCPU's FEAT match existing
>>    tcg: Update tcg_register_thread() leg to handle region alloc for
>>      hotplugged vCPU
>>    target/arm: Add support to *unrealize* ARMCPU during vCPU Hot-unplug
>>    hw/intc/arm_gicv3_common: Add GICv3CPUState 'accessible' flag
>>      migration handling
>>    hw/intc/arm_gicv3_kvm: Pause all vCPU to ensure locking in KVM of
>>      resetting vCPU
>>    hw/arm/virt: Expose cold-booted vCPUs as MADT GICC *Enabled*
>>
>>   accel/tcg/tcg-accel-ops-mttcg.c    |   3 +-
>>   accel/tcg/tcg-accel-ops-rr.c       |   2 +-
>>   cpu-common.c                       |  11 +
>>   hw/acpi/cpu.c                      |   9 +-
>>   hw/arm/Kconfig                     |   1 +
>>   hw/arm/boot.c                      |   2 +-
>>   hw/arm/virt-acpi-build.c           |  69 ++-
>>   hw/arm/virt.c                      | 840 +++++++++++++++++++++++------
>>   hw/core/gpio.c                     |   2 +-
>>   hw/intc/arm_gicv3.c                |   1 +
>>   hw/intc/arm_gicv3_common.c         |  99 +++-
>>   hw/intc/arm_gicv3_cpuif.c          | 253 ++++-----
>>   hw/intc/arm_gicv3_cpuif_common.c   |  13 +
>>   hw/intc/arm_gicv3_kvm.c            |  40 +-
>>   hw/intc/gicv3_internal.h           |   1 +
>>   include/hw/acpi/cpu.h              |  19 +
>>   include/hw/arm/boot.h              |   2 +
>>   include/hw/arm/virt.h              |  64 ++-
>>   include/hw/core/cpu.h              |  20 +
>>   include/hw/intc/arm_gicv3_common.h |  61 +++
>>   include/hw/qdev-core.h             |   2 +
>>   include/tcg/startup.h              |  13 +
>>   include/tcg/tcg.h                  |   1 +
>>   system/physmem.c                   |   8 +-
>>   target/arm/arm-powerctl.c          |  20 +-
>>   target/arm/cpu-qom.h               |  18 +-
>>   target/arm/cpu.c                   | 178 +++++-
>>   target/arm/cpu.h                   |  18 +
>>   target/arm/cpu64.c                 |  18 +
>>   target/arm/gdbstub.c               |   6 +
>>   target/arm/helper.c                |  27 +-
>>   target/arm/internals.h             |  14 +-
>>   target/arm/kvm.c                   | 146 ++++-
>>   target/arm/kvm_arm.h               |  24 +
>>   target/arm/meson.build             |   1 +
>>   target/arm/{tcg => }/psci.c        |   8 +
>>   target/arm/tcg/meson.build         |   4 -
>>   tcg/region.c                       |  14 +
>>   tcg/tcg.c                          |  46 +-
>>   39 files changed, 1714 insertions(+), 364 deletions(-)
>>   rename target/arm/{tcg => }/psci.c (97%)
>>
> 


