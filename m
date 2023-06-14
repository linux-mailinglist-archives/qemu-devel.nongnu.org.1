Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 275CF72F312
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 05:27:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9HA6-0000wg-Ki; Tue, 13 Jun 2023 23:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9HA0-0000nZ-LM; Tue, 13 Jun 2023 23:27:05 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9H9z-0002pl-6h; Tue, 13 Jun 2023 23:27:04 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-54fd6aa3b0dso80473a12.2; 
 Tue, 13 Jun 2023 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686713221; x=1689305221;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpWDnZqeru+Vx2YUIQnhfztYHlfMk73YHT3sGJBqc24=;
 b=YheKetXJjfgwiYpXozdipJMwZUXFHmkGfbStflK/Ik2O1+PP13F5sS9TM5i1oEKa+T
 LpmvBiBqYw+2rVr4Nb8fBGDmv8TCFDR1HaDX16Y2wIdeQvQOAurr8kp3t6mAvp6JPZeX
 fs/86Iz76XDXPeeFgRItsqPHxx9dM2evt34qkibNvi+cuL9+tVrbEWt+G5BdJchKasDT
 n4FRIfs08KT4h1HT4u8DOc+2Zj1EvudebsTQcOJjoFqe+OH2gLZWMcWs2cIIcH3sjs4E
 E6U+7+8lqTNYYL4aRwdPqbPVYm1jtToyAFqKyEhedV2G7DYZuDcSBmiPDa1yMRNjR8Lt
 DydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686713221; x=1689305221;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PpWDnZqeru+Vx2YUIQnhfztYHlfMk73YHT3sGJBqc24=;
 b=GE5KEd5EGGVTZIT9deZYgiVtHLuK6wf8ijIepuDjvYYOAp32y+ZVLB7b+K6zdoPKqz
 crc0hF4GeEbt4WWu2KMb+tpL89X9uM0zZrzSyBPkxM8L8MjfSwOHq0p+UsTm4IsQul9S
 JLeOq8e187+AfRzinP98EeEBHsDKbqn33W177EbFWo17YVJHWhwibeHybO3mlRsvaC3h
 bsnPok6rDTqorDDuGVw7hSzjzEr5x6lrEI1Kx9Yxp7VVElYvCLLiqhhON2C8nPAjdybn
 Iv736e8jBrbKmlrxyOXc6MV0BZjj130mT+LWqqLNrwDMcf1yeu2ib+/pSyl2dz3d7OuN
 bdAA==
X-Gm-Message-State: AC+VfDz+v8sBH+DSRaUlwMckDtV2kt0u8CV0YwQ0F1qligoaRH3I9ixr
 JMy/uo7c/vuPI8L1rqsZOWmowRcDxyP4Fg==
X-Google-Smtp-Source: ACHHUZ4Q+oM8iZLuEZM1Mk5snhaWZc9Ksm0O0xIIbcYh4GN0lN+XFdLJoyqPDsk3hM22UV+LPVcrOA==
X-Received: by 2002:a17:902:f546:b0:1b2:1942:9106 with SMTP id
 h6-20020a170902f54600b001b219429106mr11286624plf.64.1686713221247; 
 Tue, 13 Jun 2023 20:27:01 -0700 (PDT)
Received: from localhost ([1.146.66.73]) by smtp.gmail.com with ESMTPSA id
 12-20020a170902c20c00b001ac55a5e5eesm2215438pll.121.2023.06.13.20.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 20:27:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 13:26:46 +1000
Message-Id: <CTC1XHWOZVP0.3CCA0ZJNSAAGJ@wheely>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH 02/10] target/ppc: Remove unneeded parameter from
 powerpc_reset_wakeup()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <2261dffe335cc7fd1eade43cf569ae1cc640ed98.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <2261dffe335cc7fd1eade43cf569ae1cc640ed98.1686522199.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
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

On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
> CPUState is rarely needed by this function (only for logging a fatal
> error) and it's easy to get from the env parameter so passing it
> separately is not necessary.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Caller does have env already, but I don't mind much either way.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/excp_helper.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 8298217e78..3783315fdb 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -166,8 +166,7 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env, i=
nt excp)
>  }
> =20
>  #if defined(TARGET_PPC64)
> -static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp=
,
> -                                target_ulong *msr)
> +static int powerpc_reset_wakeup(CPUPPCState *env, int excp, target_ulong=
 *msr)
>  {
>      /* We no longer are in a PM state */
>      env->resume_as_sreset =3D false;
> @@ -202,8 +201,8 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPCS=
tate *env, int excp,
>          *msr |=3D SRR1_WAKEHVI;
>          break;
>      default:
> -        cpu_abort(cs, "Unsupported exception %d in Power Save mode\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Unsupported exception %d in Power Save mode\n", excp)=
;
>      }
>      return POWERPC_EXCP_RESET;
>  }
> @@ -1353,7 +1352,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int=
 excp)
>       * P7/P8/P9
>       */
>      if (env->resume_as_sreset) {
> -        excp =3D powerpc_reset_wakeup(cs, env, excp, &msr);
> +        excp =3D powerpc_reset_wakeup(env, excp, &msr);
>      }
> =20
>      /*
> --=20
> 2.30.9


