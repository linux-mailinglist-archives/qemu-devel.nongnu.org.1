Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAACD8333BD
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 12:04:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rR97e-0002eO-K8; Sat, 20 Jan 2024 06:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rR97V-0002dp-44
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 06:02:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rR97R-0003DA-5E
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 06:02:35 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e7065b692so17026545e9.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 03:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705748551; x=1706353351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FOobVmEprJ3LsAG4vcFFuSSmIIPEXnWH6LVvQAkcv6c=;
 b=Z+KK4jFQu6w50fu5geXO/gFbLZpjbhxp54x108EX0LoJfBOLazuHnItXKChnVz8EfC
 DnUH9A3hBJ69YyZjN7FlYaqEecwvqVd8NeRgJKNTD2gVfE1b89Ta16q6jE95PIfJ6Wqi
 G29RA0hcEU9Sj9FeNFtzFqFigee1JheTtRpxtzgDp6c81sNvUyt8JUeylB5Gx6MRMyB2
 JjJuY5whB494Oz6mI3/MUplD71IN+UY/kTbeNUeMdAmm7Z7EW4+m6ZJMmYTmb3rs4mjx
 JtwnEHJ3WA4eTwMFaX9lIyugv7ECl3rbHzdBOdQV6dhSc3x0+yAcUZ6P9pzkmtNxI7IC
 oiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705748551; x=1706353351;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FOobVmEprJ3LsAG4vcFFuSSmIIPEXnWH6LVvQAkcv6c=;
 b=RNuK8Hwi11nXdOyzqmyUY3qFWruXxe3QPM1zcoh/OJNvfVSKKcZqGrUjGjVIyR/dJP
 pc9rbj9P1yg/bkjHFbxinxgqdVYRKF2NTLjsdEyKHkQumI9dXndQsZslXfVypsutNFiH
 /DT3NrzsGVb3qHI/9a6225pk97u1vpLrzqSEEf+5Dl4PTeVu/COtNSxXhOSL/vWUFSUl
 LlUpjrF6mpap7hO6Suo8Dhp907LDRzw0eS6GsTihICbFIlpPYsx1JNFO+IsFqIS7e3tU
 IhEwp/qmaFNwUN9z1+Yn5yigwA5kPOhGB8sQLJjOacFP6F7UbeEyuH7aPhdT/x3WCkgO
 s8tw==
X-Gm-Message-State: AOJu0YxNqhXirK2oSDYmVfGtTQu+T1MXFEcPyb4rzwzk+NmEWfzTcKvE
 b/EODkkKP3XoWEsMFU8NIdpjGv+Bmx4KEsp2CgSVV0jq2sdIXOrjcgSmq/ORrc6kmlljYHJZccP
 h
X-Google-Smtp-Source: AGHT+IGby+O0apPINmn7UUT0VRXADep2p+M7gjrWvU2b0pEYqjeHtvm9hHgWzvWFX1DhYVW4RIb2Ew==
X-Received: by 2002:a05:600c:1906:b0:40e:a3b8:a2b0 with SMTP id
 j6-20020a05600c190600b0040ea3b8a2b0mr469975wmq.5.1705748550906; 
 Sat, 20 Jan 2024 03:02:30 -0800 (PST)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a05600c4ec600b0040e6b0a1bc1sm25268398wmq.12.2024.01.20.03.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jan 2024 03:02:30 -0800 (PST)
Message-ID: <afeb22db-736f-496e-b9a0-f64625aef4d8@linaro.org>
Date: Sat, 20 Jan 2024 12:02:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/38] tcg/i386: Use TEST r,r to test 8/16/32 bits
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-27-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 10/1/24 23:43, Richard Henderson wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Just like when testing against the sign bits, TEST r,r can be used when the
> immediate is 0xff, 0xff00, 0xffff, 0xffffffff.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


