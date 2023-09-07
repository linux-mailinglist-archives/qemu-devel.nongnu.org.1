Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161B796EDC
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 04:28:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe4ky-0007R8-8D; Wed, 06 Sep 2023 22:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe4kw-0007Qr-LT; Wed, 06 Sep 2023 22:28:30 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe4ku-0006gz-Bd; Wed, 06 Sep 2023 22:28:30 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68becf931d0so429222b3a.3; 
 Wed, 06 Sep 2023 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694053706; x=1694658506; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fesEqZcjAc5q62JlNxeQ9xedlSl5GfjrWC9LrBchun8=;
 b=rwUiiWwworw9Rv3qTJSyx9EMM8kDxnkHjGzjDUG5+gOAHdD8p9ynj/gLwXjS54LM4o
 T6MWWZKfnVTU0mxqGPNBll/2TuG7cSz0r9SCt6JKz1c9q1H/Ib/nGzKLXlozvmgjKzQP
 oEHKzI8PemYJGHxoHAs1zsjLYAXMztlDLCjccPvtUQAs8559TKFHlFZvVg+OlijMLqWU
 9ta/QTdT0/baUYQ2UCXWVyOhThFQ+XD4cKG4UyVopsEDNGXFvlI3rl2PaaEnTzyOL1EP
 PBTS0Tfc4kSHUppkkj10MUPUdeNl4Y2t7U2Clypf2eR06XMZ49469x5YElVTlvnX9P6O
 181Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694053706; x=1694658506;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fesEqZcjAc5q62JlNxeQ9xedlSl5GfjrWC9LrBchun8=;
 b=C1srteaKQ13qjcCmeFZUEM4t6BLzZTvJsUtjyI0i5f1Wmhb5jew1Ys+48rdbenoxgX
 1I6pFHiBH9lALL7l1WqBSZbl/bdWUzgJ+A6bI3hmxQ+1jIgpPpb00NAB7vnMxD8sf0kU
 qSoFk+hvVYE0Cuz7Or0LqKLstDyv2XXXqSOyP/PYvJbku/rJHCS0ZTWYE0Isr9ACKpr8
 mNWvcgNBZD1vowdwgUWwt9z0I3UHD4J0VwtDMVg7cI+qWp180Qp4T+1fWj1iFZKXGlXy
 TUhMWGx58y4Pt5X8kzF/bWfFoqgdyaQXEHm+Vd4weU4VeH85ZncL00oByWJRMemxcR0P
 Dwug==
X-Gm-Message-State: AOJu0YxKm24AdoTSt1zD3FhM+QaXekYGoGvtricuVvpmlsVSiRs6rJmd
 /KoIHB+83tBHHAtDNwzdBuE=
X-Google-Smtp-Source: AGHT+IFkAeM1fkUeAwnIT6N50QjRcp9jjWo/tO/gD/C44GofnGS6xBCrfzGDSwXWWD4j+S/AhVVSwA==
X-Received: by 2002:a05:6a20:42a6:b0:137:2281:944f with SMTP id
 o38-20020a056a2042a600b001372281944fmr17836260pzj.40.1694053706349; 
 Wed, 06 Sep 2023 19:28:26 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 jb1-20020a170903258100b001bd41b70b65sm11723325plb.49.2023.09.06.19.28.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 19:28:26 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 12:28:20 +1000
Message-Id: <CVCBX2FBQ7B8.KXFOWS32C9IQ@wheely>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 08/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_CREATE
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-9-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-9-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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
> This hcall is used by L1 to indicate to L0 that a new nested guest needs
> to be created and therefore necessary resource allocation shall be made.
> The L0 uses a hash table for nested guest specific resource management.
> This data structure is further utilized by other hcalls to operate on
> related members during entire life cycle of the nested guest.

Similar comment for changelog re detail. Detailed specification of API
and implementation could go in comments or documentation if useful.

>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr_nested.c         | 75 +++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr_nested.h |  3 ++
>  2 files changed, 78 insertions(+)
>
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 9af65f257f..09bbbfb341 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -444,6 +444,80 @@ static target_ulong h_guest_set_capabilities(PowerPC=
CPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static void
> +destroy_guest_helper(gpointer value)
> +{
> +    struct SpaprMachineStateNestedGuest *guest =3D value;
> +    g_free(guest);
> +}
> +
> +static target_ulong h_guest_create(PowerPCCPU *cpu,
> +                                   SpaprMachineState *spapr,
> +                                   target_ulong opcode,
> +                                   target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong flags =3D args[0];
> +    target_ulong continue_token =3D args[1];
> +    uint64_t lpid;
> +    int nguests =3D 0;
> +    struct SpaprMachineStateNestedGuest *guest;
> +
> +    if (flags) { /* don't handle any flags for now */
> +        return H_UNSUPPORTED_FLAG;
> +    }
> +
> +    if (continue_token !=3D -1) {
> +        return H_P2;
> +    }
> +
> +    if (!spapr_get_cap(spapr, SPAPR_CAP_NESTED_PAPR)) {
> +        return H_FUNCTION;
> +    }
> +
> +    if (!spapr->nested.capabilities_set) {
> +        return H_STATE;
> +    }
> +
> +    if (!spapr->nested.guests) {
> +        spapr->nested.lpid_max =3D NESTED_GUEST_MAX;
> +        spapr->nested.guests =3D g_hash_table_new_full(NULL,
> +                                                     NULL,
> +                                                     NULL,
> +                                                     destroy_guest_helpe=
r);

Is lpid_max only used by create? Probably no need to have it in spapr
then->nested then. Also, do we even need to have a limit?

> +    }
> +
> +    nguests =3D g_hash_table_size(spapr->nested.guests);
> +
> +    if (nguests =3D=3D spapr->nested.lpid_max) {
> +        return H_NO_MEM;
> +    }
> +
> +    /* Lookup for available lpid */
> +    for (lpid =3D 1; lpid < spapr->nested.lpid_max; lpid++) {

PAPR API calls it "guest ID" I think. Should change all references to
lpid to that.

> +        if (!(g_hash_table_lookup(spapr->nested.guests,
> +                                  GINT_TO_POINTER(lpid)))) {
> +            break;
> +        }
> +    }
> +    if (lpid =3D=3D spapr->nested.lpid_max) {
> +        return H_NO_MEM;
> +    }
> +
> +    guest =3D g_try_new0(struct SpaprMachineStateNestedGuest, 1);
> +    if (!guest) {
> +        return H_NO_MEM;
> +    }
> +
> +    guest->pvr_logical =3D spapr->nested.pvr_base;
> +
> +    g_hash_table_insert(spapr->nested.guests, GINT_TO_POINTER(lpid), gue=
st);
> +    printf("%s: lpid: %lu (MAX: %i)\n", __func__, lpid, spapr->nested.lp=
id_max);

Remove printf.

> +
> +    env->gpr[4] =3D lpid;
> +    return H_SUCCESS;
> +}
> +
>  void spapr_register_nested(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -456,6 +530,7 @@ void spapr_register_nested_phyp(void)
>  {
>      spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capab=
ilities);
>      spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capab=
ilities);
> +    spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
>  }
> =20
>  #else
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index a7996251cb..7841027df8 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -197,6 +197,9 @@
>  #define H_GUEST_CAP_P9_MODE_BMAP    1
>  #define H_GUEST_CAP_P10_MODE_BMAP   2
> =20
> +/* Nested PAPR API macros */
> +#define NESTED_GUEST_MAX 4096

Prefix with PAPR_?

Thanks,
Nick

> +
>  typedef struct SpaprMachineStateNestedGuest {
>      unsigned long vcpus;
>      struct SpaprMachineStateNestedGuestVcpu *vcpu;


