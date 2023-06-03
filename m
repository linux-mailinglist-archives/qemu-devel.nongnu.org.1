Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A937213CC
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 01:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5aru-0000q4-Cy; Sat, 03 Jun 2023 19:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ars-0000pn-3I
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:41:08 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5arq-0004Wl-7y
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:41:07 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-19f3550bcceso3319825fac.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 16:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685835665; x=1688427665;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SC8k5lv4XD4k7XBhArUpXyWpyFek39MyN2Ma/lMirD0=;
 b=qOr+FwtQ/QwBUHpnuqUiuTIIiB67HefSzq6SN4loKLmHt5eYi2eBY61DidYlM6WB2Z
 F0UGxrbLvn32wLPLrQro6N7klLVcMuOW0o25ov2+MjmbnScajQS7gB7hpTGK4n6eCdE5
 i6AgPitIusJh3rS6TWtaD9Z2wTugKjr7pweIBgL81R2a8XL4phMXVpGuhk0bvechcogH
 s+c2vmHmUCrXBki5P3ODfzXfLsmzsc2wfXnOufiKBpOPIaQ1H/g77CPlEvj5plni/oXB
 PZ5oVzJFI4oSEqIWdlC43W+/lp5xLQor44UQhBANahWC+z+ulcEt++5QTs83kprPoNwY
 WGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685835665; x=1688427665;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SC8k5lv4XD4k7XBhArUpXyWpyFek39MyN2Ma/lMirD0=;
 b=gjsPEQTCqqARJKtnoIMBcnIkIEdjLP/9mfPq/VQKEN0UOWV4aRNiN/CvHRPnAtrjzx
 a6lHV7+saGLiQFWRLQGQxu4klJcVM8XY9/2Kanh5UP6/G10bYVjjHZv8za6St/EWBKKL
 x1H31LlbSL7OhjONIQ5D99sEh1qBK7v7TiNmhN9Fkcrl0Ra/0OvHVdN20rFc4ubgBrLC
 ILYZytE17EbrBpjW2b8cEpmmrcCCAfOOlfBFbYzp/H3+1gCtqE8L/eiwWCqsxANqGly0
 t5lub2lirIFm9df7m4V5x4CaeUoJW7fPQLyvi78MLYsAMcG6pwlzNGUd9YiZ1CBWvSZp
 e2MQ==
X-Gm-Message-State: AC+VfDzecwkAu5KzuXQ5MQ/7HGsGbpWaqjyvrxwiz9rDVM0D7UnShzRQ
 +Ri/Lxm1cEz+25CxgkC0LY6SuA==
X-Google-Smtp-Source: ACHHUZ4P3Y2thiRqk+qgsUMS0O4Y2oj1VV6GcdZx4tj2uaokpv5COcQN0yLlkglUXTngweeZsK65ag==
X-Received: by 2002:a05:6870:7729:b0:1a0:85d3:3d70 with SMTP id
 dw41-20020a056870772900b001a085d33d70mr5379418oab.28.1685835664945; 
 Sat, 03 Jun 2023 16:41:04 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 jw19-20020a170903279300b00194d14d8e54sm3740412plb.96.2023.06.03.16.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 16:41:04 -0700 (PDT)
Message-ID: <1bbe6a16-e7ec-f85d-76a5-fc08616e04ce@linaro.org>
Date: Sat, 3 Jun 2023 16:41:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 16/20] target/arm: Convert load (pointer auth) insns to
 decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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
> Convert the instructions in the load/store register (pointer
> authentication) group ot decodetree: LDRAA, LDRAB.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  7 +++
>   target/arm/tcg/translate-a64.c | 83 +++++++---------------------------
>   2 files changed, 23 insertions(+), 67 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

