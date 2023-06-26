Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5B373DBB9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:49:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDiqI-0000tO-Mc; Mon, 26 Jun 2023 05:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDiqC-0000so-Ge
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:49:00 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDiqA-0005X7-UV
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:49:00 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f95bf5c493so3658262e87.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687772936; x=1690364936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RDhjahAYLLrUZxk6r7ttJp+ZHRYzhlgzDSThomtqVs4=;
 b=TBUmtop3RuNrC5afc32zRkSBlnJ2gLcGFiWoTsrtS6HaqSTiQVZbqk83T+CHU8rn8K
 VRRvpFtxxqcdEuBryK/fh9a9pfCrEGApQw7d87YqI80YhA+3IITbz2vlsiRw4hS61x3T
 UHDBuBmtte05QUe6evnjOHqgkdVCc6X0PLFcVW2r6FU6Y5EHk0zRd49cNur0yxHQOcNJ
 IuC/cr/8FTTDEKa/gfDMuJPQRRbp6bVfGPcoPi5Z07NdB4Ocjud1RLKRGKP1Dth75GBe
 Yus8HYlzVOz+YXJr7oGTnXPPowWmqiRcXv7YCcRgXRTY5tzctka69D1ffJ3Tl0R6Iiu2
 4v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687772936; x=1690364936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RDhjahAYLLrUZxk6r7ttJp+ZHRYzhlgzDSThomtqVs4=;
 b=C5VjD9mQczbdoROdmRZ1qD+wfMwVTd1r1XohBsI28LRrjmSYmtXeqc5X1ZKazMMBPn
 Wz0zx0rafmsm4AJzH21dyRGPbaVAY3BT9CQ1MTlGMA3X0MsrPC955Z3LyYFAoJQGJh2X
 8AZ1NuLMISd8TwSUhdW/AL5NXFf9s6z6Zy6PPSGK7J0TABh2uNolgPqRpgYYwN9YCNut
 P2VaJZV0EEx41wdbt89knTZxC6HXpdhshIe09gXNIoTOUb0Syw/lGJ1Bd5rThJREJ89/
 Z5f3XXuywOmGEoci+0ula2N672Cn1FIZq3ama9IQueG2wqQwbnzN6TCyRxaZt4ODsuCV
 oWzQ==
X-Gm-Message-State: AC+VfDySrx/vjYdHqUNhKgPPC67TMGs/vmW05K7eXpeogMs18M7orQxn
 +mtGxvlBijtzO4Ywo0uNmYlmHA==
X-Google-Smtp-Source: ACHHUZ6546wvRjK5vjrubRir2ay0EGlc2kQlvXPjt+UbBBzU2WIcih7DUoF8wrtuW65l+ljL5/Y/Tg==
X-Received: by 2002:a05:6512:3455:b0:4fb:7447:e71a with SMTP id
 j21-20020a056512345500b004fb7447e71amr1149391lfr.63.1687772935667; 
 Mon, 26 Jun 2023 02:48:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.226])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a1c720a000000b003fa96620b23sm2443558wmc.12.2023.06.26.02.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 02:48:55 -0700 (PDT)
Message-ID: <b7a68894-c992-3845-754c-1fdf655ad3fe@linaro.org>
Date: Mon, 26 Jun 2023 11:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive2: Allow indirect TIMA accesses of all sizes
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, clg@kaod.org,
 danielhb413@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com
References: <20230626094057.1192473-1-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230626094057.1192473-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 26/6/23 11:40, Frederic Barrat wrote:
> Booting linux on the powernv10 machine logs a few errors like:
> 
> Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
> Invalid write at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
> Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
> 
> Those errors happen when linux is resetting XIVE. We're trying to
> read/write the enablement bit for the hardware context and qemu
> doesn't allow indirect TIMA accesses of less than 8 bytes. Direct TIMA
> access can go through though, as well as indirect TIMA accesses on P9.
> So even though there are some restrictions regarding the address/size
> combinations for TIMA access, the example above is perfectly valid.
> 
> This patch lets indirect TIMA accesses of all sizes go through. The
> special operations will be intercepted and the default "raw" handlers
> will pick up all other requests and complain about invalid sizes as
> appropriate.
> 
> Tested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index ed438a20ed..e8ab176de6 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1644,11 +1644,11 @@ static const MemoryRegionOps pnv_xive2_ic_tm_indirect_ops = {
>       .write = pnv_xive2_ic_tm_indirect_write,
>       .endianness = DEVICE_BIG_ENDIAN,
>       .valid = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,

Maybe. Is there a bus involved in between?

What about other I/O regions?

>           .max_access_size = 8,
>       },
>       .impl = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,

Unlikely. This is for the handler implementation, not related to HW.

>           .max_access_size = 8,
>       },
>   };


