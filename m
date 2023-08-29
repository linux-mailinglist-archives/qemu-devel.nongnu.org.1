Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5819E78CA2F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2AX-0007OL-Nv; Tue, 29 Aug 2023 13:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2AU-0007CU-VY
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:06:19 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2AS-00062m-40
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:06:18 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bc63ef9959so35774945ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328775; x=1693933575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=56QDK0faAC92zLJdFo/FVduVNd5oSQKc+H52plpDONk=;
 b=HmEgMdot68CMkFz0BHfDX+rjSCwl0xC/ZdTPafjk97yHOV0OethyBDkVIr0Va+YBYF
 F/OY1BD2gQvNvsjTRuQzcImAMCRt3ZYPgzPv4RvXBpq7M9KhM7caQBkELd6uPyZC7UNL
 HoZb6CIwRlcJX3DQVIgEXE3uye2V1u4hxtQ77q6Slvlw0UJ9ZPa9jPy/NJdmMXLbWm6i
 DKeWF7sHfB6wDOSuP4mwDG1slEnsweiVrI8NbAZc0qx3etGnb8UIiDatbDxUXdvQ6hX7
 yfbrpa5irN1B8HuNBznZsMeDN50GopTW3qCavPMMgrjsWnR00+abeEkPE8WBRPYuGFjr
 2bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328775; x=1693933575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=56QDK0faAC92zLJdFo/FVduVNd5oSQKc+H52plpDONk=;
 b=Jtg3fJAOWuAYF96PYqOs05R93twAMp8mmI85JhMyoetYdvIn4hySgdgLdbZ6U/597r
 kZtQl6dNfao3rHUhPT24+kFcFtag38DnE6exFzNeVWL4VLtyxX9YJinHQY4r9BS+B8Kf
 lClXDwLuorRdXrP4J76HqEK886iC9tq/JqYHK1RNpNsnspP1dPBjgiFfCNHBvtosSLJb
 aEp/LDCvXbft1FZ9Npuwy3T+KA1msSp6zmZV376iQr4bIyTLScqNxui+aRH/HJX74Txj
 hbznwxwWBdiz/XQZjWuiZxJvkbkb7qSSDnnDz1n+cZkXvpIhl0B12madlkxdn45ezqVt
 IPUQ==
X-Gm-Message-State: AOJu0YwtXlcuKin6lJWuCN2ogFpu89G8sQ+OpGam2ZX3Jf9F3xGSHnzG
 /zZjUmAHK7AIPS3reEGbDQLbqg==
X-Google-Smtp-Source: AGHT+IG/m6z+euEEIeUWKL93JuvIYUBSVxKgIxFHEkdlnYhKJaxoF3jmFTcV/rxB+IeSJaBULdYVWg==
X-Received: by 2002:a17:902:f54f:b0:1bc:7c69:925a with SMTP id
 h15-20020a170902f54f00b001bc7c69925amr36743809plf.33.1693328774699; 
 Tue, 29 Aug 2023 10:06:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a170902d50100b001bf52834696sm9618698plg.207.2023.08.29.10.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 10:06:14 -0700 (PDT)
Message-ID: <3e93ab70-94f5-bd12-534b-20612a5466aa@linaro.org>
Date: Tue, 29 Aug 2023 10:06:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 07/11] target/helper: Remove unnecessary
 'qemu/main-loop.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230828221314.18435-1-philmd@linaro.org>
 <20230828221314.18435-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828221314.18435-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 8/28/23 15:13, Philippe Mathieu-Daudé wrote:
> "qemu/main-loop.h" declares functions related to QEMU's
> main loop mutex, which these files don't access. Remove
> the unused "qemu/main-loop.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/pmu.h                   | 1 -
>   target/arm/ptw.c                     | 1 -
>   target/loongarch/iocsr_helper.c      | 1 -
>   target/loongarch/op_helper.c         | 1 -
>   target/mips/tcg/sysemu/lcsr_helper.c | 1 -
>   target/nios2/op_helper.c             | 1 -
>   target/ppc/int_helper.c              | 1 -
>   target/ppc/machine.c                 | 1 -
>   target/ppc/mem_helper.c              | 1 -
>   target/ppc/mmu_common.c              | 1 -
>   target/ppc/mmu_helper.c              | 1 -
>   target/ppc/power8-pmu.c              | 1 -
>   target/ppc/translate.c               | 1 -
>   target/riscv/csr.c                   | 1 -
>   target/riscv/m128_helper.c           | 1 -
>   target/riscv/op_helper.c             | 1 -
>   target/s390x/tcg/crypto_helper.c     | 1 -
>   target/s390x/tcg/misc_helper.c       | 1 -
>   target/xtensa/dbg_helper.c           | 1 -
>   target/xtensa/fpu_helper.c           | 1 -
>   target/xtensa/mmu_helper.c           | 1 -
>   target/xtensa/op_helper.c            | 1 -
>   target/xtensa/win_helper.c           | 1 -
>   23 files changed, 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

