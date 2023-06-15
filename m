Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1CE730E9C
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 07:20:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9fPH-0000DU-IY; Thu, 15 Jun 2023 01:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9fP5-0000Cn-8V
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:20:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9fP2-00066U-MD
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:20:14 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f736e0c9b1so14432595e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 22:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686806410; x=1689398410;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tDZvX4L2yKqFfybW1GYuKllPdQ96NCt2SDA1uTM0pqk=;
 b=FjyRCF9ZRFHE6WaypMlMDnl6yAAJn//sLZ1MLJxwTLe7mXL/9dQjyeCc9z6B922Evq
 MYgM86hUjSi7f9x1V+Q3zxYUkje4lNVcOkGpYjYZ195tg2R8ONmjoN4OdKOMGEu0kOJ9
 X2aG6ToJP7DL45b93FFEYW4Cm859HDqGcabFhGsT3mtwwsGQ/YIJ470YCmaX5LfnXj40
 QSFir1kzCtCa/Mtvj9Q6w+W6wg8++tqok9UgHzi7cFpwr7ZNLMVHvU1vj2L+llH8Zy0B
 vffmxmjqk8hNbpsCZ8r22dGNwOeVidpVBrkPuApUCi4UbGQbGbuLxopkuJoI7U3NScaL
 JP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686806410; x=1689398410;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tDZvX4L2yKqFfybW1GYuKllPdQ96NCt2SDA1uTM0pqk=;
 b=kXaRuoHtOFCOpPcWporEXNKPlvB3dm2hji0j+OGTd7EGC+VQLjVUB1bws8/EsbZ6Cd
 N+luDrZLHNHj8NXsH6yKP3e8+Gx4nCY0FxGDcmesxO2zg6n92na+IXrCWs3r6U+oyb46
 liAc3j6tleq3Y5j13hqVOpFV4fOVbQwoMFhLtfopgpPJZGFNijVUHwav58JMsYuxRoL/
 9o1uUTF1KjpziLBw1BnndxSey7nhoQiPPC9Nhc9hbuMcRLsEm9q9AAm7PiybGro8nswH
 W3zY80TUjJ4N6alNfW/vcTVsQ6xFLU7LU6+H9+pOteCIvDBPMKEJMP7sMqdL4VDtWHwW
 3KOg==
X-Gm-Message-State: AC+VfDz/vuqVr87V6aHjBIu6GUpHWByJmHIL0G4Q5esA/p7CB40wkhkd
 /IQdkvG+cS5WylaF62hfd5GJgA==
X-Google-Smtp-Source: ACHHUZ6N2ahred8xlnNfDDJLH/Uw3SUAHkQsndYr96fiT4HkcNE2QclcGuwzTOVvAb19vl8wFNjohQ==
X-Received: by 2002:a1c:6a18:0:b0:3f7:e536:8f06 with SMTP id
 f24-20020a1c6a18000000b003f7e5368f06mr12896376wmc.26.1686806410645; 
 Wed, 14 Jun 2023 22:20:10 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 u26-20020a05600c211a00b003f42314832fsm19199790wml.18.2023.06.14.22.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 22:20:10 -0700 (PDT)
Message-ID: <ae60173f-5958-b40c-516e-9a237518a9ed@linaro.org>
Date: Thu, 15 Jun 2023 07:20:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] target/tricore: Implement privilege level for all
 insns
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230614165934.1370440-1-kbastian@mail.uni-paderborn.de>
 <20230614165934.1370440-3-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230614165934.1370440-3-kbastian@mail.uni-paderborn.de>
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

On 6/14/23 18:59, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c | 41 +++++++++++++++++++++++++++++---------
>   1 file changed, 32 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

