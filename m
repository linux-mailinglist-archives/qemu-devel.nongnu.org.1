Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8FD73DD7D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:29:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkP4-00072H-5R; Mon, 26 Jun 2023 07:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDkOz-00071o-1p; Mon, 26 Jun 2023 07:29:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDkOx-0005LQ-Ex; Mon, 26 Jun 2023 07:29:00 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b7fdc66e30so3866995ad.2; 
 Mon, 26 Jun 2023 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687778937; x=1690370937;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/YqrIo+DoNCao1+CGR+FjTxngrhvjvz0A0FwT7stf8=;
 b=JFhw0bKtN9Igk5IemiUeGsK/ZDs29sU8TnURcGcaOUB5e6vTfIt92JjNcMiAhXQyd4
 3Gfs7iGPBEzjIxhbqurcrB6OjLhwq7cI7Vt0TYTzKgSkNj6kiKyKJzauY4KUdEJxaDJ2
 BspGcHBh5ks/yrQUJdhv7f4b5ZxLD593CGbRfI211r9vU1W/OxmfiL+dEQwwxoiNf7U1
 6wNepb3ZQnQczQlLNwdIz+xsyAX61NmnXPewZnVmcVP0oPoc3Wx2jIKYgh4W8qa+HjJl
 zcTKWu7O6O8REK35SCmWNElYoushiiE3q+kzWCxyU/dfrePiXlJjxP7PPpeU+kucaCY5
 9sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778937; x=1690370937;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3/YqrIo+DoNCao1+CGR+FjTxngrhvjvz0A0FwT7stf8=;
 b=KGF1a2lSo8Wg/bPDjCKeB2vKrSPy1X/E/rfpkZXCkAzKiMnkkO0Jg1QIqkuKmek99K
 1p2Ynmqaw0bYVRM4w0dBmpLRD2r269zOMBUgu1/U/PwsBCNByEC2QtIWXrINRZDBzXss
 gdYvOKqG+v5aNdFYYDA5m66xpflYgead/QpVngFpT+JItG5KZwtO82DDqpV6hcrJm23h
 /l732vUL8k73IylRhlQtTzLm++MgSS5/6tAsbz2kcLo8cYOAEVp0b3s8CDYZScUbE1uY
 nK6cvQN3sD0WWzCXgh3a/UwyIi2EmvCzlQlqtB6/6v/thKYVrQD+XJS+KtIO5PFaj5af
 t2tg==
X-Gm-Message-State: AC+VfDwrFysqIqBAIcysjMckOTmyFXe8MMfbiFCMkq3w1pva30E0V2U9
 GvBHOBvtOCVuYBK/WNBaPwY=
X-Google-Smtp-Source: ACHHUZ5xrHoipuPYyaO2SixghwKZ51E0wBlxhfzjPkq/OF/CMs+5MWzHEBAbcsG4OPBd5A2x7He1mQ==
X-Received: by 2002:a17:902:f541:b0:1aa:e5cd:647a with SMTP id
 h1-20020a170902f54100b001aae5cd647amr3540149plf.23.1687778937425; 
 Mon, 26 Jun 2023 04:28:57 -0700 (PDT)
Received: from localhost (14-200-238-131.tpgi.com.au. [14.200.238.131])
 by smtp.gmail.com with ESMTPSA id
 jh13-20020a170903328d00b001b80fe91a40sm649995plb.272.2023.06.26.04.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 04:28:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jun 2023 21:28:51 +1000
Message-Id: <CTMJP5BKBZ6U.3P6Z31C635735@wheely>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH v3 09/14] target/ppc: Move patching nip from exception
 handler to helper_scv
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <b7317331ebccb0209fd0b12687945af6f626b0eb.1686868895.git.balaton@eik.bme.hu>
In-Reply-To: <b7317331ebccb0209fd0b12687945af6f626b0eb.1686868895.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

On Fri Jun 16, 2023 at 9:03 AM AEST, BALATON Zoltan wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
>
> Unlike sc, for scv a facility unavailable interrupt must be generated
> if FSCR[SCV]=3D0 so we can't raise the exception with nip set to next
> instruction but we can move advancing nip if the FSCR check passes to
> helper_scv so the exception handler does not need to change it.
>
> [balaton: added commit message]

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Thanks, sorry for the delay :( Would you be able to resend the series?
You could drop the machine check one for now perhaps until we sort out
what to do with it.

Thanks,
Nick

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> This needs SoB from Nick
>
>  target/ppc/excp_helper.c | 2 +-
>  target/ppc/translate.c   | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 903216c2a6..ef363b0285 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1304,7 +1304,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int=
 excp)
>      case POWERPC_EXCP_SYSCALL_VECTORED: /* scv exception                =
     */
>          lev =3D env->error_code;
>          dump_syscall(env);
> -        env->nip +=3D 4;
>          new_msr |=3D env->msr & ((target_ulong)1 << MSR_EE);
>          new_msr |=3D env->msr & ((target_ulong)1 << MSR_RI);
> =20
> @@ -2410,6 +2409,7 @@ void helper_ppc_maybe_interrupt(CPUPPCState *env)
>  void helper_scv(CPUPPCState *env, uint32_t lev)
>  {
>      if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
> +        env->nip +=3D 4;
>          raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
>      } else {
>          raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4260d3d66f..0360a17fb3 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4433,7 +4433,11 @@ static void gen_scv(DisasContext *ctx)
>  {
>      uint32_t lev =3D (ctx->opcode >> 5) & 0x7F;
> =20
> -    /* Set the PC back to the faulting instruction. */
> +    /*
> +     * Set the PC back to the scv instruction (unlike sc), because a fac=
ility
> +     * unavailable interrupt must be generated if FSCR[SCV]=3D0. The hel=
per
> +     * advances nip if the FSCR check passes.
> +     */
>      gen_update_nip(ctx, ctx->cia);
>      gen_helper_scv(cpu_env, tcg_constant_i32(lev));
> =20


