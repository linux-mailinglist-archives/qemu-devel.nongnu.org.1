Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B5B724C8F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6c2w-0005tQ-OY; Tue, 06 Jun 2023 15:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6c2v-0005s6-9u
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:08:45 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6c2s-0003b6-Cc
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:08:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f6dfc4dffaso55747415e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686078520; x=1688670520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wOrDBTzQ9E+uGKXbx+R7xonXW0NREdkS+vLXdo+bW9o=;
 b=BzB0ksE3egzjUpV99CzhAupYsGfFQq9u4lLJ+ftWmhf5MA48UNXHxM/5ov1WurYdNt
 r5hVqXDc0nIFDkVvmYFFI7+9iP8cyNwqu4q61yiXsDfGwe1dorG6t462Sq8RFBcWH3rh
 T4/58c4lN4ccTnamcdBg9cSOikpR22f1SHqRObygxccjEIb5YfsWWsjPs4QwPgFoepm9
 FcZ04Uyi36OG/zLUns72JgpWBRlUjNmJgd7sxn2oxk6+9gUYcUNQjPQ7fJJIpR0wKFvT
 mK4RcPXIWMuVgyLkgXVlyDwTh7+/x3mJ8INKms88/JiJFym4OttAERXz5ziGXpZbsnpD
 rnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078520; x=1688670520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wOrDBTzQ9E+uGKXbx+R7xonXW0NREdkS+vLXdo+bW9o=;
 b=TMkqTVs9b1z2E+m/sEY0nZaJNiBMjfJyDbydJ6vvh0VBQJJA24b+yvm8SZvArHilbR
 KONOla7DvAolLtCWvTt2IU7QcCkp1rs9PFpK3RLM8jCAjDt1eADebX/s7Vhv104/qHgV
 uW/hjR5PRjeuZXWog1O3703e9pv+gqxC9js9ckjL5WuiT9BZodPQBI92QO5K86gxqpA2
 WazJYKj2ZdfOxxaTyYskLUY8hsmO9t5C6qe12muEfFKulDe9BKEZnLknUyUvBZOUIQef
 XmLrxo/8obwOS5sxEN2+b1AFIZ6M2HN3SGfb6HJW/EJw85JHzgqwiro4CWEWBDY4iWOz
 H1dg==
X-Gm-Message-State: AC+VfDxW/OHPo3wW0C02rD3SCYRKY3b+PiwvxsI8nROP9UGDR+0cDGKH
 TSoRONV8Xi46FV8Tk10yFM8A0ne6L11dm8U/Dyw=
X-Google-Smtp-Source: ACHHUZ4vhE0cDgkzrImYBfPHVmbOjacXhBrx86PfJGBedq9d0o/cT1OXxNh2KTuD6xfV26PKmcmhxQ==
X-Received: by 2002:a7b:cb46:0:b0:3f5:39:240c with SMTP id
 v6-20020a7bcb46000000b003f50039240cmr2879826wmj.27.1686078520428; 
 Tue, 06 Jun 2023 12:08:40 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 h4-20020adff4c4000000b0030647d1f34bsm13446489wrp.1.2023.06.06.12.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 12:08:39 -0700 (PDT)
Message-ID: <a5318869-9a20-2f4c-7ce5-fa0d13503007@linaro.org>
Date: Tue, 6 Jun 2023 21:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/5] bsd-user: Rename elfcore.c -> elfcore.c.inc
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <20230606141252.95032-1-philmd@linaro.org>
 <20230606141252.95032-2-philmd@linaro.org>
 <c28e9cf1-5fa2-c63d-bb59-fbb4555e0150@linaro.org>
 <CANCZdfqjr8om2juzBN_BqTuoyGBq7zEuM1+J5-J3OP55qg5h9Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CANCZdfqjr8om2juzBN_BqTuoyGBq7zEuM1+J5-J3OP55qg5h9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 20:08, Warner Losh wrote:
> On Tue, Jun 6, 2023 at 8:29 AM Richard Henderson 
> <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 6/6/23 07:12, Philippe Mathieu-Daudé wrote:
>      > Since commit 139c1837db ("meson: rename included C source files
>      > to .c.inc"), QEMU standard procedure for included C files is to
>      > use *.c.inc.
>      >
>      > Besides, since commit 6a0057aa22 ("docs/devel: make a statement
>      > about includes") this is documented as the Coding Style:
>      >
>      >    If you do use template header files they should be named with
>      >    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>      >    being included for expansion.
>      >
>      > Therefore rename the included 'elfcore.c' as 'elfcore.c.inc'.
>      >
>      > Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org
>     <mailto:philmd@linaro.org>>
>      > ---
>      >   bsd-user/elfload.c                    | 2 +-
>      >   bsd-user/{elfcore.c => elfcore.c.inc} | 0
>      >   2 files changed, 1 insertion(+), 1 deletion(-)
>      >   rename bsd-user/{elfcore.c => elfcore.c.inc} (100%)
> 
>     Assuming Warner doesn't simply want to merge this small file, or
>     compile it separately. It
>     isn't actually included more than once.
> 
> 
> I'd much rather inline it in elfload.c I did the include trick as a 
> short-term
> hack so I didn't have to upstream ALL of the core dump support to get
> progress on other things in elfload.c.
> 
> So rather than rename it (which will cause some grief to me when I merge
> things, but not a huge amount), it would be better to just inline what's
> upstream now and I'll reconcile that when I upstream core dump support.

I'll just drop it in favor of yours.


