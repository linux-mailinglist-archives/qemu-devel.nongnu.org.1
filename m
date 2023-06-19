Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8F97353BE
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 12:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBCQT-0003vn-H5; Mon, 19 Jun 2023 06:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBCQR-0003v6-1r
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:47:59 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBCQO-0005Kl-6z
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:47:58 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so400085666b.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687171674; x=1689763674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/4KnMySEsdJGciUBevgZoZvi7GHm9hAdbVzOKBvHIr0=;
 b=PwIWnr00LbLZlGe8rdr0f/gKIAlm8Mr2dPb94U0RU2QC9093k4IkKP4/jkd1jLmwyg
 lxGyCnCpw22lJZazWVjf6MSm2yBzQfa6NLXqJB5ShuhPKCsiLwrqqqajpSl4KTZ1p1UU
 GrakDSew8IEvmMUisNoxEgXqldV/NOl89DbB9rWOgT9/isqWcxW4j+O4roHZ2iSvUBwp
 ESyeVBcTC5xOL81JeGg95t24ws36AQUc3UDMnkulwhU96fnVkrUIowU8sxdPg9q3YMlu
 mo4oizytyHl6OOf5KSxCqvQ8rJzQkEkoFB7dp4Ftq53oEOjTiAUKYhGCyRnAkdtUBZBY
 xDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687171674; x=1689763674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/4KnMySEsdJGciUBevgZoZvi7GHm9hAdbVzOKBvHIr0=;
 b=QmkNQFF+/e0GKXsVPF9ZSO1zTS448EvL/I1rl66izMB95W7QBbiqZabPzZtK4tvVvy
 uVZd99bTdIPk4rcD4RypIlnp3HHERMPKHkGbUMCsFB2uyhcPJg8l7ROZpjZI+EAooV3c
 qd967qB5mjMiDurRpq8btcEE8eYvN/Cb8sLPjhInN0Qok3Viv/2bDq9q9A9zisAgVjKb
 RbCRpVfZiusp68q4JBu7SRnV2egK+TK05cI3UMd/uUaskb4FlDiLcr1z3q1De3y/1VH6
 sHcN1DPjnEysr/qkDOwbU+583YUGnhCg06OzIlOyARc2c/DkzvscLGSq1n/lR0z6i3Id
 wEXw==
X-Gm-Message-State: AC+VfDzg5mjKypj6Qn1ypD08llvnVkfyAWrs5OD1v00/FEGZ7Tp5IVO0
 Pbd908e3TSKwEyHKCgcxO1so9g==
X-Google-Smtp-Source: ACHHUZ50J2prAwsUQL+4Jnqn/uuCpW5c7YeOoUXfWf7Ie03yIMGGgvInWnVGfWCM9w1FUBNbg8UCPg==
X-Received: by 2002:a17:907:6096:b0:988:9ec1:a8c8 with SMTP id
 ht22-20020a170907609600b009889ec1a8c8mr1811565ejc.54.1687171674607; 
 Mon, 19 Jun 2023 03:47:54 -0700 (PDT)
Received: from [192.168.69.115] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 gu4-20020a170906f28400b0096fbc516a93sm14470950ejb.211.2023.06.19.03.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 03:47:54 -0700 (PDT)
Message-ID: <3dccf713-e5d7-5e9a-8704-bec1812669c4@linaro.org>
Date: Mon, 19 Jun 2023 12:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 10/38] target/ppc: Use aesenc_SB_SR_AK
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
References: <20230609022401.684157-1-richard.henderson@linaro.org>
 <20230609022401.684157-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609022401.684157-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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
> This implements the VCIPHERLAST instruction.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/int_helper.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


