Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FCD7B9AE1
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:17:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGjd-0007ZY-1d; Thu, 05 Oct 2023 01:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qoGjZ-0007ZP-KH
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:17:13 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qoGjX-0007I8-Id
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:17:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-690d2441b95so463964b3a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 22:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696483030; x=1697087830;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9I2cXROv1qJRClB+tbHre+lPdQ5wXz+rxfrtrNopyQs=;
 b=wndTLA+TcJxMCOcY3aGSBqqXJA1xAUx8ue7r+NJLd8Vf93Vu0pK2xUk8cbqWbwRVKQ
 RWNnor4BAMebNgyoRQCb5pCFHV5h0WWGzTkCztppq4GgBVi02KZiPlMKVIQ/PAdDkV9z
 w2+XW5CyznKNLWekXRUkhJqHCsqb2+ZWGvpdrGSBH5wG1uOG1RH1CW/DnzTqFVDYVr9Y
 h8G+H6V4DtnkMzxwBAwSoxh6yzsHdc6c5Paww9pvPp8QZAh8FW5hzobtWw+tEavWYXeR
 tAp34hhEQX/33DCdz5C9xTp6Q6y4fXZ6HgwzUY0KUaX2O3MjxkBqJ6r496dAMOp/GP+m
 6YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696483030; x=1697087830;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9I2cXROv1qJRClB+tbHre+lPdQ5wXz+rxfrtrNopyQs=;
 b=jo7ci994yvzom0Um4azB3s90ZAbMFzrFOnDqsNs6VMXSI4vzf4MoC6KBxZ75PefLae
 OikxPQIamtXhUSI7sVSeq0LRfIzcKCtzSPEzat3e/An7Aru5e4BoGl1JDmCM5HzaBSXO
 HrHbvrL+dFvz/sL3FF5IcZDL2q5VAIy0W3k1Sl2c/DiIPBAJi3Z1Suk8ydZuZziZngnZ
 3cNGjDLQEisu5NNHeRjol28k1SpA8893O9OXEQqKY4bypaEoSsInAubw18pllT7Fj4f6
 qXfxEX2mSnhX3HTXJpG2bJCP++zAWqurb5pVMSTvVwpVCz6/siuHUX5kfzovizYTrrUK
 +MDQ==
X-Gm-Message-State: AOJu0YxUlAw6Ij2Rm21nycpMM4HAqetoJGVSY56x59vuk2vAhavlfl1W
 8I20wEH/kkYaGKC58LKWWDYi1g==
X-Google-Smtp-Source: AGHT+IFgV4HhfEW9JpuKyS4PPckPyandM/7l2luJoep5247ZWT1PwsIpDurjnWsAH+jHe2L/UqNz2g==
X-Received: by 2002:a05:6a00:8d4:b0:68c:44ed:fb6 with SMTP id
 s20-20020a056a0008d400b0068c44ed0fb6mr2700296pfu.16.1696483030093; 
 Wed, 04 Oct 2023 22:17:10 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 k15-20020aa7820f000000b0068ff0a633fdsm431857pfi.131.2023.10.04.22.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 22:17:09 -0700 (PDT)
Message-ID: <772a2b33-9f6d-41ff-9ecf-d77b65624c66@daynix.com>
Date: Thu, 5 Oct 2023 14:17:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Undo incomplete mmap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230903053927.38037-1-akihiko.odaki@daynix.com>
 <619a188e-aaae-4d45-9aa5-bd9c4eac1a4d@daynix.com>
 <fea1c085-8b92-7d01-bedb-35cefb357df5@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <fea1c085-8b92-7d01-bedb-35cefb357df5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/04 5:42, Richard Henderson wrote:
> On 9/21/23 00:09, Akihiko Odaki wrote:
>> On 2023/09/03 14:39, Akihiko Odaki wrote:
>>> When the host page size is greater than the target page size and
>>> MAP_FIXED or MAP_FIXED_NOREPLACE is requested, mmap will be done for
>>> three parts: start, middle, and end. If a later part of mmap fail,
>>> mmap done in the earlier parts must be reverted.
>>>
>>> Fixes: 54936004fd ("mmap emulation")
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>> V1 -> V2: Rebased.
>>>
>>>   linux-user/mmap.c | 65 +++++++++++++++++++++++++++++------------------
>>>   1 file changed, 40 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>>> index 9aab48d4a3..72521f8d27 100644
>>> --- a/linux-user/mmap.c
>>> +++ b/linux-user/mmap.c
>>> @@ -224,13 +224,15 @@ int target_mprotect(abi_ulong start, abi_ulong 
>>> len, int target_prot)
>>>   /* map an incomplete host page */
>>>   static bool mmap_frag(abi_ulong real_start, abi_ulong start, 
>>> abi_ulong last,
>>> -                      int prot, int flags, int fd, off_t offset)
>>> +                      int prot, int flags, int fd, off_t offset, 
>>> bool *mapped)
>>>   {
>>>       abi_ulong real_last;
>>>       void *host_start;
>>>       int prot_old, prot_new;
>>>       int host_prot_old, host_prot_new;
>>> +    *mapped = false;
>>> +
>>>       if (!(flags & MAP_ANONYMOUS)
>>>           && (flags & MAP_TYPE) == MAP_SHARED
>>>           && (prot & PROT_WRITE)) {
>>> @@ -271,6 +273,7 @@ static bool mmap_frag(abi_ulong real_start, 
>>> abi_ulong start, abi_ulong last,
>>>               return false;
>>>           }
>>>           prot_old = prot;
>>> +        *mapped = true;
>>>       }
>>>       prot_new = prot | prot_old;
>>> @@ -448,7 +451,7 @@ abi_ulong mmap_find_vma(abi_ulong start, 
>>> abi_ulong size, abi_ulong align)
>>>   abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>>>                        int flags, int fd, off_t offset)
>>>   {
>>> -    abi_ulong ret, last, real_start, real_last, retaddr, host_len;
>>> +    abi_ulong ret, last, real_start, retaddr, host_len;
>>>       abi_ulong passthrough_start = -1, passthrough_last = 0;
>>>       int page_flags;
>>>       off_t host_offset;
>>> @@ -577,12 +580,16 @@ abi_long target_mmap(abi_ulong start, abi_ulong 
>>> len, int target_prot,
>>>           passthrough_start = start;
>>>           passthrough_last = last;
>>>       } else {
>>> +        abi_ulong middle_start = HOST_PAGE_ALIGN(start);
>>> +        abi_ulong middle_last = ((start + len) & 
>>> qemu_host_page_mask) - 1;
>>> +        abi_ulong mapped_len = 0;
>>> +        bool mapped;
>>> +
>>>           if (start & ~TARGET_PAGE_MASK) {
>>>               errno = EINVAL;
>>>               goto fail;
>>>           }
>>>           last = start + len - 1;
>>> -        real_last = HOST_PAGE_ALIGN(last) - 1;
>>>           /*
>>>            * Test if requested memory area fits target address space
>>> @@ -649,35 +656,26 @@ abi_long target_mmap(abi_ulong start, abi_ulong 
>>> len, int target_prot,
>>>           }
>>>           /* handle the start of the mapping */
>>> -        if (start > real_start) {
>>> -            if (real_last == real_start + qemu_host_page_size - 1) {
>>> +        if (start < middle_start) {
>>> +            if (last < middle_start) {
>>>                   /* one single host page */
>>>                   if (!mmap_frag(real_start, start, last,
>>> -                               target_prot, flags, fd, offset)) {
>>> +                               target_prot, flags, fd, offset, 
>>> &mapped)) {
>>>                       goto fail;
>>>                   }
>>>                   goto the_end1;
>>>               }
>>> -            if (!mmap_frag(real_start, start,
>>> -                           real_start + qemu_host_page_size - 1,
>>> -                           target_prot, flags, fd, offset)) {
>>> +            if (!mmap_frag(real_start, start, middle_start - 1,
>>> +                           target_prot, flags, fd, offset, &mapped)) {
>>>                   goto fail;
>>>               }
>>> -            real_start += qemu_host_page_size;
>>> -        }
>>> -        /* handle the end of the mapping */
>>> -        if (last < real_last) {
>>> -            abi_ulong real_page = real_last - qemu_host_page_size + 1;
>>> -            if (!mmap_frag(real_page, real_page, last,
>>> -                           target_prot, flags, fd,
>>> -                           offset + real_page - start)) {
>>> -                goto fail;
>>> +            if (mapped) {
>>> +                mapped_len = qemu_host_page_size;
>>>               }
>>> -            real_last -= qemu_host_page_size;
>>>           }
>>>           /* map the middle (easier) */
>>> -        if (real_start < real_last) {
>>> +        if (middle_start < middle_last) {
>>>               void *p, *want_p;
>>>               off_t offset1;
>>>               size_t len1;
>>> @@ -685,10 +683,10 @@ abi_long target_mmap(abi_ulong start, abi_ulong 
>>> len, int target_prot,
>>>               if (flags & MAP_ANONYMOUS) {
>>>                   offset1 = 0;
>>>               } else {
>>> -                offset1 = offset + real_start - start;
>>> +                offset1 = offset + middle_start - start;
>>>               }
>>> -            len1 = real_last - real_start + 1;
>>> -            want_p = g2h_untagged(real_start);
>>> +            len1 = middle_last - middle_start + 1;
>>> +            want_p = g2h_untagged(middle_start);
>>>               p = mmap(want_p, len1, target_to_host_prot(target_prot),
>>>                        flags, fd, offset1);
>>> @@ -697,10 +695,27 @@ abi_long target_mmap(abi_ulong start, abi_ulong 
>>> len, int target_prot,
>>>                       munmap(p, len1);
>>>                       errno = EEXIST;
>>>                   }
>>> +                if (mapped_len) {
>>> +                    munmap(g2h_untagged(middle_start - mapped_len), 
>>> mapped_len);
>>> +                }
>>> +                goto fail;
>>> +            }
>>> +            mapped_len += len1;
>>> +            passthrough_start = middle_start;
>>> +            passthrough_last = middle_last;
>>> +        }
>>> +
>>> +        /* handle the end of the mapping */
>>> +        if (last > middle_last) {
>>> +            abi_ulong real_page = middle_last + 1;
>>> +            if (!mmap_frag(real_page, real_page, last,
>>> +                           target_prot, flags, fd,
>>> +                           offset + real_page - start, &mapped)) {
>>> +                if (mapped_len) {
>>> +                    munmap(g2h_untagged(real_page - mapped_len), 
>>> mapped_len);
>>> +                }
>>>                   goto fail;
>>>               }
>>> -            passthrough_start = real_start;
>>> -            passthrough_last = real_last;
>>>           }
>>>       }
>>>    the_end1:
>>
>> Hi Richard,
>>
>> Can you have a look at this patch?
> 
> munmap isn't always correct -- one has to keep the virtual address space 
> allocated for reserved_va.  So mmap_reserve_or_unmap.
> 
> That said, I've got one reorg of mmap.c outstanding already, and I'm 
> planning another to allow use of softmmu in user-only mode.  The latter 
> would eliminate mmap_frag entirely.

That sounds great. I'll wait for the changes instead of pushing this 
forward.

Regards,
Akihiko Odaki

