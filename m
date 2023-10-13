Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C27C825A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrEf7-0003ww-S0; Fri, 13 Oct 2023 05:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrEf5-0003we-U8
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:40:52 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrEf3-0001W2-9l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:40:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S6M233VgCz4xLw;
 Fri, 13 Oct 2023 20:40:43 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S6M210dnXz4x3v;
 Fri, 13 Oct 2023 20:40:40 +1100 (AEDT)
Message-ID: <000c19b5-9de3-46dc-a090-c078dcac6a43@kaod.org>
Date: Fri, 13 Oct 2023 11:40:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 58/78] hw/ppc: add fallthrough pseudo-keyword
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
 <a8b851d14520d857fccaadb9097e9aa71bb7e1bc.1697183699.git.manos.pitsidianakis@linaro.org>
 <a9cb8b38-55fb-797c-a6b5-46a0811c6982@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <a9cb8b38-55fb-797c-a6b5-46a0811c6982@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=fS+4=F3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 10/13/23 10:32, Harsh Prateek Bora wrote:
> 
> 
> On 10/13/23 13:27, Emmanouil Pitsidianakis wrote:
>> In preparation of raising -Wimplicit-fallthrough to 5, replace all
>> fall-through comments with the fallthrough attribute pseudo-keyword.
>>
>> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
> One question below, may be Cedric knows better who introduced initial code.
> 
>> ---
>>   hw/ppc/pnv_bmc.c      | 2 +-
>>   hw/ppc/spapr_events.c | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
>> index 99f1e8d7f9..9bff7d03cb 100644
>> --- a/hw/ppc/pnv_bmc.c
>> +++ b/hw/ppc/pnv_bmc.c
>> @@ -172,69 +172,69 @@ static int hiomap_erase(PnvPnor *pnor, uint32_t offset, uint32_t size)
>>   static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
>>                          RspBuffer *rsp)
>>   {
>>       PnvPnor *pnor = PNV_PNOR(object_property_get_link(OBJECT(ibs), "pnor",
>>                                                         &error_abort));
>>       uint32_t pnor_size = pnor->size;
>>       uint32_t pnor_addr = PNOR_SPI_OFFSET;
>>       bool readonly = false;
>>       rsp_buffer_push(rsp, cmd[2]);
>>       rsp_buffer_push(rsp, cmd[3]);
>>       switch (cmd[2]) {
>>       case HIOMAP_C_MARK_DIRTY:
>>       case HIOMAP_C_FLUSH:
>>       case HIOMAP_C_ACK:
>>           break;
>>       case HIOMAP_C_ERASE:
>>           if (hiomap_erase(pnor, blocks_to_bytes(cmd[5] << 8 | cmd[4]),
>>                           blocks_to_bytes(cmd[7] << 8 | cmd[6]))) {
>>               rsp_buffer_set_error(rsp, IPMI_CC_UNSPECIFIED);
>>           }
>>           break;
>>       case HIOMAP_C_GET_INFO:
>>           rsp_buffer_push(rsp, 2);  /* Version 2 */
>>           rsp_buffer_push(rsp, BLOCK_SHIFT); /* block size */
>>           rsp_buffer_push(rsp, 0);  /* Timeout */
>>           rsp_buffer_push(rsp, 0);  /* Timeout */
>>           break;
>>       case HIOMAP_C_GET_FLASH_INFO:
>>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) & 0xFF);
>>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) >> 8);
>>           rsp_buffer_push(rsp, 0x01);  /* erase size */
>>           rsp_buffer_push(rsp, 0x00);  /* erase size */
>>           break;
>>       case HIOMAP_C_CREATE_READ_WINDOW:
>>           readonly = true;
>> -        /* Fall through */
>> +        fallthrough;
>>       case HIOMAP_C_CREATE_WRITE_WINDOW:
>>           memory_region_set_readonly(&pnor->mmio, readonly);
>>           memory_region_set_enabled(&pnor->mmio, true);
>>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_addr) & 0xFF);
>>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_addr) >> 8);
>>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) & 0xFF);
>>           rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) >> 8);
>>           rsp_buffer_push(rsp, 0x00); /* offset */
>>           rsp_buffer_push(rsp, 0x00); /* offset */
>>           break;
>>       case HIOMAP_C_CLOSE_WINDOW:
>>           memory_region_set_enabled(&pnor->mmio, false);
>>           break;
>>       case HIOMAP_C_DEVICE_NAME:
>>       case HIOMAP_C_RESET:
>>       case HIOMAP_C_LOCK:
> 
> Do we need a break here ?
> Otherwise above 3 case statements doesnt add any value.

Indeed. These came from ca661fae81d3 ("ppc/pnv: Add HIOMAP commands").
The RESET command is implemented in skiboot. DEVICE_NAME and LOCK
seem not. Something to check.

Thanks,

C.

> 
>>       default:
>>           qemu_log_mask(LOG_GUEST_ERROR, "HIOMAP: unknown command %02X\n", cmd[2]);
>>           break;
>>       }
>>   }
>>   #define HIOMAP   0x5a
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index 4508e40814..9d51746daf 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -411,25 +411,26 @@ static const SpaprEventSource *
>>   rtas_event_log_to_source(SpaprMachineState *spapr, int log_type)
>>   {
>>       const SpaprEventSource *source;
>>       g_assert(spapr->event_sources);
>>       switch (log_type) {
>>       case RTAS_LOG_TYPE_HOTPLUG:
>>           source = spapr_event_sources_get_source(spapr->event_sources,
>>                                                   EVENT_CLASS_HOT_PLUG);
>>           if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
>>               g_assert(source->enabled);
>>               break;
>>           }
>>           /* fall through back to epow for legacy hotplug interrupt source */
>> +        fallthrough;
>>       case RTAS_LOG_TYPE_EPOW:
>>           source = spapr_event_sources_get_source(spapr->event_sources,
>>                                                   EVENT_CLASS_EPOW);
>>           break;
>>       default:
>>           source = NULL;
>>       }
>>       return source;
>>   }


