Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7631D720DE0
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 06:53:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5JFM-0004uL-8u; Sat, 03 Jun 2023 00:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5JFK-0004rS-CK
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:52:10 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5JFH-00070p-R0
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:52:10 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b065154b79so31574255ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 21:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685767926; x=1688359926;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3W4i4KifsABVRtFEVcMY640JUjNy0jYfJZikFZ/tcJ0=;
 b=qfASgxqKKQX9jefKSYHreM77izTkZM4XW7o+6NL8QBebYwHqvORTEqb+UGJOwEnM0h
 Y6trRhpQdvNRmOjwmbI2z+e4EpaN4CIjopYnXW/eFoGww75uZoyZ2EcvpsKYE9W4K894
 94bUDW656fNCrfxwSFI8uNmBVL44dHBHhzX3RE3Mv1Z7YLWqUfmrf4N9AfDtnXe6DKwk
 4zBP2wwHJUu4kkMCuztpMMLLwr1Te/ejyAtG96WcmU+4m/hbLXL7IYTpB7x4CWIeckZZ
 2fyUcpFAHcbKdwvxTwI4YtyPPAAUfJbYxUytrsnODkMMAjQAqvEBzhBtYwE5fbPZqiPM
 PYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685767926; x=1688359926;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3W4i4KifsABVRtFEVcMY640JUjNy0jYfJZikFZ/tcJ0=;
 b=TUF5jhGMl1JshOTzcNV2UJmjdA7eAn4uSNOqzgf1FCEuxfg+9+ctOMLJ19QJ0LpgjX
 nQttfxS9KP2wFaTR2QSqkBkbAebEO3nYK5Ix8eMZs9lRBtmmR4+hMCqgYk0GcItGKJl6
 eI3hRTXN/GIqpsRhbYBFwVqAVX7l0Xb7JkrY5P15YYUlRn49F4y4DmoAZQKhIvE+TBIs
 14QVyVMX3UOJd/y/OrfrkkC3S9y63CZakIcslBHWnwF9VmiXhwDXt1NYejwMBfUIwxYN
 AM8/KGgd5EMlsOgpGYnmbgwIFKy0Tx4xu3Br0yVoHg+3v5l+7xPpAkkVIgNMiQieokF0
 xByA==
X-Gm-Message-State: AC+VfDzWrwSOWGS8cn3aiFXQaYr7DBJ+Qu4atnmMNwbiaey2WQV+eKKJ
 CWF9uz1uGpkScW8iA66AM7Evog==
X-Google-Smtp-Source: ACHHUZ6gDIq277lgk+3Owql7uq+GuhQ3l7RQzteGQ2JoITzm0gBBUhzGt2bgMRsRI9v8OBp+EIZCQQ==
X-Received: by 2002:a17:902:ecc3:b0:1a1:d54b:71df with SMTP id
 a3-20020a170902ecc300b001a1d54b71dfmr1943824plh.0.1685767926020; 
 Fri, 02 Jun 2023 21:52:06 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 iw13-20020a170903044d00b001b03213eb7bsm2164095plb.301.2023.06.02.21.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 21:52:04 -0700 (PDT)
Message-ID: <87f06ed0-3ad2-6b14-6819-03a35e179682@linaro.org>
Date: Fri, 2 Jun 2023 21:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/arm: trap DCC access in user mode emulation
Content-Language: en-US
To: Zhuojia Shen <chaosdefinition@hotmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <DS7PR12MB630905198DD8E69F6817544CAC4EA@DS7PR12MB6309.namprd12.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <DS7PR12MB630905198DD8E69F6817544CAC4EA@DS7PR12MB6309.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 6/2/23 14:43, Zhuojia Shen wrote:
> Accessing EL0-accessible Debug Communication Channel (DCC) registers in
> user mode emulation is currently enabled.  However, it does not match
> Linux behavior as Linux sets MDSCR_EL1.TDCC on startup to disable EL0
> access to DCC (see __cpu_setup() in arch/arm64/mm/proc.S).
> 
> This patch fixes access_tdcc() to check MDSCR_EL1.TDCC for EL0 and sets
> MDSCR_EL1.TDCC for user mode emulation to match Linux.
> 
> Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>

It would be nice to define the fields of MDSCR properly but either way,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

