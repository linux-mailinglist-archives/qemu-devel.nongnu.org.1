Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 973427D113A
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 16:10:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtqBG-0001lZ-Ml; Fri, 20 Oct 2023 10:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtqBE-0001l6-0M
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 10:08:48 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtqB9-0000G1-JT
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 10:08:45 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c51388ccebso12815821fa.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697810921; x=1698415721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mD+mtuR9y47g2JJlaAJDMPPS1KcwIe47DWnTIUKNwuA=;
 b=heCFkl8EtB0UjrUAKkLnCK1w1wr0WVyv4sDyAV3yYxjziFEXdjTP9Ef6UrMIE/aYL7
 iXnm2w370Z5thFYkHhBFAjzc3S5aa++o8IAfiE4yn4qiYGp+kWz+OHRAZnDYeKGPrNvk
 fyShya879YPSRBlZ/8R+OQtsZeLfOeg/ZyPB6vs5FImqtYTjN0EoPEl351xSsc945zk6
 HQ0YvzFT9P9UYADx+rGKSG9vZEZW0fyREd970qW/cCtVW88sEfq3SLypY+/bWcvDSeAF
 jPn5cedjyO8jocBVl1ixU+b+QwmOCGcGE0TqvY4QvBSftRM0qvkVBFLQXSYhpkGFcnm8
 62tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697810921; x=1698415721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mD+mtuR9y47g2JJlaAJDMPPS1KcwIe47DWnTIUKNwuA=;
 b=POv+LjqvjZSeHUDNV8k46y4/+C/NQ9Rt2MkIc+qOEG0HEPktRSTVaDPhlZwq8Q0Hpu
 zlO1s84DpIidDhSOvcMNo2dIsZ7ygXyvEaQf8gTWE4gB3lv2RTt2jXD76+v87saHqsDx
 vrFzfYw+jeK4pMPXBQvLfXn3DJ9uOQnqWkjrCE1FHmuvNq7GeX84fX5n90KB+fzUaatg
 fOcBa1fE3mN8lQPMKxaQ86wjqiwRuXpoxDP4/yV5ZWwxwrB+522Xz0aibBIwcLJB+X97
 san9pyfLO7ZkxBM8XZtXkmhLZiq2oNdvCEB+g/bxtzRcdt3JagdXqcj1V8JDzs+U3CU6
 53RA==
X-Gm-Message-State: AOJu0YwENTB7gB57hJZI+a/PG2fw23l8Pg7O8WAdNchZYRckCMOGhNPU
 hkKYq5ZdZVEAMbB/kxdCqgZkNg==
X-Google-Smtp-Source: AGHT+IFlzm3BZ1UhJKKsl+ECL4vK7gy0iPgpfNqMN6LsNC4EoQvpOOvAJpxoMfFO2KuQ4ztA73QPUA==
X-Received: by 2002:a2e:81d6:0:b0:2c5:1553:9129 with SMTP id
 s22-20020a2e81d6000000b002c515539129mr1696130ljg.35.1697810921523; 
 Fri, 20 Oct 2023 07:08:41 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 u1-20020a05600c210100b004068de50c64sm2213225wml.46.2023.10.20.07.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 07:08:41 -0700 (PDT)
Message-ID: <e0c83090-244d-b3cc-7127-39baa879b77d@linaro.org>
Date: Fri, 20 Oct 2023 16:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] linux-user/riscv: change default cpu to 'max'
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231020074501.283063-1-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020074501.283063-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/10/23 09:45, Daniel Henrique Barboza wrote:
> Commit f57d5f8004 deprecated the 'any' CPU type but failed to change the
> default CPU for linux-user. The result is that all linux-users
> invocations that doesn't specify a different CPU started to show a
> deprecation warning:
> 
> $ ./build/qemu-riscv64  ./foo-novect.out
> qemu-riscv64: warning: The 'any' CPU is deprecated and will be removed in the future.
> 
> Change the default CPU for RISC-V linux-user from 'any' to 'max'.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Fixes: f57d5f8004 ("target/riscv: deprecate the 'any' CPU type")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   linux-user/riscv/target_elf.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


