Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA2178E865
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:38:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbdAq-0007we-Aa; Thu, 31 Aug 2023 04:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TXcQ=EQ=kaod.org=clg@ozlabs.org>)
 id 1qbdAo-0007vv-68; Thu, 31 Aug 2023 04:37:06 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TXcQ=EQ=kaod.org=clg@ozlabs.org>)
 id 1qbdAk-00028h-7D; Thu, 31 Aug 2023 04:37:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RbvfH3zhPz4x09;
 Thu, 31 Aug 2023 18:36:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbvfG1gxzz4wy9;
 Thu, 31 Aug 2023 18:36:53 +1000 (AEST)
Message-ID: <0a54be6c-698d-de03-1e7d-374960a518c4@kaod.org>
Date: Thu, 31 Aug 2023 10:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] ppc/xive: Introduce a new XiveRouter end_notify()
 handler
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230829143236.219348-1-clg@kaod.org>
 <20230829143236.219348-3-clg@kaod.org>
 <a835ad10-0de5-7364-ab4c-444b8b9fd94e@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <a835ad10-0de5-7364-ab4c-444b8b9fd94e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=TXcQ=EQ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.242, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 8/31/23 09:50, Frederic Barrat wrote:
> 
> 
> On 29/08/2023 16:32, Cédric Le Goater wrote:
>> It will help us model the END triggers on the PowerNV machine, which
>> can be rerouted to another interrupt controller.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
> 
> 
> 
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 56670b2cac6e..df3ee0496fe7 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -1518,6 +1518,13 @@ static void xive_router_realize(DeviceState *dev, Error **errp)
>>       assert(xrtr->xfb);
>>   }
>> +static void xive_router_end_notify_handler(XiveRouter *xrtr, XiveEAS *eas)
>> +{
>> +    XiveRouterClass *xrc = XIVE_ROUTER_GET_CLASS(xrtr);
>> +
>> +    return xrc->end_notify(xrtr, eas);
>> +}
>> +
>>   /*
>>    * Encode the HW CAM line in the block group mode format :
>>    *
>> @@ -1664,8 +1671,7 @@ static bool xive_router_end_es_notify(XiveRouter *xrtr, uint8_t end_blk,
>>    * another chip. We don't model the PowerBus but the END trigger
>>    * message has the same parameters than in the function below.
>>    */
>> -static void xive_router_end_notify(XiveRouter *xrtr, uint8_t end_blk,
>> -                                   uint32_t end_idx, uint32_t end_data)
>> +void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
>>   {
>>       XiveEND end;
>>       uint8_t priority;
>> @@ -1675,6 +1681,10 @@ static void xive_router_end_notify(XiveRouter *xrtr, uint8_t end_blk,
>>       XiveNVT nvt;
>>       bool found;
>> +    uint8_t end_blk = xive_get_field64(EAS_END_BLOCK, eas->w);
>> +    uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
>> +    uint32_t end_data = xive_get_field64(EAS_END_DATA,  eas->w);
>> +
>>       /* END cache lookup */
>>       if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
>>           qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No END %x/%x\n", end_blk,
>> @@ -1817,10 +1827,7 @@ do_escalation:
>>       /*
>>        * The END trigger becomes an Escalation trigger
>>        */
>> -    xive_router_end_notify(xrtr,
>> -                           xive_get_field32(END_W4_ESC_END_BLOCK, end.w4),
>> -                           xive_get_field32(END_W4_ESC_END_INDEX, end.w4),
>> -                           xive_get_field32(END_W5_ESC_END_DATA,  end.w5));
>> +    xive_router_end_notify_handler(xrtr, (XiveEAS *) &end.w4);
> 
> 
> I didn't like the cast, but I can see why you're doing it this way. 

OPAL does a similar cast :

  https://github.com/open-power/skiboot/blob/master/hw/xive.c#L783

> We should be fine as long as the notify handler is not testing the validity bit of the EAS structure.

Indeed. It doesn't seem to be set :

XIVE[0] #0 END Escalation EAT
   0000008e -Q    end:00/008f data:00000000
   0000008f --    end:01/003f data:0000008f
   00000096 -Q    end:00/0097 data:00000000
   00000097 --    end:01/003f data:00000097

I don't remember to be honest. This is from a few years back. Ask the
HW designer may be ?
  
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>

Thanks,

C.

> 
>    Fred
> 
> 
>>   }
>>   void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
>> @@ -1871,10 +1878,7 @@ void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
>>       /*
>>        * The event trigger becomes an END trigger
>>        */
>> -    xive_router_end_notify(xrtr,
>> -                           xive_get_field64(EAS_END_BLOCK, eas.w),
>> -                           xive_get_field64(EAS_END_INDEX, eas.w),
>> -                           xive_get_field64(EAS_END_DATA,  eas.w));
>> +    xive_router_end_notify_handler(xrtr, &eas);
>>   }
>>   static Property xive_router_properties[] = {
>> @@ -1887,12 +1891,16 @@ static void xive_router_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       XiveNotifierClass *xnc = XIVE_NOTIFIER_CLASS(klass);
>> +    XiveRouterClass *xrc = XIVE_ROUTER_CLASS(klass);
>>       dc->desc    = "XIVE Router Engine";
>>       device_class_set_props(dc, xive_router_properties);
>>       /* Parent is SysBusDeviceClass. No need to call its realize hook */
>>       dc->realize = xive_router_realize;
>>       xnc->notify = xive_router_notify;
>> +
>> +    /* By default, the router handles END triggers locally */
>> +    xrc->end_notify = xive_router_end_notify;
>>   }
>>   static const TypeInfo xive_router_info = {


