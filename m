Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B177182A3C9
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:14:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNgpO-0002fF-Cp; Wed, 10 Jan 2024 17:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNgpB-0002f5-0U
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:13:25 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNgp8-00082h-Cn
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:13:24 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d9af1f52bcso2458581b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704924800; x=1705529600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NUIq2JSFXzRKcxQi031nqn7Z14OJlcBGvqH6MIFJrh8=;
 b=fWaBv3PlNxlnNZX/k1SraYNpBhw/1YtWbx+NraDVQvjDOyAx+M1+PpUs41Ik6z+d30
 WXBseYHsZzlhQyfg6AksdfSOU/q80wJEoXPvENxg7ylFdgCmCjjlC10NIwZDqlbHrdbk
 A2QBbjRbh0g+yJrqFjT42Vb1PNNP3ms4wGf5Wf0wKAbRI1oVLvpTnz3Fz6J7Ht5hXY2e
 SgjFxj/wdIBMKtqLwhZmYtRkfrsWkcl0boNCxwV2GSv+RuD52SVbdKecZUWPCcMuv9z7
 vS+51s5uOWOJ3MIR8tOjxNl0cWP/g7umXMp9dnl30GFYITqMFqAzN/A1FsM43BYKoeS3
 EAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704924800; x=1705529600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NUIq2JSFXzRKcxQi031nqn7Z14OJlcBGvqH6MIFJrh8=;
 b=H8k49SWLoO1h0Qlv+m72t2yhyEagrnoz23QqX42mP1zyQ1mIJ0P15HZMVlA05odXT0
 Ss7BQHrxyolGYQN3WpfbmhccPHNiqSYj6wVGZqLHh+pZnOGBeHGp+JxSuT1xPc0Gjv3o
 SjtJlCKGUXqNtWKXvO9vUHmsxjwH0xC2v3FCak3qPj4wtodj+3SYs4E9jkLa1sZFVhfl
 7OzJ/7w4MxUAroNZ/eNbOhXgBwzhbYLMNTQ5q786JGqbBTjaPPnRKE5JABu1usbltfVh
 GJTM7ItDfQKWXBK8+Lw7PAZIzeW3hY1JOfapDrIkFjTpNFlenUkO/HG/H3YeusnFmi1h
 F73g==
X-Gm-Message-State: AOJu0YyDxWKyXcjMbdgxXV7QvJO1T5Ijh9/sJRnYwIrmjDi4/RJE/paq
 q0swA9p25alJ4EZrO5VPkP8YyTloOLJQXw==
X-Google-Smtp-Source: AGHT+IE2rFoFC9lIQmAGOBO62FgY0YZhQnzQI/AGaEg84tBc6cE/QY4C1eyBaV6JUXhOueSHoW9Rpw==
X-Received: by 2002:a05:6a20:8405:b0:197:1e78:8a79 with SMTP id
 c5-20020a056a20840500b001971e788a79mr114173pzd.50.1704924800207; 
 Wed, 10 Jan 2024 14:13:20 -0800 (PST)
Received: from [192.168.40.227] ([172.58.27.160])
 by smtp.gmail.com with ESMTPSA id
 mf6-20020a17090b184600b0028dd956835bsm308556pjb.2.2024.01.10.14.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 14:13:19 -0800 (PST)
Message-ID: <7c278618-3094-4978-85a5-4074f79e97fa@linaro.org>
Date: Thu, 11 Jan 2024 09:12:34 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/33] linux-user/arm: Remove qemu_host_page_size from
 init_guest_commpage
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-8-richard.henderson@linaro.org>
 <070c8e36-b208-4f3a-9725-64a3deaf9441@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <070c8e36-b208-4f3a-9725-64a3deaf9441@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/8/24 20:38, Pierrick Bouvier wrote:
> On 1/2/24 05:57, Richard Henderson wrote:
>> Use qemu_real_host_page_size.
>> If the commpage is not within reserved_va, use MAP_FIXED_NOREPLACE.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/elfload.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 4fcc490ce6..2e2b1b0784 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -459,6 +459,7 @@ enum {
>>   static bool init_guest_commpage(void)
>>   {
>>       ARMCPU *cpu = ARM_CPU(thread_cpu);
>> +    int host_page_size = qemu_real_host_page_size();
>>       abi_ptr commpage;
>>       void *want;
>>       void *addr;
>> @@ -471,10 +472,12 @@ static bool init_guest_commpage(void)
>>           return true;
>>       }
>> -    commpage = HI_COMMPAGE & -qemu_host_page_size;
>> +    commpage = HI_COMMPAGE & -host_page_size;
>>       want = g2h_untagged(commpage);
>> -    addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
>> -                MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>> +    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
>> +                MAP_ANONYMOUS | MAP_PRIVATE |
>> +                (commpage < reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
>> +                -1, 0);
>>       if (addr == MAP_FAILED) {
>>           perror("Allocating guest commpage");
>> @@ -487,12 +490,12 @@ static bool init_guest_commpage(void)
>>       /* Set kernel helper versions; rest of page is 0.  */
>>       __put_user(5, (uint32_t *)g2h_untagged(0xffff0ffcu));
>> -    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
>> +    if (mprotect(addr, host_page_size, PROT_READ)) {
>>           perror("Protecting guest commpage");
>>           exit(EXIT_FAILURE);
>>       }
>> -    page_set_flags(commpage, commpage | ~qemu_host_page_mask,
>> +    page_set_flags(commpage, commpage | (host_page_size - 1),
>>                      PAGE_READ | PAGE_EXEC | PAGE_VALID);
>>       return true;
>>   }
> 
> To confirm if I understand correctly, when using a reserved va, the contiguous address 
> space is reserved using mmap, thus MAP_FIXED_NOREPLACE would fail when hitting it?

Correct.

r~

