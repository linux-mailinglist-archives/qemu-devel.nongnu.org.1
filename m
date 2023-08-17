Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A00E777F8E7
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:30:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWe0p-0001G7-Jb; Thu, 17 Aug 2023 10:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qWe0k-0001Fl-4m
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:30:06 -0400
Received: from smtpnm6-09.21cn.com ([182.42.152.55] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qWe0g-0006ZV-Gf
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:30:05 -0400
HMM_SOURCE_IP: 192.168.138.117:1352.709705605
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-182.148.58.152 (unknown [192.168.138.117])
 by chinatelecom.cn (HERMES) with SMTP id E4296111070A6;
 Thu, 17 Aug 2023 22:29:42 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([182.148.58.152])
 by gateway-ssl-dep-56d86dc765-7s8sf with ESMTP id
 15f8b92be62543fd9b618f4cccec002c for peterx@redhat.com; 
 Thu, 17 Aug 2023 22:29:50 CST
X-Transaction-ID: 15f8b92be62543fd9b618f4cccec002c
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 182.148.58.152
X-MEDUSA-Status: 0
Message-ID: <9a20b490-c08f-4a6c-a6d7-350a7174abb0@chinatelecom.cn>
Date: Thu, 17 Aug 2023 22:29:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRIEZhYmlhbm8gUm9z?=
 =?UTF-8?Q?as?= <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migrate/ram: let ram_save_target_page_legacy() return if
 qemu file got error
Content-Language: en-US
To: =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRIFBldGVyIFh1?= <peterx@redhat.com>
References: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
 <87h6p0mqk8.fsf@suse.de> <ZNv6ABLk7EjaX8dD@x1n> <87350klygf.fsf@suse.de>
 <ZNzhuF7fRUdaGthV@x1n> <87o7j7kohx.fsf@suse.de>
 <15874e41-fee0-49db-98fc-cf2b545fe7c2@chinatelecom.cn> <ZN4iKgeVeLBSCSK2@x1n>
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <ZN4iKgeVeLBSCSK2@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.152.55; envelope-from=tugy@chinatelecom.cn;
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

Thank you for the reminder. There might be some issues with the 
company's email service. I also noticed this morning that I missed 
receiving an email in response from Fabiano.


On 2023/8/17 21:35, 【外部账号】 Peter Xu wrote:
> On Thu, Aug 17, 2023 at 10:19:19AM +0800, Guoyi Tu wrote:
>>
>>
>> On 2023/8/16 23:15, 【外部账号】 Fabiano Rosas wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> On Tue, Aug 15, 2023 at 07:42:24PM -0300, Fabiano Rosas wrote:
>>>>> Yep, I see that. I meant explicitly move the code into the loop. Feels a
>>>>> bit weird to check the QEMUFile for errors first thing inside the
>>>>> function when nothing around it should have touched the QEMUFile.
>>>>
>>>> Valid point.  This reminded me that now we have one indirection into
>>>> ->ram_save_target_page() which is a hook now.  Putting in the caller will
>>>> work for all hooks, even though they're not yet exist.
>>>>
>>>> But since we don't have any other hooks yet, it'll be the same for now
> 
> Guoyi,
> 
> Your email got cut from here.  Same thing happened on emails from Hyman
> (also sent from China Telecom email address), maybe your mail system did
> something wrong.
> 

