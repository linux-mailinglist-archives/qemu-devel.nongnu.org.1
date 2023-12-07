Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3367780951D
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 23:14:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBMc5-00013U-AQ; Thu, 07 Dec 2023 17:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBMc3-000134-4l
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 17:12:55 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBMbz-0005PG-81
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 17:12:54 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1fb33059466so857639fac.2
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 14:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701987170; x=1702591970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zuMK2+osl+g3rcJ34pnrTBegkSKiuBMFAEJDZTsdcsc=;
 b=GjBPkPpbjH0OTwU5oAtQ+YEmtxqp/vT7zf9GOBhX9IkKDjGc3vqY+2BZxlcIU5iN9g
 66Es0leQt3XMDeRHpn9yp9h0Em7UAFTVBGSzI2c6PIwT2mgQtD2uz7d8UR63G0lIrrKg
 zB7LgNRe17Lzr1DTht+USwbuBf80+pWJtKDMhNHWXMTCg4aEcSY+tdwKjhch969pFt0U
 wSputkA3K+XfxiEe1SI1G3u7erP0784VTZVFPJSJvZTWb3K91ewlbIkJgXJmp2tu/B8W
 6J4gB16fjSf+mTbhrMb6kuUOLYSu3NUbyB5nUfBqJcGCdKW5hI3w5Gep/vfEhay10SIY
 KzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701987170; x=1702591970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zuMK2+osl+g3rcJ34pnrTBegkSKiuBMFAEJDZTsdcsc=;
 b=sDPizlAhDr6RSUl2OpZYvU2P3BvkDIWHt7w071IerqkZ2T7x14JmVOyfUs2CYNTtsn
 o8SYZG4kWY7iZcJGgZ6qNsvy2IThsflU24pzK5bs7x75pupEOs/PIdiyzEMxLHq4LxA2
 G6qjTFupvr5MFqpwIemlKiEQ9Y4IuX5Wr4YdqCGhd/BlrbfNw4mNNswRsnMnf0L7zMRh
 dyLuBfoIEg27wstcqNCXaMZsNpfIU4sdt5HXFAc8HsCV9dBusv+RnwBgrt4FyziHDmKj
 8HERAitxQtkQ+qzVretoPHiJB8u8jiHk37H1uty5Dne7PXqho3qi+mQPYv+dKIH9VlHW
 tHAQ==
X-Gm-Message-State: AOJu0Yy/mjSqCeRx9MLmoO071SPyWRGahgxLu4uNXH8d7dYkib4aTLNV
 EztXKROECoHvXFl943YhOdsrVA==
X-Google-Smtp-Source: AGHT+IFTprZUJKyGoE8/9IJQmNayAgR6FxlXfBgdZHUrOfcLlG/+dD8jDbR3vBMOpqwijGejCwp2+Q==
X-Received: by 2002:a05:6870:5b89:b0:1b0:2f63:4ff6 with SMTP id
 em9-20020a0568705b8900b001b02f634ff6mr3824228oab.1.1701987169979; 
 Thu, 07 Dec 2023 14:12:49 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a631c51000000b005b92e60cf57sm267781pgm.56.2023.12.07.14.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 14:12:49 -0800 (PST)
Message-ID: <9508bf5e-a554-468f-ba94-4d6f1a5be7bf@linaro.org>
Date: Thu, 7 Dec 2023 14:12:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] target/arm: Ensure icount is enabled when
 emulating INST_RETIRED
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231207154550.65087-1-philmd@linaro.org>
 <20231207154550.65087-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231207154550.65087-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/7/23 07:45, Philippe Mathieu-Daudé wrote:
> pmu_init() register its event checking the pm_event::supported()
> handler. For INST_RETIRED, the event is only registered and the
> bit enabled in the PMU Common Event Identification register when
> icount is enabled as ICOUNT_PRECISE.
> 
> Assert the pm_event::get_count() and pm_event::ns_per_count()
> handler will only be called under this icount mode.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/helper.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index adb0960bba..333fd5f4bf 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -940,11 +940,13 @@ static bool instructions_supported(CPUARMState *env)
>   
>   static uint64_t instructions_get_count(CPUARMState *env)
>   {
> +    assert(icount_enabled() == ICOUNT_PRECISE);
>       return (uint64_t)icount_get_raw();
>   }
>   
>   static int64_t instructions_ns_per(uint64_t icount)
>   {
> +    assert(icount_enabled() == ICOUNT_PRECISE);
>       return icount_to_ns((int64_t)icount);
>   }
>   #endif

I don't think an assert is required -- that's exactly what the .supported field is for. 
If you think this needs additional clarification, a comment is sufficient.


r~

