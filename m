Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 068D273699B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:42:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYoa-0001Na-1Z; Tue, 20 Jun 2023 06:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYoV-0001Eo-Sq
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:42:19 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYoU-0005By-5c
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:42:19 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-987a977f62aso365888866b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257736; x=1689849736;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A1pJGHU9zoumlPJFyM0mbjEpLH5IWpVhi/yjUMy1FGE=;
 b=ivA7yz9UdiQ9tp8y2CTQiBJOUsZ3XrZETblMG047k3TpAn+nmktqf76Ktf64Vns0wG
 JdqXrQ64X1VjSp3fSNW8kO53vWut7XeV5X8Barr+vR+0prUxVVKusq7zMA7Pm59jgiia
 Csnl3HPz9Vf2Cipjbai/fvIL+qaY+Kn1I6GdqBDKsAQhIwXbwrXZKoyJdY59oAINz6bF
 q6xSS9jqKBPn09WB86z7AnNtlipIXDzkvSDB9uC0Inyl0RmsNmT2P6Vvyk0I0dq5zoYQ
 4+BWeVIsQ4GNzNPCjhjUjqHo7gwdvGMs5RHj/x4KS29SGGHDscSIL1yMJat7v5dh2bF1
 Xp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257736; x=1689849736;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A1pJGHU9zoumlPJFyM0mbjEpLH5IWpVhi/yjUMy1FGE=;
 b=TYxNGMDaTyE+Z4/PQfpFlDsWY2QsaWGdSavaG/bR3HRntQqH2J6SC4Db9C3n4SZ9MM
 pWAvsYinquttmyLyHA16EMPrsQeb4cd8klgIYuuW3hG8CQIM7JKtwi3SvNtYiSPODLyo
 3nrVvRVpnN+RGqzEVQ0+JuzriM6OugvJZ+o2+fMINICeCscZmb/L2mwUo6vH/YkgLk0b
 1yLagMJyk3Q9RySIKBeZeSOv9dBV5m6f6KF9aNuxuEy4Wbb4tLF6RXxrQ1wHPucRxSdH
 kgVHFX+ugn5rpM3IKo71LWFXxOsD2Pmlo6d0EHHKENHOFWCvCuPlbGmv0nSygPgkf4wB
 P1+w==
X-Gm-Message-State: AC+VfDwCGYBXUMMTZb1G0VAPKc+JXO9/P4sm6YbyhCLlVVefHGtcV6Vm
 v97E/1EorMHx4THSuLFvqUa47Q==
X-Google-Smtp-Source: ACHHUZ7DsPT3TMh8g3b8vkBt05IS6xdMqzoOuJ/nkIoKMpABi0ceJLTDlzNcbrw2jtMKbz0GS+trHw==
X-Received: by 2002:a17:907:928b:b0:973:cc48:f19c with SMTP id
 bw11-20020a170907928b00b00973cc48f19cmr8370417ejc.56.1687257736372; 
 Tue, 20 Jun 2023 03:42:16 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 le15-20020a170907170f00b00985bdb7dd5fsm1122951ejc.201.2023.06.20.03.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:42:16 -0700 (PDT)
Message-ID: <199d31f2-94b3-4a2d-c23f-a82c94a75d10@linaro.org>
Date: Tue, 20 Jun 2023 12:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 29/34] target/arm/tcg: Extract M-profile definitions to
 'helper-m.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
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

On 6/19/23 17:55, Philippe Mathieu-Daudé wrote:
> helper.h is used by all units, but not all require the
> M-profile definitions. Move them to a new header; the next
> commit will remove it from the common helper.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h           | 17 ++---------------
>   target/arm/tcg/helper-m.h.inc | 23 +++++++++++++++++++++++
>   2 files changed, 25 insertions(+), 15 deletions(-)
>   create mode 100644 target/arm/tcg/helper-m.h.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

