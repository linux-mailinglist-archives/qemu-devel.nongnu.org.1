Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF0F7369B1
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:44:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYqi-0003xP-UD; Tue, 20 Jun 2023 06:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYqg-0003wh-Fp
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:44:34 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYqe-0005gR-Uc
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:44:34 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-987a977f62aso366108866b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257871; x=1689849871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ETPz/gmwp/TGJCNeRY+SwMDm7Do9a1+YIdTumCuBMTo=;
 b=YR+6IfWgsgai1mkqRyoMZl2Zn9V0BoxUzaFViwkoHe4WviXkw7b/MhftVBeCrnqRzS
 VmERto0nO2lHPxU0DMK3Uo+oSuepthGPOP6djQl27JCCfIiERnGHcyCTS+q5WJDbfrkl
 P+HOjPjlts036fj86P9lBwJRrJ/6DB3RvwUbIyFoHr1bweKTUzO1jtibCuFeJlgCXZkV
 kVwiy2subOuh3U5XOhDB+0ARTIo8tQSoPJ/wDsJo9lTG7mCjn+AEFcBpyPDFMB5hFuug
 R3kCTlFL7bFAqsmOKYcVdVT5vLv82jP/xCeVblLkmNziswGL/gOqAJNCOl+WmL7Et1bj
 48XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257871; x=1689849871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ETPz/gmwp/TGJCNeRY+SwMDm7Do9a1+YIdTumCuBMTo=;
 b=cm6CReOtTGDdRhDOF9kl15sFmTl5nJyt1whz9gbZvQgCDO6F815wKJ1TjrBw6pvxwv
 BpTB7sI0dwQNY+Apcz8tU0xIDk9A51NjUlfMGDR7PYMKSmLjoNZnjhff2nJhaIkO41Ju
 j75hdl9X6Tb7fJFHMpyWUs7Tmbzzc5CG1+fXsZxUJ4how/p5/v2o7qy2rg1lPriu5Rut
 9oim0dqe68yug+WCFojkyGR129k2Q5ySmJIV3ak+iN31fwEnpgrIrLRJ+cK0W0ulftBC
 Oj99oR9ot+bQSDd4My4hCk5WDaJFNlxN9Jat0/lQgAJ/XzDtIObfn7voc/aQbxGnmzkM
 WqeQ==
X-Gm-Message-State: AC+VfDzvkO5ATiplx9UpwWUSiGJtktn3K3DZpX9rkYL9qMy6CpsTMSOS
 E37a+8nTsOZOqNEQgaHAzV5/Bg==
X-Google-Smtp-Source: ACHHUZ4aoXlVTxgrlu3mZWKhrqe8Vc3we+OK/yfxEDQBTSnRjBxL1Hc6g8x8V0nXwYL7hy0+XenomQ==
X-Received: by 2002:a17:907:807:b0:970:71c:df58 with SMTP id
 wv7-20020a170907080700b00970071cdf58mr9203181ejb.42.1687257871395; 
 Tue, 20 Jun 2023 03:44:31 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 gs2-20020a170906f18200b00982943c7892sm1156744ejb.134.2023.06.20.03.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:44:30 -0700 (PDT)
Message-ID: <baae2a0a-d0cf-4606-82df-0ef1ba687994@linaro.org>
Date: Tue, 20 Jun 2023 12:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 33/34] target/arm/tcg: Rename 'helper.h' ->
 'tcg/helper.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-21-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 17:55, Philippe Mathieu-Daudé wrote:
> Since commit 139c1837db ("meson: rename included C source files
> to .c.inc"), QEMU standard procedure for included C files is to
> use *.c.inc.
> 
> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
> about includes") this is documented as the Coding Style:
> 
>    If you do use template header files they should be named with
>    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>    being included for expansion.
> 
> Therefore rename 'helper.h' as 'helper.h.inc'. Since this file
> is TCG-specific, move it to the tcg/ directory.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/translate.h                | 2 +-
>   target/arm/{helper.h => tcg/helper.h.inc} | 0
>   target/arm/debug_helper.c                 | 2 +-
>   target/arm/helper.c                       | 2 +-
>   target/arm/tcg/helper-a64.c               | 2 +-
>   target/arm/tcg/hflags.c                   | 2 +-
>   target/arm/tcg/m_helper.c                 | 2 +-
>   target/arm/tcg/op_helper.c                | 2 +-
>   target/arm/tcg/psci.c                     | 2 +-
>   target/arm/tcg/tlb_helper.c               | 2 +-
>   target/arm/tcg/translate.c                | 2 +-
>   11 files changed, 10 insertions(+), 10 deletions(-)
>   rename target/arm/{helper.h => tcg/helper.h.inc} (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

