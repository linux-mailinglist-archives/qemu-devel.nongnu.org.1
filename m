Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A86796E95
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 03:37:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe3vl-0004ko-2Q; Wed, 06 Sep 2023 21:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe3vi-0004gq-PD; Wed, 06 Sep 2023 21:35:34 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe3vg-0003Rb-Dr; Wed, 06 Sep 2023 21:35:34 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2680eee423aso305837a91.2; 
 Wed, 06 Sep 2023 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694050530; x=1694655330; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9NSOAJ/SyyMZAE54UR7iJ4BLhbuRXxaqORYZH/jUvlc=;
 b=LZ/ChYUtPXGNfMgVbqc67VFEJzI27OT2tb0PZ3N3uaNwRFOdvQjkeooXz8/lWVTY7k
 n3F3W4+fu25y8sEmFmNJXJMt1EzxoXdH+5ev9YCEOdLquf7IZIFBC2mdUq2h3e3MCgEp
 5DRVHqXbOaEJJJtYxnBmBYLAbq4UcBY90SeVn0o4+vaj2v2RfldA3v4TvxWDp2UUrcVv
 cxIYMZUtiVG7WflTUcKfNxVJjuJ2Vam8bDvqsU0pdmrLfhk2/bRy7OX3X4fPIIsquud0
 53j66WIDy8QvrzDFJLcFHbxpjOZclO1z4FBix47frIoj5/rt4KNJIwiJGVb3Rz4lI7Nv
 ntgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694050530; x=1694655330;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9NSOAJ/SyyMZAE54UR7iJ4BLhbuRXxaqORYZH/jUvlc=;
 b=UbiulFfwkiB57dVN35gb2WcKexCMiTxmK6ILOAFuZftJH1+xWtbw82rQLUZHXapT1V
 jaC3/LetI3no3ih6WFrhr1kfUckHxZCtLEN/wicf2uj+gBQtGJTiHI9iC5RoVs8/G0W5
 T1VyTs3v6t+A7mhWGdMQrVhJJBhkvveKoGmSHpwwl2oAqtr4D9EX2NVYdte+Ct55LPrK
 B69CO/vziilHc8wP65wNRy6cbwWe7R4h1h5+nNAwhb4rNF4cQzBH/G/PA6UEIjbBPabS
 RUBIQc+yn/dHjd/SbIRVGKmp22Re59ogsD/hTdDT69GXntZy3GVhT8XyTq+IDsPhC1Cm
 Xp2w==
X-Gm-Message-State: AOJu0YyfmCiXMOCr0cqfegaAa6xPSZGhW1n1M9gqh8w9i3CYr1PbHuAV
 rOvnCAVg2g1nujfwHs92bj0=
X-Google-Smtp-Source: AGHT+IE7PQatpzY5VVKFwQpP358D+R4SMDp596Thmd8F5L4EoIi24zkaaaONoAOajM1r1HTm/7JdhA==
X-Received: by 2002:a17:90b:33c5:b0:26f:4685:5b6b with SMTP id
 lk5-20020a17090b33c500b0026f46855b6bmr14279750pjb.21.1694050530460; 
 Wed, 06 Sep 2023 18:35:30 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a17090ace0800b0026b55e28035sm371468pju.52.2023.09.06.18.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 18:35:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 11:35:24 +1000
Message-Id: <CVCASJDMEVOC.6N64CVK7Y0HL@wheely>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 04/15] ppc: spapr: Start using nested.api for
 nested kvm-hv api
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-5-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-5-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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
> With this patch, isolating kvm-hv nested api code to be executed only
> when cap-nested-hv is set. This helps keeping api specific logic
> mutually exclusive.

Changelog needs a bit of improvement. Emphasis on "why" for changelogs.
If you take a changeset that makes a single logical change to the code,
you should be able to understand why that is done. You could make some
assumptions about the bigger series when it comes to details so don't
have to explain from first principles. But if it's easy to explain why
the high level, you could.

Why are we adding this fundamentally? So that the spapr nested code can
be extended to support a second API.

This patch should add the api field to the struct, and also the
NESTED_API_KVM_HV definition.

Thanks,
Nick

>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr.c      | 7 ++++++-
>  hw/ppc/spapr_caps.c | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e44686b04d..0aa9f21516 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1334,8 +1334,11 @@ static bool spapr_get_pate(PPCVirtualHypervisor *v=
hyp, PowerPCCPU *cpu,
>          /* Copy PATE1:GR into PATE0:HR */
>          entry->dw0 =3D spapr->patb_entry & PATE0_HR;
>          entry->dw1 =3D spapr->patb_entry;
> +        return true;
> +    }
> +    assert(spapr->nested.api);
> =20
> -    } else {
> +    if (spapr->nested.api =3D=3D NESTED_API_KVM_HV) {
>          uint64_t patb, pats;
> =20
>          assert(lpid !=3D 0);
> @@ -3437,6 +3440,8 @@ static void spapr_instance_init(Object *obj)
>          spapr_get_host_serial, spapr_set_host_serial);
>      object_property_set_description(obj, "host-serial",
>          "Host serial number to advertise in guest device tree");
> +    /* Nested */
> +    spapr->nested.api =3D 0;
>  }
> =20
>  static void spapr_machine_finalizefn(Object *obj)
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 5a0755d34f..a3a790b026 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -454,6 +454,7 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState=
 *spapr,
>          return;
>      }
> =20
> +    spapr->nested.api =3D NESTED_API_KVM_HV;
>      if (kvm_enabled()) {
>          if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
>                                spapr->max_compat_pvr)) {


