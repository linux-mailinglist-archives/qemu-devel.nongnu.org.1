Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476048BAAEE
	for <lists+qemu-devel@lfdr.de>; Fri,  3 May 2024 12:43:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2qNJ-0008C5-9e; Fri, 03 May 2024 06:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1s2qNH-0008Bv-U6
 for qemu-devel@nongnu.org; Fri, 03 May 2024 06:42:44 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1s2qNE-00013j-OV
 for qemu-devel@nongnu.org; Fri, 03 May 2024 06:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1714732960; x=1746268960;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zG0K56OqcvlQTBhmpj/Arjr5UaVym859L5G+Ft/5EzM=;
 b=q+1Lju1BkeL4pK8+1OY1KAP8Wq1hwM/mDYb31amI0HGWZ768fdULykVK
 LnkbZdWKaB/MG3P5qfZ+dM9Aw4U7EOWlC5zPnUuJiuCpYo6vwMIsBhvKE
 sCmP/uq38PcD6D4ToA/XKPqxzM9i3TtoGk+RDd0SXK8pcpST3MvkgPSnn
 jgy+X7ohOKaNx5vO7cx6YDFiHyyNWB8Q/sluhlG2XNTNyVdvpbrhEJEe0
 D0xZkFk4pibbalAf7KabFlFfU1Jl5UnVDZTneULzUW4ztf0T5h37EtU9G
 mmHlIs9ikmdc+KUDnyUH7RZWb6E0cczmv0gqOJTECcVaTunqtQrbIcwWI A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="136118288"
X-IronPort-AV: E=Sophos;i="6.07,251,1708354800"; d="scan'208";a="136118288"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2024 19:42:35 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id EF6ACA3334
 for <qemu-devel@nongnu.org>; Fri,  3 May 2024 19:42:33 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2AA0226BFC
 for <qemu-devel@nongnu.org>; Fri,  3 May 2024 19:42:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A3A352008BCDF
 for <qemu-devel@nongnu.org>; Fri,  3 May 2024 19:42:32 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 98E021A0002;
 Fri,  3 May 2024 18:42:31 +0800 (CST)
Message-ID: <0d0b087f-9aa4-45d3-9412-0b1a6a005c52@fujitsu.com>
Date: Fri, 3 May 2024 18:42:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 alison.schofield@intel.com
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
 <6627f68be4ff5_cd8e0294c3@iweiny-mobl.notmuch>
In-Reply-To: <6627f68be4ff5_cd8e0294c3@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28358.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28358.007
X-TMASE-Result: 10--33.039300-10.000000
X-TMASE-MatchedRID: vewQ6k4XI8WPvrMjLFD6eJTQgFTHgkhZ2q80vLACqaeqvcIF1TcLYANw
 091XoRE6tdBbZHtILeuNZCQJKjBBDuQJzj0xQdQ4qhcdnP91eXGlLADMASK8x0+z00/C4DjDww9
 d8yX1sPVI3BZzp6gmTf/xSIRtZzAJJtllgBC70flIcJTn2HkqsciU8vWcAqwj/gMNehoKqTtSgk
 le/Q26sPElavPjC4x+c+8rZtRCVxcs1N7rS51Kj1Z85UImhNtajOKexJz6jz1DoKPcRdYETegoS
 vaKsl/kIvrftAIhWmLy9zcRSkKatcOJmY4XRXkVyRfzRkrgkUHdKRNjzo2IONe0QKEEFPqMwOWn
 bwsz43IKJfF2LeZOjwT09/zQvuDSHFja9OI/1x3wlvzzUUaf2bpAJMK7N+JVWH7Bxw4ADCNTpES
 Ak5/JCi2uAhsZxwDrgy5HvmFjzMD0f/9jKE32B7i7edL7cQQODcK8n+cR7XIXR3BxHd42r4vawJ
 4dXHm9axE9Kn8VayoxrjToeMoIAYqUC97Rfi1mHuEs048UVaLxKR2kbb+f19DEYFs+HYK0o8WMk
 QWv6iWhMIDkR/KfwLcClLxx8lxl3QfwsVk0UbslCGssfkpInQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.252;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa7.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



在 2024/4/24 1:57, Ira Weiny 写道:
> Shiyang Ruan wrote:
>> Currently driver only traces cxl events, poison creation (for both vmem
>> and pmem type) on cxl memdev is silent.  OS needs to be notified then it
>> could handle poison pages in time.  Per CXL spec, the device error event
>> could be signaled through FW-First and OS-First methods.
>>
>> So, add poison creation event handler in OS-First method:
>>    - Qemu:
>>      - CXL device reports POISON creation event to OS by MSI by sending
>>        GMER/DER after injecting a poison record;
>>    - CXL driver:
>>      a. parse the POISON event from GMER/DER;
>>      b. translate poisoned DPA to HPA (PFN);
>>      c. enqueue poisoned PFN to memory_failure's work queue;
> 
> I'm a bit confused by the need for this patch.  Perhaps a bit more detail
> here?

Yes, I should have wrote more details.

I want to check and make sure the HWPOISON on a CXL device (type3) is 
working properly.  For example, a FSDAX filesystem created on a 
type3-pmem device, then it gets a POISON bit, the OS should be able to 
handle this POISON event: find the relevant process

Currently I'm using Qemu with several simulated CXL devices, and using 
poison injection API of Qemu to create POISON records, but OS isn't 
notified.  Only when we actively call list POISON records (cxl list -L) 
will the driver fetch them and log into trace events, then we see the 
POISON records.  Memory failure wasn't triggered too.

That's why I said "poison creation on cxl memdev is silent".  Per spec, 
POISON creation should be notified to OS.  Since not familiar with 
firmware part, I'm try adding this notification for OS-First.

> 
> More comments below.
> 
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
>>   drivers/cxl/cxlmem.h      |   8 +--
>>   include/linux/cxl-event.h |  18 +++++-
>>   3 files changed, 125 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index f0f54aeccc87..76af0d73859d 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -837,25 +837,116 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>>   
>> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>> -			    enum cxl_event_log_type type,
>> -			    enum cxl_event_type event_type,
>> -			    const uuid_t *uuid, union cxl_event *evt)
>> +static void cxl_report_poison(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
>> +			      u64 dpa)
>>   {
>> -	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>> +	u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>> +	unsigned long pfn = PHYS_PFN(hpa);
>> +
>> +	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
>> +		return;
>> +
>> +	memory_failure_queue(pfn, MF_ACTION_REQUIRED);
> 
> I thought that ras daemon was supposed to take care of this when the trace
> event occurred.  Alison is working on the HPA data for that path.

It seems to save CXL trace events/memory-failures to DB and report to 
others, but cannot let OS call memory failure.

> 
>> +}
>> +
>> +static int __cxl_report_poison(struct device *dev, void *arg)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_memdev *cxlmd;
>> +	u64 dpa = *(u64 *)arg;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
>> +		return 0;
>> +
>> +	if (cxled->mode == CXL_DECODER_MIXED) {
>> +		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
>> +		return 0;
>> +	}
>> +
>> +	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
>> +		return 0;
>> +
>> +	cxlmd = cxled_to_memdev(cxled);
>> +	cxl_report_poison(cxlmd, cxled->cxld.region, dpa);
>> +
>> +	return 1;
>> +}
>> +
>> +static void cxl_event_handle_poison(struct cxl_memdev *cxlmd, u64 dpa)
>> +{
>> +	struct cxl_port *port = cxlmd->endpoint;
>> +
>> +	/*
>> +	 * No region is mapped to this endpoint, that is to say no HPA is
>> +	 * mapped.
>> +	 */
>> +	if (!port || !is_cxl_endpoint(port) ||
>> +	    cxl_num_decoders_committed(port) == 0)
>> +		return;
>> +
>> +	device_for_each_child(&port->dev, &dpa, __cxl_report_poison);
>> +}
>> +
>> +static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
>> +					   enum cxl_event_log_type type,
>> +					   struct cxl_event_gen_media *rec)
>> +{
>> +	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
>> +
>> +	if (type == CXL_EVENT_TYPE_FAIL) {
> 
> Why only FAIL and not FATAL?

POISON is recoverable(could be cleared by sending CLEAR_POISON command) 
and won't cause serious problems, so only use failure event here.

> 
>> +		switch (rec->transaction_type) {
>> +		case CXL_EVENT_TRANSACTION_READ:
>> +		case CXL_EVENT_TRANSACTION_WRITE:
>> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
> 
> Why not scan media?

Yes, this type should be handled too.  Will add.

> 
>> +			cxl_event_handle_poison(cxlmd, dpa);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static void cxl_event_handle_dram(struct cxl_memdev *cxlmd,
>> +				  enum cxl_event_log_type type,
>> +				  struct cxl_event_dram *rec)
>> +{
>> +	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
>> +
>> +	if (type == CXL_EVENT_TYPE_FAIL) {
>> +		switch (rec->transaction_type) {
>> +		case CXL_EVENT_TRANSACTION_READ:
>> +		case CXL_EVENT_TRANSACTION_WRITE:
>> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
>> +			cxl_event_handle_poison(cxlmd, dpa);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
>> +			     enum cxl_event_log_type type,
>> +			     enum cxl_event_type event_type,
>> +			     const uuid_t *uuid, union cxl_event *evt)
>> +{
>> +	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>>   		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
>> -	else if (event_type == CXL_CPER_EVENT_DRAM)
>> +		cxl_event_handle_general_media(cxlmd, type, &evt->gen_media);
>> +	} else if (event_type == CXL_CPER_EVENT_DRAM) {
>>   		trace_cxl_dram(cxlmd, type, &evt->dram);
>> -	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
>> +		cxl_event_handle_dram(cxlmd, type, &evt->dram);
>> +	} else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
>>   		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
>>   	else
>>   		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
>>   }
>> -EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
>> +EXPORT_SYMBOL_NS_GPL(cxl_event_handle_record, CXL);
>>
> 
> Why all the churn with changing the names of functions?

After adding cxl_report_poison(), these functions not only traces events 
but also contains event handler.  So rename them.

--
Thanks,
Ruan.

> 
> Ira
> 
>>   
>> -static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>> -				     enum cxl_event_log_type type,
>> -				     struct cxl_event_record_raw *record)
>> +static void __cxl_event_handle_record(struct cxl_memdev *cxlmd,
>> +				      enum cxl_event_log_type type,
>> +				      struct cxl_event_record_raw *record)
>>   {
>>   	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
>>   	const uuid_t *uuid = &record->id;
>> @@ -867,7 +958,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>   	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
>>   		ev_type = CXL_CPER_EVENT_MEM_MODULE;
>>   
>> -	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
>> +	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
>>   }
>>   
>>   static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>> @@ -979,8 +1070,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>>   			break;
>>   
>>   		for (i = 0; i < nr_rec; i++)
>> -			__cxl_event_trace_record(cxlmd, type,
>> -						 &payload->records[i]);
>> +			__cxl_event_handle_record(cxlmd, type,
>> +						  &payload->records[i]);
>>   
>>   		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>>   			trace_cxl_overflow(cxlmd, type, payload);
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 36cee9c30ceb..ba1347de5651 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -822,10 +822,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>>   void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>>   				  unsigned long *cmds);
>>   void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
>> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>> -			    enum cxl_event_log_type type,
>> -			    enum cxl_event_type event_type,
>> -			    const uuid_t *uuid, union cxl_event *evt);
>> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
>> +			     enum cxl_event_log_type type,
>> +			     enum cxl_event_type event_type,
>> +			     const uuid_t *uuid, union cxl_event *evt);
>>   int cxl_set_timestamp(struct cxl_memdev_state *mds);
>>   int cxl_poison_state_init(struct cxl_memdev_state *mds);
>>   int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
>> index 03fa6d50d46f..8189bed76c12 100644
>> --- a/include/linux/cxl-event.h
>> +++ b/include/linux/cxl-event.h
>> @@ -23,6 +23,20 @@ struct cxl_event_generic {
>>   	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
>>   } __packed;
>>   
>> +/*
>> + * Event transaction type
>> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
>> + */
>> +enum cxl_event_transaction_type {
>> +	CXL_EVENT_TRANSACTION_UNKNOWN = 0X00,
>> +	CXL_EVENT_TRANSACTION_READ,
>> +	CXL_EVENT_TRANSACTION_WRITE,
>> +	CXL_EVENT_TRANSACTION_SCAN_MEDIA,
>> +	CXL_EVENT_TRANSACTION_INJECT_POISON,
>> +	CXL_EVENT_TRANSACTION_MEDIA_SCRUB,
>> +	CXL_EVENT_TRANSACTION_MEDIA_MANAGEMENT,
>> +};
>> +
>>   /*
>>    * General Media Event Record
>>    * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
>> @@ -33,7 +47,7 @@ struct cxl_event_gen_media {
>>   	__le64 phys_addr;
>>   	u8 descriptor;
>>   	u8 type;
>> -	u8 transaction_type;
>> +	u8 transaction_type;	/* enum cxl_event_transaction_type */
>>   	u8 validity_flags[2];
>>   	u8 channel;
>>   	u8 rank;
>> @@ -52,7 +66,7 @@ struct cxl_event_dram {
>>   	__le64 phys_addr;
>>   	u8 descriptor;
>>   	u8 type;
>> -	u8 transaction_type;
>> +	u8 transaction_type;	/* enum cxl_event_transaction_type */
>>   	u8 validity_flags[2];
>>   	u8 channel;
>>   	u8 rank;
>> -- 
>> 2.34.1
>>
> 
> 

