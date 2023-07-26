Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A764F76426E
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 01:11:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOnXD-0000X9-HX; Wed, 26 Jul 2023 19:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOnXB-0000X0-Rg
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 19:03:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOnX9-00030P-Vq
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 19:03:09 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so2210405ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690412586; x=1691017386;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DQrCKj0hVQYLl19lkRXTTtpwyKJiJxd8auR2Sc5hs1Q=;
 b=oBhQS1ZtpPSevNje0Jgco0Z25Wfa+no1hZrgm8d2GFXuBJRx8Yf5c+TvCyfF1F0wnE
 FvHjdcBFot+fjIQeCJ0KtqxGwm46ef5Pe0sZoRskIhsYlwRQLhhsPC9iG1m2FRKCIFGh
 dc+pnv4FQSAPObAZ22Y4z123vgsy4MBUiW6bRZfaqXFREvH/Zc4zE3clQpb0fw5Qo110
 r5PFfsryvRKcRFsUYqB14TyDGN0k98eswQG0o06qyVHjnyMFuPFJ2voSJUXCx/0BPK34
 slcgVJOlFRK3c3iyepg+VWZrYEextffsRlUI/f3g0PZ/oS9xjqDu3GP3TC+6pLkkI5S2
 sfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690412586; x=1691017386;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DQrCKj0hVQYLl19lkRXTTtpwyKJiJxd8auR2Sc5hs1Q=;
 b=Y8DkZkyoXXkIEVSCHgpft4uyhJwLLrKI00CLpT6rLWN+kxRcxNKR4uUmICZjft0cSn
 ZcgAxJmyYJE3SD1sEvgvUi7moD6E2txzxNu0sUItvTsbpeMPTkOaigw+f9kjMMWvTZLC
 56rt29Ug/9Klv3fHLCtn3o0r4mZCfa1NbTU9UXpIisgsANPAf/M89G+t1mlhc+F/Y2iN
 lDUtGRI6xptRkJOdUMvitUHgulnUUC6A9+JmLjdacMHoAoyRRq1cpV4Ai7RJWiHgG6Qm
 OjqBImzcpl/gQu9e2h/p/8/eM5OH94wpi9Dbqw4qtot/ekxAMI7K2lgPJ50MffHhP8mg
 dSkQ==
X-Gm-Message-State: ABy/qLavKl49fJpDdRroXOggTzbmXTvTB9/Esa8V1bLlv/2ATm3rDZBO
 W+OUPRU+8X3RB5MXpyep032nSA==
X-Google-Smtp-Source: APBJJlFtwx/PCPAuTBMt0K22OHG7C5YRxeNaSFUNY2ukBQMUorZtzELy4VBpMSkkordH1Zb7qGG+MQ==
X-Received: by 2002:a17:903:41cd:b0:1bb:b74c:88f6 with SMTP id
 u13-20020a17090341cd00b001bbb74c88f6mr3389763ple.16.1690412586216; 
 Wed, 26 Jul 2023 16:03:06 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9456:37ab:20dc:17e1?
 ([2602:ae:1598:4c01:9456:37ab:20dc:17e1])
 by smtp.gmail.com with ESMTPSA id
 jb15-20020a170903258f00b001bbb22652a4sm65644plb.226.2023.07.26.16.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 16:03:05 -0700 (PDT)
Message-ID: <bc9193e2-6582-c776-e491-12d344eb3d8a@linaro.org>
Date: Wed, 26 Jul 2023 16:03:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/8] machine: Introduce helper is_cpu_type_supported()
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20230726003205.1599788-1-gshan@redhat.com>
 <20230726003205.1599788-3-gshan@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230726003205.1599788-3-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 7/25/23 17:31, Gavin Shan wrote:
> The logic of checking if the specified CPU type is supported in
> machine_run_board_init() is independent enough. Factor it out into
> helper is_cpu_type_supported(). With this, machine_run_board_init()
> looks a bit clean. Since we're here, @machine_class is renamed to
> @mc to avoid multiple line spanning of code. The comments are tweaked
> a bit either.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/core/machine.c | 82 +++++++++++++++++++++++++----------------------
>   1 file changed, 44 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d7e7f8f120..fe110e9b0a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1349,12 +1349,50 @@ out:
>       return r;
>   }
>   
> +static void is_cpu_type_supported(MachineState *machine, Error **errp)

Return type bool, false on failure.

> +    /* Check if the CPU type is supported */
> +    is_cpu_type_supported(machine, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);

Fold call into if, and no need for local_error.


r~

