Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 469947B6AFD
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:03:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnfzo-0006Qm-Ty; Tue, 03 Oct 2023 10:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnfzO-0006OX-QB
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:03:09 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnfzM-0001fv-Jl
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:03:06 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-279294d94acso3104211a91.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696341783; x=1696946583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UnayPkiXpxA7sum5FkQpu1Xk020obqsV+ZF3u+IUD8k=;
 b=a/AmwzIIgnoyuU/MKsa0Bh7Mr0+5AqS+6fQUVvfe0eXcuYA4/y9d+OqjoYEya6GUHQ
 gntwll/XgnvcLN37bN8WlSjH0NTi8Yr2vSbAYB1ueVyiFjMkc1nEOcxVMCbGcmHtczV6
 aR/5chtLsu9ysA8imfpSd9jO+tukewX6CSnaCdUj2mIxGum8ZymsYWaobU4UUA4yS268
 xWjM2pj+6f75hoot0MOy1rqvbDvbGw3SaCyaAotFLf7YWAjt72/6bUmy9mWD2Q8xntwQ
 dBAeiges4EQ8ojNOiaktMQ5Kuzdk/CsWgBMf2n9rTMuzsg/jOd0Neq2oJRYVdzlN7Y0x
 dqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696341783; x=1696946583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UnayPkiXpxA7sum5FkQpu1Xk020obqsV+ZF3u+IUD8k=;
 b=kiC1uWeJb2/tMJjue6IFAivofKJsQgioDPVdsiT7P8UTutX4zk1ecI5PhoCn1UEnRY
 /m2HnDLrSeZstBOeg4IBZ8i8UAA7mVs2ErgPFWSZRmoPvEWpsndEQ/1FiXJPeyr4FgGt
 /7EZVmQj0OHpIso8ZR0IDgsEXsg/ZDUI6MRNxARRAkzMB807CAzcwCZlnBxMOl457bWF
 3ERvHVg5Vycs1NFZGBDB374M8KhTFDUbCaUtaLuRpsqxp2IBN5JGHyTHoQVeeowki+9O
 cpaodVgwMZTdVebMMDu+0Ml1INgpeHXiFDlawqxsEDTz/J+T46VkeZJlsuZlDtKxCrzX
 HMCA==
X-Gm-Message-State: AOJu0YyAcOI6uj3W4tZvzPdNtEAOwZdgIHQ8rU2on6r9N+lt1rIKZK9o
 yIsAO1RuoFCor8qmdpds9eNkCA==
X-Google-Smtp-Source: AGHT+IH7I+k5PdAb84xgljlJPvpciF6SkP3a6EczjIFQlzPhPVWAGaYxbyWpJf26QRI6GU4Y3C+1yA==
X-Received: by 2002:a17:90a:d985:b0:273:83ac:5eb9 with SMTP id
 d5-20020a17090ad98500b0027383ac5eb9mr4339035pjv.4.1696341782754; 
 Tue, 03 Oct 2023 07:03:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 mn6-20020a17090b188600b0026b46ad94c9sm1414505pjb.24.2023.10.03.07.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 07:03:02 -0700 (PDT)
Message-ID: <dbdef0e8-d0cd-8617-02af-a11f69f4a8e1@linaro.org>
Date: Tue, 3 Oct 2023 07:03:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RESEND] osdep: set _FORTIFY_SOURCE=2 when optimization is
 enabled
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20231003091549.223020-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231003091549.223020-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 10/3/23 02:15, Daniel P. Berrangé wrote:
> Currently we set _FORTIFY_SOURCE=2 as a compiler argument when the
> meson 'optimization' setting is non-zero, the compiler is GCC and
> the target is Linux.
> 
> While the default QEMU optimization level is 2, user could override
> this by setting CFLAGS="-O0" or --extra-cflags="-O0" when running
> configure and this won't be reflected in the meson 'optimization'
> setting. As a result we try to enable _FORTIFY_SOURCE=2 and then the
> user gets compile errors as it only works with optimization.
> 
> Rather than trying to improve detection in meson, it is simpler to
> just check the __OPTIMIZE__ define from osdep.h.
> 
> The comment about being incompatible with clang appears to be
> outdated, as compilation works fine without excluding clang.
> 
> In the coroutine code we must set _FORTIFY_SOURCE=0 to stop the
> logic in osdep.h then enabling it.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
> 
> Re-sent due to previous bad patch submission
> 
>   include/qemu/osdep.h         |  4 ++++
>   meson.build                  | 10 ----------
>   util/coroutine-sigaltstack.c |  4 ++--
>   util/coroutine-ucontext.c    |  4 ++--
>   4 files changed, 8 insertions(+), 14 deletions(-)

I agree this is better than the meson fragment.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

