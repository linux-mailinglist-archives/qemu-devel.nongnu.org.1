Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9D72244B
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q686u-0000TY-DG; Mon, 05 Jun 2023 07:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q686h-0000Sk-TS; Mon, 05 Jun 2023 07:10:41 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q686d-00040c-50; Mon, 05 Jun 2023 07:10:37 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-39aa8a055ecso1004961b6e.1; 
 Mon, 05 Jun 2023 04:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685963430; x=1688555430;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NqVQzA6HLrDC03MHrMN3lkQzP8OwHuydMA8hRjgQzI0=;
 b=rmChQIKabIdpXuJh8N2ScLQnSwZrkfijya/arm/iSdrYUPPMDkRfR2t6i7AyYkKnM6
 OJdu3wxCT6EV37Wq9fcUnBP8boY2UmAEyDwn+fa5+qDoTrQZjF1jN+GAxLmiHTeCi0sA
 5r2+O1xAykuxkeGF+W6nbyGvggvwclRhqgcIM+QFZaV882EwxRWh2t0/RScQpiJ49jIp
 xD9CFf5bG5x2OzzD5cWHjYxRdF3uk7VNevWTjrnAXTyztagFSD6a3J6N1lNBJLSAHByk
 dy3my4H3vjeZ5NCfE2JXqStaKxEJSpvWcpi4M+khX1ChhT53R30nEn2fCJ+SeY5r44v/
 gFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685963430; x=1688555430;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NqVQzA6HLrDC03MHrMN3lkQzP8OwHuydMA8hRjgQzI0=;
 b=EvZ4xEd096S8DXww0IupEKGJ84LwA+R4S0jBDAw3K97dom2JUzP4ot8D0+5eYppErV
 IX6NGJTagCLvvWNJ5SH0pSsFhsNe4ZcWw+TGxaUUI6Fhtxg/rGwa1ilZXJXPW+7HSbFu
 mA4DZy89frdruvSan7fNAMp0FpF3rAS3yq62c7fLvPm1H9atKMlhYeXdydw3VvaiIMcy
 6IOzhXSf8w+1GBTrCJgMOqKK3gTN5t57BFSmH4sl5Ly4SgfhFERba3T4wpZabasWPNfc
 a8NYq0uSe8r2kq1ZzRYKnTeJAGXCHSb+qctAtCZZricf0IdTDVApjS0A5T9u66BFRpsP
 Jznw==
X-Gm-Message-State: AC+VfDxZf3Ck47egXaUxtnHCeLRuYS0SwhDq9tv5cqSVgrkMLbSNACfe
 6S+/8TzV/e/d2AY9+thNu5A=
X-Google-Smtp-Source: ACHHUZ7U+c+VrPVuNNMBdW5ccsXMmwEtfUWRMmCs4ukRHAXNf498u28kvinQK+0fKE0h9OWTHqQbjQ==
X-Received: by 2002:a05:6808:4c7:b0:39a:98bc:10e8 with SMTP id
 a7-20020a05680804c700b0039a98bc10e8mr2975788oie.28.1685963430706; 
 Mon, 05 Jun 2023 04:10:30 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 y126-20020aca3284000000b0038cff7034c0sm3278682oiy.27.2023.06.05.04.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 04:10:30 -0700 (PDT)
Message-ID: <0237ea14-67c9-b4bf-e656-8337487df427@gmail.com>
Date: Mon, 5 Jun 2023 08:10:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/2] target/ppc: PMU do not clear MMCR0[FCECE] on
 performance monitor alert
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20230530134313.387252-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230530134313.387252-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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



On 5/30/23 10:43, Nicholas Piggin wrote:
> FCECE does not get cleared according to the ISA v3.1B.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

And queued.


Daniel

>   target/ppc/power8-pmu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
> index c4c331c6b5..af065115f2 100644
> --- a/target/ppc/power8-pmu.c
> +++ b/target/ppc/power8-pmu.c
> @@ -289,7 +289,6 @@ static void fire_PMC_interrupt(PowerPCCPU *cpu)
>       pmu_update_cycles(env);
>   
>       if (env->spr[SPR_POWER_MMCR0] & MMCR0_FCECE) {
> -        env->spr[SPR_POWER_MMCR0] &= ~MMCR0_FCECE;
>           env->spr[SPR_POWER_MMCR0] |= MMCR0_FC;
>   
>           /* Changing MMCR0_FC requires summaries and hflags update */

