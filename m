Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47956745661
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:49:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEIn-0006Ox-50; Mon, 03 Jul 2023 03:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGEIi-0006Od-3g
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:48:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGEIg-0007ym-0B
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:48:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso38433285e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688370524; x=1690962524;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VGIw2t0fXaefG68IzOFMEvW7pBI3/YhduYPDEQiG8kE=;
 b=NJJYqm0AzxWVALM0y22RYKycE9OrMRdX7au7u+M2ycZkmTeFkooQ4qLSrQOd83R9ze
 krZUpmsKOEKhIAXaC0yHuVBrP07kRN6DrlN0xK8voCN2l7m5QGTjgyXRyXWr7NDihSgw
 hVyNyelNTVend8N0iQlV9SmYirTVAX/ImeHRHF7X4NTOYx29yVLOYH1MD4QW6PEqjg6/
 /l0vxwuIxqRmJJJd4UNP/kIPobgfyv84ln85JtPxrL/oEP3DNnnHwoV5vXr0FDwQj43O
 OsvdqwaKrcuLbIRP/NP+hLxGMHede+gDoJTDjcrguiqBQvP+xLGIitKtzNM1zNho6uEs
 GYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688370524; x=1690962524;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VGIw2t0fXaefG68IzOFMEvW7pBI3/YhduYPDEQiG8kE=;
 b=RYLvWQUO9IeYJ4erQdHpOA4lBOfwW4mtdjNphKBu27h/G8DtXhic/l1VZS+KpL/s6y
 hCQIP/AfJJTSEElz9mW6uTcf242v9UVWGBHub8UhjqqsOpnD1e8rk1oqk9e0SdZacEen
 6lr6Ot4X6A2zhX7F9b0lN2jDXs1AsXEnJ9cvBoLTbYH0s7JGf9/ixgrpggpjCkz5zgr8
 iubP1bshoHzKey6TC/szZ5eD3zWooWeLLv+ArE9fXxxgxbhf6CVxPWptuArgqNJXpBGQ
 MlgVmwHLXpvZk/DnJidsTva256Y6TqKIncaq2PWGc4dVIZD7J9ffAmqEN5nstMcrYaVB
 kJ8g==
X-Gm-Message-State: AC+VfDzVtE/dpr9dUllqXQEBwBbhD+nZKvBguwOCv1rI7UpDxl9yGV5h
 W1hfVSZyGQx9FLznZ5R2Gc1/6iNF69UhEq5g1pU=
X-Google-Smtp-Source: ACHHUZ7k0l3CqdrV4LR1ttqbvChy7HIVw8HMbfMCZePVum3mD22nuEQIuLbMQLe++GEY+4Y9AI2eZQ==
X-Received: by 2002:a05:600c:2299:b0:3fb:b2a5:aeac with SMTP id
 25-20020a05600c229900b003fbb2a5aeacmr8128982wmf.20.1688370524268; 
 Mon, 03 Jul 2023 00:48:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003faef96ee78sm19960079wmm.33.2023.07.03.00.48.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 00:48:43 -0700 (PDT)
Message-ID: <ad1cd84c-5b8a-1692-73fc-8bda83f4da9b@linaro.org>
Date: Mon, 3 Jul 2023 09:48:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 01/21] q800-glue.c: convert to Resettable interface
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230702154838.722809-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 2/7/23 17:48, Mark Cave-Ayland wrote:
> Convert the GLUE device to 3-phase reset. The legacy method
> doesn't do anything that's invalid in the hold phase, so the
> conversion is simple and not a behaviour change.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800-glue.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


