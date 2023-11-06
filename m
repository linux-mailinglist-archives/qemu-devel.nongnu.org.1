Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C87E279E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:50:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00ka-0007ZV-Ou; Mon, 06 Nov 2023 09:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1r00k1-00071b-Fh; Mon, 06 Nov 2023 09:38:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1r00js-000104-LT; Mon, 06 Nov 2023 09:38:10 -0500
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SPDPx2wqMz67K7y;
 Mon,  6 Nov 2023 22:34:29 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 14:37:51 +0000
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 6 Nov 2023 14:37:51 +0000
To: Igor Mammedov <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, Linuxarm
 <linuxarm@huawei.com>
Subject: RE: [PATCH V6 1/9] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Topic: [PATCH V6 1/9] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Index: AQHZ/cNbmYoAvNhsVEaeQJ89abXhdbBdndIAgA/cbdA=
Date: Mon, 6 Nov 2023 14:37:51 +0000
Message-ID: <84588feedcca4209ba3a5f07f3c94ecb@huawei.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <20231013105129.25648-2-salil.mehta@huawei.com>
 <20231027145652.44cc845c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231027145652.44cc845c@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.148.208]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Igor,
Thanks for the review comments. I was bit on and off so could not address
the comments. Please find my replies inline.

> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Friday, October 27, 2023 1:57 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; maz@kernel.org; jean-
> philippe@linaro.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> lpieralisi@kernel.org; peter.maydell@linaro.org;
> richard.henderson@linaro.org; andrew.jones@linux.dev; david@redhat.com;
> philmd@linaro.org; eric.auger@redhat.com; oliver.upton@linux.dev;
> pbonzini@redhat.com; mst@redhat.com; will@kernel.org; gshan@redhat.com;
> rafael@kernel.org; alex.bennee@linaro.org; linux@armlinux.org.uk;
> darren@os.amperecomputing.com; ilkka@os.amperecomputing.com;
> vishnu@os.amperecomputing.com; karl.heubaum@oracle.com;
> miguel.luis@oracle.com; salil.mehta@opnsrc.net; zhukeqian
> <zhukeqian1@huawei.com>; wangxiongfeng (C) <wangxiongfeng2@huawei.com>;
> wangyanan (Y) <wangyanan55@huawei.com>; jiakernel2@gmail.com;
> maobibo@loongson.cn; lixianglai@loongson.cn; Linuxarm <linuxarm@huawei.co=
m>
> Subject: Re: [PATCH V6 1/9] accel/kvm: Extract common KVM vCPU
> {creation,parking} code
>=20
> On Fri, 13 Oct 2023 11:51:21 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>=20
> > KVM vCPU creation is done once during the initialization of the VM when=
 Qemu
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > thread is spawned. This is common to all the architectures.
>=20
> is it really true fox x86?

Thanks for pointing out. I just meant,

"KVM vCPU creation is done once either during VM initialization or during
vCPU realization during Hotplug...."


> > Hot-unplug of vCPU results in destruction of the vCPU object in QOM but=
 the
> > corresponding KVM vCPU object in the Host KVM is not destroyed and its
>                                                                 ^
> since KVM doesn't support vCPU removal

Correct. Will add.


> > representative KVM vCPU object/context in Qemu is parked.
> >
> > Refactor common logic so that some APIs could be reused by vCPU Hotplug=
 code.
> 'reused' part doesn't happen within this series. So a reason
> why patch exists is not clear/no one can deduce the reason
> without the actual user here.
>=20
> Suggest to move it to a series that actually will use this patch.


I can do that but I think Loongson guys might need bit of this logic
as well. This patch also brings a good restructuring to the existing
code and fixes the traces etc.

I would humbly suggest to keep it unless you have strong views.

Thanks
Salil.

> > Update new/old APIs with trace events instead of DTRACE.
> >
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Tested-by: Xianglai Li <lixianglai@loongson.cn>
> > ---
> >  accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++----------
> >  accel/kvm/trace-events |  4 +++
> >  include/sysemu/kvm.h   | 16 +++++++++++
> >  3 files changed, 69 insertions(+), 15 deletions(-)
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 72e1d1141c..bfa7816aaa 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -137,6 +137,7 @@ static QemuMutex kml_slots_lock;
> >  #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
> >
> >  static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
> > +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
> >
> >  static inline void kvm_resample_fd_remove(int gsi)
> >  {
> > @@ -320,14 +321,53 @@ err:
> >      return ret;
> >  }
> >
> > +void kvm_park_vcpu(CPUState *cpu)
> > +{
> > +    struct KVMParkedVcpu *vcpu;
> > +
> > +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> > +
> > +    vcpu =3D g_malloc0(sizeof(*vcpu));
> > +    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
> > +    vcpu->kvm_fd =3D cpu->kvm_fd;
> > +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> > +}
> > +
> > +int kvm_create_vcpu(CPUState *cpu)
> > +{
> > +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cpu);
> > +    KVMState *s =3D kvm_state;
> > +    int kvm_fd;
> > +
> > +    trace_kvm_create_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> > +
> > +    /* check if the KVM vCPU already exist but is parked */
> > +    kvm_fd =3D kvm_get_vcpu(s, vcpu_id);
> > +    if (kvm_fd < 0) {
> > +        /* vCPU not parked: create a new KVM vCPU */
> > +        kvm_fd =3D kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
> > +        if (kvm_fd < 0) {
> > +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu",
> vcpu_id);
> > +            return kvm_fd;
> > +        }
> > +    }
> > +
> > +    cpu->kvm_fd =3D kvm_fd;
> > +    cpu->kvm_state =3D s;
> > +    cpu->vcpu_dirty =3D true;
> > +    cpu->dirty_pages =3D 0;
> > +    cpu->throttle_us_per_full =3D 0;
> > +
> > +    return 0;
> > +}
> > +
> >  static int do_kvm_destroy_vcpu(CPUState *cpu)
> >  {
> >      KVMState *s =3D kvm_state;
> >      long mmap_size;
> > -    struct KVMParkedVcpu *vcpu =3D NULL;
> >      int ret =3D 0;
> >
> > -    DPRINTF("kvm_destroy_vcpu\n");
> > +    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> >
> >      ret =3D kvm_arch_destroy_vcpu(cpu);
> >      if (ret < 0) {
> > @@ -353,10 +393,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
> >          }
> >      }
> >
> > -    vcpu =3D g_malloc0(sizeof(*vcpu));
> > -    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
> > -    vcpu->kvm_fd =3D cpu->kvm_fd;
> > -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> > +    kvm_park_vcpu(cpu);
> >  err:
> >      return ret;
> >  }
> > @@ -377,6 +414,8 @@ static int kvm_get_vcpu(KVMState *s, unsigned long
> vcpu_id)
> >          if (cpu->vcpu_id =3D=3D vcpu_id) {
> >              int kvm_fd;
> >
> > +            trace_kvm_get_vcpu(vcpu_id);
> > +
> >              QLIST_REMOVE(cpu, node);
> >              kvm_fd =3D cpu->kvm_fd;
> >              g_free(cpu);
> > @@ -384,7 +423,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long
> vcpu_id)
> >          }
> >      }
> >
> > -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> > +    return -ENOENT;
> >  }
> >
> >  int kvm_init_vcpu(CPUState *cpu, Error **errp)
> > @@ -395,19 +434,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
> >
> >      trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> >
> > -    ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
> > +    ret =3D kvm_create_vcpu(cpu);
> >      if (ret < 0) {
> > -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu fail=
ed
> (%lu)",
> > +        error_setg_errno(errp, -ret,
> > +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)"=
,
> >                           kvm_arch_vcpu_id(cpu));
> >          goto err;
> >      }
> >
> > -    cpu->kvm_fd =3D ret;
> > -    cpu->kvm_state =3D s;
> > -    cpu->vcpu_dirty =3D true;
> > -    cpu->dirty_pages =3D 0;
> > -    cpu->throttle_us_per_full =3D 0;
> > -
> >      mmap_size =3D kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
> >      if (mmap_size < 0) {
> >          ret =3D mmap_size;
> > diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> > index 399aaeb0ec..cdd0c95c09 100644
> > --- a/accel/kvm/trace-events
> > +++ b/accel/kvm/trace-events
> > @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd
> %d, type 0x%x, arg %p"
> >  kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to
> retrieve ONEREG %" PRIu64 " from KVM: %s"
> >  kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to s=
et
> ONEREG %" PRIu64 " to KVM: %s"
> >  kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id:
> %lu"
> > +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d i=
d:
> %lu"
> > +kvm_get_vcpu(unsigned long arch_cpu_id) "id: %lu"
> > +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d
> id: %lu"
> > +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id:
> %lu"
> >  kvm_irqchip_commit_routes(void) ""
> >  kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s
> vector %d virq %d"
> >  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=3D%d"
> > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > index ee9025f8e9..8137e6a44c 100644
> > --- a/include/sysemu/kvm.h
> > +++ b/include/sysemu/kvm.h
> > @@ -465,6 +465,22 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int
> sigmask_len);
> >  int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
> >                                         hwaddr *phys_addr);
> >
> > +/**
> > + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> > + * @cpu: QOM CPUState object for which KVM vCPU has to be
> fetched/created.
> > + *
> > + * @returns: 0 when success, errno (<0) when failed.
> > + */
> > +int kvm_create_vcpu(CPUState *cpu);
> > +
> > +/**
> > + * kvm_park_vcpu - Park QEMU KVM vCPU context
> > + * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be
> parked.
> > + *
> > + * @returns: none
> > + */
> > +void kvm_park_vcpu(CPUState *cpu);
> > +
> >  #endif /* NEED_CPU_H */
> >
> >  void kvm_cpu_synchronize_state(CPUState *cpu);


