Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F485724EDC
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 23:38:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6eLe-0001gS-UC; Tue, 06 Jun 2023 17:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6eLc-0001fj-Sk
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 17:36:12 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6eLZ-0006ob-VY
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 17:36:12 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-652d76be8c2so6007226b3a.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686087367; x=1688679367;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nVgjsDUf4qZ2oqtt4qddaEdBqIsvu9xwz4Itz69R6OE=;
 b=bPJQ45CPhc/wQ6HvxlMrqetmAFO9v44uOETA+N2r2cdn8jrwwCoEcLmVJHZUeHfnIH
 JGZitmEsqolVHkXbye0XaQX9UW0xOXIFMOjn40fLBhJwbSqbSaKTPXKGSN4E+iz7mMzd
 hCbPD4uhb0XQtN6svrrDZd68WFXxgoA5rQ8dGlgHsq7n/k45DjfIxUrbQVaUnOafYHHC
 qPb50oIjzQHlvQzdVXNWwbUuUIfJrrSpLqnC1GbUxQXrJ/Q0HkReqlaFTnJEy889S2Vp
 hsWhngl+Z4fVqGoC1iOYy7xQBTAiDN1THGp0LDCw65xWzKIVInfiWhjK6lfqtgmn8W1j
 Gm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686087367; x=1688679367;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nVgjsDUf4qZ2oqtt4qddaEdBqIsvu9xwz4Itz69R6OE=;
 b=ACCwUVvTdr3P6Wii9BW8+xgRBGeljonRSU7XUlqxAgRXGubVu+PBFxipvfuQQZWQf7
 Zu7lJN9Tzqk/+w5OncOMHpN8nzEexxf8E9+Qyi3VLZM++LxfvzEDVO9Sr59bvd1IT7N4
 rr8ABqALVEyeL3umfESAwUHDXejY96ZClOIH/wUB/B1qZdqnI6p+98JOvsSQvQhqOj01
 7zyg7EFBBqcD6dEohmK6KTiNjlzskTn4UL8oBU00tfoHM4hnrFQiSVj+Tniz/If6FOHV
 6AxOnB0QF83bxrDCoPgLVmBU7ih6OLlglgd7qPZFp2TwHL5pthP+SaENXdcr0FPJ98s2
 g1Yg==
X-Gm-Message-State: AC+VfDyJGUvO5kdckv/cYcv5ft3nYrnmdHnGngSBR2Aip71kv7W9J/93
 eSIi1nsOalpk9GEo3DfY7UAK6Q==
X-Google-Smtp-Source: ACHHUZ5IAOoBh4zblNFUYI1RzjtLIE7+kM5CO+2m2IGV5jkBVO82cluF6+AczwAZM2lLE9o3Qy+Sjw==
X-Received: by 2002:a05:6a00:a29:b0:655:89f1:2db8 with SMTP id
 p41-20020a056a000a2900b0065589f12db8mr4157337pfh.16.1686087367121; 
 Tue, 06 Jun 2023 14:36:07 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a62e508000000b00642f1e03dc1sm7417055pff.174.2023.06.06.14.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 14:36:06 -0700 (PDT)
Message-ID: <099c1675-9173-6780-475f-803456ebed7b@linaro.org>
Date: Tue, 6 Jun 2023 14:36:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/42] target-arm queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 02:47, Peter Maydell wrote:
> Hi; this pullreq includes FEAT_LSE2 support, the new
> bpim2u board, and some other smaller patchsets.
> 
> thanks
> -- PMM
> 
> The following changes since commit 369081c4558e7e940fa36ce59bf17b2e390f55d3:
> 
>    Merge tag 'pull-tcg-20230605' of https://gitlab.com/rth7680/qemu into staging (2023-06-05 13:16:56 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230606
> 
> for you to fetch changes up to f9ac778898cb28307e0f91421aba34d43c34b679:
> 
>    target/arm: trap DCC access in user mode emulation (2023-06-06 10:19:40 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Support gdbstub (guest debug) in HVF
>   * xnlx-versal: Support CANFD controller
>   * bpim2u: New board model: Banana Pi BPI-M2 Ultra
>   * Emulate FEAT_LSE2
>   * allow DC CVA[D]P in user mode emulation
>   * trap DCC access in user mode emulation

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.

I queued the reviewed ldst_atomicity.c.inc fix in front of this.

r~



