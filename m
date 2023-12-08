Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF94A80AB62
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 18:56:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBf55-0004eb-Ie; Fri, 08 Dec 2023 12:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBf54-0004eI-6Y
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:56:06 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBf52-0006T2-Mk
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:56:05 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d053c45897so21525515ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702058163; x=1702662963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+jP/u8lGlVLSLFJhRc7P674RDlo2t40scYWkindSGFA=;
 b=LcIQ584y3rNQ/O1WOND7qHUXXh44QmnX34t8zBAD4emGcHcjgcNEZXphvlnGBlqo2c
 EtsUlTl5IKC2j7FZW4ZQh5pZN7J27H3MS3KVffULVJq9NRhK0HiY4h4kvNnnhEo09A2Y
 woMIW+tK5i5jjy5QHAVSbKIJEozovlQUSy/UAflx31D+PZ1I1KqX+Wxsink4/0I+8q5c
 Zfxa1iunJ69dgnox3jU5wjwgEGX5dEzDUaDL9tsVcc/aA0N4u1GD64aae3VEAiBUcsMG
 rLNfleIsUNmqm9C1k7wNcQu+7qU2247qQStBaY/oHSquAehg6oqUK3M8j0VZWXmxolu/
 PcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702058163; x=1702662963;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+jP/u8lGlVLSLFJhRc7P674RDlo2t40scYWkindSGFA=;
 b=tkEptzEI80GibZ/Zuyigs4Ab8tnz/1IHQ2pTfGJVkSJ+H78Xyd5fAzgIvsBbXKH9TZ
 S9ZvcQ477+I+WI2oozL0RxFrfGH2/K8m9Fn5x0tEiw8Atj9Cmg7459PyiJ6zojzywndl
 1LWyrVcODLcaRnNyQCtf/dxIiuAoUy1pdbpRIxbt7GBTPlNEe+X4Nw9JrHcNtS9FYlRN
 xir2f1itiKSO5baQUC2Jby1wqf86b0uQfq3USROLnHqha+j5n0NnC/QfTHzBsFu6uZZq
 DNy8+jkbMiw21ZcQylaIKorSYMfdAfNXoRP+GBeHfdaGmU3wb5VpSmHHzDk50lSZrwwp
 jDiA==
X-Gm-Message-State: AOJu0YxH4Yu9gu/a167BR9frF/0QDdDg/0y8yb804ocuRRaYU9J5AN4V
 ML2wxD1d4WlyZGMaswaAllSHKQ==
X-Google-Smtp-Source: AGHT+IFbnf1SXQoc+MRF1O9AklLnLl4G8+WvcP67rviEcnblTIGMLBsilmkKXzHHD/3zyGpkdpJqUQ==
X-Received: by 2002:a17:902:704c:b0:1d0:6ffd:9e23 with SMTP id
 h12-20020a170902704c00b001d06ffd9e23mr447419plt.117.1702058163465; 
 Fri, 08 Dec 2023 09:56:03 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ja19-20020a170902efd300b001d0b0334a9asm1988324plb.155.2023.12.08.09.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 09:56:03 -0800 (PST)
Message-ID: <82bfc320-eea0-4cff-8264-ae92a06e98bc@linaro.org>
Date: Fri, 8 Dec 2023 09:56:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] system/vl: Evaluate icount after accelerator
 options are parsed
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231208113529.74067-1-philmd@linaro.org>
 <20231208113529.74067-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231208113529.74067-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 12/8/23 03:35, Philippe Mathieu-Daudé wrote:
> We need to parse the accelerators first, to be able
> to check whether TCG is enabled or not. Then we can
> parse the -icount option.
> 
> This allows removing the icount_configure() stub.
> 
> Fixes: 7f8b6126e7 ("vl: move icount configuration earlier")
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   stubs/icount.c |  8 --------
>   system/vl.c    | 16 +++++++++-------
>   2 files changed, 9 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

