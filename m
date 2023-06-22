Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A99E739DE6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCH5I-0005Zw-1Y; Thu, 22 Jun 2023 05:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCH5F-0005Zb-Vd
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:58:34 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCH5E-0001v1-AG
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:58:33 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b44eddb52dso101535891fa.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687427910; x=1690019910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zvnV1VJPWEebNXnEj623nIusXojJb+kOGXB3oNOFbbI=;
 b=db5wE/apz2my1+8dFFSHdyaOwUCHqi+gly8ANl+RprQGBYmpajzXrkz4MbEYxMtQxz
 ZXesnyX2Ll1Rrk43C2WBy5OkhDQNmyyXOd5uIq3LeZQwAl4Ig2pac46aeMjdYQWJ4Ym6
 1FWEoA+aCGYzXFRl7sbohX/PyTbM9SNXByK33+j3RAnE5tB/SjZ5ayR8GoeMXfET3TC4
 cNmKqgOyniToBOAVYFVvuqqZoZUYT6J3CgJbuIXR0vdUE2CYMqR/7xXHFEO4UR2TwcgY
 TYf1rmXnWPykYqwSLIZ3zaN3dgOIe93FwE/cs9qTisL3FXY3LkDVu/acLbtkBcAVnShk
 pmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687427910; x=1690019910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zvnV1VJPWEebNXnEj623nIusXojJb+kOGXB3oNOFbbI=;
 b=I8PkIh9/iEx/59NOGW4D9pvyl8Ugt7dNZwkC78iCKKLJ7lXtYvwevWAEBVQbnifUKJ
 bmD7DAndIXpNbOBUNI+amFH7eBRgffDabAnqQbUFTTmb1rn0MWTXl6pyuDvpl9EPpSOS
 cTojwRez+Q+/KWZFcGBJaS4z2iQJXllawuGqcUi9MRCs3jdBhzaVH6bOLJaIvSM1q3XS
 /JRRkt47rYCyE46OI9+/DX7yREsMG1Lw1A8oFe54R8mzx72pTxR9bQRuGob4qnjG/Lst
 9n+DpsP9NzvF9Gh5fesy07GIpOuVVVf3AK35tSVjzD5GnoVm8Z9Bjlmf9AWH+yXlZi6A
 kNEQ==
X-Gm-Message-State: AC+VfDzU++xuX+4zCZiZNUfyTqF4/hl6X0truiNBuAohbOAlMs0qSGWR
 MKoaVUEkwPLejM/pmnJPGLOcSw==
X-Google-Smtp-Source: ACHHUZ5F1osxNI6JFkITeRPJPyHrotjWjIos6vUrIXf1jUX/kIpVIyURSHPXeIfktSRDBI/oR8kRUg==
X-Received: by 2002:a2e:330f:0:b0:2b4:7281:1987 with SMTP id
 d15-20020a2e330f000000b002b472811987mr7858248ljc.44.1687427909804; 
 Thu, 22 Jun 2023 02:58:29 -0700 (PDT)
Received: from [192.168.122.175] (127.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.127]) by smtp.gmail.com with ESMTPSA id
 e6-20020a05600c218600b003f9b3588192sm9226502wme.8.2023.06.22.02.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 02:58:29 -0700 (PDT)
Message-ID: <405f3697-9cc8-3a19-ee79-094e6e130c29@linaro.org>
Date: Thu, 22 Jun 2023 11:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/9] accel/tcg: Store some tlb flags in CPUTLBEntryFull
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
 <20230621121902.1392277-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621121902.1392277-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 21/6/23 14:18, Richard Henderson wrote:
> We have run out of bits we can use within the CPUTLBEntry comparators,
> as TLB_FLAGS_MASK cannot overlap alignment.
> 
> Store slow_flags[] in CPUTLBEntryFull, and merge with the flags from
> the comparator.  A new TLB_FORCE_SLOW bit is set within the comparator
> as an indication that the slow path must be used.
> 
> Move TLB_BSWAP to TLB_SLOW_FLAGS_MASK.  Since we are out of bits,
> we cannot create a new bit without moving an old one.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h  | 21 +++++++--
>   include/exec/cpu-defs.h |  6 +++
>   accel/tcg/cputlb.c      | 96 ++++++++++++++++++++++++-----------------
>   3 files changed, 80 insertions(+), 43 deletions(-)

Do you mind squashing this for clarity?

-- >8 --
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index c174d5371a..c0f19e5893 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -130,3 +130,3 @@ typedef struct CPUTLBEntryFull {
       */
-    uint8_t slow_flags[3];
+    uint8_t slow_flags[MMU_ACCESS_COUNT];

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4871ad85f0..d07763fdeb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -86,2 +86,3 @@ typedef enum MMUAccessType {
      MMU_INST_FETCH = 2
+#define MMU_ACCESS_COUNT 3
  } MMUAccessType;
---

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


