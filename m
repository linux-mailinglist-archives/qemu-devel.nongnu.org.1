Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C62E7CC0B6
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 12:31:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qshM7-0004m2-66; Tue, 17 Oct 2023 06:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qshLw-0004fD-Fk
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 06:31:12 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qshLu-0004IY-Uj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 06:31:08 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9c53e8b7cf4so203665366b.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 03:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697538665; x=1698143465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i2dhat74iqNUKm4rIH3tes5U3TEsVZrO75vocFdP3eo=;
 b=dDB6c9pOrQV3o+kVRnVLgPItWZQC4l1A0oVIx3fqiPdUWE7vqsdXW85v/uyforyqXp
 vy13s8Z7eYe/4Zr5m15UapCA5Fi2nhQvtmdLsEN5opKluvtezB+RT4dNS1IkpOBYV72j
 zVBKzMtGrxdDuiZi6ucYXugzmTaghaaGZJY34CZfozgrdN3XZUCut1n3bsXIqX7y6vRk
 EjVWhj9GjsJ8k+FGEXTCILtuVsZr/SmagdK6HXGvBK/dCE34Oad86NWWazcFdsNrCpMA
 pC5mSxyeSH9yZFQo1+QUV8EWH5ItQtQpwF6pbPBN97peFcREgpnX6FAd5+7DOr5gozJc
 wPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697538665; x=1698143465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i2dhat74iqNUKm4rIH3tes5U3TEsVZrO75vocFdP3eo=;
 b=SdMRM8jy1ZKoq6/gWDtvxJdS1PCllLQf9w77YZ40uefjAFbWxmNnxE2mr6yhzMm0op
 KZa3+n9llsS1U2YvneN7sIeacG7rK65zBGzE3uin/H4uf0kethpI21jW+YS0eLpld+2L
 BiGy+9SQA2gx8gY1kUwow0O+ddLU0ET2zKCfMiS7aBbA6c4u7rikw+2AUbX9D8SuTxcw
 fMjeS1UZ5D9PhkUyOXY+ZcMHK05dSMycUqN0xPeUPp93CTsMWByEa9JyVsoenfwTtd0a
 QLz2OBgRlEcO2IP90Lj9I+KP7U9WwcZQI/8Fn5g8BHafhOTOHAIWSHLazxz6D0IS28MV
 hGIQ==
X-Gm-Message-State: AOJu0YwJI6XaO6QwhXJp1lvIFiBBKmEQSy/2F29cwpBGNPMmDUlAWOg4
 wWDrV2khdzDMVAt2JLiMh3nZ/g==
X-Google-Smtp-Source: AGHT+IFt3KBG+4CmqI4xQ2Ox+C9aHAD2nKrr8r9NhUmy0grfj2r2weGqbAS1PjYnhHIR5Kf5YQvPWg==
X-Received: by 2002:a17:907:78b:b0:9be:7de2:927c with SMTP id
 xd11-20020a170907078b00b009be7de2927cmr1228155ejb.70.1697538664810; 
 Tue, 17 Oct 2023 03:31:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a170906241300b009928b4e3b9fsm987262eja.114.2023.10.17.03.31.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 03:31:04 -0700 (PDT)
Message-ID: <a9501570-4cb7-43a3-ff63-003c086b1c41@linaro.org>
Date: Tue, 17 Oct 2023 12:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v3 40/78] hw/sd/sdhci.c: add fallthrough pseudo-keyword
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:SD (Secure Card)" <qemu-block@nongnu.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <5e159bb9fdedd630c2cab239d471f0ceb678736f.1697186560.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <5e159bb9fdedd630c2cab239d471f0ceb678736f.1697186560.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/10/23 10:46, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/sd/sdhci.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


