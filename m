Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 752887FCDCB
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 05:17:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8C0h-0000TS-4G; Tue, 28 Nov 2023 23:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8C0Y-0000Sy-PU; Tue, 28 Nov 2023 23:17:08 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8C0V-0006nA-HW; Tue, 28 Nov 2023 23:17:05 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6cdcef8b400so374567b3a.1; 
 Tue, 28 Nov 2023 20:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701231421; x=1701836221; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUicCaaHo9tQqHvHbS8DANafmn3rLeSDBVn8O4kwRng=;
 b=NLgbkdlIVF/TnpSLfnlb+lzafX9Fw3et2tiXLzS0XtQFQysLsj6zrOHddNjnKmoRQr
 dVhQVr0m4KvyNxrwALFLnlbQk8OEe07Zt0XfkO61yYLAGu2HEWvKDHEwRcaOybr4y0CB
 Km0f4mXMbik9yBTRD12cU0xnCrE1GjkFe4xYWyBSWzKJhBcRo7ZuNOjgdPOWaxtXyM67
 WuHpLqRht6JpRWjVjVQsaJsSApQR0WcBARh0+aDqelkptEkBMqXrpK9YUzS71Bi7taeQ
 23H4ZWg6DfLHrgusAnwW5sDAC+H+a8mcuTHrgqqLocYWz/wF1Vu1VeFGBwBrzBv5Uy0Z
 uJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701231421; x=1701836221;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AUicCaaHo9tQqHvHbS8DANafmn3rLeSDBVn8O4kwRng=;
 b=fRWGzLrqfgXlVgvUNv6etLMMpGFumskmFys+g8z1hjXVefIJypu6vSA2PKe+4CHwWr
 z8CuziRaTBUtu1y8dHRQMZ4mRuBRWXzBuqKWQfvjcCT6ff2QyP386DZlYwOwVLMGRmxp
 xlKUAQhbptYJ1rDkSrdUH+YEBomF5Ao9pYBfFP66CRQTesK6oj6e4q2LpQZP3UfOcOlC
 CdqAOgmnXJJ1t7XEAPkHT6CvxD5foGGzQwhnIVCFkq/pBQgVomU7KHNMEdo76QrlC4nz
 gaj0XzSS1zAp2CdAYBJ0yt0Yxp2JlQ304I6K9aG2IuaqK6e+yncwA4TvsjkDMykNRwK8
 p9Zg==
X-Gm-Message-State: AOJu0YyZimhHrg/i5d/Zd1V8wikeUw2hx2jUGohN9gj2WwxlTU4u62SQ
 JzSZ1uNnMFh9HkkfpQIoSWI8Ycw83P4=
X-Google-Smtp-Source: AGHT+IEDgejK4o2IO1Cuq+QydXNP/ZsWU2X1x1fEy/ruFF10/JHL6wCOgOE14ebmpOJd32dST2I4gw==
X-Received: by 2002:a05:6a00:15cb:b0:6cd:85a4:bbbc with SMTP id
 o11-20020a056a0015cb00b006cd85a4bbbcmr12169200pfu.9.1701231421204; 
 Tue, 28 Nov 2023 20:17:01 -0800 (PST)
Received: from localhost ([124.170.16.164]) by smtp.gmail.com with ESMTPSA id
 j24-20020aa78d18000000b0068fece2c190sm9574667pfe.70.2023.11.28.20.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 20:17:00 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Nov 2023 14:16:55 +1000
Message-Id: <CXB07EXQ2G1I.2BAP4QJEPR4NH@wheely>
Cc: <clegoate@redhat.com>, <qemu-devel@nongnu.org>, <mikey@neuling.org>,
 <vaibhav@linux.ibm.com>, <jniethe5@gmail.com>, <sbhat@linux.ibm.com>,
 <kconsul@linux.vnet.ibm.com>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 13/14] spapr: nested: keep nested-hv exit code
 restricted to its API.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
 <20231012104951.194876-14-harshpb@linux.ibm.com>
In-Reply-To: <20231012104951.194876-14-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

On Thu Oct 12, 2023 at 8:49 PM AEST, Harsh Prateek Bora wrote:
> spapr_exit_nested gets triggered on a nested guest exit and currently
> being used only for nested-hv API. Isolating code flows based on API
> helps extending it to be used with nested PAPR API as well.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr_nested.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 607fb7ead2..e2d0cb5559 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -325,7 +325,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
>      return env->gpr[3];
>  }
> =20
> -void spapr_exit_nested(PowerPCCPU *cpu, int excp)
> +static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> @@ -337,8 +337,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>      struct kvmppc_pt_regs *regs;
>      hwaddr len;
> =20
> -    assert(spapr_cpu->in_nested);
> -
>      nested_save_state(&l2_state, cpu);
>      hsrr0 =3D env->spr[SPR_HSRR0];
>      hsrr1 =3D env->spr[SPR_HSRR1];
> @@ -428,6 +426,17 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>      address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>  }
> =20
> +void spapr_exit_nested(PowerPCCPU *cpu, int excp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +
> +    assert(spapr_cpu->in_nested);
> +    if (spapr->nested.api =3D=3D NESTED_API_KVM_HV) {
> +        spapr_exit_nested_hv(cpu, excp);
> +    }
> +}
> +
>  SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *=
spapr,
>                                                       target_ulong guesti=
d)
>  {


