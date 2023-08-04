Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A48D7705CA
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 18:18:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRxUe-0002s6-EG; Fri, 04 Aug 2023 12:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRxUY-0002qW-Uh
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:17:32 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRxUW-0000an-R4
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:17:30 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bbd2761f1bso19360005ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691165847; x=1691770647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RxsxIWL9p4iHkVCFJrHyZvhtiXH8QWfk2GDb+CFIr8E=;
 b=LF55YwOMVM9hgSUZQ2zx08oi4PDNSYBjeH0K2qVpDjMgRRNJ1f1Gb83TzFVItD+4ZN
 BWGx+97q4tTxC2oQZXlKvygCWjHxEVyFbr0OSR2IuBi8sj1rJ3xk9MDamkPoitw1unCF
 OPLeSYGMSR6lBZoeCE9n8MiSYBtI8Px8sy63nHZbL1sggFQpZ8GZcNpAkjoW9ZN2W1XM
 KMwaiafH1/KhCqVuUq7wOonsSDqUHLtyuW9PT0IutfmQNEzyEL0zLa24teWsCUXX8NxM
 7DS2CgG9NNQy01e0nK7X5LJ0kwLJxhdwmzBjqAMZwMTxdsgjA1eSfQev7OvWtszCJiRe
 ugAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691165847; x=1691770647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RxsxIWL9p4iHkVCFJrHyZvhtiXH8QWfk2GDb+CFIr8E=;
 b=EF1We6JTNpSKwgz4btoFu1tTi0I/A6DRPFDUMy0+ASpyIct+AdH4TQ/esZVxcg1M5V
 LSXMs5y4fKf4qL7KvpQK+L6Qt9QS80GxF4wql4jg4JEfb/ft79iQBGMwiIAvHr81GRtH
 IH9S3v8xqnyaSLSH/5BSrNy9kRSGDJhsRO5MhMs2CmP4DKsRlDPFkVCvsMrjykHyEtCa
 l7fl0i6abCMNa0NTYqHW0p2niMJ2og72tqnzB1pBdSPdDp9NcZ5OzjXgvueIi0HS9KIa
 AF1aDkSy4CAtbUbZMbEw3u/FmKqvzGrkkGvyvMI2SjoAoknLYQYxtHXSugr/zqJqstF0
 qwqg==
X-Gm-Message-State: AOJu0YxSs9ez0q0e3f9XQB6tvyrdEeN7MoTDkoVuBonnptOsQzQeGQIx
 sqBr3on9GPT0sEGwNXkiN3pWFQ==
X-Google-Smtp-Source: AGHT+IHBhvl7M2aaUlCaImgpZjM+hfOyJqUbThAyNkIbo2xC1RiX4xnWKt6kWKlMPy1WBsdHuKW05g==
X-Received: by 2002:a17:902:f693:b0:1bb:7d2f:7c19 with SMTP id
 l19-20020a170902f69300b001bb7d2f7c19mr2596726plg.64.1691165847257; 
 Fri, 04 Aug 2023 09:17:27 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:1eed:f77f:f320:8b14?
 ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a170902a9ca00b001b5656b0bf9sm1932550plr.286.2023.08.04.09.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 09:17:26 -0700 (PDT)
Message-ID: <2a0eec8f-0091-681d-7414-5939719ec090@linaro.org>
Date: Fri, 4 Aug 2023 09:17:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] linux-user/elfload: Set V in ELF_HWCAP for RISC-V
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nathan Egge <negge@xiph.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20230803131424.40744-1-negge@xiph.org>
 <cfb8653b-ddc8-b4a9-9792-73ef84ee925e@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cfb8653b-ddc8-b4a9-9792-73ef84ee925e@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 8/3/23 07:42, Daniel Henrique Barboza wrote:
> 
> 
> On 8/3/23 10:14, Nathan Egge wrote:
>> From: "Nathan Egge" <negge@xiph.org>
>>
>> Set V bit for hwcap if misa is set.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1793
>> Signed-off-by: Nathan Egge <negge@xiph.org>
>> ---
> 
> Tested with the example program described in the bug:
> 
> ===========
> #include <sys/auxv.h>
> #include <stdio.h>
> 
> #define ISA_V_HWCAP (1 << ('v' - 'a'))
> 
> void main() {
>    unsigned long hw_cap = getauxval(AT_HWCAP);
>    printf("RVV %s\n", hw_cap & ISA_V_HWCAP ? "detected" : "not found");
> }
> ===========
> 
> $ ./qemu-riscv64 -cpu rv64,vext_spec=v1.0,v=true,vlen=128 -B 0x100000 ./a.out
> RVV detected
> $ ./qemu-riscv64 -cpu rv64,vext_spec=v1.0,vlen=128 -B 0x100000 ./a.out
> RVV not found
> 
> 
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Tested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> 
> Looks like 8.1 material to me. Thanks,

Queued to tcg-next.


r~

