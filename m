Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5F5730D93
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 05:34:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9dka-0003pA-7X; Wed, 14 Jun 2023 23:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9dkY-0003oL-7T; Wed, 14 Jun 2023 23:34:18 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9dkW-0002qQ-Jx; Wed, 14 Jun 2023 23:34:17 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-558cf19575dso1099876eaf.3; 
 Wed, 14 Jun 2023 20:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686800055; x=1689392055;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRTo0mWr4vKRVz6NY6Fa0dSWecS5M6reW1ki3STyxoI=;
 b=CSSY1xLOKOTYGGHlYHqPORGFmpWBGQeAAm+HmNhn0RureWQJXAELsWCiswlsmNlRMO
 D/hk318ZXFz3WRzoxOAm/1fQ2pQlmfSSg6Rz2bqdmq6NPz+qyZgR0ZH2yq2FzVX3qeRk
 s+wcgvGnTdJwH++hu/rTt4iIqtFIDQQoUaadBLdkXF6t9hPc5Q4Rj4nP4k87wnyAmdzD
 cv02qpsUB7IkOsycI81OImd0+LsATfT7JTBcd5RIRnP05Drrymp7q4Cy1T0lW9yqivMv
 VMa6sHE/KIQrSqIHrk98tZyK29D6eKjSzyzUZTjtNhSPr9MbaBHep8kEnX2dIPQ4sBcs
 3pGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686800055; x=1689392055;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qRTo0mWr4vKRVz6NY6Fa0dSWecS5M6reW1ki3STyxoI=;
 b=C1HgaAEu5rIv12FUwyaoPDTZKkyxyFg3n+L0EU3866X0IlKqZ7hcEAgmd+iZHplLYG
 dG+kRaketNEA39SlhxIl9adQEq9ttMMn7n58D/7QusLOssdITcpcG57WxjxSPwOCtlIr
 7lhy9gAc6WEq2+FFYFtBnnuBD7Ar/yzYNsFcNliEYNiEVNDfD3Os3qqVI+sYjb9Agocy
 MP23Mx5osX8LaqTqkc61Rbap3RWi5Mv+d2U3sCE5mj/h6+PxQWD5fXL+iJ+/Z6HCEtYx
 HePlKTQyLwACm948gLuJroyM+yfG8StGYH11vzk8aXf2MqrWoGDYiahy+3RnjuLYXLcC
 adoQ==
X-Gm-Message-State: AC+VfDx3drCRIrXsD/0AVMfis1IFMu2sbdBTUk5idMrYV0EcNKUvwNlC
 kPilwLXaLMdxMLDEMUrd70I=
X-Google-Smtp-Source: ACHHUZ4RQ3UHVxBwhjj2Zh6GKOEmRjRjnboUBtMWPhmc9lAwr1lzEtC8zMeAWskmd2mTfB15cR2wpg==
X-Received: by 2002:a05:6808:1509:b0:39e:8bc3:e63a with SMTP id
 u9-20020a056808150900b0039e8bc3e63amr885881oiw.6.1686800054727; 
 Wed, 14 Jun 2023 20:34:14 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 qe10-20020a17090b4f8a00b00259b53dccddsm11662282pjb.34.2023.06.14.20.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 20:34:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 13:34:09 +1000
Message-Id: <CTCWPOXSQZLU.275T4DDJIY90X@wheely>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH v2 09/10] target/ppc: Simplify syscall exception handlers
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.14.0
References: <cover.1686776990.git.balaton@eik.bme.hu>
 <ee7c07146e8e2e5a3d1d52aaf5a4eeef695c359d.1686776990.git.balaton@eik.bme.hu>
In-Reply-To: <ee7c07146e8e2e5a3d1d52aaf5a4eeef695c359d.1686776990.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc2f.google.com
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
> After previous changes the hypercall handling in 7xx and 74xx
> exception handlers can be folded into one if statement to simpilfy
> this code.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/excp_helper.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 1682b988ba..662457f342 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -740,26 +740,23 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int e=
xcp)
>          break;
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>      {
> -        int lev =3D env->error_code;

I would still keep lev. Self documenting and consistent with books
handler.

> +        PowerPCCPU *cpu =3D env_archcpu(env);

Is this necessary?

Thanks,
Nick

> =20
> -        if (lev =3D=3D 1 && cpu->vhyp) {
> -            dump_hcall(env);
> -        } else {
> -            dump_syscall(env);
> -        }
>          /*
>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>           * instruction to communicate with QEMU. The pegasos2 machine
>           * uses VOF and the 7xx CPUs, so although the 7xx don't have
>           * HV mode, we need to keep hypercall support.
>           */
> -        if (lev =3D=3D 1 && cpu->vhyp) {
> +        if (unlikely(env->error_code =3D=3D 1 && cpu->vhyp)) {
>              PPCVirtualHypervisorClass *vhc =3D
>                  PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +            dump_hcall(env);
>              vhc->hypercall(cpu->vhyp, cpu);
>              return;
> +        } else {
> +            dump_syscall(env);
>          }
> -
>          break;
>      }
>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception=
     */
> @@ -884,26 +881,23 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int =
excp)
>          break;
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>      {
> -        int lev =3D env->error_code;
> +        PowerPCCPU *cpu =3D env_archcpu(env);
> =20
> -        if (lev =3D=3D 1 && cpu->vhyp) {
> -            dump_hcall(env);
> -        } else {
> -            dump_syscall(env);
> -        }
>          /*
>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>           * instruction to communicate with QEMU. The pegasos2 machine
>           * uses VOF and the 74xx CPUs, so although the 74xx don't have
>           * HV mode, we need to keep hypercall support.
>           */
> -        if (lev =3D=3D 1 && cpu->vhyp) {
> +        if (unlikely(env->error_code =3D=3D 1 && cpu->vhyp)) {
>              PPCVirtualHypervisorClass *vhc =3D
>                  PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +            dump_hcall(env);
>              vhc->hypercall(cpu->vhyp, cpu);
>              return;
> +        } else {
> +            dump_syscall(env);
>          }
> -
>          break;
>      }
>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception=
     */
> --=20
> 2.30.9


