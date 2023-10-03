Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 341967B72A1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmDw-00063v-Dv; Tue, 03 Oct 2023 16:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnmDu-00063V-QN
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:42:30 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnmDs-00041Y-R8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:42:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-690d2441b95so191040b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696365747; x=1696970547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gnw+ixjajX/MV6eJ3oe79X5OY0gjokcomYfEqcmSs5E=;
 b=yxGowF51qkwf6jOYtMMNGakbhM/A1fJsP5wDV3FzdvZ1WiR4SSjoItfaAwGkNzfNMu
 QMq6oP891t4Mhfu63nruUOTn7GZvVyF69K279O8Yd3Abno5b5Ieo+nxndqE5CNs6roik
 PExSxGQNhxhCV0VvQ5LEe4Hk+mFtoF4eTMvUyKpzPkhpmeYUQI+RYRu3N902C5VW0Yzc
 Hkiq33KqNPZuEjZuOP7m4yQeDVBvClj0o+Wq260AeS6XDhJNA/g23odsxTdKr3kQdUGU
 CRcdVdzKwKYfNXbGNXjz52IrPZLv1bzVW7WgIE2LP9CDwmsWCRiau8t59Xg4goRS1ukG
 lEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696365747; x=1696970547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gnw+ixjajX/MV6eJ3oe79X5OY0gjokcomYfEqcmSs5E=;
 b=Wi2AvVsA4tXlNXrCy+Kof/OZvNZe1nKVkIAoJDh0jxbYg7an3oojLfbwtZpLB+vhET
 Rb+9YOKIvRiswSDoWwZvWbkE0tWVqGm+UpzVWBGeQt23Gr0j4GQ/BkCJaYw8Yv8c+LtM
 SM7gWlP9g+3oaUolpRPVwXzfqiQOoQW/972EVQYyg6uBa2yCKQxV81AUMs8B0oH6sEwL
 ocpM4e2tA4MNQL6agKxxhRIpIXVXoNMm6Z8Lyk+IZVvYUVpb49TguY6ftmSdA5yFpF4U
 4r214doTKqT4S24yECast2EJhv5N3ugXcttmVGYsVX8s1vVMFY1Wl15Hqtv6ythlvoFv
 7prg==
X-Gm-Message-State: AOJu0YyElpl5Iroa6//ZLl4emprcwK17PtW4BCsdA6g1NYi14CxpY2ry
 /DxUdXfaAMnnzdOkgrvJcn9VrA==
X-Google-Smtp-Source: AGHT+IGZHJrSUf2i8y309Rsc6CqDMO9k8C5b+IMEiu6QY2GL6ZLXQ/tnuQJkm2A/V9shcIfMBH2E8Q==
X-Received: by 2002:a05:6a00:390a:b0:68e:351b:15b9 with SMTP id
 fh10-20020a056a00390a00b0068e351b15b9mr589957pfb.4.1696365747250; 
 Tue, 03 Oct 2023 13:42:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a62ab0a000000b006930db1e6d1sm1770232pff.203.2023.10.03.13.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 13:42:26 -0700 (PDT)
Message-ID: <fea1c085-8b92-7d01-bedb-35cefb357df5@linaro.org>
Date: Tue, 3 Oct 2023 13:42:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] linux-user: Undo incomplete mmap
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230903053927.38037-1-akihiko.odaki@daynix.com>
 <619a188e-aaae-4d45-9aa5-bd9c4eac1a4d@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <619a188e-aaae-4d45-9aa5-bd9c4eac1a4d@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/21/23 00:09, Akihiko Odaki wrote:
> On 2023/09/03 14:39, Akihiko Odaki wrote:
>> When the host page size is greater than the target page size and
>> MAP_FIXED or MAP_FIXED_NOREPLACE is requested, mmap will be done for
>> three parts: start, middle, and end. If a later part of mmap fail,
>> mmap done in the earlier parts must be reverted.
>>
>> Fixes: 54936004fd ("mmap emulation")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> V1 -> V2: Rebased.
>>
>>   linux-user/mmap.c | 65 +++++++++++++++++++++++++++++------------------
>>   1 file changed, 40 insertions(+), 25 deletions(-)
>>
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index 9aab48d4a3..72521f8d27 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -224,13 +224,15 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
>>   /* map an incomplete host page */
>>   static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
>> -                      int prot, int flags, int fd, off_t offset)
>> +                      int prot, int flags, int fd, off_t offset, bool *mapped)
>>   {
>>       abi_ulong real_last;
>>       void *host_start;
>>       int prot_old, prot_new;
>>       int host_prot_old, host_prot_new;
>> +    *mapped = false;
>> +
>>       if (!(flags & MAP_ANONYMOUS)
>>           && (flags & MAP_TYPE) == MAP_SHARED
>>           && (prot & PROT_WRITE)) {
>> @@ -271,6 +273,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, 
>> abi_ulong last,
>>               return false;
>>           }
>>           prot_old = prot;
>> +        *mapped = true;
>>       }
>>       prot_new = prot | prot_old;
>> @@ -448,7 +451,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong 
>> align)
>>   abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>>                        int flags, int fd, off_t offset)
>>   {
>> -    abi_ulong ret, last, real_start, real_last, retaddr, host_len;
>> +    abi_ulong ret, last, real_start, retaddr, host_len;
>>       abi_ulong passthrough_start = -1, passthrough_last = 0;
>>       int page_flags;
>>       off_t host_offset;
>> @@ -577,12 +580,16 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>>           passthrough_start = start;
>>           passthrough_last = last;
>>       } else {
>> +        abi_ulong middle_start = HOST_PAGE_ALIGN(start);
>> +        abi_ulong middle_last = ((start + len) & qemu_host_page_mask) - 1;
>> +        abi_ulong mapped_len = 0;
>> +        bool mapped;
>> +
>>           if (start & ~TARGET_PAGE_MASK) {
>>               errno = EINVAL;
>>               goto fail;
>>           }
>>           last = start + len - 1;
>> -        real_last = HOST_PAGE_ALIGN(last) - 1;
>>           /*
>>            * Test if requested memory area fits target address space
>> @@ -649,35 +656,26 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>>           }
>>           /* handle the start of the mapping */
>> -        if (start > real_start) {
>> -            if (real_last == real_start + qemu_host_page_size - 1) {
>> +        if (start < middle_start) {
>> +            if (last < middle_start) {
>>                   /* one single host page */
>>                   if (!mmap_frag(real_start, start, last,
>> -                               target_prot, flags, fd, offset)) {
>> +                               target_prot, flags, fd, offset, &mapped)) {
>>                       goto fail;
>>                   }
>>                   goto the_end1;
>>               }
>> -            if (!mmap_frag(real_start, start,
>> -                           real_start + qemu_host_page_size - 1,
>> -                           target_prot, flags, fd, offset)) {
>> +            if (!mmap_frag(real_start, start, middle_start - 1,
>> +                           target_prot, flags, fd, offset, &mapped)) {
>>                   goto fail;
>>               }
>> -            real_start += qemu_host_page_size;
>> -        }
>> -        /* handle the end of the mapping */
>> -        if (last < real_last) {
>> -            abi_ulong real_page = real_last - qemu_host_page_size + 1;
>> -            if (!mmap_frag(real_page, real_page, last,
>> -                           target_prot, flags, fd,
>> -                           offset + real_page - start)) {
>> -                goto fail;
>> +            if (mapped) {
>> +                mapped_len = qemu_host_page_size;
>>               }
>> -            real_last -= qemu_host_page_size;
>>           }
>>           /* map the middle (easier) */
>> -        if (real_start < real_last) {
>> +        if (middle_start < middle_last) {
>>               void *p, *want_p;
>>               off_t offset1;
>>               size_t len1;
>> @@ -685,10 +683,10 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>>               if (flags & MAP_ANONYMOUS) {
>>                   offset1 = 0;
>>               } else {
>> -                offset1 = offset + real_start - start;
>> +                offset1 = offset + middle_start - start;
>>               }
>> -            len1 = real_last - real_start + 1;
>> -            want_p = g2h_untagged(real_start);
>> +            len1 = middle_last - middle_start + 1;
>> +            want_p = g2h_untagged(middle_start);
>>               p = mmap(want_p, len1, target_to_host_prot(target_prot),
>>                        flags, fd, offset1);
>> @@ -697,10 +695,27 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>>                       munmap(p, len1);
>>                       errno = EEXIST;
>>                   }
>> +                if (mapped_len) {
>> +                    munmap(g2h_untagged(middle_start - mapped_len), mapped_len);
>> +                }
>> +                goto fail;
>> +            }
>> +            mapped_len += len1;
>> +            passthrough_start = middle_start;
>> +            passthrough_last = middle_last;
>> +        }
>> +
>> +        /* handle the end of the mapping */
>> +        if (last > middle_last) {
>> +            abi_ulong real_page = middle_last + 1;
>> +            if (!mmap_frag(real_page, real_page, last,
>> +                           target_prot, flags, fd,
>> +                           offset + real_page - start, &mapped)) {
>> +                if (mapped_len) {
>> +                    munmap(g2h_untagged(real_page - mapped_len), mapped_len);
>> +                }
>>                   goto fail;
>>               }
>> -            passthrough_start = real_start;
>> -            passthrough_last = real_last;
>>           }
>>       }
>>    the_end1:
> 
> Hi Richard,
> 
> Can you have a look at this patch?

munmap isn't always correct -- one has to keep the virtual address space allocated for 
reserved_va.  So mmap_reserve_or_unmap.

That said, I've got one reorg of mmap.c outstanding already, and I'm planning another to 
allow use of softmmu in user-only mode.  The latter would eliminate mmap_frag entirely.


r~

