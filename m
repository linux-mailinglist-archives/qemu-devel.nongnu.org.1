Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD970FE56
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 21:14:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1tus-0006nN-Ti; Wed, 24 May 2023 15:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tug-0006kz-G5
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:12:46 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tue-0008WJ-DE
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:12:45 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ae763f9a94so4670915ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684955563; x=1687547563;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UZounCEO27Aq4lWQOtxxMwNa8G+Q3HaiVnHfppqs2mY=;
 b=BOjZQvjX/MMsF+CMMXzIoYJ6My3Ii5wcZxeZZ3OmFxZfrKmgSeysmV4UIuUGl+Huek
 xHJtjeyTykHoO2vhidWerZy6mQIgCrODKfi8rD4bvQ1Gu6dj9hGOQKYbsvPAckoEQc+1
 2mK41P9lb2M6u3rxtb9KJQIZPqF4xnAJY/XOILSqiDfjBUQOFc+m2a7d3pNkCzDZDatN
 wDXA/j2L3Cg4WLutTgTLY4J9OFVbaggGWGCDRbHsp6QiGidL28oMgVtMHhUTWOeT6vKY
 zmGIBREJIUql4nSdrTofiwq+i/M/88rzCcTT0vNPptP2yTedxfz+WiyuYy41MUNU0Q+U
 zh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684955563; x=1687547563;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UZounCEO27Aq4lWQOtxxMwNa8G+Q3HaiVnHfppqs2mY=;
 b=QlKNcPlZS9+ZTw1N9+efTCaMHckaUBJp1Ba5oQ7R1tBaWnFPZmLmysDLK7wsrqg1rn
 d0E7C7l0cSmljWtA2gwjP9ogFrQKeAaBiE4tzWLEvVTXW2sdZDtCD5zjKM48ZAB9Ypm2
 bmvPMc//cW+mEGFXi/eQZq+puAQcjxtkt7EdewP2mWF7apBqhYBINefqN1G4kZJac+ut
 DDsVw8IDe/dx8jyvfLoTRm/44g3vUahwR0S0Pk9Jjq47f5ZPchMqcJdtAgLyj8qS6eIN
 8vLq/0fTCoTtmIq2MJQ0yQE6ovX/ELwsC+SJXSl+XSi80kXXTlIvZvIrR03ffa0pPHqU
 qkzA==
X-Gm-Message-State: AC+VfDzQaSQLcEPNIkXZbY2UW33AW8Ai6N5mydsY8nDvIMKjxeFSfqlv
 BlJfMqE+bvQMRK+BY7N2a28yHA==
X-Google-Smtp-Source: ACHHUZ7M1eL7Dbq0vwAIj0WJN4rT8/5iPe2Q3z8S2nC/KQPQ4cYnPfhGwLwma907S2xazAQIWoBeLw==
X-Received: by 2002:a17:903:1d2:b0:1ac:7260:80a7 with SMTP id
 e18-20020a17090301d200b001ac726080a7mr22939103plh.43.1684955563001; 
 Wed, 24 May 2023 12:12:43 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a170902748a00b001a67759f9f8sm9103687pll.106.2023.05.24.12.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 12:12:42 -0700 (PDT)
Message-ID: <f5c0fcdf-52f2-f2fd-61bb-bcc5d0253844@linaro.org>
Date: Wed, 24 May 2023 12:12:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 09/10] hw/arm/realview: Use generic
 realview_common_machine_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20230524145906.33156-1-philmd@linaro.org>
 <20230524145906.33156-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524145906.33156-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 07:59, Philippe Mathieu-Daudé wrote:
> The realview_board_type enum is now unused. Remove it and have
> all instances use the common realview_common_machine_init()
> method.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/realview.c | 46 ++--------------------------------------------
>   1 file changed, 2 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

