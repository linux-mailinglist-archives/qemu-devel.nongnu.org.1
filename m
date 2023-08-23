Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88632786013
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 20:47:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYss8-0007b5-Q4; Wed, 23 Aug 2023 14:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYss0-0007Zv-HZ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:46:20 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYsry-0003MC-Qj
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:46:20 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68bee12e842so11828b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692816377; x=1693421177;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fWhkzme6YcoFESe9V5uFe83q8iDgbciyK9gtSQyK05U=;
 b=Kwsh1f5nAbUeSSfd7QWvYqRHVgJyFq0tZImIJNjIwZ2GlCV9N1+6H8Y6XjKubyU2PH
 iwHsdaFZT1WeJFiVkKbyREHuK5fdMLGO9DMJv+bXeNDEOhSSfSwhEBi7DDy9wCtdeZEM
 zPSVd7Z0IATRAINBMZKmO4hUhBL0eK9CYoIWBr8vqkrdT5lBpIP9WvTkbCkOQifDI0Ao
 VGJtBfmjxn+V1s3NKrh3YPUOCHTZPzV5bntE0+y/vnf7i1qWSfeKmn2C+AgKHrBE6Hdy
 xEfxUH7eFf4gi2WLgkOscaCsP6EoGcW7JLmBvBqtEDJsbzFPOchI37s4GZ1gmkUn7uTS
 1jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692816377; x=1693421177;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fWhkzme6YcoFESe9V5uFe83q8iDgbciyK9gtSQyK05U=;
 b=i/EoDXwQDvSeeB5Wi3quF29RpKQNjYzSViPa0ogHKt1lD00ntH2gV/d/IDdMLVLYsx
 QZ42nAsjLCL4H/G663i5bES6UGrTIQ+jaq2pZkosXBN/+yWgldxnhTIVSXw1j4Iskdxr
 DOeSqXMG/i797muc/pnq6/C97K/9H+upfixHRQT2rI1F/I1JmLZrSlNeogEKHuGu1ooC
 IYokEygBgzm3DEWyYTksThRB6/RkTUKBm0iUFOvXxMtK94a+2aM9V3tiv50sIkE8j7nE
 ub+Kz/TvApaNAr04VtEA6euhnr963dSp7W6CEJx3qLOq9VJbg9vTL6fRfWlA/tZbYDI3
 8Drw==
X-Gm-Message-State: AOJu0YyDdQ2Lg2oaryaxIrdJvibWfH6XmgrUH/aPJUhMoqvVr3u3B8sf
 Dn4YiRLAmqkJ7P060pkgwai2UQ==
X-Google-Smtp-Source: AGHT+IFZ1FxtnzRFUfohSTFUvDrqgGpIRn2AF8TrbwlTUQMS+To9q7UYRNsO119w1tO744nLxyCUAQ==
X-Received: by 2002:a05:6a20:1596:b0:115:5ed5:34d3 with SMTP id
 h22-20020a056a20159600b001155ed534d3mr12991238pzj.20.1692816377297; 
 Wed, 23 Aug 2023 11:46:17 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:72f0:1ea7:85d2:141e?
 ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a633e07000000b0056c3ee09b71sm4817288pga.74.2023.08.23.11.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 11:46:16 -0700 (PDT)
Message-ID: <8e791b52-b30e-fe8a-8195-617a05d31d21@linaro.org>
Date: Wed, 23 Aug 2023 11:46:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/8] tcg: Document *swap* helper implementations
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230823145542.79633-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230823145542.79633-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 8/23/23 07:55, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (8):
>    tcg/tcg-op: Document bswap16_i32() byte pattern
>    tcg/tcg-op: Document bswap16_i64() byte pattern
>    tcg/tcg-op: Document bswap32_i32() byte pattern
>    tcg/tcg-op: Document bswap32_i64() byte pattern
>    tcg/tcg-op: Document bswap64_i64() byte pattern
>    tcg/tcg-op: Document hswap_i32/64() byte pattern
>    tcg/tcg-op: Document wswap_i64() byte pattern
>    target/cris: Fix a typo in gen_swapr()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued to tcg-next with a few tweaks.


r~

