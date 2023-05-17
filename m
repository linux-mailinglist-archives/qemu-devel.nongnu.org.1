Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDFD7071C9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 21:17:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzMdL-00045D-N3; Wed, 17 May 2023 15:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzMdJ-00042m-Fx
 for qemu-devel@nongnu.org; Wed, 17 May 2023 15:16:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzMdH-0001aD-B4
 for qemu-devel@nongnu.org; Wed, 17 May 2023 15:16:21 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64388cf3263so839333b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 12:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684350978; x=1686942978;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uwt9mMEo1lX89waUnshT7h4N5vb7eMeq98zxfBeSbB0=;
 b=vVYrHu4T5YtlM61vtcnOyAIDCaD5kUadjr37f8ZbB2LKhE+uB0PQJ20cEyikrmMrW5
 Yl82PNE1GsmFCxB2EflhW1PeRUChJfmW5UAPgGasoOs7n4q6p9N4Gstugz8m+XpMpisK
 L1oAKV0rlWTHB6ej7JA9TPPprUEFsNPNcZUrlXCK/RW38JIqBhvMvwWwTGfIqKh7ev09
 /s/gdAGtDgWX/kpkiRZCRFd6jIVVc8di2vVSjMnDqem8uLY3PPrf6NYcGmXsJltxrQwT
 GA/ETGJLUsWrRQnWU74ovzhro/wFnjr9YdRfqxju0H4TaGNWay2buBGlo3cLMhOF3qnE
 gzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684350978; x=1686942978;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwt9mMEo1lX89waUnshT7h4N5vb7eMeq98zxfBeSbB0=;
 b=IrGtLGrYlcMrKEGPOi1vEok6k/8P/5SUDZOU+wJa7EQei+gWgjvDnE0jUmAu3xjm2b
 ps5dNlVf0RHvEs1tmqR4k13L60xpBxrELyKs7m6a7QrXmnvX/PxStGhQPAqySE0PlA8o
 vzqyTbpEnWHJU5QVHsN5ZybIICS8ejwad4SapSRSrxuN29ar96W/9Vck4hLMjUkwrEVv
 z0YQTU4D0KadNnz+qvn1hhHHiZq+3dCIYHRNcLZgfQ2TyU79vtow2lzBBxmeanhnXMYx
 mRtTFecNmf7e4bGyroU6P1jkPN7EWmB8rJ1vDo1DmboEbQlqdT0/TSa6bDnpzzwUeCZI
 FeBw==
X-Gm-Message-State: AC+VfDwTZaZ8Tq5ciq4lKwP2B6W7ZETCj0174PT1UQtGkAOhU+wVvAa8
 +Z07hGY7/vZIRLNCEJbgd3TDhQ==
X-Google-Smtp-Source: ACHHUZ4V5z1GOapssL9P9QVMuM/ef2LnVeKKfOrEHzlkd6Tq4F89cVFjWyZMOBgIrcL8jyNmPqCltA==
X-Received: by 2002:a05:6a20:12c9:b0:100:b715:8ab2 with SMTP id
 v9-20020a056a2012c900b00100b7158ab2mr45913835pzg.46.1684350977843; 
 Wed, 17 May 2023 12:16:17 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a17090a060200b002532ddc3a00sm2039413pjj.15.2023.05.17.12.16.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 12:16:17 -0700 (PDT)
Message-ID: <c75639e5-6e33-67e7-5619-adcbc2dae1d5@linaro.org>
Date: Wed, 17 May 2023 12:16:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 00/80] tcg patch queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
 <CAFEAcA-rw7-Ptrp47zE7+AxTEWvMez0u8Ur97=f3f4uZjokdaQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-rw7-Ptrp47zE7+AxTEWvMez0u8Ur97=f3f4uZjokdaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
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

On 5/17/23 08:11, Peter Maydell wrote:
> On Tue, 16 May 2023 at 20:48, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The following changes since commit 8844bb8d896595ee1d25d21c770e6e6f29803097:
>>
>>    Merge tag 'or1k-pull-request-20230513' of https://github.com/stffrdhrn/qemu into staging (2023-05-13 11:23:14 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230516
>>
>> for you to fetch changes up to ee95d036bf4bfa10be65325a287bf3d0e8b2a0e6:
>>
>>    tcg: Split out exec/user/guest-base.h (2023-05-16 08:11:53 -0700)
>>
>> ----------------------------------------------------------------
>> tcg/i386: Fix tcg_out_addi_ptr for win64
>> tcg: Implement atomicity for TCGv_i128
>> tcg: First quarter of cleanups for building tcg once
>>
>> ----------------------------------------------------------------
>> Richard Henderson (80):
>>        tcg/i386: Set P_REXW in tcg_out_addi_ptr
>>        include/exec/memop: Add MO_ATOM_*
>>        accel/tcg: Honor atomicity of loads
> 
> Didn't we determine yesterday that what we were doing in this patch
> didn't work (because it assumes that the compiler atomic load
> builtins for 128 bits will never do a store) ?

So we did, but I was still thinking in terms of the per-host customization, which I did 
hold back.  I'll address it this week.  Sorry about that.


r~


