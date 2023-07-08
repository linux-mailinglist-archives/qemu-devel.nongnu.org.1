Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA50D74BE93
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 19:20:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIBbd-00013T-C1; Sat, 08 Jul 2023 13:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBbX-0000wZ-E2
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:20:20 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBbT-0004K8-Sb
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:20:19 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-992f15c36fcso398568666b.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688836813; x=1691428813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MxhKU43bs1JHSSm0qPgBg513gg2gr4mB0L87lM7uzVc=;
 b=NTD3TzbcDaBttxDjvzKyx6unCgyI2PJiiG0H1fhXeZbn6ns9mkoMXyA3fTH+w7tfBD
 at6xQQM+H59gLVUJ7QIW94DDaWVe1wjosPOLNgH8SP1kVznH/RbwnQBeYWnRdWBaRUe7
 IDEsIdV/hmab9bNWalqBxoDohyLXhsjNfqo63HRc43v3LDVK6j7myY6zts3JqlOMPRZq
 slYJalyyp+n8vaLENVGQVghABxvdkgw97p00wapbsB3zuNY8G8aXpa9zy51wAB2n64wJ
 YlrHmK6+m0qeCN2XYjdbscQahSGXNiWhr4FZz9Fdz6NC89aeti5Wuet26B7gYjTD5LCl
 A7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688836813; x=1691428813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MxhKU43bs1JHSSm0qPgBg513gg2gr4mB0L87lM7uzVc=;
 b=i/cfbGaigscCfqYjedkJl+scRHF2ZoLesFvi510lixAhSL6sgh0dBav1CMxS4CsGTp
 08U9iHOXjE4aHDcgYx26lBpRuXqqmc/R4Zz+6Getp6WsCiuBI3W6sPKfXnR81fhea43j
 y1FSPhVngdMlnoNu9ZHRYw080ZZxJ9zYJj11R0IFQEPCuA5bZfUvezRY32U30fWFZT08
 GUWs0cICnjgsBIHaePvX7DzdM/v48Zj89i7OHebmy8JxJggW7gT4UyY2+XAbL+Gki9Jh
 cTS0ZYxFXrB/RhOp/KuW12TGQ+H+Td9Zz9uSCtVjA8eTms+ccKM26RovDccZVGZWy0QR
 qFUw==
X-Gm-Message-State: ABy/qLZN12fghqObNiU22trBPbNV0CMRbLZbeolJQdiv8LTWZF6mz4BE
 m4kr2uxo6ZoN+aLQHiNVoDZ5SQ==
X-Google-Smtp-Source: APBJJlGRcACcnrYSfggOoHD4z64BNPNPwszVGAGxIv9UQJ3AKWef5Y/n7FHCovs5+dr5oO6lxBKBEA==
X-Received: by 2002:a17:906:5c:b0:978:ab6b:afd4 with SMTP id
 28-20020a170906005c00b00978ab6bafd4mr6995548ejg.43.1688836813661; 
 Sat, 08 Jul 2023 10:20:13 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.184.32])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a170906925500b00984822540c9sm3760146ejx.96.2023.07.08.10.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 10:20:13 -0700 (PDT)
Message-ID: <8d230498-06fa-c4a7-b461-19dcc047b4ff@linaro.org>
Date: Sat, 8 Jul 2023 19:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 27/37] target/arm: Use aesenc_MC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
References: <20230703100520.68224-1-richard.henderson@linaro.org>
 <20230703100520.68224-28-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703100520.68224-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 3/7/23 12:05, Richard Henderson wrote:
> This implements the AESMC instruction.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/crypto_helper.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


