Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AE67C7C5D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 05:55:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9Gh-0005VZ-RS; Thu, 12 Oct 2023 23:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9Gf-0005V5-Fj
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 23:55:17 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9Ge-0003bE-0H
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 23:55:17 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a7c08b7744so20449487b3.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 20:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697169315; x=1697774115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XaUegUF9bBthmSrPdCepCUbTF7JMCE50DrGbWy11G84=;
 b=gmcQbHM50ozZfgEQuZFS46mcDvfqgMVoAaOXU8RoZbkJW6x0m4KBAsGaVnE6YvB8sG
 uIYP11Nv0ZyATDe8/WTRKbKrOb3PsRelQXob8fqwZ8FE3kOpMLQdJzccY7FASGvJuaLj
 e1naXYxQI7EbB650TWJCsWyf461qNif4AgeVQWUNNOXLpqakVq38u+oPm0YLjYz9pvq/
 IetGAA2lPX3f9gX7g3ZR6kBv9pqB+iBjKSoVMX+25Q9xZoj8gETHDcl3PvxL5YhWwzDa
 88KkQDs2kGZ+Nu7pwq5m6908+ddsGHeLn5wGUgIQ1/KnvSD6jMi8+0G7TnGQoXRVKJC5
 kMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697169315; x=1697774115;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XaUegUF9bBthmSrPdCepCUbTF7JMCE50DrGbWy11G84=;
 b=ZhBbsaf8qHiSgWOQqLFs7pjpXzAZL2Arp1rxEsTsJuBwmx4rKtPPMaY3z4RdhkTs0U
 TTjkP/lonlgoHNUO+EPsLHcp8UG1wSzZTqHjk99TuY7OP0w6MC5vdC0DvoDGJb92rHpa
 JYQLXlJBahELX4yq5ZgV7+hwYfZX2K/18ZyDFZTodwvOMoOOGQwstd9kO4wp9CfXPhAY
 pS3PCipzFVQyVnBc2SR/sCN/DpZOk3yHejA0TAsnASrQ2Yy86ZFO8VisaIiR+aeI3X8h
 ncDp17JCYXenZbxkYv8Ni/6bQEqEZgdAm6CcTV59XmL2zas/5O7raE6y9HAyYG1mmiw3
 6g8g==
X-Gm-Message-State: AOJu0YwhO6qkqiyNq4U86yl0GKyjKthCYrLj+7H8ldulLmlvYdrQBXCS
 03B0xL3k3POZASqDEFmCVIP9xQ==
X-Google-Smtp-Source: AGHT+IETkuKpEetAKs6hjjYfqWBKahsK/LG1OP9+n4aQ/guBRrr7eI822u/cX/t2yw6K/khh94kd4g==
X-Received: by 2002:a81:8284:0:b0:59b:c0d7:6766 with SMTP id
 s126-20020a818284000000b0059bc0d76766mr29307592ywf.37.1697169314625; 
 Thu, 12 Oct 2023 20:55:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w26-20020aa79a1a000000b0069b772c4325sm333393pfj.87.2023.10.12.20.55.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 20:55:14 -0700 (PDT)
Message-ID: <5ad5ac06-c98c-4751-bc50-8adb29cf48dc@linaro.org>
Date: Thu, 12 Oct 2023 20:55:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] target: Mention 'cpu-qom.h' is target agnostic
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
> "target/foo/cpu-qom.h" is supposed to be target agnostic
> (include-able by any target). Add such mention in the
> header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

