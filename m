Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E8B748585
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:54:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH2wO-0004ij-NW; Wed, 05 Jul 2023 09:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH2wM-0004iJ-IB
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:53:06 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH2wK-0006yy-Qu
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:53:06 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b6ef64342aso42118851fa.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688565183; x=1691157183;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0uRkTN8qg60w9UdsxDymsO/5BE5XssZaL7cz8WBLbdw=;
 b=BY0C52nrag/qS+TY6mU7mwKuohgzg8/9MO50hpHXL73jH9+QIyrMkxj5sAQPA2Pt6K
 5q5TCHqN9J9YKp3GvRUYX29XRwzdXxIc69zxkdVTTDMcrFQu6JsCjNIXa2apuKEPeIju
 S+HQtF77U8pPJkWctSybg20mjdrzQY6W5JEk0IreqY7HNYqDxNZ3JCRLL2dupGARIqgn
 wSLHMjDkztzVAkrHJRsnMDcaP3ShGcQ5vByMgkbjeSmEoIfCupxviZ8tdrGuS7SYx+bl
 yYkGfbBXTaDZPytI6w93ImkMkKoB6z1Lq9e4gdtcSMRZFlF6J6zkJbpOKilqe/7gLCgn
 7Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688565183; x=1691157183;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0uRkTN8qg60w9UdsxDymsO/5BE5XssZaL7cz8WBLbdw=;
 b=eXOxI5yVSw4f1s5FdRQcjok5sHPdw9oWiJYVJsGkdslPq8HYzNcj/8F8UcITQpsjlX
 pMYzxdi0Ws/l3aGZjh4OLpAPH6mXPnu2gIHM62igzEf8B7Zd6lUY1fE2sv3Z7XLF+EWF
 bEcpoWjg+pw8Xrv7rFisRb4AbGml8bvpe6yPbGDFPe5aMr2DCO0DSZGWzmGoY8r8NPmp
 Gns6qVqgzXNuSHQXR0NnaCcQyKM7MloffZVI5oqRRzS1UMWKFdPhxuTQh+g8Gg9LoctZ
 1XXOcqKtAIpZz/Ib9hSy9ux6SNHByGvJC+5eYMZ2WDirYRSMnka99UKSPAsyswmuOcGZ
 CRag==
X-Gm-Message-State: ABy/qLabo9gSRLQ0y4anJtVim7FXjHZF6EA3fl5tQnWDs2v+DqxwUl/q
 kK6BSNhLJAsIRKSoOAn1TZ53Iw==
X-Google-Smtp-Source: APBJJlFvJAczcikEGqYQB5iucnEo+Imr+cs1PO8Bszfo/evyPs7tZM6EGkTs3YuczHT8bSoMgsoPtg==
X-Received: by 2002:a2e:3a0f:0:b0:2b6:decf:5cbf with SMTP id
 h15-20020a2e3a0f000000b002b6decf5cbfmr7845605lja.32.1688565182744; 
 Wed, 05 Jul 2023 06:53:02 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002b6ee0ff9bbsm1345969ljh.67.2023.07.05.06.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 06:53:02 -0700 (PDT)
Message-ID: <52969943-de97-2d71-5321-175ee83cf73d@linaro.org>
Date: Wed, 5 Jul 2023 15:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] target/arm: Suppress more TCG unimplemented features
 in ID registers
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230704130647.2842917-1-peter.maydell@linaro.org>
 <20230704130647.2842917-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704130647.2842917-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/4/23 15:06, Peter Maydell wrote:
> We already squash the ID register field for FEAT_SPE (the Statistical
> Profiling Extension) because TCG does not implement it and if we
> advertise it to the guest the guest will crash trying to look at
> non-existent system registers.  Do the same for some other features
> which a real hardware Neoverse-V1 implements but which TCG doesn't:
>   * FEAT_TRF (Self-hosted Trace Extension)
>   * Trace Macrocell system register access
>   * Memory mapped trace
>   * FEAT_AMU (Activity Monitors Extension)
>   * FEAT_MPAM (Memory Partitioning and Monitoring Extension)
>   * FEAT_NV (Nested Virtualization)
> 
> Most of these, like FEAT_SPE, are "introspection/trace" type features
> which QEMU is unlikely to ever implement.  The odd-one-out here is
> FEAT_NV -- we could implement that and at some point we probably
> will.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c | 33 +++++++++++++++++++++++++++++----
>   1 file changed, 29 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

