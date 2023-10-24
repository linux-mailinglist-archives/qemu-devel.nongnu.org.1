Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 771E97D438F
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 02:05:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4u1-0002vb-Ht; Mon, 23 Oct 2023 20:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1qv4tz-0002vB-5z
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 20:04:07 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1qv4tw-0006Gk-Kb
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 20:04:06 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507c1936fd5so5565490e87.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 17:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698105840; x=1698710640;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gr7cfJqQg77ayxj7s13fub2YDO7k12M2Ww7gVmhpvEE=;
 b=pT4xv8Hy0xPgZ59V+MZ0kmllzFn2/J7ussAI5KWztOcSKzzHq7J8rq8Rr714P69RKu
 ZRrfYCHMu+sf1VOMDTZhtOtUcGQxDGhuPwkGHwT1Wjl2eUeqDAO6on9Osbi4HsJHxgNh
 YyTLvTZ5GZzIl2xCZgukmIA3HIjo9fuPhGkYP32mG+Z2Jj/BPSRudsocq4QUENvCZMat
 FgV5DrPv8EySrQsct90+DODISvFuGG4P6CtCjSLUqnCluv2BvbI3UCcCxCNylnvawP2h
 R+WNKl2uuTHuQHySbo+oHCmwEN9ESMOL03Oiw9PBMCMh8ZymG95B9CNleNoVKXYUxANq
 6C6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698105840; x=1698710640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gr7cfJqQg77ayxj7s13fub2YDO7k12M2Ww7gVmhpvEE=;
 b=apimsUh7PMPuX7A2Ezhjb1JPIaLiQXck9xZ8HqUbyjCOi8Fr3Ftd96yupjynlYYmoZ
 N/S7FoLJHi6qhOFsahn+VAVAVLDYXy7Xf67VeCa86BdUccseJ1qRNnhJ8B6jRAoKbCIe
 j4Cxm8TtYb4McnU8to5LmuDwahQMB1ey8mt5zduHEyXH0Z8k/5fnMKuMqhGYyNCSQdf2
 aCVz4KIDjBRKntCdMh7HbgXfZnNGngPGHkWLzowpLpZS24ByNeRrEgTzjr65xcVZ7yFz
 DcvftKHHvRVMtlDDurQkzsl14hUhF0LHA51pJu9eyTDBZ6BAFtt7N4nEBhw0GszaGC5M
 DSPw==
X-Gm-Message-State: AOJu0YwAtm9zjdeAACHiNetn+vMsxEaCkbAPp6y3Vq4QWYL9YZ4Epkwn
 huYk5EdqhhMvCaoCgcqlNqYLf8bWWSVsh4tNjEAK2Q==
X-Google-Smtp-Source: AGHT+IF8s2IDnT1s0vBOINxSah0kQTMax3Qfc0DDigf+RXEXVsLkCXFn45hsB3x0zblYPEgh36VvU9sikiSJzOsMYmY=
X-Received: by 2002:a05:6512:6cf:b0:500:c00e:8f15 with SMTP id
 u15-20020a05651206cf00b00500c00e8f15mr4571689lff.16.1698105840360; Mon, 23
 Oct 2023 17:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231018154434.17367-1-rbradford@rivosinc.com>
 <20231018154434.17367-2-rbradford@rivosinc.com>
In-Reply-To: <20231018154434.17367-2-rbradford@rivosinc.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 23 Oct 2023 17:03:49 -0700
Message-ID: <CAHBxVyENFHfK24b6nO8z58ACiFQX7J-foCNE8azJKQHPrz3ZFw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] target/riscv: Propagate error from PMU setup
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Oct 18, 2023 at 8:44=E2=80=AFAM Rob Bradford <rbradford@rivosinc.co=
m> wrote:
>
> More closely follow the QEMU style by returning an Error and propagating
> it there is an error relating to the PMU setup.
>
> Further simplify the function by removing the num_counters parameter as
> this is available from the passed in cpu pointer.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/riscv/pmu.c         | 19 +++++++++----------
>  target/riscv/pmu.h         |  3 ++-
>  target/riscv/tcg/tcg-cpu.c |  8 +++++++-
>  3 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 36f6307d28..13801ccb78 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -434,22 +434,21 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint6=
4_t value, uint32_t ctr_idx)
>  }
>
>
> -int riscv_pmu_init(RISCVCPU *cpu, int num_counters)
> +void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
>  {
> -    if (num_counters > (RV_MAX_MHPMCOUNTERS - 3)) {
> -        return -1;
> +    uint8_t pmu_num =3D cpu->cfg.pmu_num;
> +
> +    if (pmu_num > (RV_MAX_MHPMCOUNTERS - 3)) {
> +        error_setg(errp, "Number of counters exceeds maximum available")=
;
> +        return;
>      }
>
>      cpu->pmu_event_ctr_map =3D g_hash_table_new(g_direct_hash, g_direct_=
equal);
>      if (!cpu->pmu_event_ctr_map) {
> -        /* PMU support can not be enabled */
> -        qemu_log_mask(LOG_UNIMP, "PMU events can't be supported\n");
> -        cpu->cfg.pmu_num =3D 0;
> -        return -1;
> +        error_setg(errp, "Unable to allocate PMU event hash table");
> +        return;
>      }
>
>      /* Create a bitmask of available programmable counters */
> -    cpu->pmu_avail_ctrs =3D MAKE_32BIT_MASK(3, num_counters);
> -
> -    return 0;
> +    cpu->pmu_avail_ctrs =3D MAKE_32BIT_MASK(3, pmu_num);
>  }
> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> index 2bfb71ba87..88e0713296 100644
> --- a/target/riscv/pmu.h
> +++ b/target/riscv/pmu.h
> @@ -17,13 +17,14 @@
>   */
>
>  #include "cpu.h"
> +#include "qapi/error.h"
>
>  bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>                                          uint32_t target_ctr);
>  bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
>                                    uint32_t target_ctr);
>  void riscv_pmu_timer_cb(void *priv);
> -int riscv_pmu_init(RISCVCPU *cpu, int num_counters);
> +void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
>  int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
>                                 uint32_t ctr_idx);
>  int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx=
);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index a28918ab30..ed3eb991c0 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -614,7 +614,13 @@ static bool tcg_cpu_realize(CPUState *cs, Error **er=
rp)
>      }
>
>      if (cpu->cfg.pmu_num) {
> -        if (!riscv_pmu_init(cpu, cpu->cfg.pmu_num) && cpu->cfg.ext_sscof=
pmf) {
> +        riscv_pmu_init(cpu, &local_err);
> +        if (local_err !=3D NULL) {
> +            error_propagate(errp, local_err);
> +            return false;
> +        }
> +
> +        if (cpu->cfg.ext_sscofpmf) {
>              cpu->pmu_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                            riscv_pmu_timer_cb, cpu);
>          }
> --
> 2.41.0
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>

