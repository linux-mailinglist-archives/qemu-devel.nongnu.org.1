Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B95748EF4
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:32:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH99j-0002sV-81; Wed, 05 Jul 2023 16:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH99f-0002q4-Kz
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:31:15 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH99d-0004eo-G9
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:31:15 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fba8f2197bso8231274e87.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 13:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688589071; x=1691181071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zYeOppu/Qu36jETx1AY920Wy0fvuDMzwxOGZTUPKoWk=;
 b=dK5628i4uCrH9cAxCHjE3VbsrTFd194RTJhArz1vDieZkVrBh0/joKzQJqBaoc7Nbf
 B5SGma7HwvkAKrLzdgfkuoNMFvaXn/UtYTkzVatyJoZs1uLq7duGT646/7Jrnrq14fu9
 gPk20LRUclFUEECml/CmEQpbKxAZpA8vrFAlFGPcRRVzulZpFX66NCF/pc9ciuM36NpP
 js3L6/5fGO0eFy+2ltVklU1vsj7ARFFRNbxqG6z7xOM1wSUUaLuXfSwfB4klSgOzkI+v
 1CWxmitpk83knMasWKJL3YuqXkiMJyE9oYMEh4x6sUsa+L4LoSQjwWl19uKWEVd4w6AD
 6PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688589071; x=1691181071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zYeOppu/Qu36jETx1AY920Wy0fvuDMzwxOGZTUPKoWk=;
 b=L16Eta/V33jt+KsGoEh7LpdphJH4dBCvWXihs7HTST95lI+9QkygKS4w/peMFhB9/r
 5YcIxV7+xnMv1l3k7om+s8xtc1zUoLXwLYzJrp1eWQufLCSdSNiSRNOq498jvceAiAHN
 hs9ei32OpPGs0lQ000qoPCowWsUDy7M7Dwsi/vmnGyOj6YGk/q3/VvoeialLNZqAnrHJ
 hPp6THjg2huTX851A6X6cLD11Lrt/3kU8U/4kYwjPMvStDCXYb9Jl0cLRtUQsd3+C0HP
 Pq+rjescDvbDnc557EJZsGXPj7YY8crq9hTkFWaMXLGWQr/JCtBCG/7zSYjGkuNQnAAu
 m52A==
X-Gm-Message-State: ABy/qLbaGe00++wgK0Byz6QGy6lV5MuZ+6FcajnTttQ6yfZv3Tyx+0x7
 EAOim2s66dlxp/lCEhknwOfVVA==
X-Google-Smtp-Source: APBJJlEiSH5E/vq99N+qPaiS1WcdJUK03Jsfk2V/MKn4vwc9Dw5Gt/+Qc6FqqRt05jGMwXnpSaz2zQ==
X-Received: by 2002:a05:6512:32b7:b0:4f8:7897:55e6 with SMTP id
 q23-20020a05651232b700b004f8789755e6mr48592lfe.45.1688589070983; 
 Wed, 05 Jul 2023 13:31:10 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a50ee13000000b0051df5bd1cd8sm6980337eds.65.2023.07.05.13.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 13:31:10 -0700 (PDT)
Message-ID: <2d4ee5d6-db9f-12c4-63d1-6cca2118f05d@linaro.org>
Date: Wed, 5 Jul 2023 22:31:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 06/14] ppc440: Stop using system io region for PCIe
 buses
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688586835.git.balaton@eik.bme.hu>
 <b631c3a61729eee2166d899b8888164ebeb71574.1688586835.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <b631c3a61729eee2166d899b8888164ebeb71574.1688586835.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/7/23 22:12, BALATON Zoltan wrote:
> Add separate memory regions for the mem and io spaces of the PCIe bus
> to avoid different buses using the same system io region.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440_uc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


