Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C00247D1835
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:34:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtx79-00062Z-I1; Fri, 20 Oct 2023 17:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtx76-0005xv-LR
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:33:00 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtx6y-0002lI-NP
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:32:58 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9b9faf05f51so189973866b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697837567; x=1698442367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bCdeZnW/5OM0BV6AqBcXJAqHdc5PEUPzhrhUEDPQrQA=;
 b=s4AT7Vp/WQjDgmm6TNdRhUHC6BhB7OOAhAlS/L90aZCrOPsVxJ3XSaV10w9Nozhr+3
 DBNx9SRcJmib9QUtkP3QNBgQc/Kt9GIbXHubmKhX9KXDmPBOCaoNQTEeJiNIC1A2up01
 vwSDQDDzKpODM4SsWwhw9vJx14+NsXHTdE8LeqPxEVA+9ed0hSMOUeuMiLd61Pf9TfvU
 7I/qoNs1SAcizXNRQUA+d5nysYHfJZ8slkzzcEV7Jiu33qebJvxXKVihsrtiLou5EeqB
 SuUhPvONsYz2EkRasYh6niZiPHsc2TaYRS9lohtX4JY5F0sk7V4d3GHsQVbnT43JtKrJ
 dX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697837567; x=1698442367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bCdeZnW/5OM0BV6AqBcXJAqHdc5PEUPzhrhUEDPQrQA=;
 b=D+5CYYHUutjXU13lGnyecX0jk9rE3qziKkMobp6P+lDVNLaqPS9M3n/mvydoYNDHsJ
 JamcD9MZpEtOQ8hRaYJRvqrRkKJxnTeTNC79Zc28JQ8dxv9LprwxC6POmn6vYMrjyySA
 XQS7jPe3jghw8W5irJJZzse9PvTZoodJUwEld5pQwJCA+ZdA0JiRCQ4o/OY8lDNRpsZ7
 dG4QpK9kQJaa5HuI6QgcZznnduN9HIWsRZK418/MWaGsNnmaWAItn1bF5Qojtfou6jIm
 lCZUq0FQ/R/4gbobaYqA5DUxIUGPVz26SqODfRNt8csibLhFHqr+Mldvujid16HEHZ+A
 h2wQ==
X-Gm-Message-State: AOJu0YwFlHLKUgnxznTuBqlC1z2rVIHVPm2qnRoMiuUiyUWNGhM+2esP
 C8VOLGBjSuR0ibCfVU0WxhXLW5nT3nB9L3IFhSA=
X-Google-Smtp-Source: AGHT+IHMA/X9AsZhGTQ+2VGpXw7XYiwrU5+Dlvooy3C1e5RTOr6VTTG9ZpucH9WVCYQyZl7nWlZ5Og==
X-Received: by 2002:a17:907:2ce6:b0:9bd:dfaa:3f3 with SMTP id
 hz6-20020a1709072ce600b009bddfaa03f3mr2260367ejc.7.1697837567450; 
 Fri, 20 Oct 2023 14:32:47 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 kb3-20020a1709070f8300b009adcb6c0f0esm2195075ejc.193.2023.10.20.14.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 14:32:47 -0700 (PDT)
Message-ID: <c807c163-d70e-c8fa-c049-45c669fe1b5e@linaro.org>
Date: Fri, 20 Oct 2023 23:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 61/65] target/hppa: Return zero for r0 from load_gpr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231020204331.139847-1-richard.henderson@linaro.org>
 <20231020204331.139847-62-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020204331.139847-62-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 20/10/23 22:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


