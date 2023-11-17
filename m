Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 725877EECEF
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:47:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3tYr-0001HF-Oc; Fri, 17 Nov 2023 02:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3tYp-0001Gx-6S
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:46:43 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3tYn-0002L5-Hw
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:46:42 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so13035735e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 23:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700207200; x=1700812000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SjTbaOA4C39s4izikzPkH+Nc0WjuS9ts0B0tWc2pMfI=;
 b=DXVPoo9XQ2N4NFAqoM/4LLXUxwp46DPeNdihbkosi5D0m7/5hjmqCEGDegJVTetkuF
 mtWgroQNjMoFnxRdWmjVNbP14uP3xQl57O/zZLc+nVvu91bwYQyBXbXf5y1LR7o00C3H
 rMkQNWRR2iO2kfT4PBb4Ge7DEdarm0eaR7Ocz4lEKvgD76t0SCXd1HqUel1YNOVpga5E
 3ieXL+2X1TMpFTSgoeSdwHg8GTrOFZ1eLxN3GpiTWr59F7yNsLDQtcG0aeRLYDxjp20F
 opyPTwhLU9r0Jm4rX8xOAjU7RXB/c1Sp9iiYFF/5DgMFAxLDlqZ2iv8bAB7crjv1720h
 b2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700207200; x=1700812000;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SjTbaOA4C39s4izikzPkH+Nc0WjuS9ts0B0tWc2pMfI=;
 b=Fbgx7A87BGa6wJXvNXqlENhDBYKk3spCSIqJOD/QP/MlIyUeHfC/Ym8qYw/DqQEggo
 SgxfCtbvkg+R7Cqfbl7jnz4ibO9ftiFjrI6BTyrTStAlB9KLiw0qEGQNCQ9ANO5fh57m
 BrXNvTeFYiTfMWy7uDNJKwx5Fw1Ii+JRnolSEENQ33GHQzS7dkhestYy3uTnV9S3B7ed
 iWYZpKz3dvcFtHmvi3dAEwhzYpmF3Ge8VejWUhC06L310hmlMyxEfad6PDSQb8eAF2aF
 9Qgr6D26UVEVBLokSSnTf7o27AJzzGdBMwfHnpQE/nv3Skiko1L4TNMJVDJO8s6lFmnC
 gbzQ==
X-Gm-Message-State: AOJu0YwajzC1IUT8SQjXuJ4lXUdzyNkVjEmeSEjcB+lYLuN35eaDvrc6
 XE9/ETkMerjCY9BdFfRrLDGzx8sR+OUO83xzkuA=
X-Google-Smtp-Source: AGHT+IHnk25heXF0/y1/Q9qSJjipK07GUzW6JhqpyPH0wOeKDXL0XW7KqRLDzrzclQh9yuqRrswHQg==
X-Received: by 2002:a05:6000:2a6:b0:331:462a:e6e6 with SMTP id
 l6-20020a05600002a600b00331462ae6e6mr14190300wry.43.1700207199900; 
 Thu, 16 Nov 2023 23:46:39 -0800 (PST)
Received: from [192.168.69.100] (bd137-h02-176-184-46-187.dsl.sta.abo.bbox.fr.
 [176.184.46.187]) by smtp.gmail.com with ESMTPSA id
 dd11-20020a0560001e8b00b0032db8f7f378sm1479284wrb.71.2023.11.16.23.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 23:46:39 -0800 (PST)
Message-ID: <cbd8f4e4-351c-442c-9ddd-a2a8505a7232@linaro.org>
Date: Fri, 17 Nov 2023 08:46:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/35] tcg/mips: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Richard,

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/mips/tcg-target.c.inc | 41 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)


> @@ -1053,6 +1071,14 @@ static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
>           tcg_out_setcond(s, cond, ret, tmp1, TCG_REG_ZERO);
>           break;
>   
> +    case TCG_COND_TSTEQ:
> +    case TCG_COND_TSTNE:
> +        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, al, bl);
> +        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, ah, bh);
> +        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
> +        tcg_out_setcond(s, tcg_eqne_cond(cond), ret, tmp1, TCG_REG_ZERO);

Where is tcg_eqne_cond() declared?

> +        break;


