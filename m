Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4779FB93
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfSU-0001w8-LY; Thu, 14 Sep 2023 02:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfSS-0001vl-Fm
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:04:08 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfSQ-0005KP-Vc
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:04:08 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9a64619d8fbso77381066b.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694671445; x=1695276245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sj7kEn9b0unkHMlbNISLmBDqKfLP4cNWnfu2ut+Iovw=;
 b=u40CoaQknPu46IZkPvZgWysDomkEN0YW0w1d3jYltU91K1AcYL/RWYdeYyeSi7qety
 ht4WPrV9BsBid88K7jA0IBV6jmLqFmxWRbRHzKirUkJvwfaHpYCGiJ4jq/tS7acbmm0G
 6ZtdJNCcUC/IkelMLydZn439TbZbwVcdPoR4qrvts6GJ++hNWz+QCWnsaBN5W/gCcMR0
 dk3OANytZdcKxln4m814fA1TPm1sFPd4NB7jVAKeJs+qAh1EpTqpr7x9FE4H0RxhwOkx
 zOQ35DClvhhBVoks6gimXK5pfqhPLlcXAtflbFviKu5+/GvycboDTU9QHCl4qucC4gYk
 mZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694671445; x=1695276245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sj7kEn9b0unkHMlbNISLmBDqKfLP4cNWnfu2ut+Iovw=;
 b=aPmiEF9OIM73c7n4Gl9roA5md/4vXBk7jB8kmhLWGIbkr6fNkgyvj6rEeJ3k+6f6vt
 vi/7iSFqcRQrN7kdaeeZzHzhKgFImzIEii5166wxXJssP5A9riYVk5it22Qd95dfTQzt
 heUOJ3JwFVZ/wuA5SSZsQ7kRhmbdCb4ecwR0kdrDl9yd7JCG0L5VcdG2nfUS03KGwdF+
 iQSWprMgSQcLn7xI6AJ9JuTJ1W2Gsjp6LPzb8LMnXqUJ3gUl48CLLAMlv6jzo+HJM+Bu
 kM+8f1WOyoKjfzmXd3yrJM1/Qx8UjAErpCuojWgPeOdurz8ot8gwl/L1BRPDGuJRBTbU
 yN3A==
X-Gm-Message-State: AOJu0YxNDQuoi48tKNmsmDzOGuT+L18aC0pwkrGLNCTNLdZfmG5NP/UX
 66Uq5wMDAQTYYkRtY8F9CM6xFAVEXVVrPgF+SUM=
X-Google-Smtp-Source: AGHT+IFxY8IY8tPMNuLZ58NOEr2rXHyULNTw+sYBHgFuR9WGd0CNiqncFfqci2mZU1RquHZr8ecFXg==
X-Received: by 2002:a17:906:74de:b0:99b:627b:e96d with SMTP id
 z30-20020a17090674de00b0099b627be96dmr3486329ejl.44.1694671445443; 
 Wed, 13 Sep 2023 23:04:05 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 w18-20020a170906481200b0099329b3ab67sm499758ejq.71.2023.09.13.23.04.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:04:04 -0700 (PDT)
Message-ID: <518042c2-c158-a82e-04ee-413e5c3d9ef5@linaro.org>
Date: Thu, 14 Sep 2023 08:04:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 06/24] target/*: Add instance_align to all cpu base
 classes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 04:44, Richard Henderson wrote:
> The omission of alignment has technically been wrong since
> 269bd5d8f61, where QEMU_ALIGNED was added to CPUTLBDescFast.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/cpu.c      | 1 +
>   target/avr/cpu.c        | 1 +
>   target/cris/cpu.c       | 1 +
>   target/hexagon/cpu.c    | 1 +
>   target/hppa/cpu.c       | 1 +
>   target/i386/cpu.c       | 1 +
>   target/loongarch/cpu.c  | 1 +
>   target/m68k/cpu.c       | 1 +
>   target/microblaze/cpu.c | 1 +
>   target/mips/cpu.c       | 1 +
>   target/nios2/cpu.c      | 1 +
>   target/openrisc/cpu.c   | 1 +
>   target/riscv/cpu.c      | 2 +-
>   target/rx/cpu.c         | 1 +
>   target/sh4/cpu.c        | 1 +
>   target/sparc/cpu.c      | 1 +
>   target/tricore/cpu.c    | 1 +
>   target/xtensa/cpu.c     | 1 +
>   18 files changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


