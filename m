Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E8B7213B0
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:33:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Znk-0000d8-Hn; Sat, 03 Jun 2023 18:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Zni-0000cM-BS
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:32:46 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Zng-0006j8-RI
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:32:46 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-19f3550bcceso3296277fac.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831563; x=1688423563;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BBu7fFWdcmFaKomwmhRM7bSas7K76l10adFKiwZSZn0=;
 b=jigYizfaVLLbwoSVKJ0TIz5vMrq7+HEgXFcJXcBPgGYLMumbYiFgbztEwffu78WTLu
 MaaECSQ7B87WQx2dZvsoghYXWS4fyeAN/REggfGjJnq7474mrxZLpaw2iCRi+yAme3Nr
 zXZ63ygdMBH0jJRPbCFMDZ/a0VuXlBliDUbdSvsONoty56gEUolLSxAxb/eliRJppE6R
 0LMyKsq9TR1Iqwu7e9Yk+wHxVCskDaOeZK72YcEeJHWMxIxD5LgEkQgezDIolUFINs+S
 MEu7x6OKlyGVN/nmtVr31HtxF92wgX0g27Z1XeQuXI3iVDbsqlXgRUHZtAsUvJ8RvlF4
 9pJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831563; x=1688423563;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BBu7fFWdcmFaKomwmhRM7bSas7K76l10adFKiwZSZn0=;
 b=UJ5q5mxOuuG7J9vbnx019nZjIbAOV3yYgIwkDPQA6E9+aef/cdzfx2lreA1LoF0tYm
 V/IFd32lcsZUHNFocPkZRFPA07oTO4cFFYwvi20uXF0cwOClHbEEZCc+NiefmbQXFN0T
 ZpfB2nM2pTFztAmQhcx+XlZVTeglEnwLmtkxDpP0A7WwB1C/BCunkyofkp2/2561rGkE
 2wUop6fVb0LqEd4wrC3vw5C8N9iML8hXuWxoPax03DUySsIfWBLTi5AjzOi6luGHAfc5
 Il7xOtVHs/RDHtRGrBmzIQvYVqOBETRNEZf6+3e67rggJNxhGOXaGSCVt+DMnltasi5A
 8Auw==
X-Gm-Message-State: AC+VfDykikex4hlW2I5Mxt8Ul5O58VmqvGB80K0+vo5Cy6sCv8cPLTsT
 /apNtw96y2xQVfSnLsyIXz6+bw4livyZ22AdcMo=
X-Google-Smtp-Source: ACHHUZ770VGjhefUny90PbmF6MxYb5ktr64AwTepRXVs26vFf8jToyrQJqeeoRBopFIev92/EgePgw==
X-Received: by 2002:a05:6870:37c5:b0:19e:c567:6020 with SMTP id
 p5-20020a05687037c500b0019ec5676020mr5699991oai.38.1685831563542; 
 Sat, 03 Jun 2023 15:32:43 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 6-20020a170902c24600b001a0567811fbsm3660706plg.127.2023.06.03.15.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 15:32:43 -0700 (PDT)
Message-ID: <37e65b77-8ad9-c6fb-d45c-714af02d7435@linaro.org>
Date: Sat, 3 Jun 2023 15:32:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/20] target/arm: Convert load/store exclusive and
 ordered to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the instructions in the load/store exclusive (STXR,
> STLXR, LDXR, LDAXR) and load/store ordered (STLR, STLLR,
> LDAR, LDLAR) to decodetree.
> 
> Note that for STLR, STLLR, LDAR, LDLAR this fixes an under-decoding
> in the legacy decoder where we were not checking that the RES1 bits
> in the Rs and Rt2 fields were set.
> 
> The new function ldst_iss_sf() is equivalent to the existing
> disas_ldst_compute_iss_sf(), but it takes the pre-decoded 'ext' field
> rather than taking an undecoded two-bit opc field and extracting
> 'ext' from it. Once all the loads and stores have been converted
> to decodetree disas_ldst_compute_iss_sf() will be unused and
> can be deleted.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  11 +++
>   target/arm/tcg/translate-a64.c | 164 ++++++++++++++++++++-------------
>   2 files changed, 110 insertions(+), 65 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

