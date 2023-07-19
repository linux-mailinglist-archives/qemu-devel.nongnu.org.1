Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC697594C1
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 14:09:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM5z2-0000YK-8e; Wed, 19 Jul 2023 08:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM5z0-0000XW-Bv
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:08:42 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM5yy-0003HI-DJ
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:08:41 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31716932093so949867f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689768518; x=1692360518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CWRjXCB00XnSrrh95nA1JCnw9WxZxcfAIgiT4e43tlQ=;
 b=S6xWfHsRqloxqj94t5qzaUuK5wiOgFpu7huGW+xCLn+uABkpupQ9jXwpkfgn3FfjJR
 4p7Xu0qGiBf51KdHGSupBddQWZmF78zS/CCWYag6JB4k6+JLka0BJ5EHe+i/gwH3KdRt
 gJN6sxnNNqN7CnCtQ7YPNdYgFw8XX0chdtWjGxBKzvHziXAxc9iSx1280S5yFuBmrR/p
 VrNd26O7qUUp1nI66BpcdiGkAhvAK5NEN1cZ+/mWdUgpXPsdZmbRvW8Kgj4KIkRxcG7H
 YADbzL+71fcuVgw3wWlQKHhYs5ZG6UVFKqufXhY7gSESiQ1aq6B4/vQyFjNiqdkEi0MG
 CZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689768518; x=1692360518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CWRjXCB00XnSrrh95nA1JCnw9WxZxcfAIgiT4e43tlQ=;
 b=IYqZUzHzTVExt7Nr1PYcnL+cDPCKknReT9oC3XUjcP5HI7WYcolnMSpMmXUkbQGFUm
 kRBDCbKPvWG+AcvRF1fGbt8OtfWCvQGBYYiO5RYTQPAoCL3onMPr9a4SVPZQ3606xe1v
 wkk71FKQA7oj81Ut9wabEIg5ricVM/SE04HPNDQjBCGR0GtIwvYeZ9rb0d4s896JKjfn
 g/EZCPwnFlb9goCiqYvw1VI9JXyK62ZBmeW/99izYjQZnYHM3BRTZHidwV0E65Z2v4iB
 e81gmVbo++VOXTjRFzwhK3ihESLPzGfq0ToHFR/xlbytdOccpcDfmpgfMVW0RqEyMO3s
 56WA==
X-Gm-Message-State: ABy/qLZEGNJqaMKrZ6b8qz9xiMwVRAN12YOCy+T9SkmpkrJvzGke0iBC
 97c4Lkp0vl94tCih8whHhCFRCA==
X-Google-Smtp-Source: APBJJlFOJb28Ot72TBAWUhB5ch8NwboEJH6+i8hq1JHwk9wJLPcask4QYjfwEOVk7z44zc2LWgg+3Q==
X-Received: by 2002:adf:f14d:0:b0:313:fe1b:f444 with SMTP id
 y13-20020adff14d000000b00313fe1bf444mr2100650wro.68.1689768517688; 
 Wed, 19 Jul 2023 05:08:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a5d49d2000000b0030647449730sm5174130wrs.74.2023.07.19.05.08.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 05:08:37 -0700 (PDT)
Message-ID: <61be191f-c1b1-cfbc-d50a-1ee9cdd7d667@linaro.org>
Date: Wed, 19 Jul 2023 14:08:35 +0200
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
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi Ilya,

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


> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 652e8ea6b93..ddfe9a96cb7 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -648,6 +648,7 @@ static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
>   #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2),
>   #define C_O2_I3(O1, O2, I1, I2, I3)     C_PFX5(c_o2_i3_, O1, O2, I1, I2, I3),
>   #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4),
> +#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4),

No need for O2. Also can you place it earlier just after C_N1_I2?

-- >8 --
@@ -643,6 +643,7 @@ static void tcg_out_movext3(TCGContext *s, const 
TCGMovExtend *i1,
  #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, 
I3, I4),

  #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2),
+#define C_N1_O1_I4(O1, I1, I2, I3, I4)  C_PFX5(c_n1_o1_i4_, O1, I1, I2, 
I3, I4),

  #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1),
  #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2),
---

Thanks,

Phil.

