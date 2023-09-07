Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68537796EFB
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 04:32:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe4oC-0002BP-H0; Wed, 06 Sep 2023 22:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe4nx-000272-3H; Wed, 06 Sep 2023 22:31:37 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe4nu-0007vh-Fr; Wed, 06 Sep 2023 22:31:36 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68a3f1d8be2so422241b3a.3; 
 Wed, 06 Sep 2023 19:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694053892; x=1694658692; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJqqxDp71JXn9Gr13rxuBDk89HCGUhkQh8ZHUNTYrkU=;
 b=lbJ0DenT/6wYlVyFmA0tpOL31qWXLh3dXtlHUGRKrKzc/9sICu2DT8Ni16K931KzWn
 KhO1cVQMhlxybX4XF1emeNdJEkFb8fn2jCGnLGrj1jPbS4/HooFaa/XNK3WxBfpFPCAK
 PhiVEtICktQVCoPqF4m43omklpVaO1Vw2wiyjTseKsguumpSHEMrmEivhaBg6CwLmsDc
 Y8FigL+aSQx1xtE96GnRV03XoQekIPCHBB+1JLAV/kkJzScbSvbhc/daoCZMzXInWz2A
 ZcdzqKMEaiPC+Gy0pJhUK39jSFrcgTId5jweOK0368kyPNy6n7he4DoOnyWX5XuEVRn/
 E8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694053892; x=1694658692;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rJqqxDp71JXn9Gr13rxuBDk89HCGUhkQh8ZHUNTYrkU=;
 b=ghpHcvqzuy8qSP8mrr6YSVVliISK9tqe48sjyxhEgLancOb4k2XNS8L3dy874OHvsa
 xMcukHBtYNDuYTDyGIOgntdKrF4umPwqMvEv0fVcb5dVvKv7X7nTCmQutaVQJPtYwzxl
 3SaRQxIJaBoFi6fKp3B9GfQuA1HcQjXZ/FTvzW7dXNdcV/8tfwpLSSTSTuSAWY6ou9M1
 aAyQ93EHetr4dpt9/6goPm//s6t22n59xtMlFHzSUIkp0wY+bYKdwvm/8MyG+9INo0Z+
 2Ilx59emLxgDnZJUmMjucbtRiM4yGCUtLtaFqJMFn1JIImbh++YH4uExB+dTP7Bl6E1o
 2NRA==
X-Gm-Message-State: AOJu0Yy4X2LJi05nv+gXPZLpCiymPqiPT/xCs7q8O6nGXyAdSlCQj8Xk
 RVtzfBAnBUXbfH30wpmcCXll07DMC+g=
X-Google-Smtp-Source: AGHT+IEyp1Yk9wTYmB850c1AnH9mTZ3PC4lfBRSXgOfX3J09quzGEtzLRvCE2SGF4zwANQcBu1YPdg==
X-Received: by 2002:a05:6a00:a07:b0:68a:3eef:166d with SMTP id
 p7-20020a056a000a0700b0068a3eef166dmr22119771pfh.28.1694053892539; 
 Wed, 06 Sep 2023 19:31:32 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 k27-20020a634b5b000000b00573db18bca2sm3843056pgl.33.2023.09.06.19.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 19:31:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 12:31:26 +1000
Message-Id: <CVCBZFYKWAJ6.23SX9FTBWFT2J@wheely>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 14/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_DELETE
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-15-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-15-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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
> This hcall is used by L1 to delete a guest entry in L0 or can also be
> used to delete all guests if needed (usually in shutdown scenarios).

I'd squash with at least the create hcall.

>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr_nested.c         | 32 ++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr_nested.h |  1 +
>  2 files changed, 33 insertions(+)
>
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 3605f27115..5afdad4990 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -1692,6 +1692,37 @@ static void exit_process_output_buffer(PowerPCCPU =
*cpu,
>      return;
>  }
> =20
> +static target_ulong h_guest_delete(PowerPCCPU *cpu,
> +                                   SpaprMachineState *spapr,
> +                                   target_ulong opcode,
> +                                   target_ulong *args)
> +{
> +    target_ulong flags =3D args[0];
> +    target_ulong lpid =3D args[1];
> +    struct SpaprMachineStateNestedGuest *guest;
> +
> +    if (!spapr_get_cap(spapr, SPAPR_CAP_NESTED_PAPR)) {
> +        return H_FUNCTION;
> +    }

If you only register these hcalls when you apply the cap, then you
don't need to test it, right?

Open question as to whether it's better to register hcalls when
enabling such caps, or do the tests for them here. I guess the
former makes sense.

> +
> +    /* handle flag deleteAllGuests, remaining bits reserved */

This comment is confusing. What is flag deleteAllGuests?

H_GUEST_DELETE_ALL_MASK? Is that a mask, or a flag?

> +    if (flags & ~H_GUEST_DELETE_ALL_MASK) {
> +        return H_UNSUPPORTED_FLAG;
> +    } else if (flags & H_GUEST_DELETE_ALL_MASK) {
> +        g_hash_table_destroy(spapr->nested.guests);
> +        return H_SUCCESS;
> +    }
> +
> +    guest =3D g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(=
lpid));
> +    if (!guest) {
> +        return H_P2;
> +    }
> +
> +    g_hash_table_remove(spapr->nested.guests, GINT_TO_POINTER(lpid));
> +
> +    return H_SUCCESS;
> +}
> +
>  void spapr_register_nested(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -1709,6 +1740,7 @@ void spapr_register_nested_phyp(void)
>      spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state=
);
>      spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state=
);
>      spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu)=
;
> +    spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
>  }
> =20
>  #else
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index ca5d28c06e..9eb43778ad 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -209,6 +209,7 @@
>  #define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000 /* BE in=
 GSB */
>  #define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
>  #define GUEST_STATE_REQUEST_SET              0x2
> +#define H_GUEST_DELETE_ALL_MASK              0x8000000000000000ULL
> =20
>  #define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
>      .id =3D (i),                                     \


