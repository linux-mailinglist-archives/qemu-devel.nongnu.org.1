Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7E3849209
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Feb 2024 01:24:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWmlq-0007HG-6k; Sun, 04 Feb 2024 19:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWmlk-0007F7-MK; Sun, 04 Feb 2024 19:23:30 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWmlh-0002yT-GZ; Sun, 04 Feb 2024 19:23:27 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7cedcea89a0so1991621241.1; 
 Sun, 04 Feb 2024 16:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707092603; x=1707697403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOA/Q+UawU681ET19ArYRw+EFfInAwcv9LKE6/6659I=;
 b=isj8KG5RebesRhK+JDKZ2PkhrYiOz1QqxrkJFbjISGFLVkG41L2quPaJUpLerghI+g
 BjjK9oVw0UXFHXWgIgc3BAySBqakkljlr6gLLiBlUggFY9v8XlSBL4GSOX2kRrnvr2td
 S9GaalIKcfk6meJjdTewPRYoM8jY9grbWDYzLIZ70JZ+IOmBw+OBwiSV9NuZvo5WLjT2
 kwA5Y3K5gZIJenHjsCbgbVvTUYoyW7Ijck/1K/Q9fa1d/+rPmiM4l3P30nsXqLeEXb5i
 1nwS99lKzG+isz035DKQCmdZZ8GW2LGMLiebRWhcqU5tUHN8bzHm0D7eK4L1BMbHP/+F
 KaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707092603; x=1707697403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOA/Q+UawU681ET19ArYRw+EFfInAwcv9LKE6/6659I=;
 b=byape9oSeSm6CfSNxwajqOe9cCY8tsj/g7PkfzZc5GXR3qLfznPnWUEs3Dp/wZpSXB
 vvfRIWezCBPQ9yKl67a9pDtkwwJwcNzGG2JaMlSBqtFFyEDUbtu0+x4CGcJIoLW4L4Qq
 I6iUiwYmrmWiRGyP/NM6dCHZNbwwfOWAuyh9S6Wb9vsRMkFvcPBhid0T5aq17blC96AV
 fIpkXviNLWoi0iw8Q6XuWbaBSZHUzpmSNf3xKuPdU+frvp0VBR2sHSlw5/ilXzA4RhW/
 lBuD7l9euSESTqCpkv+kv4sZfXyxBYniRvlBt07VdMrTKBxNL3iTap5glgzO5nKe+9VA
 6Srw==
X-Gm-Message-State: AOJu0YzGrDyieznZU6zzBZz7O4WtMQlHvU4pFZJmbRhzccyjWV2LxLrC
 P1UxMv/yvu6tZnkte8IoVBNUOolIKNaW2jQtZrFqwGueOksqAJ/E2v/4Y9gh3uX/YQ+kHjyZclh
 2+qaZySxhfrUR7Ehaompb+lHpkLE=
X-Google-Smtp-Source: AGHT+IGwsmqyNRS9O8RGKSAZE275EVKb0P3KvFyccGbFGRG8jP1QEITD8rF2KNFfughbvQBSdT/kGP8MsMAk942Ftg4=
X-Received: by 2002:a05:6122:c96:b0:4bd:355e:dec5 with SMTP id
 ba22-20020a0561220c9600b004bd355edec5mr8818039vkb.12.1707092603034; Sun, 04
 Feb 2024 16:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20240130110844.437-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240130110844.437-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 10:22:57 +1000
Message-ID: <CAKmqyKMbKX+pE8PgbH8fzifnYi3-FR6zFCySGzhi044Yyx0REA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Use RISCVException as return type for all
 csr ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 qemu-riscv@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jan 30, 2024 at 10:49=E2=80=AFPM LIU Zhiwei
<zhiwei_liu@linux.alibaba.com> wrote:
>
> The real return value type has been converted to RISCVException,
> but some function declarations still not. This patch makes all
> csr operation declarations use RISCVExcetion.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 117 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 74 insertions(+), 43 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 674ea075a4..ac9a856cc5 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -242,7 +242,7 @@ static RISCVException any32(CPURISCVState *env, int c=
srno)
>
>  }
>
> -static int aia_any(CPURISCVState *env, int csrno)
> +static RISCVException aia_any(CPURISCVState *env, int csrno)
>  {
>      if (!riscv_cpu_cfg(env)->ext_smaia) {
>          return RISCV_EXCP_ILLEGAL_INST;
> @@ -251,7 +251,7 @@ static int aia_any(CPURISCVState *env, int csrno)
>      return any(env, csrno);
>  }
>
> -static int aia_any32(CPURISCVState *env, int csrno)
> +static RISCVException aia_any32(CPURISCVState *env, int csrno)
>  {
>      if (!riscv_cpu_cfg(env)->ext_smaia) {
>          return RISCV_EXCP_ILLEGAL_INST;
> @@ -269,7 +269,7 @@ static RISCVException smode(CPURISCVState *env, int c=
srno)
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
>
> -static int smode32(CPURISCVState *env, int csrno)
> +static RISCVException smode32(CPURISCVState *env, int csrno)
>  {
>      if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
>          return RISCV_EXCP_ILLEGAL_INST;
> @@ -278,7 +278,7 @@ static int smode32(CPURISCVState *env, int csrno)
>      return smode(env, csrno);
>  }
>
> -static int aia_smode(CPURISCVState *env, int csrno)
> +static RISCVException aia_smode(CPURISCVState *env, int csrno)
>  {
>      if (!riscv_cpu_cfg(env)->ext_ssaia) {
>          return RISCV_EXCP_ILLEGAL_INST;
> @@ -287,7 +287,7 @@ static int aia_smode(CPURISCVState *env, int csrno)
>      return smode(env, csrno);
>  }
>
> -static int aia_smode32(CPURISCVState *env, int csrno)
> +static RISCVException aia_smode32(CPURISCVState *env, int csrno)
>  {
>      if (!riscv_cpu_cfg(env)->ext_ssaia) {
>          return RISCV_EXCP_ILLEGAL_INST;
> @@ -496,7 +496,7 @@ static RISCVException pointer_masking(CPURISCVState *=
env, int csrno)
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
>
> -static int aia_hmode(CPURISCVState *env, int csrno)
> +static RISCVException aia_hmode(CPURISCVState *env, int csrno)
>  {
>      if (!riscv_cpu_cfg(env)->ext_ssaia) {
>          return RISCV_EXCP_ILLEGAL_INST;
> @@ -505,7 +505,7 @@ static int aia_hmode(CPURISCVState *env, int csrno)
>       return hmode(env, csrno);
>  }
>
> -static int aia_hmode32(CPURISCVState *env, int csrno)
> +static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
>  {
>      if (!riscv_cpu_cfg(env)->ext_ssaia) {
>          return RISCV_EXCP_ILLEGAL_INST;
> @@ -681,7 +681,8 @@ static RISCVException read_vl(CPURISCVState *env, int=
 csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_vlenb(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_vlenb(CPURISCVState *env, int csrno,
> +                                 target_ulong *val)
>  {
>      *val =3D riscv_cpu_cfg(env)->vlen >> 3;
>      return RISCV_EXCP_NONE;
> @@ -742,13 +743,15 @@ static RISCVException write_vstart(CPURISCVState *e=
nv, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_vcsr(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_vcsr(CPURISCVState *env, int csrno,
> +                                target_ulong *val)
>  {
>      *val =3D (env->vxrm << VCSR_VXRM_SHIFT) | (env->vxsat << VCSR_VXSAT_=
SHIFT);
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_vcsr(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_vcsr(CPURISCVState *env, int csrno,
> +                                 target_ulong val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      env->mstatus |=3D MSTATUS_VS;
> @@ -798,13 +801,15 @@ static RISCVException read_timeh(CPURISCVState *env=
, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_hpmcounter(CPURISCVState *env, int csrno, target_ulong *=
val)
> +static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
>  {
>      *val =3D get_ticks(false);
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong =
*val)
> +static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
>  {
>      *val =3D get_ticks(true);
>      return RISCV_EXCP_NONE;
> @@ -812,7 +817,8 @@ static int read_hpmcounterh(CPURISCVState *env, int c=
srno, target_ulong *val)
>
>  #else /* CONFIG_USER_ONLY */
>
> -static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong *v=
al)
> +static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
> +                                     target_ulong *val)
>  {
>      int evt_index =3D csrno - CSR_MCOUNTINHIBIT;
>
> @@ -821,7 +827,8 @@ static int read_mhpmevent(CPURISCVState *env, int csr=
no, target_ulong *val)
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_mhpmevent(CPURISCVState *env, int csrno, target_ulong v=
al)
> +static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
> +                                      target_ulong val)
>  {
>      int evt_index =3D csrno - CSR_MCOUNTINHIBIT;
>      uint64_t mhpmevt_val =3D val;
> @@ -837,7 +844,8 @@ static int write_mhpmevent(CPURISCVState *env, int cs=
rno, target_ulong val)
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_mhpmeventh(CPURISCVState *env, int csrno, target_ulong *=
val)
> +static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
>  {
>      int evt_index =3D csrno - CSR_MHPMEVENT3H + 3;
>
> @@ -846,7 +854,8 @@ static int read_mhpmeventh(CPURISCVState *env, int cs=
rno, target_ulong *val)
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_mhpmeventh(CPURISCVState *env, int csrno, target_ulong =
val)
> +static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
> +                                       target_ulong val)
>  {
>      int evt_index =3D csrno - CSR_MHPMEVENT3H + 3;
>      uint64_t mhpmevth_val =3D val;
> @@ -860,7 +869,8 @@ static int write_mhpmeventh(CPURISCVState *env, int c=
srno, target_ulong val)
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong=
 val)
> +static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
> +                                        target_ulong val)
>  {
>      int ctr_idx =3D csrno - CSR_MCYCLE;
>      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> @@ -885,7 +895,8 @@ static int write_mhpmcounter(CPURISCVState *env, int =
csrno, target_ulong val)
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulon=
g val)
> +static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
> +                                         target_ulong val)
>  {
>      int ctr_idx =3D csrno - CSR_MCYCLEH;
>      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> @@ -945,7 +956,8 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVStat=
e *env, target_ulong *val,
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_hpmcounter(CPURISCVState *env, int csrno, target_ulong *=
val)
> +static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
>  {
>      uint16_t ctr_index;
>
> @@ -960,7 +972,8 @@ static int read_hpmcounter(CPURISCVState *env, int cs=
rno, target_ulong *val)
>      return riscv_pmu_read_ctr(env, val, false, ctr_index);
>  }
>
> -static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong =
*val)
> +static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
>  {
>      uint16_t ctr_index;
>
> @@ -975,7 +988,8 @@ static int read_hpmcounterh(CPURISCVState *env, int c=
srno, target_ulong *val)
>      return riscv_pmu_read_ctr(env, val, true, ctr_index);
>  }
>
> -static int read_scountovf(CPURISCVState *env, int csrno, target_ulong *v=
al)
> +static RISCVException read_scountovf(CPURISCVState *env, int csrno,
> +                                     target_ulong *val)
>  {
>      int mhpmevt_start =3D CSR_MHPMEVENT3 - CSR_MCOUNTINHIBIT;
>      int i;
> @@ -1638,7 +1652,8 @@ static RISCVException rmw_mvienh(CPURISCVState *env=
, int csrno,
>      return ret;
>  }
>
> -static int read_mtopi(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_mtopi(CPURISCVState *env, int csrno,
> +                                 target_ulong *val)
>  {
>      int irq;
>      uint8_t iprio;
> @@ -1678,8 +1693,9 @@ static int aia_xlate_vs_csrno(CPURISCVState *env, i=
nt csrno)
>      };
>  }
>
> -static int rmw_xiselect(CPURISCVState *env, int csrno, target_ulong *val=
,
> -                        target_ulong new_val, target_ulong wr_mask)
> +static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
> +                                   target_ulong *val, target_ulong new_v=
al,
> +                                   target_ulong wr_mask)
>  {
>      target_ulong *iselect;
>
> @@ -1758,8 +1774,9 @@ static int rmw_iprio(target_ulong xlen,
>      return 0;
>  }
>
> -static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
> -                     target_ulong new_val, target_ulong wr_mask)
> +static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
> +                                target_ulong *val, target_ulong new_val,
> +                                target_ulong wr_mask)
>  {
>      bool virt, isel_reserved;
>      uint8_t *iprio;
> @@ -1833,8 +1850,9 @@ done:
>      return RISCV_EXCP_NONE;
>  }
>
> -static int rmw_xtopei(CPURISCVState *env, int csrno, target_ulong *val,
> -                      target_ulong new_val, target_ulong wr_mask)
> +static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
> +                                 target_ulong *val, target_ulong new_val=
,
> +                                 target_ulong wr_mask)
>  {
>      bool virt;
>      int ret =3D -EINVAL;
> @@ -3031,7 +3049,8 @@ static RISCVException write_satp(CPURISCVState *env=
, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_vstopi(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_vstopi(CPURISCVState *env, int csrno,
> +                                  target_ulong *val)
>  {
>      int irq, ret;
>      target_ulong topei;
> @@ -3120,7 +3139,8 @@ static int read_vstopi(CPURISCVState *env, int csrn=
o, target_ulong *val)
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_stopi(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_stopi(CPURISCVState *env, int csrno,
> +                                 target_ulong *val)
>  {
>      int irq;
>      uint8_t iprio;
> @@ -3576,19 +3596,21 @@ static RISCVException write_htimedeltah(CPURISCVS=
tate *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_hvictl(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_hvictl(CPURISCVState *env, int csrno,
> +                                  target_ulong *val)
>  {
>      *val =3D env->hvictl;
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_hvictl(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_hvictl(CPURISCVState *env, int csrno,
> +                                   target_ulong val)
>  {
>      env->hvictl =3D val & HVICTL_VALID_MASK;
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_hvipriox(CPURISCVState *env, int first_index,
> +static RISCVException read_hvipriox(CPURISCVState *env, int first_index,
>                           uint8_t *iprio, target_ulong *val)
>  {
>      int i, irq, rdzero, num_irqs =3D 4 * (riscv_cpu_mxl_bits(env) / 32);
> @@ -3614,7 +3636,7 @@ static int read_hvipriox(CPURISCVState *env, int fi=
rst_index,
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_hvipriox(CPURISCVState *env, int first_index,
> +static RISCVException write_hvipriox(CPURISCVState *env, int first_index=
,
>                            uint8_t *iprio, target_ulong val)
>  {
>      int i, irq, rdzero, num_irqs =3D 4 * (riscv_cpu_mxl_bits(env) / 32);
> @@ -3640,42 +3662,50 @@ static int write_hvipriox(CPURISCVState *env, int=
 first_index,
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_hviprio1(CPURISCVState *env, int csrno, target_ulong *va=
l)
> +static RISCVException read_hviprio1(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
>  {
>      return read_hvipriox(env, 0, env->hviprio, val);
>  }
>
> -static int write_hviprio1(CPURISCVState *env, int csrno, target_ulong va=
l)
> +static RISCVException write_hviprio1(CPURISCVState *env, int csrno,
> +                                     target_ulong val)
>  {
>      return write_hvipriox(env, 0, env->hviprio, val);
>  }
>
> -static int read_hviprio1h(CPURISCVState *env, int csrno, target_ulong *v=
al)
> +static RISCVException read_hviprio1h(CPURISCVState *env, int csrno,
> +                                     target_ulong *val)
>  {
>      return read_hvipriox(env, 4, env->hviprio, val);
>  }
>
> -static int write_hviprio1h(CPURISCVState *env, int csrno, target_ulong v=
al)
> +static RISCVException write_hviprio1h(CPURISCVState *env, int csrno,
> +                                      target_ulong val)
>  {
>      return write_hvipriox(env, 4, env->hviprio, val);
>  }
>
> -static int read_hviprio2(CPURISCVState *env, int csrno, target_ulong *va=
l)
> +static RISCVException read_hviprio2(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
>  {
>      return read_hvipriox(env, 8, env->hviprio, val);
>  }
>
> -static int write_hviprio2(CPURISCVState *env, int csrno, target_ulong va=
l)
> +static RISCVException write_hviprio2(CPURISCVState *env, int csrno,
> +                                     target_ulong val)
>  {
>      return write_hvipriox(env, 8, env->hviprio, val);
>  }
>
> -static int read_hviprio2h(CPURISCVState *env, int csrno, target_ulong *v=
al)
> +static RISCVException read_hviprio2h(CPURISCVState *env, int csrno,
> +                                     target_ulong *val)
>  {
>      return read_hvipriox(env, 12, env->hviprio, val);
>  }
>
> -static int write_hviprio2h(CPURISCVState *env, int csrno, target_ulong v=
al)
> +static RISCVException write_hviprio2h(CPURISCVState *env, int csrno,
> +                                      target_ulong val)
>  {
>      return write_hvipriox(env, 12, env->hviprio, val);
>  }
> @@ -3699,7 +3729,8 @@ static RISCVException write_vsstatus(CPURISCVState =
*env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_vstvec(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_vstvec(CPURISCVState *env, int csrno,
> +                                  target_ulong *val)
>  {
>      *val =3D env->vstvec;
>      return RISCV_EXCP_NONE;
> --
> 2.25.1
>
>

