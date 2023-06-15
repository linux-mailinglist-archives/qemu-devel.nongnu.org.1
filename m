Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFBA730D9B
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 05:36:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9dlq-0004fA-AS; Wed, 14 Jun 2023 23:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9dlm-0004eu-UP; Wed, 14 Jun 2023 23:35:35 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9dll-000382-Ck; Wed, 14 Jun 2023 23:35:34 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3909756b8b1so3512975b6e.1; 
 Wed, 14 Jun 2023 20:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686800130; x=1689392130;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzOTlsWjRRWPWD4HvW4rG7/FWmwBTd1oU7iz9Gy7UTQ=;
 b=roIV5TfMjf7B+j+QdpIlfPQDz+EQ+wjNJnRBFhkDfm/ZBZMeO+KPSdsmio7wq//r4d
 zmN/Yoo7+vAUWCgPpVHZX5I2mFUGO+DGWcb3LutmDlPQXjgeqsLPW78ajARQya7OtiMx
 SDXHwAa+wPQG8CWRihv7dgf5KMe4Mdhp3Zp0o8Q/8TwMaX8w4YZMkiuJpSSUZEeCgl3E
 PB24Rzv7C+jBPuae6oLYHUePVNxkhd6nPBYKe/Iz1w5HSpvU2ahpAMAp0oFteMxap1Ee
 GDr/ih9VDEkkb8jdgpoWEU+pxERXbj5WAI0DTothTCwuTE32P8jmJ7X57UJ4cnROVt2r
 QxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686800130; x=1689392130;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yzOTlsWjRRWPWD4HvW4rG7/FWmwBTd1oU7iz9Gy7UTQ=;
 b=YM4ILto8CHMi1x4aT5c6MGwcuHsihu4w3FaadMeKBNyCfjzlRO1h1sMTZMJ6NCT0Uz
 zgRe3OFZv/fQffs47CceJgh/lKx4CLPjoQIxI9miuihrj8JZng3uSdo11rZG/Fdv3J9W
 CZMAdFOULZAFlADnE0ws1SSvjpkzf2UnbgNiTfcB03Yk/bCztJQBg9zG2JloxPvxeKM5
 BQLq1KKVaozU40hnQj5CdfQPj/inIDShyVmNSJOiTJ+muhRWVI08aFrHpPWJ2/FqDiWx
 KxSbStAvMYPivhBkjbIm4pKiZhOxr/qa1DJKuWy9CCghsI0oEGu9+3eOKYiBZW8GScQ6
 F7zQ==
X-Gm-Message-State: AC+VfDz4q+hD3nF8dsbRbvAsEfT7lA+M4UyI4ZbrYUAGV5krCCJgmuLy
 T8jZsVrUBTzZMrN48B2HuL+hohpZ4+k=
X-Google-Smtp-Source: ACHHUZ5sSSNGZC7sFEdCE69zyouoVJ6yoNt4NBkrghweXI6D+5zwmY298jaeDqna1vQNNCwUJ+kSJw==
X-Received: by 2002:a05:6808:9a4:b0:398:4385:baf4 with SMTP id
 e4-20020a05680809a400b003984385baf4mr10652082oig.49.1686800130451; 
 Wed, 14 Jun 2023 20:35:30 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 12-20020a17090a004c00b0025bf1ea918asm6105032pjb.55.2023.06.14.20.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 20:35:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 13:35:25 +1000
Message-Id: <CTCWQNY1WICB.22H2C7EM4JJKT@wheely>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH v2 10/10] target/ppc: Get CPUState in one step
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.14.0
References: <cover.1686776990.git.balaton@eik.bme.hu>
 <f2a22b2c5483a31fa2c6cdd84fe659bfc5d499cd.1686776990.git.balaton@eik.bme.hu>
In-Reply-To: <f2a22b2c5483a31fa2c6cdd84fe659bfc5d499cd.1686776990.git.balaton@eik.bme.hu>
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

On Thu Jun 15, 2023 at 7:34 AM AEST, BALATON Zoltan wrote:
> We can get CPUState from env with env_cpu without going through
> PowerPCCPU and casting that.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/excp_helper.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 662457f342..5edf06210f 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1506,8 +1506,8 @@ static int p7_interrupt_powersave(CPUPPCState *env)
> =20
>  static int p7_next_unmasked_interrupt(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D env_cpu(env);
> +
>      /* Ignore MSR[EE] when coming out of some power management states */
>      bool msr_ee =3D FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sres=
et;
> =20
> @@ -1596,8 +1596,8 @@ static int p8_interrupt_powersave(CPUPPCState *env)
> =20
>  static int p8_next_unmasked_interrupt(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D env_cpu(env);
> +
>      /* Ignore MSR[EE] when coming out of some power management states */
>      bool msr_ee =3D FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sres=
et;
> =20
> @@ -1717,8 +1717,8 @@ static int p9_interrupt_powersave(CPUPPCState *env)
> =20
>  static int p9_next_unmasked_interrupt(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D env_cpu(env);
> +
>      /* Ignore MSR[EE] when coming out of some power management states */
>      bool msr_ee =3D FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sres=
et;
> =20
> @@ -2412,9 +2412,8 @@ void helper_scv(CPUPPCState *env, uint32_t lev)
> =20
>  void helper_pminsn(CPUPPCState *env, uint32_t insn)
>  {
> -    CPUState *cs;
> +    CPUState *cs =3D env_cpu(env);
> =20
> -    cs =3D env_cpu(env);
>      cs->halted =3D 1;
> =20
>      /* Condition for waking up at 0x100 */
> --=20
> 2.30.9


