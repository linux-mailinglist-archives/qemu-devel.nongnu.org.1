Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C407A74ACAC
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHggS-0005Ds-F4; Fri, 07 Jul 2023 04:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHggQ-0005DV-No
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:19:18 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHggP-0001LJ-9B
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:19:18 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-992b66e5affso197408166b.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688717956; x=1691309956;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DxR3ocZExgWQsB9UsI4L1s6pJLRl0yzuPpAtDcheIHQ=;
 b=SHOzlma+kPxXTjZwggRWN2bpVJdXyq1uL/hNJ2tl1vtHWO+2jPJMENa8CAMjJSqpCF
 naVV0Ynf19b9xOYio98oVjjcLFWhjsS4B9ig/tg3k4+gGTkMJJOWLzq/f9EpwtqawMsq
 yTSnLVZ8jhERy+S/fQmk+frlRR7Gs8DCxQh9al5v4HSu4RoJucqL5+FCoNr53mQRuQCM
 SoIUU6TJYOOoh7o3swigJklxzGCySIebDcb7pe/aTnP1F88quie8ZflqdjHCz9Lb1BUb
 TP7Gano0Ui6hP3CBVzYlVS9vkgI/oCdo6Ze9Y+yJxEpDzxCuoYnGWIPPGk2sh/gSZYLA
 hjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688717956; x=1691309956;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DxR3ocZExgWQsB9UsI4L1s6pJLRl0yzuPpAtDcheIHQ=;
 b=alSFP4DF/ygzg2j7MIIkLKC3B4jhw7ODJ0jteMGytOGHVs1YGSl+9346QS6BaF0emP
 RAEfwgTxY+ASJqpxLgaCkh2xZ65XwiaIUhFILPBGi6FddzXhz9oF8wr44AenzdjjSRqL
 Oqe37v3bxs4jeXL2no3pLy/WLRMAsuR5xTRkKjonl0EhAxveyzzLsMioTP0krh6w/jNg
 Xt448q9fF8riRHHvd1Kqq9WU3/GNc+j+LN9c/8oAxU3mUwils86LYmse+ocCtgY3Aauq
 SvwXIHG/UP8N/NrONJHzw2ctvbI1d16DHNLPNtw/tlzgaWShtMB5lnPSdAyepOt8SV7t
 ntCg==
X-Gm-Message-State: ABy/qLaBgIMtBrgDdrxVlzrQzKyyD7gQUV0seQjGAFkE0csM5wm0gt7c
 sCB9QUBqILv9WxNyck9H8SWf4B1D5bV5uDjrSOQ=
X-Google-Smtp-Source: APBJJlEGb6e1qRo62BXK7XOm7wH3cjJF4ZSWbwD8HcozQ5kWhXVuKVqtlhQz9bnpZXoXPVv1QzX0GQ==
X-Received: by 2002:a17:906:3796:b0:991:b6f5:5f96 with SMTP id
 n22-20020a170906379600b00991b6f55f96mr3220594ejc.60.1688717955759; 
 Fri, 07 Jul 2023 01:19:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a17090622d100b009934855d8f1sm1834725eja.34.2023.07.07.01.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:19:15 -0700 (PDT)
Message-ID: <cc555375-e2e6-13f1-511e-b562ec297e96@linaro.org>
Date: Fri, 7 Jul 2023 10:19:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 04/21] q800: implement additional machine id bits on VIA1
 port A
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230702154838.722809-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 2/7/23 17:48, Mark Cave-Ayland wrote:
> Co-developed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/misc/mac_via.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


