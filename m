Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B182BC76
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 09:45:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOD9J-0008MJ-7j; Fri, 12 Jan 2024 03:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOD9H-0008M6-BF
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 03:44:19 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOD99-0001hZ-NH
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 03:44:15 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d3ed1ca402so56829165ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 00:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705049048; x=1705653848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bqj1vLfC+4eBLGSKDWM91k4/gUjyUe75vfG3xNLI2wk=;
 b=U9hktF2q1j0+4PrLG0jIMWqhiibd8OlARjF+geNALWsF0H+Jl0RXYsv9rSSHLttyBc
 doRNIVy4GLiTLLrc31jqFSLJ0zaxjnOUqTcvBIy1wpQrNXM1f5Vqexedxfekr+8ox3Ku
 MNLupTAX6QL9HpXvlfPUJj1jhOEsf+311QK1p4m1Cb3nwFMqbTeGD74dBMR02G91dny4
 cEGlhlD94Dc2kyU4yIgk07srdL5Le8+6vqTiD2FaoshPUkArNb2Q29/PhFfhjGKtFkbt
 zvtzGtNGV+KTJUfF2LpxiLN8vS7folDWWhf/uNOVVbo+5VMZqJJ2NFIr7MXPh3hhDq9k
 gfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705049048; x=1705653848;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bqj1vLfC+4eBLGSKDWM91k4/gUjyUe75vfG3xNLI2wk=;
 b=tG0f9aJmyV6Ot+SEYYVFdDSMlgx/FQqoI3Z4QrFeR3SA+ZvHPINevGacoeL8vt2wzr
 1dDtdUPwGDJ904sKC7j1BJqEFWkoIXXnLW3lfpWvRillE/BDfj3sLUlsWmq4lqhdoss+
 AXNzhxkbkz033lNl6bcHgaWb2Rp3BN4Q8OxMi+1MqiDypLuZD8keE/mZmBsALnbsgIz8
 WweoHcJQ7lRs4yDIajCT3dHH4MYAEr5dcHKPG7nGoGa4PHLvyZvMxM9akGpdbQ+B8UPp
 4BfLhQhOk5gavPPvgfdzYeWYIKz6fxWIy4DzpMl7xte7QxPxYmbQGM0QvOHz7tZsN3k9
 HRgw==
X-Gm-Message-State: AOJu0YxxIkNV3htxa8hQdkYq7PzdZv+K6IfmePfekYA3poDBEu8KX4MZ
 j/GIV8FVkCgq7rEx6N85Ap/FWrvD7ZUASg==
X-Google-Smtp-Source: AGHT+IF/GUYNr8Jnuvg0OWqxYQtTJfClVcHmdqfIHYKvBK0OMjUP3qUx45LD/qMSrQBlp9fEnXESOg==
X-Received: by 2002:a17:902:e751:b0:1d5:8ce6:e4b1 with SMTP id
 p17-20020a170902e75100b001d58ce6e4b1mr733515plf.43.1705049048737; 
 Fri, 12 Jan 2024 00:44:08 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:6327:94c1:b7f6:cf28?
 ([2001:8004:2728:2ad6:6327:94c1:b7f6:cf28])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001d35223d0besm2588160plg.251.2024.01.12.00.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 00:44:08 -0800 (PST)
Message-ID: <4cb4c362-fa1b-45f1-b628-1a1161916776@linaro.org>
Date: Fri, 12 Jan 2024 19:44:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] contrib/plugins/howvec: migrate to new per_vcpu API
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-11-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240111142326.1743444-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/12/24 01:23, Pierrick Bouvier wrote:
> @@ -180,11 +190,11 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>           class = &class_table[i];
>           switch (class->what) {
>           case COUNT_CLASS:
> -            if (class->count || verbose) {
> +            if (count(class->count) || verbose) {
>                   g_string_append_printf(report,
>                                          "Class: %-24s\t(%" PRId64 " hits)\n",
>                                          class->class,
> -                                       class->count);
> +                                       count(class->count));
>               }

Compute count once.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

