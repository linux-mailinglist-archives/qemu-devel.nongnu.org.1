Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3797972BC50
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:28:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8dqT-0001jM-VL; Mon, 12 Jun 2023 05:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8dqR-0001ir-QG
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:28:15 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8dqQ-0006HR-4c
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:28:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f7ebb2b82cso42739195e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686562092; x=1689154092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M967LEERHvZrlTsC2WemRJWeeLVe14SnPixIQY4F/EY=;
 b=Ai3u95agQu6eWQ9wni15CC0k2ijTnZEpiTYNCXBUm0RG1Jz4TSP7ZhNuEmVSZjbaSN
 dr1ZM5RU7Jt45I1wh3Rr2BplA8n3Z5z/diol8fovThvqRaiBkH9PQ4w74SkOfOcIRgww
 e3Aqd9sV/uIMo34XTBROaGaa7VI2m3k4lQdMzuDIwHYXEYbNXsOsZX0CJ91QHXoat5e8
 jqwQdTRfxeFUKlB9j+bRyMoB9V1jHtcEWh6f8s+kh8b15qXx7Hm35b9dqKL3DucRBZHe
 zplBqLFuo9YOO3rbz5euwF8Y/LPgEZwla6jq6rCsttX7RmKauIb+D+6n41dj1HO4z/Fc
 JKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686562092; x=1689154092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M967LEERHvZrlTsC2WemRJWeeLVe14SnPixIQY4F/EY=;
 b=UBLGJZncAElA+apr1eFUGmvl6s/uI5vFUBEjJiOF67zMAls9dh14JxqiLNuz7x4BCh
 y+uAJeNa02degoLSeWTdhUz9XWllBj4VeSyCFdbHjJVSft4mucsdgTupPoWUMGN0DWU7
 lnRA/etaRtRx6iiJ070qZ63jTdCnJGq6Sf/d3d3IJZ25m7aakEzNvxcsxYKDpkgQMd8h
 /ej2TuJ4I5dw6kbu+EYWIclCrxRe0G+7euJrG9Z0hcZ/ENDDnn4+eTcZals5QmTQKotS
 kAp2ocoGuhHlSzeKRKudXC+suXIw8KK5wl1fW1oSM5fyu5XINxknzCIghJqv1DlroygP
 prrw==
X-Gm-Message-State: AC+VfDz6dI7YuhQNlh5Ie2+SaeVOM341AO9szVlEy7ytM/wnewUlRqOh
 FVrJK0Z1TJMxBp2R+hyfR1cq1Q==
X-Google-Smtp-Source: ACHHUZ4OMcZkbBAeMvOEJiV7SpKZsuD3K4WhH65DxdM0YLFee8HwtoIrl4uu3vuBeOU6o4tOpxZKrQ==
X-Received: by 2002:a05:600c:287:b0:3f6:766:f76f with SMTP id
 7-20020a05600c028700b003f60766f76fmr6324481wmk.36.1686562091962; 
 Mon, 12 Jun 2023 02:28:11 -0700 (PDT)
Received: from [192.168.143.175] (17.red-88-29-166.dynamicip.rima-tde.net.
 [88.29.166.17]) by smtp.gmail.com with ESMTPSA id
 k9-20020a7bc409000000b003f6050d35c9sm10773966wmi.20.2023.06.12.02.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 02:28:11 -0700 (PDT)
Message-ID: <c2e2a63d-8cfd-35d2-bce2-7046895d6da9@linaro.org>
Date: Mon, 12 Jun 2023 11:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 03/10] target/ppc: Move common check in exception handlers
 to a function
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <e7c1a61de1efdee932b71fada93dd58a3ce951cb.1686522199.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e7c1a61de1efdee932b71fada93dd58a3ce951cb.1686522199.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 12/6/23 00:42, BALATON Zoltan wrote:
> All powerpc exception handlers share some code when handling machine
> check exceptions. Move this to a common function.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   target/ppc/excp_helper.c | 112 ++++++++-------------------------------
>   1 file changed, 23 insertions(+), 89 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 3783315fdb..e4532f5088 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -403,6 +403,23 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
>       env->reserve_addr = -1;
>   }
>   
> +static void powerpc_checkstop_state(CPUPPCState *env)
> +{
> +    if (!FIELD_EX64(env->msr, MSR, ME)) {

Preferably inverting this if() and returning early:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        CPUState *cs = env_cpu(env);
> +
> +        /* Machine check exception is not enabled. Enter checkstop state. */
> +        fprintf(stderr, "Machine check while not allowed. "
> +                "Entering checkstop state\n");
> +        if (qemu_log_separate()) {
> +            qemu_log("Machine check while not allowed. "
> +                     "Entering checkstop state\n");
> +        }
> +        cs->halted = 1;
> +        cpu_interrupt_exittb(cs);
> +    }
> +}


