Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE057FCDB5
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 05:04:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Bnb-0006k1-Ic; Tue, 28 Nov 2023 23:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8BnY-0006ji-Jq; Tue, 28 Nov 2023 23:03:40 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8BnU-0003QP-6t; Tue, 28 Nov 2023 23:03:40 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cfd78f8a12so23161175ad.2; 
 Tue, 28 Nov 2023 20:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701230614; x=1701835414; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsyE4ZVtmuFYSoiNQHPXl5LPtvUAxRNDHM10YVRxAgI=;
 b=KHA42SJ+kFiwhDXMuNI9wBoB1fcpJsdcxww50r6sDSfwjDMTBS678CIuj3z/KDrywy
 eNMegyqLEpfhMPh7sj4i9JwNe+cTLrORToLQxU8Q7Z13Y7wpVOcHXpoycHNiJerNAKgr
 W9Blz1dgOWPdP8tjvuI4eQVIDFEauwFfE30mr5EbXDSmjqdjXcV76R3ZeFXOOEBjtIZy
 TYBvZNa80UYVWgnZfaWdTX43u70yq7ZmjrqgKQ5/LmnprN4idMFBSZk7sX/J8rV1V4PN
 oJpMEqc3b00IatFeM0kZSDMKDuX6rREn+wLnDjbdrb3RCxKwrA5XYZdxqrVq9qWAhq67
 UdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701230614; x=1701835414;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nsyE4ZVtmuFYSoiNQHPXl5LPtvUAxRNDHM10YVRxAgI=;
 b=aOT8bGPBz5nmtGGVu8cIP7Vl/vxmq9R5FOpXQyLi38zpSyuslHAvYXrZQTZ3n30KnL
 QGXvDCOTzCkhqVWIjLvTe4b4U5wi5ViAKqMbSCLD58NZwowhCCQTEFYRMkKEg/W5CEHk
 vDeVrjrJlHB2Zold1rQRBEiVlyv64nLZaIfecD0zLgOQRz5kAlEDIHDNwpKb5i5te5AO
 OwFR/O+UPMYUArb+1NDSlEhoUwaBCmS/FDv2mwX9kyIlLphgoarAUZcpev8VQwelQTAJ
 r9YyQNUDtsfPsAdzG3/fpMz2ngAwKE4fIdRMf6OXBOL5KaaWH0T54BJC5MM39eqoJm0j
 oiSQ==
X-Gm-Message-State: AOJu0Yy6jaxB+eBZPSnhGpHm4hTMrtwQa2q71rKG5VXVHiwkRgK39Tca
 cxN9T0S2CDbhr0WWRmD+eJo=
X-Google-Smtp-Source: AGHT+IE18pU6Vi8mB+StR0U0sgNEM44bSlSPCrasYzsfRV9QnGBfldGVYlHe7AtBkghoP8KoXODDug==
X-Received: by 2002:a17:903:234c:b0:1cf:cb27:3aa5 with SMTP id
 c12-20020a170903234c00b001cfcb273aa5mr12350251plh.5.1701230613892; 
 Tue, 28 Nov 2023 20:03:33 -0800 (PST)
Received: from localhost ([124.170.16.164]) by smtp.gmail.com with ESMTPSA id
 s10-20020a170902ea0a00b001cfc3f73927sm5808048plg.9.2023.11.28.20.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 20:03:33 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Nov 2023 14:03:27 +1000
Message-Id: <CXAZX3XHE6O8.1CFCJWZKXV9EB@wheely>
Cc: <clegoate@redhat.com>, <qemu-devel@nongnu.org>, <mikey@neuling.org>,
 <vaibhav@linux.ibm.com>, <jniethe5@gmail.com>, <sbhat@linux.ibm.com>,
 <kconsul@linux.vnet.ibm.com>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 05/14] spapr: nested: register nested-hv api hcalls
 only for cap-nested-hv
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
 <20231012104951.194876-6-harshpb@linux.ibm.com>
In-Reply-To: <20231012104951.194876-6-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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
> Since cap-nested-hv and cap-nested-papr are mutually exclusive, now it
> makes sense to register api specfic hcalls only when respective
> capability is enabled, hence this change.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

I think this basically makes sense anyway since if you don't enable
cap-nested-hv, then no need to register the hcalls. This patch could
be pulled to the front of the series.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  hw/ppc/spapr_caps.c  | 1 +
>  hw/ppc/spapr_hcall.c | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 9b53f19ec8..ed3e638334 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -456,6 +456,7 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState=
 *spapr,
> =20
>      if (!spapr->nested.api) {
>          spapr->nested.api =3D NESTED_API_KVM_HV;
> +        spapr_register_nested();
>      } else {
>          error_setg(errp, "Nested-HV APIs are mutually exclusive/incompat=
ible");
>          error_append_hint(errp, "Please use either cap-nested-hv or "
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 522a2396c7..8ae55087ec 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1635,8 +1635,6 @@ static void hypercall_register_types(void)
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> =20
>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
> -
> -    spapr_register_nested();
>  }
> =20
>  type_init(hypercall_register_types)


