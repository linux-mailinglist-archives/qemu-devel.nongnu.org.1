Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E256479F4E2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 00:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgYHN-0007j4-A7; Wed, 13 Sep 2023 18:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgYHK-0007iC-Gr
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:24:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgYHI-0000S3-Cb
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:24:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso2367765ad.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694643846; x=1695248646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5luaKmPsVcUi2NnpV0mmnLlASFEM7TrHnpLk+frE6bw=;
 b=RGqfxB2Btnz7MRYujSOeAV2x2H/eUnU9ulOZq3ZYzSGfUpdxN6ko/izlNocbaCy8ZX
 dwE/eYRJ5VpYc6PSxjuopbZPCIRhNSxVQNRD1zcIfqD+r0LANxOAGg5paK+D0pOB6Uoy
 OBtXB9q0p+EvhO1aNf8SONKk84PrurtzE6ZtRRHCqlweayQeYjISXS4AaQdKy7d5UdV/
 noilW7MMJDOzUqr3grKJQq4KxuC9SiCdIXGGkhYmJeXcV2X8W072yianyvVFdp/LFWrn
 jn/DpU2CcKhqVtvxeTTnF3QMPkbkMnYyFOFJpMV7HTYzbpbEUQPo7p2B382wSZeBGsgX
 qYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694643846; x=1695248646;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5luaKmPsVcUi2NnpV0mmnLlASFEM7TrHnpLk+frE6bw=;
 b=XlmbByU5QwXBa46XWDiSlujOMp/8mTq8ffPK+1mKmPYJjHCradQ0lIOfZ24OIELbhz
 zEmKITc1DnvSncKYtdC7J/VZ3h3E+SndzlKcpdFPQuo+9+CKdV1+MhKjV5f2djCbyohK
 dQ4KYBH/paCMQEPPc36OMUosBo0GWEj+ye9HUsTcY+mknKHAx3+fxiEoSDns2fBGVD5A
 SSrU9Bb+yFjMBSAxt3yRXfv8oIWmTrvwi6at9U99B2Ev6j1mgOGetUmtLFedoscz9Y2e
 zQ6wqeHszh5oFuu8Ujltrf4N2CCDG3xdDnE2ABg2cNsyxgmqS5Rn6xJrLsIYZlV+GtyU
 pK+A==
X-Gm-Message-State: AOJu0YwODaseVhvD6Jvl3UWkwqu4T9BN4NN+l/ipQVxvbYpTBp33hhnG
 Kxt9H/C8nYmj2cQ4VRtz5GCY3Q==
X-Google-Smtp-Source: AGHT+IHKD0hDyWOCPXScmg7+el5GfCMXOZRUynXiWrGRjrFxNlG1FrIAi92mur5/aGLxBYFXemcM5g==
X-Received: by 2002:a17:903:2351:b0:1c0:ee60:470a with SMTP id
 c17-20020a170903235100b001c0ee60470amr5171961plh.66.1694643846442; 
 Wed, 13 Sep 2023 15:24:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 iw12-20020a170903044c00b001c32fd9e412sm122651plb.58.2023.09.13.15.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 15:24:05 -0700 (PDT)
Message-ID: <f6a452cb-4eb3-95b2-cdf1-6ed9e9502693@linaro.org>
Date: Wed, 13 Sep 2023 15:24:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 17/23] bsd-user: Implement mincore(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-18-kariem.taha2.7@gmail.com>
 <d019b498-d0ef-e006-a0c3-a2dfa29a5d35@linaro.org> <874jjx91fi.fsf@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <874jjx91fi.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/13/23 15:02, Karim Taha wrote:
> Richard Henderson <richard.henderson@linaro.org> wrote:
> 
>> On 9/9/23 12:36, Karim Taha wrote:
>>> From: Stacey Son <sson@FreeBSD.org>
>>>
>>> Signed-off-by: Stacey Son <sson@FreeBSD.org>
>>> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
>>> ---
>>>    bsd-user/bsd-mem.h            | 22 ++++++++++++++++++++++
>>>    bsd-user/freebsd/os-syscall.c |  4 ++++
>>>    2 files changed, 26 insertions(+)
>>>
>>> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
>>> index 0e16051418..1dabbe36e6 100644
>>> --- a/bsd-user/bsd-mem.h
>>> +++ b/bsd-user/bsd-mem.h
>>> @@ -189,4 +189,26 @@ static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
>>>        return get_errno(minherit(g2h_untagged(addr), len, inherit));
>>>    }
>>>    
>>> +/* mincore(2) */
>>> +static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
>>> +        abi_ulong target_vec)
>>> +{
>>> +    abi_long ret;
>>> +    void *p;
>>> +    abi_ulong vec_len = DIV_ROUND_UP(len,TARGET_PAGE_SIZE);
>>> +
>>> +    if (!guest_range_valid_untagged(target_addr,len) || !page_check_range(target_addr, len, PAGE_VALID)) {
>>> +        return -TARGET_EFAULT;
>>> +    }
>>> +
>>> +    p = lock_user(VERIFY_WRITE, target_vec, vec_len, 0);
>>> +    if (p == NULL) {
>>> +        return -TARGET_EFAULT;
>>> +    }
>>> +    ret = get_errno(mincore(g2h_untagged(target_addr), len, p));
>>> +    unlock_user(p, target_vec, 0);
>>
>> You don't need the lock/unlock_user at all.  It is wrongly checking for WRITE.
>>
>>
>> r~
>>
> AFAIU, the host is writing to the target's memory, right?

Oops, I misread this.  The lock/unlock is for the output vector,
which means you do need it.

You also need unlock_user(p, target_vec, vec_len).

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

