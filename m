Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EE870DF9B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1TGu-0008VT-7J; Tue, 23 May 2023 10:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1TGO-0008Se-IB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:45:25 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1TGM-0008Rt-Fh
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:45:24 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2533ed4f1dcso5085913a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684853120; x=1687445120;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JFNp4xd579Hp5IAVfTBbHz1vK60Rg41sE8HnfvKdrTA=;
 b=Ebw2ZcJ29EBO6vMyZx1Y8PrZQ7jg4/N3SsAFWa4Pa/knYVaROMtgP9iIfvu1B9Kx/v
 QulJWmI4knByM+KnJS1h+K0t5gwpmxr0pnMNOZOQ/vh7DZ/VRImBHRqSIIbH+bkAIAgx
 hJZGUmrO0DYJ6imbhlKtuMHd2xYR/8Z6cik7wFWntbpvLad+x/UYBtvKz8RLwrvSsTn/
 eYRfk/cEwE17zY8Ua0jHi18UC40b4Gmh5GWBNu87ijesfjEpLBdtTSsGUaSJRfcpKN+D
 c4IhAdoFiitV+GaDSVsorlTwdgvoEjnVrmjTxg8euTDmZZ3OI9qsnuodW/4EqwgtAd1X
 bRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684853120; x=1687445120;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JFNp4xd579Hp5IAVfTBbHz1vK60Rg41sE8HnfvKdrTA=;
 b=JToTzRPQ0Ny/TbQ8TmQvKOELO9YXCjqDqHgflJg9BFKd04s08P7ia8s6T8ml4gPJhl
 OJTafeEBQ3NTpo7EJ8NyQ+BFrruONgElTuXGN1mKZRGc2xdYITNh95DUWdlcyNwRpsOa
 IHjhYYfIrZmaM39DJ6WZKulpX1LbrbtFwG+hlmYpLz0vKldK4pzMH1xpCtU/ZBXAX6ik
 stUi7yhIgsyNLLp0vJ5n97HGHW9O4BzReFg2UmvwFDqS5VeqODC3TgGj+zPI6R6XI+vX
 yY8Hmh79b/y5zG4fr79AcmxCqI7+gYaDinENcA2ApGB0+G/84vuNtF2dcuH1lwPF63Wi
 lFxQ==
X-Gm-Message-State: AC+VfDx9Izy7UMuZnuvxA6aQ+lH1Qrgqoj0OEeF0ye/8M8VPIy1o6D7I
 x8r4SyqX7goT691oX3FKwUC8sYTwRIUAzcms/As=
X-Google-Smtp-Source: ACHHUZ6apRlMjgtcJX3oA/KQrWR1d0MmkvymN03996JN5QrlIcvKQyeWY+7c9ZzQSCjDDMdqvFbHMw==
X-Received: by 2002:a17:90a:d384:b0:255:54ce:c3a9 with SMTP id
 q4-20020a17090ad38400b0025554cec3a9mr7974915pju.24.1684853119881; 
 Tue, 23 May 2023 07:45:19 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a17090ad90e00b00247601ce2aesm7609404pjv.20.2023.05.23.07.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 07:45:19 -0700 (PDT)
Message-ID: <959c1456-0a4c-6fc4-b878-e856fbf52927@linaro.org>
Date: Tue, 23 May 2023 07:45:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hw/ppc/openpic: Do not open-code ROUND_UP() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-trivial@nongnu.org
References: <20230523061546.49031-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523061546.49031-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/22/23 23:15, Philippe Mathieu-Daudé wrote:
> While reviewing, the ROUND_UP() macro is easier to figure out.
> Besides, the comment confirms we want to round up here.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/ppc/openpic.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

