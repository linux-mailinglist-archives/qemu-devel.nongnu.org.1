Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 114C38C7740
	for <lists+qemu-devel@lfdr.de>; Thu, 16 May 2024 15:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7apA-0007aW-8Z; Thu, 16 May 2024 09:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7ap2-0007R3-MX; Thu, 16 May 2024 09:07:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7aoz-0007QD-UW; Thu, 16 May 2024 09:07:00 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44GD40VH014142; Thu, 16 May 2024 13:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gGnNUNAcOowupAnsWVHcdCyfhOAVBXZR88+dXB33nCc=;
 b=Xl0gis6+QGLdczd6n3XsisRNQ4EhQiRafPdCF09rMP7dXZGt/vGMB4P1ej2Ft6xPjjSi
 Wvyu7uYx6EgoJo+MKXVUfWfputRuUHHxX50Q39uGKgRYcxTMBnRqOcFfdTSb015lMrIN
 0j1nlEdt4tavOLgcGPubZcoMBUl5svNQrMBH9YhuiBbVD0MhP7EHFaKriJQcxtUIIv0s
 ALq1ioPD9tzl+oAppCKEVdhGw1oPuKqscz2Tbz8rp6M6Ii/s1nzIPbtuaQSiYHfDikUD
 qoNq8TAVIaf58x8CxvuGI6ZCGuX/I/mjKQWAEmYfLR+WkKEGgXSsBz5S2CRF75eXe/Kv xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5jpa80aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 13:06:47 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44GD6l4u017820;
 Thu, 16 May 2024 13:06:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5jpa80am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 13:06:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44GB2v8t002291; Thu, 16 May 2024 13:06:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0pj26e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 13:06:46 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44GD6hnU13632242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2024 13:06:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 686CA5805A;
 Thu, 16 May 2024 13:06:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 726E258064;
 Thu, 16 May 2024 13:06:39 +0000 (GMT)
Received: from [9.195.33.214] (unknown [9.195.33.214])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 May 2024 13:06:39 +0000 (GMT)
Message-ID: <49f4d0cb-260e-45fb-a678-2dec45c9fab8@linux.ibm.com>
Date: Thu, 16 May 2024 18:36:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] accel/kvm: Extract common KVM vCPU {creation,
 parking} code
To: Salil Mehta <salil.mehta@huawei.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "danielhb413@gmail.com" <danielhb413@gmail.com>,
 "vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>,
 "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>
References: <20240516053211.145504-1-harshpb@linux.ibm.com>
 <20240516053211.145504-2-harshpb@linux.ibm.com>
 <fc08e87c979a4916aaff649724df9c6b@huawei.com>
 <bfb5888c-c66c-4000-ba12-5af202b0fe17@linux.ibm.com>
 <2e290791a92949d79fe0fdfcb972a029@huawei.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <2e290791a92949d79fe0fdfcb972a029@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0fLsoClaAgkjDnS8vlfJo_gnuSSwF3ZR
X-Proofpoint-GUID: IBHoVgejkt3OlDtOhtxko3jFV4U1Q2bm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160092
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

On 5/16/24 17:42, Salil Mehta wrote:
> Hi Harsh,
> 
>>   From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>   Sent: Thursday, May 16, 2024 11:15 AM
>>   
>>   Hi Salil,
>>   
>>   Thanks for your email.
>>   Your patch 1/8 is included here based on review comments on my previous
>>   patch from one of the maintainers in the community and therefore I had
>>   kept you in CC to be aware of the desire of having this independent patch to
>>   get merged earlier even if your other patches in the series may go through
>>   further reviews.
> 
> I really don’t know which discussion are  you pointing at? Please understand
> you are fixing a bug and we are pushing a feature which has got large series.
> It will break the patch-set  which is about t be merged.
> 
> There will be significant overhead of testing on us for the work we have been
> carrying forward for large time. This will be disruptive. Please dont!
> 

I was referring to the review discussion on my prev patch here:
https://lore.kernel.org/qemu-devel/D191D2JFAR7L.2EH4S445M4TGK@gmail.com/

Although your patch was included with this series only to facilitate
review of the additional patches depending on just one of your patch.

I am not sure what is appearing disruptive here. It is a common practive
in the community that maintainer(s) can pick individual patches from the
series if it has been vetted by siginificant number of reviewers.

However, in this case, since you have mentioned to post next version
soon, you need not worry about it as that would be the preferred version
for both of the series.

> 
>>   
>>   I am hoping to see your v9 soon and thereafter maintainer(s) may choose to
>>   pick the latest independent patch if needs to be merged earlier.
> 
> 
> I don’t think you are understanding what problem it is causing. For your
> small bug fix you are causing significant delays at our end.
> 

I hope I clarfied above that including your patch here doesnt delay
anything. Hoping to see your v9 soon!

Thanks
Harsh
> 
> Thanks
> Salil.
>>   
>>   Thanks for your work and let's be hopeful it gets merged soon.
>>   
>>   regards,
>>   Harsh
>>   
>>   On 5/16/24 14:00, Salil Mehta wrote:
>>   > Hi Harsh,
>>   >
>>   > Thanks for your interest in the patch-set but taking away patches like
>>   > this from other series without any discussion can disrupt others work
>>   > and its acceptance on time. This is because we will have to put lot of
>>   > effort in rebasing bigger series and then testing overhead comes along
>>   > with it.
>>   >
>>   > The patch-set (from where this  patch has been taken) is part of even
>>   > bigger series and there have been many people and companies toiling to
>>   > fix the bugs collectively in that series and for years.
>>   >
>>   > I'm about float the V9 version of the Arch agnostic series which this
>>   > patch is part of and you can rebase your patch-set from there. I'm
>>   > hopeful that it will get accepted in this cycle.
>>   >
>>   >
>>   > Many thanks
>>   > Salil.
>>   >
>>   >>   From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>   >>   Sent: Thursday, May 16, 2024 6:32 AM
>>   >>
>>   >>   From: Salil Mehta <salil.mehta@huawei.com>
>>   >>
>>   >>   KVM vCPU creation is done once during the vCPU realization when
>>   Qemu
>>   >>   vCPU thread is spawned. This is common to all the architectures as of
>>   now.
>>   >>
>>   >>   Hot-unplug of vCPU results in destruction of the vCPU object in QOM
>>   but
>>   >>   the corresponding KVM vCPU object in the Host KVM is not destroyed
>>   as
>>   >>   KVM doesn't support vCPU removal. Therefore, its representative KVM
>>   >>   vCPU object/context in Qemu is parked.
>>   >>
>>   >>   Refactor architecture common logic so that some APIs could be reused
>>   by
>>   >>   vCPU Hotplug code of some architectures likes ARM, Loongson etc.
>>   Update
>>   >>   new/old APIs with trace events instead of DPRINTF. No functional
>>   change is
>>   >>   intended here.
>>   >>
>>   >>   Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>   >>   Reviewed-by: Gavin Shan <gshan@redhat.com>
>>   >>   Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>>   >>   Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>   >>   Tested-by: Xianglai Li <lixianglai@loongson.cn>
>>   >>   Tested-by: Miguel Luis <miguel.luis@oracle.com>
>>   >>   Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>>   >>   [harshpb: fixed rebase failures in include/sysemu/kvm.h]
>>   >>   Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>   >>   ---
>>   >>    include/sysemu/kvm.h   | 15 ++++++++++
>>   >>    accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++---
>>   -----
>>   >>   --
>>   >>    accel/kvm/trace-events |  5 +++-
>>   >>    3 files changed, 68 insertions(+), 16 deletions(-)
>>   >>
>>   >>   diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h index
>>   >>   eaf801bc93..fa3ec74442 100644
>>   >>   --- a/include/sysemu/kvm.h
>>   >>   +++ b/include/sysemu/kvm.h
>>   >>   @@ -434,6 +434,21 @@ void kvm_set_sigmask_len(KVMState *s,
>>   unsigned
>>   >>   int sigmask_len);
>>   >>
>>   >>    int kvm_physical_memory_addr_from_host(KVMState *s, void
>>   >>   *ram_addr,
>>   >>                                           hwaddr *phys_addr);
>>   >>   +/**
>>   >>   + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM
>>   vCPU
>>   >>   + * @cpu: QOM CPUState object for which KVM vCPU has to be
>>   >>   fetched/created.
>>   >>   + *
>>   >>   + * @returns: 0 when success, errno (<0) when failed.
>>   >>   + */
>>   >>   +int kvm_create_vcpu(CPUState *cpu);
>>   >>   +
>>   >>   +/**
>>   >>   + * kvm_park_vcpu - Park QEMU KVM vCPU context
>>   >>   + * @cpu: QOM CPUState object for which QEMU KVM vCPU context
>>   has to
>>   >>   be parked.
>>   >>   + *
>>   >>   + * @returns: none
>>   >>   + */
>>   >>   +void kvm_park_vcpu(CPUState *cpu);
>>   >>
>>   >>    #endif /* COMPILING_PER_TARGET */
>>   >>
>>   >>   diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
>>   >>   d7281b93f3..30d42847de 100644
>>   >>   --- a/accel/kvm/kvm-all.c
>>   >>   +++ b/accel/kvm/kvm-all.c
>>   >>   @@ -128,6 +128,7 @@ static QemuMutex kml_slots_lock;  #define
>>   >>   kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>>   >>
>>   >>    static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
>>   >>   +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
>>   >>
>>   >>    static inline void kvm_resample_fd_remove(int gsi)  { @@ -340,14
>>   +341,53
>>   >>   @@ err:
>>   >>        return ret;
>>   >>    }
>>   >>
>>   >>   +void kvm_park_vcpu(CPUState *cpu)
>>   >>   +{
>>   >>   +    struct KVMParkedVcpu *vcpu;
>>   >>   +
>>   >>   +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   >>   +
>>   >>   +    vcpu = g_malloc0(sizeof(*vcpu));
>>   >>   +    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
>>   >>   +    vcpu->kvm_fd = cpu->kvm_fd;
>>   >>   +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu,
>>   node); }
>>   >>   +
>>   >>   +int kvm_create_vcpu(CPUState *cpu)
>>   >>   +{
>>   >>   +    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
>>   >>   +    KVMState *s = kvm_state;
>>   >>   +    int kvm_fd;
>>   >>   +
>>   >>   +    trace_kvm_create_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   >>   +
>>   >>   +    /* check if the KVM vCPU already exist but is parked */
>>   >>   +    kvm_fd = kvm_get_vcpu(s, vcpu_id);
>>   >>   +    if (kvm_fd < 0) {
>>   >>   +        /* vCPU not parked: create a new KVM vCPU */
>>   >>   +        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
>>   >>   +        if (kvm_fd < 0) {
>>   >>   +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu",
>>   >>   vcpu_id);
>>   >>   +            return kvm_fd;
>>   >>   +        }
>>   >>   +    }
>>   >>   +
>>   >>   +    cpu->kvm_fd = kvm_fd;
>>   >>   +    cpu->kvm_state = s;
>>   >>   +    cpu->vcpu_dirty = true;
>>   >>   +    cpu->dirty_pages = 0;
>>   >>   +    cpu->throttle_us_per_full = 0;
>>   >>   +
>>   >>   +    return 0;
>>   >>   +}
>>   >>   +
>>   >>    static int do_kvm_destroy_vcpu(CPUState *cpu)  {
>>   >>        KVMState *s = kvm_state;
>>   >>        long mmap_size;
>>   >>   -    struct KVMParkedVcpu *vcpu = NULL;
>>   >>        int ret = 0;
>>   >>
>>   >>   -    trace_kvm_destroy_vcpu();
>>   >>   +    trace_kvm_destroy_vcpu(cpu->cpu_index,
>>   kvm_arch_vcpu_id(cpu));
>>   >>
>>   >>        ret = kvm_arch_destroy_vcpu(cpu);
>>   >>        if (ret < 0) {
>>   >>   @@ -373,10 +413,7 @@ static int do_kvm_destroy_vcpu(CPUState
>>   *cpu)
>>   >>            }
>>   >>        }
>>   >>
>>   >>   -    vcpu = g_malloc0(sizeof(*vcpu));
>>   >>   -    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
>>   >>   -    vcpu->kvm_fd = cpu->kvm_fd;
>>   >>   -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu,
>>   node);
>>   >>   +    kvm_park_vcpu(cpu);
>>   >>    err:
>>   >>        return ret;
>>   >>    }
>>   >>   @@ -397,6 +434,8 @@ static int kvm_get_vcpu(KVMState *s, unsigned
>>   long
>>   >>   vcpu_id)
>>   >>            if (cpu->vcpu_id == vcpu_id) {
>>   >>                int kvm_fd;
>>   >>
>>   >>   +            trace_kvm_get_vcpu(vcpu_id);
>>   >>   +
>>   >>                QLIST_REMOVE(cpu, node);
>>   >>                kvm_fd = cpu->kvm_fd;
>>   >>                g_free(cpu);
>>   >>   @@ -404,7 +443,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned
>>   long
>>   >>   vcpu_id)
>>   >>            }
>>   >>        }
>>   >>
>>   >>   -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
>>   >>   +    return -ENOENT;
>>   >>    }
>>   >>
>>   >>    int kvm_init_vcpu(CPUState *cpu, Error **errp) @@ -415,19 +454,14
>>   @@
>>   >>   int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>   >>
>>   >>        trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   >>
>>   >>   -    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>>   >>   +    ret = kvm_create_vcpu(cpu);
>>   >>        if (ret < 0) {
>>   >>   -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed
>>   >>   (%lu)",
>>   >>   +        error_setg_errno(errp, -ret,
>>   >>   +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
>>   >>                             kvm_arch_vcpu_id(cpu));
>>   >>            goto err;
>>   >>        }
>>   >>
>>   >>   -    cpu->kvm_fd = ret;
>>   >>   -    cpu->kvm_state = s;
>>   >>   -    cpu->vcpu_dirty = true;
>>   >>   -    cpu->dirty_pages = 0;
>>   >>   -    cpu->throttle_us_per_full = 0;
>>   >>   -
>>   >>        mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>>   >>        if (mmap_size < 0) {
>>   >>            ret = mmap_size;
>>   >>   diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events index
>>   >>   681ccb667d..75c1724e78 100644
>>   >>   --- a/accel/kvm/trace-events
>>   >>   +++ b/accel/kvm/trace-events
>>   >>   @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd
>>   %d,
>>   >>   type 0x%x, arg %p"
>>   >>    kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to
>>   >>   retrieve ONEREG %" PRIu64 " from KVM: %s"
>>   >>    kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to
>>   set
>>   >>   ONEREG %" PRIu64 " to KVM: %s"
>>   >>    kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d
>>   id:
>>   >>   %lu"
>>   >>   +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id) "index:
>>   %d
>>   >>   id: %lu"
>>   >>   +kvm_get_vcpu(unsigned long arch_cpu_id) "id: %lu"
>>   >>   +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index:
>>   %d
>>   >>   id: %lu"
>>   >>   +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d
>>   id:
>>   >>   %lu"
>>   >>    kvm_irqchip_commit_routes(void) ""
>>   >>    kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s
>>   >>   vector %d virq %d"
>>   >>    kvm_irqchip_update_msi_route(int virq) "Updating MSI route
>>   virq=%d"
>>   >>   @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>>   >>    kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64"
>>   pages
>>   >>   (took %"PRIi64" us)"
>>   >>    kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>>   >>    kvm_dirty_ring_flush(int finished) "%d"
>>   >>   -kvm_destroy_vcpu(void) ""
>>   >>    kvm_failed_get_vcpu_mmap_size(void) ""
>>   >>    kvm_cpu_exec(void) ""
>>   >>    kvm_interrupt_exit_request(void) ""
>>   >>   --
>>   >>   2.39.3
>>   >

