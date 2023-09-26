Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 296477AEC1F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:05:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6nR-0001HL-Qx; Tue, 26 Sep 2023 08:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql6nN-0001Dh-2s
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:04:05 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql6nI-0006Ku-G1
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:04:04 -0400
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rvyw058cCztStk;
 Tue, 26 Sep 2023 19:59:28 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 20:03:48 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 26 Sep 2023 13:03:46 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: xianglai li <lixianglai@loongson.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, Salil Mehta
 <salil.mehta@opnsrc.net>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao
 <gaosong@loongson.cn>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, "wangyanan
 (Y)" <wangyanan55@huawei.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Bibo Mao <maobibo@loongson.cn>
Subject: RE: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
Thread-Topic: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
Thread-Index: AQHZ8F98Fz18osKCj0u+l4OH//GmcbAs7Gww///2vACAABh10P//8ysAgAARtGA=
Date: Tue, 26 Sep 2023 12:03:46 +0000
Message-ID: <54482e7486564d68926ded075ebe8c6f@huawei.com>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <c2ab409710f5e0f0346727b47aaabd14537d45b8.1695697701.git.lixianglai@loongson.cn>
 <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
 <20230926071055-mutt-send-email-mst@kernel.org>
 <4cc68780b63f47879d757fe604f37892@huawei.com>
 <20230926074945-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230926074945-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.16]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=salil.mehta@huawei.com; helo=szxga01-in.huawei.com
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

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, September 26, 2023 12:54 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: xianglai li <lixianglai@loongson.cn>; qemu-devel@nongnu.org; Bernhard
> Beschow <shentey@gmail.com>; Salil Mehta <salil.mehta@opnsrc.net>; Xiaoju=
an
> Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Igor
> Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo
> Bonzini <pbonzini@redhat.com>; Richard Henderson
> <richard.henderson@linaro.org>; Eduardo Habkost <eduardo@habkost.net>;
> Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daud=E9
> <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Daniel P.
> Berrang=E9 <berrange@redhat.com>; Peter Xu <peterx@redhat.com>; David
> Hildenbrand <david@redhat.com>; Bibo Mao <maobibo@loongson.cn>
> Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
>=20
> On Tue, Sep 26, 2023 at 11:45:19AM +0000, Salil Mehta wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, September 26, 2023 12:12 PM
> > > To: Salil Mehta <salil.mehta@huawei.com>
> > > Cc: xianglai li <lixianglai@loongson.cn>; qemu-devel@nongnu.org;
> Bernhard
> > > Beschow <shentey@gmail.com>; Salil Mehta <salil.mehta@opnsrc.net>;
> Xiaojuan
> > > Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Igor
> > > Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paol=
o
> > > Bonzini <pbonzini@redhat.com>; Richard Henderson
> > > <richard.henderson@linaro.org>; Eduardo Habkost <eduardo@habkost.net>=
;
> > > Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daud=
=E9
> > > <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Daniel P=
.
> > > Berrang=E9 <berrange@redhat.com>; Peter Xu <peterx@redhat.com>; David
> > > Hildenbrand <david@redhat.com>; Bibo Mao <maobibo@loongson.cn>
> > > Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
> > >
> > > On Tue, Sep 26, 2023 at 10:49:08AM +0000, Salil Mehta wrote:
> > > > Hi Xianglai,
> > > > FYI. RFC V2 is out and you can now drop the arch agnostic patches
> from
> > > > your patch-set. Please check the details in the cover letter which
> one
> > > > you need to pick and rebase from:
> > > >
> > > > https://lore.kernel.org/qemu-devel/20230926100436.28284-1-
> > > salil.mehta@huawei.com/T/#t
> > > >
> > > > I am planning to float the architecture agnostic patch-set within
> this
> > > > week which will have same patches and in same order as mentioned in
> > > > the cover letter. This will untie the development across different
> > > > architectures.
> > > >
> > > > Many thanks
> > > > Salil.
> > >
> > > However, please get authorship info right. This claims patch has been
> > > codeveloped by Bernhard Beschow, xianglai li and yourself.
> > > Your patch claims a completely different list of authors
> >
> > Yes, because those are the people who have developed the patches.
> >
> > > with yourself being the only common author.
> > > Not nice.
> >
> > I have already replied in the other thread. This patch has been
> > taken from the ARM patch-set sent in the year 2020.
> >
> > I am not sure who is the other author and how he has contributed.
> >
> > Co-developed-by usually points at main authors.
> >
>=20
>=20
> If you are not sure then find out please.


We really have not collaborated on anything as part of
this entire development of virtual CPU hotplug since the
year 2020?

I would leave it to Xianglai to answer about the person.



> And to help you stop guessing at the rules:
>=20
> Documentation/process/submitting-patches.rst
>=20
> 	Co-developed-by: states that the patch was co-created by multiple
> developers;
> 	it is used to give attribution to co-authors (in addition to the
> author
> 	attributed by the From: tag) when several people work on a single
> patch.  Since
> 	Co-developed-by: denotes authorship, every Co-developed-by: must be
> immediately
> 	followed by a Signed-off-by: of the associated co-author.  Standard
> sign-off
> 	procedure applies, i.e. the ordering of Signed-off-by: tags should
> reflect the
> 	chronological history of the patch insofar as possible, regardless of
> whether
> 	the author is attributed via From: or Co-developed-by:.  Notably, the
> last
> 	Signed-off-by: must always be that of the developer submitting the
> patch.


Sure, ARM patch-set follows exactly above rules.



> > > > > From: xianglai li <lixianglai@loongson.cn>
> > > > > Sent: Tuesday, September 26, 2023 10:54 AM
> > > > > To: qemu-devel@nongnu.org
> > > > > Cc: Bernhard Beschow <shentey@gmail.com>; Salil Mehta
> > > > > <salil.mehta@opnsrc.net>; Salil Mehta <salil.mehta@huawei.com>;
> > > Xiaojuan
> > > > > Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>;
> > > Michael S.
> > > > > Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; An=
i
> > > Sinha
> > > > > <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richa=
rd
> > > > > Henderson <richard.henderson@linaro.org>; Eduardo Habkost
> > > > > <eduardo@habkost.net>; Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com>;
> > > > > Philippe Mathieu-Daud=E9 <philmd@linaro.org>; wangyanan (Y)
> > > > > <wangyanan55@huawei.com>; Daniel P. Berrang=E9 <berrange@redhat.c=
om>;
> > > Peter
> > > > > Xu <peterx@redhat.com>; David Hildenbrand <david@redhat.com>; Bib=
o
> Mao
> > > > > <maobibo@loongson.cn>
> > > > > Subject: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
> > > > >
> > > > > CPUs Control device(\\_SB.PCI0) register interface for the x86 ar=
ch
> > > > > is based on PCI and is IO port based and hence existing cpus AML
> code
> > > > > assumes _CRS objects would evaluate to a system resource which
> > > describes
> > > > > IO Port address.
> > > > > But on Loongarch arch CPUs control device(\\_SB.PRES) register
> > > interface
> > > > > is memory-mapped hence _CRS object should evaluate to system
> resource
> > > > > which describes memory-mapped base address.
> > > > >
> > > > > This cpus AML code change updates the existing interface of the
> build
> > > cpus
> > > > > AML
> > > > > function to accept both IO/MEMORY type regions and update the _CR=
S
> > > object
> > > > > correspondingly.
> > > > >
> > > > > Co-authored-by: "Bernhard Beschow" <shentey@gmail.com>
> > > > > Co-authored-by: "Salil Mehta" <salil.mehta@opnsrc.net>
> > > > > Co-authored-by: "Salil Mehta" <salil.mehta@huawei.com>
> > > > > Cc: "Bernhard Beschow" <shentey@gmail.com>
> > > > > Cc: "Salil Mehta" <salil.mehta@huawei.com>
> > > > > Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
> > > > > Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> > > > > Cc: Song Gao <gaosong@loongson.cn>
> > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > Cc: Igor Mammedov <imammedo@redhat.com>
> > > > > Cc: Ani Sinha <anisinha@redhat.com>
> > > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > > Cc: Richard Henderson <richard.henderson@linaro.org>
> > > > > Cc: Eduardo Habkost <eduardo@habkost.net>
> > > > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > > > Cc: "Philippe Mathieu-Daud=E9" <philmd@linaro.org>
> > > > > Cc: Yanan Wang <wangyanan55@huawei.com>
> > > > > Cc: "Daniel P. Berrang=E9" <berrange@redhat.com>
> > > > > Cc: Peter Xu <peterx@redhat.com>
> > > > > Cc: David Hildenbrand <david@redhat.com>
> > > > > Cc: Bibo Mao <maobibo@loongson.cn>
> > > > > Signed-off-by: xianglai li <lixianglai@loongson.cn>
> > > > > ---
> > > > >  hw/acpi/cpu.c         | 20 +++++++++++++++-----
> > > > >  hw/i386/acpi-build.c  |  3 ++-
> > > > >  include/hw/acpi/cpu.h |  5 +++--
> > > > >  3 files changed, 20 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> > > > > index 5bad983928..0afa04832e 100644
> > > > > --- a/hw/acpi/cpu.c
> > > > > +++ b/hw/acpi/cpu.c
> > > > > @@ -6,6 +6,7 @@
> > > > >  #include "qapi/qapi-events-acpi.h"
> > > > >  #include "trace.h"
> > > > >  #include "sysemu/numa.h"
> > > > > +#include "hw/acpi/cpu_hotplug.h"
> > > > >
> > > > >  #define OVMF_CPUHP_SMI_CMD 4
> > > > >
> > > > > @@ -332,9 +333,10 @@ const VMStateDescription vmstate_cpu_hotplug=
 =3D
> {
> > > > >  #define CPU_FW_EJECT_EVENT "CEJF"
> > > > >
> > > > >  void build_cpus_aml(Aml *table, MachineState *machine,
> > > CPUHotplugFeatures
> > > > > opts,
> > > > > -                    build_madt_cpu_fn build_madt_cpu, hwaddr
> io_base,
> > > > > +                    build_madt_cpu_fn build_madt_cpu, hwaddr
> > > mmap_io_base,
> > > > >                      const char *res_root,
> > > > > -                    const char *event_handler_method)
> > > > > +                    const char *event_handler_method,
> > > > > +                    AmlRegionSpace rs)
> > > > >  {
> > > > >      Aml *ifctx;
> > > > >      Aml *field;
> > > > > @@ -359,14 +361,22 @@ void build_cpus_aml(Aml *table, MachineStat=
e
> > > > > *machine, CPUHotplugFeatures opts,
> > > > >          aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
> > > > >
> > > > >          crs =3D aml_resource_template();
> > > > > -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1=
,
> > > > > +        if (rs =3D=3D AML_SYSTEM_IO) {
> > > > > +            aml_append(crs, aml_io(AML_DECODE16, mmap_io_base,
> > > > > mmap_io_base, 1,
> > > > >                                 ACPI_CPU_HOTPLUG_REG_LEN));
> > > > > +        } else {
> > > > > +            aml_append(crs, aml_memory32_fixed(mmap_io_base,
> > > > > +                               ACPI_CPU_HOTPLUG_REG_LEN,
> > > AML_READ_WRITE));
> > > > > +        }
> > > > > +
> > > > >          aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
> > > > >
> > > > > +        g_assert(rs =3D=3D AML_SYSTEM_IO || rs =3D=3D AML_SYSTEM=
_MEMORY);
> > > > >          /* declare CPU hotplug MMIO region with related access
> fields
> > > */
> > > > >          aml_append(cpu_ctrl_dev,
> > > > > -            aml_operation_region("PRST", AML_SYSTEM_IO,
> > > aml_int(io_base),
> > > > > -                                 ACPI_CPU_HOTPLUG_REG_LEN));
> > > > > +            aml_operation_region("PRST", rs,
> > > > > +                                         aml_int(mmap_io_base),
> > > > > +
> ACPI_CPU_HOTPLUG_REG_LEN));
> > > > >
> > > > >          field =3D aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
> > > > >                            AML_WRITE_AS_ZEROS);
> > > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > > > index 863a939210..7016205d15 100644
> > > > > --- a/hw/i386/acpi-build.c
> > > > > +++ b/hw/i386/acpi-build.c
> > > > > @@ -1550,7 +1550,8 @@ build_dsdt(GArray *table_data, BIOSLinker
> > > *linker,
> > > > >              .fw_unplugs_cpu =3D pm->smi_on_cpu_unplug,
> > > > >          };
> > > > >          build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
> > > > > -                       pm->cpu_hp_io_base, "\\_SB.PCI0",
> > > "\\_GPE._E02");
> > > > > +                       pm->cpu_hp_io_base, "\\_SB.PCI0",
> > > "\\_GPE._E02",
> > > > > +                       AML_SYSTEM_IO);
> > > > >      }
> > > > >
> > > > >      if (pcms->memhp_io_base && nr_mem) {
> > > > > diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> > > > > index bc901660fb..601f644e57 100644
> > > > > --- a/include/hw/acpi/cpu.h
> > > > > +++ b/include/hw/acpi/cpu.h
> > > > > @@ -60,9 +60,10 @@ typedef void (*build_madt_cpu_fn)(int uid, con=
st
> > > > > CPUArchIdList *apic_ids,
> > > > >                                    GArray *entry, bool
> force_enabled);
> > > > >
> > > > >  void build_cpus_aml(Aml *table, MachineState *machine,
> > > CPUHotplugFeatures
> > > > > opts,
> > > > > -                    build_madt_cpu_fn build_madt_cpu, hwaddr
> io_base,
> > > > > +                    build_madt_cpu_fn build_madt_cpu, hwaddr
> > > mmap_io_base,
> > > > >                      const char *res_root,
> > > > > -                    const char *event_handler_method);
> > > > > +                    const char *event_handler_method,
> > > > > +                    AmlRegionSpace rs);
> > > > >
> > > > >  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoLi=
st
> > > > > ***list);
> > > > >
> > > > > --
> > > > > 2.39.1
> > > > >
> > > >


