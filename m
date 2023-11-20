Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 764177F1831
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 17:09:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r56p8-0007pN-Mz; Mon, 20 Nov 2023 11:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r56p5-0007nc-Ta
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 11:08:33 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r56p4-00062j-7G
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 11:08:31 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c6b5841f61so47388971fa.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 08:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700496508; x=1701101308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=spY+bVUctbutBFaAWliQ/V61LM81iYfTCR6LfYrcRI8=;
 b=EGUtEXa1Qanh+NhfZ1n8cANciZGW4Cpu6ZnzQp63/4LIFmcGlF61Qc+bPe4p/HSGQ+
 wF7LJnISMCDl7CvmahvBqS/3pMPbbMee5tEwX+etx3PyBEpOeutIu7FSm31Jqe7L2/DB
 EVw9esgw3XVfDWv+R2ZQg8DjZ+SyZ3H+Qu/TJigwoql7kokrpT91wNQko99uWOjZNv9W
 u8vShho9c7dEeehdfScd2rAg7NIB5V3YLVvfNq+dAgU0s6jcn1hV5skW4f5mMmqIni0V
 6XSxWcSfn0b8bVR8x4/gWoG/USaXoZXrf93HBojKbtyq0Ojd/h0S/ub9tnhJ7E+1RU/k
 1twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700496508; x=1701101308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=spY+bVUctbutBFaAWliQ/V61LM81iYfTCR6LfYrcRI8=;
 b=p4XgCBEacr2WREP36jkDKS+SA11+iqBciNRPxJtpcwsLgvzVfZa5zeTtl/P7Xn1/Mf
 NjFE+8HPgfng3aAYTErYBB6G8KfYxStmDtpDa4LBTS+rwGjWxn7JBSrKv0CyfxuZnxKN
 TxB6Bc9DDpHUb70arEuxsFm5fsZkYeT4YlX7T43GidxmWBbQGlvJizgOeOB0zUzy6R0v
 jhPtL5gTMnYvoUFYLkl+jK4lB9827YShqnIAMtHTyOzNcu/d8TDyBZGV6q1aBpiWRsp0
 LR+PSRGkZ0nuXs0vcQBiomPO3dmY8uKGU7Adh3Bb0XvO/O7liAAJR7USe5BkKhPJwggB
 ydCQ==
X-Gm-Message-State: AOJu0Yxsiga1/IFua0VIEottreSebjSt71EjZTc1v0/olCtJc4wxskLd
 S+UYUwfFheJSeGLCnvECgv2CIQNoI/JR46+YklYWTg==
X-Google-Smtp-Source: AGHT+IFySzDOE0kHjMAoxnHs6edvyCYqB0iXwv58GDZA8245vkIrIQJREVojfKt5e6Tm/BPBphUvXQ==
X-Received: by 2002:a2e:a367:0:b0:2c8:8479:51ff with SMTP id
 i7-20020a2ea367000000b002c8847951ffmr949726ljn.26.1700496508024; 
 Mon, 20 Nov 2023 08:08:28 -0800 (PST)
Received: from [192.168.174.227] ([91.223.100.4])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a2e994d000000b002b9e5fe86dasm1059373ljj.81.2023.11.20.08.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 08:08:27 -0800 (PST)
Message-ID: <8960014b-9f2e-469d-8e6c-5c44d26c2304@linaro.org>
Date: Mon, 20 Nov 2023 08:08:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2] target/arm: Set IL bit for pauth, SVE access, BTI
 trap syndromes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20231120150121.3458408-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231120150121.3458408-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/20/23 07:01, Peter Maydell wrote:
> The syndrome register value always has an IL field at bit 25, which
> is 0 for a trap on a 16 bit instruction, and 1 for a trap on a 32
> bit instruction (or for exceptions which aren't traps on a known
> instruction, like PC alignment faults). This means that our
> syn_*() functions should always either take an is_16bit argument to
> determine whether to set the IL bit, or else unconditionally set it.
> 
> We missed setting the IL bit for the syndrome for three kinds of trap:
>   * an SVE access exception
>   * a pointer authentication check failure
>   * a BTI (branch target identification) check failure
> 
> All of these traps are AArch64 only, and so the instruction causing
> the trap is always 64 bit. This means we can unconditionally set
> the IL bit in the syn_*() function.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>   target/arm/syndrome.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

