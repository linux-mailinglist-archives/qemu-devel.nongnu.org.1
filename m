Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8007B796E78
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 03:14:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe3au-0006zn-Oh; Wed, 06 Sep 2023 21:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe3as-0006za-TO; Wed, 06 Sep 2023 21:14:02 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe3aq-0006sJ-By; Wed, 06 Sep 2023 21:14:02 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c336f3f449so3667695ad.3; 
 Wed, 06 Sep 2023 18:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694049238; x=1694654038; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nh1bcRJRhlhU+4Bfm/7C1sb7oH6qglmMv2Ed1MzGbzU=;
 b=f9t9jjIztbm78a2HyH64F17Jf4V9mD53j44b9TtcOMpWW3XRzjp/y8Ag2/3BhMAtDr
 /8grP1nwflx3BbGH+wltLI5QGdB4lXvps0gv4opr0cKRjO3RHQAVeBr8xVT9Ig6yLxOV
 6rng2LnPTdRPL8xF4rdO9sSbuf1Y8dyJ7WURlmkTY7ogCuPUko6kC0p31utMfKcEH7Sq
 LtxnsmpB9kSbM9WsIb46nNAv8/nGIzdGXPHcXu0bSCAHTDL3lI8Nz05/oEPaeEEydCjQ
 kcgkXOunIGUhadDWOcBvSfiGhM2VQ+T8AxUbz4hVAdYsoqK96l5iROK+uobl5OyKcAFs
 0gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694049238; x=1694654038;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nh1bcRJRhlhU+4Bfm/7C1sb7oH6qglmMv2Ed1MzGbzU=;
 b=lnpnSaksnGfVeWCq8OeN2ApLQdPWwfJ8XXpme5dhVvha8RjcMOsLKkZCcDi3nOS6YZ
 ILmiruJlnPZECy67IjEgrKouRV11L4Qk2wQUW7bwKxoGhO069ikHRlmI5iZ+BeC7IclE
 MC0lBMav/vsQZiCQfd1gLGeSCdVobwQI8taa+JppTJ9T9I91P5U/EDEP4HRkwbc5ZThh
 aA0PgGW23GgFmnlgsQNGrG/6M/1+4nOkKS/PVqY7eZdblR4ijRgDQsvjBHKA/eOR9bHc
 mdbl1wE3co9rTt3jhqTeT8X/Hy7QP4txRTzGbMBgnx78HDCzqcCuIt8pe5/Q3UC/Zs6r
 qGJg==
X-Gm-Message-State: AOJu0YzNk/YzFt7VDOIxGlhEUPKIw5CJX5/cL9g8B/1LN7z7ziBSBXg/
 ghsEinzevXkYs4NCka/2NyE=
X-Google-Smtp-Source: AGHT+IGaEgd2VdwatO8PRfdk8WGNS9X3yyBJ8REdLCRAg383svyQZEgnjtg+salid9ha3vAR8YE6VA==
X-Received: by 2002:a17:902:b485:b0:1bc:9651:57c6 with SMTP id
 y5-20020a170902b48500b001bc965157c6mr16924527plr.57.1694049238438; 
 Wed, 06 Sep 2023 18:13:58 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a170902ec8800b001bf095dfb76sm11587530plg.237.2023.09.06.18.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 18:13:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 11:13:52 +1000
Message-Id: <CVCAC1ITW1TA.1L7Q46DV3IHKA@wheely>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 03/15] ppc: spapr: Use SpaprMachineStateNested's
 ptcr instead of nested_ptcr
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-4-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-4-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
> Use nested guest state specific struct for storing related info.

So this is the patch I would introduce the SpaprMachineStateNested
struct, with just the .ptrc member. Add other members to it as they
are used in later patches.

>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr.c         | 4 ++--
>  hw/ppc/spapr_nested.c  | 4 ++--
>  include/hw/ppc/spapr.h | 3 ++-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 07e91e3800..e44686b04d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1340,8 +1340,8 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vh=
yp, PowerPCCPU *cpu,
> =20
>          assert(lpid !=3D 0);
> =20
> -        patb =3D spapr->nested_ptcr & PTCR_PATB;
> -        pats =3D spapr->nested_ptcr & PTCR_PATS;
> +        patb =3D spapr->nested.ptcr & PTCR_PATB;
> +        pats =3D spapr->nested.ptcr & PTCR_PATS;
> =20
>          /* Check if partition table is properly aligned */
>          if (patb & MAKE_64BIT_MASK(0, pats + 12)) {

At this point I wonder if we should first move the nested part of
spapr_get_pate into nested code. It's a bit of a wart to have it
here when most of the other nested cases are abstracted from non
nested code quite well.

> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 121aa96ddc..a669470f1a 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -25,7 +25,7 @@ static target_ulong h_set_ptbl(PowerPCCPU *cpu,
>          return H_PARAMETER;
>      }
> =20
> -    spapr->nested_ptcr =3D ptcr; /* Save new partition table */
> +    spapr->nested.ptcr =3D ptcr; /* Save new partition table */
> =20
>      return H_SUCCESS;
>  }
> @@ -157,7 +157,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
>      struct kvmppc_pt_regs *regs;
>      hwaddr len;
> =20
> -    if (spapr->nested_ptcr =3D=3D 0) {
> +    if (spapr->nested.ptcr =3D=3D 0) {
>          return H_NOT_AVAILABLE;
>      }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 3990fed1d9..c8b42af430 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -12,6 +12,7 @@
>  #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
>  #include "hw/ppc/xics.h"        /* For ICSState */
>  #include "hw/ppc/spapr_tpm_proxy.h"
> +#include "hw/ppc/spapr_nested.h" /* for SpaprMachineStateNested */
> =20
>  struct SpaprVioBus;
>  struct SpaprPhbState;
> @@ -216,7 +217,7 @@ struct SpaprMachineState {
>      uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") */
> =20
>      /* Nested HV support (TCG only) */
> -    uint64_t nested_ptcr;
> +    struct SpaprMachineStateNested nested;

I think convention says to use the typedef for these?

Thanks,
Nick

> =20
>      Notifier epow_notifier;
>      QTAILQ_HEAD(, SpaprEventLogEntry) pending_events;


