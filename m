Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EAD8D44AC
	for <lists+qemu-devel@lfdr.de>; Thu, 30 May 2024 07:07:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCXza-0003go-HY; Thu, 30 May 2024 01:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sCXzX-0003fx-EK; Thu, 30 May 2024 01:06:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sCXzU-0006pj-OF; Thu, 30 May 2024 01:06:19 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U3vtJ5002421; Thu, 30 May 2024 05:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=aFtEBSupd9KJZzmv1FBMPeu+pl9TUX4hCpENkIO0IdU=;
 b=ZgdVhf2OkD+ZN4/Zqev36LetHh8cFSw9zq2nNKaVDFDTeL8SPydlSTiU2bkfADU6fYPY
 lkeXFPMODKFOjdCCff9iLhJKcafkbr7hSLaN+rYflH9Mx1pERdegYbLkb0roG2OvU2+N
 IU2NIwHon3i117FeMyq/CLMDosZoLse+tXkqSfFhxU8iFKXZ8ULBkCLrqjbobVwVOEja
 7Wyf2Zt7RbNtHpNIqZDXjSxvAilyplYSLSfbQU2G1R6ko+6emzt5zz++zNcTCsCbGl+n
 RcrF1ltbN1xnUDqflNBTg1Idxvk1serGgfSE86HJsdaKqNSRHKYiiJZe8WJFVC8Jz7bU 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yej0s84bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 05:05:30 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44U55T3W005101;
 Thu, 30 May 2024 05:05:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yej0s84bj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 05:05:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U1cOmC024752; Thu, 30 May 2024 05:05:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydphqqy50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 05:05:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44U55P1Y42861302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 05:05:27 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00EE55805D;
 Thu, 30 May 2024 05:05:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38F9658043;
 Thu, 30 May 2024 05:05:15 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 May 2024 05:05:14 +0000 (GMT)
Message-ID: <62f55169-1796-4d8e-a35d-7f003a172750@linux.ibm.com>
Date: Thu, 30 May 2024 10:35:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 npiggin@gmail.com, linuxarm@huawei.com,
 Shaoqin Huang <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240529234241.205053-1-salil.mehta@huawei.com>
 <20240529234241.205053-2-salil.mehta@huawei.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240529234241.205053-2-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VIZDXd-eYFEeLIoL6VjkbXv9PDIWZJO5
X-Proofpoint-ORIG-GUID: VjYHTL98YlduRrTI_UstbIUMZIVsD5XK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300034
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 5/30/24 05:12, Salil Mehta wrote:
> KVM vCPU creation is done once during the vCPU realization when Qemu vCPU thread
> is spawned. This is common to all the architectures as of now.
> 
> Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
> corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doesn't
> support vCPU removal. Therefore, its representative KVM vCPU object/context in
> Qemu is parked.
> 
> Refactor architecture common logic so that some APIs could be reused by vCPU
> Hotplug code of some architectures likes ARM, Loongson etc. Update new/old APIs
> with trace events. No functional change is intended here.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   accel/kvm/kvm-all.c    | 95 ++++++++++++++++++++++++++++--------------
>   accel/kvm/kvm-cpus.h   | 23 ++++++++++
>   accel/kvm/trace-events |  5 ++-
>   3 files changed, 90 insertions(+), 33 deletions(-)
> 

Since there are no functional changes intended here and we have a
different patch series (ppc64 vcpu hotplug failure fixes) depending on
this patch as well, it will be nice to see this patch getting merged
soon.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c0be9f5eed..8f9128bb92 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -340,14 +340,71 @@ err:
>       return ret;
>   }
>   
> +void kvm_park_vcpu(CPUState *cpu)
> +{
> +    struct KVMParkedVcpu *vcpu;
> +
> +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> +
> +    vcpu = g_malloc0(sizeof(*vcpu));
> +    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
> +    vcpu->kvm_fd = cpu->kvm_fd;
> +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +}
> +
> +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
> +{
> +    struct KVMParkedVcpu *cpu;
> +    int kvm_fd = -ENOENT;
> +
> +    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> +        if (cpu->vcpu_id == vcpu_id) {
> +            QLIST_REMOVE(cpu, node);
> +            kvm_fd = cpu->kvm_fd;
> +            g_free(cpu);
> +        }
> +    }
> +
> +    trace_kvm_unpark_vcpu(vcpu_id, kvm_fd > 0 ? "unparked" : "not found parked");
> +
> +    return kvm_fd;
> +}
> +
> +int kvm_create_vcpu(CPUState *cpu)
> +{
> +    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
> +    KVMState *s = kvm_state;
> +    int kvm_fd;
> +
> +    /* check if the KVM vCPU already exist but is parked */
> +    kvm_fd = kvm_unpark_vcpu(s, vcpu_id);
> +    if (kvm_fd < 0) {
> +        /* vCPU not parked: create a new KVM vCPU */
> +        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
> +        if (kvm_fd < 0) {
> +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu", vcpu_id);
> +            return kvm_fd;
> +        }
> +    }
> +
> +    cpu->kvm_fd = kvm_fd;
> +    cpu->kvm_state = s;
> +    cpu->vcpu_dirty = true;
> +    cpu->dirty_pages = 0;
> +    cpu->throttle_us_per_full = 0;
> +
> +    trace_kvm_create_vcpu(cpu->cpu_index, vcpu_id, kvm_fd);
> +
> +    return 0;
> +}
> +
>   static int do_kvm_destroy_vcpu(CPUState *cpu)
>   {
>       KVMState *s = kvm_state;
>       long mmap_size;
> -    struct KVMParkedVcpu *vcpu = NULL;
>       int ret = 0;
>   
> -    trace_kvm_destroy_vcpu();
> +    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>   
>       ret = kvm_arch_destroy_vcpu(cpu);
>       if (ret < 0) {
> @@ -373,10 +430,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>           }
>       }
>   
> -    vcpu = g_malloc0(sizeof(*vcpu));
> -    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
> -    vcpu->kvm_fd = cpu->kvm_fd;
> -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +    kvm_park_vcpu(cpu);
>   err:
>       return ret;
>   }
> @@ -389,24 +443,6 @@ void kvm_destroy_vcpu(CPUState *cpu)
>       }
>   }
>   
> -static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
> -{
> -    struct KVMParkedVcpu *cpu;
> -
> -    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> -        if (cpu->vcpu_id == vcpu_id) {
> -            int kvm_fd;
> -
> -            QLIST_REMOVE(cpu, node);
> -            kvm_fd = cpu->kvm_fd;
> -            g_free(cpu);
> -            return kvm_fd;
> -        }
> -    }
> -
> -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> -}
> -
>   int kvm_init_vcpu(CPUState *cpu, Error **errp)
>   {
>       KVMState *s = kvm_state;
> @@ -415,19 +451,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>   
>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>   
> -    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
> +    ret = kvm_create_vcpu(cpu);
>       if (ret < 0) {
> -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
> +        error_setg_errno(errp, -ret,
> +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
>                            kvm_arch_vcpu_id(cpu));
>           goto err;
>       }
>   
> -    cpu->kvm_fd = ret;
> -    cpu->kvm_state = s;
> -    cpu->vcpu_dirty = true;
> -    cpu->dirty_pages = 0;
> -    cpu->throttle_us_per_full = 0;
> -
>       mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>       if (mmap_size < 0) {
>           ret = mmap_size;
> diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
> index ca40add32c..2c1cad4179 100644
> --- a/accel/kvm/kvm-cpus.h
> +++ b/accel/kvm/kvm-cpus.h
> @@ -22,5 +22,28 @@ bool kvm_supports_guest_debug(void);
>   int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
>   int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
>   void kvm_remove_all_breakpoints(CPUState *cpu);
> +/**
> + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> + * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
> + *
> + * @returns: 0 when success, errno (<0) when failed.
> + */
> +int kvm_create_vcpu(CPUState *cpu);
>   
> +/**
> + * kvm_park_vcpu - Park QEMU KVM vCPU context
> + * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
> + *
> + * @returns: none
> + */
> +void kvm_park_vcpu(CPUState *cpu);
> +
> +/**
> + * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
> + * @s: KVM State
> + * @vcpu_id: Architecture vCPU ID of the parked vCPU
> + *
> + * @returns: KVM fd
> + */
> +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
>   #endif /* KVM_CPUS_H */
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 681ccb667d..37626c1ac5 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>   kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>   kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>   kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id, int kvm_fd) "index: %d, id: %lu, kvm fd: %d"
> +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_unpark_vcpu(unsigned long arch_cpu_id, const char *msg) "id: %lu %s"
>   kvm_irqchip_commit_routes(void) ""
>   kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
>   kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
> @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>   kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (took %"PRIi64" us)"
>   kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>   kvm_dirty_ring_flush(int finished) "%d"
> -kvm_destroy_vcpu(void) ""
>   kvm_failed_get_vcpu_mmap_size(void) ""
>   kvm_cpu_exec(void) ""
>   kvm_interrupt_exit_request(void) ""

