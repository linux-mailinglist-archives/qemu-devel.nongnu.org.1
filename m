Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE51C72F310
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 05:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9H97-0000S8-ST; Tue, 13 Jun 2023 23:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9H95-0000Qx-P5; Tue, 13 Jun 2023 23:26:07 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9H92-0002f1-7G; Tue, 13 Jun 2023 23:26:07 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6664e4d8fb4so147423b3a.3; 
 Tue, 13 Jun 2023 20:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686713162; x=1689305162;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mHOkOSU5ju75A8+skdS+9Ve4TX8bIoqe0zV85aWNRE=;
 b=BRvGOVu7MHHNKXz0vmN2PjzfrDIxMfyUhy3GiC2A9dq5ztXl7FuWDJVem68V9EwsVJ
 r4dYmUJY61fuN5FFVTrGdjxt78L10mImXs3GOeQxILVAzFOrdwe6affFCpLJ11hHYf8g
 qVIiFunGKber0hngIjFBfb+bMHiF6HC93tvTjGCZZfJc9h21UA+DEGo+vVgWveN3wJ6P
 pukN3V03Mp1Fk44zV60QCBO/jNlZKgVo/eUftJHH3YoH+NGgCXWJZ8q0gUNa2CGrJ/rh
 M1+1KGVS3KTHk7YZ7sFazGQqf2vTXLnooGHNeG7QwNoByvh+XGOh01h0u+RzD+xnLIBO
 evGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686713162; x=1689305162;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2mHOkOSU5ju75A8+skdS+9Ve4TX8bIoqe0zV85aWNRE=;
 b=XDFqRtPeKGrziBBBFF4JWkenwLwHzfq9zf+uglFT8F5cnLuomipsXNFvSxwRqMgZf2
 aNOiGG5ENoYuEM/nrC10g8eFE/038vDc0AuS2vKdk1jBOOg+SC3TzzLOvrmYuoBKIcv8
 Kk/6BH/JixUl+8ys4ieUGpiAa1Y6iWEEVF/Ss1uD1IZWpIccH3AnhlgU/6g3d69TUqRX
 twFnCRJdmYPaYKgy9X67CLTMxsQ1dCxkuFXAxzMLYnT/1+it5+OSEU6gspbeqyAH9CLk
 UO9ez72pnqW/z/RlrsC/It/MTv971LlERKuOj5DuL81ia6cC27UCxVyEuqtCxRfMUYFl
 B2+w==
X-Gm-Message-State: AC+VfDw6qvS2wp+mEW6Y/YT9QbieR2yNBFOcs+yqFAVT7rrPkCrfedha
 LuxobS85ze/n9NDoD6imcdw=
X-Google-Smtp-Source: ACHHUZ7MzQAIrwRaNDky8CAMmMPckQesbloYlBqQtbRwX4MQnkg5N1pADXz9QKZzmQCVx1rRazJyDQ==
X-Received: by 2002:a05:6a00:1144:b0:647:e45f:1a4c with SMTP id
 b4-20020a056a00114400b00647e45f1a4cmr653792pfm.11.1686713161733; 
 Tue, 13 Jun 2023 20:26:01 -0700 (PDT)
Received: from localhost ([1.146.66.73]) by smtp.gmail.com with ESMTPSA id
 x2-20020a056a00270200b005d22639b577sm1113587pfv.165.2023.06.13.20.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 20:26:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 13:25:50 +1000
Message-Id: <CTC1WS7U75CJ.30S7ZR0AIGC73@wheely>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH 01/10] target/ppc: Remove some superfluous parentheses
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <0e526b0cdfc31655fd1d3c3f2d6ea75bcafb8f3c.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <0e526b0cdfc31655fd1d3c3f2d6ea75bcafb8f3c.1686522199.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/excp_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 12d8a7257b..8298217e78 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1009,7 +1009,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int =
excp)
>      {
>          int lev =3D env->error_code;
> =20
> -        if ((lev =3D=3D 1) && cpu->vhyp) {
> +        if (lev =3D=3D 1 && cpu->vhyp) {
>              dump_hcall(env);
>          } else {
>              dump_syscall(env);
> @@ -1027,7 +1027,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int =
excp)
>           * uses VOF and the 74xx CPUs, so although the 74xx don't have
>           * HV mode, we need to keep hypercall support.
>           */
> -        if ((lev =3D=3D 1) && cpu->vhyp) {
> +        if (lev =3D=3D 1 && cpu->vhyp) {
>              PPCVirtualHypervisorClass *vhc =3D
>                  PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>              vhc->hypercall(cpu->vhyp, cpu);
> @@ -1481,7 +1481,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int=
 excp)
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>          lev =3D env->error_code;
> =20
> -        if ((lev =3D=3D 1) && cpu->vhyp) {
> +        if (lev =3D=3D 1 && cpu->vhyp) {
>              dump_hcall(env);
>          } else {
>              dump_syscall(env);
> @@ -1494,7 +1494,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int=
 excp)
>          env->nip +=3D 4;
> =20
>          /* "PAPR mode" built-in hypercall emulation */
> -        if ((lev =3D=3D 1) && books_vhyp_handles_hcall(cpu)) {
> +        if (lev =3D=3D 1 && books_vhyp_handles_hcall(cpu)) {
>              PPCVirtualHypervisorClass *vhc =3D
>                  PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>              vhc->hypercall(cpu->vhyp, cpu);
> --=20
> 2.30.9


