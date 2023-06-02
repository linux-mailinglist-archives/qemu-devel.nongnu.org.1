Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E3E720AB8
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:01:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Btp-0005jD-MT; Fri, 02 Jun 2023 17:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Btm-0005fE-S9
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:01:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Btj-0004hs-By
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:01:24 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30ae69ef78aso2944897f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685739682; x=1688331682;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SLn4RXy1/lZKosOsDl28kI6qVRXwZyaVn61rKGywO0g=;
 b=IhJcilP2ib1r/4i20vvwft9eslo6VfXYwNOHHF/y+YGf6S9hvUraaWOKOB+elj0ry7
 aYdKZLeAap+p1LLFqsmo+1in+Xxw5vkf0JKOvDiXN0cGgBzJpgFOHOPUuf4MwBctV6Mw
 EFa4VKqh0qREeC/nsT5hgLOROeHSFeWTk8bszfml4QykKMm2bFM5is/LzIFfeOyrUCJY
 qv+rrnbiKQ2831UVIWI0eG+TpIuSrPdb/l09ZdHnTkXTv/K5U14AXWinvax9vh3G5TYp
 Xsmd7lefoerKKyi15fYBdjEPTDNywy8h+wDBx8savbUOOpkCMz25qL3U3BnHDPvmJnrt
 9hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685739682; x=1688331682;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SLn4RXy1/lZKosOsDl28kI6qVRXwZyaVn61rKGywO0g=;
 b=Wi1uhmFJwMRndxTC+UIbdv9PAerP3hfKyFtAits4qNNk8kRdw2KGeE9dXyJVX66ndG
 31IHVK4nj9tstBlCpU/wXpxSxlmO/iPG/RmNbSYwSSkMv4b1JHWV3XS02soOLMg53YMf
 ndh2PlelcJdVS3puSm6xkHwJloAxXRqO25I8cJl7MFSjTygIhWZEdhzyKLrR9Jd+cehs
 8UK6wCSugD1aeVSIEns5h+RFrHqOPVjSKKXbll3XuZUuHhgc1mXnPrY3WbaVNGvGVmmh
 2qIXG1iTNr68syhZssV2Yftymd7Od+ThEvwAo7P2eCuhFAtg/EXsVtdyJr96AxXQ0oa+
 JO2Q==
X-Gm-Message-State: AC+VfDy2sLTtnZe2QxuYzCOHsWW13UF9qkQimqznUB1wzDfA5yeZWEw+
 9Ka+yJFU5x+D2YjKI1MzHx2kaKQfRMzH2ZbO8FE=
X-Google-Smtp-Source: ACHHUZ7/CjbALLsKgOhydUMuC0zNw5MEZCb9OdXboJsund/SMBtnpj67FlyfQaUXznGcnVIxv1iGlw==
X-Received: by 2002:adf:ee51:0:b0:309:4ece:a412 with SMTP id
 w17-20020adfee51000000b003094ecea412mr724169wro.14.1685739681924; 
 Fri, 02 Jun 2023 14:01:21 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 k9-20020adfe8c9000000b0030644bdefd8sm2574903wrn.52.2023.06.02.14.01.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 14:01:21 -0700 (PDT)
Message-ID: <447e0b29-a5f7-1598-5179-50ca76083b76@linaro.org>
Date: Fri, 2 Jun 2023 23:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 46/48] plugins: Drop unused headers from
 exec/plugin-gen.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-47-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/5/23 06:03, Richard Henderson wrote:
> Two headers are not required for the rest of the
> contents of plugin-gen.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/plugin-gen.h | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


