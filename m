Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C36273DBFF
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:05:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDj5U-0001wb-RA; Mon, 26 Jun 2023 06:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDj5O-0001tH-9X
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:04:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDj5M-0000B2-EO
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:04:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fa7cd95dacso38343085e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 03:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687773879; x=1690365879;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NJrL3H73Td5szKC3TKyW4me1mspfT6LHEi0s8Ou6Bjk=;
 b=JA5BGkuny1/MNf3tWAbTP5rliiiqWHdVttQDSSSLjjWTP47GYDGN2YWRAcBmwtJhe9
 CEUCkxeRuvPp60cjtASzQnuOEOwiyNpiU02Km5LFEx/RShfCXUQ+qlaP2jN7CY6dDqUd
 xFd2HKWQ7T3c2brJ8xwPYzDOlMh53Kr9o5QYPFrgVWzr1rJq/acL2pM2qcfoQFoVyNvI
 SeKEs3yKvg4XLQ+S2H5lNSJ59PVza+JwBPsOxUs2oaDy84wkB2iUSlsj369Uj5gLLsrF
 +KnUCPAilFc6SYIwJVgJlpUb6mj0k3gD7CcuW8ptjkMduLtdWuRhsk3xLZQA+y3FVddF
 kMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687773879; x=1690365879;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NJrL3H73Td5szKC3TKyW4me1mspfT6LHEi0s8Ou6Bjk=;
 b=jlJD0ueyOR2Vn129tdrIEDr8K89B5AZdnTDgQtsyeDc5y6TF/d7ElDGlzscCiDTaU5
 toFvi18jnKDLhls3aAe1bAMnqJlOX5AbxCiGVs0TmPu6AkuSRE/tG2qhqg2xk2pmSNbi
 /lhHCz/FZDmIiXFPfyMlWMvWT2J0dUoK5aRLxfePFn2lB4g2rh2St96B2nlI1OAMpnjA
 eqc2BhnqKAZxf4BeHX9nLM84gbKS9r54eo4swzj303v78JYLw2Bhy5kivy1fq5GbgDA5
 eJk4UjwPLD8rmDeJ0Jl1I8MsuhOQrkNZ36eZ8LUJAoBRfHrT3XvkT+nCupfFHmOdit39
 wNxw==
X-Gm-Message-State: AC+VfDwcq9KKuSopKCwQ5rwNX8LvZLGIawv17qQd6gfvwkCSueEDHlZ6
 Hgo927qivyBhQ9JrMG3KP3P54iYryltBGGfLNbYpLyqY
X-Google-Smtp-Source: ACHHUZ5FCfvbpHRzlCzNUSBtKZKMDYoaZZK3r3HHDz8S0QdcfCsG4278z9Bz90L+66DtnkR3BZ+B9w==
X-Received: by 2002:a1c:6a0b:0:b0:3fa:72ce:25a8 with SMTP id
 f11-20020a1c6a0b000000b003fa72ce25a8mr9684177wmc.33.1687773878823; 
 Mon, 26 Jun 2023 03:04:38 -0700 (PDT)
Received: from [192.168.157.227] (141.pool92-176-132.dynamic.orange.es.
 [92.176.132.141]) by smtp.gmail.com with ESMTPSA id
 25-20020a05600c029900b003f42158288dsm10097331wmk.20.2023.06.26.03.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 03:04:38 -0700 (PDT)
Message-ID: <1a12ad74-ef39-6669-12e4-6defd9807ea3@linaro.org>
Date: Mon, 26 Jun 2023 12:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] target/i386: ignore ARCH_CAPABILITIES features in
 user mode emulation
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230626083317.144746-1-pbonzini@redhat.com>
 <20230626083317.144746-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230626083317.144746-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/26/23 10:33, Paolo Bonzini wrote:
> ARCH_CAPABILITIES is only accessible through a read-only MSR, so it has
> no impact on any user-mode operation (user-mode cannot read the MSR).
> So do not bother printing warnings about it in user mode emulation.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

