Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD061772B0B
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:35:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3Bx-0004ix-NF; Mon, 07 Aug 2023 12:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1qT3Bu-0004i8-9s
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:34:46 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1qT3Bs-00020x-Hi
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:34:46 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b9e6cc93d8so75535791fa.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google; t=1691426082; x=1692030882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHxvjnBSRxLQr68jdsdbnmVlyaK76zQk0tdd09tcceM=;
 b=kvnx8gXVTxu+tgPq+HmnQZcFh/kZCUoPqwvhrdZu+fgxx9zXUKS6ZKQT+InQ+I44qQ
 q389rVe7ulvQC7qSBBMNUOvEb6wTzTAJGxA7zG3LciDFcLtgUriqb/XpYCwjy0U6zwX7
 NoxSbRt+eJcwA1Yvd81iEiIDHMv8KTU42aYqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426082; x=1692030882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHxvjnBSRxLQr68jdsdbnmVlyaK76zQk0tdd09tcceM=;
 b=K310THCTd1z9Jgckg6rhRHWdqYPM69SfD2TqudcKvjreBcRppHk4EaYi/rXCDirN9K
 Pq+peP1D67K+yHwU/8QwKLWam24WiIl9BxOnQuCzsvQYZxIhhwrGqxDRJmMME4Nanbu7
 ZiHbGoZwRBgqwrw+w/l6Bsw/UtYb2mjRyYBa63tGJiGDaBkHZbfVgTOx278jcy/Bo5FN
 8ewCF30QHZT8pomwJ6DZlLi0LgOTcd7xjH1zv+2RVr6ybMqEhC24JdsuZXdhjNZOLutl
 x5dyH28/qgsDvsESzVTPvEWUuuWfZzdvI0E1HAMPP28nQaHCgNIkrMfrSg2F/Iqh+t1e
 PCwg==
X-Gm-Message-State: AOJu0YzQ24RC6qOKaYmAtmtPoUX6TS9+h+0WU3/jolVsLRNiDXoFjnT1
 xB0VcZXLg8Il9R8xtdzPGTrjGU9WVuEW3KjcEoJQ
X-Google-Smtp-Source: AGHT+IG47KrvJKbopwyIeA/dLPn5F6IYNA/uFCicSCJmT/DGOHGR+z7CTBq67Zz3PLrbdR23khOYn7ZEYz8Lr3ey+Lc=
X-Received: by 2002:a2e:9bc3:0:b0:2b9:ba02:436c with SMTP id
 w3-20020a2e9bc3000000b002b9ba02436cmr6282035ljj.28.1691426082025; Mon, 07 Aug
 2023 09:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230802124906.24197-1-rbradford@rivosinc.com>
In-Reply-To: <20230802124906.24197-1-rbradford@rivosinc.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 7 Aug 2023 09:34:31 -0700
Message-ID: <CAOnJCUKeOQgajDX06SYsZmiFiHLhrEQ73CAfGXoRe5szeBtO2A@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Implement WARL behaviour for
 mcountinhibit/mcounteren
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=atishp@atishpatra.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Aug 2, 2023 at 5:50=E2=80=AFAM Rob Bradford <rbradford@rivosinc.com=
> wrote:
>
> These are WARL fields - zero out the bits for unavailable counters and
> special case the TM bit in mcountinhibit which is hardwired to zero.
> This patch achieves this by modifying the value written so that any use
> of the field will see the correctly masked bits.
>
> Tested by modifying OpenSBI to write max value to these CSRs and upon
> subsequent read the appropriate number of bits for number of PMUs is
> enabled and the TM bit is zero in mcountinhibit.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
>  target/riscv/csr.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ea7585329e..495ff6a9c2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1834,8 +1834,11 @@ static RISCVException write_mcountinhibit(CPURISCV=
State *env, int csrno,
>  {
>      int cidx;
>      PMUCTRState *counter;
> +    RISCVCPU *cpu =3D env_archcpu(env);
>
> -    env->mcountinhibit =3D val;
> +    /* WARL register - disable unavailable counters; TM bit is always 0 =
*/
> +    env->mcountinhibit =3D
> +        val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR);
>
>      /* Check if any other counter is also monitoring cycles/instructions=
 */
>      for (cidx =3D 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
> @@ -1858,7 +1861,11 @@ static RISCVException read_mcounteren(CPURISCVStat=
e *env, int csrno,
>  static RISCVException write_mcounteren(CPURISCVState *env, int csrno,
>                                         target_ulong val)
>  {
> -    env->mcounteren =3D val;
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +
> +    /* WARL register - disable unavailable counters */
> +    env->mcounteren =3D val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUN=
TEREN_TM |
> +                             COUNTEREN_IR);
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.41.0
>
>

LGTM.
Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish

