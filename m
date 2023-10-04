Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C5E7B7C3D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:36:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnyI0-000220-D9; Wed, 04 Oct 2023 05:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qnyHw-000210-Tu
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:35:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qnyHu-00048e-1r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:35:28 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0qGv2bdrz6D8Wk;
 Wed,  4 Oct 2023 17:32:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 4 Oct
 2023 10:35:21 +0100
Date: Wed, 4 Oct 2023 10:35:20 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
 <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 2/3] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <20231004103520.00003425@Huawei.com>
In-Reply-To: <20231004045943-mutt-send-email-mst@kernel.org>
References: <20230904161847.18468-1-Jonathan.Cameron@huawei.com>
 <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
 <20231004045943-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 4 Oct 2023 05:04:31 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Sep 04, 2023 at 05:18:46PM +0100, Jonathan Cameron wrote:
> > From: Dave Jiang <dave.jiang@intel.com>
> > 
> > Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
> > ID value of 0 in all cases. The enabling is for _DSM plumbing testing
> > from the OS.
> > 
> > Following edited for readbility only
> > 
> > Device (CXLM)
> > {
> >     Name (_HID, "ACPI0017")  // _HID: Hardware ID
> > ...
> >     Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
> >     {
> >         If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
> >         {
> >             If ((Arg2 == Zero))
> >             {
> >                 Return (Buffer (One) { 0x01 })
> >             }
> > 
> >             If ((Arg2 == One))
> >             {
> >                 Return (Package (0x02)
> >                 {
> >                     Buffer (0x02)
> >                     { 0x01, 0x00 },
> >                     Package (0x01)
> >                     {
> >                         Buffer (0x02)
> >                         { 0x00, 0x00 }
> >                     }
> >                 })
> >             }
> >         }
> >     }
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > --
> > v2: Minor edit to drop reference to switches in patch description.
> > ---  
> 
> >  include/hw/acpi/cxl.h |  1 +
> >  hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
> >  hw/i386/acpi-build.c  |  1 +
> >  3 files changed, 59 insertions(+)  
> 
> 
> This is not the right way to format it. The correct way is:
> 
> ---
> v2: Minor edit to drop reference to switches in patch description.
> 
>  include/hw/acpi/cxl.h |  1 +
>  hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c  |  1 +
>  3 files changed, 59 insertions(+)
> 
> The way you do it breaks b4 and a bunch of other tools.  signatures must
> come last before ---, then versioning info (which generally does not
> need to be in git because readers of git have no access to older
> versions, though there could be exceptions. If there's anything relevant
> in this versioning history, such as some design directions which were
> tried and discarded, then put it above ---). Then the diff.

Sorry, typo. I believe b4 and git am are also fine with what was intended
here.

---
v2: xxx
---

stats

which has advantage that you can track the change log easily in a git tree
as things evolve rather than a bunch of hand editing of patches to add
this stuff in at time of send.

I'll be more careful to check for errors like this in future.

Thanks for fixing it up and sorry for the waste of your time!

Jonathan



> 
> 
> > 
> > diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> > index acf4418886..8f22c71530 100644
> > --- a/include/hw/acpi/cxl.h
> > +++ b/include/hw/acpi/cxl.h
> > @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
> >                      BIOSLinker *linker, const char *oem_id,
> >                      const char *oem_table_id, CXLState *cxl_state);
> >  void build_cxl_osc_method(Aml *dev);
> > +void build_cxl_dsm_method(Aml *dev);
> >  
> >  #endif
> > diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> > index 92b46bc932..5e9039785a 100644
> > --- a/hw/acpi/cxl.c
> > +++ b/hw/acpi/cxl.c
> > @@ -30,6 +30,63 @@
> >  #include "qapi/error.h"
> >  #include "qemu/uuid.h"
> >  
> > +void build_cxl_dsm_method(Aml *dev)
> > +{
> > +    Aml *method, *ifctx, *ifctx2;
> > +
> > +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> > +    {
> > +        Aml *function, *uuid;
> > +
> > +        uuid = aml_arg(0);
> > +        function = aml_arg(2);
> > +        /* CXL spec v3.0 9.17.3.1 *, QTG ID _DSM */
> > +        ifctx = aml_if(aml_equal(
> > +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
> > +
> > +        /* Function 0, standard DSM query function */
> > +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
> > +        {
> > +            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
> > +
> > +            aml_append(ifctx2,
> > +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
> > +        }
> > +        aml_append(ifctx, ifctx2);
> > +
> > +        /*
> > +         * Function 1
> > +         * A return value of {1, {0}} inciate that
> > +         * max supported QTG ID of 1 and recommended QTG is 0.
> > +         * The values here are faked to simplify emulation.
> > +         */
> > +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
> > +        {
> > +            uint16_t word_list[1] = { 0x01 };
> > +            uint16_t word_list2[1] = { 0 };
> > +            uint8_t *byte_list = (uint8_t *)word_list;
> > +            uint8_t *byte_list2 = (uint8_t *)word_list2;
> > +            Aml *pak, *pak1;
> > +
> > +            /*
> > +             * The return package is a package of a WORD and another package.
> > +             * The embedded package contains 0 or more WORDs for the
> > +             * recommended QTG IDs.
> > +             */
> > +            pak1 = aml_package(1);
> > +            aml_append(pak1, aml_buffer(sizeof(uint16_t), byte_list2));
> > +            pak = aml_package(2);
> > +            aml_append(pak, aml_buffer(sizeof(uint16_t), byte_list));
> > +            aml_append(pak, pak1);
> > +
> > +            aml_append(ifctx2, aml_return(pak));
> > +        }
> > +        aml_append(ifctx, ifctx2);
> > +    }
> > +    aml_append(method, ifctx);
> > +    aml_append(dev, method);
> > +}
> > +
> >  static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
> >  {
> >      PXBDev *pxb = PXB_DEV(cxl);
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index bb12b0ad43..d3bc5875eb 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1422,6 +1422,7 @@ static void build_acpi0017(Aml *table)
> >      method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> >      aml_append(method, aml_return(aml_int(0x01)));
> >      aml_append(dev, method);
> > +    build_cxl_dsm_method(dev);
> >  
> >      aml_append(scope, dev);
> >      aml_append(table, scope);
> > -- 
> > 2.39.2  
> 


