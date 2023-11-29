Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5897FDFAE
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 19:49:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8PbY-0002yN-8Y; Wed, 29 Nov 2023 13:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8PbW-0002yC-TB
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:48:10 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8PbV-0007Xg-Df
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:48:10 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b8412723c4so52276b6e.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 10:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701283688; x=1701888488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=El9pvocyNav9Deg2XPp3FsGgfbgcxii3OR6oYcaJ0wU=;
 b=s9dyRZk62G/izBgyXx55W+XjDUP/r+ztoHqGO73bRvNgIucAJA5C7NTUOsL2gfBXhD
 Hw28L+Y1Kflw1GfRkv3p5s+80aoHEvYJd2T5Kp4KBki6tTom1btDrPO6tt32VMlXdERP
 JE2/kaS/79FGvR/M/K7Z7a+XHCkz5zEx+WM5HhOUW0jfNLWPKCmhRGaXRdYlxNy0TfSO
 rCdOFS0H+Rc4DhiCnaAhANN/ltBj0wSGISh7ku+ag9E/k6dr5pc9V51HyEQLhGwEptl5
 mlHmfQrMo2qDMQNqVjLy9RyldEam2x3WSo1K4w6ymy0iQE+vEiqpIt4w9WrJusZSnh9A
 mnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701283688; x=1701888488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=El9pvocyNav9Deg2XPp3FsGgfbgcxii3OR6oYcaJ0wU=;
 b=TYJ0egsh3Fro62TWWXICyXvAyzDjsblS2sFTkv3TMVtxF3x80txYBZ+XTVsupA4l7a
 quxKDOjfgEo0kIW0EKeGvWbxgHkZO+NRH8vr9Hr7wK2vA6KW5dhdfMgZ8ks75goXPfHy
 HHiV++PFY8QR/lGVPntv/YL6PTR9fXGa4pFh8NGhbV9zEhWUtSOwsjoJKNM+3HGdD6Hy
 opxyZ1ZP54FUH1NcsjszShOV8cx2ARgGfpS6fZEJwBNBxLqX7HV90jHi2HI5G4ruCz3R
 rpKVBIav0MmsRvjCyQbLSqhcXeA9w332kkyHZzN9Q6bXq0bI8L6+TzNdsc26+oCGMIeu
 7Bmw==
X-Gm-Message-State: AOJu0Yz8zziCLvoW0ab1ak2VLaSofwzL9rDPAFzAdADgseEgPipA7CXh
 5aWLwppTVWiHgGz8LsW46chvYw==
X-Google-Smtp-Source: AGHT+IGFlmhbUZb3OPQynuBsubsK7AqmLhob6RomLKASYGDPwo+fo4s5DBEWMhXVKHqFEA+h0nTxAA==
X-Received: by 2002:a05:6808:1898:b0:3b8:983f:4469 with SMTP id
 bi24-20020a056808189800b003b8983f4469mr2768515oib.8.1701283688315; 
 Wed, 29 Nov 2023 10:48:08 -0800 (PST)
Received: from [192.168.174.227] (rrcs-71-42-197-3.sw.biz.rr.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 j6-20020aca1706000000b003b84aad737csm2362188oii.8.2023.11.29.10.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 10:48:07 -0800 (PST)
Message-ID: <75c6480c-0716-418e-b453-468b2cbef0af@linaro.org>
Date: Wed, 29 Nov 2023 12:48:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/cpu: Update description of CPUState::node
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20231129183243.15859-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231129183243.15859-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 11/29/23 12:32, Philippe Mathieu-Daudé wrote:
> 'next_cpu' was converted to 'node' in commit bdc44640cb
> ("cpu: Use QTAILQ for CPU list").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 134ecb907e..3208b938f7 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -430,7 +430,7 @@ struct qemu_work_item;
>    * @gdb_regs: Additional GDB registers.
>    * @gdb_num_regs: Number of total registers accessible to GDB.
>    * @gdb_num_g_regs: Number of registers in GDB 'g' packets.
> - * @next_cpu: Next CPU sharing TB cache.
> + * @node: QTAILQ of CPUs sharing TB cache.
>    * @opaque: User data.
>    * @mem_io_pc: Host Program Counter at which the memory was accessed.
>    * @accel: Pointer to accelerator specific state.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

