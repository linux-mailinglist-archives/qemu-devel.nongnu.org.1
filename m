Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72032704FC1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:49:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyv2l-0004Di-7u; Tue, 16 May 2023 09:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyv2f-0004CJ-If
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:48:42 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyv2d-0004FX-3g
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:48:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-643ac91c51fso9237318b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684244917; x=1686836917;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=63Nz8jrRwNkgVogeAp1t3FO6mZRBCNWCI890vpaZHU8=;
 b=KlDfT/GhB0BP8Y7477xV33HtLoFszzBgYIFmZVH76cgCaUiFPZTZNZpK+rntbiu/wm
 sE7HJxJuzKjpHkdzflsk6KjS3KXUR9EjrrwOHUDDlqJcMMkdKYp2t2eWexaFYHP/5Mcm
 dV++FNwPh58Qb5ooP5Z2nJuImoF+GS4Ou2MCKiULZoaOq+vDkpV7ENx/w8q6U6SFnz2A
 +iVyaGtT0VeE6dUqR1/TM4gc/ypjEqTbH9zBpbpLWo13/F2BycbMMG8llCMx0ZC+ehyi
 XGdFP+B7YS5/dRMB1fR43pQqISCYywClNLuIqDQQFJ+GNh47fjC1W52uYWXySBf1F2VH
 1OCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684244917; x=1686836917;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=63Nz8jrRwNkgVogeAp1t3FO6mZRBCNWCI890vpaZHU8=;
 b=AyR+J294OE8AvtNndSNkCow7DaXKYwLrAVW91+ThFaUW8Yzh3YjD2cIeshKH2T6qIx
 AYeV+geHnPRM05xWbcZagLYrx8NaLi8DP91JZWzWbU1fMIMfK15Ffqz8BLlef7Da9ODs
 uL73nGNUj0SNnVLYl+zwUTapAeqVRv23lq6qFUJNQwD+hR5z2x4j7ZRQs8/ADhgVmQr/
 fyAABLY16dm7I8ojIVrUbqpDAICePkwzyugHv4fz1YjqruvCbVYYVGdBpna/1E3FG/kO
 FgpRsYT1PPvM0Rl+QwtDxiw6YDzHb6o+Ggg4K4nlxnAj0bMlbKrUDJFJyyCdZJtKk9up
 SlRw==
X-Gm-Message-State: AC+VfDwz0H1CbZQLsD4HQa4DJB2kwVRpio5KkC9rNTtPF6BGpFGx0sw/
 +vtfRiO8vPh7aOpZmvUVoWBtaQ==
X-Google-Smtp-Source: ACHHUZ7LKdfW/2hTlyp6+6Wc+SkYHbQk4rfwnQDEwN3vcnHGziPyQkB7TmX0HoV63PrXQLI3Nir19w==
X-Received: by 2002:a05:6a20:548a:b0:104:1428:8d36 with SMTP id
 i10-20020a056a20548a00b0010414288d36mr24371907pzk.35.1684244917573; 
 Tue, 16 May 2023 06:48:37 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a17090a929100b0024df2b712a7sm1628733pjo.52.2023.05.16.06.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 06:48:37 -0700 (PDT)
Message-ID: <8f3fbd2a-b348-2b5d-78e3-43dbfdce2086@linaro.org>
Date: Tue, 16 May 2023 06:48:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 02/54] accel/tcg: Honor atomicity of loads
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-3-richard.henderson@linaro.org>
 <CAFEAcA8SxOVhPC+Y5saHKDWmBpOYZ2Ujcn3yHxoauw-jhhj3qg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8SxOVhPC+Y5saHKDWmBpOYZ2Ujcn3yHxoauw-jhhj3qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 5/16/23 06:13, Peter Maydell wrote:
> On Mon, 15 May 2023 at 15:35, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Create ldst_atomicity.c.inc.
>>
>> Not required for user-only code loads, because we've ensured that
>> the page is read-only before beginning to translate code.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v5: Dropped r-b because of MO_ATOM_* reorg
>> ---
> 
>> +/**
>> + * load_atomic16:
>> + * @pv: host address
>> + *
>> + * Atomically load 16 aligned bytes from @pv.
>> + */
>> +static inline Int128 load_atomic16(void *pv)
>> +{
>> +#ifdef CONFIG_ATOMIC128
>> +    __uint128_t *p = __builtin_assume_aligned(pv, 16);
>> +    Int128Alias r;
>> +
>> +    r.u = qatomic_read__nocheck(p);
>> +    return r.s;
>> +#else
>> +    qemu_build_not_reached();
>> +#endif
>> +}
> 
> Something that I remembered: Are we OK with this potentially barfing
> if you try it on read-only memory?

For system mode it is ok, but for user-only, no we are not ok with that.

I was not aware that clang was expanding this inline for aarch64 v8.0 -- I would have 
hoped it would be true only for LSE2.

Any thoughts for detecting this in configure/meson, or considering that I'm already doing 
some per-host ifdeffery simply rely on that entirely.  There are only 4 such hosts, after 
all, so it's not terribly difficult.


r~

