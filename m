Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 983A173D030
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 12:53:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDNMF-0008Dj-4G; Sun, 25 Jun 2023 06:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDNMD-0008DN-3c
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:52:37 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDNMB-0005TA-CD
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:52:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-312863a983fso2633763f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 03:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687690353; x=1690282353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2MiyG8szExBCUndDEUWIU/frrOrXQHhamVMXlUqD/vY=;
 b=kvu6OhaX+DOiJjIN1QuGHGsfCkO3tPmaiy7JmtTQ63WJpo+hgxX63fmvg47ScYGiRk
 iNVt8HChuRyocN1cMhDVP8e2/cefMA5UyO4cfps2J3G/nMiFs0peLWTDm0zHswtACnlS
 NtFp0a8SmXFaK4ZplWyNgyCrH3vDcjfPPnBxDmrdes1DtZrzePDdKzRE/7r8x/ux6vMF
 WznLFaOp4R34uPwrA8E0eolria0E1ed+RwLz1llUFk+42OgTncMjGjSQv5oZ4/4n9DVM
 9U9WA6zskM1dvGx1pnh+9Uda9DEEx5K7cZnDM17+atwzRRbmrhIsGOSQOokQ6PPNCFKa
 9TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687690353; x=1690282353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2MiyG8szExBCUndDEUWIU/frrOrXQHhamVMXlUqD/vY=;
 b=YKYmAVYx6ljd8aUW4w/ArANPhJdrdNjFpn5Aq/FbcqQnniC6TMlo7+88q/5pgFyV/o
 8HEAK9i8c3PFjrwBTOnxI2N7XhfShdkXzOh3GkpgsEygpRWNNRbASTRIya3S44MJcKeS
 UkoAQkmineG3Us5Hv/+dRal7k6BfrXGlbupwpZHZMR8TDK+3yJCunc5ylmcRQORmVJ0C
 2NPPB/jJ0y45zYz876UUqS4aO1h2WtoX7jjrQr0X6fCfGxICdI0N9ifvPPoNl6IFT/ad
 vqow3U6xnTeWxyz9rtVHRDmCfdB4VEtJ7agNGbtyPK5GbZitHuWTf79Kxq2zgsIF7oRg
 PiXQ==
X-Gm-Message-State: AC+VfDwEeQb8hHZ+yyI2X8RQM3DC4iWZXGnFw08pU4XAbkUJPRBeI1Vo
 K5xKvWY9CjKEWKFGG5NjP/DDUQ==
X-Google-Smtp-Source: ACHHUZ5xXeflfyFrobCthZwRR0d6Xl9MsGUZOyEdjFap9+SPQJ3KAjjULz0ymjzt2tQtZhhmBta0BA==
X-Received: by 2002:a5d:4d0f:0:b0:30f:c142:5330 with SMTP id
 z15-20020a5d4d0f000000b0030fc1425330mr20443510wrt.27.1687690353314; 
 Sun, 25 Jun 2023 03:52:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
 by smtp.gmail.com with ESMTPSA id
 g12-20020adffc8c000000b00313eda9a185sm1197528wrr.87.2023.06.25.03.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 03:52:32 -0700 (PDT)
Message-ID: <00cae1a7-ea6b-343e-c3e4-6458132236ca@linaro.org>
Date: Sun, 25 Jun 2023 12:52:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] contrib/gitdm: add domain-map for Cestc
To: luzhipeng <luzhipeng@cestc.cn>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230625094136.738-1-luzhipeng@cestc.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230625094136.738-1-luzhipeng@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 25/6/23 11:41, luzhipeng wrote:
> From: Zhipeng Lu <luzhipeng@cestc.cn>
> 
> Signed-off-by: Zhipeng Lu <luzhipeng@cestc.cn>
> ---
>   contrib/gitdm/domain-map | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 3727918641..2f9dd66ef8 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -43,3 +43,4 @@ windriver.com   Wind River
>   xilinx.com      Xilinx
>   yadro.com       YADRO
>   yandex-team.ru  Yandex
> +cestc.cn        Cestc

Please keep alphabetically sorted, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

