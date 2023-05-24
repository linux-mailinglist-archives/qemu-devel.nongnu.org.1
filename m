Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E0970F98F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:01:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1py2-0006kR-KW; Wed, 24 May 2023 10:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1pxz-0006dx-IH
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1pxx-0006Uw-5P
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:55 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d604cc0aaso805544b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940392; x=1687532392;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ns25hFQv0m873dAstZ8K9TCtQcMZTz3TE3rahAkHoFI=;
 b=zuGGy9x5feHbH4Tcnwi+w3xowMLN2GN7LZkR4iGf/8/EUK//kP4Kn7rq1zmd4E4X4X
 vgFRuKL13G6AhQ/hC3AaroO9+5hPQUjIRp5FVJDrYqk5gwUfvKRUR21Au86kOWoviwvW
 p9YmaxJERe0xXQ1atk4gLBb1jpWpQQmQ9jd34P7zmvywCTlmtxEameXE71P1Ad387C62
 3av1lf/EaHn7XOViJOka8iTrUnxydjAq11paxEcSutY8aEWQd7CfNn8GnFT1FV4NDbUe
 bC240l7cLdNZj01D8A+TR/yZHds+RqWYPDr3G2GybcF4w6MyfXkls4GN34AAMoEcwVrU
 dYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940392; x=1687532392;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ns25hFQv0m873dAstZ8K9TCtQcMZTz3TE3rahAkHoFI=;
 b=YF3v7aD8/P4VFGiaJ5sFTgWQ4N9AHLxKh0ACpiDE2yTxlTYkdRTWfcmrJgxi3czc1O
 lVkIIA0Iu9jXa2rxYKHU1it3ZXqVbiUqekTG8MZxS5OK5P5I5DqWySu46yj++a8fG8Qh
 +CjVn+lIACOc+sjVRiD4naA59yWoApLbFBH2icNBID3mwdNPLcgXh/hsuD+N7X1QTWF0
 Bxhaf++sntIEVs7nwm5bR5yIp2FLfIgpAnlVW58h0rbjLCiYpHFJfpMH4YsqEHRZF1C8
 4FiSSqwMfdCqp74GYWsfn/PcwsbcmlwBk6O6OTyfoTmbM1+HHrKDTCUjcw5jApPyz9In
 sbQA==
X-Gm-Message-State: AC+VfDy6QSw21V5Bpij1ZmVrYVs5bDf87W1VQzXEPE+2mHF/JmIdiQBv
 EtOLMHDk7maoMAGsUW5W0dV36Q==
X-Google-Smtp-Source: ACHHUZ6tjzqKngLi0oBwwzK9ZrX2JGc3RLfw7EIlg4MDAKD4Eb+d5izoDGKJMW3H/2HP2gwh/qodLA==
X-Received: by 2002:aa7:8896:0:b0:64c:ae1c:337f with SMTP id
 z22-20020aa78896000000b0064cae1c337fmr4199900pfe.12.1684940392352; 
 Wed, 24 May 2023 07:59:52 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 k25-20020aa790d9000000b0064d421f0497sm7515771pfk.109.2023.05.24.07.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 07:59:51 -0700 (PDT)
Message-ID: <32ec9373-d095-41d7-6242-90014db9e78c@linaro.org>
Date: Wed, 24 May 2023 07:59:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/5] hw/arm/sbsa-ref: honor "-vga none" argument
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230524102729.810892-1-marcin.juszkiewicz@linaro.org>
 <20230524102729.810892-4-marcin.juszkiewicz@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524102729.810892-4-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 03:27, Marcin Juszkiewicz wrote:
> In case someone wants to run without graphics card.
> 
> Signed-off-by: Marcin Juszkiewicz<marcin.juszkiewicz@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

