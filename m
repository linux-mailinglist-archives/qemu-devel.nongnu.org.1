Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D776EDB3
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZzC-0004Eb-O3; Thu, 03 Aug 2023 11:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRZzA-0004Dw-CY
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:11:32 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRZz8-0004lp-MQ
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:11:32 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bbf8cb694aso9361495ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691075489; x=1691680289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qZxFFZOYVtKRu1/Yw3Pm1idsjCTVK+AKFFxJXeqtqt0=;
 b=WyxETsLA685Y/L3YhYxoFzchNbcAiLY08YGi6pUk7dfxHwgLlQOZNI7r89bJjCjQPU
 kLuTnKskkqxiBryyFHYbpTMP3C17YNA7j0DcqljiDZzj/uuRrSvjeTRf1yN2eQrYnEhe
 Mcxz2q+hTZmYqEwqGaQPdjeliYmU6gsSZr3gWLzDlFOZWTeq1FdkSMSqoQ3wc/m/1AE9
 uNne2dOTXcCfZmHLMVHBkeQwNrOjjjFCnoyjVdk/UpQCA1uAuPa/guLu1qaUHayp9oUJ
 R5oVGwvsdw8iGJFNns1xN8pP75z3R0vQi9L/dTCTcwWDsj9VH1U1qhqjhxXAouFPlTab
 bvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691075489; x=1691680289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qZxFFZOYVtKRu1/Yw3Pm1idsjCTVK+AKFFxJXeqtqt0=;
 b=FdfpfLQLUmgRucwpeYXR9Ux2AE/eYANctjBHHiG5iq+R0A6VrzV32qZnNjfMlZLLWc
 W4y+mBzWi1/pof8lFXo+U9rdpcAAEWOVBhnke3WB7XnVYUGx9GEEv/HlbEfXNKpqZKYP
 d3WfCpNYJ4T0VwGeQuL8GGY1Ax/BxPqU/tLd/fqdWErh0O5s/1j0cSEcB4IvN7BkyGY5
 LvwCMzQHsrLCqS0YbJz8GZikCMXbnouQ8DqCGq8mkSOvmt9RIIy5HDeHnaaaaTacuinj
 jOzMLXFgHrlWdHxFTWKarnMvOrW9E7u5UiUS5YNMkdMQC7v7Q4ksyTUlYw0y1SYdgv0g
 HLOg==
X-Gm-Message-State: ABy/qLY6RfOYVR7+d/WtfhJ+H7a0HoSaEER8uZpbZ+CR5NuBxtmko/iH
 sub0g4M4GGSthOTKHszsVlevpyFJsRtR0+n26Ps=
X-Google-Smtp-Source: APBJJlGAtkuJgjzXgd+n5KMJjr8+0aJ8LGQpn3/dtpBY2hVINzBp3BRVGNN99Oi/TmZLbF0aZQzmQg==
X-Received: by 2002:a17:902:9a06:b0:1bb:edd5:4644 with SMTP id
 v6-20020a1709029a0600b001bbedd54644mr16705266plp.68.1691075489095; 
 Thu, 03 Aug 2023 08:11:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a17090274c900b001bc445e249asm1397527plt.124.2023.08.03.08.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 08:11:28 -0700 (PDT)
Message-ID: <3b08c3df-3237-284d-564f-5f14a515d59e@linaro.org>
Date: Thu, 3 Aug 2023 08:11:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 00/14] linux-user: brk fixes
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
References: <20230803015302.407219-1-richard.henderson@linaro.org>
 <CACPK8XfNiGiprxYd-J+E-oFqPsRVPfQa7+e5hX8DFw0OudT85A@mail.gmail.com>
 <cd9b0651-475d-1b11-d648-594b52d48bd1@gmx.de>
 <CACPK8XcdO4KpBfUZmxLNRLLcAOfM9D39be=m4O72kO0+_GiuQQ@mail.gmail.com>
 <ZMvBTMpi9jDVWDiP@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZMvBTMpi9jDVWDiP@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 8/3/23 08:01, Helge Deller wrote:
> * Joel Stanley <joel@jms.id.au>:
>> On Thu, 3 Aug 2023 at 13:55, Helge Deller <deller@gmx.de> wrote:
>>>> 143551 brk(NULL) = 0x0009b000
>>>> 143551 brk(0x0009b8fc) = 0x0009b000
>>>
>>> I think the problem is the brk with 9b000 here.
>>> It's not 64k aligned (=pages size of your ppc64le).
>>>
>>> Please try with this patch on top of Richard's series:
>>>
>>>> @@ -3229,7 +3208,8 @@ static void load_elf_image(const char *image_name, int image_fd,
>>>>        info->end_code = 0;
>>>>        info->start_data = -1;
>>>>        info->end_data = 0;
>>>> -    info->brk = .....
>>> change that to become:
>>>       info->brk = HOST_PAGE_ALIGN(hiaddr);
>>
>> That stopped the crashing, and the binaries seem to run fine. I tested
>> on two hosts: ppc64le (64K) and arm64 (16K).
> 
> Great!
> 
> That made re-read Akihiko's patch:
> ----
> Author: Akihiko Odaki <akihiko.odaki@daynix.com>
>      linux-user: Do not align brk with host page size
> 
>      do_brk() minimizes calls into target_mmap() by aligning the address
>      with host page size, which is potentially larger than the target page
>      size. However, the current implementation of this optimization has two
>      bugs:
> 
>      - The start of brk is rounded up with the host page size while brk
>        advertises an address aligned with the target page size as the
>        beginning of brk. This makes the beginning of brk unmapped.
> ----
> this patch has wrong assumptions.
> 
> The start of brk always needs to be host page aligned.


There is a bunch of code in target_mmap that attempts to manage adjacent guest pages that 
fall into the same host page.  Akihiko's patch assumes that code actually works.  Which I 
think is entirely reasonable.

You can't move brk up like this either (without other adjustments to the binary mapping), 
since that will leave a hole in the guest address space, which can get filled with 
something else later, which will definitely cause problems.


r~

