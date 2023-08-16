Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D5F77D861
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 04:23:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW6AT-0000Ld-Rd; Tue, 15 Aug 2023 22:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qW6AR-0000EF-05
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 22:21:51 -0400
Received: from smtpnm6-01.21cn.com ([182.42.159.233] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qW6AN-0000U3-MK
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 22:21:50 -0400
HMM_SOURCE_IP: 192.168.139.44:61332.1203497443
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.139.44])
 by chinatelecom.cn (HERMES) with SMTP id 5B446100111F5;
 Wed, 16 Aug 2023 10:09:37 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([36.111.64.85])
 by gateway-ssl-dep-56d86dc765-g96c8 with ESMTP id
 794cd757766d4411993cbdf0bae1e03f for peterx@redhat.com; 
 Wed, 16 Aug 2023 10:09:45 CST
X-Transaction-ID: 794cd757766d4411993cbdf0bae1e03f
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Message-ID: <ad6d2f08-0917-4136-a67b-47644ce479ba@chinatelecom.cn>
Date: Wed, 16 Aug 2023 10:09:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migrate/ram: let ram_save_target_page_legacy() return if
 qemu file got error
Content-Language: en-US
To: =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRIFBldGVyIFh1?= <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
 <87h6p0mqk8.fsf@suse.de> <ZNv6ABLk7EjaX8dD@x1n>
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <ZNv6ABLk7EjaX8dD@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.159.233; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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



On 2023/8/16 6:19, 【外部账号】 Peter Xu wrote:
> On Tue, Aug 15, 2023 at 09:35:19AM -0300, Fabiano Rosas wrote:
>> Guoyi Tu <tugy@chinatelecom.cn> writes:
>>
>>> When the migration process of a virtual machine using huge pages is
>>> cancelled,
>>> QEMU will continue to complete the processing of the current huge page
>>> through the qemu file object got an error set. These processing, such as
>>> compression and encryption, will consume a lot of CPU resources which may
>>> affact the the performance of the other VMs.
>>>
>>> To terminate the migration process more quickly and minimize unnecessary
>>> resource occupancy, it's neccessary to add logic to check the error status
>>> of qemu file object in the beginning of ram_save_target_page_legacy
>>> function,
>>> and make sure the function returns immediately if qemu file got an error.
>>>
>>> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
>>> ---
>>>    migration/ram.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index 9040d66e61..3e2ebf3004 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -2133,6 +2133,10 @@ static int ram_save_target_page_legacy(RAMState
>>> *rs, PageSearchStatus *pss)
>>>        ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>>>        int res;
>>>
>>> +    if (qemu_file_get_error(pss->pss_channel)) {
>>> +        return -1;
>>> +    }
>>
>> Where was the error set? Is this from cancelling via QMP? Or something
>> from within ram_save_target_page_legacy? We should probably make the
>> check closer to where the error happens. At the very least moving the
>> check into the loop.
> 
> Fabiano - I think it's in the loop (of all target pages within a same host
> page), and IIUC Guoyi mentioned it's part of cancelling.
> 
> Guoyi, I assume you just saw qemu cancel too slow over e.g. 1g pages?
> The patch looks good here.

Yes, when migration process got cancelled, i think there is no need to 
handle the remaining part of the huge page, we should quit immediatley

> Thanks,
> 

