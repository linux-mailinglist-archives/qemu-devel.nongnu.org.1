Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 126607B6836
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qndo9-0004Ea-FT; Tue, 03 Oct 2023 07:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndo6-0004Dm-Lo; Tue, 03 Oct 2023 07:43:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndo4-0005nT-4b; Tue, 03 Oct 2023 07:43:18 -0400
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0GB81s8xz6K6Ds;
 Tue,  3 Oct 2023 19:41:36 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 3 Oct 2023 12:43:11 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 3 Oct 2023 12:43:11 +0100
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
Subject: RE: [PATCH V2 06/10] hw/acpi: Update GED _EVT method AML with cpu scan
Thread-Topic: [PATCH V2 06/10] hw/acpi: Update GED _EVT method AML with cpu
 scan
Thread-Index: AQHZ8zQk6MAP2ANe7ES6Fefhb3Wj6LA2n9eAgAFUrJA=
Date: Tue, 3 Oct 2023 11:43:11 +0000
Message-ID: <ed93b18d03ef44c5b37815449bdc10c3@huawei.com>
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-7-salil.mehta@huawei.com>
 <20231002171423.00003c39@Huawei.com>
In-Reply-To: <20231002171423.00003c39@Huawei.com>
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
> Sent: Monday, October 2, 2023 5:14 PM
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
> Subject: Re: [PATCH V2 06/10] hw/acpi: Update GED _EVT method AML with cp=
u
> scan
>=20
> On Sat, 30 Sep 2023 01:19:29 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>=20
> > OSPM evaluates _EVT method to map the event. The cpu hotplug event even=
tually
> > results in start of the cpu scan. Scan figures out the cpu and the kind=
 of
> > event(plug/unplug) and notifies it back to the guest.
> >
> > The change in this patch updates the GED AML _EVT method with the call =
to
> > \\_SB.CPUS.CSCN which will do above.
> >
> > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> One trivial suggested addition inline (dropping existing definition that =
this
> replicates). With that tidied up
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks
Salil.

>=20
> > ---
> >  hw/acpi/generic_event_device.c | 4 ++++
> >  include/hw/acpi/cpu_hotplug.h  | 2 ++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/hw/acpi/generic_event_device.c
> b/hw/acpi/generic_event_device.c
> > index d2fa1d0e4a..62d504d231 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -108,6 +108,10 @@ void build_ged_aml(Aml *table, const char *name,
> HotplugHandler *hotplug_dev,
> >                  aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER
> "."
> >                                               MEMORY_SLOT_SCAN_METHOD))=
;
> >                  break;
> > +            case ACPI_GED_CPU_HOTPLUG_EVT:
> > +                aml_append(if_ctx, aml_call0(ACPI_CPU_CONTAINER "."
> > +                                             ACPI_CPU_SCAN_METHOD));
> > +                break;
> >              case ACPI_GED_PWR_DOWN_EVT:
> >                  aml_append(if_ctx,
> >
> aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
> > diff --git a/include/hw/acpi/cpu_hotplug.h
> b/include/hw/acpi/cpu_hotplug.h
> > index 48b291e45e..ef631750b4 100644
> > --- a/include/hw/acpi/cpu_hotplug.h
> > +++ b/include/hw/acpi/cpu_hotplug.h
> > @@ -20,6 +20,8 @@
> >  #include "hw/acpi/cpu.h"
> >
> >  #define ACPI_CPU_HOTPLUG_REG_LEN 12
> > +#define ACPI_CPU_SCAN_METHOD "CSCN"
>=20
> This seems to already be defined in hw/acpi/cpu.c
> Can we drop it from there given that file now includes this
> header anyway.

Perhaps I can assign this to the macro in the hw/acpi/cpu.c?

Thanks
Salil.

