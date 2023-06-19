Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4DE735907
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:01:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFQ2-0007Up-4H; Mon, 19 Jun 2023 09:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBFPw-0007Ro-71
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:59:40 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBFPt-0001Y1-R6
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:59:39 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51a2c60c529so4349141a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687183176; x=1689775176;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F1ITw7OriNqjVl/jvxDv2HEcl5ZDD6hAU+/z548XyKU=;
 b=MlNUrEWGbkOpD2Zwm6EKKji+xfDeSvG/SMZ02AhXVcwvwV8vYhA7G7jP31qBkedplA
 DqHKcB35Bso25USWv539Hxad0xfvEDjsMiFRnlWBaK0Y7tYshdtQBBunHJBLH0O/PM1L
 pMxVKtLhM840f2dKbc7be9HBaRhjHu1A6OlsgTcNldCz4LfGjNJJpZNovQuhNmrKcblt
 5/qFsSMwpGzYzWMbCNeKqpahRt+YBrGO28vRe72qNnNDlrDat16ep/0KSNwAKJKcPMo2
 itX0MwCHImfHb/gFiT06WFPn7X5TL5rvBe0aNl82JLsktH4phTt5fr+tGJ1STCmj39Fv
 NmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687183176; x=1689775176;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F1ITw7OriNqjVl/jvxDv2HEcl5ZDD6hAU+/z548XyKU=;
 b=KQj/FP6mUQuyAAUiNMdHi8WFVhFsAZJK2pabrEOoatzS6guSMQsrCa3AlxA1yaNYRg
 bCovHuehxHVPBI9m5w5YH0Y5ZzWFv69VYXIfu5xA1+OW9Ih+eQKRUm3JOSNZ+LXzTaN3
 fCZEGH26Xxvo+FqQ9dtNaeOMEgpddeZv7YTY/014xi+tpxHWBMEDW43OrEtnnMRaMQaV
 FeEB2ZcXlWzVkHJ1so09kP150aE4k2UnMr3ftirCWvRMNb+6Vj/YzFMRYaiyXAQBJEIo
 fNLSx3LDUZ/mi6jZzqjVM6MKxCjjnSZMZqrM+8gMuqg2ljhHO1x6a7QnNcUcMD8qefs1
 AMhA==
X-Gm-Message-State: AC+VfDyVioZkwshdOM63No8IPeQaLsdJHZ5GVGNL2Ybz4bb9OqGodywE
 S8byi1ISCzE/YSoGRZbAOhvzRw==
X-Google-Smtp-Source: ACHHUZ6UJ7rEpFVmtRkuVL8WIqKAIfDIwEGylK/snjsSQ+cI9ePRKmHawPL6VWn73eXXMl6LiOfHMQ==
X-Received: by 2002:a05:6402:5162:b0:51a:4963:e012 with SMTP id
 d2-20020a056402516200b0051a4963e012mr3671509ede.18.1687183176165; 
 Mon, 19 Jun 2023 06:59:36 -0700 (PDT)
Received: from [192.168.69.115] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 e4-20020a056402088400b0051a5360052csm1711270edy.48.2023.06.19.06.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 06:59:35 -0700 (PDT)
Message-ID: <2312da69-e5f9-d8df-35af-deb7561c66fb@linaro.org>
Date: Mon, 19 Jun 2023 15:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 30/38] crypto: Add aesdec_ISB_ISR_AK_IMC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
References: <20230609022401.684157-1-richard.henderson@linaro.org>
 <20230609022401.684157-31-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609022401.684157-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 9/6/23 04:23, Richard Henderson wrote:
> Add a primitive for InvSubBytes + InvShiftRows +
> AddRoundKey + InvMixColumns.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/generic/host/aes-round.h |  3 +++
>   include/crypto/aes-round.h            | 21 +++++++++++++++++++++
>   crypto/aes.c                          | 14 ++++++++++++++
>   3 files changed, 38 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


