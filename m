Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17305A1227E
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Jan 2025 12:24:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY1Tt-0006BR-S4; Wed, 15 Jan 2025 06:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tY1Tq-0006AL-MP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 06:22:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tY1Tn-0002iG-Ff
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 06:22:38 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YY3PH2yZHz6K8qn;
 Wed, 15 Jan 2025 19:17:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 67979140B35;
 Wed, 15 Jan 2025 19:22:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 15 Jan
 2025 12:22:18 +0100
Date: Wed, 15 Jan 2025 11:22:14 +0000
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fan Ni
 <fan.ni@samsung.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Message-ID: <20250115112214.0000550f@huawei.com>
In-Reply-To: <4d4a138f-4648-4733-933b-02cd8d934699@fujitsu.com>
References: <20241213093602.3248246-1-lizhijian@fujitsu.com>
 <20250110154432.000031b0@huawei.com>
 <4d4a138f-4648-4733-933b-02cd8d934699@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.794, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 15 Jan 2025 07:48:59 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 10/01/2025 23:44, Jonathan Cameron wrote:
> > On Fri, 13 Dec 2024 17:36:02 +0800
> > Li Zhijian <lizhijian@fujitsu.com> wrote:
> >   
> >> This assertion always happens when we sanitize the CXL memory device.
> >> $ echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> >>
> >> It is incorrect to register an MSIX number beyond the device's capability.
> >>
> >> Expand the device's MSIX number and use the enum to maintain the *USED*
> >> and MAX MSIX number
> >>
> >> Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >> ---
> >> V2: just increase msix number and add enum to maintainer their values #
> >> Jonathan  
> > 
> > Ah. Sorry I was unclear. Two patches please
> > 
> > 1. Make the number bigger to fix the bug. Only this one gets a fixes tag and
> >     is suitable for backporting.
> > 
> > 2. Add an enum including all numbers currently used and use that throughout the
> >     type3 related code. That will prevent use accidentally introducing the
> >     bug in future but doesn't need to be backported.
> >     
> 
> Understood, it make sense.
> 
> 
> 
> > A few other comments inline.
> > 
> > Thanks
> > 
> > Jonathan
> >   
> >> ---
> >>   hw/cxl/cxl-device-utils.c   |  6 ++----
> >>   hw/mem/cxl_type3.c          | 10 +++++-----
> >>   include/hw/cxl/cxl_device.h |  7 +++++++
> >>   3 files changed, 14 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> >> index 035d034f6d..bc2171e3d4 100644
> >> --- a/hw/cxl/cxl-device-utils.c
> >> +++ b/hw/cxl/cxl-device-utils.c
> >> @@ -354,8 +354,6 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
> >>   
> >>   static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
> >>   {
> >> -    const uint8_t msi_n = 9;
> >> -
> >>       /* 2048 payload size */
> >>       ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> >>                        PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
> >> @@ -364,8 +362,8 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
> >>       ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> >>                        BG_INT_CAP, 1);
> >>       ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> >> -                     MSI_N, msi_n);
> >> -    cxl_dstate->mbox_msi_n = msi_n;
> >> +                     MSI_N, CXL_MSIX_MBOX);  
> > 
> > Should be passed in from the type 3 specific call so add a parameter to this
> > function and pass this from cxl_device_register_init_t3.
> > Even better pass it into there from ct3d_reset()
> >   
> 
> At a glance, `ct3d_reset()` has the following prototype: `typedef void (*DeviceReset)(DeviceState *dev)`,
> which is inherited from the QEMU device framework. Consequently, it is hard to extend `ct3d_reset()`
> to include an additional parameter.

I wasn't clear in that statement.   ct3d_reset() calls cxl_device_register_init_t3(). Change
the signature of cxl_device_register_init_t3() so that takes the appropriate MSI index.
that puts the source of the information in the cxl_type3.c code, not the core support in hw / CXL.
No change to ct3d_reset() signature needed.

> 
> 
> 
> > Will potentially be a different number for the switch CCI passed in from
> > the call of cxl_device_register_init_swcci() in switch-mailbox-cci.c  
> 
> It sounds reasonable, offering a more flexible design for the future.
> 
> Currently, mailbox_reg_init_common() will be called from type3 device and swcci,
> however, I didn't see any where the swcci itself have setup the msi/msix at all.
> 
> Is this expected, feel free to let me know if I'm missing something.
Currently that is in cxl_device_register_init_swcci() via
mailbox_reg_init_common()
Suggestion is to like the above type 3 case move it into the specific driver
by having cxl_device_register_init_swcci() take it as a parameter and
pass that in from cswmbcci_reset() in switch-mailbox-cci.c


> 
> > 
> >   
> >> +    cxl_dstate->mbox_msi_n = CXL_MSIX_MBOX;
> >>       ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> >>                        MBOX_READY_TIME, 0); /* Not reported */
> >>       ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> >> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> >> index 5cf754b38f..f2f060ed9e 100644
> >> --- a/hw/mem/cxl_type3.c
> >> +++ b/hw/mem/cxl_type3.c
> >> @@ -843,7 +843,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> >>       ComponentRegisters *regs = &cxl_cstate->crb;
> >>       MemoryRegion *mr = &regs->component_registers;
> >>       uint8_t *pci_conf = pci_dev->config;
> >> -    unsigned short msix_num = 6;
> >>       int i, rc;
> >>       uint16_t count;
> >>   
> >> @@ -884,16 +883,17 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> >>                        &ct3d->cxl_dstate.device_registers);
> >>   
> >>       /* MSI(-X) Initialization */
> >> -    rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
> >> +    rc = msix_init_exclusive_bar(pci_dev, CXL_MSIX_MAX, 4, NULL);
> >>       if (rc) {
> >>           goto err_address_space_free;
> >>       }
> >> -    for (i = 0; i < msix_num; i++) {
> >> +    for (i = 0; i < CXL_MSIX_MAX; i++) {
> >>           msix_vector_use(pci_dev, i);
> >>       }
> >>   
> >>       /* DOE Initialization */
> >> -    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
> >> +    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
> >> +                  CXL_MSIX_PCIE_DOE);
> >>   
> >>       cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
> >>       cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
> >> @@ -908,7 +908,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> >>       if (rc) {
> >>           goto err_release_cdat;
> >>       }
> >> -    cxl_event_init(&ct3d->cxl_dstate, 2);
> >> +    cxl_event_init(&ct3d->cxl_dstate, CXL_MSIX_EVENT_START);
> >>   
> >>       /* Set default value for patrol scrub attributes */
> >>       ct3d->patrol_scrub_attrs.scrub_cycle_cap =
> >> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> >> index 561b375dc8..3f89b041ce 100644
> >> --- a/include/hw/cxl/cxl_device.h
> >> +++ b/include/hw/cxl/cxl_device.h
> >> @@ -133,6 +133,13 @@ typedef enum {
> >>       CXL_MBOX_MAX = 0x20
> >>   } CXLRetCode;
> >>   
> >> +enum {  
> > 
> > Maybe worth naming these to be type3 specific.  
> 
> It sounds good to me.
> 
> 
> >   
> >> +    CXL_MSIX_PCIE_DOE = 0,  
> > Name it to include that this is specifically the DOE for the table access protocol.
> > 
> >     CXL_MSIX_PCIE_DOE_TABLE_ACCESS  
> 
> make sense.
> 
> 
> > 
> > 
> > This should be private to cxl_type3.c which should be possible by passing
> > it to a few more calls from there.
> >   
> 
> If we make the entire enumeration `cxl_type3` private, it appears unnecessary to pass it through several more calls.

Key is to make sure it is in cxl_type3.c  For that to work you need to pass it as
described above so that we can set the relevant values in various registers
configured by the hw/cxl/* code.

> 
> How about this
> 
> +/* type3 device private */
> +enum CXL_T3_MSIX_VECTOR {
> +    CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS = 0,

What is on 1?  We don't need to maintain backwards compatibility (migration
is broken in lots of other ways and not high on priority list to fix) so should
be no need to skip it. If you really want to add a reserved entry and we will
fill it in later.

> +    CXL_T3_MSIX_EVENT_START = 2,
> +    CXL_T3_MSIX_MBOX = CXL_T3_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
> +    CXL_T3_MSIX_VECTOR_NR
> +};
> +
> 
Hope that helps,

Jonathan

> 
> Thanks
> Zhijian
> 
> >> +    CXL_MSIX_EVENT_START = 2,
> >> +    CXL_MSIX_MBOX = CXL_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
> >> +    CXL_MSIX_MAX
> >> +};
> >> +
> >>   typedef struct CXLCCI CXLCCI;
> >>   typedef struct cxl_device_state CXLDeviceState;
> >>   struct cxl_cmd;  
> >  


