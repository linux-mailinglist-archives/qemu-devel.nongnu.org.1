Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F1078F639
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 01:54:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbrTe-0004nw-6A; Thu, 31 Aug 2023 19:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbrTc-0004nj-IZ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:53:28 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbrTa-0000cI-AF
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:53:28 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-26f38171174so1005063a91.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693526004; x=1694130804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R6LcxSxat1T5drkGYwpR6ZhkOL7n7DCsJSUtL0pm9bc=;
 b=w7srJKODhIjw0v/RvgBmqZpMJkccm4dv7qtj07lP98NmMizEPVjsyMD89vNVCDRxkm
 7ap7wG6nyQRK2AtMwSNuf6oaBOCXRBT2BCy0r/1TUG2srWQz1/lDelX9kdTvja9VtZzX
 8VAhYEMfSwIgKPRUfEUsZNhY6CQi7NggEDVmuEyhpXtwPW4WyJ11cu2jlt9gEVqcSLCI
 fk5Tlsfmr0HW9+bFq9SVEZ+fgiGUnuc7VFHJTZwslUfeYEzn+YatkxibuZNRY/kkpftS
 l6/AzoDtkJ3TbaNs5UajngiwH61rWqov0R9n7ABxV7MVoYdUpfilVuNiIp3KR+4/3rL/
 /WkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693526004; x=1694130804;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R6LcxSxat1T5drkGYwpR6ZhkOL7n7DCsJSUtL0pm9bc=;
 b=NKIudHBXltHyZr/CffodnTmTz9L5oPBFFePNg/yVsY8Sj3jrkx0Kx4laYaYz53NVyM
 KxuEYbg6F6njiPCyPnEIuq5+eLe4KBrXj4YJrfCMNyLeqUjbPMKS65XVMqfVDN3Ubh2G
 S6LWCpGENHyREf9PKYBL5C4t7xSAJUS6xx8q85pJfWlYLmlX4SN0Cd2VCKTiPH3wrsL+
 jqa1dkmG2Ee9CSDXpkXik/HFF3EBgr8nhyQpBEoN1yFuZr73+RJNQomVPVkn+NJkvj59
 xwieLGgy0gqz9WJ0EbQKpCmO3+ELkBhe6PuMR5+UU9OMCf8aAiZKtXwrS9WFdDcgajYJ
 hN2g==
X-Gm-Message-State: AOJu0Yy5HmH4vhvov1czSMShmpA+P+BPzrhuRKPRlqgb+NIVGTtLsT/Y
 BctJwZNywA/QSJdZBqt9uQBuwg==
X-Google-Smtp-Source: AGHT+IHD/6TxQZ1KoUjhV1xESobwrS+jdKmjctA34WSbBxzuH5PR1GKh8VSUkEo2Cr7ykIBQNc3jUw==
X-Received: by 2002:a17:90a:aa94:b0:271:c2fd:721b with SMTP id
 l20-20020a17090aaa9400b00271c2fd721bmr845062pjq.18.1693526004507; 
 Thu, 31 Aug 2023 16:53:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 n14-20020a17090ac68e00b0025bdc3454c6sm3429435pjt.8.2023.08.31.16.53.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 16:53:24 -0700 (PDT)
Message-ID: <06a3008f-0fae-09ce-c669-b8ff17b0c1ce@linaro.org>
Date: Thu, 31 Aug 2023 16:53:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/7] target/mips: Simplify Loongson MULTU.G opcode
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20230831203024.87300-1-philmd@linaro.org>
 <20230831203024.87300-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230831203024.87300-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 8/31/23 13:30, Philippe Mathieu-Daudé wrote:
> Since MULTU opcodes don't record the most significant bits
> of the infinite result, sign-extending the sources make no
> difference in the result.
> 
> Once we remove the sign extension of source registers, MULT
> and MULTU are identical (as are DMULT and DMULTU).
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

