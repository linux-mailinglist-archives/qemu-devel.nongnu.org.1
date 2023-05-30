Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B17716F65
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:08:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46a4-0002bq-AO; Tue, 30 May 2023 17:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46a1-0002aq-O1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:08:33 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46a0-0002uY-5T
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:08:33 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30ae5f2ac94so3426739f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685480911; x=1688072911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xzpt2JoNzbBRZAfqloD+27PM6WNp4n8/tTtcFNqTIxs=;
 b=ZwtjiiEHDCUdHwxSJN/1ns51tAJOj+dgyGaQo2a6VX+B4xUfxFv15jVAn0lsvr5Oaz
 0s1EpNz47R4IpJ1DdzRD9Shiu29TCO2XUntaegkU5bGLQgLHl5MkEv/leA5HS9gdZWGD
 0K6LQt5tz4U7us/ZFVgTMVQOF0pfhBDmWuPiz0EAUI7OOQIObGpLEwh2o6RJju6EVImr
 yDBfDK51R5lOUWcRYEyLCeQu9HJVXXj2Ad9iSF78Oxp3fIArOQ5RUw3dBrJIdV7Gtz0s
 hcQCY5lN09c7lJGuLP+3fsI7/mf0gV3XP0NcOW9iOLV5lqRNilVKUh3KovA5Bx8Bo/G5
 gpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685480911; x=1688072911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzpt2JoNzbBRZAfqloD+27PM6WNp4n8/tTtcFNqTIxs=;
 b=FeNdX02q+HJQ9L8Q91AirJWwxZKVe2hdR66QMP9cyaw7BGqiIQYvGKhWH4xR2EVeJi
 S2JpsiJDzgddCaVfFtnf+Q+ZDgkKvVpzHSkJH6aSvHUzRHf2wsA4H8Ht3qbeYVHCwlf0
 RUulKN57zcOUI7Ux0HdjFm1sxIppt0dPvoj4kq4Ltj/lz/pXGOVZVTxGCdnH1dwyt2w6
 a5XrizXu+/apbcdO4imABk/YvgE5SIIau7iuHvZoSTobzhLQGTAqauuyqSktTFjEfxo2
 2Uw5zPs9VK4qXDO1ep5FRGpfB7LB6HAwQ4r5MWQ4t2WPaJtj/HsjlGI0m3kHBOUnZ245
 /+Rg==
X-Gm-Message-State: AC+VfDyeSO9GsE2q6LCbp6XmHalrDN7Do7v1EQAugOdIVS5siPC2yZO2
 ZcsLCHuEFhrROvdniDzEthlrUw==
X-Google-Smtp-Source: ACHHUZ4MMX9QonJMlk/h21rnqni/5D4hFb1YXga5hIRXQFoQ7DqvkwWFpGqukOzXXYuoKOr0NnfPKg==
X-Received: by 2002:a05:6000:1370:b0:30a:e435:63a6 with SMTP id
 q16-20020a056000137000b0030ae43563a6mr2562663wrz.4.1685480910830; 
 Tue, 30 May 2023 14:08:30 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 i16-20020a05600011d000b0030aefa3a957sm4468147wrx.28.2023.05.30.14.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 14:08:30 -0700 (PDT)
Message-ID: <70e16f10-0172-cc9d-716f-eb09539cec39@linaro.org>
Date: Tue, 30 May 2023 23:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 10/12] aspeed: Get the BlockBackend of FMC0 from the flash
 device
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-11-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230508075859.3326566-11-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 8/5/23 09:58, Cédric Le Goater wrote:
> and get rid of an unnecessary drive_get(IF_MTD) call.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/arm/aspeed.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



