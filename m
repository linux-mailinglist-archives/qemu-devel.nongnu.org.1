Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9193274BE9E
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 19:39:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIBtX-0000GH-8F; Sat, 08 Jul 2023 13:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBtR-0000FX-V3
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:38:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBtO-0000eo-Sy
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:38:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso31065545e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688837925; x=1691429925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X9V3mlclSrZnn64RNlPhkleDibYYoVmln79aRJTZDHo=;
 b=yvSoWskVNJ6/Y3ZSap6nGL/Bdien/DkvOEeSJJZMItaX6jTWh6FgVhdhz7sQ0XqlKU
 EGSE1hxItCnQgu6K2OrGRYwVYUuzd9wVMCmSGGelPj6qVUOGdhCBRBpKSI9n7E73PThK
 0Shg7HnJBN8asOw04mbuvLJTqEUL5TA1VTDcf/zCA9oKxM4qHNQMfzGaVC6PRHQBNRby
 RCMarjvvgsDXKlp0W1EDRSeCz1lj7pKCsPT4y2QGYLTGk6MHsYw7ES1bsPrv0mz9ZI9V
 T8dFNYgrQkDK6wK6hyolW5vHdXZQfzOXmRlsYMgd8YKHqmivy2hvGKsoACIgHpPhz7gj
 CUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688837925; x=1691429925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X9V3mlclSrZnn64RNlPhkleDibYYoVmln79aRJTZDHo=;
 b=KgApxFP8InxyKxrIHkbc/uRU4uELWVoprVc/KysQhyZnNLY0m+Wky1fiGlQULP/8SL
 hpDcnlyaJ4BaYd9TAn+pq4GwykicDeZX8ucwL6XXnOh5woIT9bmOWunu2VvDJT9PTMog
 iZi5iVPg0I8PaxD1usM/EpSwwW2wHGRZXEo3D/+ghJJPuLWJTRSty1k4FJvqVoEtKY2f
 suhvcxIP3apKVXd/j3f2whB1qjCFEH+W/Ukdlgh3Z2kNCStqKfiquS/C3xxBBeHYf0ek
 JHsXmRMWbwyD7w1QFjZ7e0M+xS7bzcrLEWxHVe3M0SZn91UVGhVLxQ1pvzoToFSrAfgF
 XVzg==
X-Gm-Message-State: ABy/qLY80SC+MjmQMUI+89Nyful1qvLne7YGOkPqXO1DPR1cj8xNBJST
 eeOycmVs27xbnX4Yp/Pil7rQwQ==
X-Google-Smtp-Source: APBJJlGm0P7wRvMmz4kS2uBbmOQO/ku8qB3tUMl+BINLKn60SmWxFbtorcuA12zsnlIFsPZ9+9KPSA==
X-Received: by 2002:a1c:e902:0:b0:3fa:8874:fe69 with SMTP id
 q2-20020a1ce902000000b003fa8874fe69mr6744892wmc.29.1688837924986; 
 Sat, 08 Jul 2023 10:38:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.184.32])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a05600c364b00b003f90b9b2c31sm5626969wmq.28.2023.07.08.10.38.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 10:38:44 -0700 (PDT)
Message-ID: <d33e7552-2f53-6669-ff6c-348b7f024967@linaro.org>
Date: Sat, 8 Jul 2023 19:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 00/37] crypto: Provide aes-round.h and host accel
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
References: <20230703100520.68224-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 3/7/23 12:04, Richard Henderson wrote:
> Inspired by Ard Biesheuvel's RFC patches for accelerating AES
> under emulation, provide a set of primitives that maps between
> the guest and host fragments.
> 
> Changes for v4:
>    * Fix typo in AESState (Max Chou)
>    * Define AES_SH/ISH as macros (Ard Biesheuvel)
>    * Group patches by subsystem.
> 
> Patches lacking review:
>    12-host-include-i386-Implement-aes-round.h.patch

Deferring this one to Paolo & co,

>    13-host-include-aarch64-Implement-aes-round.h.patch

and this one to Ard :)


Possible cleanup to add in patch #4 "crypto/aes: Add AES_SH,
AES_ISH macros", declare 'extern const AESState aes_zero;' in
include/crypto/aes-round.h and define it in crypto/aes.c.

Regards,

Phil.

