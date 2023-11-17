Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B66927EECF8
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:49:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3taQ-0001yD-AA; Fri, 17 Nov 2023 02:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3taJ-0001xf-NS
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:48:16 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3taI-0005M8-6C
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:48:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so13043905e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 23:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700207292; x=1700812092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zBlMHG3ywmvFR+96PPU7cIV1iI9nRgIosmh4DYTF9Yc=;
 b=ISIoT6FfzukLBQ+cDpuGGpJ3H5wx3GfmEq22/DdIYMc4TljClIB7Kpi80dcoMK8gzP
 5F3CRVerdE4As8zrg6pOXriyOuZVCT4OzxX7zxORfvPsjH5iWzAAuyOWQM9tYmwFXHz/
 YEun5rIntdPdB0KMZi2AQKA+lvZsTYNb9tSv1t432tyBid4HBheALlOMq53fVWjSjjWt
 g44HUqArSZ9DIWud9JTLaMINNqjmTmLPiAbFFyi5HOaf8DNTjyc1lO3dIrxrFKOkcOH7
 F9Yyj/z4Xxwzytv4FMLdvyHJzq7vt6pTfmSHmdH396WKRdIEkLcR+g2Si35OEREdR5y4
 8wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700207292; x=1700812092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zBlMHG3ywmvFR+96PPU7cIV1iI9nRgIosmh4DYTF9Yc=;
 b=tmGELRHuXF6LQTbsjPsQyv0eKBVOE8YLTYnAuZ+25W7zC0mW0d5mseGHprMv95Ieo2
 jcPnuEdrw2rF9LGEBLbQ07CXIUs/gOXabi4/qkL99n9Mn3Zs5MUNxflTpi/0/sqhRagz
 Smxnb7GAJWsHAqxqFxrtNL2ak1h9nn1kc/A7YsXP+n72HxapFygMWSD7cPvyt4tcIeql
 kxBovQUsOdmzlHkON0zs257Wnki0jNi83mm2iKqCiU7/dhiWQKU6/u/vqdIQNj9F4yKQ
 xSv3fCYNweRARj+Bcxxhcbk0eXtWbTekB6SUghHIdhDKcS1rgfgKAzcA5ZFByQfwv37o
 5WjQ==
X-Gm-Message-State: AOJu0YxD4ctepmlXYnapgKtYx8BcoACz4u/oxWukE9uKy4pHOCvenjr5
 ZmgrCaTsq6IADu6RX4cREjMcxw==
X-Google-Smtp-Source: AGHT+IGh1ftMspLiqDA00LswWqW0IOiGZfSi+D8KvcB4sYLkq3a4eZvYtkfFQMOhuxRthtvz9O521w==
X-Received: by 2002:a5d:47ca:0:b0:32d:82d8:3442 with SMTP id
 o10-20020a5d47ca000000b0032d82d83442mr18752460wrc.53.1700207292042; 
 Thu, 16 Nov 2023 23:48:12 -0800 (PST)
Received: from [192.168.69.100] (bd137-h02-176-184-46-187.dsl.sta.abo.bbox.fr.
 [176.184.46.187]) by smtp.gmail.com with ESMTPSA id
 dd11-20020a0560001e8b00b0032db8f7f378sm1479284wrb.71.2023.11.16.23.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 23:48:11 -0800 (PST)
Message-ID: <f0eaeeda-49bb-4dd1-810f-a68e3ebb57c1@linaro.org>
Date: Fri, 17 Nov 2023 08:48:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/35] tcg/loongarch64: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 56 ++++++++++++++++++++++----------
>   1 file changed, 38 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


