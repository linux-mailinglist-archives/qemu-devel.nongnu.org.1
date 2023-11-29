Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F17A47FCD98
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 04:49:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8BYU-00034S-Kb; Tue, 28 Nov 2023 22:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8BYK-00033Y-Gi; Tue, 28 Nov 2023 22:47:58 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8BYI-0000SA-Dt; Tue, 28 Nov 2023 22:47:55 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6cbe716b511so4766093b3a.3; 
 Tue, 28 Nov 2023 19:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701229670; x=1701834470; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwLCSbjrqbB8zFk7O7IsMYDhiegCcOuBn6fltNdkjNY=;
 b=iMb+KgGEDdFC5fN+nmtmyBt3reFPuyejepaDoS97J+csp7zGqPobMMtqJOip6lJprE
 RegU/cXaZH9ZAXI0SwlYYPtbudlPLJ4GqfAzLGuRwvpvVxmrI6mfhtACV9dg0cwJVmfd
 xQx36AwPK0Qi9LnWIPADMUrBfr9+9C6x/Im82/mZC0V/5Y6j9gOfCaGu5r4m6O1VAVsI
 2EiSKgSunr+D1+3bYJd0rB6C0OPduTeQHbzYdM9s6ugzKDghyXTPZJk4IaO9YZ60yrl2
 4ML4CqyoT/dRefGqseVRiqaMN2D3kvHb4UF/emS/GW0IPsDK6PtbTAbtTrubJDSKTyV3
 nULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701229670; x=1701834470;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zwLCSbjrqbB8zFk7O7IsMYDhiegCcOuBn6fltNdkjNY=;
 b=lMAN2KShr2hgs0r9mqa7Pa8wMcUJE/ORZGT3AdvHXaln/F+3bDQ0awBrp95fr0mySJ
 fBDysXFgZAYQy/dvmyR//Iuzk5p2oZ5Uf9XUceKtSLsba2jqCuY8ovqo7dryPhfJbYsA
 avQ3FoUn4S6QbE6BF2tFP4iZZ7CdlKCzxIfM2fk0QZjc4SZjj9ng/z6jBQRSgK59qies
 ACwxou2XK6pDyWoDze2y1zfSTUdWb10LZlTZjBCFU1sCx6/aqh5tvBEKN3r/lmeIrPez
 gvtkxYzsZddfiYUXL7JC6bZW/LNRwcRepf2b7KahH4iUpGInr/UA7YAO5Gm2tGiIwN49
 jNrg==
X-Gm-Message-State: AOJu0YwhjJgNR68vkv4ZItf6v8cVVrt2INtN+bVVik/CWu4IfyW9YX1n
 1n7D66Q+/Odycy2J1iv/zxo=
X-Google-Smtp-Source: AGHT+IEkg2c4Dqj25U9w9IXHE6CqALz0N7wq9bUtGJlAxnVh/smPCrrI6SGrE2k44sLAKbzgSOeyWg==
X-Received: by 2002:a05:6a00:1a88:b0:6cd:aff4:8dcc with SMTP id
 e8-20020a056a001a8800b006cdaff48dccmr2547244pfv.29.1701229670354; 
 Tue, 28 Nov 2023 19:47:50 -0800 (PST)
Received: from localhost ([124.170.16.164]) by smtp.gmail.com with ESMTPSA id
 q18-20020a056a00085200b006cc02e550f0sm6546596pfk.130.2023.11.28.19.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 19:47:49 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Nov 2023 13:47:43 +1000
Message-Id: <CXAZL2F3WKME.1ZE6Y4IFGFHUF@wheely>
Cc: <clegoate@redhat.com>, <qemu-devel@nongnu.org>, <mikey@neuling.org>,
 <vaibhav@linux.ibm.com>, <jniethe5@gmail.com>, <sbhat@linux.ibm.com>,
 <kconsul@linux.vnet.ibm.com>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 01/14] spapr: nested: move nested part of
 spapr_get_pate into spapr_nested.c
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
 <20231012104951.194876-2-harshpb@linux.ibm.com>
In-Reply-To: <20231012104951.194876-2-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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
> Most of the nested code has already been moved to spapr_nested.c
> This logic inside spapr_get_pate is related to nested guests and
> better suited for spapr_nested.c, hence moving there.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  hw/ppc/spapr.c                | 28 ++--------------------------
>  hw/ppc/spapr_nested.c         | 29 +++++++++++++++++++++++++++++
>  include/hw/ppc/spapr_nested.h |  3 ++-
>  3 files changed, 33 insertions(+), 27 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cb840676d3..a2c69d0f4f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1341,7 +1341,6 @@ void spapr_init_all_lpcrs(target_ulong value, targe=
t_ulong mask)
>      }
>  }
> =20
> -
>  static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
>                             target_ulong lpid, ppc_v3_pate_t *entry)
>  {
> @@ -1354,33 +1353,10 @@ static bool spapr_get_pate(PPCVirtualHypervisor *=
vhyp, PowerPCCPU *cpu,
>          /* Copy PATE1:GR into PATE0:HR */
>          entry->dw0 =3D spapr->patb_entry & PATE0_HR;
>          entry->dw1 =3D spapr->patb_entry;
> -
> +        return true;
>      } else {
> -        uint64_t patb, pats;
> -
> -        assert(lpid !=3D 0);
> -
> -        patb =3D spapr->nested_ptcr & PTCR_PATB;
> -        pats =3D spapr->nested_ptcr & PTCR_PATS;
> -
> -        /* Check if partition table is properly aligned */
> -        if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
> -            return false;
> -        }
> -
> -        /* Calculate number of entries */
> -        pats =3D 1ull << (pats + 12 - 4);
> -        if (pats <=3D lpid) {
> -            return false;
> -        }
> -
> -        /* Grab entry */
> -        patb +=3D 16 * lpid;
> -        entry->dw0 =3D ldq_phys(CPU(cpu)->as, patb);
> -        entry->dw1 =3D ldq_phys(CPU(cpu)->as, patb + 8);
> +        return spapr_get_pate_nested(spapr, cpu, lpid, entry);
>      }
> -
> -    return true;
>  }
> =20
>  #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 121aa96ddc..123e127b08 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -6,6 +6,35 @@
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/spapr_nested.h"
> +#include "mmu-book3s-v3.h"
> +
> +bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
> +                           target_ulong lpid, ppc_v3_pate_t *entry)
> +{
> +    uint64_t patb, pats;
> +
> +    assert(lpid !=3D 0);
> +
> +    patb =3D spapr->nested_ptcr & PTCR_PATB;
> +    pats =3D spapr->nested_ptcr & PTCR_PATS;
> +
> +    /* Check if partition table is properly aligned */
> +    if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
> +        return false;
> +    }
> +
> +    /* Calculate number of entries */
> +    pats =3D 1ull << (pats + 12 - 4);
> +    if (pats <=3D lpid) {
> +        return false;
> +    }
> +
> +    /* Grab entry */
> +    patb +=3D 16 * lpid;
> +    entry->dw0 =3D ldq_phys(CPU(cpu)->as, patb);
> +    entry->dw1 =3D ldq_phys(CPU(cpu)->as, patb + 8);
> +    return true;
> +}
> =20
>  #ifdef CONFIG_TCG
>  #define PRTS_MASK      0x1f
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index d383486476..e3d15d6d0b 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -98,5 +98,6 @@ struct nested_ppc_state {
> =20
>  void spapr_register_nested(void);
>  void spapr_exit_nested(PowerPCCPU *cpu, int excp);
> -
> +bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
> +                           target_ulong lpid, ppc_v3_pate_t *entry);
>  #endif /* HW_SPAPR_NESTED_H */


