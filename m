Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7C873DB9
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Mar 2024 18:49:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhvNa-0006fY-6Y; Wed, 06 Mar 2024 12:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhvNS-0006W6-0l
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:48:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhvNL-0005WD-5g
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:48:25 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tqfv402gyz6K8h6;
 Thu,  7 Mar 2024 01:44:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 2FF14140AA7;
 Thu,  7 Mar 2024 01:48:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 17:48:12 +0000
Date: Wed, 6 Mar 2024 17:48:11 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240306174811.000029fd@Huawei.com>
In-Reply-To: <20240304194331.1586191-10-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon,  4 Mar 2024 11:34:04 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Since fabric manager emulation is not supported yet, the change implements
> the functions to add/release dynamic capacity extents as QMP interfaces.

We'll need them anyway, or to implement an fm interface via QMP which is
going to be ugly and complex.

> 
> Note: we skips any FM issued extent release request if the exact extent
> does not exist in the extent list of the device. We will loose the
> restriction later once we have partial release support in the kernel.

Maybe the kernel will treat it as a request to release the extent it
is tracking that contains it.  So we may want to add a way to poke that.
Not today though!

> 
> 1. Add dynamic capacity extents:
> 
> For example, the command to add two continuous extents (each 128MiB long)
> to region 0 (starting at DPA offset 0) looks like below:
> 
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-add-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "region-id": 0,
>       "extents": [
>       {
>           "dpa": 0,
>           "len": 134217728
>       },
>       {
>           "dpa": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
> 
> 2. Release dynamic capacity extents:
> 
> For example, the command to release an extent of size 128MiB from region 0
> (DPA offset 128MiB) look like below:
> 
> { "execute": "cxl-release-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "region-id": 0,
>       "extents": [
>       {
>           "dpa": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

...
  
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index dccfaaad3a..e9c8994cdb 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -674,6 +674,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>          ct3d->dc.total_capacity += region->len;
>      }
>      QTAILQ_INIT(&ct3d->dc.extents);
> +    QTAILQ_INIT(&ct3d->dc.extents_pending_to_add);
>  
>      return true;
>  }
> @@ -686,6 +687,12 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
>          ent = QTAILQ_FIRST(&ct3d->dc.extents);
>          cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
>      }
> +
> +    while (!QTAILQ_EMPTY(&ct3d->dc.extents_pending_to_add)) {

QTAILQ_FOR_EACHSAFE

> +        ent = QTAILQ_FIRST(&ct3d->dc.extents_pending_to_add);
> +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending_to_add,
> +                                           ent);
> +    }
>  }

> +/*
> + * The main function to process dynamic capacity event. Currently DC extents
> + * add/release requests are processed.
> + */
> +static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
> +                                             CXLDCEventType type, uint16_t hid,
> +                                             uint8_t rid,
> +                                             CXLDCExtentRecordList *records,
> +                                             Error **errp)
> +{
> +    Object *obj;
> +    CXLEventDynamicCapacity dCap = {};
> +    CXLEventRecordHdr *hdr = &dCap.hdr;
> +    CXLType3Dev *dcd;
> +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> +    uint32_t num_extents = 0;
> +    CXLDCExtentRecordList *list;
> +    g_autofree CXLDCExtentRaw *extents = NULL;
> +    uint8_t enc_log;
> +    uint64_t offset, len, block_size;
> +    int i;
> +    int rc;

Combine the two lines above.

> +    g_autofree unsigned long *blk_bitmap = NULL;
> +
> +    obj = object_resolve_path(path, NULL);
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }

object_resolve_path_type() and skip a step (should do this in various places
in our existing code!)

> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path not point to a valid CXL type3 device");
> +        return;
> +    }
> +
> +    dcd = CXL_TYPE3(obj);
> +    if (!dcd->dc.num_regions) {
> +        error_setg(errp, "No dynamic capacity support from the device");
> +        return;
> +    }
> +
> +    rc = ct3d_qmp_cxl_event_log_enc(log);
> +    if (rc < 0) {
> +        error_setg(errp, "Unhandled error log type");
> +        return;
> +    }
> +    enc_log = rc;
> +
> +    if (rid >= dcd->dc.num_regions) {
> +        error_setg(errp, "region id is too large");
> +        return;
> +    }
> +    block_size = dcd->dc.regions[rid].block_size;
> +
> +    /* Sanity check and count the extents */
> +    list = records;
> +    while (list) {
> +        offset = list->value->offset;
> +        len = list->value->len;
> +
> +        if (len == 0) {
> +            error_setg(errp, "extent with 0 length is not allowed");
> +            return;
> +        }
> +
> +        if (offset % block_size || len % block_size) {
> +            error_setg(errp, "dpa or len is not aligned to region block size");
> +            return;
> +        }
> +
> +        if (offset + len > dcd->dc.regions[rid].len) {
> +            error_setg(errp, "extent range is beyond the region end");
> +            return;
> +        }
> +
> +        num_extents++;
> +        list = list->next;
> +    }
> +    if (num_extents == 0) {
> +        error_setg(errp, "No extents found in the command");
> +        return;
> +    }
> +
> +    blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
> +
> +    /* Create Extent list for event being passed to host */
> +    i = 0;
> +    list = records;
> +    extents = g_new0(CXLDCExtentRaw, num_extents);
> +    while (list) {
> +        CXLDCExtent *ent;
> +        bool skip_extent = false;
> +
> +        offset = list->value->offset;
> +        len = list->value->len;
> +
> +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> +        extents[i].len = len;
> +        memset(extents[i].tag, 0, 0x10);
> +        extents[i].shared_seq = 0;
> +
> +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> +            /*
> +             *  if the extent is still pending to be added to the host,

Odd spacing.

> +             * remove it from the pending extent list, so later when the add
> +             * response for the extent arrives, the device can reject the
> +             * extent as it is not in the pending list.
> +             */
> +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> +                        &extents[i]);
> +            if (ent) {
> +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> +                g_free(ent);
> +                skip_extent = true;
> +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> +                /* If the exact extent is not in the accepted list, skip */
> +                skip_extent = true;
> +            }
I think we need to reject case of some extents skipped and others not.
That's not supported yet so we need to complain if we get it at least. Maybe we need
to do two passes so we know this has happened early (or perhaps this is a later
patch in which case a todo here would help).

> +        
> +
> +        /* No duplicate or overlapped extents are allowed */
> +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> +                              len / block_size)) {
> +            error_setg(errp, "duplicate or overlapped extents are detected");
> +            return;
> +        }
> +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> +
> +        list = list->next;
> +        if (!skip_extent) {
> +            i++;
Problem is if we skip one in the middle the records will be wrong below.
> +        }
> +    }
> +    num_extents = i;
> +
> +    /*
> +     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> +     *
> +     * All Dynamic Capacity event records shall set the Event Record Severity
> +     * field in the Common Event Record Format to Informational Event. All
> +     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> +     * Event Log.
> +     */
> +    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> +                            cxl_device_get_timestamp(&dcd->cxl_dstate));
> +
> +    dCap.type = type;
> +    /* FIXME: for now, validity flag is cleared */
> +    dCap.validity_flags = 0;
> +    stw_le_p(&dCap.host_id, hid);
> +    /* only valid for DC_REGION_CONFIG_UPDATED event */
> +    dCap.updated_region_id = 0;
> +    /*
> +     * FIXME: for now, the "More" flag is cleared as there is only one
> +     * extent associating with each record and tag-based release is
> +     * not supported.

Hmm. Seems like tag support would be easy.  Add an optional qmp parameter,
if a tag is set, we set the more flag for all but the last entry in this
loop.  I'm ok with that being a follow up patch though.

> +     */
> +    dCap.flags = 0;
> +    for (i = 0; i < num_extents; i++) {
> +        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> +               sizeof(CXLDCExtentRaw));
> +
> +        if (type == DC_EVENT_ADD_CAPACITY) {
> +            cxl_insert_extent_to_extent_list(&dcd->dc.extents_pending_to_add,
> +                                             extents[i].start_dpa,
> +                                             extents[i].len,
> +                                             extents[i].tag,
> +                                             extents[i].shared_seq);
> +        }
> +
> +        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
> +                             (CXLEventRecordRaw *)&dCap)) {
> +            cxl_event_irq_assert(dcd);
> +        }
> +    }
> +}




> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 341260e6e4..b524c5e699 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -490,6 +490,7 @@ struct CXLType3Dev {
>          AddressSpace host_dc_as;
>          uint64_t total_capacity; /* 256M aligned */
>          CXLDCExtentList extents;
> +        CXLDCExtentList extents_pending_to_add;

Long name, extents_pending or just pending is plenty I think.

>          uint32_t total_extent_count;
>          uint32_t ext_list_gen_seq;
>  
> @@ -551,4 +552,9 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
>  
>  void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
>                                          CXLDCExtent *extent);
> +void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
> +                                      uint64_t len, uint8_t *tag,
> +                                      uint16_t shared_seq);
> +bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
> +                       unsigned long size);
>  #endif



