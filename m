Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54616739BD4
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGES-000125-Sf; Thu, 22 Jun 2023 05:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCGEQ-00011g-99
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:03:58 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCGEO-00079x-Js
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:03:58 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3111547c8f9so7976215f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 02:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687424635; x=1690016635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Dz88Jf+B2MCWHiTqhWoKnJ9P5S2znpqYhv5Ue2nRrY=;
 b=cfC1FBhcJ3VcLGRdysFVZJdjGsPeqUT1NI3e2CfUwmjRY2lLBzwlmicEJlP9gg2LAU
 /yJboky//EXL62UNb4HJ7eI/EwyMbHAu/UcI3qsW+noK7GnIhp+mkIpDtR5QVETnqyD4
 P41AWbQjcnhSXnYSznzRk58o942tC8imm3lGxwgrUvzz9rV26Bp5Wps6czlzO0PEZMV4
 Ja5r9P6gl0AcB2HpirsH9hDJ2feiw/TRRvOrlU7TWaqd/LqDcYabpzNKsqyKSasueads
 rxPX9iZW3AIZm0x/1pAWblMSRsAt/Tz4Z6vVSrRimmYC2e0uE4qLS+0gNh9aKVDKULMS
 7bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687424635; x=1690016635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Dz88Jf+B2MCWHiTqhWoKnJ9P5S2znpqYhv5Ue2nRrY=;
 b=WvXfYB68dzGBAUMDhMyxSeDJr4W0cdfqiL8Sd1fz687mfpbUOtBC6c3xuP5mPE1bc+
 hlJ+l8cvwfdkW4JXG4SZvuHq7tD4vhIffgwPKKP/dZ1twtrNG5BgsBdR8fHp2p3HL8im
 eg7dM0UxtBCg+CtomPnkgkF0upgbWT/dPQfsLAZgGpdLNF2ocaXzmS+8jRkVFUCD/war
 +0+yxRKjk5yV96X7RPqcFqC4FgyzFhiHVSJmMNsD7Kra/dycD4p3ESOz6Q6M9gun/uDC
 nP38Qa0MdlmzfrLpbnZj6h74a5wkse2gUgm28mVpgsWWSkLqEgwX31b8mJ7paKpMDV2Q
 xX4A==
X-Gm-Message-State: AC+VfDxlGg8hmz1MvrxZmRFD4Tzwod4Rstv4kLsnJnzCRpE7Oj6OEFG6
 7xjEerZJyO7A5pdhC2NZgsAnDA==
X-Google-Smtp-Source: ACHHUZ5+RchBVru2HgAklXMT68uDVpXAAhf10wiBY9Wno9d6vlecYO4e6saU4TNTSvrSlDjBgbqc+w==
X-Received: by 2002:adf:f287:0:b0:311:13e6:650a with SMTP id
 k7-20020adff287000000b0031113e6650amr14725297wro.28.1687424634790; 
 Thu, 22 Jun 2023 02:03:54 -0700 (PDT)
Received: from [192.168.69.115] (che77-h02-176-184-42-18.dsl.sta.abo.bbox.fr.
 [176.184.42.18]) by smtp.gmail.com with ESMTPSA id
 p16-20020a5d6390000000b003113943bb66sm6444903wru.110.2023.06.22.02.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 02:03:54 -0700 (PDT)
Message-ID: <c9bad229-874d-aa72-aca5-8834866026cb@linaro.org>
Date: Thu, 22 Jun 2023 11:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr in
 gen_goto_tb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <20230621180607.1516336-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621180607.1516336-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 21/6/23 20:06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



