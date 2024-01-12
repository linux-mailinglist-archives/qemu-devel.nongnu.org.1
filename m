Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC4382C739
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:25:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPxi-0004lQ-6K; Fri, 12 Jan 2024 17:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPxa-0004l4-LC
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:25:08 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPxX-0003Xp-Dx
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:25:05 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d9af1f12d5so6048950b3a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 14:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705098302; x=1705703102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EzmvGX+5lopIiSQe+5jFvQId5oaw4SJgsWjVZjj6olI=;
 b=KMvjO5YjoFfGaKA+U6/g02KGQJN5AWk50h8wlAelIUq3+jt14T9KBwHG8n8EBkJsL+
 GwgZxPEJEdHvYjrGDDPB+g2SOfeFhlobkxzTaF8KWPKydaebOeAxEvW/ZLZNiOJrKr51
 6F0IJlaswlk0OIF4+WTNj5s8JKvHQpx6eFaWTq67NY1wIhsvm24xqiSNO3S7JnGlIIDs
 cdQU6VokiaM9a++kSXQ57iMEmFldOcL6cOvNH9Gj1Agqjy+Iq7uETTHBAvQgeBOjZCze
 FJDgLj5SSUUtPuWQaHhoXsws5Z7Yl8GAsbshPNEAXQ6wACerEnVb/s8XkniaWn2J2WzO
 ldCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705098302; x=1705703102;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EzmvGX+5lopIiSQe+5jFvQId5oaw4SJgsWjVZjj6olI=;
 b=gU+fo0o5jmDxc2DhCzU3MsX4BX8u+idxGrdAApNGguIrHgZ4CbCxulAnebS7FcV2Ym
 KiUoiuo4q0Bd4Sn7i5T+wUX0Ojb4PQLPnU1ooICW7NousDmtTJJb+D48SHigzPcsyZmZ
 HjY69ivH8J/d/BsAcNdbTYvM7GiuIpu0/ON97HgzXnHTfN4RcOZ0KL5WGBBmONgotEFQ
 mM5vIlGZ+wQctgHKp1DL72aXBlxNDiX/Rl+RV1lylAhljkrbXEGXJf47cPWXCOtty55y
 JBgBi2Qy+Zs45l0ML3pOu4xDYqm6Gf5KOMWnu9yY8K/q/+eNa1eePFh8khcc5BP9g1kD
 Nw8A==
X-Gm-Message-State: AOJu0YxmQosyxrw/H2g8Km9i2U5jQq/nwc0/YJ6qxbEk+obyn8gwTML+
 Mxsia5WDa1OiMKrzW+MQs03DlINd8+AOKA==
X-Google-Smtp-Source: AGHT+IGu44ZI3ZneaokNTmhuFJMbpnfwtwW/5J+bsfx96P9f6Bbe3Pt2JzsaNryBiK8uyyb/aRytuQ==
X-Received: by 2002:a05:6a00:1251:b0:6da:e246:5c2 with SMTP id
 u17-20020a056a00125100b006dae24605c2mr2090137pfi.55.1705098301884; 
 Fri, 12 Jan 2024 14:25:01 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 fb9-20020a056a002d8900b006da550512d8sm3629327pfb.126.2024.01.12.14.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 14:25:01 -0800 (PST)
Message-ID: <ba475ccb-cc6d-4191-b0cd-92bb1b3c9eee@linaro.org>
Date: Sat, 13 Jan 2024 09:24:55 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] target/hppa: Fix PDC address translation on PA2.0
 with PSW.W=0
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-5-deller@kernel.org>
 <551dac95-3346-41eb-aa8c-d22b19f8c4fd@linaro.org> <ZaG7zLKP3gFV4-H3@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZaG7zLKP3gFV4-H3@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 1/13/24 09:23, Helge Deller wrote:
>> Please adjust the code comment that immediately precedes this, not just
>> within the commit message.
> 
> Like this: ?

Yes, thanks.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +        /*
> +         * PDC address space:
> +         * Figures H-10 and H-11 of the parisc2.0 spec do not specify
> +         * where to map into the 64-bit PDC address space.
> +         * We map with an offset which equals the 32-bit address, which
> +         * is what can be seen on physical machines too.
> +         */
> +        addr = (uint32_t)addr;


r~


