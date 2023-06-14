Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FF972F3C2
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:50:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9ISC-0002Fv-1F; Wed, 14 Jun 2023 00:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IS9-0002FJ-9z
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:49:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IS7-0004B7-QV
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:49:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f8d5262dc8so1494895e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686718190; x=1689310190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ClAnjXInF4nVP6exj95wvTED4u6Pdst/e5XqX3tvjNY=;
 b=KBq9ZSu9mJYOnHDjOkWVbSIyQdLnYJbK5M1Mo8EqT0fds/hnnd5ZMBcUyu0eCmxUJW
 HV9M4GKrgSGMJCtT7WiiawswbxKjTFfRjKKz4VLsgZ3FU7q8KfSINRFzdTQdST7LXjA0
 gBB+zKRtL0xjOMWEgsmra1wDQn8UQTIDhGqT8CmCCeM8DT0PK8x1kA8qWWsXOdI8ne0M
 eQy6Ao83rmz+fGQSiWDf69li0DZMJtS34xxIz/+8U+NBra8uJFNRAzATcBhxoG/9AmX8
 Er0JH4nC5MTgKPDDXhSQwQkNHY8vNyWocKKL6lcEmsZhtNXwckQC/hhUw/nbWuttAFPE
 pouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686718190; x=1689310190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ClAnjXInF4nVP6exj95wvTED4u6Pdst/e5XqX3tvjNY=;
 b=WpBgkJr319+yJ/8lgbB1yWpGs/1pW8tRqDCDxbQavArHqbacdt9kynHUmWAk4JN2my
 WmjS4IgpbxFLeA4iXYz+0LWnpJy6AlHFGKONlXwB3UGQ/x2R4J8oYnh3MCjn0n2BnDyO
 S9aFyXd1RS/gsaoOt/dDPqhpPUijBJyHmyL5xIZ74VAyn+ajf7z58teRFv9vnn8hpQAi
 YN3gPb7lAz79JZO3UmWBvdSswm5odblI+JO1HLhcRA1eiEKN6VTCXR0tNfWIi/VRXGfb
 EFWUazB0Oc9NPzj2XdaOnIdmYAyvzkvArUrEDuZKfL1X9BZAkhfqVwZ0618ozvgvhksi
 TYeA==
X-Gm-Message-State: AC+VfDwDjv4KG1I4hzBdf4sdffTx731p0oLrjihucKXtZZt2J3MKvAbj
 3gCeftdlIiVLthQuhZtf8B+tUm2yrhg9InkQD9XTPYo6
X-Google-Smtp-Source: ACHHUZ465eLs7QI+FUNM0vO7Fa/LFNiiDu1xk/O6zaGBhE530G9bAV7mczIEWffPwgLvI+MCely2OA==
X-Received: by 2002:a1c:770a:0:b0:3f8:d030:862c with SMTP id
 t10-20020a1c770a000000b003f8d030862cmr319172wmi.20.1686718190337; 
 Tue, 13 Jun 2023 21:49:50 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a1c6a10000000b003f60fb2addbsm16211790wmc.44.2023.06.13.21.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:49:50 -0700 (PDT)
Message-ID: <6d133799-d111-3d2d-3f57-1c938e2a6ca0@linaro.org>
Date: Wed, 14 Jun 2023 06:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 16/26] target/arm/tcg: Reduce 'helper-sve.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611085846.21415-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
> Instead of including helper-sve.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h            | 1 -
>   target/arm/tcg/sve_helper.c    | 4 ++++
>   target/arm/tcg/translate-sme.c | 4 ++++
>   target/arm/tcg/translate-sve.c | 5 +++++
>   target/arm/tcg/vec_helper.c    | 4 ++++
>   5 files changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

