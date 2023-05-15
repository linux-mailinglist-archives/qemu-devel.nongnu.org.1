Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C570309F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 16:54:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZZy-0005Ow-Pt; Mon, 15 May 2023 10:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pyZZw-0005Me-9M
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:53:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pyZZt-0002CE-6A
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:53:36 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKj4b0W0Qz67M5Q;
 Mon, 15 May 2023 22:51:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 15:53:27 +0100
Date: Mon, 15 May 2023 15:53:26 +0100
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
Subject: Re: [RFC 6/7] Add qmp interfaces to add/release dynamic capacity
 extents
Message-ID: <20230515155326.0000093f@Huawei.com>
In-Reply-To: <20230511175609.2091136-7-fan.ni@samsung.com>
References: <20230511175609.2091136-1-fan.ni@samsung.com>
 <CGME20230511175642uscas1p27cf2915c8184225bfd581fb6f6dfb2d9@uscas1p2.samsung.com>
 <20230511175609.2091136-7-fan.ni@samsung.com>
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
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 11 May 2023 17:56:40 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> Since fabric manager emulation is not supported yet, the change implements
> the functions to add/release dynamic capacity extents as QMP interfaces.

This makes sense at least as a stop gap.

> 
> 1. Add dynamic capacity extents:
> 
> For example, the command to add two continuous extents (each is 128MB
> long) to region 0 (starting at dpa offset 0) looks like below:
> 
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-add-dynamic-capacity-event",
>     "arguments": {
> 	"path": "/machine/peripheral/cxl-pmem0",
> 	"region-id" : 0,
> 	"num-extent": 2,
What does num-extent mean? 
A multiple entry injection mechanism makes sense but this
doesn't seem be one.  Look at the error injection stuff done
to ensure we could inject multiple of those as one atomic operation
to trigger the various multi error handling paths.

> 	"dpa":0,
> 	"extent-len": 128
> 	}
> }
> 
> 2. Release dynamic capacity extents:
> 
> For example, the command to release an extent of size 128MB from region
> 0 (starting at dpa offset 0) look like below:
> 
> { "execute": "cxl-release-dynamic-capacity-event",
> 	"arguments": {
> 		 "path": "/machine/peripheral/cxl-pmem0",
> 		"region-id" : 0,
> 		 "num-extent": 1 ,
> 		"dpa":0,
> 		"extent-len": 128
> 	}
> }
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/mem/cxl_type3.c          | 127 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_events.h |  16 +++++
>  qapi/cxl.json               |  44 +++++++++++++
>  3 files changed, 187 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 23954711b5..70d47d43b9 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1651,6 +1651,133 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>      }
>  }
>  
> +static const QemuUUID dynamic_capacity_uuid = {
> +	.data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> +			0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> +};
> +
> +static void qmp_cxl_process_dynamic_capacity_event(const char *path, CxlEventLog log,
> +		uint8_t flags, uint8_t type, uint16_t hid, uint8_t rid, uint32_t extent_cnt,
> +		CXLDCExtent_raw *extents, Error **errp)
> +{
> +	Object *obj = object_resolve_path(path, NULL);
> +	CXLEventDynamicCapacity dCap;
> +	CXLEventRecordHdr *hdr = &dCap.hdr;
> +	CXLDeviceState *cxlds;
> +	CXLType3Dev *dcd;
> +	int i;
> +
> +	if (!obj) {
> +		error_setg(errp, "Unable to resolve path");
> +		return;
> +	}
> +	if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +		error_setg(errp, "Path not point to a valid CXL type3 device");
> +		return;
> +	}
> +
> +	dcd = CXL_TYPE3(obj);
> +	cxlds = &dcd->cxl_dstate;
> +	memset(&dCap, 0, sizeof(dCap));
> +
> +	if (!dcd->dc.num_regions) {
> +		error_setg(errp, "No dynamic capacity support from the device");
> +		return;
> +	}
> +
> +	/*
> +	 * 8.2.9.1.5
> +	 * All Dynamic Capacity event records shall set the Event Record
> +	 * Severity field in the Common Event Record Format to Informational
> +	 * Event. All Dynamic Capacity related events shall be logged in the
> +	 * Dynamic Capacity Event Log.
> +	 */
> +	assert(flags & (1<<CXL_EVENT_TYPE_INFO));

Given this requirement, why pass in those flags at all? Just set it in here instead
thus ensuring it's always right.

> +	cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap));
> +
> +	/*
> +	 * 00h: add capacity
> +	 * 01h: release capacity

Enum for these so the input is typed.

> +	 * 02h: forced capacity release
> +	 * 03h: region configuration updated
> +	 * 04h: Add capacity response
> +	 * 05h: capacity released
> +	 **/
> +	dCap.type = type;
> +	stw_le_p(&dCap.host_id, hid);
> +	dCap.updated_region_id = rid;
> +	for (i = 0; i < extent_cnt; i++) {
> +		extents[i].start_dpa += dcd->dc.regions[rid].base;

Mixture of handling endian conversion and not.  Whilst we still have
a bunch of cleanup to do around this, new code should handle endian
conversions always.  If touching code with problems, a precursor patch
to fix that code up before adding new stuff would be great as well.

> +		memcpy(&dCap.dynamic_capacity_extent, &extents[i]
> +				, sizeof(CXLDCExtent_raw));

comma on previous line.

> +
> +		if (cxl_event_insert(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP,
> +					(CXLEventRecordRaw *)&dCap)) {
> +			;

?  Failure here indicates a bug or an overflow of the event log.
Both want handling.

> +		}
> +		cxl_event_irq_assert(dcd);
> +	}
> +}
> +
> +#define MEM_BLK_SIZE_MB 128
> +void qmp_cxl_add_dynamic_capacity_event(const char *path, uint8_t region_id,
> +		uint32_t num_exent, uint64_t dpa, uint64_t extent_len_MB, Error **errp)
> +{
> +	uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;

As above, no point in handling flags out here if they always have same value.
Push them to where it matters.

> +	CXLDCExtent_raw *extents;
> +	int i;
> +
> +	if (extent_len_MB < MEM_BLK_SIZE_MB) {
> +		error_setg(errp,
> +			"extent size cannot be smaller than memory block size (%dMB)",
> +			MEM_BLK_SIZE_MB);
> +		return;
> +	}
> +
> +	extents = g_new0(CXLDCExtent_raw, num_exent);

Ah. Raw extents used in here. Either combine the different definitions or bring
that one forwards to this patch.

> +	for (i = 0; i < num_exent; i++) {
> +		extents[i].start_dpa = dpa;
> +		extents[i].len = extent_len_MB*1024*1024;
> +		memset(extents[i].tag, 0, 0x10);
> +		extents[i].shared_seq = 0;
> +		dpa += extents[i].len;
> +	}
> +
> +	qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATIONAL,
> +			flags, 0x0, 0, region_id, num_exent, extents, errp);
> +
> +	g_free(extents);
> +}
> +
> +void qmp_cxl_release_dynamic_capacity_event(const char *path, uint8_t region_id,
> +		uint32_t num_exent, uint64_t dpa, uint64_t extent_len_MB, Error **errp)
> +{
> +	uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> +	CXLDCExtent_raw *extents;
> +	int i;
> +
> +	if (extent_len_MB < MEM_BLK_SIZE_MB) {
> +		error_setg(errp,
> +			"extent size cannot be smaller than memory block size (%dMB)",
> +			MEM_BLK_SIZE_MB);
> +		return;
> +	}
> +
> +	extents = g_new0(CXLDCExtent_raw, num_exent);
> +	for (i = 0; i < num_exent; i++) {
> +		extents[i].start_dpa = dpa;
> +		extents[i].len = extent_len_MB*1024*1024;
> +		memset(extents[i].tag, 0, 0x10);
> +		extents[i].shared_seq = 0;
> +		dpa += extents[i].len;
> +	}
> +
> +	qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATIONAL,
> +			flags, 0x1, 0, region_id, num_exent, extents, errp);
> +
> +	g_free(extents);
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 089ba2091f..dd00458d1d 100644
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
> +	CXLEventRecordHdr hdr;
> +	uint8_t type;
> +	uint8_t reserved1;
> +	uint16_t host_id;
> +	uint8_t updated_region_id;
> +	uint8_t reserved2[3];
> +	uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */
> +	uint8_t reserved[0x20];
> +} QEMU_PACKED CXLEventDynamicCapacity;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 8b3d30cd71..c9a9a45ce4 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -264,3 +264,47 @@
>              'type': 'CxlCorErrorType'
>    }
>  }
> +
> +##
> +# @cxl-add-dynamic-capacity-event:
> +#
> +# Command to add dynamic capacity extent event
> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: region id
> +# @num-extent: number of extents to add, test only
Moving towards 
> +# @dpa: start dpa for the operation
> +# @extent-len: extent size in MB
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-add-dynamic-capacity-event',
> +  'data': { 'path': 'str',
> +           'region-id': 'uint8',
> +           'num-extent': 'uint32',

Look at how cxl-inject-uncorrectable-errors is done
as that handles a set of records all in one command and
we want similar here - so that we generate what it would
look like if the fm-api was used.

> +           'dpa':'uint64',
> +           'extent-len': 'uint64'
> +  }
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity-event:
> +#
> +# Command to add dynamic capacity extent event
> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: region id
> +# @num-extent: number of extents to add, test only
> +# @dpa: start dpa for the operation
> +# @extent-len: extent size in MB
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-release-dynamic-capacity-event',
> +  'data': { 'path': 'str',
> +           'region-id': 'uint8',
> +           'num-extent': 'uint32',
> +           'dpa':'uint64',
> +           'extent-len': 'uint64'
> +  }
> +}


