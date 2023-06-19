Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774B9735BEF
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 18:09:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHQB-0002RO-UC; Mon, 19 Jun 2023 12:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHQ7-0002QX-TS
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 12:08:00 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHQ5-00005h-FQ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 12:07:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f9b23dc270so10487565e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190875; x=1689782875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+zpWvBfPNwZY5Dtg089q2fFN02loHRdVAjbeqy2g/pE=;
 b=J04a85E8AeXw6K3gn9ulVYQ1pXN/mtEQ/tyiZv0p6I/LziHuZE7KM1f72R9Sd1SxY2
 bVhpzRjLEbjfx+kRJoe6S5X//Nu7Zsga7XbTgB+xap8yyox/SX42w/ZYCY9gzYp6QH5S
 Sn3tdU7oIT5GicqPiCYpu6YbEfeAufMp0eQdicCfC0UMF6Zu9PAeMSNVgRVe1IQh8RD5
 KCdX+dEDjosKWTZ7J5kN7W8fFwB4LJqC/riNzenh+QMv6R0aNtmVM0PZQFEY9hStQ4ET
 WnKrYKKWhzUM9OaX7ospNZBjhFErwufmfr/JCDJqk1R6Z/2knIyXmHc//nK9swqtopUY
 Qh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190875; x=1689782875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+zpWvBfPNwZY5Dtg089q2fFN02loHRdVAjbeqy2g/pE=;
 b=DSjDNS6iNjIxPcyMimxIPc4oGE/K5F4by5nG509H8FurtpfZN72si7EkjLinM654Lv
 RFnzcgFer0TYx5SK2jlbSU7kLb/RlDTJ+hqepKAOYcRPXGgAoNwyU94t4HxIFlyvhiHH
 Lbynifsd8aKwxNLP463r2rHZ8QivvvDLgr+n0xSdNffZNLeP26ro24aePjeGVSrVdhYJ
 XHWRC7f3PWfgR+M+15vym8LHQZPerT33p8ThYOCZXmYF/y0ELhdnoEUxMWbj/mESR8lZ
 LHbqhkStPhgDULPDzShxrWK7fHVEy3K8KswOsB3CEp5PdqE9/UftTCViwlSDBHOd3NeY
 R99Q==
X-Gm-Message-State: AC+VfDynJX5OmdcUsf8Vzb+jJmtF7uHSoEILY+g7WoxzKtEdQqE95FZW
 RyD1pPagHYsEGsqR9ypD56k7yQ==
X-Google-Smtp-Source: ACHHUZ5r8siwKGzcTzAL8CpZ57emhmRAe3JHIal/GhJtOdi86vLV6OLrAhZdQ6gBEuNeN33/CcyMTA==
X-Received: by 2002:a05:600c:2113:b0:3f9:b4b5:e000 with SMTP id
 u19-20020a05600c211300b003f9b4b5e000mr678788wml.23.1687190874889; 
 Mon, 19 Jun 2023 09:07:54 -0700 (PDT)
Received: from [192.168.69.115] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 e6-20020a05600c218600b003f9b3588192sm2066686wme.8.2023.06.19.09.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 09:07:54 -0700 (PDT)
Message-ID: <13aa9c38-1887-bf9b-f034-b0217308ab15@linaro.org>
Date: Mon, 19 Jun 2023 18:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] target/arm: Restructure has_vfp_d32 test
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>
References: <20230619140216.402530-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230619140216.402530-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 19/6/23 16:02, Richard Henderson wrote:
> One cannot test for feature aa32_simd_r32 without first
> testing if AArch32 mode is supported at all.  This leads to
> 
> qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither
> 
> for Apple M1 cpus.
> 
> We already have a check for ARMv8-A never setting vfp-d32 true,
> so restructure the code so that AArch64 avoids the test entirely.
> 
> Reported-by: Mads Ynddal <mads@ynddal.dk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


