Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7C71FE85
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 12:06:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q51fe-0005Y0-5z; Fri, 02 Jun 2023 06:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q51fc-0005Xr-3m
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:06:08 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q51fa-0001sa-Kd
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:06:07 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30ae69ef78aso2445749f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 03:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685700365; x=1688292365;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4izEsdGWELL+jgIMhjR2JpAMZ3UUgtuTTpldsVZzu9U=;
 b=vODgwklL7vcPadABog8If9BMi/IHKXDlBja9RVNTmqJ3UwyIvkZ8rPtmtH5kf6f/gD
 +vOGwkGB/lldK+3qLQ5WJgNWgcySPtRX9TVtJjbXknOoFA8PQUzftS6eQkHup8tQtrmw
 xQ8CJMYHrbTBhu4TW3QSfJWDqrj2JAUsG6YihUyZyW/7CVI1V8RjDf94aS7W8e55EQxm
 4fIjBie9WXqU0wRUBQkDlQpyVi4zF5C8n+aPsafuje7kif+ScvtGtany237t2y1/IWpv
 xTiVybtlibqGdNoYAPXPoUO+QTcHsKkqWYBz4Wk5huFTyCEkO1m1G26UTo3lpV8zxNT6
 wIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685700365; x=1688292365;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4izEsdGWELL+jgIMhjR2JpAMZ3UUgtuTTpldsVZzu9U=;
 b=dzHGRvIIdo8WIT3bL0SB1CVm6an3YeGFf0vP2A17H9oaRr6ljVbpr8FV1EriTB2vN3
 FX6rCN6kdGEIf06exB4DQrm5mJmtTfodj8CsU5KYcAIpPKbhjzKJRKbBb6HzAQSBTiLP
 t19lFuCHN7zjwzkyllT0yEC8xL05S4yvdA0tm2VNOzeqDPv+xAGhhywKljd5m2Ve988p
 ieSYaKSqehu4/JKW9tHjhJcqlXXOicwyHNIpa6fsaaFgDpvI5vj/xYeJEujMEbc80Phf
 EzBjPVtEq3gFbw+UJUB5RtPd3Slx61Mm4m+jHTbBBaokcpuWjcraHKui7D+FLrTes4EA
 WNkQ==
X-Gm-Message-State: AC+VfDzobSwB+aRl7u4DuevfxiKhepx90R57NW+hyZ4Lh4qxcNZtQwEZ
 f+jjv6XZAAi1QhD3iX8zLIunSLSOCmQC7E6650E=
X-Google-Smtp-Source: ACHHUZ5Q0oQASsmSmT0p7RtDl9PQDXuJlqNgUOlwNTeaaTT7InNOM9unTl1T+VUJdHsDAJzZ8Spv8g==
X-Received: by 2002:adf:f749:0:b0:307:869c:99ce with SMTP id
 z9-20020adff749000000b00307869c99cemr4280065wrp.21.1685700364908; 
 Fri, 02 Jun 2023 03:06:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a05600010c900b0030ae87bd3e3sm1226935wrx.18.2023.06.02.03.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 03:06:04 -0700 (PDT)
Message-ID: <9005d8f7-f5fa-bdf3-4031-6b54bae1996c@linaro.org>
Date: Fri, 2 Jun 2023 12:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 36/48] accel/tcg: Move translator_fake_ldb out of line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-37-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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
> This is used by exactly one host in extraordinary circumstances.
> This means that translator.h need not include plugin-gen.h;
> translator.c already includes plugin-gen.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h | 8 +-------
>   accel/tcg/translator.c    | 5 +++++
>   2 files changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


