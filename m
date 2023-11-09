Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF207E6D5C
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:24:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16tL-0001RJ-5N; Thu, 09 Nov 2023 10:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16tI-0001IV-EB
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:24:20 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16tG-0001i6-Lb
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:24:20 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo1541425a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699543457; x=1700148257; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u073M315NvHUPimKYcjW8iahiuQzGe6hOaGotA0j7Ao=;
 b=Ls6kovyL299lH9qoEKyKhuh/OxDJgAJT4lsD5p6SbvDvckfRR5THI5QYT75cHcHbXZ
 cB2mb4wmUMWgj2d2yN0PCeOuwpdAZjD3nmFuNirYFeWP532Hm8wmI9Piqv44OMBQJkYo
 PXzy6RIr5G7TBQNeL8ExCCvG/RqjyQoUCfPy1WFD/bzW8nxHaL2suuz40PKMuHvrmxZA
 pRl2ocBIYkW3IDzkC4TpHHxc2prSowWFV9+mFryQcbzW3xHk5d3MxDLDhDwK6dhcuWJm
 QTZCvseL9DusWaAzcmzlR9EPywajclBRLi4TYYBOYRWcSOog8UHlEid3RUmxz8JpKodj
 eVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699543457; x=1700148257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u073M315NvHUPimKYcjW8iahiuQzGe6hOaGotA0j7Ao=;
 b=wHo3EDm48QD74XywmoEkxO3emRUrw8qTf8f1lZ3+1wEzsg2S51tQLwH37nxCF4hRS5
 wFvg8YbSH1uz/vvxgfYGdmDth84tAa8L4OfVZco7kNY2hEFe2UyxR3nSvJeYlTxWfIz0
 03I8bXU+8ar6hg4HKhYh+7OMf247S8IBqfYuBr3QOAfrJb+XzSBF+NxDTXPufhsRVk/E
 /8KUabZwc60UtV9It9XSDWUTRDm7qJoaC1MvRO0B5my27ril3r2YxO+OaIseANzzavrH
 Ul+rl49bsa51WNibP4boQ8ghJTlAybMzhXWeJE33OoUCSFe8eu/n4RY85Dtes1takD/q
 /pZw==
X-Gm-Message-State: AOJu0Yx9MyiHlLeXslL4ku0+MHwAc/C1BHVxg2L8J0rW8o9OhwBHx9c3
 mpY2uNalIKcx+B5m20uaZe5DI3GF6XnsYiPes6tEQbkHfNSGPAWY
X-Google-Smtp-Source: AGHT+IF95AK4N5kJUEi6Jpb0lab2Hbd7gUexHp3pyvB460GLLOKrJhdmid4stmNSzDYV2deUkoCh13fjBdbzcEzC22M=
X-Received: by 2002:a50:d081:0:b0:544:b0f4:f13 with SMTP id
 v1-20020a50d081000000b00544b0f40f13mr4510779edd.23.1699543457124; Thu, 09 Nov
 2023 07:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
 <20231107022946.1055027-47-alistair.francis@wdc.com>
In-Reply-To: <20231107022946.1055027-47-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 15:24:06 +0000
Message-ID: <CAFEAcA_DrOBcQytM+UkMNEFFgEhOYqbKnnSREhRY+UsEwD+RbQ@mail.gmail.com>
Subject: Re: [PULL 46/49] target/riscv: Don't assume PMU counters are
 continuous
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Rob Bradford <rbradford@rivosinc.com>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 7 Nov 2023 at 02:36, Alistair Francis <alistair23@gmail.com> wrote:
>
> From: Rob Bradford <rbradford@rivosinc.com>
>
> Check the PMU available bitmask when checking if a counter is valid
> rather than comparing the index against the number of PMUs.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Message-ID: <20231031154000.18134-3-rbradford@rivosinc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index fc26b52c88..fde7ce1a53 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -188,7 +188,8 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
>  #if !defined(CONFIG_USER_ONLY)
>  static RISCVException mctr(CPURISCVState *env, int csrno)
>  {
> -    int pmu_num = riscv_cpu_cfg(env)->pmu_num;
> +    RISCVCPU *cpu = env_archcpu(env);
> +    uint32_t pmu_avail_ctrs = cpu->pmu_avail_ctrs;
>      int ctr_index;
>      int base_csrno = CSR_MHPMCOUNTER3;
>
> @@ -197,7 +198,7 @@ static RISCVException mctr(CPURISCVState *env, int csrno)
>          base_csrno += 0x80;
>      }
>      ctr_index = csrno - base_csrno;
> -    if (!pmu_num || ctr_index >= pmu_num) {
> +    if ((BIT(ctr_index) & pmu_avail_ctrs >> 3) == 0) {
>          /* The PMU is not enabled or counter is out of range */
>          return RISCV_EXCP_ILLEGAL_INST;
>      }

Hi; Coverity is not convinced that ctr_index is necessarily
guaranteed to be within the valid range to be an argument
to BIT() (eg that it won't be negative). Looking at the
code as a human I'm pretty unsure too. Could somebody have
a look at this and maybe improve the readability / add an
assertion / fix a bug if any ? (CID 1523910)

More generally there are about half a dozen other riscv
issues in Coverity at the moment, so if somebody who knows
the riscv code could have a look at them that would be great.

thanks
-- PMM

