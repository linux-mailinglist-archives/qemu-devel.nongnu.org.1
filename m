Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8334831162
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 03:25:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQI4Y-000844-Qw; Wed, 17 Jan 2024 21:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQI4W-00083c-7i; Wed, 17 Jan 2024 21:24:00 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQI4T-00067x-83; Wed, 17 Jan 2024 21:23:59 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bd5c4cffefso5726780b6e.1; 
 Wed, 17 Jan 2024 18:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705544635; x=1706149435; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNnJzEYpGlV9SIzuqfomTR+rjWi2RBAePa+3JfSXttI=;
 b=Y+OJUZ6z2a01V+WNC/7446RBQ1cZHei1axwTk+xKq0cJq2agJEcoMtdLR2mWI8tk3v
 FzNKuIV26ra79BewTrtopsorFNbePyvAyCb6R7tEbiMRE4LkyOzO2UJWK1RTw+mZPAFI
 L4I2BS2H/m649sLzzQz32mZSTGzDUL02uZZAm+tAYP7LaIDgfvNc3GZEWtqcCg+LcYfr
 hyj93DswLxqrDPPDmBoxJS9UrexgC1LzOZ8A7InSbD+pitkJ/tdP5TpdP72MkUIS/Jof
 jlEPFUNmBEkkCHY7fBHlSgv3dbl/wlKQPYgVxGBtUdaYXb6mbvgg53ZcrbU6x1T2Qd9x
 uw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705544635; x=1706149435;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hNnJzEYpGlV9SIzuqfomTR+rjWi2RBAePa+3JfSXttI=;
 b=opy7U2dwgLpLslSHr/llFzDJ9yOB+Z/cFIXrKl+LfdfWkLcZy2aTLVuuvv/YrCc+zx
 5PKo99NWkwdKjdWE0oSO0aji3sS4Dx4ZX2EwG1IMnW8lkROX+hG6oMBx7L+m58dUl+zX
 RMXvDQfcuuQq/LcdasxyQls2limj5WIIAIt/lLhK95Hd3ETe5+2FZhV+Oc8TaUoz5pR4
 KvAwdRdbzciW2DQl4tf3L80B8ZRNrzByEVkKuT/3W9d8H+Eaik9z4sxr8lwezXd3Mijl
 knMXSbwyfTh24KIHteDuug8ZTMSm2iYWgvz5SG7y8i6QeMaJ3MXWXvdOux0Oh/KBFu2b
 XGvg==
X-Gm-Message-State: AOJu0YyEJudQQII3vro1hKFvedJkeNrvVynpPHha8Bxy4hkw5VxEIY3U
 488ZNqS/j6DYFSjJJ2iKM6VpfoKjocVgLBMi66DPh75ZzkDNGtn3
X-Google-Smtp-Source: AGHT+IGqgvLLtI8hLMFUlihckIeRvp3hNWXIOXftX3UhBD4VX1cgec2H+3RRdn8aVQiJXP9f1hoi9Q==
X-Received: by 2002:a05:6808:13d4:b0:3bd:9aea:58c7 with SMTP id
 d20-20020a05680813d400b003bd9aea58c7mr242566oiw.108.1705544635453; 
 Wed, 17 Jan 2024 18:23:55 -0800 (PST)
Received: from localhost ([1.146.114.176]) by smtp.gmail.com with ESMTPSA id
 fi35-20020a056a0039a300b006d94291679asm2122439pfb.78.2024.01.17.18.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 18:23:55 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jan 2024 12:23:49 +1000
Message-Id: <CYHH429YYHUZ.2JYDWW2L6TA8F@wheely>
Subject: Re: [PATCH]       ppc/pnv: Add PowerPC Special Purpose Registers
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "dan tan" <dantan@linux.vnet.ibm.com>, <qemu-devel@nongnu.org>
Cc: <danielhb413@gmail.com>, <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240117223429.2295-1-dantan@linux.vnet.ibm.com>
In-Reply-To: <20240117223429.2295-1-dantan@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Jan 18, 2024 at 8:34 AM AEST, dan tan wrote:
>         The handling of the following two registers are added -
>             DAWR1  (0x0bd, 189) - Data Address Watchpoint 1
>             DAWRX1 (0x0b5, 181) - Data Address Watchpoint Extension 1
>
>       Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>

Small nit, but there's some extra whitespace on the left here and in
Subject header which is normally not required.

> ---
>  target/ppc/cpu.c         | 51 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/ppc/cpu.h         |  6 ++++++
>  target/ppc/cpu_init.c    | 10 ++++++++++
>  target/ppc/excp_helper.c | 11 ++++++++++-
>  target/ppc/helper.h      |  2 ++
>  target/ppc/machine.c     |  1 +
>  target/ppc/misc_helper.c | 10 ++++++++++
>  target/ppc/spr_common.h  |  2 ++
>  target/ppc/translate.c   | 12 ++++++++++++
>  9 files changed, 104 insertions(+), 1 deletion(-)
>
> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index e3ad8e0..8a77328 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -188,6 +188,57 @@ void ppc_store_dawrx0(CPUPPCState *env, uint32_t val=
)
>      env->spr[SPR_DAWRX0] =3D val;
>      ppc_update_daw0(env);
>  }
> +
> +void ppc_update_daw1(CPUPPCState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +    target_ulong deaw =3D env->spr[SPR_DAWR1] & PPC_BITMASK(0, 60);
> +    uint32_t dawrx =3D env->spr[SPR_DAWRX1];
> +    int mrd =3D extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
> +    bool dw =3D extract32(dawrx, PPC_BIT_NR(57), 1);
> +    bool dr =3D extract32(dawrx, PPC_BIT_NR(58), 1);
> +    bool hv =3D extract32(dawrx, PPC_BIT_NR(61), 1);
> +    bool sv =3D extract32(dawrx, PPC_BIT_NR(62), 1);
> +    bool pr =3D extract32(dawrx, PPC_BIT_NR(62), 1);
> +    vaddr len;
> +    int flags;
> +
> +    if (env->dawr1_watchpoint) {
> +        cpu_watchpoint_remove_by_ref(cs, env->dawr1_watchpoint);
> +        env->dawr1_watchpoint =3D NULL;
> +    }
> +
> +    if (!dr && !dw) {
> +        return;
> +    }
> +
> +    if (!hv && !sv && !pr) {
> +        return;
> +    }
> +
> +    len =3D (mrd + 1) * 8;
> +    flags =3D BP_CPU | BP_STOP_BEFORE_ACCESS;
> +    if (dr) {
> +        flags |=3D BP_MEM_READ;
> +    }
> +    if (dw) {
> +        flags |=3D BP_MEM_WRITE;
> +    }
> +
> +    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr1_watchpoint);
> +}

I would say this is just beyond the point where we should share
code with daw0. You could make a function that takes DAWR(x) SPR
numbers or values, and a pointer to the watchpoint to use.

> +
> +void ppc_store_dawr1(CPUPPCState *env, target_ulong val)
> +{
> +    env->spr[SPR_DAWR1] =3D val;
> +    ppc_update_daw1(env);
> +}
> +
> +void ppc_store_dawrx1(CPUPPCState *env, uint32_t val)
> +{
> +    env->spr[SPR_DAWRX1] =3D val;
> +    ppc_update_daw1(env);
> +}
>  #endif
>  #endif
> =20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f8101ff..ab34fc7 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1237,6 +1237,7 @@ struct CPUArchState {
>      ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
>      struct CPUBreakpoint *ciabr_breakpoint;
>      struct CPUWatchpoint *dawr0_watchpoint;
> +    struct CPUWatchpoint *dawr1_watchpoint;
>  #endif
>      target_ulong sr[32];   /* segment registers */
>      uint32_t nb_BATs;      /* number of BATs */
> @@ -1552,6 +1553,9 @@ void ppc_store_ciabr(CPUPPCState *env, target_ulong=
 value);
>  void ppc_update_daw0(CPUPPCState *env);
>  void ppc_store_dawr0(CPUPPCState *env, target_ulong value);
>  void ppc_store_dawrx0(CPUPPCState *env, uint32_t value);
> +void ppc_update_daw1(CPUPPCState *env);
> +void ppc_store_dawr1(CPUPPCState *env, target_ulong value);
> +void ppc_store_dawrx1(CPUPPCState *env, uint32_t value);
>  #endif /* !defined(CONFIG_USER_ONLY) */
>  void ppc_store_msr(CPUPPCState *env, target_ulong value);
> =20
> @@ -1737,9 +1741,11 @@ void ppc_compat_add_property(Object *obj, const ch=
ar *name,
>  #define SPR_PSPB              (0x09F)
>  #define SPR_DPDES             (0x0B0)
>  #define SPR_DAWR0             (0x0B4)
> +#define SPR_DAWR1             (0x0B5)
>  #define SPR_RPR               (0x0BA)
>  #define SPR_CIABR             (0x0BB)
>  #define SPR_DAWRX0            (0x0BC)
> +#define SPR_DAWRX1            (0x0BD)
>  #define SPR_HFSCR             (0x0BE)
>  #define SPR_VRSAVE            (0x100)
>  #define SPR_USPRG0            (0x100)
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 40fe14a..d75c359 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5119,11 +5119,21 @@ static void register_book3s_207_dbg_sprs(CPUPPCSt=
ate *env)
>                          SPR_NOACCESS, SPR_NOACCESS,
>                          &spr_read_generic, &spr_write_dawr0,
>                          KVM_REG_PPC_DAWR, 0x00000000);
> +    spr_register_kvm_hv(env, SPR_DAWR1, "DAWR1",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        &spr_read_generic, &spr_write_dawr1,
> +                        KVM_REG_PPC_DAWR, 0x00000000);
>      spr_register_kvm_hv(env, SPR_DAWRX0, "DAWRX0",
>                          SPR_NOACCESS, SPR_NOACCESS,
>                          SPR_NOACCESS, SPR_NOACCESS,
>                          &spr_read_generic, &spr_write_dawrx0,
>                          KVM_REG_PPC_DAWRX, 0x00000000);
> +    spr_register_kvm_hv(env, SPR_DAWRX1, "DAWRX1",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        &spr_read_generic, &spr_write_dawrx1,
> +                        KVM_REG_PPC_DAWRX, 0x00000000);

These are new for POWER10, no? This is adding them for P8/9 too.

Thanks,
Nick

