Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E92705B68
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 01:36:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4DI-0000ho-HP; Tue, 16 May 2023 19:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4DG-0000hV-D2
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:36:14 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4DE-0004XV-Lp
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:36:14 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-783ef1c0cfdso2929414241.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 16:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684280171; x=1686872171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ujd0OZng2QQNZy33wnAf8SsL8rA1t6H97jIIJeK1dI=;
 b=FEFCttHtBsVJZodhXwSIL0htxFbGealxJVqdJQAigBrzrniHyVSdxba2YXbxy6ccj2
 99S4hnLOKMZJBInLxHN5G8EMSonJyOmM7Y5+TJZxCMCaBjbkXg3MVwoHugmSnD0YQlae
 8cHdzIaPmFe+p4hisBU2V49P2BHel3FHkp0C1WTlrSYLa1nhof36BQ86UljqaeWuHAet
 pndSTCGqts910rNQCwfebhjRVW0VO85MuH+CQPDbqknWJWRZVqjsEhPGxN/bCNmc4irY
 h28pQOr+PvNOweZsOqDSuGFotyIyKF+IS3df6D9jE3A8Lyy6KGcFqal7pN5BNbP+pVs3
 F9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684280171; x=1686872171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ujd0OZng2QQNZy33wnAf8SsL8rA1t6H97jIIJeK1dI=;
 b=Xjxg9CtsQg7n7TNPG0qTQo1RPKiarI8Mq2sYmLNP6/TDXc9cGVP8hl3uWOAX5o2j2m
 ikezhNn39uvn9G2UMF8Frx2dXVEXDdF7BN3CTuQbrTVHRzyOzXv7aTxrXiSRitDi8kLa
 g9Hy0Q28UYlycAILCG1+haqG8jAMv94iM9rhI3D5LqIAJ+ZppPoE+Cnztobwwjim87JH
 feA7ThgCBy5F6b25sWiCSFAZiylVkfOkrmrS3Y4TbuLAWqoaatPUMzyq9UYPmuLStpZl
 70c+9W/ekmV7fV0HAWuMAK1E9sRyMitwRL9faugUY9PFyHkNiJ5Szu7GOCT5AU9l7V/l
 3Fqw==
X-Gm-Message-State: AC+VfDz4WkXQ7YFDfPUR051XtaJTrkE3VNjvJ8wETB5dlbi29M7y3uZC
 eSSlQwAYPTHpRr9oesziEWsFic1omoex0EUXHDKu4tKrsVI=
X-Google-Smtp-Source: ACHHUZ5w0SEf+H3UWtoxhCMz1jLWBJXyZ/AgFhjDmcpcUof7QF89wfzoObfyj8ZXn4SLXyLuu405WPAcgiX7h8BGoJA=
X-Received: by 2002:a1f:4315:0:b0:44f:c1a7:ceff with SMTP id
 q21-20020a1f4315000000b0044fc1a7ceffmr154341vka.6.1684280170515; Tue, 16 May
 2023 16:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230503085657.1814850-1-richard.henderson@linaro.org>
 <20230503085657.1814850-3-richard.henderson@linaro.org>
In-Reply-To: <20230503085657.1814850-3-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 09:35:44 +1000
Message-ID: <CAKmqyKOBNBkoEpftTST3LPac=8WpbP6vPPfUtTXGJGaXEOe6hA@mail.gmail.com>
Subject: Re: [PATCH 02/11] tcg/riscv: Probe for Zba, Zbb, Zicond extensions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Wed, May 3, 2023 at 6:59=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Define a useful subset of the extensions.  Probe for them
> via compiler pre-processor feature macros and SIGILL.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/riscv/tcg-target.h     |  6 +++
>  tcg/riscv/tcg-target.c.inc | 96 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
>
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 494c986b49..863ac8ba2f 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -90,6 +90,12 @@ typedef enum {
>  #define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
>  #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
>
> +#if defined(__riscv_arch_test) && defined(__riscv_zbb)
> +# define have_zbb true
> +#else
> +extern bool have_zbb;
> +#endif
> +
>  /* optional instructions */
>  #define TCG_TARGET_HAS_movcond_i32      0
>  #define TCG_TARGET_HAS_div_i32          1
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 4dd33c73e8..49ff9c8b9d 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -113,6 +113,20 @@ static const int tcg_target_call_iarg_regs[] =3D {
>      TCG_REG_A7,
>  };
>
> +#ifndef have_zbb
> +bool have_zbb;
> +#endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zba)
> +# define have_zba true
> +#else
> +static bool have_zba;
> +#endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zicond)
> +# define have_zicond true
> +#else
> +static bool have_zicond;
> +#endif
> +
>  static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>  {
>      tcg_debug_assert(kind =3D=3D TCG_CALL_RET_NORMAL);
> @@ -234,6 +248,34 @@ typedef enum {
>
>      OPC_FENCE =3D 0x0000000f,
>      OPC_NOP   =3D OPC_ADDI,   /* nop =3D addi r0,r0,0 */
> +
> +    /* Zba: Bit manipulation extension, address generation */
> +    OPC_ADD_UW =3D 0x0800003b,
> +
> +    /* Zbb: Bit manipulation extension, basic bit manipulaton */
> +    OPC_ANDN   =3D 0x40007033,
> +    OPC_CLZ    =3D 0x60001013,
> +    OPC_CLZW   =3D 0x6000101b,
> +    OPC_CPOP   =3D 0x60201013,
> +    OPC_CPOPW  =3D 0x6020101b,
> +    OPC_CTZ    =3D 0x60101013,
> +    OPC_CTZW   =3D 0x6010101b,
> +    OPC_ORN    =3D 0x40006033,
> +    OPC_REV8   =3D 0x6b805013,
> +    OPC_ROL    =3D 0x60001033,
> +    OPC_ROLW   =3D 0x6000103b,
> +    OPC_ROR    =3D 0x60005033,
> +    OPC_RORW   =3D 0x6000503b,
> +    OPC_RORI   =3D 0x60005013,
> +    OPC_RORIW  =3D 0x6000501b,
> +    OPC_SEXT_B =3D 0x60401013,
> +    OPC_SEXT_H =3D 0x60501013,
> +    OPC_XNOR   =3D 0x40004033,
> +    OPC_ZEXT_H =3D 0x0800403b,
> +
> +    /* Zicond: integer conditional operations */
> +    OPC_CZERO_EQZ =3D 0x0e005033,
> +    OPC_CZERO_NEZ =3D 0x0e007033,
>  } RISCVInsn;
>
>  /*
> @@ -1612,8 +1654,62 @@ static void tcg_target_qemu_prologue(TCGContext *s=
)
>      tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_RA, 0);
>  }
>
> +static volatile sig_atomic_t got_sigill;
> +
> +static void sigill_handler(int signo, siginfo_t *si, void *data)
> +{
> +    /* Skip the faulty instruction */
> +    ucontext_t *uc =3D (ucontext_t *)data;
> +    uc->uc_mcontext.__gregs[REG_PC] +=3D 4;
> +
> +    got_sigill =3D 1;
> +}
> +
> +static void tcg_target_detect_isa(void)
> +{
> +#if !defined(have_zba) || !defined(have_zbb) || !defined(have_zicond)
> +    /*
> +     * TODO: It is expected that this will be determinable via
> +     * linux riscv_hwprobe syscall, not yet merged.
> +     * In the meantime, test via sigill.
> +     */
> +
> +    struct sigaction sa_old, sa_new;
> +
> +    memset(&sa_new, 0, sizeof(sa_new));
> +    sa_new.sa_flags =3D SA_SIGINFO;
> +    sa_new.sa_sigaction =3D sigill_handler;
> +    sigaction(SIGILL, &sa_new, &sa_old);
> +
> +#ifndef have_zba
> +    /* Probe for Zba: add.uw zero,zero,zero. */
> +    got_sigill =3D 0;
> +    asm volatile(".insn %0" : : "i"(OPC_ADD_UW) : "memory");
> +    have_zba =3D !got_sigill;
> +#endif
> +
> +#ifndef have_zbb
> +    /* Probe for Zba: andn zero,zero,zero. */
> +    got_sigill =3D 0;
> +    asm volatile(".insn %0" : : "i"(OPC_ANDN) : "memory");
> +    have_zbb =3D !got_sigill;
> +#endif
> +
> +#ifndef have_zicond
> +    /* Probe for Zicond: czero.eqz zero,zero,zero. */
> +    got_sigill =3D 0;
> +    asm volatile(".insn %0" : : "i"(OPC_CZERO_EQZ) : "memory");
> +    have_zicond =3D !got_sigill;
> +#endif
> +
> +    sigaction(SIGILL, &sa_old, NULL);
> +#endif
> +}
> +
>  static void tcg_target_init(TCGContext *s)
>  {
> +    tcg_target_detect_isa();
> +
>      tcg_target_available_regs[TCG_TYPE_I32] =3D 0xffffffff;
>      tcg_target_available_regs[TCG_TYPE_I64] =3D 0xffffffff;
>
> --
> 2.34.1
>
>

