Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5DD71FA10
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 08:27:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4yER-0007Uy-50; Fri, 02 Jun 2023 02:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1q4yEC-0007SM-D0
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:25:36 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1q4yEA-0004SR-4Q
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:25:36 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4effb818c37so2199517e87.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 23:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685687132; x=1688279132; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TnIx/lfaqXY9Hil/ZNG6cBrNYFuykU9O4e8GegKBLsc=;
 b=nw8EpYnRSDydV95EnwwxrfoppwtlFV7Iji8VjEmWgzJmVVmR6eyu4OFLZWQiSy3WNI
 AUeFteABPHZtsckx5mzzBCgUcstIUHWFZeeP415+G/7zV8xhGXtmAqeF+2fe0uLLk1P0
 YVDtplR4pQP9E5yjbPcr5lRYe/6SoWHtp7JWgj86+D5m+YG9sVeGofMLohtj+VlFxTGo
 DYkJDqwDN19VeaxPvapGyvKJoFi+2qaGuzyVZx66BitVn1VZ6oBwyOGd7/2y8WZ+6UZH
 Y5NwPyUKzaQgCWWT3ptWWN+K0oeT5YEGrDZ0jDzcGf9ip6/MmbPRRsgtTAgTw+6SPVaK
 thXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685687132; x=1688279132;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TnIx/lfaqXY9Hil/ZNG6cBrNYFuykU9O4e8GegKBLsc=;
 b=GgR0rZZMOpjXU/uk2dcmZ77pwazVn4veJJHAeh06/dRJ1mJ71AHSSXth9F65wkPfaq
 fDCBSac+UbNN5ByLqGegR6uTXZXO5qUl/f8pWRpsBlQXe2wkAdgN6cgLJMl/VP/ZkbtH
 nHmv9PSGTfC11eEgHgCJXF7AYPfoJdTqGO9rcoJW+DQYhK1MrWeXmZNvL/vPVA7o6oxI
 u0FI1kaBvrY3iQ88aSqp16upHqAoUZPHDG2w3/lZ2+AJHgw6RqFztV1MTK1qu28yhJkX
 aylzRDZcE10UYH0UV7RgAxZiDuUfzrbSKKNI0jwjGlm5AB+cBSno6jhBfERb5gJCTTYk
 b96A==
X-Gm-Message-State: AC+VfDy2yK9GnX149T8ua/Ba1HyroSiaFC0CqtDqjlxpm+VaVj92eVhr
 zRIYoNszgjvwRUclL67OjXAXnw==
X-Google-Smtp-Source: ACHHUZ6VjSLVqaAOmU0sVE0B8kgsJcHszJar55GcaG69L9Ccb8cGFWdzy3HLKmGEjswQtUm1ROd+eg==
X-Received: by 2002:ac2:42c6:0:b0:4f3:9930:5b8c with SMTP id
 n6-20020ac242c6000000b004f399305b8cmr1055128lfl.25.1685687131885; 
 Thu, 01 Jun 2023 23:25:31 -0700 (PDT)
Received: from [192.168.50.45] (h-155-4-92-80.A980.priv.bahnhof.se.
 [155.4.92.80]) by smtp.gmail.com with ESMTPSA id
 j4-20020ac25504000000b004f3945751b2sm59146lfk.43.2023.06.01.23.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 23:25:31 -0700 (PDT)
Message-ID: <d818b6a319c3faf37b92f3151698e6b1c9517a5c.camel@rivosinc.com>
Subject: Re: [RFC] linux-user/riscv: Add syscall riscv_hwprobe
From: Robbin Ehn <rehn@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Date: Fri, 02 Jun 2023 08:25:30 +0200
In-Reply-To: <d4ced46f-ce77-d5d1-87f3-498b98249c3c@linaro.org>
References: <964faef7016042962e3002b328a80c239f8de962.camel@rivosinc.com>
 <d4ced46f-ce77-d5d1-87f3-498b98249c3c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=rehn@rivosinc.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 2023-06-01 at 08:15 -0700, Richard Henderson wrote:
> On 6/1/23 05:27, Robbin Ehn wrote:
> > This patch adds the new syscall for the
> > "RISC-V Hardware Probing Interface"
> > (https://docs.kernel.org/riscv/hwprobe.html).
> >=20
> > Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
> > ---
> >   linux-headers/asm-riscv/unistd.h |   9 +++
> >   linux-user/riscv/cpu_loop.c      | 119 ++++++++++++++++++++++++++++++=
-
> >   linux-user/riscv/syscall32_nr.h  |   1 +
> >   linux-user/riscv/syscall64_nr.h  |   1 +
> >   4 files changed, 129 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/linux-headers/asm-riscv/unistd.h b/linux-headers/asm-riscv=
/unistd.h
> > index 73d7cdd2ec..950ab3fd44 100644
> > --- a/linux-headers/asm-riscv/unistd.h
> > +++ b/linux-headers/asm-riscv/unistd.h
> > @@ -43,3 +43,12 @@
> >   #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
> >   #endif
> >   __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
> > +
> > +/*
> > + * Allows userspace to query the kernel for CPU architecture and
> > + * microarchitecture details across a given set of CPUs.
> > + */
> > +#ifndef __NR_riscv_hwprobe
> > +#define __NR_riscv_hwprobe (__NR_arch_specific_syscall + 14)
> > +#endif
> > +__SYSCALL(__NR_riscv_hwprobe, sys_riscv_hwprobe)
>=20
> You don't need to change linux-headers at all.

Ok

>=20
>=20
>=20
> > diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
> > index bffca7db12..5207739185 100644
> > --- a/linux-user/riscv/cpu_loop.c
> > +++ b/linux-user/riscv/cpu_loop.c
> > @@ -26,6 +26,117 @@
> >   #include "elf.h"
> >   #include "semihosting/common-semi.h"
> >  =20
> > +#define RISCV_HWPROBE_KEY_MVENDORID     0
> > +#define RISCV_HWPROBE_KEY_MARCHID       1
> > +#define RISCV_HWPROBE_KEY_MIMPID        2
> > +
> > +#define RISCV_HWPROBE_KEY_BASE_BEHAVIOR 3
> > +#define     RISCV_HWPROBE_BASE_BEHAVIOR_IMA (1 << 0)
> > +
> > +#define RISCV_HWPROBE_KEY_IMA_EXT_0     4
> > +#define     RISCV_HWPROBE_IMA_FD       (1 << 0)
> > +#define     RISCV_HWPROBE_IMA_C        (1 << 1)
> > +
> > +#define RISCV_HWPROBE_KEY_CPUPERF_0     5
> > +#define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
> > +#define     RISCV_HWPROBE_MISALIGNED_EMULATED    (1 << 0)
> > +#define     RISCV_HWPROBE_MISALIGNED_SLOW        (2 << 0)
> > +#define     RISCV_HWPROBE_MISALIGNED_FAST        (3 << 0)
> > +#define     RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
> > +#define     RISCV_HWPROBE_MISALIGNED_MASK        (7 << 0)
> > +
> > +struct riscv_hwprobe {
> > +    int64_t  key;
> > +    uint64_t value;
> > +};
> > +
> > +static void hwprobe_one_pair(CPURISCVState *env, struct riscv_hwprobe =
*pair)
> > +{
> > +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> > +
> > +    pair->value =3D 0;
> > +
> > +    switch (pair->key) {
> > +    case RISCV_HWPROBE_KEY_MVENDORID:
> > +        pair->value =3D cfg->mvendorid;
> > +        break;
> > +    case RISCV_HWPROBE_KEY_MARCHID:
> > +        pair->value =3D cfg->marchid;
> > +        break;
> > +    case RISCV_HWPROBE_KEY_MIMPID:
> > +        pair->value =3D cfg->mimpid;
> > +        break;
> > +    case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
> > +        pair->value =3D riscv_has_ext(env, RVI) &&
> > +                      riscv_has_ext(env, RVM) &&
> > +                      riscv_has_ext(env, RVA) ?
> > +                      RISCV_HWPROBE_BASE_BEHAVIOR_IMA : 0;
> > +        break;
> > +    case RISCV_HWPROBE_KEY_IMA_EXT_0:
> > +        pair->value =3D riscv_has_ext(env, RVF) &&
> > +                      riscv_has_ext(env, RVD) ?
> > +                      RISCV_HWPROBE_IMA_FD : 0;
> > +        pair->value |=3D riscv_has_ext(env, RVC) ?
> > +                       RISCV_HWPROBE_IMA_C : pair->value;
> > +        break;
> > +    case RISCV_HWPROBE_KEY_CPUPERF_0:
> > +        pair->value =3D RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> > +        break;
> > +    default:
> > +        pair->key =3D -1;
> > +    break;
> > +    }
> > +}
> > +
> > +static long sys_riscv_hwprobe(CPURISCVState *env,
> > +                              abi_ulong user_pairs,
> > +                              size_t pair_count,
> > +                              size_t cpu_count,
> > +                              abi_ulong user_cpus,
> > +                              unsigned int flags)
> > +{
> > +    struct riscv_hwprobe *host_pairs;
> > +    cpu_set_t *host_cpus =3D NULL;
> > +    size_t cpu_setsize =3D 0;
> > +
> > +    /* flags must be 0 */
> > +    if (flags !=3D 0) {
> > +        return 1
> > +    };
> > +
> > +    /* inconsistence cpu_set */
> > +    if (cpu_count !=3D 0 && user_cpus =3D=3D 0) {
> > +        return 1;
> > +    }
> > +
> > +    host_pairs =3D lock_user(VERIFY_WRITE, user_pairs,
> > +                           sizeof(*host_pairs) * pair_count, 0);
> > +
> > +    if (host_pairs =3D=3D NULL) {
> > +        return 1;
> > +    }
> > +
> > +    if (user_cpus !=3D 0) {
> > +        cpu_setsize =3D CPU_ALLOC_SIZE(user_cpus);
> > +        host_cpus =3D lock_user(VERIFY_READ, user_cpus, cpu_setsize, 0=
);
> > +    }
> > +
> > +    /* cpuset is ignored, symmetric CPUs in qemu */
> > +
> > +    for (struct riscv_hwprobe *ipairs =3D host_pairs;
> > +         pair_count > 0;
> > +         pair_count--, ipairs++) {
> > +        hwprobe_one_pair(env, ipairs);
> > +    }
> > +
> > +    if (host_cpus !=3D 0) {
> > +        unlock_user(host_cpus, user_cpus, cpu_setsize);
> > +    }
> > +
> > +    unlock_user(host_pairs, user_pairs, sizeof(*host_pairs) * pair_cou=
nt);
> > +    return 0;
> > +};
> > +
> >   void cpu_loop(CPURISCVState *env)
> >   {
> >       CPUState *cs =3D env_cpu(env);
> > @@ -47,7 +158,13 @@ void cpu_loop(CPURISCVState *env)
> >               break;
> >           case RISCV_EXCP_U_ECALL:
> >               env->pc +=3D 4;
> > -            if (env->gpr[xA7] =3D=3D TARGET_NR_arch_specific_syscall +=
 15) {
> > +            if (env->gpr[xA7] =3D=3D TARGET_NR_arch_specific_syscall +=
 14) {
> > +                /* riscv_hwprobe */
> > +                ret =3D sys_riscv_hwprobe(env,
> > +                                        env->gpr[xA0], env->gpr[xA1],
> > +                                        env->gpr[xA2], env->gpr[xA3],
> > +                                        env->gpr[xA4]);
>=20
> This belongs in linux-user/syscall.c.
> You've bypassed all of the strace support.
>=20
>=20
> r~

Thank you for the feedback!

/Robbin

