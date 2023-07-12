Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F2775052E
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 12:53:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJXT2-0004V4-K5; Wed, 12 Jul 2023 06:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJXT0-0004Un-QZ
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 06:53:06 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJXSy-0001IC-Dk
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 06:53:06 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51d95aed33aso8265967a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 03:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689159182; x=1691751182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IPrsB1cjDmxELL3Zsliu6sUQYWBBz6iBkC3Z5Q1d4yE=;
 b=wElixkBDDA+xlevW52nyqEhrlxkdzOCJK5DVB+26WcsT7qNJ9cFRLpX/fKDs1cfQuv
 PDC28KrAZiyQSNQiF9a/iKJmSmLLkuKG0zQU4c8AleVO63tWxaTfKsXk/sfrKfdmZjr+
 pKkcO0GNa0CkBk0lQiut/mukpinPGQ1obL5l0p3Me02PPywu651ZXKS6WXvDu098B4Kg
 vcr4omdy1ntBjhsUCxGAge+nvm1ip1IgMF9javaYyTfJGwrl2odY2OwT/wzyPTMEt19X
 U2Up7rrW4t61t8VoHqtIv/mId6/IX3s5DdAhc+/dVDnVFQNbU0h7Y6zdHPkvwg5coA9s
 HJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689159182; x=1691751182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IPrsB1cjDmxELL3Zsliu6sUQYWBBz6iBkC3Z5Q1d4yE=;
 b=Fhv64dItLSIAfEfHObrx37zp72Kt11RKgyt0WM5xtg6ebxF63klH0F/5J3WPg4WA84
 R2xaxeI/vsmvVivEn32mOtw1irnONewA84BQnaNhf7kCY+o0+lIXo7yp3fkkFe/x8FfQ
 +GRS34qeZZD/yohrAah9BkyEJZWvlJ4qZ8WJUYxwDMMNh0Kvd4sngGblxcZRdc/KNy6l
 PZ+l60x6Ii5ay/Vo6hh/YXOcbGb9kVRmyeET/50aN1iJnr/yhMNQbkk1tc4atqzduvQN
 WaQ+2a/wG4+ql0G4Xtj6fDzcZLrpazlPcE8N7pAvpNp4eETkQcpm5NO14mzbw+No5CbG
 Bqjw==
X-Gm-Message-State: ABy/qLaEUj0I7X5/ZIMTf77xOHboYm71ugU3+0v12EGvXKlmceltrZWR
 RJn0xKIhZH6tt7xxgXf+jyU9Ng==
X-Google-Smtp-Source: APBJJlFmx0AXGTX+6cIGDwmBCx4zpBC73acSj7eWXj6Dv2sg9S2UzPhvMsT9jiWFpau0OYHN+y2PJg==
X-Received: by 2002:aa7:d68d:0:b0:51d:9ddf:f0f3 with SMTP id
 d13-20020aa7d68d000000b0051d9ddff0f3mr15635962edr.31.1689159182644; 
 Wed, 12 Jul 2023 03:53:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.150.242])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a056402069400b0051da8fd7570sm2565445edy.41.2023.07.12.03.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 03:53:02 -0700 (PDT)
Message-ID: <62d2e306-c5a7-a639-22a9-3ed664b2fa0a@linaro.org>
Date: Wed, 12 Jul 2023 12:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3] hw/ide/piix: properly initialize the BMIBA register
Content-Language: en-US
To: Olaf Hering <olaf@aepfle.de>, Bernhard Beschow <shentey@gmail.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
References: <20230712074721.14728-1-olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230712074721.14728-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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

On 12/7/23 09:47, Olaf Hering wrote:
> According to the 82371FB documentation (82371FB.pdf, 2.3.9. BMIBA-BUS
> MASTER INTERFACE BASE ADDRESS REGISTER, April 1997), the register is
> 32bit wide. To properly reset it to default values, all 32bit need to be
> cleared. Bit #0 "Resource Type Indicator (RTE)" needs to be enabled.
> 
> The initial change wrote just the lower 8 bit, leaving parts of the "Bus
> Master Interface Base Address" address at bit 15:4 unchanged.
> 
> Fixes: e6a71ae327 ("Add support for 82371FB (Step A1) and Improved support for 82371SB (Function 1)")
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/ide/piix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I can take this patch via mips-fixes.


