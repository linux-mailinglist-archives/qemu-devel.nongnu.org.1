Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6545571F3A2
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 22:19:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4oke-0002gQ-2g; Thu, 01 Jun 2023 16:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4okc-0002db-1b
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:18:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4okZ-0007No-Lj
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:18:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30af56f5f52so1238769f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685650701; x=1688242701;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vErTTuliMGa5y0Q+Wwmgti7vo+jo+nPGebg7TPSp6F4=;
 b=W6npqV/boYy0wsppCgeBPntXq/I5UG1/76GsJLRxnZOI/RiML7bk8PFDvqmWNE6a5B
 UkR6epa5YrPIzSxMgDA7Fv1wBcDsdNIy0BJJyV8/j56EACuK1AUoIXZTYk6PjzdWC+Dp
 LtRJVe/Gi+UkZyKCAVWGz1OhM0eeOfoq1vrEo1CvZ21bFj2PdkwfA0SwI9gswu9yDbBo
 cI3Wb2t4vuBZ5wxgSgF1WEm+NZufdwOcg/b/vSANt5sykRIpu1VmvXbrlMijuD8JHQfO
 9LSHmP0gEcybv38VGxbE/ToOGeR5tre0r5eu/MRY+d5Rn7watcE9PaS5P8EcGqIV+07Y
 9hkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685650701; x=1688242701;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vErTTuliMGa5y0Q+Wwmgti7vo+jo+nPGebg7TPSp6F4=;
 b=esU/jaV0OlMPJs7sR4+cy7OzAVHrHfxw7wH1tR1Ud+n771OjVfll2sk2pU9Jkr1/L8
 4QkX46jdR3nE9cqJAc4+97CUmmjKsVAD309HV+vnUyjuep6Z9PBbap7BtTVLe7FVWLwB
 U/L2Z2c3eyDVQtbIf3yaRCLtIR/mVhbEhTFxtZvbVyphHrneZO6tznKsVL1gVH7ttJ7t
 Cy/WKN7L1TnIATqHSLIvMBjEwvvZ8/FShCRt8S7AQN6YcqsynhUwMIm/LnERYwShHQRj
 HT0GPonb1tOF54ZSzDMNCJENtNM3XBLsLK8/iii8YBKqqrdkI37fUXSuuSi5uGk/CYwG
 khag==
X-Gm-Message-State: AC+VfDwTntc0xVHfJ8vIJR+cTTShk+9pFAkvLmcXmo9LisFeFI+4Mnx1
 JPdeNS0XtB5V+H19CHTSyjCBqA==
X-Google-Smtp-Source: ACHHUZ4B5MWpGfaCgVDqXouByCXdErZOLIhGOAQZoW7jPgSZ5UQM0udQTmfkxMvt+FAnJUlP2OuxCg==
X-Received: by 2002:adf:e609:0:b0:2f5:9800:8d3e with SMTP id
 p9-20020adfe609000000b002f598008d3emr3020561wrm.47.1685650701710; 
 Thu, 01 Jun 2023 13:18:21 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 r13-20020adfce8d000000b0030630de6fbdsm11112436wrn.13.2023.06.01.13.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 13:18:21 -0700 (PDT)
Message-ID: <2fe8601a-93dd-8ba7-2e0c-7fc2b11d672d@linaro.org>
Date: Thu, 1 Jun 2023 22:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 21/48] tcg: Move temp_idx and tcgv_i32_temp debug out
 of line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 06:03, Richard Henderson wrote:
> Removes a multiplicty of calls to __assert_fail, saving up

"Multiplicity"

> to 360kiB of .text space as measured on an x86_64 host.
> 
> Old     New     Less    %Change
> 9257272	8888680	368592	3.98%	qemu-system-aarch64
> 6100968	5911832	189136	3.10%	qemu-system-riscv64
> 5839112	5707032	132080	2.26%	qemu-system-mips
> 4447608	4341752	105856	2.38%	qemu-system-s390x
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h | 30 ++++++++++++++++--------------
>   tcg/tcg.c         | 19 +++++++++++++++++++
>   2 files changed, 35 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


