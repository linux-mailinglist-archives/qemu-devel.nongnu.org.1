Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4B178D068
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:24:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nq-0001ZB-Pl; Tue, 29 Aug 2023 19:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5KS-0004UB-1h
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:28:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5KP-0004Av-Ig
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:28:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c0d0bf18d7so30049525ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693340921; x=1693945721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AKJOC6I5SaJe95E+HItkl94xl24i0ygcJBTe03UPc6c=;
 b=IsrNoj/v8MQ62uJAjNVUTUgxrFkEylKEUufpDqEgvOYEhVeaFObeM+0q2/3guCfce4
 ZCH3BF8d3lDASqPuLLeyxlgQkQK6PZ8K2lVi4pLyo5Xnw81haRroUbDGsKhWt8XXYs0R
 8naSLm2+/swNzRUvBnEcUIWdO/bKyYf3lPlgIc8aeL/vi6A98yGhef7ZnJ8fQxqrPZTS
 BQsgwq9NAeTqbyLc7YYFaMdPI3gpljbOWPIH1PRHSZYzvsNAeovWkYMQDk12Kja5cwwK
 sXN5elzfG3tpXjxSiAoDDbXJorBJaUTP9wfuwRIgJYiAFdnUMfVuQrV0Ql7qNfYtUUl3
 VcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693340921; x=1693945721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AKJOC6I5SaJe95E+HItkl94xl24i0ygcJBTe03UPc6c=;
 b=BLK4+kl5qXcngkunEB2gHPcsffRQYhZc6pjSnik4edzJtS/sN52MmfvwN2/IO1uLbZ
 lKlP7sD0B6Id7zYyYfaFx8FD7ufHIcAZoELEVwtsvZUvHm2jnUAg4q87fNTg2Wnwt3IY
 Lm+YFzNzPepG9y1hf1X6K+blLHJQk3pyOZVDkbX5tCcFmxST7bp5aFvAbGNbHHapJITD
 iuosiYWGMGlpgrgYwLrtsx1mT1Al23Sm3m33BSFT/izjqQeKRwN/UORYFzlq5z9MFEgH
 vQ87L8eC/UdSorSB8Tjl4Dih0yteklCcrOUlAOCNUl5H7N58/Z+XNf/zytCDT8zX2enI
 trtw==
X-Gm-Message-State: AOJu0YzY1wsA6e/RIr8vloxxcV0+suLN7G1rWdQ04U+X5EfGQkjHB9gk
 b9/mAHtnL20drSRXQgFdR+pClw==
X-Google-Smtp-Source: AGHT+IGvGViOl+chpwLRXTqH/AfPVPU2UYQK7cUFxceReTwA/70KtWL+HeuTMWCWdBlz3OzIrkISwg==
X-Received: by 2002:a17:902:c947:b0:1bd:f314:7896 with SMTP id
 i7-20020a170902c94700b001bdf3147896mr251366pla.25.1693340920670; 
 Tue, 29 Aug 2023 13:28:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a170902f7d400b001b531e8a000sm9281405plw.157.2023.08.29.13.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:28:40 -0700 (PDT)
Message-ID: <c9567536-237e-f587-2d1e-db38d6b6eb30@linaro.org>
Date: Tue, 29 Aug 2023 13:28:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 22/32] bsd-user: Implement freebsd_exec_common, used in
 implementing execve/fexecve.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-23-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-23-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-proc.c | 177 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 177 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

> +    if (do_fexec) {
> +        if (((int)path_or_fd > 0 &&
> +            is_target_elf_binary((int)path_or_fd)) == 1) {
> +            char execpath[PATH_MAX];
> +
> +            /*
> +             * The executable is an elf binary for the target
> +             * arch.  execve() it using the emulator if we can
> +             * determine the filename path from the fd.
> +             */
> +            if (get_filename_from_fd(getpid(), (int)path_or_fd, execpath,
> +                        sizeof(execpath)) != NULL) {
> +                memmove(qarg1 + 2, qarg1, (qargend-qarg1) * sizeof(*qarg1));
> +		qarg1[1] = qarg1[0];
> +		qarg1[0] = (char *)"-0";
> +		qarg1 += 2;
> +		qargend += 2;
> +                *qarg1 = execpath;
> +#ifndef DONT_INHERIT_INTERP_PREFIX
> +                memmove(qarg1 + 2, qarg1, (qargend-qarg1) * sizeof(*qarg1));
> +                *qarg1++ = (char *)"-L";
> +                *qarg1++ = (char *)interp_prefix;
> +#endif

I'm not especailly keen on the ifdef, but I'll let that go.

As for get_filename_from_fd, perhaps it would be cleaner to add a command-line parameter 
which would allow qemu to run from an open file descriptor?  Although perhaps that has 
CLOEXEC implications too...


r~

