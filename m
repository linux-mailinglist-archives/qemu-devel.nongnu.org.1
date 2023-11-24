Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FED07F7316
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:50:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UgO-0001s7-Tj; Fri, 24 Nov 2023 06:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UgL-0001rg-J4
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:49:13 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UgK-00036y-4w
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:49:13 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-332e56363adso895039f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700826549; x=1701431349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kDycAxorQx/JETYMjMOu7ZhPf8tONa+u8Eo+8N3REvM=;
 b=Wf6qP4tS9A1rPXdDcS83qOOYv/6/pjzaGUpEeR/VKD78kSBdTBm95EYajjX+KY7edZ
 44yHYhpfbYfamaEc/s3/S/HWjZuQQT91CQcgeylOAuyzH1YMa6dCjMc7zBfCZDDS2sxG
 /7r9TZUCo9Ups/TnLcviVG678wpKeFAX0pQn9dHsMMajlzaBGUTWEgsu82dfDiroOqLX
 4xiC96YDau1u9AwqnSBIkbuiqqwAO+dWc0YN0iF7iEG8PUD8f+5Z9CpCUt+XUP9CmLrZ
 HLuOr6OEJ6eWoNsiR7UyWqk7xYxTWP3gEKvcBiA/c9SD2B7lL3vL38K1BC8fq6sKVW4J
 TsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700826549; x=1701431349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kDycAxorQx/JETYMjMOu7ZhPf8tONa+u8Eo+8N3REvM=;
 b=dSQk0F+ASjVpiuISdjPFlUMn/oUrcRDYZ1/7w3xJu4cXDLs7kvPnRagtaIuxz2941o
 Gk3HcO5mJYn4kd78twYJQF+Z8pS1E1iEuVmY3xbZo6SKrS8x5CnR9P0MxbAK8ZFNtcAT
 0FE6LiNWomY+QfeEGyA5KKmvhKPN2D2g573wdlN3S/+zsMwrz8lKOgTvPuP5BFJltSzt
 yxHXY6HQf4K21QwI8d9zJ/zklcMBj1Zrid67O6BSmhrNNqGLWUqXSRcpFXw6EsGGzlR9
 ypVlukwA8AnYUW4Cf+KDxVa85aVLJYOFOQdMfXK4rP2JNf+kySwpcZra9GEYuOHHWLo/
 visg==
X-Gm-Message-State: AOJu0Yw0kyHpOo+l3fqamGDT/EflueG5y4XJVJUfIp8fdx+22AvbUpfZ
 KhYWQi3/0yGHiggTxlnXxnvwV5/39Y59HMis4wk=
X-Google-Smtp-Source: AGHT+IF7CmhqG8V2HFXpK54QqKeFvyvU8AkP0IFeZXT0JGNvTELG/+PCSkEDjuVBgICedf4ezKgleg==
X-Received: by 2002:adf:fd8f:0:b0:331:6ae6:d25f with SMTP id
 d15-20020adffd8f000000b003316ae6d25fmr2106156wrr.26.1700826548704; 
 Fri, 24 Nov 2023 03:49:08 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 x9-20020adfdd89000000b00332dc82f70esm4096537wrl.102.2023.11.24.03.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:49:08 -0800 (PST)
Message-ID: <d08beba6-1e2e-404e-9fbe-65b6a941e9f9@linaro.org>
Date: Fri, 24 Nov 2023 12:49:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] target/arm/kvm: Init cap_has_inject_serror_esr in
 kvm_arch_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 23/11/23 05:42, Richard Henderson wrote:
> There is no need to do this in kvm_arch_init_vcpu per vcpu.
> Inline kvm_arm_init_serror_injection rather than keep separate.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h |  8 --------
>   target/arm/kvm.c     | 13 ++++---------
>   2 files changed, 4 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


