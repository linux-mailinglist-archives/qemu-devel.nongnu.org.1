Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E07BA72469A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:45:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XwB-00078s-Cq; Tue, 06 Jun 2023 10:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Xw5-000710-VM
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:45:26 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Xvv-00044y-9y
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:45:25 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-256d1b5f7c0so4630072a91.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686062714; x=1688654714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n1tJ2+L5cHCKhwAu73ijDxV4qbX5hmhJ/fdum4OqMek=;
 b=cXkLIF4OrlCwwa5akW6dvgabsRFZ6lFTOVDKjmpfxXz4lTY3KTJmfW5F7hoesuRxmU
 2+FO+0Dr4z3uMWdcPwpHCykvYjfhFkLqZgGv0U2P6g+usS+IiZP1q2wy5MsofCpv2ue5
 cRhmEiZGubPuEMjPKvxDm+31ru25I2Q9RC6mts3eg+XqpExoX5+zl4gl6ca6tjjHHY5q
 UJsahjQmlhhmRPtCLZpni+X5JKIYupiLAloVfDJSedCk/+Lrhu2i9U8+HCp8KGfAd000
 B5sNQ+do7XxKsE3lH9POmvlm1T23llc6krvgsbICYE6ZwrY2Y7wopLcSGjzNt+vIA4Zi
 3Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686062714; x=1688654714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n1tJ2+L5cHCKhwAu73ijDxV4qbX5hmhJ/fdum4OqMek=;
 b=WBE8fco7qAB48wCq0L9omITNniLKeGA8he2pVoO3aY5dbxap/pnbCrM6NzSDjetOAp
 DHatXMKA1G6XldXMOaCOP+Nu4+osNP2p1WJxJvYpAs/ufYhnutYE6AiT2kSqE4rlf5zg
 RUQkXw0e/3AIP3PBXEzZGZoTqH0ncYB5vTN21zx1+67swdbTd7+IgERABE7Tkfwa/hDv
 abjWxv6Ke3ySFXD1aPSteYdG3rQt7zi7KUa0Dx5IORdbLlZKKL2yH/EmX68GPs6hNwZG
 CnVXdtuaxo/rCSgcdQKkYeAYUDrbQXv+fDkUgKKJW4XAdCYUii5XbeTq5Q6Fxy3QGYgm
 +4rw==
X-Gm-Message-State: AC+VfDwFz+CwZTOj9N2t1QaD2HNeWq1bCT4acviBTTeXcErezQ2V+1f5
 GpKWSAztlVwrgBkjFJGycw3ycA==
X-Google-Smtp-Source: ACHHUZ63LrsaKH1r0pjj2mSEFvB4/oLo+8z9Hh7fu5FMxItxedlN6MUk1BmxdtjbWyyVAmkRUz7aFg==
X-Received: by 2002:a17:90b:2397:b0:250:50c5:cabc with SMTP id
 mr23-20020a17090b239700b0025050c5cabcmr12509845pjb.3.1686062713761; 
 Tue, 06 Jun 2023 07:45:13 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a17090ad3c700b002529f2e570esm7742448pjw.28.2023.06.06.07.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 07:45:13 -0700 (PDT)
Message-ID: <599d706c-070a-c2d3-990e-f6a1720f3485@linaro.org>
Date: Tue, 6 Jun 2023 07:45:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 1/9] target/tricore: Remove pointless
 CONFIG_SOFTMMU guard
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
References: <20230605222420.14776-1-philmd@linaro.org>
 <20230605222420.14776-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605222420.14776-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/5/23 15:24, Philippe Mathieu-Daudé wrote:
> We don't build any user emulation target for Tricore,
> only the system emulation. No need to check for it as
> it is always defined.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/helper.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

