Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25A929B2E
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jul 2024 05:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQfWj-0004Ws-Ek; Sun, 07 Jul 2024 23:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQfWh-0004V2-Ai; Sun, 07 Jul 2024 23:58:55 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQfWf-0004Tc-Ht; Sun, 07 Jul 2024 23:58:55 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-48fff45a7daso486422137.2; 
 Sun, 07 Jul 2024 20:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720411132; x=1721015932; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQDJaUoQ0Ad6j7a9LYBknq6RvpDey2QgNS8cE8ikPgs=;
 b=JlGWaydZ4Hv6MR+KPvywSXcxx4Wvdtne1ZkZcTbP3IFtvyP5fckrZGOVze/X2CDMQI
 eHRErGS/urZ2poZEh+02yFGuTDMeBpIpnyzQDpqTmfCvQxNRq6L9FpIHuqkw70/t50nx
 EURnuVsLHmgRI1ZHgIllUhb3oUulciwBPJHXrwj0OW6wDigEvUacPsPe9MpS38xeA0W4
 1XikO2wWAM3fgCd8XSimPkzUF+kUkgwHGcVBYgExoR0K/caJ3MrK/TQKBvCpV4IbjHUl
 H7izLbYTob3LpTTGc+KMrNZ9TbI1qtRXITqkuJZpNJS9DAm4qrZvYj+155PSBjjn0hi+
 L3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720411132; x=1721015932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQDJaUoQ0Ad6j7a9LYBknq6RvpDey2QgNS8cE8ikPgs=;
 b=QWaAvdVIHjPaLUzxUIE07e9TMhakjPtNTIKjUI7LLmwNBrx1fNpVO8kSbhklWLVEev
 +w2qrDXrCRJDZ6t958LVJDDkq+wrpfK7W1tmLJyfFVslsPkRsKGRcMn2dPuCScD+zkq/
 CPihIv3GAUaWiGKSGP1DKK88whegzWFYpXdw3B6qficAG5wspTGgg86bkpHGDso/gg7o
 7nN4SRHvIXCxDFE0911uysrx3UPMmpGFAu7ub5hx2jYhq/3QM7vegp9TH4xAjdnYWc3U
 O7Ch27d+S6e/XshX69GsFdf7i5gQuTCw3JRXiLjs6Nmk9+gYHqq93h+PlPWWaEypwTe+
 Um9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBuL9DZMoVab8TRmTov6mTeUSVetxMCN4aVFNP6AYYdZ+FzbdiHxgM6h+yELuikWRn04Lf+G3kUadee6Zt1yJwwmlDV+0=
X-Gm-Message-State: AOJu0Ywy/VSL/MsWZZOE8y2pKA8CjJEgJdzeM5+cFsCMcFShCJoYMiiG
 wE5HOGfY5jWTbdDHxOTSxgHv5NI+/YTfw5EbjJWy4n6tyAFnAfEW2muUG6RQ3CtqV3mQfaIpBij
 RQujhQW3PYppzC+I/119fOJbadX8=
X-Google-Smtp-Source: AGHT+IFSjJo8J5RUQ+rQQcEBVf3caOtW4IlH/XPWSnMm4EDSUozUh3rTvsZ+9kLCQXUf5qKlGXGfbY1OIO0EvEQU4J8=
X-Received: by 2002:a67:f401:0:b0:48b:8eb3:7dbc with SMTP id
 ada2fe7eead31-48fee7edf73mr7353940137.18.1720411131823; Sun, 07 Jul 2024
 20:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240604090434.37136-1-yumin686@andestech.com>
In-Reply-To: <20240604090434.37136-1-yumin686@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 13:58:25 +1000
Message-ID: <CAKmqyKMFm0g1Ud=1iGoF9DQO9CQi6vmegAKSQh5HUhv0TrjBUQ@mail.gmail.com>
Subject: Re: [PATCH v4] target/riscv: raise an exception when CSRRS/CSRRC
 writes a read-only CSR
To: Yu-Ming Chang <yumin686@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 Alvin Chang <alvinga@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jun 4, 2024 at 7:15=E2=80=AFPM Yu-Ming Chang via <qemu-devel@nongnu=
.org> wrote:
>
> Both CSRRS and CSRRC always read the addressed CSR and cause any read sid=
e
> effects regardless of rs1 and rd fields. Note that if rs1 specifies a reg=
ister
> holding a zero value other than x0, the instruction will still attempt to=
 write
> the unmodified value back to the CSR and will cause any attendant side ef=
fects.
>
> So if CSRRS or CSRRC tries to write a read-only CSR with rs1 which specif=
ies
> a register holding a zero value, an illegal instruction exception should =
be
> raised.
>
> Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
> Signed-off-by: Alvin Chang <alvinga@andestech.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Hi Alistair,
>     This fixed the issue of riscv_csrrw_debug().
>
> Best regards,
> Yuming
>
>  target/riscv/cpu.h       |  4 +++
>  target/riscv/csr.c       | 57 ++++++++++++++++++++++++++++++++++++----
>  target/riscv/op_helper.c |  6 ++---
>  3 files changed, 58 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2d0c02c35b..72921bafc0 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -708,6 +708,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *=
pc,
>  void riscv_cpu_update_mask(CPURISCVState *env);
>  bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>
> +RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> +                          target_ulong *ret_value);
>  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                             target_ulong *ret_value,
>                             target_ulong new_value, target_ulong write_ma=
sk);
> @@ -740,6 +742,8 @@ typedef RISCVException (*riscv_csr_op_fn)(CPURISCVSta=
te *env, int csrno,
>                                            target_ulong new_value,
>                                            target_ulong write_mask);
>
> +RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
> +                               Int128 *ret_value);
>  RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
>                                  Int128 *ret_value,
>                                  Int128 new_value, Int128 write_mask);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 726096444f..aa765678b9 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -4312,7 +4312,7 @@ static RISCVException rmw_seed(CPURISCVState *env, =
int csrno,
>
>  static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
>                                                 int csrno,
> -                                               bool write_mask)
> +                                               bool write)
>  {
>      /* check privileges and return RISCV_EXCP_ILLEGAL_INST if check fail=
s */
>      bool read_only =3D get_field(csrno, 0xC00) =3D=3D 3;
> @@ -4334,7 +4334,7 @@ static inline RISCVException riscv_csrrw_check(CPUR=
ISCVState *env,
>      }
>
>      /* read / write check */
> -    if (write_mask && read_only) {
> +    if (write && read_only) {
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
>
> @@ -4421,11 +4421,22 @@ static RISCVException riscv_csrrw_do64(CPURISCVSt=
ate *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> +                           target_ulong *ret_value)
> +{
> +    RISCVException ret =3D riscv_csrrw_check(env, csrno, false);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0);
> +}
> +
>  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                             target_ulong *ret_value,
>                             target_ulong new_value, target_ulong write_ma=
sk)
>  {
> -    RISCVException ret =3D riscv_csrrw_check(env, csrno, write_mask);
> +    RISCVException ret =3D riscv_csrrw_check(env, csrno, true);
>      if (ret !=3D RISCV_EXCP_NONE) {
>          return ret;
>      }
> @@ -4473,13 +4484,45 @@ static RISCVException riscv_csrrw_do128(CPURISCVS=
tate *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
> +                               Int128 *ret_value)
> +{
> +    RISCVException ret;
> +
> +    ret =3D riscv_csrrw_check(env, csrno, false);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    if (csr_ops[csrno].read128) {
> +        return riscv_csrrw_do128(env, csrno, ret_value,
> +                                 int128_zero(), int128_zero());
> +    }
> +
> +    /*
> +     * Fall back to 64-bit version for now, if the 128-bit alternative i=
sn't
> +     * at all defined.
> +     * Note, some CSRs don't need to extend to MXLEN (64 upper bits non
> +     * significant), for those, this fallback is correctly handling the
> +     * accesses
> +     */
> +    target_ulong old_value;
> +    ret =3D riscv_csrrw_do64(env, csrno, &old_value,
> +                           (target_ulong)0,
> +                           (target_ulong)0);
> +    if (ret =3D=3D RISCV_EXCP_NONE && ret_value) {
> +        *ret_value =3D int128_make64(old_value);
> +    }
> +    return ret;
> +}
> +
>  RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
>                                  Int128 *ret_value,
>                                  Int128 new_value, Int128 write_mask)
>  {
>      RISCVException ret;
>
> -    ret =3D riscv_csrrw_check(env, csrno, int128_nz(write_mask));
> +    ret =3D riscv_csrrw_check(env, csrno, true);
>      if (ret !=3D RISCV_EXCP_NONE) {
>          return ret;
>      }
> @@ -4518,7 +4561,11 @@ RISCVException riscv_csrrw_debug(CPURISCVState *en=
v, int csrno,
>  #if !defined(CONFIG_USER_ONLY)
>      env->debugger =3D true;
>  #endif
> -    ret =3D riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
> +    if (!write_mask) {
> +        ret =3D riscv_csrr(env, csrno, ret_value);
> +    } else {
> +        ret =3D riscv_csrrw(env, csrno, ret_value, new_value, write_mask=
);
> +    }
>  #if !defined(CONFIG_USER_ONLY)
>      env->debugger =3D false;
>  #endif
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index f414aaebdb..b95d47e9ac 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -51,7 +51,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
>      }
>
>      target_ulong val =3D 0;
> -    RISCVException ret =3D riscv_csrrw(env, csr, &val, 0, 0);
> +    RISCVException ret =3D riscv_csrr(env, csr, &val);
>
>      if (ret !=3D RISCV_EXCP_NONE) {
>          riscv_raise_exception(env, ret, GETPC());
> @@ -84,9 +84,7 @@ target_ulong helper_csrrw(CPURISCVState *env, int csr,
>  target_ulong helper_csrr_i128(CPURISCVState *env, int csr)
>  {
>      Int128 rv =3D int128_zero();
> -    RISCVException ret =3D riscv_csrrw_i128(env, csr, &rv,
> -                                          int128_zero(),
> -                                          int128_zero());
> +    RISCVException ret =3D riscv_csrr_i128(env, csr, &rv);
>
>      if (ret !=3D RISCV_EXCP_NONE) {
>          riscv_raise_exception(env, ret, GETPC());
> --
> 2.34.1
>
>

