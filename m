Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F04447409D1
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:48:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPuT-00007v-SP; Wed, 28 Jun 2023 03:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPuR-0008VD-Al
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:48:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPuP-0004to-Dx
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:48:14 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-311099fac92so6838628f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687938492; x=1690530492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jJN4Suhhvh/vNEWWIgV42qpuvIadtPahvACBQkU1+rA=;
 b=pFSI3KiscKQ/4U51qSHXuelxLFpcEHajHu+ISdFhR//FIwcG6F+YJZ/rhJqlRxS4LS
 +aV74BbpoeMtuxaDZLjFUHaO3CtOogItFqkjcxDBa+LzV/Qm0Wwdoxbn0R/P0wTFcRY8
 sHdr/O5KF0ONe59chcnJF9lve3K9ULvw9ix0gxgU5ajLgsRw9xrwlPM6MllxyTeqdR9D
 u1z70P/09mbcccG3LN7ytCfYyuM91omzRRqt+IakJSAwcJRjWdI/onVecEt0QgXbbD5/
 FbRyljCqVlFJhrbAXcY/wLUXAWYj+c4A+uQqZDTGIhXp3LzAmENfGDguTEONqPiiSXHH
 S7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687938492; x=1690530492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jJN4Suhhvh/vNEWWIgV42qpuvIadtPahvACBQkU1+rA=;
 b=ZDRCKhGDGEG5MWGsn20GeKfX6qM2NKzrcpcHhdcDtp8FDakc9ymwf7gk725wAb/wfo
 5QHyy44D3enFtvtOoQo2Qylrm88gwpAySCYvCgSxtuqb6ko4HHMpneITuDtDZe4Sj36s
 iD873nmiZ5KwYa8c8LB5d7PAoBbtvNLjxNtXTkVS64hLpYLIodsNsiXTm7opLDx9HApQ
 peFn5RdDQoGlWYW6BMON/y9pO4uyi9NjVA5AvPltJj74F2n+f5Cgz1uqb3bG2+jqM2Tv
 MgmCGi1O6WYHs1EzMQ453IG3DlkfuovUG4n0vYYj6UWCsoB1b3dJvWOIbB8Nt/ZP8oZr
 9Tuw==
X-Gm-Message-State: AC+VfDxiiFHw8Jv3GAy3Rbqhn05gqT2J0JLcLNBp97Rq7AhVJSdspMWv
 yKIW7wxAeF5gKR1MfBqst6vXfQ==
X-Google-Smtp-Source: ACHHUZ501p1B3gcKWeJ3QS6fjsCrecUx1ouGyskO3KrWHQNiNp4ByRmXtKCG2Jeh/MJSxoBZ0UgV5Q==
X-Received: by 2002:a5d:4910:0:b0:314:144:adb2 with SMTP id
 x16-20020a5d4910000000b003140144adb2mr3294257wrq.5.1687938491780; 
 Wed, 28 Jun 2023 00:48:11 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a5d4f8b000000b00313ff56eaa2sm4023878wru.20.2023.06.28.00.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 00:48:11 -0700 (PDT)
Message-ID: <747bf8a9-355f-b84a-6e0a-a10c5ea28395@linaro.org>
Date: Wed, 28 Jun 2023 09:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] target/riscv: Only build qemu-system-riscv$$ on rv$$
 host
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org
References: <20230627143235.29947-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230627143235.29947-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 16:32, Philippe Mathieu-Daudé wrote:
> Per Anup Patel in [*]:
> 
>   > Currently, we only support running rv64 guest on rv64 host
>   > and rv32 guest on rv32 host.
>   >
>   > In the future, we might support running rv32 guest on rv64
>   > host but as of now we don't see a strong push for it.
> 
> Therefore, when only using the KVM accelerator it is pointless
> to build qemu-system-riscv32 on a rv64 host (or qemu-system-riscv64
> on a rv32 host). Restrict meson to only build the correct binary,
> avoiding to waste ressources building unusable code.
> 
> [*] https://lore.kernel.org/qemu-devel/CAAhSdy2JeRHeeoEc1XKQhPO3aDz4YKeyQsPT4S8yKJcYTA+AiQ@mail.gmail.com/
> 
> Based-on: <20230626232007.8933-1-philmd@linaro.org>
> "target/riscv: Allow building without TCG (KVM-only so far)"
> https://lore.kernel.org/qemu-devel/20230626232007.8933-1-philmd@linaro.org/
> 
> Philippe Mathieu-Daudé (2):
>    target/riscv: Only unify 'riscv32/64' -> 'riscv' for host cpu in meson
>    target/riscv: Only build KVM guest with same wordsize as host
> 
>   meson.build | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

