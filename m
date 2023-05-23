Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E65270E4A2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:27:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WiX-0006ZX-EM; Tue, 23 May 2023 14:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WiU-0006Su-Vw
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:26:39 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WiQ-0003yl-8C
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:26:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1afa6afcf4fso29950085ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684866393; x=1687458393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eqzu2qtTwaDpNsLhpY9nsNEgwXw1+p71QLaM8jJUVhw=;
 b=DYszNePO4mBQj9WKxm4+1/VrWBEVrSQHZcIXx/Lv1hCaAUz/p1h5DxVcDzHF3fbzou
 HynR1AeJgZpdnd/Y6/uxLC+kvt5Pbtm+Pd77awDN5Hqy8OMpLg1xIJsY5kcAK0BV/VxQ
 a7uqknxUs+nt0cpD7Xthn8JpH93iOCg/WV+XSQM7ilxSO+h9mRRYsaf78SiSPlkjrzbZ
 q9/eK8h71bBVKdKu1BfxOD53CFcSHQRWw2x7Ad3rSwdyRBv2Ep7LCEy1bJ1PlfG9XgtD
 x6Mg0+QU9jEx9GsvGqd1hFEDKC+vNGs/iPXjMCT8VNGWD7NvSWeDqASbjAMH8AwFDF1Q
 8TxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684866393; x=1687458393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqzu2qtTwaDpNsLhpY9nsNEgwXw1+p71QLaM8jJUVhw=;
 b=V5T6lqjTK1Qu3V0A3BOAeuujYvWTjHFwYf5WfE/+3r6pOk/jL5aYxjjGqBne8z8KIL
 cL0s7Mf98S75T1tOQBUGoYVNAbl//Rm1ph5rs6g39IT0fXLAd2JCcPn2b0Shs3ez5jon
 4UiMfuwFomX+ajOZnOQKxHZY02lbU6GDq08LEDuymZjL7BeaOR8Q4EuqACL6FZDN3eeX
 ELcAi/nkrbgcS/s3K4C8hcuoja1MfPPNRVrAtWX4BQvXnZBxSUtAWSNCbWX7pJB0mdpp
 TwOtB6SYQSmIcQJGScIZ2hPSZnRbxgzGdItHpq2J7LezeSBNBDtfg3GhnGbirKy5DW1i
 rhAg==
X-Gm-Message-State: AC+VfDwy9XllICy8ergwTBbj2J0WxIEiinU0IQhuOIOP1pYBl4yOYSE1
 B3xCAvKUwTz93SJPxsEm51YjqA==
X-Google-Smtp-Source: ACHHUZ4pRduN6jyHVyDWHtc1mmKBfvPPAaeYHzqXVJHaR/mhCkQ/ThTraJHwinnyb1qIrpPc8qTR5g==
X-Received: by 2002:a17:902:e811:b0:1af:981b:eeff with SMTP id
 u17-20020a170902e81100b001af981beeffmr13070076plg.64.1684866392743; 
 Tue, 23 May 2023 11:26:32 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a170902d50600b001ac6b926621sm7038308plg.292.2023.05.23.11.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:26:32 -0700 (PDT)
Message-ID: <a3d223e4-5e76-71c7-17c5-b4cbfbf8b721@linaro.org>
Date: Tue, 23 May 2023 11:26:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] hw/mips/jazz: Fix modifying QOM class internal state
 from instance
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Titus Rwantare <titusr@google.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20230523064408.57941-1-philmd@linaro.org>
 <20230523064408.57941-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523064408.57941-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 5/22/23 23:44, Philippe Mathieu-Daudé wrote:
> QOM object instance should not modify its class state (because
> all other objects instanciated from this class get affected).
> 
> Instead of modifying the MIPSCPUClass 'no_data_aborts' field
> in the instance machine_init() handler, set it in the machine
> class_init handler. Since 2 machines require this, share the
> common code in a new machine_class_ignore_data_abort() helper.
> 
> Inspired-by: Bernhard Beschow<shentey@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/mips/jazz.c | 41 +++++++++++++++++++++++------------------
>   1 file changed, 23 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

