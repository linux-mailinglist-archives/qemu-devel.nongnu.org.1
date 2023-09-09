Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB11D799BE4
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 00:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf6Gt-00005m-Gk; Sat, 09 Sep 2023 18:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf6Gr-00005c-4V
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 18:17:41 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf6Gn-0004pt-Sy
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 18:17:39 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-56a8794b5adso2419613a12.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694297856; x=1694902656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dc9VOGNceEJmIXGI7jsbAqrLY4ZgsXSZ2JCKwpqBX3s=;
 b=vro6wTfl+el7c8Fo9D8ZVC+5DPCD3foh26GOugR7byczd25W7dvriqr0FExsckcUyb
 Reewb6Jr0nEUon08sEYt+uaGuKYSsBl6UHwydJ7uUYIhc0z5QYgSWMXR8YC3LU4wU0Fz
 sG4+ah1V2uw3Q6qP26wkdlJiYHyB+glP2T5H+jCjdgMDnprRu8M37tgCCs1z501cQAx8
 NF6LW8WvgLzGlKTI2RLPMIxJvmnzGvpnGKdXwgqVS2KwyN5RF7SlhEbj+A398l8OpO5G
 KC4CUeBQKafKEfEmS1hbeiH1LgxIANTz7VUOg/FJWDLXG3CMRqBoaUHe9gTfsW7cfKu0
 KnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694297856; x=1694902656;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dc9VOGNceEJmIXGI7jsbAqrLY4ZgsXSZ2JCKwpqBX3s=;
 b=MAk33mTLWBPqh5FQ80Jx2AN8g50CHE6AiP+h545i+ESxZDnpxVg/xNnHWXHGdyHTW8
 TG/GmHWhlBfmjnbwnEWwcuBT/xXclKpqWAQvXvDYRXN8D+0WibtxysVd9Psvb3amHswC
 fp6Nq3ASHcChRx+081pNCE3ugfd+YUkq9eeBBAzVcW5jA6UIZyFOgOcLjk45anj9B47k
 B9TFENExzYUyML6rmsjIwoopMJdP5DixlznBBzrVyGODtDYY5Bc9kqBbIoqTY8iAM0ze
 ChSTzhQMXOE8otQFZDMWDncCR5xcFm7wlkbxMaKplHdGRmUUio4Oh8sUdIxES7chOKYe
 Xd5A==
X-Gm-Message-State: AOJu0Yzyfe+k/axzd9yDex5WxgAwvfugheyN49T7jFxSR7UmpOpr2egj
 w7d0iCQJE6VCnAaMZX2Vm2oj6A==
X-Google-Smtp-Source: AGHT+IG21YrHYhp0yrEbGLZDsAcPsHsVfli/TWAv3eD3X38h6HHOdrB0bvWq4MYadaZ0XEm3Hy0LiQ==
X-Received: by 2002:a17:902:9892:b0:1b8:2c6f:3248 with SMTP id
 s18-20020a170902989200b001b82c6f3248mr5648946plp.39.1694297855707; 
 Sat, 09 Sep 2023 15:17:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 cm16-20020a17090afa1000b00262d9b4b527sm3189379pjb.52.2023.09.09.15.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 15:17:35 -0700 (PDT)
Message-ID: <ee44a348-4e8d-876d-286e-1c6ac8a4b181@linaro.org>
Date: Sat, 9 Sep 2023 15:17:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] target/alpha: Tidy up alpha_cpu_class_by_name()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230908112235.75914-1-philmd@linaro.org>
 <20230908112235.75914-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230908112235.75914-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/8/23 04:22, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/alpha/cpu.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

