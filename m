Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E757B67F0
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:32:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qndd5-0005C4-Io; Tue, 03 Oct 2023 07:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndcy-0005AR-D6; Tue, 03 Oct 2023 07:31:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndcw-0003Mw-ET; Tue, 03 Oct 2023 07:31:48 -0400
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0Fvf1xNCz6H8xS;
 Tue,  3 Oct 2023 19:29:02 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 3 Oct 2023 12:31:42 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 3 Oct 2023 12:31:42 +0100
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
Subject: RE: [PATCH V2 05/10] hw/acpi: Update CPUs AML with cpu-(ctrl)dev
 change
Thread-Topic: [PATCH V2 05/10] hw/acpi: Update CPUs AML with cpu-(ctrl)dev
 change
Thread-Index: AQHZ8zQYC4/+Jpm3GUq+5/2Z200pcbA2npYAgAFVDEA=
Date: Tue, 3 Oct 2023 11:31:41 +0000
Message-ID: <714adebf61184e439f1f5c331d90b1c2@huawei.com>
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-6-salil.mehta@huawei.com>
 <20231002170954.000016ba@Huawei.com>
In-Reply-To: <20231002170954.000016ba@Huawei.com>
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

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: Monday, October 2, 2023 5:10 PM
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
> Subject: Re: [PATCH V2 05/10] hw/acpi: Update CPUs AML with cpu-(ctrl)dev
> change
>=20
> On Sat, 30 Sep 2023 01:19:28 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>=20
> > CPUs Control device(\\_SB.PCI0) register interface for the x86 arch is =
based on
> > PCI and is IO port based and hence existing cpus AML code assumes _CRS =
objects
> > would evaluate to a system resource which describes IO Port address. Bu=
t on ARM
> > arch CPUs control device(\\_SB.PRES) register interface is memory-mappe=
d hence
> > _CRS object should evaluate to system resource which describes memory-m=
apped
> > base address.
> >
> > This cpus AML code change updates the existing inerface of the build cp=
us AML
> > function to accept both IO/MEMORY type regions and update the _CRS obje=
ct
> > correspondingly.
>=20
> This also makes a change to make the event_handler_method optional.
> Would be good to explain why or leave that for a future patch.

Will add.

Thanks
Salil.


>=20
> Otherwise looks fine.
>=20
> >
> > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> >  hw/acpi/cpu.c         | 23 ++++++++++++++++-------
> >  hw/i386/acpi-build.c  |  2 +-
> >  include/hw/acpi/cpu.h |  5 +++--
> >  3 files changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> > index 45defdc0e2..66a71660ec 100644
> > --- a/hw/acpi/cpu.c
> > +++ b/hw/acpi/cpu.c
> > @@ -338,9 +338,10 @@ const VMStateDescription vmstate_cpu_hotplug =3D {
> >  #define CPU_FW_EJECT_EVENT "CEJF"
> >
> >  void build_cpus_aml(Aml *table, MachineState *machine,
> CPUHotplugFeatures opts,
> > -                    hwaddr io_base,
> > +                    hwaddr base_addr,
> >                      const char *res_root,
> > -                    const char *event_handler_method)
> > +                    const char *event_handler_method,
> > +                    AmlRegionSpace rs)
> >  {
> >      Aml *ifctx;
> >      Aml *field;
> > @@ -367,13 +368,19 @@ void build_cpus_aml(Aml *table, MachineState
> *machine, CPUHotplugFeatures opts,
> >          aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
> >
> >          crs =3D aml_resource_template();
> > -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
> > +        if (rs =3D=3D AML_SYSTEM_IO) {
> > +            aml_append(crs, aml_io(AML_DECODE16, base_addr, base_addr,
> 1,
> >                                 ACPI_CPU_HOTPLUG_REG_LEN));
> > +        } else {
> > +            aml_append(crs, aml_memory32_fixed(base_addr,
> > +                               ACPI_CPU_HOTPLUG_REG_LEN,
> AML_READ_WRITE));
> > +        }
> > +
> >          aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
> >
> >          /* declare CPU hotplug MMIO region with related access fields =
*/
> >          aml_append(cpu_ctrl_dev,
> > -            aml_operation_region("PRST", AML_SYSTEM_IO,
> aml_int(io_base),
> > +            aml_operation_region("PRST", rs, aml_int(base_addr),
> >                                   ACPI_CPU_HOTPLUG_REG_LEN));
> >
> >          field =3D aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
> > @@ -699,9 +706,11 @@ void build_cpus_aml(Aml *table, MachineState
> *machine, CPUHotplugFeatures opts,
> >      aml_append(sb_scope, cpus_dev);
> >      aml_append(table, sb_scope);
> >
> > -    method =3D aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> > -    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> > -    aml_append(table, method);
> > +    if (event_handler_method) {
> > +        method =3D aml_method(event_handler_method, 0, AML_NOTSERIALIZ=
ED);
> > +        aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> > +        aml_append(table, method);
> > +    }
> >
> >      g_free(cphp_res_path);
> >  }
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 4d2d40bab5..611d3d044d 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1550,7 +1550,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >              .fw_unplugs_cpu =3D pm->smi_on_cpu_unplug,
> >          };
> >          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
> > -                       "\\_SB.PCI0", "\\_GPE._E02");
> > +                       "\\_SB.PCI0", "\\_GPE._E02", AML_SYSTEM_IO);
> >      }
> >
> >      if (pcms->memhp_io_base && nr_mem) {
> > diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> > index 999caaf510..b87ebfdf4b 100644
> > --- a/include/hw/acpi/cpu.h
> > +++ b/include/hw/acpi/cpu.h
> > @@ -56,9 +56,10 @@ typedef struct CPUHotplugFeatures {
> >  } CPUHotplugFeatures;
> >
> >  void build_cpus_aml(Aml *table, MachineState *machine,
> CPUHotplugFeatures opts,
> > -                    hwaddr io_base,
> > +                    hwaddr base_addr,
> >                      const char *res_root,
> > -                    const char *event_handler_method);
> > +                    const char *event_handler_method,
> > +                    AmlRegionSpace rs);
> >
> >  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList
> ***list);
> >


