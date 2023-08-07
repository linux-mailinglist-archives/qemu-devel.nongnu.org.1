Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80B771E37
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 12:36:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSxaQ-0005tc-Mu; Mon, 07 Aug 2023 06:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qSxaN-0005tE-Fg
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 06:35:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qSxaJ-0005uO-Nj
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 06:35:39 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKCL53C62z67p9F;
 Mon,  7 Aug 2023 18:31:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 11:35:30 +0100
Date: Mon, 7 Aug 2023 11:35:20 +0100
To: Fan Ni <fan.ni@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
 "cbrowy@avery-design.com" <cbrowy@avery-design.com>, "ira.weiny@intel.com"
 <ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, 
 Adam Manzanares <a.manzanares@samsung.com>, "dave@stgolabs.net"
 <dave@stgolabs.net>, "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>, 
 "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu PATCH v2 8/9] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20230807113520.0000798b@Huawei.com>
In-Reply-To: <20230725183939.2741025-9-fan.ni@samsung.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p1ebf676c30d21896d1fd7f9b652250449@uscas1p1.samsung.com>
 <20230725183939.2741025-9-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Tue, 25 Jul 2023 18:39:56 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> Since fabric manager emulation is not supported yet, the change implements
> the functions to add/release dynamic capacity extents as QMP interfaces.
> 
> 1. Add dynamic capacity extents:
> 
> For example, the command to add two continuous extents (each is 128MB long)
> to region 0 (starting at dpa offset 0 and 128MB) looks like below:
> 
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-add-dynamic-capacity-event",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "extents": [
>       {
>           "region-id": 0,
>           "dpa": 0,
>           "len": 128
>       },
>       {
>           "region-id": 0,
>           "dpa": 128,
>           "len": 128
>       }
>       ]
>   }
> }
> 
> 2. Release dynamic capacity extents:
> 
> For example, the command to release an extent of size 128MB from region 0
> (starting at dpa offset 128MB) look like below:
> 
> { "execute": "cxl-release-dynamic-capacity-event",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "extents": [
>       {
>           "region-id": 0,
>           "dpa": 128,
>           "len": 128
>       }
>       ]
>   }
> }
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/mem/cxl_type3.c          | 145 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |   6 ++
>  include/hw/cxl/cxl_events.h |  16 ++++
>  qapi/cxl.json               |  49 ++++++++++++
>  4 files changed, 216 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index f1170b8047..41a828598a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1817,6 +1817,151 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>      }
>  }
>  
> +static const QemuUUID dynamic_capacity_uuid = {
> +    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> +            0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> +};
> +
> +/*
> + * cxl r3.0: Table 8-47
> + * 00h: add capacity
> + * 01h: release capacity
> + * 02h: forced capacity release
> + * 03h: region configuration updated
> + * 04h: Add capacity response
> + * 05h: capacity released

If we explicitly set the values in the enum below then this
comment only adds the useful reference. Hence I've done that
and updated reference to my preferred format.
Also moved the reference up a few lines so it covers the
UUID as well.

> + */
> +enum DC_Event_Type {
> +    DC_EVENT_ADD_CAPACITY,
> +    DC_EVENT_RELEASE_CAPACITY,
> +    DC_EVENT_FORCED_RELEASE_CAPACITY,
> +    DC_EVENT_REGION_CONFIG_UPDATED,
> +    DC_EVENT_ADD_CAPACITY_RSP,
> +    DC_EVENT_CAPACITY_RELEASED,
> +    DC_EVENT_NUM
> +};
> +
> +#define MEM_BLK_SIZE_MB 128
> +static void qmp_cxl_process_dynamic_capacity_event(const char *path,
> +        CxlEventLog log, enum DC_Event_Type type,
> +        uint16_t hid, CXLDCExtentRecordList *records, Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    CXLEventDynamicCapacity dCap;
> +    CXLEventRecordHdr *hdr = &dCap.hdr;
> +    CXLDeviceState *cxlds;
> +    CXLType3Dev *dcd;
> +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> +    uint32_t num_extents = 0;
> +    CXLDCExtentRecordList *list = records;
For consistency (as we reset this for second pass) I've moved the
setting of this down to just above the first loop.

> +    CXLDCExtent_raw *extents;
> +    uint64_t dpa, len;
> +    uint8_t rid = 0;

> +    int i;
> +
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path not point to a valid CXL type3 device");
> +        return;
> +    }
> +
> +    dcd = CXL_TYPE3(obj);
> +    cxlds = &dcd->cxl_dstate;

Only used once so I've moved it inline.

> +    memset(&dCap, 0, sizeof(dCap));

Can use dCap = {}; It's packed so no holes to be covered by the memset.
AS a side note, I'd have done this after the next check if we were doing
it explicitly.  With the {} approach we can rely on compiler to optimize
when it is done.


> +
> +    if (!dcd->dc.num_regions) {
> +        error_setg(errp, "No dynamic capacity support from the device");
> +        return;
> +    }
> +
> +    while (list) {
> +        dpa = list->value->dpa * 1024 * 1024;

MiB

> +        len = list->value->len * 1024 * 1024;
> +        rid = list->value->region_id;
> +
> +        if (rid >= dcd->dc.num_regions) {
> +            error_setg(errp, "region id is too large");
> +            return;
> +        }
> +
> +        if (dpa % dcd->dc.regions[rid].block_size
> +                || len % dcd->dc.regions[rid].block_size) {
> +            error_setg(errp, "dpa or len is not aligned to region block size");
> +            return;
> +        }
> +
> +        if (dpa + len > dcd->dc.regions[rid].decode_len * 256 * 1024 * 1024) {
> +            error_setg(errp, "extent range is beyond the region end");
> +            return;
> +        }
> +
> +        num_extents++;
> +        list = list->next;
> +    }
> +
> +    i = 0;
> +    list = records;
> +    extents = g_new0(CXLDCExtent_raw, num_extents);
> +    while (list) {
> +        dpa = list->value->dpa * 1024 * 1024;
> +        len = list->value->len * 1024 * 1024;

MiB

> +        rid = list->value->region_id;
> +
> +        extents[i].start_dpa = dpa + dcd->dc.regions[rid].base;
> +        extents[i].len = len;
> +        memset(extents[i].tag, 0, 0x10);

I'd suggest we add a tag sooner rather than later. Can make it optional
and default to zero though.  Note I'm not making that change whilst rebasing
this.

> +        extents[i].shared_seq = 0;
> +
> +        list = list->next;
> +        i++;
> +    }
> +
> +    /*
> +     * 8.2.9.1.5
> +     * All Dynamic Capacity event records shall set the Event Record
> +     * Severity field in the Common Event Record Format to Informational
> +     * Event. All Dynamic Capacity related events shall be logged in the
> +     * Dynamic Capacity Event Log.
> +     */
> +    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> +            cxl_device_get_timestamp(&dcd->cxl_dstate));
> +
> +    dCap.type = type;
> +    stw_le_p(&dCap.host_id, hid);
> +    /* only valid for DC_REGION_CONFIG_UPDATED event */
> +    dCap.updated_region_id = rid;
> +    for (i = 0; i < num_extents; i++) {
> +        memcpy(&dCap.dynamic_capacity_extent, &extents[i]
> +                , sizeof(CXLDCExtent_raw));
> +
> +        if (cxl_event_insert(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                    (CXLEventRecordRaw *)&dCap)) {
> +            cxl_event_irq_assert(dcd);
> +        }
> +    }
> +
> +    g_free(extents);
Can use g_autofree given lifetime of this can be governed by the scope.
Qemu code does this a lot - it's just starting to sneak into the kernel
as well and makes this sort of handling much nicer as they end up more
or less looking like they are on the stack ;)

> +}
> +
> +void qmp_cxl_add_dynamic_capacity_event(const char *path,
> +        struct CXLDCExtentRecordList  *records,
Don't need the struct as there is a typedef autocreated from the qmp
schema stuff.

> +        Error **errp)
Where it doesn't go over 80 chars, prefer aligned to one space after the (

> +{
> +   qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATIONAL,
> +           DC_EVENT_ADD_CAPACITY, 0, records, errp);
> +}
> +
> +void qmp_cxl_release_dynamic_capacity_event(const char *path,
> +        struct CXLDCExtentRecordList  *records,
> +        Error **errp)
> +{
> +    qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATIONAL,
> +            DC_EVENT_RELEASE_CAPACITY, 0, records, errp);
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index f3e4a9fa72..482229f3bd 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -56,3 +56,9 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>  {
>      error_setg(errp, "CXL Type 3 support is not compiled in");
>  }
> +
> +void qmp_cxl_add_dynamic_capacity_event(const char *path,
> +        struct CXLDCExtentRecordList  *records, Error **errp) {}

Good to have the error prints as done for the other cases.

> +
> +void qmp_cxl_release_dynamic_capacity_event(const char *path,
> +        struct CXLDCExtentRecordList  *records, Error **errp) {}
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 089ba2091f..3baf745f8d 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -165,4 +165,20 @@ typedef struct CXLEventMemoryModule {
>      uint8_t reserved[0x3d];
>  } QEMU_PACKED CXLEventMemoryModule;
>  
> +/*
> + * Dynamic Capacity Event Record
> + * CXL Rev 3.0 Section 8.2.9.2.1.5: Table 8-47
> + * All fields little endian.
> + */
> +typedef struct CXLEventDynamicCapacity {
> +    CXLEventRecordHdr hdr;
> +    uint8_t type;
> +    uint8_t reserved1;
> +    uint16_t host_id;
> +    uint8_t updated_region_id;
> +    uint8_t reserved2[3];
> +    uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */
> +    uint8_t reserved[0x20];
> +} QEMU_PACKED CXLEventDynamicCapacity;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 05c560cfe5..fb04ec4c41 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -369,3 +369,52 @@
>  ##
>  {'command': 'cxl-inject-correctable-error',
>   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> +
> +##
> +# @CXLDCExtentRecord:
> +#
> +# Record of a single extent to add/release
> +#
> +# @region-id: id of the region where the extent to add/release
> +# @dpa: start dpa (in MiB) of the extent, related to region base address
> +# @len: extent size (in MiB)
> +#
> +# Since: 8.0
> +##
> +{ 'struct': 'CXLDCExtentRecord',
> +  'data': {
> +      'region-id': 'uint8',
> +      'dpa':'uint64',
> +      'len': 'uint64'
> +  }
> +}
> +
> +##
> +# @cxl-add-dynamic-capacity-event:
In later patches this is going to add the capacity - the event is
just part of it. So I've renamed to simply cxl-add-dynamic-capacity
and added a bit about it 'starting the add capacity flow./

> +#
> +# Command to add dynamic capacity extent event
> +#
> +# @path: CXL DCD canonical QOM path
> +# @extents: Extents to add

Added a highly speculative (and optimistic) Since: 8.2
as hopefully we can remember to update them.  I'm thinking this
is at least 9.0 material but you never know! :)

> +#
> +##
> +{ 'command': 'cxl-add-dynamic-capacity-event',
> +  'data': { 'path': 'str',
> +            'extents': [ 'CXLDCExtentRecord' ]
> +           }
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity-event:
> +#
> +# Command to release dynamic capacity extent event
> +#
> +# @path: CXL DCD canonical QOM path
> +# @extents: Extents to release
> +#
> +##
> +{ 'command': 'cxl-release-dynamic-capacity-event',
> +  'data': { 'path': 'str',
> +            'extents': [ 'CXLDCExtentRecord' ]
> +           }
> +}


