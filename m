Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB8D736903
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:19:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYRl-000538-Vo; Tue, 20 Jun 2023 06:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBYRj-000523-GL
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:18:47 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBYRi-00082B-1D
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:18:47 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9881b9d8cbdso537831266b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687256324; x=1689848324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1CGMxhJjntb4TH9CX2YiIRiz2pbuLDI+0qNAit9f6Is=;
 b=W8a5aMgaN62EDPq+amdCCDU4S+4R1JWDlrSnL4ddwsHbOnrRQNsPhyA19gysrIunY3
 IQgQ3lyVHdSc01FA3PZWtkNsdDRg+3kPTvIetVERKpBX0QhgKxKjANEs76QsrosGe7tx
 Bbgey6GZ3xeokQUYiMyVXPPcey0oU0YoWTJvx5434Se7Fo+yNi61MCxlADfoVyjLPiEk
 4ofHgQCgdoWZLC2XF1uFE8t4XFkiJKehEzSNdSMFd13NtRWBKEdUIYqd/7OkAC/l93Tc
 9V2rwMTetirdOspnLS3u5Gjpi++3M1T2bSSgJIO4+XO3OvpBMJWXOS0KvI3WaSnvW7Ys
 NXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687256324; x=1689848324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1CGMxhJjntb4TH9CX2YiIRiz2pbuLDI+0qNAit9f6Is=;
 b=Jy4M5jaaBv3Rd2A8Lec4qUUKViP1X5zq7dpuDSF9gyMH+Cq7155QOo9hWLDimHntEL
 SBLQOQZBb39yn/a+m1O92NhXV4HYTu6WU/d3UxriNNz2+p8RWZxe12nJ/z9qi3U14EOi
 NF6WHkdPu9I+6Ht/al/3RiW3giEviY3UDh04e5kXpkUY8da8yeNOjncBZzqJb37H0Kkh
 ydfTHXYulJmMocCuYpOODfqjAtPE3iwAu7kqj4GTQ/ldtkbA3SbwnQlrFWWUv5yHCIp/
 DBs6rnuZKKOOwy6Lhn09Q7IfOPbshK2kTv/MZGsT/maIqvNQN2dghk94anVFgm7zvUW9
 97iQ==
X-Gm-Message-State: AC+VfDzIHHpoc9KzWfDo+1hF0MtiPQRq6NIvHF6Zat43QnrVJyL4ZWbW
 sXEBUgwDCk/zotZ5j+9iQ0cPzw==
X-Google-Smtp-Source: ACHHUZ5P9b6hnWW2LKdz8QLEm/9R3G3HIYIM2djxFLAt7fWCevGqp4DvMZIlq/55BmFBPHurQIyQKg==
X-Received: by 2002:a17:907:968f:b0:988:b61e:4219 with SMTP id
 hd15-20020a170907968f00b00988b61e4219mr4566817ejc.29.1687256324407; 
 Tue, 20 Jun 2023 03:18:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a17090685ca00b0098873024c95sm1126997ejy.136.2023.06.20.03.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:18:44 -0700 (PDT)
Message-ID: <da71e852-5c81-b7c6-61e3-b8b8dbba64e6@linaro.org>
Date: Tue, 20 Jun 2023 12:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/9] MAINTAINERS: Add reviewer for PowerPC TCG CPUs
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-3-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230620055911.187065-3-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 20/6/23 07:59, Cédric Le Goater wrote:
> Nick has great knowledge of the PowerPC CPUs, software and hardware.
> Add him as a reviewer on CPU TCG modeling.
> 
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



