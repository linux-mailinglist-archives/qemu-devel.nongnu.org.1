Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 702E27F232B
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 02:35:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5FeG-0006lH-B1; Mon, 20 Nov 2023 20:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r5FeD-0006iF-Ga; Mon, 20 Nov 2023 20:33:53 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r5FeB-0004bC-RA; Mon, 20 Nov 2023 20:33:53 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6cb74a527ceso1398123b3a.2; 
 Mon, 20 Nov 2023 17:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700530430; x=1701135230; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wUDGe10c0aU14nTgD3n9Gyt2ZABfd6AJzBeTscJ34I=;
 b=I+svLXU0EEpexBnfzgfTEdhV9ntyPE4Zn0DcPjD4DjdG3GcPbZyb3vy1aUxesmg6+N
 0oPtC9lgBZ2uv9Q5iAZlOZMIJIPBjmiY8La2H+AnfUqngwHvnhAkIbA4NrUQ/v0S9dnp
 tXsFlIXUej8MECIUwYoA9+hO+YxP6ChAkA3Pf8tsHcMrcK4OdJ9KWRefkvxALdhqmq5a
 oDYsnplvoYdMv6TBPf/HWN40h7pzSFNOvY7cCVxS+7SEXMU1tSWkx1pyJF7xQsw2dKXg
 pUMRJUkruUVF8OdrWZFvF2EL7+ZTMfkqrgSeFaOC1mSqMofJF5YqAfbYMWmAhC130nSx
 /WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530430; x=1701135230;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6wUDGe10c0aU14nTgD3n9Gyt2ZABfd6AJzBeTscJ34I=;
 b=N0kUC05JYoxTu2p6XthEnxAw9CYsuUty0x7ELlwNNMRggP2X4gaJBxkV7dJlHeTB+j
 MdNU2phMdeFwx+OATuo1RN1aYQN55l+M/pm6cMrZCOI61h73XbinVNb1Ecf2ZHP3E+tw
 91P+vLztHKI6K6cEe+q+E9+1c93ErS0okxcH7nodPC+PuGYsFsLt2rsWClZpuHKw3wof
 D5SOHyLGjOqeN73jFWrGAA/SoYe+1hJk/Q4eTFtJuQBAC+yKJpuIxwGx+54vI4Kp3bKi
 JlZKuEctrw4HVJ6J2CkeDwODi1+mxKu33i++eaELl49207d3ENadUVmQbWxRG3Ejncb0
 jKCg==
X-Gm-Message-State: AOJu0YzDDjocuZaBL/Z+rTqY4S0S2E3LIjdFt5ZblrsSJPPcNldJKKGV
 z3Uneb/rEsuJbL6DFckJOWU=
X-Google-Smtp-Source: AGHT+IHQeMqEaohUXVXU5XNnyvgRKMUFDkrx4h/1Sm+x29KIHRmHP6R93dk2lq9Iz+1IFl8hv3YfOA==
X-Received: by 2002:a05:6a00:1a8a:b0:6be:62e:d5a8 with SMTP id
 e10-20020a056a001a8a00b006be062ed5a8mr8184430pfv.0.1700530429840; 
 Mon, 20 Nov 2023 17:33:49 -0800 (PST)
Received: from localhost (203-219-179-16.tpgi.com.au. [203.219.179.16])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b006b58af8aae3sm6692228pfd.77.2023.11.20.17.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 17:33:49 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Nov 2023 11:33:44 +1000
Message-Id: <CX43Q4CXT43G.16NTWUAWGGXCB@wheely>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v4 03/11] ppc/pnv: New powernv10-rainier machine type
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Glenn Miles" <milesg@linux.vnet.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
 <20231120235112.1951342-4-milesg@linux.vnet.ibm.com>
In-Reply-To: <20231120235112.1951342-4-milesg@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

On Tue Nov 21, 2023 at 9:51 AM AEST, Glenn Miles wrote:
> Create a new powernv machine type, powernv10-rainier, that
> will contain rainier-specific devices.

Is the plan to have a base powernv10 common to all and then
powernv10-rainier looks like a Rainier? Or would powernv10
just be a rainier?

It's fine to structure code this way, I'm just wondering about
the machine types available to user. Is a base powernv10 machine
useful to run?

Thanks,
Nick

>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>  hw/ppc/pnv.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 9c29727337..3481a1220e 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2249,7 +2249,7 @@ static void pnv_machine_power9_class_init(ObjectCla=
ss *oc, void *data)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>  }
> =20
> -static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
> +static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *dat=
a)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      PnvMachineClass *pmc =3D PNV_MACHINE_CLASS(oc);
> @@ -2261,7 +2261,6 @@ static void pnv_machine_power10_class_init(ObjectCl=
ass *oc, void *data)
>          { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
>      };
> =20
> -    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER10";
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power10_v2.0");
>      compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_comp=
at));
> =20
> @@ -2274,6 +2273,23 @@ static void pnv_machine_power10_class_init(ObjectC=
lass *oc, void *data)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>  }
> =20
> +static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    pnv_machine_p10_common_class_init(oc, data);
> +    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER10";
> +
> +}
> +
> +static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *da=
ta)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    pnv_machine_p10_common_class_init(oc, data);
> +    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER10 rainier";
> +}
> +
>  static bool pnv_machine_get_hb(Object *obj, Error **errp)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(obj);
> @@ -2379,6 +2395,15 @@ static void pnv_machine_class_init(ObjectClass *oc=
, void *data)
>      }
> =20
>  static const TypeInfo types[] =3D {
> +    {
> +        .name          =3D MACHINE_TYPE_NAME("powernv10-rainier"),
> +        .parent        =3D TYPE_PNV_MACHINE,
> +        .class_init    =3D pnv_machine_p10_rainier_class_init,
> +        .interfaces =3D (InterfaceInfo[]) {
> +            { TYPE_XIVE_FABRIC },
> +            { },
> +        },
> +    },
>      {
>          .name          =3D MACHINE_TYPE_NAME("powernv10"),
>          .parent        =3D TYPE_PNV_MACHINE,


