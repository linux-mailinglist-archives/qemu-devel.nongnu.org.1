Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E77B3BF8
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:29:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmL2d-000503-H7; Fri, 29 Sep 2023 17:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmL2a-0004zn-TM
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:28:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmL2V-0007IB-Ff
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:28:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso113261485ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696022925; x=1696627725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+baPzrIKLFTfVQpY3QY5gdIt65jXL+vrRCbVSNITLnw=;
 b=Jl/aLcfZAn36zS2++MaMkwDl823u5s87Rjf+92Kw+yybwLH1J5VyBbpEJkvwbB0rzR
 FFxXUKcQNzVWX6pZqPwcTEOJWkt/qY29cujooAQbmARaPmyhEWbn0PorOD4pxbQuxIg2
 PWbIOFqt0oMOFgpy2bXymwzQh5AYbJJE/QwQy5F03TITDfnB1qFx1PPOByhC4kItFEjv
 YBsL3VWBeM+crcSSLnowlN8KjW7XVW9QbrF0DXRNw4H2tj4G7e7QBWSw8SQ6GnFSTnnK
 b4BKfsq5/I4pM1RB5P+tAf3DVKddCH2ISjO7TAhir+nIRt2Hj3p1K9meI8CLRnMl+wWi
 B7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696022925; x=1696627725;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+baPzrIKLFTfVQpY3QY5gdIt65jXL+vrRCbVSNITLnw=;
 b=OCzc4a4Md+yK/vi8mRaGumASGmczmywn42rGSN2fIEZqPHTNtyItAZKfmLUxNKxryI
 v0edrNNwM7SkzMZP7+CFIAzuKqGqVhyrvXIp323Tx7HQ8zWMuP0sgkSKTzFUyMgheKk9
 b5z2tOh0ARHwCLymbPj0tVVnWrMR1QQ/1xzYFVS6L6SCrtUHCTFqgHR/evk6Rq89La7k
 MsKa49ixJgtwlAxuBIUyBOs4Jd+x95gk5UHxV1pDnjExuugO99+7wvEP5rpucchOosKH
 dJnNaGnHFAXL4RvHnSpgGVyC4dIvWImWynO30J0cnK9Jk8s0PqoqZvBs5xseRcatdUPh
 3F0Q==
X-Gm-Message-State: AOJu0Yw4xv6aT0P2JZ9NE7170FXcejsaqToShADbUiNbbCRQCoRZl9v6
 UiIgdjiT6Eo/znzrT0sslbLyn5M0yLgd5X3gywU=
X-Google-Smtp-Source: AGHT+IFovFyo89qg7HQ6GYVJBog6TZ22Vqu80WWg6pjXbWMMvSdTI4gTqoIeCGcVA9bYj/ypSLS9Pw==
X-Received: by 2002:a17:902:ec8d:b0:1c6:1fc3:6857 with SMTP id
 x13-20020a170902ec8d00b001c61fc36857mr6508169plg.27.1696022925062; 
 Fri, 29 Sep 2023 14:28:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y24-20020a1709027c9800b001c3267ae31bsm17300706pll.301.2023.09.29.14.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:28:44 -0700 (PDT)
Message-ID: <4fcdb57e-7300-f60b-fa58-fc3cd056a953@linaro.org>
Date: Fri, 29 Sep 2023 14:28:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 21/22] exec/cpu: Have cpu_exec_realize() return a boolean
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-22-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()
> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 2 +-
>   cpu.c                 | 6 ++++--
>   2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

