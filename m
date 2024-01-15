Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A598282D690
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:00:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJk8-0000XS-Cm; Mon, 15 Jan 2024 04:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPJk5-0000Wv-EH
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:58:53 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPJk3-0004N0-AC
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:58:52 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55783b7b47aso9053666a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 01:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705312728; x=1705917528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ylsUC7GYBQVtxrDwJNTaFIBmR8FEQVu7iqF8zS7u1ns=;
 b=HexGSbHVQI1+ACS/3WSb8asvP++UpyK2ta5wE+fKfNqyOQowGhYlAhvq5KBnTEwadf
 lEAEjg1P37iPAIIQkJy0lvwbAKjA/lNnwnvnD1VAbcWCYtkTPghZ48O7ZO9OSndWiMrq
 FNHVdMOxnB7/nh9/Mypb8rNWd2O8y8A4skYSiIrLzPS7oMypzjIL/woku06pLcqlx1Ms
 uCtb7o2dFlC/Mt6jCHzPpCUZ3yXrG10Y+gY1Z3H46inu800EreFPpKXsHzkiT+mTZag1
 18+5B4errSiNcVk5INAK18gVBnFWrr4Lec8oXSe8dehzBMf3ItupBHGRsekkuDFPOhmr
 7jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705312728; x=1705917528;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ylsUC7GYBQVtxrDwJNTaFIBmR8FEQVu7iqF8zS7u1ns=;
 b=w7kUTmDDtYKlmR/ORI9UFw/mpsw9c6haXfuNGjcu2edB05ok2numshdGySp9GEKvMP
 OxsOGIqBeEtE5DK3ZUiHhKHJ5pMk2CweA1zwyHCp7WeRJ0kfANXF7sx1CBL2f/dnksih
 cCQuVMtUr6xsGWZpPcr4QuFN8lBDmaYDAbTwD3b1KObaPvVbgyyyUPj/mM5msCE4lP5a
 Q2RkEr+sMSgkcUsHMD0Ch3tW1Ckj2yJS7tdD7nCV3pVRnRZ07ow4vDl0nF5fDxkfvhwa
 rbAw7pRSERfKbA88dIjoFW8fqMatnAEx6ytcTHc8oy/ek0lkTwWhRdsqnpNpTkh86goE
 15TQ==
X-Gm-Message-State: AOJu0YzPP5BlZhGEwKk+235m55J03VBsrZyHoH1vPW461OSL0LlXrNMD
 OJAGVPF3+6ffxxpqWib81XEV0I+WLR+6Dw==
X-Google-Smtp-Source: AGHT+IFCPszdV6VGgFnBDPnxoL3veVi7sr3Dam6ZbrtLzBQGX7NPTPbkWd5gHjrkHBMFOdGoPPABjA==
X-Received: by 2002:aa7:de17:0:b0:559:54d8:df1e with SMTP id
 h23-20020aa7de17000000b0055954d8df1emr400347edv.35.1705312728442; 
 Mon, 15 Jan 2024 01:58:48 -0800 (PST)
Received: from [192.168.69.100] ([176.187.209.182])
 by smtp.gmail.com with ESMTPSA id
 cq13-20020a056402220d00b0055946388052sm1195390edb.43.2024.01.15.01.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 01:58:48 -0800 (PST)
Message-ID: <a9f4e624-01aa-4d8c-8fe6-991185402e22@linaro.org>
Date: Mon, 15 Jan 2024 10:58:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/riscv: Fix sizeof_reg typo in vdso unwind info
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Vineet Gupta <vineetg@rivosinc.com>, qemu-riscv <qemu-riscv@nongnu.org>
References: <20240112220348.49021-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240112220348.49021-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 12/1/24 23:03, Richard Henderson wrote:

Fixes: 468c1bb5ca ("linux-user/riscv: Add vdso")

> Reported-by: Vineet Gupta <vineetg@rivosinc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   linux-user/riscv/vdso-32.so | Bin 2900 -> 2900 bytes
>   linux-user/riscv/vdso-64.so | Bin 3856 -> 3856 bytes
>   linux-user/riscv/vdso.S     |   2 +-
>   3 files changed, 1 insertion(+), 1 deletion(-)

