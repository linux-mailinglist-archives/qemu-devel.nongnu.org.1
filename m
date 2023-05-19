Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E52709AB6
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:58:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01WQ-0007C6-S5; Fri, 19 May 2023 10:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q01WO-0006vT-3f
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:55:56 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q01WL-0007pE-JP
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:55:55 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d3e5e5980so438918b3a.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684508152; x=1687100152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FN4aSqNn3UXjSiBjzXh4KZBQGq8xhbefpqTUEFY07sk=;
 b=k46E0wswExbTnEmTGKu1MtV4ynXkuIeqCA9S8RbGf/elMTV/DzJUtofU4aur7BB03f
 9sKoUVCSz61Ju62Ez09pcDCBaXwkCIapVXWh3S9qV9hy5LH/wMZgl+KFBpr1UoqCIFmP
 TAFAg6QpiFlR5TXmkxhUGgb/2fRjUsEAeYyDy+4gJsUGM288A+nl7li2a6etekdVOSE3
 wo7GUQFWDmRZp582h9bLHNa3m5MBtLE7xsMjuiy4XwrEhZEIf3G5kpDk1JsKFMti/XET
 pPjqLKC1TU4hAaXvxF/GJ2LF7pm1jw6LVN0vPR6UZbl3ml58tmk8nE3c99pfoY2Gbh9D
 A6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684508152; x=1687100152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FN4aSqNn3UXjSiBjzXh4KZBQGq8xhbefpqTUEFY07sk=;
 b=CXVZAY0HgsYvnWogtLNwDdivUkN7GY1djRsWj7RNFSWvf1WXRnmKnwLSVkN8z7W7yx
 Gb166wJH7g5Zbh3BqIW1x/Vpd0L2FHRVJskq/hulYFPymMcKEfMG7G7jx65lo1TfZ7cE
 yvgpAqEYE+kCr2mrgTa/BrinrSuhUbQcsJQtHiaEKrjxM0Ci50K8/dighXn4MSijhX3L
 PGhQFJX/fd08MHAMWIRWALrg0bHZXJC27mmoesjs2nouR1Zt44cYkrLzxOR+YsaRZjnJ
 FZ8Azu6XFaovfV/DrNNOkwhhWHbSvu+Vg8NB7DZIwRcSxJTUQ58A10RM1Nj3FenVQ1l9
 oiyw==
X-Gm-Message-State: AC+VfDyUKRFR8sMnIwj/hE2/Xrsbr2mkZLkB9R3GTDOJbLXi4TWPWR5Q
 aGaXU/ZU6XpFIItgo9rt9DVuIQ==
X-Google-Smtp-Source: ACHHUZ4xE8fJ2qmeI9lr0ntyX3QoiF1+IqSGclppCPbVQn6CUHdwrHavVBpVt+IYm/D6eRDEtUEnfA==
X-Received: by 2002:a05:6a00:1505:b0:64c:c5c0:6e01 with SMTP id
 q5-20020a056a00150500b0064cc5c06e01mr4045017pfu.31.1684508151767; 
 Fri, 19 May 2023 07:55:51 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:686f:d1bb:8fc4:dc38?
 ([2602:ae:1598:4c01:686f:d1bb:8fc4:dc38])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a634545000000b0050be8e0b94csm3111455pgk.90.2023.05.19.07.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 07:55:51 -0700 (PDT)
Message-ID: <1e87fc3b-ed31-ee70-01d5-0df52237ec70@linaro.org>
Date: Fri, 19 May 2023 07:55:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 00/44] Hexagon update
Content-Language: en-US
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, bcain@quicinc.com,
 quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com
References: <20230518200411.271148-1-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230518200411.271148-1-tsimpson@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 5/18/23 13:03, Taylor Simpson wrote:
> The following changes since commit 278238505d28d292927bff7683f39fb4fbca7fd1:
> 
>    Merge tag 'pull-tcg-20230511-2' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-05-11 11:44:23 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/quic/qemu  tags/pull-hex-20230518-1
> 
> for you to fetch changes up to 9073bfd725440da0af44f1ee1e3bcf72e9de39b6:
> 
>    Hexagon (linux-user/hexagon): handle breakpoints (2023-05-18 12:40:52 -0700)
> 
> ----------------------------------------------------------------
> **** Changes in v2 ****
> Fix break in 32-bit host build
> 
> This PR can be broken down into the following parts
> - Add support for new architecture versions v68/v69/v71/v73
> - Short-circuit writes to temporaries when packet semantics permit this
> - Move bookkeeping items from CPUHexagonState to DisasContext
> - Correct '-cpu help' output and handling of unknown Hexagon versions
> - Enable LLDB debugging
> - Miscellaneous fixes and improvements

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


