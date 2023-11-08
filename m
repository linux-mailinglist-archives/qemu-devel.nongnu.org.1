Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D067E54A1
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:59:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0gGn-00013F-KD; Wed, 08 Nov 2023 05:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1r0gGl-00012q-4Y; Wed, 08 Nov 2023 05:58:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1r0gGi-0004jP-9j; Wed, 08 Nov 2023 05:58:46 -0500
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SQMRp5CdBz67XhB;
 Wed,  8 Nov 2023 18:55:02 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 8 Nov 2023 10:58:31 +0000
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Wed, 8 Nov 2023 10:58:31 +0000
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
Subject: RE: [PATCH V6 7/9] hw/acpi: Update ACPI GED framework to support vCPU
 Hotplug
Thread-Topic: [PATCH V6 7/9] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Thread-Index: AQHZ/cOYufqPrPRhXUanC39HFNBrArBdo9oAgA/gD4A=
Date: Wed, 8 Nov 2023 10:58:30 +0000
Message-ID: <950b9f911fb341dca81ceeaeab6c50b3@huawei.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <20231013105129.25648-8-salil.mehta@huawei.com>
 <20231027151828.5c9d499b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231027151828.5c9d499b@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.122]
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

> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Friday, October 27, 2023 2:18 PM
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
> Subject: Re: [PATCH V6 7/9] hw/acpi: Update ACPI GED framework to support
> vCPU Hotplug
>=20
> On Fri, 13 Oct 2023 11:51:27 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>=20
> > ACPI GED shall be used to convey to the guest kernel about any CPU hot-=
(un)plug
> > events. Therefore, existing ACPI GED framework inside QEMU needs to be =
enhanced
> > to support CPU hotplug state and events.
> >
>=20
> This is a part of hw wiring which you started to introduce in 4/9
> Given patches are small, I'd merge this into 4/9 to avoid broken context.
> So essentially GED improvement would consist from hw and aml parts.
> with some extra refactoring (5/9) in a separate patch.


No issues. Will merge.

Thanks
Salil.

> > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Xianglai Li <lixianglai@loongson.cn>
> > ---
> >  hw/acpi/generic_event_device.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_dev=
ice.c
> > index 62d504d231..0d5f0140e5 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -12,6 +12,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> >  #include "hw/acpi/acpi.h"
> > +#include "hw/acpi/cpu.h"
> >  #include "hw/acpi/generic_event_device.h"
> >  #include "hw/irq.h"
> >  #include "hw/mem/pc-dimm.h"
> > @@ -239,6 +240,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler =
*hotplug_dev,
> >          } else {
> >              acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, err=
p);
> >          }
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
> >      } else {
> >          error_setg(errp, "virt: device plug request for unsupported de=
vice"
> >                     " type: %s", object_get_typename(OBJECT(dev)));
> > @@ -253,6 +256,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandl=
er *hotplug_dev,
> >      if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
> >                         !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)=
))) {
> >          acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, de=
v, errp);
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > +        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, =
errp);
> >      } else {
> >          error_setg(errp, "acpi: device unplug request for unsupported =
device"
> >                     " type: %s", object_get_typename(OBJECT(dev)));
> > @@ -266,6 +271,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotp=
lug_dev,
> >
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >          acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > +        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
> >      } else {
> >          error_setg(errp, "acpi: device unplug for unsupported device"
> >                     " type: %s", object_get_typename(OBJECT(dev)));
> > @@ -277,6 +284,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev=
, ACPIOSTInfoList ***list)
> >      AcpiGedState *s =3D ACPI_GED(adev);
> >
> >      acpi_memory_ospm_status(&s->memhp_state, list);
> > +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
> >  }
> >
> >  static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBit=
s ev)
> > @@ -291,6 +299,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev,=
 AcpiEventStatusBits ev)
> >          sel =3D ACPI_GED_PWR_DOWN_EVT;
> >      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
> >          sel =3D ACPI_GED_NVDIMM_HOTPLUG_EVT;
> > +    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> > +        sel =3D ACPI_GED_CPU_HOTPLUG_EVT;
> >      } else {
> >          /* Unknown event. Return without generating interrupt. */
> >          warn_report("GED: Unsupported event %d. No irq injected", ev);


