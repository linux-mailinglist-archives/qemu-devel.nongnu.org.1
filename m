Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4D6753243
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 08:49:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCbG-0002Rw-5o; Fri, 14 Jul 2023 02:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCaH-0002RG-Nr
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:47:23 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCaF-000872-BB
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:47:20 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1b441dd19eeso1264961fac.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689317238; x=1691909238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yDjzcZy8Ij6agTjcnO8RJE91E87MJmyjcuZF/llx978=;
 b=kqbcLRK9qiJER6PQVcpXDVLWiTGeHAe6aPU1CyMjNl3gBfa5zj9+BLQT5x6FaDUTIO
 XUv4zuzsale2yncTosPGkNQprBQ9cyGWLITZYm8VTh6d2FGNoseP5/pByVmw58ISau2i
 NLHzQ4/66vGlFqOm31U0xeelCbeG8wIAulfJnN7Klfo/vAfWe2MBBdYdp7KPjB8B+pI6
 FLLbQSplSxmN/tOA27/KoRv4oLHyx2Ku0lfzb+x8H5H/JtanM5yRWoNUWOzR1waEX3fG
 v27B60yQ7vvnVQRvpPVpiuDOd6c6d7UB7eL7Wmm+JpGAeX7XCsrz7zl5qxE5s067S/+7
 tgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689317238; x=1691909238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yDjzcZy8Ij6agTjcnO8RJE91E87MJmyjcuZF/llx978=;
 b=ONN86i7bfUp2NhHOuYPXYvgoY3QAu8LV8nwpO2H9nga9E0rxeJXNK2OQQFcEXZzGdM
 JicjsaJptdJjM1qwImSBMReQTfOOiBEbUkYW3TtFMHfEcPWZFrvBgV8QiGs/MC2kh/Xh
 tTlNJnwAsFVI5hi9iKotYHNducsr8J9WeyGu/11X18LuWUq77hADz1EPqeVaSslSjTJS
 Zj3+zvPy3sBdHf7Yv5b+5e/OkfogOnToJmyJaID4rInsdEsObby1bCIxheLrP+ZnhOZ9
 fF5sqRi2QpOhYs2sdw4v7fubnUKCJaHtKfqKDt53gLXTk7bjn7ExYSShs2ZG/Is8+mUR
 5vZQ==
X-Gm-Message-State: ABy/qLboIbYcoo0GhjMLws5f8Y28F1nm1/qT4lCC4XcZZNIaTGkHjwpQ
 PZ+LgRDZ7ZDbgVWDHX1tga/zZw==
X-Google-Smtp-Source: APBJJlHFEkdgHFUzAa9er6RXCBjdttLOm0PKhf3PFMjRUV01Thd1PsClOTZGC5N1mHLfVcRMzvY79Q==
X-Received: by 2002:a05:6871:91:b0:1b7:2261:e5b3 with SMTP id
 u17-20020a056871009100b001b72261e5b3mr4366597oaa.31.1689317237742; 
 Thu, 13 Jul 2023 23:47:17 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a63b44a000000b0054fb537ca5dsm6038489pgu.92.2023.07.13.23.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 23:47:17 -0700 (PDT)
Message-ID: <8a7dc0d3-8489-7f1d-0e77-0050b5775bcc@linaro.org>
Date: Fri, 14 Jul 2023 07:47:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 01/11] hw/char/pl011: Restrict MemoryRegionOps
 implementation access sizes
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org
References: <20230710175102.32429-1-philmd@linaro.org>
 <20230710175102.32429-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710175102.32429-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/10/23 18:50, Philippe Mathieu-Daudé wrote:
> The pl011_read() and pl011_write() handlers shift the offset
> argument by 2, so are implemented on a 32-bit boundary.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/char/pl011.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

