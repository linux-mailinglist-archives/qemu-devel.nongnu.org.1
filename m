Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 434D77FCDC6
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 05:16:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Bz0-0008C2-Im; Tue, 28 Nov 2023 23:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8Byx-0008BY-Uy; Tue, 28 Nov 2023 23:15:27 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8Byw-0006OU-1Y; Tue, 28 Nov 2023 23:15:27 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6cbc8199a2aso5461854b3a.1; 
 Tue, 28 Nov 2023 20:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701231324; x=1701836124; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vkvw1N7WBvxKi2qGCLd2OelBg+iYsq2ODq0fY+2z4ro=;
 b=Xh8yfMHgs4JdJdB8wzOaI9q1QNBnUuk2ZqDYKQkF0EEk09dLhtkEMQloDkMSvsGJMR
 lATUHSEhRaHZ7vM+U/uHKUtirLP059QBjEE4kDQ/qdonqGG+9UNhuoKWFaHNZoZDP8d/
 7YP+u62tnFZvDomDkYnGUK8zq2fw3yhbF+StEyZIkdge763pBO5RbD80TtZYCI/UZBDv
 UVjoUmsnmZENlvdY0minT0ofycK+r1DUHugttIxWp8JFjnjq6823XXBHER1k2xDtDXh1
 1cnbDXr75dWlnqcLWo8IWUHjQljFTss7eZzmIYkbWoGC9SMitvUr2ksEsHepjDCOzh3E
 QBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701231324; x=1701836124;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vkvw1N7WBvxKi2qGCLd2OelBg+iYsq2ODq0fY+2z4ro=;
 b=YK45nd3fV9R4bRGwHqlfP0OJNjrp4nYiVW/FVsU+J9yhAKi5JwXfxs4ttGxrOAcbJ8
 am73SiRo6+SbB0KO3jbn2DnGjREGJQ284dqyUhWNi8DOfgqmGCY4ePzUyRZlPglGfQi9
 jWiWwP6TA+Ec7zxjkqqjDw3UM1+Mgw7krNSTklWrqPcJpDncUeXJg/zmPFsJ42EgpoOr
 cxwC5tDXv3VzSCR++2todRWmveJ71C4FJ+hggxDmXHjyJBIkxDbvU1hfVbVyBEDvxTkS
 U5IBNG68+7H4zsLR19cL0DZN7vRJ2h68YDv66zJ3aCg0BF/uWtfLhY8o12CViVdI+hdq
 IOmg==
X-Gm-Message-State: AOJu0YzXyRXNo3kti1liXmrFyYKGyL8YZ0BN8R8P5INDnCYW2K7nvLKK
 +AyjNCbHB96myerRBGwEBnE=
X-Google-Smtp-Source: AGHT+IHCad3OTdu+2ccWbzJGJKs6vHSpGGRfu6rHwoN+T759/RMAAOeAq+3abA4hdgE1VEzrnGlRJg==
X-Received: by 2002:a05:6a00:1914:b0:6c3:703a:c394 with SMTP id
 y20-20020a056a00191400b006c3703ac394mr18722850pfi.27.1701231323818; 
 Tue, 28 Nov 2023 20:15:23 -0800 (PST)
Received: from localhost ([124.170.16.164]) by smtp.gmail.com with ESMTPSA id
 fj14-20020a056a003a0e00b006cbef269712sm8972258pfb.9.2023.11.28.20.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 20:15:23 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Nov 2023 14:15:17 +1000
Message-Id: <CXB065Z14ATU.3V8KU00E4QYP8@wheely>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <clegoate@redhat.com>, <qemu-devel@nongnu.org>, <mikey@neuling.org>,
 <vaibhav@linux.ibm.com>, <jniethe5@gmail.com>, <sbhat@linux.ibm.com>,
 <kconsul@linux.vnet.ibm.com>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 11/14] spapr: nested: Use correct source for parttbl
 info for nested PAPR API.
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
 <20231012104951.194876-12-harshpb@linux.ibm.com>
In-Reply-To: <20231012104951.194876-12-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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
> For nested PAPR API, we use SpaprMachineStateNestedGuest struct to store
> partition table info, use the same in spapr_get_pate_nested() as well.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr.c                |  5 +---
>  hw/ppc/spapr_nested.c         | 49 +++++++++++++++++++++++------------
>  include/hw/ppc/spapr_nested.h |  3 +++
>  3 files changed, 36 insertions(+), 21 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 14196fdd11..e1f7b29842 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1356,10 +1356,7 @@ static bool spapr_get_pate(PPCVirtualHypervisor *v=
hyp, PowerPCCPU *cpu,
>          return true;
>      } else {
>          assert(spapr->nested.api);
> -        if (spapr->nested.api =3D=3D NESTED_API_KVM_HV) {
> -            return spapr_get_pate_nested(spapr, cpu, lpid, entry);
> -        }
> -        return false;
> +        return spapr_get_pate_nested(spapr, cpu, lpid, entry);

If you don't permit the api to be changed to PAPR at the start, then you
don't need to juggle this back and forth.

>      }
>  }
> =20
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index f41b0c0944..1917d8bb13 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -19,29 +19,45 @@ void spapr_nested_init(SpaprMachineState *spapr)
>  bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
>                             target_ulong lpid, ppc_v3_pate_t *entry)
>  {
> -    uint64_t patb, pats;
> +    if (spapr->nested.api =3D=3D NESTED_API_KVM_HV) {

Maybe split out the implementations into two functions?

And actually instead of open coding the API test, I'm thinking
maybe you should add a helper function

spapr_cpu_nested_api(cpu) which returns NESTED_API_... and you
can just hard code it to return spapr->nested.api for now.
That should avoid a bunch of churn when we permit guests to
run with different APIs.

> +        uint64_t patb, pats;
> =20
> -    assert(lpid !=3D 0);
> +        assert(lpid !=3D 0);
> =20
> -    patb =3D spapr->nested.ptcr & PTCR_PATB;
> -    pats =3D spapr->nested.ptcr & PTCR_PATS;
> +        patb =3D spapr->nested.ptcr & PTCR_PATB;
> +        pats =3D spapr->nested.ptcr & PTCR_PATS;
> =20
> -    /* Check if partition table is properly aligned */
> -    if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
> -        return false;
> -    }
> +        /* Check if partition table is properly aligned */
> +        if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
> +            return false;
> +        }
> =20
> -    /* Calculate number of entries */
> -    pats =3D 1ull << (pats + 12 - 4);
> -    if (pats <=3D lpid) {
> -        return false;
> +        /* Calculate number of entries */
> +        pats =3D 1ull << (pats + 12 - 4);
> +        if (pats <=3D lpid) {
> +            return false;
> +        }
> +
> +        /* Grab entry */
> +        patb +=3D 16 * lpid;
> +        entry->dw0 =3D ldq_phys(CPU(cpu)->as, patb);
> +        entry->dw1 =3D ldq_phys(CPU(cpu)->as, patb + 8);
> +        return true;
>      }
> +#ifdef CONFIG_TCG

Nested spapr is entirely TCG, no? If we're not properly guarding the
nested code with CONFIG_TCG, that should go as an initial prep patch.

Thanks,
Nick

> +    /* Nested PAPR API */
> +    SpaprMachineStateNestedGuest *guest;
> +    assert(lpid !=3D 0);
> +    guest =3D spapr_get_nested_guest(spapr, lpid);
> +    assert(guest !=3D NULL);
> +
> +    entry->dw0 =3D guest->parttbl[0];
> +    entry->dw1 =3D guest->parttbl[1];
> =20
> -    /* Grab entry */
> -    patb +=3D 16 * lpid;
> -    entry->dw0 =3D ldq_phys(CPU(cpu)->as, patb);
> -    entry->dw1 =3D ldq_phys(CPU(cpu)->as, patb + 8);
>      return true;
> +#else
> +    return false;
> +#endif
>  }
> =20
>  #ifdef CONFIG_TCG
> @@ -412,7 +428,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>      address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>  }
> =20
> -static
>  SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *=
spapr,
>                                                       target_ulong guesti=
d)
>  {
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index d27688b1b8..e04202ecb4 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -457,4 +457,7 @@ bool spapr_get_pate_nested(SpaprMachineState *spapr, =
PowerPCCPU *cpu,
>  void spapr_register_nested_papr(void);
>  void spapr_nested_init(SpaprMachineState *spapr);
>  void spapr_nested_gsb_init(void);
> +SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *=
spapr,
> +                                                     target_ulong lpid);
> +
>  #endif /* HW_SPAPR_NESTED_H */


