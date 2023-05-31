Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA82718204
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:35:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Lyu-0000uP-Nc; Wed, 31 May 2023 09:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Lyn-0000tJ-Ea
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:35:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Lyl-0006sP-RZ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:35:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6e13940daso61251935e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685540105; x=1688132105;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7fsE+s1QvSKRaWJKHEjuiQTJpZdRk9037UWBaDOidkA=;
 b=UjNMI+JhFWSMMSbBKZ1ZB5sN6a21m94I5qhRm24MB0rftfwuMUZbCG95WgAbwQGXpl
 aAamyBkUnZlhm/4yekMFpHb54q+utM7cZk2OLdWnGPYsPhptFBK0i//c3PB1KAR1YT4T
 6ynA8BMRjosLUMULWnaoSfegp0hgQ17tR9Tp+L29L2W++V/VkeTmM8/kW4t7PcwD4ud/
 CpAo/4XNSvv5SHDbOujpXO90uRCDtp1xfwo0xLNvryrhvMGqcaSoYNnYY2b9C2H9lWAT
 hZD0tpMuDMZ+TAcgxDLPfBLjJ70oAI4ZuoFRfmLBtyEH/nped/z+dHGSbtWpkYvJRMZX
 NAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540105; x=1688132105;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7fsE+s1QvSKRaWJKHEjuiQTJpZdRk9037UWBaDOidkA=;
 b=K+Mj/9YHAuCN2kTr6zLywT7KHUXN3kNEAIsTbAu8PcsYLY96HcApobfwJPyAAMzfd2
 ldMbD2be41eB21sI9Sii0auMJSbU8nt87iQK5w2UIpcNIDIEl7pyQW81PrOkGaz0k4Ml
 0JllXR6qLCCmAtL97uYToTMcgiJ09modNQQ7NFUrdGhCpIvIG+WlCS3hoVwx8abNlYLI
 rL3dAybypJ23VIfdVfiL1q1Qki8J0F1xIr9a1tGh0+wAP9+Ct5oa85FY62yFtXn/9neU
 bqvULZg8IKJhO9U4LAc50LFGQpU4BsnyQ79d6Clf9eX121Egaj2AmsDCXSwKwfTUUexF
 ryxA==
X-Gm-Message-State: AC+VfDxYoWoXqgOUGXJKW46ZNXbvUymyweJEywEcqOBkkX8qfqhIUE86
 74SwdQaCjH0MzVqUCY8Ry4W+mi3XDtdy/XpMZWk=
X-Google-Smtp-Source: ACHHUZ7kzaQbgRsLosPgqHzYn7r/KLiDcss6VLiKbhAbflDj7xk6nx8PXHpP6aAl8lRYnFgbgG61cQ==
X-Received: by 2002:a1c:7905:0:b0:3f6:eff:279a with SMTP id
 l5-20020a1c7905000000b003f60eff279amr4613376wme.9.1685540104841; 
 Wed, 31 May 2023 06:35:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a7bcbda000000b003f60482024fsm20929093wmi.30.2023.05.31.06.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:35:04 -0700 (PDT)
Message-ID: <b97a8ebf-f73a-5bb3-6aba-bec77805f9df@linaro.org>
Date: Wed, 31 May 2023 15:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 02/23] q800: add missing space after parent object in
 GLUEState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> This brings GLUEState in line with our current QOM guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



