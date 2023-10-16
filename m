Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7345F7CA3E7
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJji-00053Q-FG; Mon, 16 Oct 2023 05:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsJjf-00050J-LQ
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:18:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsJje-0006N7-2t
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:18:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40675f06f1fso32497045e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697447880; x=1698052680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J8HBoxwSOZi2fwOpU7PzOzC4cbtiKQcsj4DLLMwgC3Q=;
 b=Vmz+wPDSe3SKf4dCyV/BFN2Jv9xUwBcew63hkoxACtXZAYPPWvAEISfcIgwz+qaKUB
 dpuhv7P31hkRCkYkVMqo+fkTX2HLCJF3BIVX7zCshG7aLKIdO9A2FjdkBijn3k1AZxnS
 HkpKLguvi9Tx1iGk8GvUeLh9psgWHf5MyWKvjwA08L8/sC0Mz86K1bHi3B77YiiUulpX
 ttkD4lDdjokoe/ibal6gnaMd0069Vetq12rVKaLlv/ODRDa8AiNr2gfMDX5n7OKlfOXl
 l7fwZXXYcobcN8fJgQNdRszF9OlLWBIJvqg+Bi0BgweI45cK30yl9bWCpRTILtmG06Ou
 9qZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697447880; x=1698052680;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J8HBoxwSOZi2fwOpU7PzOzC4cbtiKQcsj4DLLMwgC3Q=;
 b=OP1eryqFhsHKP5ZaV7q2YGqSDi7fF3o3WGYi+bTXZ9A3fTAfdEAnTlYrdYnmkSsCfI
 Mn0ctEJel+UH41ZNNlanrtGxiphbvBkhCHtwJBuZNRI1ILDD5HR8jCn5D6As1M0u15sS
 TPo347RTxwnE8gx4sY8ANx99jW7DVhliAMT+ome4/m5Lsp7m0fDUaqhd1bU+dC8xFsPn
 RAdNDU82OhETVGE2pze9vpyPMwoRQrs3MLbLIjF23LUqOPOigDxETrrO3rrpBmP4+61W
 doyEodPy77hIZ2enJkLyk7wEYU3+4rpIBNwm7s0zaak8G4DKKOxJg32tp6bZJQuNUTfm
 Z8eg==
X-Gm-Message-State: AOJu0Yxm5KeauqB0VHogwRC5/7n3D+v313RquWb1toxVz48qnGxyuZZR
 tTR5gylfAvbkh3wYnRzR2eqiLg==
X-Google-Smtp-Source: AGHT+IGYq5OTKWzaumcL2JmwbMiHJEbe0pmucPJB0hu30X9ZN4XCNuR7IyPnpgkBCX+AsCzbNi0Tmw==
X-Received: by 2002:a05:6000:1c16:b0:32d:846a:e987 with SMTP id
 ba22-20020a0560001c1600b0032d846ae987mr5537672wrb.6.1697447880522; 
 Mon, 16 Oct 2023 02:18:00 -0700 (PDT)
Received: from [192.168.69.115]
 (9r679-h01-176-171-216-136.dsl.sta.abo.bbox.fr. [176.171.216.136])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a5d5444000000b0032da87e32e2sm4330991wrv.4.2023.10.16.02.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:18:00 -0700 (PDT)
Message-ID: <bdac37d1-cd6a-d2da-3aca-9a4a8e46254f@linaro.org>
Date: Mon, 16 Oct 2023 11:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] MAINTANERS: Split vt82c686 out of fuloong2e
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231015141517.219317456A7@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231015141517.219317456A7@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 15/10/23 16:15, BALATON Zoltan wrote:
> The VIA south bridgges are now mostly used by other machines not just
> fuloong2e so split off into a separate section and take maintanership.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---


> @@ -2491,6 +2488,15 @@ S: Maintained
>   F: hw/isa/piix4.c
>   F: include/hw/southbridge/piix.h
>   
> +VIA South Bridges (VT82C686B, VT8231)
> +M: BALATON Zoltan <balaton@eik.bme.hu>
> +S: Maintained
> +R: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks, queued to mips-next, keeping a 'M:' tag here
and fixing typos in subject / bridge.

