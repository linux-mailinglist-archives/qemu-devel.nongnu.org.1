Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1AF7F5E14
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:43:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r686o-0001PL-4R; Thu, 23 Nov 2023 06:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r686m-0001Oa-0r
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:43:00 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r686j-0004eQ-MW
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:42:59 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40b358f216dso4350215e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 03:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700739776; x=1701344576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TK5gmGcJ/bkpS3b4rH8kMNV0KRS2ibQV+3r0RfiRAtw=;
 b=orve1dsU2vrmMBevE1VVzbtztLubMPTuife3s0kp4AJ8Zm9ZRHSKt0AMmW6AZbRT1e
 hW8AUoyj6LQ6bDsGR2SD8yQdYVLrQYNlE2bOxWq2gvjxsLadvTvOY2EzkQLnsqK0PRPH
 fewSot9Szov+40IXKW+CCUe90+kQ/zv5nASMqUvCCitozLHu/iUYCcfUQ+dTkkAE17Xf
 Z8IcKvfkzO4blzmPPb5GA0qbwqRFR2MBjnGtQJOX+LPTbtoVlocaNdy12RR2WAlaZMhg
 HYOUIvlxx5Dpo7hrTy+e/nov98KH6Nk1JTnNXXAcWe/wzwmzxSNl/JzktsHiuIMP3Dkg
 ulyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700739776; x=1701344576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TK5gmGcJ/bkpS3b4rH8kMNV0KRS2ibQV+3r0RfiRAtw=;
 b=MVhxCwFOJRU95MjSQqiQdSS5bkHrV5vJk9CTk9qXF2ALqIk5jPr6cY5P4sEdpHdqFb
 1kEWJaRgsXnUSjUhymrKtLoh1LPda97DAzuXT++kLXgz/a+E6DTn/QyJ92qM3tSJ7R/x
 Ku91/AxjFCmmq9yqn7P4Rj2i56GbaH4ai8KTkTUW+rOi85eleTEm4ZgnUkZ67NUst1nV
 IRmKkCP1n+2XTebdBlx5DMJfZ/KxEo69jzomL1sU983+n3TaKm8TZ5iu9DYemb5lFJPM
 hXi9neVKms/8s68EMv4anfe42ZjWFCOLuXEjvYgUpyDxFDyQERaXAywIbWQHeMprgsmC
 4F8Q==
X-Gm-Message-State: AOJu0Yya+so+xztydUxYR6QtFVpCDQdO2VJtJh1QtXrJZuJpfoCq1Z4c
 cytJ1cKa/97dsPajIi1JjbUcog==
X-Google-Smtp-Source: AGHT+IGyAoNx1DwVRFO407Q40DfkMeVcWNPlQO7yCacBdTeYhQeZ9zAnI2NOE+B27o/1m57P5LV6Pw==
X-Received: by 2002:a5d:6c6d:0:b0:332:ca1a:a824 with SMTP id
 r13-20020a5d6c6d000000b00332ca1aa824mr5304732wrz.11.1700739775041; 
 Thu, 23 Nov 2023 03:42:55 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adfa4c4000000b0032d8eecf901sm1455905wrb.3.2023.11.23.03.42.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:42:54 -0800 (PST)
Message-ID: <b82c568f-1f3a-472d-a3e6-12e5d95015d9@linaro.org>
Date: Thu, 23 Nov 2023 12:42:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] target/arm/kvm: Use a switch for kvm_arm_cpreg_level
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
> Use a switch instead of a linear search through data.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm64.c | 32 +++++++++-----------------------
>   1 file changed, 9 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


