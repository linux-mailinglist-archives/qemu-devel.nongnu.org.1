Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00591828F25
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 22:48:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNJwi-0005tp-6p; Tue, 09 Jan 2024 16:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNJwf-0005rr-Kn
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:47:37 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNJwd-0002iC-5r
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:47:37 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6dddfdc3244so949190a34.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 13:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704836853; x=1705441653; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z6mlmKKl0dxnFYQ96TgJKXaPpEa7mLFTUa1Gacpiv+8=;
 b=F2tmwsbyTsRY4fwgoVpVhdbG3mdmcVwY3oPLVGyib36AZDxBheG7Y8nkpYBs9VKI9S
 66jmq7Eh1V3E/7FX9fT3DCqXVG4cObUyIfwTHEZOMaLPuUruXxIxNCBxJKa1K4epZoug
 +cJ850GPJDZtRvcEmD8ucs2wg1/7j+QbPoRT9z3cFpU2G9Awo/GlaK05813IF0QsUVTg
 7Cj/h6AZK4K9rT5bTQBJxUDwOEHq/MRFgnmaYAVY252lCcbzRUK2iKvbXB82eBfh+bVF
 LGJdwlHyOxThI3+GOov8NnYi7Fsme/FJgOgBFbPxGaj4vgfO22OaRZEQIvF+InJx0jGv
 /GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704836853; x=1705441653;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z6mlmKKl0dxnFYQ96TgJKXaPpEa7mLFTUa1Gacpiv+8=;
 b=cp5fjydDrCCUwpY8hwTiDND2IUeKjMxjsulDB1nVImpyHTAO5i1xTv6OAGQZwwfb1d
 tEqZ02eMqWzrTWKnGiYdRN/mU4BBLHAo/vO/ZBbOEhIr2uPDFHXOHnd1jA80ibI1XAoa
 V71Gtxds5MfpuQaRbPu58eQlhsH7hrwkZGkbugbR75A+FYMgLMgx/wdFz/vZXnbOZpDx
 njAb0NUzaAVfIg8sRvmBB2vbhKJ+Stu6dENrd4+t4HYmsft2aHet9dJ2PLIVraSXuqMe
 dJBBePXvubmbmvUh2ai9AgGgyUOiBT+3/TF5K7ZpJbRb6/wI/XK8B8sCg9AOJ06m4+T2
 E4ow==
X-Gm-Message-State: AOJu0Yzq1S0ksjOdHw9IWKKkYqRbFvaZg2G0VLgHeOnQBZrVVJof8Npd
 5gRxc5kh230PzDa3ljdCm2aGH7sb1kTWkw==
X-Google-Smtp-Source: AGHT+IEqrgWcZo5HjHrAQ+SlypPQNRY8cRFDcKpwyoi7GrqHj+UdgUPe9e3qicO9EMDtCr1viG263Q==
X-Received: by 2002:a05:6870:b622:b0:204:126d:85b5 with SMTP id
 cm34-20020a056870b62200b00204126d85b5mr139430oab.38.1704836852809; 
 Tue, 09 Jan 2024 13:47:32 -0800 (PST)
Received: from [192.168.44.231] ([172.58.109.85])
 by smtp.gmail.com with ESMTPSA id
 tp15-20020a0568718b8f00b00205e506c00fsm648824oab.49.2024.01.09.13.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 13:47:32 -0800 (PST)
Message-ID: <c0bef257-4d1a-4660-a351-ff5dc240723c@linaro.org>
Date: Wed, 10 Jan 2024 08:47:21 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user: Allow gdbstub to ignore page protection
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20240108233821.201325-1-iii@linux.ibm.com>
 <20240108233821.201325-2-iii@linux.ibm.com>
 <0195c274-0d5c-484b-9475-84a4d16bfae8@linaro.org>
 <139c997f23a3e7edd8334de124d0ba7820cf6dc9.camel@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <139c997f23a3e7edd8334de124d0ba7820cf6dc9.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/10/24 06:39, Ilya Leoshkevich wrote:
> On Wed, 2024-01-10 at 04:42 +1100, Richard Henderson wrote:
>> On 1/9/24 10:34, Ilya Leoshkevich wrote:
>>> gdbserver ignores page protection by virtue of using
>>> /proc/$pid/mem.
>>> Teach qemu gdbstub to do this too. This will not work if /proc is
>>> not
>>> mounted; accept this limitation.
>>>
>>> One alternative is to temporarily grant the missing PROT_* bit, but
>>> this is inherently racy. Another alternative is self-debugging with
>>> ptrace(POKE), which will break if QEMU itself is being debugged - a
>>> much more severe limitation.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    cpu-target.c | 55 ++++++++++++++++++++++++++++++++++++++---------
>>> -----
>>>    1 file changed, 40 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/cpu-target.c b/cpu-target.c
>>> index 5eecd7ea2d7..69e97f78980 100644
>>> --- a/cpu-target.c
>>> +++ b/cpu-target.c
>>> @@ -406,6 +406,15 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr
>>> addr,
>>>        vaddr l, page;
>>>        void * p;
>>>        uint8_t *buf = ptr;
>>> +    int ret = -1;
>>> +    int mem_fd;
>>> +
>>> +    /*
>>> +     * Try ptrace first. If /proc is not mounted or if there is a
>>> different
>>> +     * problem, fall back to the manual page access. Note that,
>>> unlike ptrace,
>>> +     * it will not be able to ignore the protection bits.
>>> +     */
>>> +    mem_fd = open("/proc/self/mem", is_write ? O_WRONLY :
>>> O_RDONLY);
>>
>> Surely this is the unlikely fallback, and you don't need to open
>> unless the page is
>> otherwise inaccessible.
> 
> Ok, I can move this under (flags & PAGE_*) checks.
> 
>> I see no handling for writes to pages that contain TranslationBlocks.
> 
> Sorry, I completely missed that. I'm currently experimenting with the
> following:
> 
> 	/*
> 	 * If there is a TranslationBlock and we weren't bypassing
> host
> 	 * page protection, the memcpy() above would SEGV, ultimately
> 	 * leading to page_unprotect(). So invalidate the translations
> 	 * manually. Both invalidation and pwrite() must be under
> 	 * mmap_lock() in order to prevent the creation of another
> 	 * TranslationBlock in between.
> 	 */
> 	mmap_lock();
> 	tb_invalidate_phys_page(page);
> 	written = pwrite(fd, buf, l, (off_t)g2h_untagged(addr));

I would use here tb_invalidate_phys_range(addr, addr + l - 1),
but otherwise, it looks good.


r~

> 	mmap_unlock();
> 
> Does that look okay?
> 
> [...]


