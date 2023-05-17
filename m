Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2808570685D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 14:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzGSV-0001LW-Fe; Wed, 17 May 2023 08:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzGSH-0001Ep-7V
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:40:33 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzGSF-0001hQ-LM
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:40:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-643b60855c8so693845b3a.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684327229; x=1686919229;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vjV3Xu5ciWw8tdSQ4176Z19RICpHxoGYjjIMEyo3yfI=;
 b=DJ0bx2mWhe3QBHwyDklyFfP09h8Y6ZZNRpawY0CkZ00P8HGHmYGduNDjmzU27ON698
 3cLCRVttKZgj9x9xl41CK8V33CSS1ARz8fSmpD4g5n9uEbklYRySYEPdnTYAlnUE3WkO
 t64jd1Roc8X012CEnhAqg5LRr8vg4t4v92YRs6uPekFDaTr3n1rt7/HcZ09tQfvwjTnv
 RnErB7MoSe3ZB5/0W0wYr/Cf7Ar1Pxc7LibH/9+iKZI0JnZVU3lxwMJYfQqWuyIxgtFJ
 FSajrdG7DIHvXF+sr7AXXbQxFbHt/Bbzo/O1STOuIOSg4Huoi1xIDK9r8fP6ZPHpNGZ7
 ak3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684327229; x=1686919229;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vjV3Xu5ciWw8tdSQ4176Z19RICpHxoGYjjIMEyo3yfI=;
 b=Kn2BToWWGyBwZu85pJZ8jgBnjpbMliuQPSZ8Z2RoiG7nYgZ4z40Bxhu1zEgMHhPJtw
 FRaU9H6A2D8CKlT8TJFi9bsiGrOx2t37SNfqB9AzI/QyKwbpSR0FTMKKZfMufrH85WdY
 YnqX2vszGZlNrGoiQToX+FPX2r0QZRUDtXdBvgvais1/ZPB9hFtoK6rhLRS81R4Ss2cQ
 TeiS1NzgZdfcoIb3HPIHHcTp4IyPGC0/pyAuePgxT2umyv2jy6NaNGLxzrqTRoPAO80o
 xqfUV1asmoy6FBllHl5fCpkxmjo5J/Pxfa0YWKj8Xjg7osx01HYZfwmcJFwprlGdDoi2
 PuQg==
X-Gm-Message-State: AC+VfDw3q8ptQIiaLdYShScbVGxkWVpmzqVrg9hAPeJdGvvLK5yEBtsn
 2CUNGgAAEIRO0IUYSWLmQM+8i2s7xsaHW2RY02Q=
X-Google-Smtp-Source: ACHHUZ5B+lpjExrDD97cVn69ir7lH1F2Sz9K6iBwuf2I6XKHIpM/Pg/xtiI0ldl6C8+rCq7N4JOSyw==
X-Received: by 2002:a05:6a00:1952:b0:64b:256:204c with SMTP id
 s18-20020a056a00195200b0064b0256204cmr749636pfk.20.1684327229256; 
 Wed, 17 May 2023 05:40:29 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a62e813000000b0063b806b111csm15021741pfi.169.2023.05.17.05.40.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 05:40:28 -0700 (PDT)
Message-ID: <bdf2609c-d3f2-042f-0d0d-32ee1e946079@linaro.org>
Date: Wed, 17 May 2023 05:40:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL v2 00/74] tcg patch queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230517010220.1990465-1-richard.henderson@linaro.org>
In-Reply-To: <20230517010220.1990465-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/16/23 18:02, Richard Henderson wrote:
> v2: Drop a few patches, which showed regressions in CI
> for jobs that are not run for forks.  :-/
> 
> 
> r~
> 
> 
> The following changes since commit f9d58e0ca53b3f470b84725a7b5e47fcf446a2ea:
> 
>    Merge tag 'pull-9p-20230516' ofhttps://github.com/cschoenebeck/qemu  into staging (2023-05-16 10:21:44 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230516-2
> 
> for you to fetch changes up to 44fe8f47fce3bdc8dcf49e3f001519a375ecc88a:
> 
>    tcg: Split out exec/user/guest-base.h (2023-05-16 16:31:05 -0700)
> 
> ----------------------------------------------------------------
> tcg/i386: Fix tcg_out_addi_ptr for win64
> tcg: Implement atomicity for TCGv_i128
> tcg: First quarter of cleanups for building tcg once

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


