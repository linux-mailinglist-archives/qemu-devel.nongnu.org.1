Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC778294D
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:39:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4Bz-0001Jd-Px; Mon, 21 Aug 2023 08:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4Ba-0001Ih-TF
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:39:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4BX-0004bb-IA
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:39:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so30870735e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692621546; x=1693226346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+BcVVTHFZLsIMmZBHITK2uid3OSeTJLURKTcwUbmbIo=;
 b=uQGmXasrhCLx5ILGn3cq+uXJNaMN0G66KEVNziIMPZWFBcuDHvPzf/N6Jc/p6S17as
 Wk1iR26MdrqFbL+KnLmq1WePE05L/mDhBY2n7ZPwAeCPmA8NXcq5uhikc4kr7FQr0MUI
 J/imXkKRdW5O+xjF327TQ+lxx+AHP5e1luO50FTrMfgy5kTjpaTXQH8gPbHMzU1JnYKE
 KE1/WwDvnDUZKCAbaaxGXEGTZCDdBweBUNE1zP8jd5Ye4hTZqzO+WgnJRLGChf188yY+
 90k7sPxx4K54JPfeqPftaLoZJ112fndqLUm2kwqzAnUwP5LYcPMxJxAMO7ZfY0Yarg5D
 wNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692621546; x=1693226346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+BcVVTHFZLsIMmZBHITK2uid3OSeTJLURKTcwUbmbIo=;
 b=lVjReZ8mDzBOyT8NmM2/3vEmBDmVSPn9LJdRXyA1xSjQwa9Xu+Bha/K+gMSh5nZx0J
 JV19JBcrU6Tind8qhz2aYdDnn3h2BGpoP3xloVr9dgwh7PH4zGIGChyjajmJICFFlIR7
 X5WvKXlewTC+DYGLlPqKK/uSWAqsHV/F+atgBcyHy3xo10FMBskxOxmW8eofx6SAcmvo
 1oUMWfJvkOwDk7wR1TUlMA/uJc/4bezClIpJZKHrZOPVmkcRJwct0YYxiIlNlZdMZPzv
 r8F9ioDKtho8rLPHYIFqY5c+38+kYPGkpBgPk3UXeroBf3ncYxCDuoynh/LSmQoNcZ27
 aCMw==
X-Gm-Message-State: AOJu0YyvXtJdY6k0YjCqx2ImedTp8gFsw39ak3hEr7dBGi9K/XAWi4CG
 jJ4wTBI57eo3IgoODISU5M/8ag==
X-Google-Smtp-Source: AGHT+IH2SrmRIsEQfOusA8QWA1/WlLRthz3OtfwSutef2XfeZKY6lr6M+wZvdoxYnqU3o7WDjJh++Q==
X-Received: by 2002:a7b:cb59:0:b0:3fe:dbb9:1d84 with SMTP id
 v25-20020a7bcb59000000b003fedbb91d84mr4977967wmj.0.1692621545988; 
 Mon, 21 Aug 2023 05:39:05 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 21-20020a05600c22d500b003fee777fd84sm7746962wmg.41.2023.08.21.05.39.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 05:39:05 -0700 (PDT)
Message-ID: <73d0571e-fa06-1a17-2f34-97cd296ddea2@linaro.org>
Date: Mon, 21 Aug 2023 14:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 11/18] target/s390x: Use clmul_32* routines
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230819010218.192706-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 19/8/23 03:02, Richard Henderson wrote:
> Use generic routines for 32-bit carry-less multiply.
> Remove our local version of galois_multiply32.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/vec_int_helper.c | 75 +++++++++----------------------
>   1 file changed, 22 insertions(+), 53 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


