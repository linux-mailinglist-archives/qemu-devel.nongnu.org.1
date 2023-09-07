Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF1796ED0
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 04:11:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe4Sg-0003VN-RP; Wed, 06 Sep 2023 22:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe4Se-0003Ud-Qn; Wed, 06 Sep 2023 22:09:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe4Sc-0000ht-7H; Wed, 06 Sep 2023 22:09:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68a3e271491so406358b3a.0; 
 Wed, 06 Sep 2023 19:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694052572; x=1694657372; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aid1PRyiwrW4kPLa/3ek3hR4o+lDM2ytCwfCh+lJ/DI=;
 b=BgubbKTnqv1Y1AIuPVdYlbmou8pNAJg8itpjRvfeAStr0rXA3puxRFS4y09LDuk8Xu
 IiVNENJTsqSFhZ2vmTG/tQeZf7IAn+elMQ93DQmeGT4pEeEPMInMh/zZyefJrv0pn2T1
 xiqCuIjcwEOsnSb62KAr3gCcocVYDZQSEB/Qq+b0wooCR+yCSuPM4dy39rsI/krF4jp6
 aEIGizKuFzdWUlPpOH8bVNqMYDDQk0FiLxqXc35znXcX383Sh6jWwaQHnSZJKX7y5Pk3
 FRJGYcWDGqfDjHU+ZTV5IQbVKWitRSNy6jXQvRJfYLyp/9SCM46Y9Rmk0dUWdM8fEICJ
 9bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694052572; x=1694657372;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aid1PRyiwrW4kPLa/3ek3hR4o+lDM2ytCwfCh+lJ/DI=;
 b=Pny2BeHUqblH+bQxZvHDExYUXeCVZ/mv/u65JxP4q7V8nmfj8RSCuHzg9odxV05O1f
 u9j7thNeOeXQ2QzhLOIB5LiR81plJTBS2SzqKCamLTgfcj0WtBVW/jGYP6RFC2qsmH3d
 yxgX4lx54NQIY4hLUkp8z/5HSY2sWLpq79wFl6if6+SJgoVcX4fnfAmtsCEc0T72ahpL
 5AK5FGdSlKiMzzvzjNdVOZutIIuUp3Z79bsywyRv+jVBQGvqsZlcsXPuSbHf+AT2+pun
 yWnxkmPLyl7qI20LgIkW3hZ/NCPJRFoAGrtLjsJnsuZSB5j6E8VXTD+DLomYlWbzZ1Bt
 80aw==
X-Gm-Message-State: AOJu0YxB4qaFv5RW/DnYJi10+tKygpU2zLJfgpkiufUZZLPiyPdIVUAB
 ubFORp+9YrXFo8sN1KM8gRk=
X-Google-Smtp-Source: AGHT+IHN/rVa4BBby5l5aXT+WAC8jiIg/IGZhcs19U49x40Y6sEBo2TbUeRHBoYAWqDH9FyIZXJwZg==
X-Received: by 2002:a62:f24c:0:b0:68e:30db:ee43 with SMTP id
 y12-20020a62f24c000000b0068e30dbee43mr3125859pfl.21.1694052572120; 
 Wed, 06 Sep 2023 19:09:32 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b00688435a9915sm11386626pfe.189.2023.09.06.19.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 19:09:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 12:09:26 +1000
Message-Id: <CVCBILCCQQKB.2L31Z17STQ298@wheely>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 07/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_SET_CAPABILITIES
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-8-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-8-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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
> This patch implements nested PAPR hcall H_GUEST_SET_CAPABILITIES.
> This is used by L1 to set capabilities of the nested guest being
> created. The capabilities being set are subset of the capabilities
> returned from the previous call to H_GUEST_GET_CAPABILITIES hcall.
> Currently, it only supports P9/P10 capability check through PVR.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr.c                |  1 +
>  hw/ppc/spapr_nested.c         | 46 +++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr_nested.h |  3 +++
>  3 files changed, 50 insertions(+)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cbab7a825f..7c6f6ee25d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3443,6 +3443,7 @@ static void spapr_instance_init(Object *obj)
>          "Host serial number to advertise in guest device tree");
>      /* Nested */
>      spapr->nested.api =3D 0;
> +    spapr->nested.capabilities_set =3D false;

I would actually think about moving spapr->nested init into
spapr_nested.c.

>  }
> =20
>  static void spapr_machine_finalizefn(Object *obj)
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 37f3a49be2..9af65f257f 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -399,6 +399,51 @@ static target_ulong h_guest_get_capabilities(PowerPC=
CPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
> +                                             SpaprMachineState *spapr,
> +                                             target_ulong opcode,
> +                                              target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong flags =3D args[0];
> +    target_ulong capabilities =3D args[1];
> +
> +    if (flags) { /* don't handle any flags capabilities for now */
> +        return H_PARAMETER;
> +    }
> +
> +

May need to do a pass over whitespace.

> +    /* isn't supported */
> +    if (capabilities & H_GUEST_CAPABILITIES_COPY_MEM) {
> +        env->gpr[4] =3D 0;
> +        return H_P2;
> +    }
> +
> +    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) =3D=3D
> +        (CPU_POWERPC_POWER9_BASE)) {
> +        /* We are a P9 */
> +        if (!(capabilities & H_GUEST_CAPABILITIES_P9_MODE)) {
> +            env->gpr[4] =3D 1;
> +            return H_P2;
> +        }
> +    }
> +
> +    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) =3D=3D
> +        (CPU_POWERPC_POWER10_BASE)) {
> +        /* We are a P10 */

The 2 comments above aren't helpful. Just remove them.

> +        if (!(capabilities & H_GUEST_CAPABILITIES_P10_MODE)) {
> +            env->gpr[4] =3D 2;
> +            return H_P2;
> +        }
> +    }
> +
> +    spapr->nested.capabilities_set =3D true;

Is it okay to set twice? If not, add a check. If yes, remove
capabilities_set until it's needed.

> +
> +    spapr->nested.pvr_base =3D env->spr[SPR_PVR];
> +
> +    return H_SUCCESS;
> +}
> +
>  void spapr_register_nested(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -410,6 +455,7 @@ void spapr_register_nested(void)
>  void spapr_register_nested_phyp(void)
>  {
>      spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capab=
ilities);
> +    spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capab=
ilities);
>  }
> =20
>  #else
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index ce198e9f70..a7996251cb 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -193,6 +193,9 @@
>  #define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
>  #define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
>  #define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000
> +#define H_GUEST_CAP_COPY_MEM_BMAP   0
> +#define H_GUEST_CAP_P9_MODE_BMAP    1
> +#define H_GUEST_CAP_P10_MODE_BMAP   2
> =20
>  typedef struct SpaprMachineStateNestedGuest {
>      unsigned long vcpus;


