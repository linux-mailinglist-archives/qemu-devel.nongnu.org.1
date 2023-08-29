Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC8578CB4E
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2aP-0001P4-Jc; Tue, 29 Aug 2023 13:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2aM-0001OU-TD
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:33:02 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2aK-0003WT-Dx
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:33:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso36687555ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693330379; x=1693935179;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iIq9k8X8YDDOU6/7AhARvSfa59wJRwgUJb86PWbQ7K8=;
 b=rcca8m5IV/iJ9s2IdZZh41jMJCTQJGcz/wMOhGVm8UzfKRQmq8n1xz5l4aF6eAW+6Q
 H58EsBEgLxHYr8SkOv3I8MU1oLXUS8n43eb6c4nnoedB4fS9Row+OLm1xQhceG+YM6WA
 0iARHv4GLe5xL2FumuVGTMHap58XhTjpuxCYqhjbQJN0EsecFLkAQatN7ALZqIO0x3BX
 9xg6OpJWzh1KihwH69eErk+keCbwmvmhMzZlBLk4f/KeF4FFQ+R2UUmh8JLD/4c2KOSE
 vW1iJvcuH/Z2jmfSSn3vK+y4t3rk/bSjoxXZV6kQP4dx926v70DccM/XzsNO6RNpA0XF
 j2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693330379; x=1693935179;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iIq9k8X8YDDOU6/7AhARvSfa59wJRwgUJb86PWbQ7K8=;
 b=kyTIwKJAz4osPE1uZbHCn+/SjziFJiBY73IAPIDiVUXlyQWfqFfpYiPk6wKpJEqe9X
 C7QXAC+UuPFD5zs2yKhkVytIHgE+H93xFLU/6EeXQEFlZlaoqbXJcu1Ji+S0Jtceew8W
 TCHG/s2PnRzjYGUTPvBGhMw8t9DZuG3SBz11LaWndauQsc3UMGJWpTGDvx6FUJnLylGS
 mfenVAYxU4NBh9Ik2f282wYYNa9MnAVSVnTo9bvHRwnd1cnD7BKFoaa4KaG+sMWAEpKY
 sQyXibjtlciUyl2O5cn0ZvAjjJO4nBox40Ptmivg6rhqLszQGzoWUAACnMBNaL8xw8ui
 EZ2g==
X-Gm-Message-State: AOJu0YzixjeAyw6uszLFWq7XbDStJJ4KXMFndHEQ/4QNWG8WIoOap3Zb
 sYLcNv0s74GG2nsyBGqt92WQKA==
X-Google-Smtp-Source: AGHT+IFumzKt7/B+YGFni+cJ1pvTdQieBN/ZwljB9fh+kSLyMXRfWEIQ9y735Oq6+F4Kh2UusF/MDg==
X-Received: by 2002:a17:902:ea93:b0:1bf:64c9:a67c with SMTP id
 x19-20020a170902ea9300b001bf64c9a67cmr26260482plb.22.1693330378883; 
 Tue, 29 Aug 2023 10:32:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902860800b001beef2c9bffsm9618073plo.85.2023.08.29.10.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 10:32:58 -0700 (PDT)
Message-ID: <cb568d18-2e30-f61b-54e1-22b525ced541@linaro.org>
Date: Tue, 29 Aug 2023 10:32:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] target/i386: generalize operand size "ph" for use in
 CVTPS2PD
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20230829165304.114948-1-pbonzini@redhat.com>
 <20230829165304.114948-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829165304.114948-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/29/23 09:53, Paolo Bonzini wrote:
> CVTPS2PD only loads a half-register for memory, like CVTPH2PS.  It can
> reuse the "ph" packed half-precision size to load a half-register,
> but rename it to "xh" because it is now a variation of "x" (it is not
> used only for half-precision values).
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 6 +++---
>   target/i386/tcg/decode-new.h     | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

