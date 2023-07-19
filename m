Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B26E7597B6
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:06:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7nf-0005Ej-II; Wed, 19 Jul 2023 10:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM7ne-0005E9-0V
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:05:06 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM7nb-0000vL-1l
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:05:05 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3158a5e64b6so6547855f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689775501; x=1692367501;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qy5VA3K7ZoTHH/hHjnqJEbDGSLWCsiPOtNqfY8hf4Rk=;
 b=kwoljZ+52L9DuQZ8slNIKSUVEPNa0b3/1fLwEKNEv3PVI4F+cFbytjpBVL/LvoBtSe
 710NArMMlJAtzCNLfDoaM0qVOoVYfGA0jqVS3wbKf5vCJjkPi3VCYS9F2Vt6zwZIUyDL
 NZs8q2Y4SNRRqBt+RIJQCL37ymASACXolxXyI0duLY9/AkkESmMA40oU37oiPzTfMujN
 0fa82/+zoK7MsjwXE3bJL+SChFozFpE0HzdQ2yw9EdzcfhfW7yINhgNjMCHzE9hVRH8Q
 5xpdWF98P0Ej8vV/dW3vJV1okhYCX+kbBdEqmiaB9VrPJUjTX/JBStFcOt83KZlzjK63
 ZQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689775501; x=1692367501;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qy5VA3K7ZoTHH/hHjnqJEbDGSLWCsiPOtNqfY8hf4Rk=;
 b=IXsdLLVXyqWD6K+zYBGTX7rb0Iu2Ka/MVoJbZekuiaILyNTbjMYGV9qLws46KkOAsf
 U+qRIiMpZHuTT6GLwS75a2x5l3/t33OC0u+UiS5ht2xK3uoxWGCiVQ0ggyb85pYBmQ/F
 WDJ64FsuKZa5K4/WrBDWwpr93wPUcGXTQGGCUAvc18Dz9Ghic+PUAleZqkjWQtoObQeS
 hlx0VHW6KWlzflGp1+HWZ9ULAcgD2iY1tCfR/bRcuNPDUE56luR8uJ4p/38DOsHcS3NG
 2V2CkojboejV3s9rsGXiKQgHCWt+bBYy8Ozd2a3bKGI+ivDgcK+5XtoZkWGmdi2S4+Kf
 Ugzw==
X-Gm-Message-State: ABy/qLYeM0apz75fJamRJMIgZY6ngXiIPIgwxWKjVNETt1cy/C7+hj4Y
 +i6/hA9cgVSOXpzOjJC/YIS7dA==
X-Google-Smtp-Source: APBJJlHakLoxcGPrdtIffcuIK81BoqBQUKcv2GK27bT8ryObLTqc5oEHSFBUcu6huHoAsqsY0snjsA==
X-Received: by 2002:adf:fe49:0:b0:314:1ca4:dbd9 with SMTP id
 m9-20020adffe49000000b003141ca4dbd9mr14233056wrs.27.1689775500983; 
 Wed, 19 Jul 2023 07:05:00 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4147000000b00314374145e0sm5391301wrq.67.2023.07.19.07.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 07:05:00 -0700 (PDT)
Message-ID: <2a14dc9b-f5a3-191b-9382-0c1b4f66e6d2@linaro.org>
Date: Wed, 19 Jul 2023 16:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/14] tcg/{i386, s390x}: Add earlyclobber to the
 op_add2's first output
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-7-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230719094620.363206-7-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 19/7/23 11:44, Ilya Leoshkevich wrote:
> i386 and s390x implementations of op_add2 require an earlyclobber,
> which is currently missing. This breaks VCKSM in s390x guests. E.g., on
> x86_64 the following op:
> 
>      add2_i32 tmp2,tmp3,tmp2,tmp3,tmp3,tmp2   dead: 0 2 3 4 5  pref=none,0xffff
> 
> is translated to:
> 
>      addl     %ebx, %r12d
>      adcl     %r12d, %ebx
> 
> Introduce a new C_N1_O1_I4 constraint, and make sure that earlyclobber
> of aliased outputs is honored.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 82790a870992 ("tcg: Add markup for output requires new register")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tcg/i386/tcg-target-con-set.h  | 2 +-
>   tcg/i386/tcg-target.c.inc      | 2 +-
>   tcg/s390x/tcg-target-con-set.h | 5 ++---
>   tcg/s390x/tcg-target.c.inc     | 4 ++--
>   tcg/tcg.c                      | 8 +++++++-
>   5 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
> index 91ceb0e1da2..cb4b25263e9 100644
> --- a/tcg/i386/tcg-target-con-set.h
> +++ b/tcg/i386/tcg-target-con-set.h
> @@ -53,4 +53,4 @@ C_O2_I1(r, r, L)
>   C_O2_I2(a, d, a, r)
>   C_O2_I2(r, r, L, L)
>   C_O2_I3(a, d, 0, 1, r)
> -C_O2_I4(r, r, 0, 1, re, re)
> +C_N1_O1_I4(r, r, 0, 1, re, re)

While here, please update the comment in header. Although the
description is not arch-specific; include/tcg/tcg.h or tcg/tcg.c
could hold it.

The patch LGTM but I don't feel confident enough to add a R-b tag.
If it still miss a R-b tag in a pair of days I'll have a deeper
look at it.

Regards,

Phil.

