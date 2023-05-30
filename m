Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB747160DF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:00:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ywt-0006Pl-8F; Tue, 30 May 2023 08:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3ywU-0006CL-C1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:59:14 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3ywS-0000Wk-SV
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:59:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30af86a96b4so157356f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685451551; x=1688043551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fc0QNYBo/7/8H3C0PU1VdgFRhXbx+g6BrK/2wpkYl38=;
 b=pyKFH3iIddls+HZ4duVm5T/t4A42pfiW3J8W2N5ujiZ03j4NJ+Ky7zhe3FA/RmBLQJ
 Cz/5Nb/qaF2lagc/ow7q1g9/fGNuQFl244RV5wI1zN/S2Wg1vLKB2LY2M8Cq9EMAfjcT
 a4JoBquJmbz2P7FltwXLfmjaoq7e4V5tGaV8d7lIf7qbFwWGn6EX+d3x1dGgt7W0a0pN
 ew1p0qXsmdjFiobS4VoJRSau0XOYjC0xZqRDq1me+ihfCEEIRMokJgRyN7+54euvsuMs
 oEJIsmxwd6yBGi69yXz0WaOoxdn2WGcrB+iKGoKezICj5Kv/eHqoMh2Q4uczgcXnVDZr
 JWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685451551; x=1688043551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fc0QNYBo/7/8H3C0PU1VdgFRhXbx+g6BrK/2wpkYl38=;
 b=RgJXekGGZzfWQT3eiWO03tbIrSlrp5qRoQ5tCZkb8ST8xJCZSn3Uey3sonG/M0Q/4j
 dT4XtSI9TsyP3hYznVMkcSoGRQLIeAVpIinYRgQfaVhS9VzEPiwY6gl4suG+mWleZD+y
 XtxkAYabhTL9pAPCjo6Q9SuxZdp8tGNFExVY0/7n28n+VaKALPQikxwtzZt4Gi1zTG8L
 H27rOL5AJ+NXZgnVs1NmDOyXsZ1TWLJU3U9Bhb5Y9rTGgbUpsxY7rrYXYl22xlIvD/wj
 3i5KPm7z3bSqQMHUbAOPzo+6krDfpS4iaNT/NZnKiu+59OqGkJc2m4s65ah0ftwnfsKB
 vppA==
X-Gm-Message-State: AC+VfDxm7y7R/Z0KN2qYl7aJW/admuvWTD3XHi+hXHmSdrTHwN3VV/bV
 gTY2XHQ4hxX0UBdvIrrty28Npw==
X-Google-Smtp-Source: ACHHUZ7dEgfKr1ncMxjLJyRx3fXuajH5yXlix8qOVdWqGhf0IALBiKd0fmauLHkuKgOFpsUqzSiLYw==
X-Received: by 2002:adf:ea08:0:b0:306:26d7:3805 with SMTP id
 q8-20020adfea08000000b0030626d73805mr1489984wrm.63.1685451551185; 
 Tue, 30 May 2023 05:59:11 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adfe984000000b002fe96f0b3acsm3270710wrm.63.2023.05.30.05.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:59:10 -0700 (PDT)
Message-ID: <f20d051b-4daa-1118-4d3f-c9a1403d63c1@linaro.org>
Date: Tue, 30 May 2023 14:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 11/20] target/arm: Hoist finalize_memop out of
 do_fp_{ld, st}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
 <20230525232558.1758967-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230525232558.1758967-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 26/5/23 01:25, Richard Henderson wrote:
> We are going to need the complete memop beforehand,
> so let's not compute it twice.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 43 ++++++++++++++++++----------------
>   1 file changed, 23 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


