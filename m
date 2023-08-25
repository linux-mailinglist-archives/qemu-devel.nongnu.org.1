Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C07880B7
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:14:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZR1I-0006NH-HV; Fri, 25 Aug 2023 03:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZR1E-0006N5-6J
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:14:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZR1B-0001zz-VK
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:14:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31ae6bf91a9so494887f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692947644; x=1693552444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jyF/mCi3Gl+lUQjG9hc8gmB+iNyNh6mPSWDF+5z37Xo=;
 b=Kr9EEUMuANbgwDzUvuQpUvqSbILOr0Vomk2ZJqO+E2BygTyKcsVWqgnZ3CpPSWiesp
 kwr0v/GIZ6ZP63qNAOd9okXsqCWdTBYA3ViQ4EKoqwl4ruMGlG+qegfn9jFsQ4bJr6JB
 aVDMOV1WpEHfJKu1RVIXZE/NmScUH3lJuMoa7k8I2i1bqjyHd30fBh7E6M0D8QQEr0MR
 XKd2Ldi13mBRUTAMQgwD/6kmzUQe/FU6EpyYnH8F+IUHvQYaemJSbuHi4CjV8JeTmZ6I
 38TAqvLASKMy6qrSjsaAic1aG3YnN2AnbOHy902k6WPn+rWWyu1I/tpqxtV590frgJlr
 Mulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692947644; x=1693552444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jyF/mCi3Gl+lUQjG9hc8gmB+iNyNh6mPSWDF+5z37Xo=;
 b=RS2iRogtZgF6BVdyGT64uKfhLud/jPygynoctb1+wNh1x3TiiSL9ZUwYeq+MnLPTr4
 EVXFEoo9e6CecbwgUee+7EgE5f3ElGALQ2cfDbYNSpOCnKAYRMz7QcYL1H/OjFxLCZVb
 tQqTry/pXHzaYW/0u1lTNmOw+EO0FwuwJS0hD9226cI5Tp/MKgoR8U88PoQl3gzTZivo
 zBBbZPsIsdQjZQpJjtqjbZD2W0YbI5qbr+G50Tg4CLwCS1lnSKHjGP2qqC9wXWAhGbnA
 O0kuLK7oevABstf0HkO8/92lsLOiUeJ246zSgwOFiAwl8vGahk7NNgnj0dVN+OX87hpC
 jVKw==
X-Gm-Message-State: AOJu0Yye0lg+92gRZFHGyl9bZzldL1EHBffdtgZtUs0Oxf9tG3Qrdq7x
 Ivnl6ic8zoZ7OOxP6ptymCGMNQ==
X-Google-Smtp-Source: AGHT+IHnwpNCao6iDgNyCseIY6HJ4m2Np/wYj73KRQ2jH3ADVMkhsBpkff0Q8PAUEO3ZtW8sLM9adw==
X-Received: by 2002:a5d:6f0e:0:b0:317:6681:e42a with SMTP id
 ay14-20020a5d6f0e000000b003176681e42amr20718345wrb.9.1692947644352; 
 Fri, 25 Aug 2023 00:14:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a5d538f000000b0031ae8d86af4sm1332069wrv.103.2023.08.25.00.14.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:14:04 -0700 (PDT)
Message-ID: <cac0f87b-8026-8e02-c6b3-a415af664f55@linaro.org>
Date: Fri, 25 Aug 2023 09:14:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 3/5] target/hppa: Do not use hardcoded value for
 tlb_flush_*()
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20230824210434.151971-1-deller@kernel.org>
 <20230824210434.151971-4-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824210434.151971-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 24/8/23 23:04, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Avoid using hardcoded values when calling the tlb_flush*() functions.
> Instead define the correct mask (HPPA_MMU_FLUSH_MASK) and use it.
> Skip flushing the MMU for physical addresses.

Alternatively:

   Instead, define and use HPPA_MMU_FLUSH_MASK (keeping the current
   behavior, which doesn't flush the physical address MMU).

> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/cpu.h        | 5 +++++
>   target/hppa/helper.c     | 2 +-
>   target/hppa/mem_helper.c | 7 +++----
>   3 files changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


