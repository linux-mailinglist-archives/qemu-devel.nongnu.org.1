Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1612574AEC6
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:35:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHin7-0008Ae-UT; Fri, 07 Jul 2023 06:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHin5-0008AB-Ew
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:34:19 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHin3-0003rI-BC
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:34:19 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51d805cb33aso2324518a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688726056; x=1691318056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ljUEZq8cO1V8M5ZZyRSIA5C6lEPedJXsQSnierisscw=;
 b=uSVbI7gu5qz/qQhWfnJxIjkLzRiLdWYCr9FvXOXt1I2XPKzYGcqI1GeB/EduE3uIzb
 8J5wA1ZVUPD33vgra7SYFDvCFrR4Z1t7ZIA5+48SLNqDyCtUeqkqi2dEluHpdnxaxCZG
 GcRBsSAEEMMFqTD3C36eAoa+dGGkQBpyGxAsGYGRKmo4+kFnn9TwUCAsBM1l//rP2oBv
 Au7Z5JpZj8jw9R7sQztWfdOEqpipRx/2A1eXlwGp3qHEf5pskNOEZPW0fa862N5MmsxN
 OpFXW91O8gIw1BkgU2sFqAJDlpcX6+7Kkkpv1fmOl0KJBNvBgoG7z6RbbxiHILdfLfQ+
 iCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688726056; x=1691318056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ljUEZq8cO1V8M5ZZyRSIA5C6lEPedJXsQSnierisscw=;
 b=A9j5WOG7fbubtJKKYLr0OnnzPIlyVNZhJnTZkJaAxAq8RbWwkyZCf4vG6A3jjM+XMC
 MhDuUV0cXfYgbNgsAaY2A8GGHC7/cyNRncFO2aWFuBfYPMQP3+bMJKzAMCTur6zAwbrg
 Fe/ZjFat1EpMWAFzK+i+g2mXbfA69hlyfJgpuejGzQWDpmveVwz3WH5y4jsks3G79T7J
 1VPjiVmwGDazPtmI7vgj527f/dGhVvaFaeLMjXGenamSMo+5+F1mkEI9Xr/zghcge8GZ
 wDTSgPqbqtFAx9whiZ/67yEO8obWoCWz2gjO2j6QmyjY21PnP/8A192KkWPHrwbP6504
 sd3A==
X-Gm-Message-State: ABy/qLbQtXYFHm5V+94yo0xjTWSu8A8XTu82EfpILZPgYUR+poWvPZuf
 TmmVW+sVHOFIkmuDUHPGrgf2pA==
X-Google-Smtp-Source: APBJJlGn/9ZVtNiYwpWcRBCK3L9oiICkOJ53zVM/8tMPKtsE5/PwstUDATeGbbUHI38mcbWEuG5ReA==
X-Received: by 2002:a05:6402:184e:b0:514:9929:1b01 with SMTP id
 v14-20020a056402184e00b0051499291b01mr3373533edy.8.1688726055784; 
 Fri, 07 Jul 2023 03:34:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020a05640231e700b0051bfb7de166sm1892969edb.39.2023.07.07.03.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 03:34:15 -0700 (PDT)
Message-ID: <7c8cff75-158a-cbb6-bd0a-da5effe03577@linaro.org>
Date: Fri, 7 Jul 2023 12:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/4] QGA VSS: Replace 'fprintf(stderr' with PRINT_DEBUG
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
References: <20230707092258.768420-1-kkostiuk@redhat.com>
 <20230707092258.768420-3-kkostiuk@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230707092258.768420-3-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/7/23 11:22, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>   qga/vss-win32/install.cpp   | 12 ++++++------
>   qga/vss-win32/requester.cpp |  9 +++++----
>   2 files changed, 11 insertions(+), 10 deletions(-)


> @@ -304,9 +305,8 @@ STDAPI COMRegister(void)
>       }
>       strcpy(tlbPath, dllPath);
>       strcpy(tlbPath+n-3, "tlb");
> -    fprintf(stderr, "Registering " QGA_PROVIDER_NAME ":\n");
> -    fprintf(stderr, "  %s\n", dllPath);
> -    fprintf(stderr, "  %s\n", tlbPath);
> +    qga_debug("Registering " QGA_PROVIDER_NAME ": %s %s",
> +              dllPath, tlbPath);

Previous has 3 "\n", not necessary? Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       if (!PathFileExists(tlbPath)) {
>           hr = HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND);
>           errmsg(hr, "Failed to lookup tlb");



