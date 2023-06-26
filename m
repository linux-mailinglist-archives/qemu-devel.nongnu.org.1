Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 711E673DBCC
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:53:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDitZ-0003fC-UW; Mon, 26 Jun 2023 05:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDitX-0003eZ-SZ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:52:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDitS-0006Dv-FA
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:52:24 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-313e1c27476so1437625f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687773140; x=1690365140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NC8I14ZtPyuKbAdwhwO3FPUAUk89s1EhA4fooV2IDwM=;
 b=WgCDFgvloSQ0hGN6lpY9Oy2yxxvUIehGNQhalXv5IjpGmbRO4JxaYEhVFiqMDX+teX
 N10TP0xmeQjSEunZQsQn6PNa23mzLCHJzOUwAoIQQAsFNRCWcRmV/3wWKvv2gDby7z7m
 LVKwnbuBURbZXqE7BKzvrM8MJgQQLxE0uQi7BFJtlM4PWqKE94ZAh4xcvCbnHldpISur
 LeJ1LvZj459TggunNeFB1VTyxWr87WyL2UPJLZ/QCw940vSgifOsgnerFANy0YmAQ8Yy
 Oqa+8U9cjcjThcAaqjuAD7hvV1/lto+eJwUf8WmiadFPX1YV0dd3GCwgWR+KiIUBPfYu
 bsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687773140; x=1690365140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NC8I14ZtPyuKbAdwhwO3FPUAUk89s1EhA4fooV2IDwM=;
 b=XyQo95bI52sJ54YE99kc2VMT/B/b67TzmuSBmWv2nkvNyLMjVD6oplD8mXaSSjfUdp
 KHf2FAc2hah1UvDSmF3AmTQ9Xtg8vIAhmKKYG2KAjj4hvup5f0a6qDxBEUgsRUdG50/p
 rVhT9h7wUSK69VSKM44/UJ4azwZmN1u823T+mREAvYmTjsHiGoNu8qY8VidFtKEsYcNT
 cVzpGdi03aWH5JqemU4RaFrDQFITb/IfF1Yhf1mOmxVaHZcVUhb6gDL39Od1mGh082ly
 NenvhOQDkj0gojsmRGmaRGYFtfWbS+vvacFHEWQGg5G0Bn+66usPp+HLh6OAf3z4xqKr
 g6kg==
X-Gm-Message-State: AC+VfDwuGkG+Gu7cL9NgaHhTbXUDGcynFSTHSJxLsVINPFl6eTAm3pa7
 Kp6JSGJrMWfJTHMsrZML6rTFLA==
X-Google-Smtp-Source: ACHHUZ6wx3HKn7gu2sK2dkmmB9Kepcm2OzHRtd6COQ3B+190m5RNLigrcLvPAKiUfN/Vf7eLufoc6g==
X-Received: by 2002:a5d:430d:0:b0:30f:d052:2edb with SMTP id
 h13-20020a5d430d000000b0030fd0522edbmr25311266wrq.35.1687773140382; 
 Mon, 26 Jun 2023 02:52:20 -0700 (PDT)
Received: from [192.168.157.227] (141.pool92-176-132.dynamic.orange.es.
 [92.176.132.141]) by smtp.gmail.com with ESMTPSA id
 g17-20020a7bc4d1000000b003f9b1131a90sm7185423wmk.23.2023.06.26.02.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 02:52:19 -0700 (PDT)
Message-ID: <539281fe-4a75-34aa-e9f1-e88056a6947a@linaro.org>
Date: Mon, 26 Jun 2023 11:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: RFC: bsd-user broken a while ago, is this the right fix?
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Warner Losh <imp@bsdimp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <CANCZdfrHEQ=dMfpKGvYBHbXMfbQb9fDQh+bkdZW0Z6zQWVVUCA@mail.gmail.com>
 <ZJlMQQP7Y8r6Wrd7@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZJlMQQP7Y8r6Wrd7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/26/23 10:28, Daniel P. Berrangé wrote:
> Just CC'ing Richard to make sure it catches his attention.
> 
> On Sat, Jun 24, 2023 at 12:40:33AM -0600, Warner Losh wrote:
>> This change:
>>
>> commit f00506aeca2f6d92318967693f8da8c713c163f3
>> Merge: d37158bb242 87e303de70f
>> Author: Peter Maydell <peter.maydell@linaro.org>
>> Date:   Wed Mar 29 11:19:19 2023 +0100
>>
>>      Merge tag 'pull-tcg-20230328' of https://gitlab.com/rth7680/qemu into
>> staging
>>
>>      Use a local version of GTree [#285]
>>      Fix page_set_flags vs the last page of the address space [#1528]
>>      Re-enable gdbstub breakpoints under KVM
>>
>>      # -----BEGIN PGP SIGNATURE-----
>>      #
>>      # iQFRBAABCgA7FiEEekgeeIaLTbaoWgXAZN846K9+IV8FAmQjcLIdHHJpY2hhcmQu
>>      # aGVuZGVyc29uQGxpbmFyby5vcmcACgkQZN846K9+IV8rkgf/ZazodovRKxfaO622
>>      # mGW7ywIm+hIZYmKC7ObiMKFrBoCyeXH9yOLSx42T70QstWvBMukjovLMz1+Ttbo1
>>      # VOvpGH2B5W76l3i+muAlKxFRbBH2kMLTaL+BXtkmkL4FJ9bS8WiPApsL3lEX/q2E
>>      # 3kqaT3N3C09sWO5oVAPGTUHL0EutKhOar2VZL0+PVPFzL3BNPhnQH9QcbNvDBV3n
>>      # cx3GSXZyL7Plyi+qwsKf/3Jo+F2wr2NVf3Dqscu9T1N1kI5hSjRpwqUEJzJZ5rei
>>      # ly/gBXC/J7+WN+x+w2JlN0kWXWqC0QbDfZnj96Pd3owWZ7j4sT9zR5fcNenecxlR
>>      # 38Bo0w==
>>      # =ysF7
>>      # -----END PGP SIGNATURE-----
>>      # gpg: Signature made Tue 28 Mar 2023 23:56:50 BST
>>      # gpg:                using RSA key
>> 7A481E78868B4DB6A85A05C064DF38E8AF7E215F
>>      # gpg:                issuer "richard.henderson@linaro.org"
>>      # gpg: Good signature from "Richard Henderson <
>> richard.henderson@linaro.org>" [full]
>>      # Primary key fingerprint: 7A48 1E78 868B 4DB6 A85A  05C0 64DF 38E8
>> AF7E 215F
>>
>>      * tag 'pull-tcg-20230328' of https://gitlab.com/rth7680/qemu:
>>        softmmu: Restore use of CPU watchpoint for all accelerators
>>        softmmu/watchpoint: Add missing 'qemu/error-report.h' include
>>        softmmu: Restrict cpu_check_watchpoint / address_matches to TCG accel
>>        linux-user/arm: Take more care allocating commpage
>>        include/exec: Change reserved_va semantics to last byte
>>        linux-user: Pass last not end to probe_guest_base
>>        accel/tcg: Pass last not end to tb_invalidate_phys_range
>>        accel/tcg: Pass last not end to tb_invalidate_phys_page_range__locked
>>        accel/tcg: Pass last not end to page_collection_lock
>>        accel/tcg: Pass last not end to PAGE_FOR_EACH_TB
>>        accel/tcg: Pass last not end to page_reset_target_data
>>        accel/tcg: Pass last not end to page_set_flags
>>        linux-user: Diagnose misaligned -R size
>>        tcg: use QTree instead of GTree
>>        util: import GTree as QTree
>>
>>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> breaks bsd-user. when I merge it to the bsd-user upstream blitz branch I
>> get memory allocation errors on startup. At least for armv7.
>>
>> specifically, if I back out the bsd-user part of both
>> commit 95059f9c313a7fbd7f22e4cdc1977c0393addc7b
>> Author: Richard Henderson <richard.henderson@linaro.org>
>> Date:   Mon Mar 6 01:26:29 2023 +0300
>>
>>      include/exec: Change reserved_va semantics to last byte
>>
>>      Change the semantics to be the last byte of the guest va, rather
>>      than the following byte.  This avoids some overflow conditions.
>>
>>      Reviewed-by: Philippe Mathieu-Daud<C3><A9> <philmd@linaro.org>
>>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> and
>>
>> commit 49840a4a098149067789255bca6894645f411036
>> Author: Richard Henderson <richard.henderson@linaro.org>
>> Date:   Mon Mar 6 01:51:09 2023 +0300
>>
>>      accel/tcg: Pass last not end to page_set_flags
>>
>>      Pass the address of the last byte to be changed, rather than
>>      the first address past the last byte.  This avoids overflow
>>      when the last page of the address space is involved.
>>
>>      Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1528
>>      Reviewed-by: Philippe Mathieu-Daud<C3><A9> <philmd@linaro.org>
>>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> things work again. If I backout parts, it fails still. If I back out only
>> one of
>> the two, but not both, then it fails.
>>
>> What's happening is that we're picking a reserved_va that's overflowing when
>> we add 1 to it. this overflow goes away if I make the overflows not
>> possible:
>> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
>> index a88251f8705..bd86c0a8689 100644
>> --- a/bsd-user/mmap.c
>> +++ b/bsd-user/mmap.c
>> @@ -237,8 +237,8 @@ unsigned long last_brk;
>>   static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
>>                                           abi_ulong alignment)
>>   {
>> -    abi_ulong addr;
>> -    abi_ulong end_addr;
>> +    uint64_t addr;
>> +    uint64_t end_addr;
>>       int prot;
>>       int looped = 0;
>>
>> My question is, is this the right fix? The old code avoided the overflow in
>> two ways. 1 it set reserve_va to a page short (which if I fix that, it
>> works better, but not quite right). and it never computes an address that
>> may overflow (which the new code does without the above patch).

Not really correct, though it will work for the 32-bit guests.

You want to change end_addr to last_addr, which would be end_addr - 1, and do that 
basically everywhere. That's the only way to avoid overflow properly, and is what I'm 
settling on with page_set_flags et al.


r~

