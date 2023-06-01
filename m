Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF2E71F3CB
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 22:24:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4oq2-00061s-09; Thu, 01 Jun 2023 16:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4oq0-00061c-0N
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:24:00 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4opy-00004s-IW
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:23:59 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30ae901a9ffso1210928f8f.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685651036; x=1688243036;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EgXFvi+1DyLx6ht2YH+tJYGurG2t7PM0Iz0ChWassvo=;
 b=c3ZoqGOHIOx6q5ju63af0Dp3vDT9rLNnZ3+CQbliIe92wsw94RIkeseUWO5IxFKKyR
 C1Jj1f2aspiyLhQRErzlGA0T6SZuLmDjpbRTcdnMOZ5L57BrjmeyhPzfcP5CWzIq4Svf
 U4F3KnkN3c25vMc7UaKGLXoO2mtHRAMtJrzTuoXCWywNg8lSH0LS5LtN7nLg1JfDZWmt
 Kkf2K4lqQbGq1VRgSNph9G+Z5WBjl3fz/2bmhZUAOGAbAQI128UEe05+ncyzbrobEZyq
 AoFk2EFOpp6jNdfJ/1THCUJ+a6uWa4UPxnjW6aIF3a03ISH2QFWutufx5pwvVfpLC+WX
 6bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685651036; x=1688243036;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EgXFvi+1DyLx6ht2YH+tJYGurG2t7PM0Iz0ChWassvo=;
 b=RHS6sjS7wVtOaOVEjnNh1zekrSIfXJuOGyLYhVkqJJ+xiBojKqBp19LCRyC+9+fKDK
 uq9sYI2G+vZDGSc421GsNxTZoTaX4mQpDNq9+AKNzlGJFy35HkKj6wtcGEOEfQh5RKx1
 C8bckVATJj+8yWiMhcuWGORj0epdnW34BmV5vXo/jhDtWB+LUTIaeP4EbHwx/1FYhBNy
 gfkNFHKLFaR9vtAKboNvcxLkvUz3NgqY/IjxGDeAHaaHmzCqclG6ARoPa1ldEqhcC4fu
 6juB6mCEQc7vBaKNr365gqGyI1bmK+hTUYxOOnFPFf6KcXZ+CULCqx6JCuPvW8NP6hha
 8ZsQ==
X-Gm-Message-State: AC+VfDybWNsrGj1fTpQC14RkjH0SoC//ZG1CMGnrDR0hySZsCRmk/QKp
 58cX2qYlfJMb9bdJ61ja2upMsKEz8ScWzfX5pKU=
X-Google-Smtp-Source: ACHHUZ4bjiLGcJrYp7gi/b1n6QUApiHIFr/gH8aFHA8lN/bmbzI/STkl2GF8CBbH4Y4rOjK3saczRw==
X-Received: by 2002:adf:ee49:0:b0:30a:e369:5aca with SMTP id
 w9-20020adfee49000000b0030ae3695acamr2723047wro.25.1685651036628; 
 Thu, 01 Jun 2023 13:23:56 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a05600011c100b00306c5900c10sm11385206wrx.9.2023.06.01.13.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 13:23:56 -0700 (PDT)
Message-ID: <f930ef34-9c6b-5c68-bb55-f4886360fbac@linaro.org>
Date: Thu, 1 Jun 2023 22:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 32/48] tcg: Spit out exec/translation-block.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
> This is all that is required by tcg/ from exec-all.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h          | 135 +--------------------------
>   include/exec/translation-block.h | 152 +++++++++++++++++++++++++++++++
>   tcg/tcg-op-ldst.c                |   2 +-
>   3 files changed, 154 insertions(+), 135 deletions(-)
>   create mode 100644 include/exec/translation-block.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


