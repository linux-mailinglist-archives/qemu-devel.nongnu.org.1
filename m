Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5707B278F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 23:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlyct-0004aH-M0; Thu, 28 Sep 2023 17:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlycr-0004Zu-NS
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:32:49 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlycp-0004vV-TP
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:32:49 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6bf2427b947so6704884a34.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695936766; x=1696541566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AQV6/LWMTIatjZ6MZAfkxn6TqNms+ONHm1Q0Cbl9Aco=;
 b=AwM5+85x2XZcNAMAaaIAsscgpiFmv1RovWmQxzabsO//y78F4XubzV2AmRAjs7Vat9
 zUngWRT+lxQSAl2VGJHRP8fYQh/r5kbpkuX2SSuUOCjPlHHuSah5W8x1WVN4u2g6B+Tz
 2LW6ER6NaMbI7WxfrI7dl02kWv/IgokVD8rRHoC/L0UtsJdwSlZ2KkV90ZKW5CQ1i6Ce
 dWtAGRn5wU4VtgaVoqofznCieO6mEhlKtFKBVvkRrLdKByVs7QiTvZdSBgb8TzLqsjjl
 TdLZv/kkwf+e8aHoFp2A3mKdfmXC6mfMenfyEjB4V4fsHHfC0erduayTsVFQOmFfV8aG
 /AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695936766; x=1696541566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AQV6/LWMTIatjZ6MZAfkxn6TqNms+ONHm1Q0Cbl9Aco=;
 b=tDXHvnbf8VvCoytnlBOYPIAmqQ+RzVdqJweVVIs8YVVdxo/ttSY9Ciu5+dm+qNH1gx
 wKtQ1FJ/ae4Tsg8uyzIPIK3xTuSgV7BDcbRQ9Kds5NV1RTFt3viiMyjiRgEw7KLLcfgy
 GOc5sZZ7U7fge7On3hxZ7LyWhcGqz/vfyzcl1WRXG7H03Z1nx/0SYx3kuywYx+Gc8re3
 eLnJsLI6kTm6AOAU5qMFBfwtzD1i9Pze2e+rz8YSLyl+Q4C8wvw3GQAGqsMSxuBWWJWm
 PwGmxojmVv3OQNvjnmvjGnsAkDrJsYsCzJF8/HcBkrEEdUJ0u9x0wUiB6CWEcZ5LXNNE
 9byQ==
X-Gm-Message-State: AOJu0Ywvt3/AOU1Ed9diyWFA/9zCQrMQAb3/spZyMW6513isNvZY9Qm0
 IAkXjeVs14azA2msmg1o1RAeXQ==
X-Google-Smtp-Source: AGHT+IF7eT2S+v7G4US+JtzXK91nrvH14TrdI1nVNX7LYlOURaEOX7JSS2hct/oH7et/NxuNwvPdFA==
X-Received: by 2002:a9d:6643:0:b0:6be:e447:dbd with SMTP id
 q3-20020a9d6643000000b006bee4470dbdmr2272908otm.22.1695936766047; 
 Thu, 28 Sep 2023 14:32:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 bf25-20020a056a000d9900b00690ca4356f1sm13504983pfb.198.2023.09.28.14.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 14:32:45 -0700 (PDT)
Message-ID: <1cd9adb3-004c-7512-e587-085959296f03@linaro.org>
Date: Thu, 28 Sep 2023 14:32:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/8] target/sparc: Fix VIS fmul8x16au instruction.
Content-Language: en-US
To: Nick Bowler <nbowler@draconx.ca>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-3-nbowler@draconx.ca>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230925050545.30912-3-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/24/23 01:03, Nick Bowler wrote:
> On a real UltraSparc II, the fmul8x16au instruction takes two single-
> precision input operands and returns a double-precision result.  For
> the second operand, bits 31:16 are used, and bits 15:0 are ignored.
> 
> However, the emulation is taking two double-precision input operands,
> and furthermore it is using bits 15:0 of the second operand (ignoring
> bits 31:16).  These are unlikely to contain the correct values.
> 
> Even still, the emulator overwrites the second input before all outputs
> are calculated, so even if by chance the data loaded in happens to be
> correct, the results are just garbage except in trivial cases.
> 
> Signed-off-by: Nick Bowler <nbowler@draconx.ca>
> ---
>   target/sparc/helper.h     |  2 +-
>   target/sparc/translate.c  | 19 ++++++++++++++++++-
>   target/sparc/vis_helper.c | 14 +++++++++-----
>   3 files changed, 28 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

>   #define PMUL(r)                                                 \
> -    tmp = (int32_t)d.VIS_SW64(0) * (int32_t)s.VIS_B64(r);       \
> +    tmp = (int32_t)s2.VIS_SW32(1) * (int32_t)s1.VIS_B64(r);     \
>       if ((tmp & 0xff) > 0x7f) {                                  \
>           tmp += 0x100;                                           \
>       }                                                           \

Belated follow-up suggestion:

-   if ((tmp & 0xff) > 0x7f) {
-       tmp += 0x100;
-   }
+   tmp += 0x80;

7 occurrences throughout vis_helper.c.


r~

