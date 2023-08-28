Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F1278B75F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:42:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahB4-0005WC-R5; Mon, 28 Aug 2023 14:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahAz-0005Sx-7C
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:41:26 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahAu-00089f-N7
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:41:24 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-26fc9e49859so1922754a91.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248079; x=1693852879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MbiCO1qQfDzgACV48VNmvBD1/zkiRSqRJqDRIe4onpE=;
 b=Sjti6Q1dYyiPvHeqGibSUX3KTOFMLxNCVLeCs1Yqjvy3VnmFu7VdxKhF/OC+76ol8H
 9X54FJSBWC0ine3mqX9FDBQwYU8VqAGTGM64pNkVUMj6BB8gh4zP/8OVkzWEbv1Lu7oa
 CBVcIiyZdFQlnK3VUgOYNgOargN8zUFFu3217ajSt3jP487bDvT+XCQKAhAYg/65JHgF
 jQsNOHIah4qZghxO5rkZEfE2I346VZaGUFVeEseWT9rS36+AWAn/A3gSYVV7leeAmFFu
 96nt9ztDycBs3h95+7o0HGEf0N4ORsoAzjcULLH0cPKzk2ZO4HbsBN/YEjC/7h8JQYCj
 MiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248079; x=1693852879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MbiCO1qQfDzgACV48VNmvBD1/zkiRSqRJqDRIe4onpE=;
 b=Uw2H+pX4ruqCGj4BagvdyMm8uhqqB3wVLshtBNAMaK+7bnk/u7NL8x8IWasW5LGHzz
 VMaVXc1D5KLRWo7mpKb5uE7wTStAd96VlOKgh17UEX2TvB5O4wSYWK4tA2i6oKvOSUbC
 S8BWPoW+ZgTUhHllABQzvou8PAooZyLvUF2YePYr8+kffGItX+aZ0/qqJ5VHOGEIWinZ
 uogPilhlKmnyQITVUT6mzHWHNkKrrior9t58q7NY5lkYjWubAfaUmBdYJ61xCEclC1AF
 w/We4zaNpVgEOa9eLMG36ZOYMDSxkaJebA++Guh7jL2PTf0LIKSqUGZ5PIVQJzDTs0R3
 16FQ==
X-Gm-Message-State: AOJu0YwSKEK9VmJ8s7fbMDqSwNpqkQ+tn2ytIC54W3g7yebmjyPX9CAF
 eus+JPErHXzgkd3GBtD9UGfXbw==
X-Google-Smtp-Source: AGHT+IHSQARfl2Twy4rqRIQeJQaH0LUqrxJlnbCz+ASZYNgQ8ieoiv7AvegiJinmuocXdTvTo5zjxQ==
X-Received: by 2002:a17:90a:7b83:b0:268:3f6d:9751 with SMTP id
 z3-20020a17090a7b8300b002683f6d9751mr20869989pjc.23.1693248078918; 
 Mon, 28 Aug 2023 11:41:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q33-20020a17090a17a400b0026d54b2abe9sm7895516pja.37.2023.08.28.11.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 11:41:18 -0700 (PDT)
Message-ID: <bba2391a-f4fe-45a4-a4e5-ae66849babc3@linaro.org>
Date: Mon, 28 Aug 2023 11:41:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 8/8] target/mips: Remove unused headers in lcsr_helper.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org
References: <20230828145545.81165-1-philmd@linaro.org>
 <20230828145545.81165-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828145545.81165-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 8/28/23 07:55, Philippe Mathieu-Daudé wrote:
> This files only access the address_space_ld/st API, declared
> in "exec/cpu-all.h", already included by "cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/sysemu/lcsr_helper.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

