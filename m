Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE33720A9F
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 22:57:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5BpM-0002QK-A1; Fri, 02 Jun 2023 16:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5BpL-0002Q5-5u
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:56:51 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5BpJ-0003QA-Mk
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:56:50 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30ae69ef78aso2942245f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685739408; x=1688331408;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tbQLZbE/WDczJJDfEsqfW53QUkwag2K+3Av6p4ZLfsM=;
 b=EqSWSg60MQmbrpzI29mlR3DvSeLVCRMkEnTBmnW05tDaoeR3peGYYxg5CwZCT/SXJT
 ejNvmP8e9tEvTgHjeuhhnpzs1UTQPZenDDE5MiuoA0bo3H5QStgkigzO/e/IfNXAD+pt
 ckiqDNHWyBTj7jvNW8kwpkgciw2NZOzM68Zmgg2q0RWMgeGi+vebtBxo5Oz+nzO2E+nV
 TuZxI7x8A/mOW+8NkN1ExUNu44D38MRM6HXpTcXftCvJ14KCxnOrR802QfgINnLas3e6
 dBf9xubWBXfQhPZEhZ8gIBrykWiQTn/JCZL/sL0nhoK+wq/5eSgann7xh3urCrekfd3P
 X85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685739408; x=1688331408;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tbQLZbE/WDczJJDfEsqfW53QUkwag2K+3Av6p4ZLfsM=;
 b=aiTdlji8afR+b3qguuwOglgr5JLIJegRge9+T/jyLJ+sE2io0hoBE6Q0h2kwBFJZEz
 LQhQMFJcIJ3k00Dh0HEHIpYxwk9yCIwucTrDkYKoLKu2hxp+Pd130e3H6bO69w1Tt8ZO
 q08gECUpTamQMESGgxmowx6e/etwwjsENVCaIfQaDxKAoeqe5+wFga0Zrc5e3ukOrZI1
 FUWeLlrJC783PViVPB+6Iabblad0o7hrccXubk3ZzT5UEopm9sqdXgXkFXyt3T7Wap8V
 F6RwQzAi0bdOVrbncZlTQu//+D8VIPKhin/rGWPMdWo21CnmQt9G7Mq8sv4C3cJo3Tc0
 2n8w==
X-Gm-Message-State: AC+VfDxkHOvjDh2sXMCjwHKhUGNYkpGklxuCPqpDiAkbTcvinWuXcDwJ
 t4PksFuzeWS2pGvsLCq0t4krhA==
X-Google-Smtp-Source: ACHHUZ5EZ+gnK6yQLf1DhWeT8CekgBVtleURqQ+jB2FGraLlArgzKQURSrGAc/ZJEpH9qUbwJSvbGA==
X-Received: by 2002:adf:ebc9:0:b0:303:daff:f1a3 with SMTP id
 v9-20020adfebc9000000b00303dafff1a3mr938709wrn.1.1685739408014; 
 Fri, 02 Jun 2023 13:56:48 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a05600c290a00b003f0aefcc457sm6523275wmd.45.2023.06.02.13.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 13:56:47 -0700 (PDT)
Message-ID: <c79771a1-9b93-98d3-b4ba-dd5eb415ef7d@linaro.org>
Date: Fri, 2 Jun 2023 22:56:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 16/20] target/arm: Convert load (pointer auth) insns to
 decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-17-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230602155223.2040685-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 2/6/23 17:52, Peter Maydell wrote:
> Convert the instructions in the load/store register (pointer
> authentication) group ot decodetree: LDRAA, LDRAB.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  7 +++
>   target/arm/tcg/translate-a64.c | 83 +++++++---------------------------
>   2 files changed, 23 insertions(+), 67 deletions(-)
> 
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 69635586718..2ea85312bba 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -457,3 +457,10 @@ LDUMIN          .. 111 0 00 . . 1 ..... 0111 00 ..... ..... @atomic
>   SWP             .. 111 0 00 . . 1 ..... 1000 00 ..... ..... @atomic
>   
>   LDAPR           sz:2 111 0 00 1 0 1 11111 1100 00 rn:5 rt:5
> +
> +# Load/store register (pointer authentication)
> +
> +# LDRA immediate is 10 bits signed and scaled, but the bits aren't all contiguous
> +%ldra_imm       22:s1 12:9 !function=times_2
> +
> +LDRA            11 111 0 00 m:1 . 1 ......... w:1 1 rn:5 rt:5 imm=%ldra_imm

Only sz=3 && v=0, OK (previous code was calling unallocated_encoding).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


