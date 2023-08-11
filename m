Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C78A9778BF0
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 12:23:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUPI2-0001Wl-8s; Fri, 11 Aug 2023 06:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUPI0-0001Tn-4B
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:22:40 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUPHx-0006Uf-LC
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:22:39 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so2314643a12.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691749356; x=1692354156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XpP3rdBE5w+IiQdYR1lx8C/z1R1Ia26ftCFvEKLRgeQ=;
 b=BmzdJZK+FHLfWnDfBaqVmu3t7qEB05/EjGNWYuR52WrDlaJHkM0MZrY70WNt5m1Ebm
 R4bIVlMTvqFGcD5zq2l1pOTsMuMjNIXw8T5MXgYclaSjavNHQnuCJrZy23Hcd6tSVBmv
 qkBEE8HdKyojADY7e42+O4m1vahuW8zzgvbtzKv6NuOwbGD6PSOhJfhf6DQp4XW3d0ZS
 8poPlRYCm3Ag/tGrqduuBxpAh0IWdAj55Gp3BbsyJHo9SHvPIzbM3/O1EG9UGuPv/zLR
 vVfmJ12tprnEvxe3e/h5WCg0MtpLKwX8K+leLucyR4CQrgojo5GANfu10un7qyeC7PQo
 RKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691749356; x=1692354156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XpP3rdBE5w+IiQdYR1lx8C/z1R1Ia26ftCFvEKLRgeQ=;
 b=fW/XbLpk9CjiX1MViPDeIGwuPY6wu5v4UgDJqDsAmc4ViWk+8yCLJABEM5Tseu9yYU
 mp1933B8bTX6Cf3/Zv/ZanOGctt6Ll3wd8S8drLKNzr7Pe2au1quhCD1oXrd4wZP07F7
 3f2V1CDXUmXReSZ8A6aItGDBiQETSU61zaxwV6rtkVhCgn4K7EwQYq4Sf4ghfni61Er8
 2XRC2PQWhHSIVWgOZZQJvpKFsnXpICisZDMjKmrrq4IQ54ultJbAsLqszIX+adMmmceA
 r3xksD9x0CudELxHv2ImiE05d0dZLGT8/ZUg0xlXva9NtB36ysReaKtRIK2zgwazLT15
 GxxA==
X-Gm-Message-State: AOJu0YwFK2ubkFzkTJUeWIImpED3eeSN9k7+Cx9LXz+WAzb+iGL+Yl5F
 HGL7NNwgMRKt2K7ywz643UElbwoiklPvN6yquk8MsA==
X-Google-Smtp-Source: AGHT+IGa1GViyP8+9a2lL2U8L+iUR8m9ZYRISh+frqsO+O5fVpM8b1upGSjrInSDGe2+39lRsyCwgW1azL9QG9X9gSQ=
X-Received: by 2002:a05:6402:3449:b0:523:197c:36e0 with SMTP id
 l9-20020a056402344900b00523197c36e0mr1317966edc.19.1691749355783; Fri, 11 Aug
 2023 03:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-20-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2023 11:22:24 +0100
Message-ID: <CAFEAcA-Z2rEnyf1Lk6swhBQhUCMLjPvoHYfyk-FkspsQ8f5qOQ@mail.gmail.com>
Subject: Re: [PATCH 19/24] tcg/i386: Merge tcg_out_movcond{32,64}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 8 Aug 2023 at 04:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Pass a rexw parameter instead of duplicating the functions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

