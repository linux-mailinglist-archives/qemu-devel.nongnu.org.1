Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 946207C5527
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:22:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZ96-0004Xv-6n; Wed, 11 Oct 2023 09:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qqZ8w-0004Xc-0n
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:20:54 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qqZ8s-0003jg-4g
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:20:52 -0400
Message-ID: <04093899-57e7-75bf-5b16-0ec08708a2d0@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1697030443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4098uk/asTGC8/4Fp+JSj/CHqyDkDPa7C8u6LZ5qVU=;
 b=jmqEEU+MTOmg1cVKhMXqdHICTvlnMeRaPQkoQoNEeuU/7Bi2wd4JObCswZ2BS4xJkTT5BE
 dlDYOvJmrQGPrJiNo3IpqlZV1Gfek/9Oaqw7usUmKkZb6cKKMP+9e6Vh57CR7BuoD5Tj5H
 VNp0oa9L3WUWkzUrsoJXXCGSvcitAqc=
Date: Wed, 11 Oct 2023 16:20:42 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v1] migration: fix RAMBlock add NULL check
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
References: <20231010104851.802947-1-frolov@swemel.ru> <ZSWkvPH0asP8xXSu@x1n>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <ZSWkvPH0asP8xXSu@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 10.10.2023 22:23, Peter Xu wrote:
> On Tue, Oct 10, 2023 at 01:48:53PM +0300, Dmitry Frolov wrote:
>> qemu_ram_block_from_host() may return NULL, which will be dereferenced w/o
> AFAIU this path is only called from trusted sites, so I don't see why it
> can be NULL?  Do you have any scenario that can trigger this?
No, actually no exact case. This was found by static analyzer.
I am also not sure, if NULL is possible here.
>
>> check. Usualy return value is checked for this function.
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: c7c0e72408df5e7821c0e995122fb2fe0ac001f1 ("migration/ram: Handle RAM block resizes during precopy")
> Normally if we attach Fixes it means we want to backport it to stable.
> Here I'd like to double check on above to see whether we'd need a Fixes.
>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> The patch itself looks all fine; though if I'm going to add some print, I'd
> print something more to make it at least try to be more useful (host,
> old_size, new_size).  I had a feeling that we can already assert.
I do not insist on accepting this patch - it is more like RFC.
Also, i can add more verbose message and assert, if necessary.
> Thanks,
>
>> ---
>>   migration/ram.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index e4bfd39f08..bd4b7574e1 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -4281,6 +4281,11 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
>>       RAMBlock *rb = qemu_ram_block_from_host(host, false, &offset);
>>       Error *err = NULL;
>>   
>> +    if (!rb) {
>> +        error_report("RAM block not found");
>> +        return;
>> +    }
>> +
>>       if (migrate_ram_is_ignored(rb)) {
>>           return;
>>       }
>> -- 
>> 2.34.1
>>
>>


