Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A474B7EB567
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:15:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wzb-0002rJ-Ft; Tue, 14 Nov 2023 12:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2wzX-0002nR-IN
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:14:24 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2wzV-0008EA-Ub
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:14:23 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54796f18365so1618139a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 09:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699982060; x=1700586860; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VjIw4Bu3EPxhdXeKr7A+9QZgOLb13tZ8T17jgSOeo4o=;
 b=V07ClREs9aD64viu8z8mwUNBMcBnhSZHN9L6prviJAvvltEd+1dJUY4dhtfI/Jmd6r
 whBds/Ju/5G1jmwKvyDsCQbBJkFKw/djPn2Pt4gPb8Mycc/yzCCawS7lsqPkKsfncmqH
 MeDHmH7I6p3skGZYYG7NXsh3hWG45UL0yK7p7uRcSBoyudd3sofcKJS2GXuzWF86mGrC
 dhgk8bY9V8aeK/GA2VziRa+LXReKZlbaKB1nr4Vs3s64hRQpPmZP++cs9CbiP1QvAAYg
 0myGsJA8LvjKjORk2FhBjqgqNmzV7S9W5r5ErW1SD+z5AflfNLyBvf6dMYpaQ1SQuYaM
 jovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699982060; x=1700586860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VjIw4Bu3EPxhdXeKr7A+9QZgOLb13tZ8T17jgSOeo4o=;
 b=Y9zYbJuIbA9hnIyQ0+933YIva5VpgbQ+fwmArcKyw8r216e9TwvyrTjAaQRCD05fSZ
 jvXiUc9UfuAnMQhKtBnLpw5AQLl86ZYnFSzzZUYk/Of0NV03CyuDbx7npf3frKoSZ1FI
 LDcAWIRxAJgCJPeBSh7PJEGePObJPsugX05M1eDlQUH//u3iKodbfCEAYN1EWS/cDphO
 cKLHrHKwFhTu1mg2hjqR2nZV8NVexhwC3K53/cXGguh7gjjfDuOTlvXxW7YH/57d4ZuE
 fkudOh6cU4Fc6kAAePHjep959xOyQwRjR8EGDFVDhN5LE9mBG+x3HrWjh0lgF6nWvR1i
 X9Pg==
X-Gm-Message-State: AOJu0YwNM129STi2rwN52ESJ6AgfUUY9hJ5PR5jGYmCZWpDa6RuImDkS
 WovrjfM6eTCgU0EOahssA/LYhWTjb3+BlJ7DxIPVgw==
X-Google-Smtp-Source: AGHT+IH0vju27kcjmQ8fT0Duy/cjOt+YNTv1ML5wL8bcntAnpC9utzUmYUPqpOAIsa1BlbaNUVt6G2OcA8fRTwkMC4M=
X-Received: by 2002:aa7:d48c:0:b0:545:5601:414d with SMTP id
 b12-20020aa7d48c000000b005455601414dmr3139481edr.17.1699982059869; Tue, 14
 Nov 2023 09:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20231114165404.681826-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20231114165404.681826-1-ben.dooks@codethink.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2023 17:14:08 +0000
Message-ID: <CAFEAcA-MG+ak8+xVyqgpWqmKAryOXJtOckUmA=GysQwnpuz5SQ@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3: ICC_PMR_EL1 high bits should be RAZ
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 14 Nov 2023 at 16:54, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> The ICC_PMR_ELx bit msak returned from icc_fullprio_mask
> should technically also remove any bit above 7 as these
> are marked reserved (read 0) and should therefore should
> not be written as anything other than 0.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  hw/intc/arm_gicv3_cpuif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index d07b13eb27..986044df79 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -803,7 +803,7 @@ static uint32_t icc_fullprio_mask(GICv3CPUState *cs)
>       * with the group priority, whose mask depends on the value of BPR
>       * for the interrupt group.)
>       */
> -    return ~0U << (8 - cs->pribits);
> +    return (~0U << (8 - cs->pribits)) & 0xff;
>  }

The upper bits of ICC_PMR_ELx are defined as RES0, which has a
complicated technical definition which you can find in the GIC
architecture specification glossary. It's valid for RES0 bits to
be implemented as reads-as-written, which is the way our current
implementation works. Valid guest code should never be writing
any non-zero value into those bits.

What problem are you running into that you're trying to fix
with this patch? If our implementation misbehaves as a result
of letting these high bits through into cs->icc_pmr_el1 that
would be a good reason for making the change.

If we do want to change this, for consistency we'd want
to change icv_fullprio_mask() too.

thanks
-- PMM

