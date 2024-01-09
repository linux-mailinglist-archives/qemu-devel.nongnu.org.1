Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD2E8283A1
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 11:05:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN8y7-00084H-6p; Tue, 09 Jan 2024 05:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8y2-00083S-AP
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:04:18 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8y0-00087d-IR
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:04:18 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9b050e88cso1165835b3a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 02:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704794654; x=1705399454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SyFkUwihui8zlp39SsY9lEMIJM2wa1dwRzJAvypV2jM=;
 b=ZKqdVG2Ry7wxLj3pQ57wlZqGGVjSU4+1dXhWIkepy7PK3TxILJgVvPFxmUsH8bsqJI
 SrS2rKu8MonsHe1XdwhXuybi0Q2rxgWdFoXyLau0jn42CnxqiBG69JbvpPQII9jIcNWW
 NsoxUj27ISp1+UzHiFwfmNHlNaRPfV80A7ThhMa+s0BnPzjKJtnZR7NJf83OHeAET/Dg
 acDYpxTfHC7GiximPoTIP7ePl0eydAjg+esVPSQFqr0E8TmL0duZrryU2Skud8tzkN1u
 zQSKXVogRb/gOzFp2udQinNV5vwNXieOmIDmqkZNHexfsWVL5bpBG6MOGRfXiFG/JdFO
 DqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704794654; x=1705399454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SyFkUwihui8zlp39SsY9lEMIJM2wa1dwRzJAvypV2jM=;
 b=VRiiqhg/1+QSSYdK3xl881Sysqz5mW2c3Su15xVHTliAjwOvYWdIayumW7wrIAKqrU
 4Syken/0TtW/02pMYmSoSfU206z1e3IGMVe8e7i9Z30rvMQ03JvXF9yJ8KMs6V4KdoAy
 tqUtmos32FKv2wwvY1MEeXzfKs/ODZXaNtHpgsfGxAC3qQQDifKZvb42ZkHIGgQRYERX
 Rf/EB87SbWSWfyRmaUp2GSSe7qrXBJUHOBauApK4+3lNEx6uyoqjop4nX2CIrg/8OTj7
 y3N+QuI4Sxw1nCEa5xAhr/jacP1N7PN5mCQWwqh1EcjcWeliZkjXQtyOKrMROdq02Kz4
 9TDA==
X-Gm-Message-State: AOJu0YyE739HUaVY7pyG51tljtS4vQIQDLuCiYU+WLi9dUwcoIeHnv65
 I7qdxjxKMRZOZt33PTPWkSHQtVJjl56wVA==
X-Google-Smtp-Source: AGHT+IHK9vV8osK7IrrJB43LioVX2ftWi800G+0z8ou1Yqikn9AiBMfZfQluG3X866s9cFtHD1R9Bg==
X-Received: by 2002:a05:6a20:6325:b0:199:b49f:4024 with SMTP id
 h37-20020a056a20632500b00199b49f4024mr1454468pzf.83.1704794654608; 
 Tue, 09 Jan 2024 02:04:14 -0800 (PST)
Received: from [192.168.40.227] ([172.58.27.248])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a62d143000000b006d9a42f25b2sm1335766pfl.201.2024.01.09.02.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 02:04:14 -0800 (PST)
Message-ID: <84ce492e-3b8e-4199-a277-8f9defa27b6a@linaro.org>
Date: Tue, 9 Jan 2024 21:04:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] target/hppa: Strip upper 32-bits of IOR on error
 in probe
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-6-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240107132237.50553-6-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/8/24 00:22, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Limit IOR to the lower 32-bits on failure.
> Keep patch short for easier backporting.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/op_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
> index 7f607c3afd..60c9014242 100644
> --- a/target/hppa/op_helper.c
> +++ b/target/hppa/op_helper.c
> @@ -353,7 +353,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
>       if (excp >= 0) {
>           if (env->psw & PSW_Q) {
>               /* ??? Needs tweaking for hppa64.  */
> -            env->cr[CR_IOR] = addr;
> +            env->cr[CR_IOR] = (uint32_t)addr;
>               env->cr[CR_ISR] = addr >> 32;
>           }
>           if (excp == EXCP_DTLB_MISS) {

We might need to export raise_exception_with_ior and use that.
ISR needs adjusting as well for hppa64.


r~

