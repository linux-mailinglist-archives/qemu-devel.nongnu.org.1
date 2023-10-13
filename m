Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF81C7C7C60
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 05:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9HK-00067g-Ir; Thu, 12 Oct 2023 23:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9HH-00065q-Rl
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 23:55:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9HG-0003or-3L
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 23:55:55 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-69af8a42066so1342697b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 20:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697169352; x=1697774152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C2xz4GnbJCnY4eO51oHmlBh1K/4IlvMVWB0zS6Wz7Kk=;
 b=XSQ4tyeH4Em9B8uaomLnc2mdKDmChBA/8vB6yAEVrPVyAh0gXVwm4a/BhJmZk9H8TU
 F6nQxUBAnU0jj/rd+S/uLm7f9WVY0CDN71LP1oc9noz9GrQfHPJ/ac686RSC/DxAJ2kG
 bGcJXUd9ZexLCn/FNPZ7y2PrL31kJqibUtdRtE0RhXltFqHISi+86AWeQ0m/sI91rpXZ
 DyRR9xLVF3jgtaTrUYzKssAWLkpYC9jQTKRUvlzLS1CiIfTCFp+Ua4LUO8ZLO8E2VuWt
 oe/LdJwaP8evxJFwEdacWWRYY7KIJn79RvPs4U9BhDYSgMzszrM+tx2lZpdgrmRHQ9qc
 0+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697169352; x=1697774152;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C2xz4GnbJCnY4eO51oHmlBh1K/4IlvMVWB0zS6Wz7Kk=;
 b=ln6CfgU9Ivb4oMdxV8qPIX7iXYtm8b/8cSnI6CL89K1l/vhbr93NZScJcbL95bkUHf
 d2ADqsWc23AULE1x3OLYnrIHDQMpmPyLqt9yD2xKblBiKvTG6V4iqOMaBM+tMmR2rzw5
 Jmc2+nmAkG0ha2ic0eK2tpf1jdSrCmyhYA+WPC9Hef1wSvHiVSL81/qhzUXiralw0xeB
 JQUhE/zIYEnuQNb1iRLSU5IdxJ8va5QDpGEuLM8yzpJFKnI2HP+X3kSIP0BQ61bUk0pn
 FR1pOxnKRi+QJwLio4YZBwwNj0swUe3OdwC6+AAym7+DdqAqYVOgdAnlIsViktigQ+s0
 wrbg==
X-Gm-Message-State: AOJu0Yx3j5cXFRI2EHlThMMeSJC3MUuUqbJTVl+V8LJiWQ8hoVTXI65h
 G8RfT6Vf0OJXA/N77YnWVr2dxQ==
X-Google-Smtp-Source: AGHT+IErizTRxY26PoMISQO5RR742KW2QdzcNhiPQu+oReAPVrp/2nmLzixcMw3QQjUy/Ij62xe8Ww==
X-Received: by 2002:aa7:8889:0:b0:691:1eb:7dda with SMTP id
 z9-20020aa78889000000b0069101eb7ddamr26949969pfe.7.1697169352521; 
 Thu, 12 Oct 2023 20:55:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w26-20020aa79a1a000000b0069b772c4325sm333393pfj.87.2023.10.12.20.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 20:55:52 -0700 (PDT)
Message-ID: <783a99bb-420f-46e3-95af-4c878e7f57c3@linaro.org>
Date: Thu, 12 Oct 2023 20:55:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] target/ppc: Remove CPU_RESOLVING_TYPE from
 'cpu-qom.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
> CPU_RESOLVING_TYPE is a per-target definition, and is
> irrelevant for other targets. Move it to "cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu-qom.h | 3 +--
>   target/ppc/cpu.h     | 2 ++
>   2 files changed, 3 insertions(+), 2 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

