Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F65B7FAFE4
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 03:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7nXe-0006C0-Gk; Mon, 27 Nov 2023 21:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7nXY-0006BI-R4; Mon, 27 Nov 2023 21:09:36 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7nXW-00019G-Tw; Mon, 27 Nov 2023 21:09:32 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5be30d543c4so3521372a12.2; 
 Mon, 27 Nov 2023 18:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701137369; x=1701742169; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BfseZB9/C3OdWUDC/RmFJnY+Q6tEfyCoMEbwH4vC74=;
 b=B/XakCIWsdLR3IBaUcFUXeQV/Iu4zBj8rUGmnGPWaB1r/umIKDSRc0KYDnSWTA3yq+
 w5tzAEqnyjLdHqj/7ShrsaMHoV+6ZeKTmJTR3FuCXc4pBBx1d5sEVuQDACPTjT+LkCYy
 Ef5K/oXc/r8jvztnGmd7tf1q85EbDS4K9irMoyhPq1TFpElCNTvQlTcgHV+tWu346dDi
 G4VZSdwhOClVhx2OOe+u9cPTlpLzT2uyqKez/AnanDh1IZcSBQQBFEH5H8sby4/7hGsv
 QkApmCw8Dw1cntXVy8NAL810fzkV4SULrXWSO3xMBy1e0E7vxPZzmHu88v0IXFgBph9G
 gqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701137369; x=1701742169;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3BfseZB9/C3OdWUDC/RmFJnY+Q6tEfyCoMEbwH4vC74=;
 b=cimweFh8Yfg0UANqSi5oHN6OrUbWltxLgcgUGmCpx0NTfPDXLjeIA3CqSI/ehiRtPn
 4wdQkwXZvYq6qaUjQn7h/Ph69DQkmqffde3bna9uJAvzg2DAKRRTdz5A8a/cdKNErr3Q
 Z2tGIy/645lSDqA35OoI6iPflJfR0amteDxoNQd7D6VePMrtqLN23Vyfins2hhOj3R3T
 lhzCs1xwRgNsK5QzXVkRxuEzyFCJtJxPD6OU5jOtMeZkqzQpfw8Bg/LB/maz1srt41TV
 PjrGxw4P/k0sTYgxCQEDqr+bdcsR7+HAgEpqYFvgmipShX0FKqcRM9AZq1uqyf0gTvx4
 z47Q==
X-Gm-Message-State: AOJu0YxwFqf/AYlGPEqyxElOyBWk+cc7bBm2MDNRqtXhtvtkXvhn8huz
 oiVn2Rk3p4pRVbaezelUzbU=
X-Google-Smtp-Source: AGHT+IHz4zc0KvGCVWYmQO48qrAmNyJb/LZj0dNSTCzBy1NOcKlawtBc5v4TuEeTlgmO7uP2FxwEaA==
X-Received: by 2002:a05:6a21:789a:b0:18c:3260:e20f with SMTP id
 bf26-20020a056a21789a00b0018c3260e20fmr10124927pzc.33.1701137368746; 
 Mon, 27 Nov 2023 18:09:28 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 ot5-20020a17090b3b4500b00285d330ae8bsm2247767pjb.57.2023.11.27.18.09.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 18:09:27 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Nov 2023 12:09:20 +1000
Message-Id: <CXA2V6ZORQTU.T6GDJHYBZD92@wheely>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@us.ibm.com>, <chalapathi.v@ibm.com>,
 <saif.abrar@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 3/3] hw/ppc: N1 chiplet wiring
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231127171307.5237-1-chalapathi.v@linux.ibm.com>
 <20231127171307.5237-4-chalapathi.v@linux.ibm.com>
In-Reply-To: <20231127171307.5237-4-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

On Tue Nov 28, 2023 at 3:13 AM AEST, Chalapathi V wrote:
> This part of the patchset connects the nest1 chiplet model to p10 chip.
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  include/hw/ppc/pnv_chip.h |  2 ++
>  hw/ppc/pnv.c              | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 0ab5c42308..9b06c8d87c 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -4,6 +4,7 @@
>  #include "hw/pci-host/pnv_phb4.h"
>  #include "hw/ppc/pnv_core.h"
>  #include "hw/ppc/pnv_homer.h"
> +#include "hw/ppc/pnv_n1_chiplet.h"
>  #include "hw/ppc/pnv_lpc.h"
>  #include "hw/ppc/pnv_occ.h"
>  #include "hw/ppc/pnv_psi.h"
> @@ -113,6 +114,7 @@ struct Pnv10Chip {
>      PnvOCC       occ;
>      PnvSBE       sbe;
>      PnvHomer     homer;
> +    PnvN1Chiplet     n1_chiplet;
> =20
>      uint32_t     nr_quads;
>      PnvQuad      *quads;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0297871bdd..6cf1f3319f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1680,6 +1680,8 @@ static void pnv_chip_power10_instance_init(Object *=
obj)
>      object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
>      object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
>      object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOM=
ER);
> +    object_initialize_child(obj, "n1_chiplet", &chip10->n1_chiplet,
> +                            TYPE_PNV_N1_CHIPLET);

Another very small nit, we seem to have convention of minus rather than
underscore for these names, so n1-chiplet fits better.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> =20
>      chip->num_pecs =3D pcc->num_pecs;
> =20
> @@ -1849,6 +1851,19 @@ static void pnv_chip_power10_realize(DeviceState *=
dev, Error **errp)
>      memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(ch=
ip),
>                                  &chip10->homer.regs);
> =20
> +    /* N1 chiplet */
> +    if (!qdev_realize(DEVICE(&chip10->n1_chiplet), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE,
> +             &chip10->n1_chiplet.nest_pervasive.xscom_ctrl_regs);
> +
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_EQ_BASE,
> +                           &chip10->n1_chiplet.xscom_pb_eq_regs);
> +
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_ES_BASE,
> +                           &chip10->n1_chiplet.xscom_pb_es_regs);
> +
>      /* PHBs */
>      pnv_chip_power10_phb_realize(chip, &local_err);
>      if (local_err) {


