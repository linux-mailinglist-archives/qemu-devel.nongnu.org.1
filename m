Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDB673D8F9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:57:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDh5O-0000Ww-C2; Mon, 26 Jun 2023 03:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh5N-0000We-8C
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:56:33 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh5L-0004qN-GF
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:56:32 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f76a0a19d4so3800592e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687766189; x=1690358189;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RGGiuHJsxSKHXwFRhpPmNrzFRVpLiuJtVbKciQK45qI=;
 b=qx06lioubOsMpallcGuWkukIobW+SQsj93QJKSZEhQRwSHZtVOITmFIjxfqyvjPPFu
 GWuElB99FOE3VzgAQAaRMWkAZCIVbcdjFA6Q97Zj3V04mEUtmfHeH3+9mQfDpT1c3TOv
 1az8p3v0jYSRKno+riYAuBQoaXFcyXoUqGyBidNmIKw+ceplYLe2eh+NJn337+UvhSf6
 ZjyZOArpGmtiuKyaFgUs3ClAhH/brExOfwyVQrPK+YHfVnOma7P+LMxSo7KLEUmiF8ql
 AWzEGpMIq+mUaQPKUvDm4GHcjhG90Z9O8udXWu4VJAQg7E/Mch5UKTOvOJz2hiIJ7ApR
 U1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687766189; x=1690358189;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RGGiuHJsxSKHXwFRhpPmNrzFRVpLiuJtVbKciQK45qI=;
 b=h6GlVb2PrEh70PPFIonTV5OQIgpK3gXqd+iffiXVxylcutaX5afwRiXml0Wml18z6t
 iRXmTYg3+zxnGk338hBzISBGf3xdjMyixHfBHhx7zK6j574A9qQ04AGxNjqn6rO61N4u
 PCc+Jjt0a3q68XAHt1DyWfDws5KDcMbz8+mE20FDw/3PwhPfEUf/mkICnMtPi9OU/fkZ
 AHuf7MRHk/0JSRBHJXXc9PVYhM0Wl1Skw2tGKutQsqMLFBxzNzQ7MZnRMhhhpwD9eI9K
 Ckc1uBsNpAc8VibaLjXVa92Z6648pwJLR46qkZFHB0Qr1JY2VWh6JRBh5syNIh+4Bsvg
 +ifQ==
X-Gm-Message-State: AC+VfDwJqxu26dJCI2UIdxVJDEoZ8KzbWCOkHSWDFG0wN/QYVkkM2NFG
 rzEPhCteBP7U7TIG60JMeASAtzs2DO1PCmC5KVckFSW+
X-Google-Smtp-Source: ACHHUZ7XufVP27HsZvCL4Oj+jVBYjAO/ScjosQSd8F4NEjAnXbtGabY73Dj7EhFabbriseYW3nWryQ==
X-Received: by 2002:ac2:5bca:0:b0:4f8:67e7:8a1c with SMTP id
 u10-20020ac25bca000000b004f867e78a1cmr7208815lfn.45.1687766189112; 
 Mon, 26 Jun 2023 00:56:29 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 10-20020a05600c230a00b003f7eeec829asm6867901wmo.10.2023.06.26.00.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 00:56:28 -0700 (PDT)
Message-ID: <20254de7-920d-a8c9-becd-892496d7801d@linaro.org>
Date: Mon, 26 Jun 2023 09:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 11/11] target/i386: implement SYSCALL/SYSRET in 32-bit
 emulators
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230623131711.96775-1-pbonzini@redhat.com>
 <20230623131711.96775-12-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623131711.96775-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12a.google.com
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

On 6/23/23 15:17, Paolo Bonzini wrote:
> AMD supports both 32-bit and 64-bit SYSCALL/SYSRET, but the TCG only
> exposes it for 64-bit targets.  For system emulation just reuse the
> helper; for user-mode emulation the ABI is the same as "int $80".
> 
> The BSDs does not support any fast system call mechanism in 32-bit
> mode so add to bsd-user the same stub that FreeBSD has for 64-bit
> compatibility mode.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   bsd-user/i386/target_arch_cpu.h     |  4 ++++
>   linux-user/i386/cpu_loop.c          | 13 +++++++++----
>   target/i386/cpu.c                   |  4 ++--
>   target/i386/helper.h                |  2 --
>   target/i386/tcg/seg_helper.c        |  7 +++++--
>   target/i386/tcg/sysemu/seg_helper.c |  7 ++++---
>   target/i386/tcg/translate.c         |  2 --
>   target/i386/tcg/user/seg_helper.c   |  2 --
>   8 files changed, 24 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

