Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E42678D6CE
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMkA-0006TZ-Gl; Wed, 30 Aug 2023 11:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qbMk7-0006P3-Un
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:04:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qbMk3-0003Ox-Q5
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:04:27 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbSGW5nDwz67Ph9;
 Wed, 30 Aug 2023 23:03:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 16:04:18 +0100
Date: Wed, 30 Aug 2023 16:04:17 +0100
To: Fan Ni <fan.ni@gmx.us>
CC: Fan Ni <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "gregory.price@memverge.com"
 <gregory.price@memverge.com>, "hchkuo@avery-design.com.tw"
 <hchkuo@avery-design.com.tw>, "cbrowy@avery-design.com"
 <cbrowy@avery-design.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Adam Manzanares
 <a.manzanares@samsung.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>, "nifan@outlook.com"
 <nifan@outlook.com>
Subject: Re: [Qemu PATCH v2 9/9] hw/mem/cxl_type3: Add dpa range validation
 for accesses to dc regions
Message-ID: <20230830160417.000060d3@Huawei.com>
In-Reply-To: <ZOjYKq+vDMIdFEl7@debian>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p2ca5293c7229ab989ad1a2d95395436a6@uscas1p2.samsung.com>
 <20230725183939.2741025-10-fan.ni@samsung.com>
 <20230807095342.00006f88@Huawei.com> <ZOfCPADXcYMGIGC4@debian>
 <20230825124256.0000604c@Huawei.com> <ZOjYKq+vDMIdFEl7@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 25 Aug 2023 09:34:50 -0700
Fan Ni <fan.ni@gmx.us> wrote:

> On Fri, Aug 25, 2023 at 12:42:56PM +0100, Jonathan Cameron wrote:
> > On Thu, 24 Aug 2023 13:49:00 -0700
> > Fan Ni <fan.ni@gmx.us> wrote:
> >  
> > > On Mon, Aug 07, 2023 at 09:53:42AM +0100, Jonathan Cameron wrote:  
> > > > On Tue, 25 Jul 2023 18:39:56 +0000
> > > > Fan Ni <fan.ni@samsung.com> wrote:
> > > >  
> > > > > From: Fan Ni <nifan@outlook.com>
> > > > >
> > > > > Not all dpa range in the dc regions is valid to access until an extent
> > > > > covering the range has been added. Add a bitmap for each region to
> > > > > record whether a dc block in the region has been backed by dc extent.
> > > > > For the bitmap, a bit in the bitmap represents a dc block. When a dc
> > > > > extent is added, all the bits of the blocks in the extent will be set,
> > > > > which will be cleared when the extent is released.
> > > > >
> > > > > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
> > > > Hi Fan,
> > > >
> > > > A few of the bits of feedback apply broadly across the series.  Given I'm
> > > > rebasing this anyway to give myself something to test I'll tidy things up
> > > > (feel free to disagree with and revert any changes !)
> > > > and push a tree out in next day or two.  I'll message when I've done so.
> > > >
> > > > Jonathan  
> > >
> > > Hi Jonathan,
> > > I tried DCD with your branch "cxl-2023-08-07", and noticed the
> > > following,
> > > 1. You made some changes to the bitmap functionality, now it is only
> > > used to validate extents when adding/releasing dc extents. My original
> > > thought of adding the bitmap is to 1) validating extents for extent
> > > add/release as you do; 2) Add validating when doing read/write to the dc
> > > regions since some address region may not have valid extent added yet.
> > > Do you think 2) is not necessary?  
> >
> > Change wasn't intentional. I probably just messed up the rebase!  
> 
> Just double checked the code. The logic is still there, but in another
> patch in the series, so no issue and ignore my previous question.
> Sorry for the confusion.
> 
> >  
> > >
> > > 2. Your change introduced a bug in the code.
> > > https://gitlab.com/jic23/qemu/-/blob/cxl-2023-08-07/hw/cxl/cxl-mailbox-utils.c?ref_type=heads#L1394
> > > ct3d->dc.num_regions should be ct3d->dc.num_regions-1.  
> > Thanks.  Given I might forget about about it, if you want to incorporate that in
> > your next version that would be great. I might remember to fix it in the meantime!
Oops. I'll tiddy that up in my tree. 
> >
> > Jonathan
> >  
> 
> My code does not have this. It seems you added the lastregion variable
> to record the last region, while I use the following logic to iterate
> the regions and record last region automatically while collecting
> min_block_size.
> 
> +    for (i = 1; i < dev->dc.num_regions; i++) {
> +        region = &dev->dc.regions[i];
> +        if (min_block_size > region->block_size) {
> +            min_block_size = region->block_size;
> +        }
> +    }
> +
> +    blk_bitmap = bitmap_new((region->len + region->base
> +                - dev->dc.regions[0].base) / min_block_size);
Understood.  I found that hard to read (see review of patch 7).
I then messed up the cleanup as you've noted.

Jonathan
> 
> 
> Fan
> 
> > >
> > > Thanks,
> > > Fan
> > >  
> > > >  
> > > > > ---
> > > > >  hw/mem/cxl_type3.c          | 155 ++++++++++++++++++++++++++++++++++++
> > > > >  include/hw/cxl/cxl_device.h |   1 +
> > > > >  2 files changed, 156 insertions(+)
> > > > >
> > > > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > > > index 41a828598a..51943a36fc 100644
> > > > > --- a/hw/mem/cxl_type3.c
> > > > > +++ b/hw/mem/cxl_type3.c
> > > > > @@ -787,13 +787,37 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
> > > > >          /* dsmad_handle is set when creating cdat table entries */
> > > > >          region->flags = 0;
> > > > >
> > > > > +        region->blk_bitmap = bitmap_new(region->len / region->block_size);  
> > > >
> > > > In common with many allocators in qemu if this fails it calls abort()
> > > > internally so no need to handle potential errors.
> > > >  
> > > > > +        if (!region->blk_bitmap) {
> > > > > +            break;
> > > > > +        }
> > > > > +
> > > > >          region_base += region->len;
> > > > >      }
> > > > > +
> > > > > +    if (i < ct3d->dc.num_regions) {
> > > > > +        while (--i >= 0) {
> > > > > +            g_free(ct3d->dc.regions[i].blk_bitmap);
> > > > > +        }
> > > > > +        return -1;
> > > > > +    }
> > > > > +
> > > > >      QTAILQ_INIT(&ct3d->dc.extents);
> > > > >
> > > > >      return 0;
> > > > >  }
> > > > >
> > > > > +static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> > > > > +{
> > > > > +    int i;
> > > > > +    struct CXLDCD_Region *region;
> > > > > +
> > > > > +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> > > > > +        region = &ct3d->dc.regions[i];
> > > > > +        g_free(region->blk_bitmap);
> > > > > +    }
> > > > > +}
> > > > > +
> > > > >  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> > > > >  {
> > > > >      DeviceState *ds = DEVICE(ct3d);
> > > > > @@ -1021,6 +1045,7 @@ err_free_special_ops:
> > > > >      g_free(regs->special_ops);
> > > > >  err_address_space_free:
> > > > >      if (ct3d->dc.host_dc) {
> > > > > +        cxl_destroy_dc_regions(ct3d);
> > > > >          address_space_destroy(&ct3d->dc.host_dc_as);
> > > > >      }
> > > > >      if (ct3d->hostpmem) {
> > > > > @@ -1043,6 +1068,7 @@ static void ct3_exit(PCIDevice *pci_dev)
> > > > >      spdm_sock_fini(ct3d->doe_spdm.socket);
> > > > >      g_free(regs->special_ops);
> > > > >      if (ct3d->dc.host_dc) {
> > > > > +        cxl_destroy_dc_regions(ct3d);
> > > > >          address_space_destroy(&ct3d->dc.host_dc_as);
> > > > >      }
> > > > >      if (ct3d->hostpmem) {
> > > > > @@ -1053,6 +1079,110 @@ static void ct3_exit(PCIDevice *pci_dev)
> > > > >      }
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * This function will marked the dpa range [dpa, dap + len) to be backed and
> > > > > + * accessible, this happens when a dc extent is added and accepted by the
> > > > > + * host.
> > > > > + */
> > > > > +static void set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > > > > +        uint64_t len)
> > > > > +{
> > > > > +    int i;
> > > > > +    CXLDCD_Region *region = &ct3d->dc.regions[0];
> > > > > +
> > > > > +    if (dpa < region->base
> > > > > +            || dpa >= region->base + ct3d->dc.total_capacity)
> > > > > +        return;
> > > > > +
> > > > > +    /*
> > > > > +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
> > > > > +     * Region 0 being used for the lowest DPA of Dynamic Capacity and
> > > > > +     * Region 7 for the highest DPA.
> > > > > +     * So we check from the last region to find where the dpa belongs.
> > > > > +     * access across multiple regions is not allowed.
> > > > > +     **/
> > > > > +    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
> > > > > +        region = &ct3d->dc.regions[i];
> > > > > +        if (dpa >= region->base) {
> > > > > +            break;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
> > > > > +            len / region->block_size);
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * This function check whether a dpa range [dpa, dpa + len) has been backed
> > > > > + * with dc extents, used when validating read/write to dc regions
> > > > > + */
> > > > > +static bool test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > > > > +        uint64_t len)
> > > > > +{
> > > > > +    int i;
> > > > > +    CXLDCD_Region *region = &ct3d->dc.regions[0];
> > > > > +    uint64_t nbits;
> > > > > +    long nr;
> > > > > +
> > > > > +    if (dpa < region->base
> > > > > +            || dpa >= region->base + ct3d->dc.total_capacity)
> > > > > +        return false;
> > > > > +
> > > > > +    /*
> > > > > +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
> > > > > +     * Region 0 being used for the lowest DPA of Dynamic Capacity and
> > > > > +     * Region 7 for the highest DPA.
> > > > > +     * So we check from the last region to find where the dpa belongs.
> > > > > +     * access across multiple regions is not allowed.
> > > > > +     */
> > > > > +    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
> > > > > +        region = &ct3d->dc.regions[i];
> > > > > +        if (dpa >= region->base) {
> > > > > +            break;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    nr = (dpa - region->base) / region->block_size;
> > > > > +    nbits = len / region->block_size;
> > > > > +    return find_next_zero_bit(region->blk_bitmap, nbits, nr) >= nr + nbits;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * This function will marked the dpa range [dpa, dap + len) to be unbacked and
> > > > > + * inaccessible, this happens when a dc extent is added and accepted by the
> > > > > + * host.
> > > > > + */
> > > > > +static void clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > > > > +        uint64_t len)
> > > > > +{
> > > > > +    int i;
> > > > > +    CXLDCD_Region *region = &ct3d->dc.regions[0];
> > > > > +    uint64_t nbits;
> > > > > +    long nr;
> > > > > +
> > > > > +    if (dpa < region->base
> > > > > +            || dpa >= region->base + ct3d->dc.total_capacity)
> > > > > +        return;
> > > > > +
> > > > > +    /*
> > > > > +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
> > > > > +     * Region 0 being used for the lowest DPA of Dynamic Capacity and
> > > > > +     * Region 7 for the highest DPA.
> > > > > +     * So we check from the last region to find where the dpa belongs.
> > > > > +     * access across multiple regions is not allowed.
> > > > > +     */
> > > > > +    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
> > > > > +        region = &ct3d->dc.regions[i];
> > > > > +        if (dpa >= region->base) {
> > > > > +            break;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    nr = (dpa - region->base) / region->block_size;
> > > > > +    nbits = len / region->block_size;
> > > > > +    bitmap_clear(region->blk_bitmap, nr, nbits);
> > > > > +}
> > > > > +
> > > > >  static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
> > > > >  {
> > > > >      uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> > > > > @@ -1145,6 +1275,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> > > > >          *as = &ct3d->hostpmem_as;
> > > > >          *dpa_offset -= vmr_size;
> > > > >      } else {
> > > > > +        if (!test_region_block_backed(ct3d, *dpa_offset, size)) {
> > > > > +            return -ENODEV;
> > > > > +        }
> > > > > +
> > > > >          *as = &ct3d->dc.host_dc_as;
> > > > >          *dpa_offset -= (vmr_size + pmr_size);
> > > > >      }
> > > > > @@ -1944,6 +2078,27 @@ static void qmp_cxl_process_dynamic_capacity_event(const char *path,
> > > > >      }
> > > > >
> > > > >      g_free(extents);
> > > > > +
> > > > > +    /* Another choice is to do the set/clear after getting mailbox response*/
> > > > > +    list = records;
> > > > > +    while (list) {
> > > > > +        dpa = list->value->dpa * 1024 * 1024;
> > > > > +        len = list->value->len * 1024 * 1024;
> > > > > +        rid = list->value->region_id;
> > > > > +
> > > > > +        switch (type) {
> > > > > +        case DC_EVENT_ADD_CAPACITY:
> > > > > +            set_region_block_backed(dcd, dpa, len);
> > > > > +            break;
> > > > > +        case DC_EVENT_RELEASE_CAPACITY:
> > > > > +            clear_region_block_backed(dcd, dpa, len);
> > > > > +            break;
> > > > > +        default:
> > > > > +            error_setg(errp, "DC event type not handled yet");
> > > > > +            break;
> > > > > +        }
> > > > > +        list = list->next;
> > > > > +    }
> > > > >  }
> > > > >
> > > > >  void qmp_cxl_add_dynamic_capacity_event(const char *path,
> > > > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > > > > index 01a5eaca48..1f85c88017 100644
> > > > > --- a/include/hw/cxl/cxl_device.h
> > > > > +++ b/include/hw/cxl/cxl_device.h
> > > > > @@ -412,6 +412,7 @@ typedef struct CXLDCD_Region {
> > > > >      uint64_t block_size;
> > > > >      uint32_t dsmadhandle;
> > > > >      uint8_t flags;
> > > > > +    unsigned long *blk_bitmap;
> > > > >  } CXLDCD_Region;
> > > > >
> > > > >  struct CXLType3Dev {  
> > > >  
> >  


