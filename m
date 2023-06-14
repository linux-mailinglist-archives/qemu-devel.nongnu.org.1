Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1772F419
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 07:19:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IuP-0008A2-IG; Wed, 14 Jun 2023 01:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IuE-00085v-7n
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 01:18:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IuC-0001gb-Q2
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 01:18:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f8c5d0b216so2184425e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 22:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686719931; x=1689311931;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p/OemhwbcezN/G/2+1eIZHya+G/idBcQBVZo6oAF9Q0=;
 b=VIBvBAeWOOIzc2DfHcHORkH6CiuvTDlReW0+04xmisMGnNv+oQpjNeC/bHOseN1+ys
 Vi/OYnmaybh04OXkaxDw/Zn4JPop1o2P+5c8NK/ZrkXMIJ06XG1nG/VVHXcRU1hjG00q
 KyckSI+gk2FthJ+41uClr9s3YCCZXD2a437oBIXVAvWK/XBd3V3lDEjEzPA75lxuzyRo
 Q7g/qPh0o59y+R1RiPTYyXc8VPwlr4J4bcR/N2byLf6txpNJ2UH5a1Dj7PjylxeZ1Mga
 Mg3ZYr5We8ZmCyDVS5Xd8GU5l1V96guca7/72PwQ4ZWcoY0UuNdtbObEylUIwZTRW51s
 enyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686719931; x=1689311931;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p/OemhwbcezN/G/2+1eIZHya+G/idBcQBVZo6oAF9Q0=;
 b=fxBg1ViyYiaXUUcmGDnb5WYh/tDk/aogmDFEiXM/42emU6CI7VM8Oz+pyF8+GJ7yE9
 vNMP3IsHm2kps+hGFopzA8w9AIZceqy2gY/2nv7eYE+k3BOIU6Oufrcgsgw+TefqJbcI
 dy6usZ5sXlOlCOM4APztHAXg7PfjFL7WNUd9o3PkVmykw8Ed5naP6e7dT+Vl7rCPKJdj
 1K7/Hf1ukPsEGq649KD0cDZGIShOoQKEQIULM0eTmahBISiSVdp4rwpgiPfYLWIgEskN
 vac1Wuvw6QPerm7miY9iSEIwEM6dJQ2N+JzjMSfMi5GNNq69uDuzbwb7TGXHY5jWDEsO
 67TQ==
X-Gm-Message-State: AC+VfDzN0EYT81CLzv2a2I7XYQCEV6Itmb4XbiNkSBoMSrrRbjQ6L5TG
 XusMYRp/AY6IPk9ClCCI/muA2A==
X-Google-Smtp-Source: ACHHUZ7LKy4b8l3aN7LOKW/QG5o7rabxJfl3ayrvrT/9qLjPrqX8Oc585pI0Sbt6ePM5eudd6gNa/g==
X-Received: by 2002:a7b:ca46:0:b0:3f4:f4d1:5c28 with SMTP id
 m6-20020a7bca46000000b003f4f4d15c28mr9265544wml.24.1686719930786; 
 Tue, 13 Jun 2023 22:18:50 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a05600c224700b003f60a9ccd34sm16311201wmm.37.2023.06.13.22.18.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 22:18:50 -0700 (PDT)
Message-ID: <fb4877cf-6066-b062-95ee-2fd8942b3411@linaro.org>
Date: Wed, 14 Jun 2023 07:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/23] target/arm: Pass memop to
 gen_mte_check1_mmuidx() in reg_imm9 decode
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230611160032.274823-1-peter.maydell@linaro.org>
 <20230611160032.274823-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611160032.274823-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/11/23 18:00, Peter Maydell wrote:
> In disas_ldst_reg_imm9() we missed one place where a call to
> a gen_mte_check* function should now be passed the memop we
> have created rather than just being passed the size. Fix this.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

