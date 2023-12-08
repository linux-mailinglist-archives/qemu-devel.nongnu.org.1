Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9780F80A420
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 14:07:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBaYQ-00049q-BJ; Fri, 08 Dec 2023 08:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBaY7-00042S-8x
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 08:05:55 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBaXm-00041D-Or
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 08:05:45 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50be4f03b06so1982276e87.0
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 05:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702040723; x=1702645523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/t0HoY1C3neyISWJuyb6jOMXnPjOnvOpO/4u2zzyJJ4=;
 b=wKlygqLVl9LhzX9R2L1JA+jz7kX3BueLmICAVpcn11ZO6kSNIBoYO9c1dAWbqO1pua
 RJrgwuAHxHDvuY+OaiHaY4yCNaS21WbkiRqVI59hIhy/mz0o1axUHNolopdA+wQg6i6N
 W+PWmHOYjCYSr4mObu5mp7+96OSYZkChQ0cgI5ORZHOE3FF5PJFulLGNV0Eq1XWAWXGS
 VbN7Pd2JyMdHhGOq1NMH747mIBb7q/mLKXSUnCfutouLXvVlD4nJC3Ab5M7R36Jp0cKX
 R0XD7omHbVAhEMMoHf5BUSMTQI7+hgAmeqOoFeN/oj9pZ6ePKcXDg0l4VTjcmQm2Ti8I
 OAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702040723; x=1702645523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/t0HoY1C3neyISWJuyb6jOMXnPjOnvOpO/4u2zzyJJ4=;
 b=bfo/GT3r/3Y58CVrPc2S9DK0KQj/7jvfW3Kr1HfadSp2avslzZ5Md4j9CDTNXh0XEz
 /KuN6SSXr63oDVUDcBDmtjTHUZIX2934bKMysUhShEc/9GGsJMR+sJd6cmHnKhE9fDZ4
 53SPZiBd+3gog/rRGLXZLwm756YNL5bJCQh8mDiMDhjB2vICYVv1zrF6WqQNF7mwEGrv
 Mh+yi5t/Tt386P/BJ2yKvx7I7LPyo2SOAHxJSi2atwtRwriLhk+8JsjYZxKY5/u+e+7R
 EHspFkqHye8bctHbak2IMr2LgnLgEg7KudnTbcHXZbqkYuPTXBdcY/hi9W3PmGdJPFAh
 cmVw==
X-Gm-Message-State: AOJu0YyEJggoQWmhmtg+c52tmvV7OiTg4ExDab/pFqimuaN49sCaJv5K
 t3Jkk0RNCf9MBF9ZDxALkN9g00vVoWfLQtmctO8=
X-Google-Smtp-Source: AGHT+IFW0WZcGDr+m+ArX4QSGInt+I2I7GhSkt5zEspy/3dIh1hlA3L2DgzPUpC7X3MTEsUNYVx2bQ==
X-Received: by 2002:a05:6512:344e:b0:509:8f8c:986f with SMTP id
 j14-20020a056512344e00b005098f8c986fmr1541720lfr.7.1702040722614; 
 Fri, 08 Dec 2023 05:05:22 -0800 (PST)
Received: from [192.168.69.100] ([176.176.146.181])
 by smtp.gmail.com with ESMTPSA id
 cx12-20020a170907168c00b00a1caa9dd507sm989606ejd.52.2023.12.08.05.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 05:05:21 -0800 (PST)
Message-ID: <5f9513ff-1a41-4f83-8ff0-eeb550ea2eef@linaro.org>
Date: Fri, 8 Dec 2023 14:05:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] sysemu/cpu-timers: Introduce ICountMode enumerator
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231208113529.74067-1-philmd@linaro.org>
 <20231208113529.74067-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231208113529.74067-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 8/12/23 12:35, Philippe Mathieu-Daudé wrote:
> Rather than having to lookup for what the 0, 1, 2, ...
> icount values are, use a enum definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/sysemu/cpu-timers.h | 20 +++++++++++++-------
>   accel/tcg/icount-common.c   | 16 +++++++---------
>   stubs/icount.c              |  2 +-
>   system/cpu-timers.c         |  2 +-
>   target/arm/helper.c         |  3 ++-
>   5 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
> index b70dc7692d..3f05f29b10 100644
> --- a/include/sysemu/cpu-timers.h
> +++ b/include/sysemu/cpu-timers.h
> @@ -17,18 +17,24 @@ void cpu_timers_init(void);
>   
>   /* icount - Instruction Counter API */
>   
> -/*
> - * icount enablement state:
> +/**
> + * ICountMode: icount enablement state:
>    *
> - * 0 = Disabled - Do not count executed instructions.
> - * 1 = Enabled - Fixed conversion of insn to ns via "shift" option
> - * 2 = Enabled - Runtime adaptive algorithm to compute shift
> + * @ICOUNT_DISABLED: Disabled - Do not count executed instructions.
> + * @ICOUNT_PRECISE: Enabled - Fixed conversion of insn to ns via "shift" option
> + * @ICOUNT_ADAPTATIVE: Enabled - Runtime adaptive algorithm to compute shift
>    */
> +typedef enum {
> +    ICOUNT_DISABLED = 0,
> +    ICOUNT_PRECISE,
> +    ICOUNT_ADAPTATIVE,
> +} ICountMode;

Per v2:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

