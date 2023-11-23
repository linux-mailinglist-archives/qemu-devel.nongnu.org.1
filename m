Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C187F5E0E
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:42:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r685Q-0006tK-K2; Thu, 23 Nov 2023 06:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r685O-0006sm-3b
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:41:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r685M-0004Nv-1V
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:41:33 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3316bd84749so501094f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 03:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700739688; x=1701344488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a8jW+oRd2zCpfNpm0y1vOAWuOryPcBDO8kJRrv4hZFE=;
 b=FpEeb4BN75UUqFGcYzWS9nfNCtWh8MpCYviAmkTeqqU668BdjAeE7Fya3IefcqInyf
 gZhF4fotzaR7MhpcwOu9/ADNaUuMtfxxd9gy/HOuyQDcfrfqXuvZ9vJ3uVH3e1dhLzg6
 FqR6wR1OO/rffqpZbirPIYR0dwp/e4odwAoIxiWlRKkY1sS/JkH6DBRj0oJ1lGiWJq9a
 5oA7rylKPZF/f2PbcDy4QL4orJcp/3XSzKf3DtYsrbYOqeCVbIvj6G4RPsUYNAu8DURf
 eRPVc0+R9La9khCsSeXLrGpyaQq0ZXnKjnVan381THdZGMIBx2p0zsBpg9WYUB7qcvfh
 /DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700739688; x=1701344488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a8jW+oRd2zCpfNpm0y1vOAWuOryPcBDO8kJRrv4hZFE=;
 b=CiTz7cCVewh4ralkuqoK8+BzZggxvxv379g0mmQllN9burB2hLYKrgFZMXwSzmsMSZ
 8t1ZMfHtZDfODBJqnHgDB4FB3OcLfBR3PqsVrnglyqj30mPAukD2MwfGSWysoWcY/M0L
 8jxFTrSZusM4K0uObwBoyAul5TEqktqItCNJ7we4X0w0xwU7ff/oklgQEaebyCCitHn4
 aom2/esYVKuYBFqc0oOZV6uh1I//JcEw2qSXrdapJ2qsboUCjRT7VyQOf3y46R4o2U6g
 Ifd4y6o3BO7MS6ZmvY/50/v63pjWpyqPF1Qs/Do5KOcmNIJEk9QXP/1BSH9v0nuzHgE4
 izTw==
X-Gm-Message-State: AOJu0YyxMc9Q4ll9cbeJ6Tmh7cZJI0Qg/Nvq/BT2PxRdRoo62BgxfMsM
 pL8J0f++fCqlMl3xmzQ/E3JzFA==
X-Google-Smtp-Source: AGHT+IFp/+kjDzvd4McHnaHVGxgNMT8AIJXJoZMsVlVLRRqsXFDiuzyaV3JXpw8Ca6beW2SEXZFD3g==
X-Received: by 2002:adf:f082:0:b0:332:c4e3:9b09 with SMTP id
 n2-20020adff082000000b00332c4e39b09mr3261365wro.30.1700739688483; 
 Thu, 23 Nov 2023 03:41:28 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adfa4c4000000b0032d8eecf901sm1455905wrb.3.2023.11.23.03.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:41:28 -0800 (PST)
Message-ID: <fe710001-1f37-467d-8744-405ad0ed7fb4@linaro.org>
Date: Thu, 23 Nov 2023 12:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] target/arm/kvm: Inline kvm_arm_steal_time_supported
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 23/11/23 05:42, Richard Henderson wrote:
> This function is only used once, and is quite simple.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 13 -------------
>   target/arm/kvm64.c   |  7 +------
>   2 files changed, 1 insertion(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


