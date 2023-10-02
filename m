Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9407B4B88
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:35:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCVI-000640-LT; Mon, 02 Oct 2023 02:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCV4-00063M-AO
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:33:52 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCUy-000082-Uc
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:33:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40651a72807so38419335e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696228423; x=1696833223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8hDakobXsRrM/sW77zaqH+fHkmrO5PVulxjFJfMJK0U=;
 b=QaLpX9m2hMt5nNuqjuEATnnwzA5OwJvbv+KDNFnmiuBqhs0NCXYfDQbakx6VYmDvCJ
 9nEswn/RzdSYcAfpH75VIv2jUUaAKG1j2t3QikFgDaCG8HDBLx9vMr2EsnILH6XKaWco
 3WrCE96S96c9hJxIvInJe9qThFTAeKzrnho2UM1ed15kGkvB3966/hjRzSKg1hgq4fHP
 wMpVH2xTGuz8ShIHRu59YFLhUcu0RqaGgF3OdfoZmxxdoBIXR4SLNj0InZcv8baPNeZs
 beyq5n3wX3w7hJ1pGy9sx5xUAj74u7W07gJGCH1DX6M4cSN3ZT6W0FDddaS7/Q0z4UP1
 8PGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696228423; x=1696833223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8hDakobXsRrM/sW77zaqH+fHkmrO5PVulxjFJfMJK0U=;
 b=ktQHHZoCORnW7GZZsMqmN/4vqzTx14rE8yr6lKJkMp8q2w/n9ZwO2iHoqx3P3no+EZ
 tvbm0vuC7FOy2q7nRARITiLJn/mOwptRifIFdZjTTHdnbZLL71U5VlMP+K1TUPGKAjfV
 6b2CcluvT28qHZR7+NCCkRzNYF6ad30w2+ED/EQSo/aeTfivNUD8ahi4Y4nopw9/OWOP
 X7bE/lfAvVhCKl3DhlD0ZaYvHpYcj8q1cmH3Ir8whPtXVtiCX/L45o3QzPTrThSJDx+I
 nCDRkwzAibHBdjD0cWVYI1ajQU0HPM1WiOkzc307BI9snmpxuYE2Gqpi74T0bmcuVnzm
 rX0g==
X-Gm-Message-State: AOJu0Yz2B3Ete8688/rzLLRRqkTyIB4B6cTIoCrRHQS1jVK9BTFiKRaG
 m1KVLHvwvwgkMYdjOG05SyRf3iSCdD+I0W2mxtQ=
X-Google-Smtp-Source: AGHT+IH0PCO4MvwIBfAavZsLq/BuD16Hq/qZI9rahaUWPuOSZU3BkFJwP+WAgAjmkEuNUFOTyztwRw==
X-Received: by 2002:a05:600c:ad3:b0:402:e68f:888c with SMTP id
 c19-20020a05600c0ad300b00402e68f888cmr9341053wmr.7.1696228423169; 
 Sun, 01 Oct 2023 23:33:43 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 f19-20020a7bc8d3000000b003fefaf299b6sm6556626wml.38.2023.10.01.23.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:33:42 -0700 (PDT)
Message-ID: <a72d2f45-a5d6-94c9-2cfb-ef685771d117@linaro.org>
Date: Mon, 2 Oct 2023 08:33:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] build: Remove --enable-gprof
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org
References: <20230930181841.245024-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930181841.245024-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-3.058, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/9/23 20:18, Richard Henderson wrote:
> This build option has been deprecated since 8.0.
> Remove all CONFIG_GPROF code that depends on that,
> including one errant check using TARGET_GPROF.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/about/deprecated.rst      | 14 --------------
>   meson.build                    | 12 ------------
>   bsd-user/bsd-proc.h            |  3 ---
>   bsd-user/signal.c              |  5 -----
>   linux-user/exit.c              |  6 ------
>   linux-user/signal.c            |  5 -----
>   meson_options.txt              |  3 ---
>   scripts/meson-buildoptions.sh  |  3 ---
>   tests/qemu-iotests/meson.build |  2 +-
>   9 files changed, 1 insertion(+), 52 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


