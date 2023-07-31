Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CFD76A450
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 00:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQbcT-0005Tf-AJ; Mon, 31 Jul 2023 18:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQbcO-0005T8-Kv
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:44:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQbcM-00051u-86
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:44:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bbd03cb7c1so31524615ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690843436; x=1691448236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tzGCIa7Iq9NomVIsCLOhJd0qCZo8WRR/jwxoBhp0sAg=;
 b=35af6C39or2aqbKiF9K5+E0Y9VxoXl0DS5l/9OBAggXeo8QhCtYtrRD074WDsqfIG+
 0wUjqz4OyCZpYDuKIr2gcg8C1lPSrS1fFRUI1iSDlaI/S2hMEc5KsaMfaygznvvlA8DQ
 //S1de2z/hE9JrLmcDbfS2mJtlMrzGS/wD+5KBDEz41b54AAN1m/vItLWX7N0ibOVjrV
 SjqLPFexy3/JLvZoZFXfTUSYsgjEDr1GMOeZBot/YYKH3NLfzcjjId/3AD1a1PKziifi
 GwGET536mZFsSFZcgD8jQ8vCqhsaBLv096fNSsbyuIzobCnKK7hsUrAvkTMsuNQQpQyG
 Y21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690843436; x=1691448236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tzGCIa7Iq9NomVIsCLOhJd0qCZo8WRR/jwxoBhp0sAg=;
 b=eshduMtEZ1iDx+MALVkGXOjAXrquVC/xfrj70Yut58MRw9PRVOEpltvhm4ZE5ch8IA
 vpl+NZCyOY07QKq6Lz3qrPFsuEPI6wrQWQ5i7H1HY2chh13QW0N17apOgFfC86QbOa/E
 GmsPU35QEO5Mc/VK5v2II4bCo0+B7bBkWzjSg1VqDp+QeAfEWX5qOQr1J7k0ih6rFuk/
 Fx5Q1eF2cSj4pM8hp+ndSAqk4Mb3T4MINEBsUA6Rz7JeV3p6rG2B4yvIGdxEbETBXtWo
 oyEK2Thxcq3VknjuvKDkB4U+9MoWgXC3eAFmAohoHIrFykg0wiB5BCmsuMCTrwkNSc80
 1G1Q==
X-Gm-Message-State: ABy/qLY+/L0dZEGpjBTzTqt3WS0xsZj36zILieYhN1tWaL+VajuVRIif
 qTGUzLLp7x2FmFGbOEV/brNMeA==
X-Google-Smtp-Source: APBJJlFLCf4zXL1EQAtdM/le7nZxKP4tMR9MTeWaLP1ks/0U8k0HuSGcF5Ena7peNCEbJBqKA9Cymg==
X-Received: by 2002:a17:902:8a85:b0:1b9:e913:b585 with SMTP id
 p5-20020a1709028a8500b001b9e913b585mr8879831plo.13.1690843436551; 
 Mon, 31 Jul 2023 15:43:56 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a1709028c8e00b001b1a2c14a4asm9056943plo.38.2023.07.31.15.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 15:43:56 -0700 (PDT)
Message-ID: <aa7e87f0-ae72-0147-3e8e-4d06b736b28c@daynix.com>
Date: Tue, 1 Aug 2023 07:43:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] linux-user: Do not align brk with host page size
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <20230731080317.112658-6-akihiko.odaki@daynix.com>
 <7b55e607-45f9-a574-fb00-b65508e57b10@gmx.de>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <7b55e607-45f9-a574-fb00-b65508e57b10@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/01 0:51, Helge Deller wrote:
> On 7/31/23 10:03, Akihiko Odaki wrote:
>> do_brk() minimizes calls into target_mmap() by aligning the address
>> with host page size, which is potentially larger than the target page
>> size.
> 
> Keep in mind, that host page size can be smaller than target page size too.
> That's the reason why host brk (brk_page) and target brk (target_brk)
> needs to be tracked individually.
> So, it's not an optimization, but required.
> Btw, I think we have been there before with the idea of
> just keeping track of host pages...

It does not matter even if the host page size is smaller or larger. 
do_brk() solely relies on target_mmap(), which works with target page size.

> 
>> However, the current implementation of this optimization has two
>> bugs:
>>
>> - The start of brk is rounded up with the host page size while brk
>>    advertises an address aligned with the target page size as the
>>    beginning of brk. This makes the beginning of brk unmapped.
>> - Content clearing after mapping is flawed. The size to clear is
>>    specified as HOST_PAGE_ALIGN(brk_page) - brk_page, but brk_page is
>>    aligned with the host page size so it is always zero.
>>
>> This optimization actually has no practical benefit. It makes difference
>> when brk() is called multiple times with values in a range of the host
>> page size. However, sophisticated memory allocators try to avoid to
>> make such frequent brk() calls. For example, glibc 2.37 calls brk() to
>> shrink the heap only when there is a room more than 128 KiB. It is
>> rare to have a page size larger than 128 KiB if it happens.
>>
>> Let's remove the optimization to fix the bugs and make the code simpler.
>>
>> Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1616
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   linux-user/elfload.c |  4 ++--
>>   linux-user/syscall.c | 54 ++++++++++----------------------------------
>>   2 files changed, 14 insertions(+), 44 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 861ec07abc..2aee2298ec 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -3678,8 +3678,8 @@ int load_elf_binary(struct linux_binprm *bprm, 
>> struct image_info *info)
>>        * to mmap pages in this space.
>>        */
>>       if (info->reserve_brk) {
>> -        abi_ulong start_brk = HOST_PAGE_ALIGN(info->brk);
>> -        abi_ulong end_brk = HOST_PAGE_ALIGN(info->brk + 
>> info->reserve_brk);
>> +        abi_ulong start_brk = TARGET_PAGE_ALIGN(info->brk);
>> +        abi_ulong end_brk = TARGET_PAGE_ALIGN(info->brk + 
>> info->reserve_brk);
> 
> In my patchset I removed the reserve_brk stuff...
> 
>>           target_munmap(start_brk, end_brk - start_brk);
>>       }
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index ebdc8c144c..475260b7ce 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -802,81 +802,51 @@ static inline int host_to_target_sock_type(int 
>> host_type)
>>   }
>>
>>   static abi_ulong target_brk, initial_target_brk;
>> -static abi_ulong brk_page;
> 
> with that you loose the ability to track the brk address on host.

brk_page actually doesn't track the address on the host. It's just an 
address on the target but aligned with host page size. And the alignment 
is purely for optimization.

> 
> 
>>   void target_set_brk(abi_ulong new_brk)
>>   {
>>       target_brk = TARGET_PAGE_ALIGN(new_brk);
>>       initial_target_brk = target_brk;
>> -    brk_page = HOST_PAGE_ALIGN(target_brk);
>>   }
>>
>>   /* do_brk() must return target values and target errnos. */
>>   abi_long do_brk(abi_ulong brk_val)
>>   {
>>       abi_long mapped_addr;
>> -    abi_ulong new_alloc_size;
>> -    abi_ulong new_brk, new_host_brk_page;
>> +    abi_ulong new_brk;
>> +    abi_ulong old_brk;
>>
>>       /* brk pointers are always untagged */
>>
>> -    /* return old brk value if brk_val unchanged */
>> -    if (brk_val == target_brk) {
>> -        return target_brk;
>> -    }
>> -
>>       /* do not allow to shrink below initial brk value */
>>       if (brk_val < initial_target_brk) {
>>           return target_brk;
>>       }
>>
>>       new_brk = TARGET_PAGE_ALIGN(brk_val);
>> -    new_host_brk_page = HOST_PAGE_ALIGN(brk_val);
>> +    old_brk = TARGET_PAGE_ALIGN(target_brk);
>>
>> -    /* brk_val and old target_brk might be on the same page */
>> -    if (new_brk == TARGET_PAGE_ALIGN(target_brk)) {
>> -        /* empty remaining bytes in (possibly larger) host page */
>> -        memset(g2h_untagged(new_brk), 0, new_host_brk_page - new_brk);
> 
> you can't drop that.
> guest could have clobbered the upper parts, e.g. when it first mapped
> all (e.g. 8k), wrote to it, then released upper half of the host page 
> (4k) and
> then remaps the upper 4k again.
> In that case we need to ensure that the upper 4k gets cleaned. On a 
> physical
> machine the kernel would have requested a new page, but here we are stuck
> with the bigger host page which we can't simply release.

Such a case should also be handled with target_mmap().

Regards,
Akihiko Odaki

