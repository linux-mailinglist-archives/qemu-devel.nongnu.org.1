Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 627127409D4
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:50:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPvy-0001DP-KB; Wed, 28 Jun 2023 03:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPvY-0001CO-43
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:49:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPvW-0005E5-1n
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:49:23 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fa96fd79f0so41864225e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687938560; x=1690530560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aXHYuGJpSV2JC+Lig7+7GT5OnYqg8e9lyeuV8IPIgRM=;
 b=Kh6z4LlQBFBugWr4ZYsaS7amXmfV8WOWgSJKkQd5lOtmuneqJR6/YYwVvCIwtNvyHT
 EDPq8mbuTHacdiAEIpA9nbHE0c6A/dIQ99uOAmAVDru5sjVz6025Uwf6VsrYBuLMLBzW
 AOEwR3KoxW+G/CPsbSNMGVVsS7kiffOzOvg3VTq2JVT7nZVWTdMHdM9LlzhtxUdlYbuu
 SdlpIprarruNpbzTmX7HHj5+GF8cTHysaW7tO0RqHVyc9xrlHdNMEm/R8T78zERQEVc7
 laz8YZKQuD5xvkfiTxI4fJOdmhsqH3M97m/WlzSqio3w61W16+ZyyGwT8arl2MewYeJd
 FApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687938560; x=1690530560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aXHYuGJpSV2JC+Lig7+7GT5OnYqg8e9lyeuV8IPIgRM=;
 b=jKWQWd0A1mlm6rLLeIfvLkQ/mnU/grg/Fn4ZXPPW9zKTR/y6SO6BGDpOnpAaXCjBJR
 JhBbLvah5FupFaUFLzPbAICdTO2BX5CTcBcLn/ZUniLeKSM3FexMbrjYQSqLLGRl9kug
 3/ayelkvqFQsxOuHuI+KcrXP7TmLTRx4lXzLZFXpwYkY4VheLcsxupQX7BTnOJqQxpGB
 cYs7IGN1R0/YQV/JnwIzlb+XekdyfIXyoXR1nkPktKVNP4h82t6fKM+Fc8VQy8EY19al
 UESAtCsE8a1R9ez9B+4/d4ufZJNWeATrAU6V253sC5EOYAa1oKE17JcI3RBbpnX/uTC+
 Qq7Q==
X-Gm-Message-State: AC+VfDzqISH/J4Nf0OiGN8h9kf8t3IOHMVFT0/37RclQTwTZjLmrnEzt
 iLy1YisV3uXyP/uvsZFdAJdzvg9CigQTIZtvtsJNjnPU
X-Google-Smtp-Source: ACHHUZ5nFR+1ltVhc1KP0hWEaBTuUnyxu8qaO9B4B1gwEsCXv/so26VfCjjcRR5qvSmVAHTfH80pYA==
X-Received: by 2002:a7b:c051:0:b0:3f6:1474:905 with SMTP id
 u17-20020a7bc051000000b003f614740905mr37613086wmc.29.1687938560453; 
 Wed, 28 Jun 2023 00:49:20 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a1ccc0b000000b003fa8158135esm13670078wmb.11.2023.06.28.00.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 00:49:20 -0700 (PDT)
Message-ID: <f359dae7-e0a3-42cf-c2cd-fff7f9c3a607@linaro.org>
Date: Wed, 28 Jun 2023 09:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux-user/elfload: Fix /proc/cpuinfo features: on s390x
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20230627151356.273259-1-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230627151356.273259-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 17:13, Ilya Leoshkevich wrote:
> elf_hwcap_str() takes a bit number, but compares it for equality with
> the HWCAP_S390_* masks. This causes /proc/cpuinfo to display incorrect
> hwcaps.
> 
> Fix by introducing the HWCAP_S390_NR_* constants and using them in
> elf_hwcap_str() instead of the HWCAP_S390_*. While at it, add the
> missing nnpa, pcimio and sie hwcaps from the latest kernel.
> 
> Output before:
> 
> 	features	: esan3 zarch stfle msa
> 
> Output after:
> 
> 	features	: esan3 zarch stfle msa ldisp eimm etf3eh highgprs vx vxe
> 
> Fixes: e19807bee357 ("linux-user/elfload: Introduce elf_hwcap_str() on s390x")
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   include/elf.h        | 66 +++++++++++++++++++++++++++++++-------------
>   linux-user/elfload.c | 41 ++++++++++++++-------------
>   2 files changed, 69 insertions(+), 38 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

