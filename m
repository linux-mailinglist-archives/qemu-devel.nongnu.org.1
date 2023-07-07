Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3A74B77C
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 21:50:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHrTJ-0001zu-4R; Fri, 07 Jul 2023 15:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHrTG-0001yu-AT
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 15:50:26 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHrTA-0006yK-Sq
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 15:50:26 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9922d6f003cso296324666b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688759419; x=1691351419;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gsJFcU87Ses0H12xUGrBivfmaW2VxYbgrPDRsuNAeHc=;
 b=iaExMKvvH8cTp2tmgojMUWNyD1JjNJ7JDQtcBeAmXmKTvbdVxykrQTYB1DbSeVwSZP
 B+o0Z80u1vQKwulwNuutl5yJdTLDuiCQ09PSTk3UK0U6y10dJPIfQs+AujlQ2u9m1wOw
 O6uss2HEuNqmkpJGb7rffD1IiAP9+CDSLXJLYieQCJ97XAT2k4APpN/xeiwrmEb/xXxB
 r5Q6/Y9d5bnEGFzgCKgoSiG+WzuOXEZeHGZio68LoB/kr3k9MFrJvyNqoFTAqaUE0KpN
 5k6NSArpIctQdzmu71xlwaLaSIM+Q3WK6BLyVcf8qsik2JvY/L3EislS35u6egLTaLNT
 R0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688759419; x=1691351419;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gsJFcU87Ses0H12xUGrBivfmaW2VxYbgrPDRsuNAeHc=;
 b=im5MYeNzxl8nQZIrrCqXb2a7wHpQn72GV0t8IDCY4jE467PjYDELY/WfHJanYKwnvM
 m+0Bbuo47AvwZ9awk5mppujwWvjILrTrq8Z8XKad6OfjX8T3WuFebOehyhk56ZnUg0b1
 ij4ldp/H74OoRrrzIRsbO8U6NTJ+daKBIac/tN3zjR1eFZx1wHnGOVwBOdAyAJ5AqZyk
 JOc97eUrv2sG7Cpae4A817VB/yIkEQA8hDD+Wm9ahf7E5IyD1Ci/6n4hO6UgRTYMaiCa
 L0GLhj9KIwCzfT8/8aJsLeQuYy1GgGbkCr1aKnL0aBHneXx5FDDY73KTzpdEtjMCzG1j
 OtJg==
X-Gm-Message-State: ABy/qLb3X3KwtAyuFEnME2oW1AM4ll2E6HEth55gwMal2+OBN+LM27EF
 tKfmqa9FRis/hCoH4Xu50YTMZQ==
X-Google-Smtp-Source: APBJJlEOfw/N9ht4WFJwt7krqzxIAA8I9UDrFRtEfNSszfEaLv6j86PQmzlwMr1hM2z091KR8Kby1Q==
X-Received: by 2002:a17:907:1390:b0:992:8092:c109 with SMTP id
 vs16-20020a170907139000b009928092c109mr4459590ejb.51.1688759419228; 
 Fri, 07 Jul 2023 12:50:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a1709060e4900b00982842ea98bsm2529437eji.195.2023.07.07.12.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 12:50:18 -0700 (PDT)
Message-ID: <a897a164-ab0b-8398-f6f3-0705a4625a4a@linaro.org>
Date: Fri, 7 Jul 2023 21:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 22/37] target/i386: Use aesenc_SB_SR_MC_AK
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
References: <20230703100520.68224-1-richard.henderson@linaro.org>
 <20230703100520.68224-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703100520.68224-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 3/7/23 12:05, Richard Henderson wrote:
> This implements the AESENC instruction.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/ops_sse.h | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


