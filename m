Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B35C2712A09
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:56:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zn6-0004PS-JH; Fri, 26 May 2023 11:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Zn1-0004MV-Pu
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:55:39 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Zmy-00008v-Ke
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:55:38 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-534696e4e0aso584287a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685116534; x=1687708534;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/7XBjsNTlyTJXytuq08uMo1C4/N4C+2V/Dt5G0nQqbI=;
 b=Nyf7+iEb7QGMvme6NQyolVVAGjMzr/0EYM71awle5WsDK1WVDqmO50jJD9AA9iYFQc
 Im2ZBTGyS+opU6iMpGyc3KQRi+gtG3mLyr/PB7pRlwSqy65c4+qnFBtzyjdhcppbNi0X
 jYEIl4EOc4NdI4fzwzZwgVrBuR2mtR6O5hD7oUykTwZEdrbCMDSbGFvWHXNa0yoRekPN
 2oY79vpdNUAr1soAzI1Fb7FcGoAvzlo0EG/MP9SpBh6BYpypr/IQ0qBcvVlgaxZaQwdh
 zmAszhS7Q7eyFbiHA/U5r2tuGBb/MxXfWjWeketWtjIkALhh+e2dSfcn0j0FvFfAAlEr
 hkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685116534; x=1687708534;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/7XBjsNTlyTJXytuq08uMo1C4/N4C+2V/Dt5G0nQqbI=;
 b=Mv1rbQ0u8Whv2LRltDS7EZifRuiskFyXnGkuyhUf1lrDsUBJ1FEHL+bZGLyiMuX6nG
 dPiLaN6msJOSBN8YZpEfy9GyHoNwJAywV59FSmOW7FTt2/MOnFkCMLKhNdPSn3rg+RwW
 c6B6s/18r8gDJpR54ABpcK42BATvWkT/KFkqNvv0hG1f777S3SwrHXxAZ7/PxjFCsufv
 t5JbgBB2nxkJ97Oxt/QpByGZ+hMj5ygoVkiBTD42IP2CjSM0qjnsz9OEMgYC6TsQ43uY
 1RjL7/WBzKo+XqWBLgbFj0Y2G6IIFTIf559F/KZRKNR8j0KFfKadro6kvs8xJjzVqndW
 Tn3w==
X-Gm-Message-State: AC+VfDxbyU0DlPDjOgsB9YZOZCu0XW8cdPVMwauLJG3DV9Ao8goKar42
 06KEPUZii9qBD5a1xGcUXGJ9KF5FUsmxe+uGpjI=
X-Google-Smtp-Source: ACHHUZ6HyTJfNkUP0zNgPsrn3oPLu19s79dvbyV9V8LUK3/jBdmlanL6Q7SgOwNkb4NLVCNTv4+urA==
X-Received: by 2002:a17:902:e5c8:b0:1ad:fa2e:17fc with SMTP id
 u8-20020a170902e5c800b001adfa2e17fcmr3351541plf.2.1685116534142; 
 Fri, 26 May 2023 08:55:34 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a170902e54600b001afa7040a70sm3413086plf.276.2023.05.26.08.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 08:55:33 -0700 (PDT)
Message-ID: <3e797413-a8ee-ecd3-8775-b22107cd0418@linaro.org>
Date: Fri, 26 May 2023 08:55:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] atomics: eliminate mb_read/mb_set
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230526081810.423315-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526081810.423315-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 01:18, Paolo Bonzini wrote:
> qatomic_mb_read and qatomic_mb_set were the very first atomic primitives
> introduced for QEMU; their semantics are unclear and they provide a false
> sense of safety.
> 
> The last use of qatomic_mb_read() has been removed, so delete it.
> qatomic_mb_set() instead can survive as an optimized
> qatomic_set()+smp_mb(), similar to Linux's smp_store_mb(), but
> rename it to qatomic_set_mb() to match the order of the two
> operations.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   accel/tcg/cpu-exec.c              |  2 +-
>   accel/tcg/tcg-accel-ops-mttcg.c   |  2 +-
>   accel/tcg/tcg-accel-ops-rr.c      |  4 ++--
>   docs/devel/atomics.rst            | 27 ++++-----------------------
>   include/qemu/atomic.h             |  4 ++--
>   monitor/qmp.c                     |  2 +-
>   softmmu/cpus.c                    |  2 +-
>   softmmu/physmem.c                 |  2 +-
>   target/arm/hvf/hvf.c              |  2 +-
>   tests/unit/test-aio-multithread.c |  2 +-
>   util/qemu-coroutine-lock.c        |  4 ++--
>   11 files changed, 17 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

