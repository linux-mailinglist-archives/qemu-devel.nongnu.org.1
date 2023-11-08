Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF627E5328
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:14:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0faB-0000bx-15; Wed, 08 Nov 2023 05:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fa7-0000ad-Mo
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:14:44 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fa6-0005Lo-50
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:14:43 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5446c9f3a77so6592371a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699438480; x=1700043280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nXu5JbxuCc43Id12FbPQve/1ULkK4fdNAbZOIBym3oc=;
 b=KxH2hSl7s3iLrs5/yHWtkrNSRQalEGw2O9lDIHC3UIn7xVDFcG+WZ4GbD7nDx0fxfW
 4PsZCwqdJr+SALhpNxZ7JfkizD+O7eEnuvSwnbhH+3NwjTk+JbA/ib00PtFZYZb9XWA1
 E2qvuizV1a7OpCFNSMQHRWt03oOUAlqMvzYtXxadnsc/hE+mSdngP6hQc21JAf/CaA2b
 Z7LA0aLe2cAjJvjw0ySk0Tyw5ONmFKV/p2xrG9uR04xpQsG62fIK8IG+jbnxZkF0cyR8
 FqmeAgK2JOT/K/3yS/FMsEFf5SWcd2FhdLHCyszqvtVwkv4tskLX9CUH0PoDQVwAnzJV
 kLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699438480; x=1700043280;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nXu5JbxuCc43Id12FbPQve/1ULkK4fdNAbZOIBym3oc=;
 b=sgeBgkL6yJA/WBLA5ZvWjtr1vAjIEu4D+ACoJusXI1kRdCtoH/edxuY93zpWt4bz2f
 13sGvTuLq9ZBophfj1YiGMPqMgAlMUrB9W5dWOpGkWMksQzDe9YR+PrKzExxJCICNvdD
 pFse2g/a9lVGHJQYEjhsZ+WRew8p+tX27f20/tYMqtPGGzefQPPHV4NRH3UGi0jC6hEa
 J6UA3mxkg8DhB2oObXuAmCuKF/ZTPrwrZ34+f+QupKTMvRcUTsrGcloNjaFItgA4UJsX
 So0FrHAv4Va1HtQc2byfY7Kix/aDw/QBmDjoKk6K1EONI7hT5yE04zphO4JBNwVvJh02
 PGtg==
X-Gm-Message-State: AOJu0YyCtEzLScovy/9Phl344lAfykvxeZ9s3DSNPnI/cVl7HndTwbRE
 iotaTH3s23TFKzJHnhEBEkoz4g==
X-Google-Smtp-Source: AGHT+IHh0y9/YSc2NARpFyHb7MgtvLEtQta3Xoj56zoIFxNjk9hb5SdtEn57Whv+WNGBYN2lzCJZNA==
X-Received: by 2002:a17:907:6d07:b0:9be:6ccb:6a8f with SMTP id
 sa7-20020a1709076d0700b009be6ccb6a8fmr932441ejc.48.1699438480717; 
 Wed, 08 Nov 2023 02:14:40 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a1709062e8e00b00997cce73cc7sm794992eji.29.2023.11.08.02.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:14:40 -0800 (PST)
Message-ID: <88a3fd18-c756-47c8-99b8-bac30d3e1775@linaro.org>
Date: Wed, 8 Nov 2023 11:14:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 49/71] hw/rtc: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-50-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-50-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 6/11/23 07:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/rtc/allwinner-rtc.c   | 2 +-
>   hw/rtc/aspeed_rtc.c      | 2 +-
>   hw/rtc/ds1338.c          | 2 +-
>   hw/rtc/exynos4210_rtc.c  | 2 +-
>   hw/rtc/goldfish_rtc.c    | 2 +-
>   hw/rtc/ls7a_rtc.c        | 2 +-
>   hw/rtc/m48t59.c          | 2 +-
>   hw/rtc/mc146818rtc.c     | 6 +++---
>   hw/rtc/pl031.c           | 6 +++---
>   hw/rtc/twl92230.c        | 4 ++--
>   hw/rtc/xlnx-zynqmp-rtc.c | 2 +-
>   11 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


