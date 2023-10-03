Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B1D7B7277
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnlxe-0004ma-4h; Tue, 03 Oct 2023 16:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1qnlxb-0004lo-7I
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:25:39 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1qnlxZ-0000ij-14
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:25:38 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50336768615so1602001e87.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696364734; x=1696969534;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ev38KSd3vQDsnmGeIX19w1k3uojaXHA2nr8aR5yY8/o=;
 b=FVf9LVus4Oa0iHOHeQnzKWRvFpNYBUPA4EfIVo8dH1hdSIVsmdwKigyvEmetQjiaZA
 8Z2Xv1O95GX/wN5mFCSi1gsGQ7W5p039owqA9kp66twaWtOeLtEwqem5yXV0SLNoiPoK
 7hNdUcbuRkasu24tw2HlqZ3CK/ghxsTqwnCMzcxTbc0n/CvSN9JdIh3FX6BljNiOVAZA
 FVSr5EgtTEjChVZulC82tyZjvRWchAvMjcvepmQFob1YPl8l3yEkS6JFHZt1cw5cuC7R
 OQEAjPTqXNfreSNNZAgVWvDgU6I/buy/XH+Z6rlzSj0P7gyrTXVNY2Gs69tqp3Y0jCeJ
 3HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696364734; x=1696969534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ev38KSd3vQDsnmGeIX19w1k3uojaXHA2nr8aR5yY8/o=;
 b=GYL9iLOFYWdtntMppM9/mRlUynk8NxuDTqEpjuFS0MRnmjfG3/MsQuB4e/5OULIFdO
 RyIkgDwc2xguLmiYxppyJf2YMLyhg4zSMpybhY0Zy6g73EGxZw/sSmESgeJib1jzQLXM
 KydsxARAhkyAXBwwb1JV1+6zjLGiLyzmaDo0HRVb3bQudpFTEr14EK5ImKcMHsNhJyxl
 XUcj5HMpsGzxQuPjhHc0OwGq2XU/v64CkxV1k4bV83VWN3/SQFQmDYYwsNnzvcfW6WiY
 6Yjdnj4kd6oGNA/Hm1T5Q/tC5lVzslSHAESenAz70chd8J+9DTVOdZTXU6W5H+ZkuvTq
 2Eww==
X-Gm-Message-State: AOJu0YxiE//IABfSlSQhhayHgCTnSOTEnaAefWKbZ9/zIjJ0OM5sEOMl
 dj7sQlMoQPHm2mCYZ1JdD5Yd2ZrMX9M4A/N3QTKxow==
X-Google-Smtp-Source: AGHT+IHu1HjJ1Gbek08gD6IxrqT41fUNgp6Kt+8A/PGcfvR+WdrL4aaX6pYa5tBWGZj5/012b8q6RhNWs1uBuWefoZ4=
X-Received: by 2002:a05:6512:3706:b0:500:ce5f:7635 with SMTP id
 z6-20020a056512370600b00500ce5f7635mr217213lfr.54.1696364734157; Tue, 03 Oct
 2023 13:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231003125107.34859-1-rbradford@rivosinc.com>
 <20231003125107.34859-3-rbradford@rivosinc.com>
In-Reply-To: <20231003125107.34859-3-rbradford@rivosinc.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 3 Oct 2023 13:25:23 -0700
Message-ID: <CAHBxVyHYJjvADsHPCJeheU4_8s1=DfyeApPyV8QpuPnTm2F=Gw@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/riscv: Support discontinuous PMU counters
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

On Tue, Oct 3, 2023 at 5:51=E2=80=AFAM Rob Bradford <rbradford@rivosinc.com=
> wrote:
>
> There is no requirement that the enabled counters in the platform are
> continuously numbered. Add a "pmu-mask" property that, if specified, can
> be used to specify the enabled PMUs. In order to avoid ambiguity if
> "pmu-mask" is specified then "pmu-num" must also match the number of
> bits set in the mask.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
>  target/riscv/cpu.c     |  1 +
>  target/riscv/cpu_cfg.h |  1 +
>  target/riscv/pmu.c     | 15 +++++++++++++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9d79c20c1a..b89b006a76 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1817,6 +1817,7 @@ static void riscv_cpu_add_misa_properties(Object *c=
pu_obj)
>  static Property riscv_cpu_extensions[] =3D {
>      /* Defaults for standard extensions */
>      DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
> +    DEFINE_PROP_UINT32("pmu-mask", RISCVCPU, cfg.pmu_mask, 0),
>      DEFINE_PROP_BOOL("sscofpmf", RISCVCPU, cfg.ext_sscofpmf, false),
>      DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
>      DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 0e6a0f245c..40f7d970bc 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -124,6 +124,7 @@ struct RISCVCPUConfig {
>      bool ext_XVentanaCondOps;
>
>      uint8_t pmu_num;
> +    uint32_t pmu_mask;
>      char *priv_spec;
>      char *user_spec;
>      char *bext_spec;
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 13801ccb78..f97e25a1f6 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -437,6 +437,13 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64=
_t value, uint32_t ctr_idx)
>  void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
>  {
>      uint8_t pmu_num =3D cpu->cfg.pmu_num;
> +    uint32_t pmu_mask =3D cpu->cfg.pmu_mask;
> +
> +    if (pmu_mask && ctpop32(pmu_mask) !=3D pmu_num) {
> +        error_setg(errp, "Mismatch between number of enabled counters in=
 "
> +                         "\"pmu-mask\" and \"pmu-num\"");
> +        return;
> +    }
>

Is that necessary for the default case? I am thinking of marking
pmu-num as deprecated and pmu-mask
as the preferred way of doing things as it is more flexible. There is
no real benefit carrying both.
The default pmu-mask value will change in that case.
We can just overwrite pmu-num with ctpop32(pmu_mask) if pmu-mask is
available. Thoughts ?

>      if (pmu_num > (RV_MAX_MHPMCOUNTERS - 3)) {
>          error_setg(errp, "Number of counters exceeds maximum available")=
;
> @@ -449,6 +456,10 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>
> -    /* Create a bitmask of available programmable counters */
> -    cpu->pmu_avail_ctrs =3D MAKE_32BIT_MASK(3, pmu_num);
> +    /* Create a bitmask of available programmable counters if none suppl=
ied */
> +    if (pmu_mask) {
> +        cpu->pmu_avail_ctrs =3D pmu_mask;
> +    } else {
> +        cpu->pmu_avail_ctrs =3D MAKE_32BIT_MASK(3, pmu_num);
> +    }
>  }
> --
> 2.41.0
>

