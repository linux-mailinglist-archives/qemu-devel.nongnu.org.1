Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B18674B1CC
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 15:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHlXf-0003qP-NC; Fri, 07 Jul 2023 09:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHlXc-0003q8-0x
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:30:32 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHlXV-00016T-2l
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:30:31 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9922d6f003cso247958566b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688736622; x=1691328622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=39gMjFsdbEapqGPFg6LByWYl2iaofpkxb3nuwMNFMf0=;
 b=KH+O2sAyXe4P1AQArA9MoeWT1SCcBC9iGM2DyTW3bjMzKcvZvhTgURk5hyhWX9Oldv
 ZLZl2S5AyHJ/ssQWjHL2IfWuXr9+pHPY20QHj9cNHsfgvTPUvIYSe+prEwJ/s4T39Wwd
 BVhmE2q4TuqTeaYHq+SuYRlUx67xjEnUsaJcNSDtFhsgbwD17kuTLJSxngIEF5ziIimj
 PDSwKdteayx4/k7tRvrZevDiLCPO4Ue7RIUZrMr+GQWEaPcQ4tYyGw9COYPPuXIEmS9P
 cqn3e59YOk1DfmpDr7vOKEvhNRUIsReUORR/Mb5lUIQJOFboOV3cGhPTh+7Kg3GI42k/
 yTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688736622; x=1691328622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=39gMjFsdbEapqGPFg6LByWYl2iaofpkxb3nuwMNFMf0=;
 b=XhQQXNZHQUPildUjl9SRUkTgK8x3aAVU2sDVz1rTHCi9unsxrXYAQTlc8rA2Zxo/pt
 5QwYFb02nQJBMIaKowj2Av25euovPQpmeuyN6oYfAAzvOgXjXvf6E6igsGFBE9gX2K/+
 n2i6aq/X8Ur9r2TAOycYlcBtjx2kyKFDX0K/Rph9ATgUYsYRs51HMiKkhX19U2UjMIE8
 GzXgqblbSrxrXbylVUNaygVkx98TFLzR/IpJjALG8AMGfFu0/sumdXd9APpeWHF3gG8d
 ZnPoNY+VTABq4uvItDxC0VznFfQdXwYsi/XWEVi+veT9k1kEMk9TV8zjhHV7PBm7N8jr
 qrpA==
X-Gm-Message-State: ABy/qLZISIAd7azI0VmEG3pTzTvDxcgZSdUCzbAqttygW7vb22aansEW
 fS3QwTLWMdKR2RCRhdp5JuBRpQ==
X-Google-Smtp-Source: APBJJlGrIxDnTQo01iczscYaLsdkjwv5a96AA6SXDWOW7KM8Tyl92XegPU4Bckzwd/ASpBlgeMmQSA==
X-Received: by 2002:a17:906:9614:b0:988:9d0f:db52 with SMTP id
 s20-20020a170906961400b009889d0fdb52mr4269133ejx.35.1688736622454; 
 Fri, 07 Jul 2023 06:30:22 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a1709063c4c00b00982a92a849asm2201821ejg.91.2023.07.07.06.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 06:30:22 -0700 (PDT)
Message-ID: <cb08af9f-18b0-3ba3-ab5e-6eaaea84a63c@linaro.org>
Date: Fri, 7 Jul 2023 15:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] tcg: Fix info_in_idx increment in layout_arg_by_ref
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org
References: <20230707102955.5607-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230707102955.5607-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/7/23 12:29, Richard Henderson wrote:
> Off by one error, failing to take into account that layout_arg_1
> already incremeneted info_in_idx for the first piece.  We only

"incremented"

> need care for the n-1 TCG_CALL_ARG_BY_REF_N pieces here.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 313bdea84d2 ("tcg: Add TCG_CALL_{RET,ARG}_BY_REF")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1751
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

