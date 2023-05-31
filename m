Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92006717616
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:22:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4EI0-0006kF-S4; Wed, 31 May 2023 01:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EHP-0006h9-Tx
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:21:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EHO-0004LQ-9F
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:21:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6da07feb2so54544745e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685510508; x=1688102508;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j92EyHohY+K+XZN8ZVYgvtHhu7LGWGGhix4W5PYooSE=;
 b=q5+FUOsca+WwnnB1QbEyj9QTN6rddwWik0mHkLQ1o9OYmk7cjBG/bPYzJa8NcAp3c1
 ZnBnmm0COh33bTK1wXAfsRKdHMrjJwCazew+Cii8WDsHsgRveHpvq7N0dnZ86dK2LYT5
 ZpPa9B1EEdeekcjf1LAgjOwm8bv20SknvEkLaKJlWp/uttSGaSxGrXqSF4gDCUx92+MR
 ntS5Yvh1WnRxWkgCU+KCoau4F5u39hgggmFfpewK2oraY7ZZgAZSoSg173TYG1YQWtOf
 0tbYsg55YtIFknMVINWvPYE9pe9Uib36634aS7xc9qqjHRVWj9ve2wLQEYTxBu+yO3hw
 by1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685510508; x=1688102508;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j92EyHohY+K+XZN8ZVYgvtHhu7LGWGGhix4W5PYooSE=;
 b=QC96HWBgkKep6VIXlVe9uvLXKTFJTMvFLsLVOy/w35nRQtWQ5aPzav5a9/OfgfUkVn
 /em5TMu939LFrshzq08yTgyd9ugw55hHXzjo0i2oQJgHpDY9F7krTxsgQhWO0rmgM9+j
 kHz+GL4R55+sVOjJFr0KG0WOcpe1r4wy8JFgkmeuYeVSr9aAc5Fcy4DbtFoc9DNOxkq7
 lRN9U4yimQVFp6QESzxzf+uRxvQdrg0ipeL+MF5ZYTswl2zS4ipOz7gx2F/HXV+au7OF
 r2oKFerGcjGT92sKSszWMUQbkDfR7LK8l1gDNRgy9y4+BakIQFpsTllsYLKh2kcAdBnH
 bzWQ==
X-Gm-Message-State: AC+VfDw1BehzG7WFenWE0NRDnCleAoF6un0qbBWYegAGK5tl1r3+ew1M
 NPTBX+PB5ay9bxmLw6lLq8DCmQ==
X-Google-Smtp-Source: ACHHUZ4dQ55qL41ec3GWaBNiaH7q/JnrqOKpZvX+HpYi9Cx4gg/m2mIxDIMnIIQTQPEK0JxzIjs/pw==
X-Received: by 2002:a7b:c048:0:b0:3f6:d2:d8c0 with SMTP id
 u8-20020a7bc048000000b003f600d2d8c0mr3442159wmc.19.1685510508342; 
 Tue, 30 May 2023 22:21:48 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a1c4b08000000b003f4289b18a7sm19364285wma.5.2023.05.30.22.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:21:48 -0700 (PDT)
Message-ID: <b7c8083e-1bf5-9cd9-bb8c-fd7db2d429dc@linaro.org>
Date: Wed, 31 May 2023 07:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 34/48] accel/tcg: Move most of gen-icount.h into
 translator.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-35-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 31/5/23 06:03, Richard Henderson wrote:
> The only usage of gen_tb_start and gen_tb_end are here.
> Move the static icount_start_insn variable into a local
> within translator_loop.  Simplify the two subroutines
> by passing in the existing local cflags variable.
> 
> Leave only the declaration of gen_io_start in gen-icount.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/gen-icount.h | 79 +------------------------------------
>   accel/tcg/translator.c    | 83 ++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 82 insertions(+), 80 deletions(-)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


