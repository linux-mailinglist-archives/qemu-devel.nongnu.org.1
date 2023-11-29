Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D80187FCD99
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 04:49:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8BZ9-0003Ap-Gh; Tue, 28 Nov 2023 22:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8BZ1-0003A6-Hf; Tue, 28 Nov 2023 22:48:39 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8BYz-0000WD-Hj; Tue, 28 Nov 2023 22:48:39 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28598035301so4272096a91.0; 
 Tue, 28 Nov 2023 19:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701229716; x=1701834516; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aE38or/toMX1sEU63p+DZxjW97YreIxViO+AubgjFw=;
 b=V9uBTmtXAX9bKWjO9lXbaQKbcd+fPtywCFGYrbfXCKUnXpWcxb3KUJTKi3zCAwuqih
 JYVuNrrdHx/v8qHYk8vge5eyYQ0xjEAxdppWUNXg4+0zFwLwi9344pXqVmiT3rq4Cznk
 Vnt8mAS+TcmeKH91oHG0O03JET4hoelCzzFgjOZzeM4P0KBPzGlcemhAG8pM5+6ltKFI
 1cUFG7z+q8hmvp2h74qMKdmym3IIwQEDGhuEy0t+I5anTZ6HIWLEyquHJUtjRe8BugDP
 gJIaaA+wycB7tWDrjy+wtgaTNhAumZNZu6Fmzzq4g6rtFzHs7s3t8YJnweHxzP/D5lVm
 GjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701229716; x=1701834516;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9aE38or/toMX1sEU63p+DZxjW97YreIxViO+AubgjFw=;
 b=sYC+4x20a9UNN7m8WNer6PMIJWq1KGeoo/pNsKWJJtJf6k17FYPKxQIG1uvMs3hAh7
 1YliAmAIz+zG7IXwKx9pW/eHS6FDA937a6eSm2xgaDdn0H6AvZIlkm3g2pJ3KHHQ1EVw
 53CX6RlAyTRHaXnrVdZs+ORJ6CYuLk6Da9QwbBcgzeNuFIAlwqgBj7LcmONLhiOB4vRz
 G879/CWVeIrMExj5u8Sp17QZdszqQAHiQpHwYT3cb+uXWp9ajnIZlnLMZL1Gp3cl8v4m
 17yK5hANt5Hy1SKO6Itb7KBV/hNvKdX/rk8AcCtCdny6CiFlgU4LXSigv3WYQvqCgIaQ
 dg2Q==
X-Gm-Message-State: AOJu0Yy/6/Vzy78kUBr/1WaH9NQAE6I3nq6D9COWMWDJNbJwGZlIxfDi
 aPq0BGGIEaI7jGGhBckNfTY=
X-Google-Smtp-Source: AGHT+IEc201d8JRdeK9t7vzqcalVRHqXzr73SLZ7maQ9UvotTZK8KisynWiNitWrNDjR4LDByQ7MJA==
X-Received: by 2002:a17:90b:4f48:b0:285:fc67:6164 with SMTP id
 pj8-20020a17090b4f4800b00285fc676164mr4057815pjb.5.1701229715725; 
 Tue, 28 Nov 2023 19:48:35 -0800 (PST)
Received: from localhost ([124.170.16.164]) by smtp.gmail.com with ESMTPSA id
 bo21-20020a17090b091500b00280469602bcsm265001pjb.2.2023.11.28.19.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 19:48:35 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Nov 2023 13:48:30 +1000
Message-Id: <CXAZLNKR1DD7.7QRRPBQN3R1G@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <clegoate@redhat.com>, <qemu-devel@nongnu.org>, <mikey@neuling.org>,
 <vaibhav@linux.ibm.com>, <jniethe5@gmail.com>, <sbhat@linux.ibm.com>,
 <kconsul@linux.vnet.ibm.com>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 02/14] spapr: nested: Introduce
 SpaprMachineStateNested to store related info.
X-Mailer: aerc 0.15.2
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
 <20231012104951.194876-3-harshpb@linux.ibm.com>
In-Reply-To: <20231012104951.194876-3-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
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
> Currently, nested_ptcr is being used by existing nested-hv API to store
> nested guest related info. This need to be organised to extend support
> for the nested PAPR API which would need to store additional info related
> to nested guests in next series of patches.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  hw/ppc/spapr_nested.c         | 8 ++++----
>  include/hw/ppc/spapr.h        | 3 ++-
>  include/hw/ppc/spapr_nested.h | 5 +++++
>  3 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 123e127b08..db47c1196f 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -15,8 +15,8 @@ bool spapr_get_pate_nested(SpaprMachineState *spapr, Po=
werPCCPU *cpu,
> =20
>      assert(lpid !=3D 0);
> =20
> -    patb =3D spapr->nested_ptcr & PTCR_PATB;
> -    pats =3D spapr->nested_ptcr & PTCR_PATS;
> +    patb =3D spapr->nested.ptcr & PTCR_PATB;
> +    pats =3D spapr->nested.ptcr & PTCR_PATS;
> =20
>      /* Check if partition table is properly aligned */
>      if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
> @@ -54,7 +54,7 @@ static target_ulong h_set_ptbl(PowerPCCPU *cpu,
>          return H_PARAMETER;
>      }
> =20
> -    spapr->nested_ptcr =3D ptcr; /* Save new partition table */
> +    spapr->nested.ptcr =3D ptcr; /* Save new partition table */
> =20
>      return H_SUCCESS;
>  }
> @@ -186,7 +186,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
>      struct kvmppc_pt_regs *regs;
>      hwaddr len;
> =20
> -    if (spapr->nested_ptcr =3D=3D 0) {
> +    if (spapr->nested.ptcr =3D=3D 0) {
>          return H_NOT_AVAILABLE;
>      }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index e91791a1a9..3e825f2787 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -12,6 +12,7 @@
>  #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
>  #include "hw/ppc/xics.h"        /* For ICSState */
>  #include "hw/ppc/spapr_tpm_proxy.h"
> +#include "hw/ppc/spapr_nested.h" /* For SpaprMachineStateNested */
> =20
>  struct SpaprVioBus;
>  struct SpaprPhbState;
> @@ -213,7 +214,7 @@ struct SpaprMachineState {
>      uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") */
> =20
>      /* Nested HV support (TCG only) */
> -    uint64_t nested_ptcr;
> +    SpaprMachineStateNested nested;
> =20
>      Notifier epow_notifier;
>      QTAILQ_HEAD(, SpaprEventLogEntry) pending_events;
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index e3d15d6d0b..0722b999cd 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -4,6 +4,10 @@
>  #include "qemu/osdep.h"
>  #include "target/ppc/cpu.h"
> =20
> +typedef struct SpaprMachineStateNested {
> +    uint64_t ptcr;
> +} SpaprMachineStateNested;
> +
>  /*
>   * Register state for entering a nested guest with H_ENTER_NESTED.
>   * New member must be added at the end.
> @@ -98,6 +102,7 @@ struct nested_ppc_state {
> =20
>  void spapr_register_nested(void);
>  void spapr_exit_nested(PowerPCCPU *cpu, int excp);
> +typedef struct SpaprMachineState SpaprMachineState;
>  bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
>                             target_ulong lpid, ppc_v3_pate_t *entry);
>  #endif /* HW_SPAPR_NESTED_H */


