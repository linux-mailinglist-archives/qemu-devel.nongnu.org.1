Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF707B6841
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:46:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qndr6-00076r-2w; Tue, 03 Oct 2023 07:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndr3-00076Q-D1; Tue, 03 Oct 2023 07:46:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndr1-0006Mj-E7; Tue, 03 Oct 2023 07:46:21 -0400
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0GHN07wpz67nc4;
 Tue,  3 Oct 2023 19:46:08 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 3 Oct 2023 12:46:16 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 3 Oct 2023 12:46:16 +0100
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V2 08/10] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Topic: [PATCH V2 08/10] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Index: AQHZ8zQ7yGl3U6l090SRw8cLGCyLZ7A2oYUAgAFWSiA=
Date: Tue, 3 Oct 2023 11:46:16 +0000
Message-ID: <65a71eabfd054646b069710ccfa9f633@huawei.com>
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-9-salil.mehta@huawei.com>
 <20231002172024.000042aa@Huawei.com>
In-Reply-To: <20231002172024.000042aa@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.168.138]
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Jonathan,

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: Monday, October 2, 2023 5:20 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; maz@kernel.org; jean-
> philippe@linaro.org; lpieralisi@kernel.org; peter.maydell@linaro.org;
> richard.henderson@linaro.org; imammedo@redhat.com; andrew.jones@linux.dev=
;
> david@redhat.com; philmd@linaro.org; eric.auger@redhat.com;
> oliver.upton@linux.dev; pbonzini@redhat.com; mst@redhat.com;
> will@kernel.org; gshan@redhat.com; rafael@kernel.org;
> alex.bennee@linaro.org; linux@armlinux.org.uk;
> darren@os.amperecomputing.com; ilkka@os.amperecomputing.com;
> vishnu@os.amperecomputing.com; karl.heubaum@oracle.com;
> miguel.luis@oracle.com; salil.mehta@opnsrc.net; zhukeqian
> <zhukeqian1@huawei.com>; wangxiongfeng (C) <wangxiongfeng2@huawei.com>;
> wangyanan (Y) <wangyanan55@huawei.com>; jiakernel2@gmail.com;
> maobibo@loongson.cn; lixianglai@loongson.cn; Linuxarm <linuxarm@huawei.co=
m>
> Subject: Re: [PATCH V2 08/10] physmem: Add helper function to destroy CPU
> AddressSpace
>=20
> On Sat, 30 Sep 2023 01:19:31 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>=20
> > Virtual CPU Hot-unplug leads to unrealization of a CPU object. This als=
o
> > involves destruction of the CPU AddressSpace. Add common function to he=
lp
> > destroy the CPU AddressSpace.
> >
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>=20
> I'm not that familiar with this bit of the code, so no tag, but
> as far as I can tell from a fairly superficial look, this is good.

Ok no problem. Thanks.

Salil.


> >  include/exec/cpu-common.h |  8 ++++++++
> >  include/hw/core/cpu.h     |  1 +
> >  softmmu/physmem.c         | 25 +++++++++++++++++++++++++
> >  3 files changed, 34 insertions(+)
> >
> > diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> > index 41788c0bdd..eb56a228a2 100644
> > --- a/include/exec/cpu-common.h
> > +++ b/include/exec/cpu-common.h
> > @@ -120,6 +120,14 @@ size_t qemu_ram_pagesize_largest(void);
> >   */
> >  void cpu_address_space_init(CPUState *cpu, int asidx,
> >                              const char *prefix, MemoryRegion *mr);
> > +/**
> > + * cpu_address_space_destroy:
> > + * @cpu: CPU for which address space needs to be destroyed
> > + * @asidx: integer index of this address space
> > + *
> > + * Note that with KVM only one address space is supported.
> > + */
> > +void cpu_address_space_destroy(CPUState *cpu, int asidx);
> >
> >  void cpu_physical_memory_rw(hwaddr addr, void *buf,
> >                              hwaddr len, bool is_write);
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 648b5b3586..65d2ae4581 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -355,6 +355,7 @@ struct CPUState {
> >      QSIMPLEQ_HEAD(, qemu_work_item) work_list;
> >
> >      CPUAddressSpace *cpu_ases;
> > +    int cpu_ases_count;
> >      int num_ases;
> >      AddressSpace *as;
> >      MemoryRegion *memory;
> > diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> > index 4f6ca653b3..4dfa0ca66f 100644
> > --- a/softmmu/physmem.c
> > +++ b/softmmu/physmem.c
> > @@ -761,6 +761,7 @@ void cpu_address_space_init(CPUState *cpu, int asid=
x,
> >
> >      if (!cpu->cpu_ases) {
> >          cpu->cpu_ases =3D g_new0(CPUAddressSpace, cpu->num_ases);
> > +        cpu->cpu_ases_count =3D cpu->num_ases;
> >      }
> >
> >      newas =3D &cpu->cpu_ases[asidx];
> > @@ -774,6 +775,30 @@ void cpu_address_space_init(CPUState *cpu, int
> asidx,
> >      }
> >  }
> >
> > +void cpu_address_space_destroy(CPUState *cpu, int asidx)
> > +{
> > +    CPUAddressSpace *cpuas;
> > +
> > +    assert(asidx < cpu->num_ases);
> > +    assert(asidx =3D=3D 0 || !kvm_enabled());
> > +    assert(cpu->cpu_ases);
> > +
> > +    cpuas =3D &cpu->cpu_ases[asidx];
> > +    if (tcg_enabled()) {
> > +        memory_listener_unregister(&cpuas->tcg_as_listener);
> > +    }
> > +
> > +    address_space_destroy(cpuas->as);
> > +    g_free_rcu(cpuas->as, rcu);
> > +
> > +    if (cpu->cpu_ases_count =3D=3D 1) {
> > +        g_free(cpu->cpu_ases);
> > +        cpu->cpu_ases =3D NULL;
> > +    }
> > +
> > +    cpu->cpu_ases_count--;
> > +}
> > +
> >  AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
> >  {
> >      /* Return the AddressSpace corresponding to the specified index */


