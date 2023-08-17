Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE777EF01
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 04:21:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWScN-0005G3-E5; Wed, 16 Aug 2023 22:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qWScK-0005Fd-9P
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:20:08 -0400
Received: from smtpnm6-04.21cn.com ([182.42.158.78] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qWScH-0004fz-3b
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:20:08 -0400
HMM_SOURCE_IP: 192.168.139.44:36701.1353264787
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.139.44])
 by chinatelecom.cn (HERMES) with SMTP id 714609C25AA;
 Thu, 17 Aug 2023 10:19:23 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([36.111.64.85])
 by gateway-ssl-dep-56d86dc765-g96c8 with ESMTP id
 7e99bcd52ed04e118f8d005ac14c14ed for farosas@suse.de; 
 Thu, 17 Aug 2023 10:19:42 CST
X-Transaction-ID: 7e99bcd52ed04e118f8d005ac14c14ed
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Message-ID: <15874e41-fee0-49db-98fc-cf2b545fe7c2@chinatelecom.cn>
Date: Thu, 17 Aug 2023 10:19:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migrate/ram: let ram_save_target_page_legacy() return if
 qemu file got error
Content-Language: en-US
To: =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRIEZhYmlhbm8gUm9zYXM=?=
 <farosas@suse.de>, Peter Xu <peterx@redhat.com>
References: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
 <87h6p0mqk8.fsf@suse.de> <ZNv6ABLk7EjaX8dD@x1n> <87350klygf.fsf@suse.de>
 <ZNzhuF7fRUdaGthV@x1n> <87o7j7kohx.fsf@suse.de>
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <87o7j7kohx.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.158.78; envelope-from=tugy@chinatelecom.cn;
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



On 2023/8/16 23:15, 【外部账号】 Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Tue, Aug 15, 2023 at 07:42:24PM -0300, Fabiano Rosas wrote:
>>> Yep, I see that. I meant explicitly move the code into the loop. Feels a
>>> bit weird to check the QEMUFile for errors first thing inside the
>>> function when nothing around it should have touched the QEMUFile.
>>
>> Valid point.  This reminded me that now we have one indirection into
>> ->ram_save_target_page() which is a hook now.  Putting in the caller will
>> work for all hooks, even though they're not yet exist.
>>
>> But since we don't have any other hooks yet, it'll be the same for now.
>>
>> Acked-by: Peter Xu <peterx@redhat.com>
>>
>> For the long term: there's one more reason to rework qemu_put_byte()/... to
>> return error codes.. Then things like save_normal_page() can simply already
>> return negatives when hit an error.
>>
>> Fabiano - I see that you've done quite a few patches in reworking migration
>> code.  I had that for a long time in my todo, but if you're interested feel
>> free to look into it.
>>
>> IIUC the idea is introducing another similar layer of API for qemufile (I'd
>> call it qemu_put_1|2|4|8(), or anything you can come up better with..) then
>> let migration to switch over to it, with retval reflecting errors.  Then we
>> should be able to drop this patch along with most of the explicit error
>> checks for the qemufile spread all over.
> 
> I was just ranting about this situation in another thread! Yes, we need
> something like that. QEMUFile errors should only be set by code doing
> actual IO and if we want to store the error for other parts of the code
> to use, that should be another interface.
> 
> While reviewing this patch I noticed we have stuff like this:
> 
> pages = ram_find_and_save_block()
> ...
> if (pages < 0) {
>      qemu_file_set_error(f, pages);
>      break;
> }
> 
> So the low-level code sets the error, ram_save_target_page_legacy() sees
> it and returns -1, and this^ code loses all track of the initial error
> and inadvertently turns it into -EPERM!
> 
> I'll try to find some time to start cleaning this up

It sounds very reasonable. the return value of the QEMUFile interface
cannot accurately reflect the actual situation, and the way these
interfaces are being called during the migration process also is a
little bit weird.

I'm glad to see that you have plans to improve these interfaces. If you
need any assistance, I'd be more than happy to be involved.

