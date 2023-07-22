Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9CE75DCDB
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 16:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNDG8-00018B-Rb; Sat, 22 Jul 2023 10:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNDFo-000149-9V
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 10:06:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNDFm-0001gx-NC
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 10:06:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fc0aecf107so22742465e9.2
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690034796; x=1690639596;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J2FD2DJf0a/VP0RYOPU0CVDYFMhjJWhEaHNFT8pA9kw=;
 b=YcT0MM1lkzJl0d+NXEq520wiYBHBRQOrsSYIPJ2LH1fE9U7dInn5friEandlUW4FuV
 R6dkK1DEl+/2JRrU+4mdOIOJPx2vt3xM5QbwRKDbp0ImZtcFjDHeW8qgKhhtINBMkU3x
 MAI1wy4CPec0zbTkZUi8AP7P1kWkyMMF0Mh6KjYjeKffHG376F7lDpmg0UKctALbBXfE
 2a4sJz7db1MnrOtisZJWM277TOTYh+4KUfZMyt/SnpGy/AeCnzxP4MNEdrO8rKqnQstk
 7FKgMvU1SpiGYVKnOjgrCjmEQ6QUPfmN4xjGYVNy5nizZWIklO04C6tZIXQ4qL7rw3yr
 9Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690034796; x=1690639596;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J2FD2DJf0a/VP0RYOPU0CVDYFMhjJWhEaHNFT8pA9kw=;
 b=WgGX2nzF27j+WOd1ntexTiG5UozhLLCjRBjJRSPUP4ipP7f3vDcZOeHdKzpM8G5Ws+
 gPp7+9ZxMHIQ1bBPNnPB/EgpN19UNHs8psKtfrBElgXThv89WsMPaf8P0/8X/TL9x0NX
 DYw6pQq6koewYXomsjPOReCfmmeIVqxeVFGN6VuGPuRT4Rfi1U7GcGB3KmUS+O3QIB0n
 WyFLiO2+LeWXeb3UT3Zi5G1yLPGRH8kNbVSzSTI4A7vZVgugdvsr9gMCJSE+hzuK8Z9r
 nNdNYfXQejZ4OBM9+KbwtNNOR7eHj5bjOHQseBbkNcGO/7CVRdyI5jdwNeHlmC7+qMLr
 Ru4w==
X-Gm-Message-State: ABy/qLYzyz5uAPURT2NonlEwrkhnhf46HjF0eH9tJnDijDjo2hMrAs52
 v677lhDcSfkhEcqMO/kXCd2GhJvZN6iGHOb3C6EYcQ==
X-Google-Smtp-Source: APBJJlG5MMZ5YgHM/aGPzZsl69xr0mphe7hRarmUaOoRDpmrvDR2fxeoCO6exe66Ay37Km+ZXahJFQ==
X-Received: by 2002:adf:e285:0:b0:314:11ea:480d with SMTP id
 v5-20020adfe285000000b0031411ea480dmr3544867wri.9.1690034796326; 
 Sat, 22 Jul 2023 07:06:36 -0700 (PDT)
Received: from [172.20.15.195]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 w10-20020adfd4ca000000b003140f47224csm7029578wrk.15.2023.07.22.07.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jul 2023 07:06:35 -0700 (PDT)
Message-ID: <d433a38a-ffe5-fb2d-faa4-6b537aecfdf9@linaro.org>
Date: Sat, 22 Jul 2023 15:06:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] target/arm: Special case M-profile in
 debug_helper.c code
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230721143239.1753066-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230721143239.1753066-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/21/23 15:32, Peter Maydell wrote:
> A lot of the code called from helper_exception_bkpt_insn() is written
> assuming A-profile, but we will also call this helper on M-profile
> CPUs when they execute a BKPT insn.  This used to work by accident,
> but recent changes mean that we will hit an assert when some of this
> code calls down into lower level functions that end up calling
> arm_security_space_below_el3(), arm_el_is_aa64(), and other functions
> that now explicitly assert that the guest CPU is not M-profile.
> 
> Handle M-profile directly to avoid the assertions:
>   * in arm_debug_target_el(), M-profile debug exceptions always
>     go to EL1
>   * in arm_debug_exception_fsr(), M-profile always uses the short
>     format FSR (compare commit d7fe699be54b2, though in this case
>     the code in arm_v7m_cpu_do_interrupt() does not need to
>     look at the FSR value at all)
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1775
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Not sure exactly when this assert() got in (probably in the
> semi-recent refactorings for realm support), but it won't hurt
> to backport the fix even if the older QEMU doesn't assert().
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

