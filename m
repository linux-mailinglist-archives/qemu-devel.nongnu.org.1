Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB44878B720
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qagoL-0002nQ-NA; Mon, 28 Aug 2023 14:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qagnr-0002jQ-66
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:17:37 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qagno-0002eb-LT
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:17:30 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso20045685ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693246647; x=1693851447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5S1A86LILieqbYAawvjrJNZmaXoplZeF03sKo53Tp/s=;
 b=n3uwoA1fhnFXgaRWEVSA07u7Nqn5/SKBf6ExrYfEkaj2jbiK8RkGea28pqqveB8pKy
 aCXdmfjDJpvereUJH0dqifHlkIbtgqk0Kv/j66sXelFCUZJeHkFkg9RdyrDGONfHbEdR
 5svBhSo37yrKpUKRBNUIYOCx9fL/QC6SMQlZ+kNTbNzqRT4daZKuCuyjlQ4iArXsScgE
 VzF/rZLLbKRIY3HIaR+JQsa4w9hzMZeuQiNmVOVUsujWP1tUrtwRv3Fki9qPvWOOMMLk
 rxli7CI+pu660CKSOptOaO1LMjL37dAtgJo2YwMrPJUjkOZ5aGgWdnQ+hy0u7IBvafz8
 icKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693246647; x=1693851447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5S1A86LILieqbYAawvjrJNZmaXoplZeF03sKo53Tp/s=;
 b=IZiwm+waKi8oVcXFyNueGo/HZWVFkqxuf5zZ8ixG2GcfoWk/TCgufI8Joau37cjzfj
 WhQo7TqPirEXNrxMmD17g8n0zJOKpokAuc51u+NyvjBGh1c5dgpVZcGaq3xPDyjqS351
 sQ3JNQWYShc+tkppEoBZX/huRPD1R2PYa2CQGgN2wguCROcqouFwIQ0sd0Cj5rR8icBP
 T+OZfr3XNUbFcFEtxm2PC8MfdV8momOPFWNHpHbU4LeGTez+qRNbCjHKwkTmDglYLPbg
 quY7qXXDHMwp8SKn2Yz6XGnu1PPTNmOpj7RP2llXaePxuY4N012dnIZxYMXW20m06iYJ
 sD/g==
X-Gm-Message-State: AOJu0YwvzEkvbzbl1WBWBW2cFBCvDreLuwPWQgmdYvLbDhuL6a/zufS1
 IL0m9BdN8sbODNi6xcjQ3+oNhw==
X-Google-Smtp-Source: AGHT+IGj0U+9U+vmL6iErRuCJuehDpfNxX8AfPst0g3ZuTVfJvdTRjhIpCDOXMBdCIl31nG4tJzQFw==
X-Received: by 2002:a17:903:41cd:b0:1b8:9ecd:8b86 with SMTP id
 u13-20020a17090341cd00b001b89ecd8b86mr27788426ple.5.1693246647303; 
 Mon, 28 Aug 2023 11:17:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a20-20020a170902ee9400b001bc676df6a9sm7700864pld.132.2023.08.28.11.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 11:17:26 -0700 (PDT)
Message-ID: <7692868e-5617-0642-8284-7dd62273482a@linaro.org>
Date: Mon, 28 Aug 2023 11:17:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 07/11] target/tricore: Implement hptof insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
 <20230828112651.522058-8-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828112651.522058-8-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 04:26, Bastian Koppelmann wrote:
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1667
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
> v1 -> v2:
>      - Removed special case for f_arg being infinity
>      - Clarified, why we need a special case for arg being NAN
> 
>   target/tricore/fpu_helper.c               | 36 +++++++++++++++++++++++
>   target/tricore/helper.h                   |  1 +
>   target/tricore/translate.c                |  7 +++++
>   target/tricore/tricore-opcodes.h          |  1 +
>   tests/tcg/tricore/Makefile.softmmu-target |  1 +
>   tests/tcg/tricore/asm/test_hptof.S        | 12 ++++++++
>   6 files changed, 58 insertions(+)
>   create mode 100644 tests/tcg/tricore/asm/test_hptof.S

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

