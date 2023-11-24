Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 567137F72B1
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:29:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UMW-0000h4-73; Fri, 24 Nov 2023 06:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6UMG-0000ez-Oe; Fri, 24 Nov 2023 06:28:29 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6UMF-0005Xy-4X; Fri, 24 Nov 2023 06:28:28 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso1733438b3a.2; 
 Fri, 24 Nov 2023 03:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700825304; x=1701430104; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9n3iac1hlpYLu3Df3NKGKAEeSLve4l5QBiWLouYaCY=;
 b=DZ3j2FYAINwrB2BjjM5Q1fNcLJhwJaPcer2EsoylHtRnZfGkZikrSoJbfagkKWGpiN
 5Y7k3IWvQDhv+3g0sDUxG2rMOybhO6NiZ/y6xZr7sPgezfpS2hUlMsrbXxkkyTyshv/G
 jSp7OrmzRTPzY+opN2X2qQmBvpbjLQvCzcaWzo1/Yrdsxqd/2CDdjP1wHhXcJp+sLJ66
 zt5qqu24B2sG+dnXngledcYWbmpJEoHxYhI4zOg0hn4lnO8TXREihA/XHdihTyHgHJrm
 Ut315wK7itIE3wE0ngwjkYka6pBuJcXRM3PBQdZlQEoh9FReXQ1GbmxLe2q1Hrp47WvC
 9Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700825304; x=1701430104;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u9n3iac1hlpYLu3Df3NKGKAEeSLve4l5QBiWLouYaCY=;
 b=bDRIdLysu+hKnfqjBBJb+1JCZDnuB5LLvnH9nK07mCKU0mvFWtx7xJ0h5uGG/zJrzq
 iSByhKiWPKteH1ifMutMWectaGDyiEEbleupB72zPJOc4RkVcYE6WhvBkOF7jXDSF1LA
 SQYtEzfJIrJi0Oo0Jz2whUt2dfjQMi5U1yLdjp5dI0Y0jwpDrvrOYGZIdFLdMkpkd/io
 2T3dCGE9ZDY2pARsksAbVxdSzTAiFQkAVnD/fbHvs8hYLC2x5xjXd1zQYnoCwDzPZY0K
 ZRizxw6T7O7BeXSPC8koDMfczTnWV8JjpKzfibZo4w/pTm7JkW+GnPwP4QIJbualMWxn
 I4Zw==
X-Gm-Message-State: AOJu0YwYmAl2IKGC5U/4FFvA4p7DAZ8siX+i4AXYTbfgWojoPiE7hDtK
 vj+5aSBFrCIndwtWSnMt84Xglj+HwDs=
X-Google-Smtp-Source: AGHT+IEYr7WlSKp82aWgSCrJ3L+55nKQShftYVUhCKDcT8uVqgjO6XvsDPpYZmLMevvkhZui2AY2NQ==
X-Received: by 2002:a05:6a20:9595:b0:187:5be4:67e2 with SMTP id
 iu21-20020a056a20959500b001875be467e2mr3435161pzb.53.1700825304514; 
 Fri, 24 Nov 2023 03:28:24 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 c4-20020aa781c4000000b006cb955dc54csm2696183pfn.58.2023.11.24.03.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:28:24 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 21:28:17 +1000
Message-Id: <CX708Z3P2ZAA.3VDMJRTBIK14W@wheely>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@us.ibm.com>, <chalapathi.v@ibm.com>,
 <saif.abrar@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/3] hw/ppc: Nest1 chiplet wiring
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
 <20231124101534.19454-4-chalapathi.v@linux.ibm.com>
In-Reply-To: <20231124101534.19454-4-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

On Fri Nov 24, 2023 at 8:15 PM AEST, Chalapathi V wrote:
> This part of the patchset connects the nest1 chiplet model to p10 chip.

Seems fine to me. Should it just be squashed into patch 2?

Thanks,
Nick

>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  include/hw/ppc/pnv_chip.h |  2 ++
>  hw/ppc/pnv.c              | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 0ab5c42308..59a3158a6b 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -4,6 +4,7 @@
>  #include "hw/pci-host/pnv_phb4.h"
>  #include "hw/ppc/pnv_core.h"
>  #include "hw/ppc/pnv_homer.h"
> +#include "hw/ppc/pnv_nest_chiplet.h"
>  #include "hw/ppc/pnv_lpc.h"
>  #include "hw/ppc/pnv_occ.h"
>  #include "hw/ppc/pnv_psi.h"
> @@ -113,6 +114,7 @@ struct Pnv10Chip {
>      PnvOCC       occ;
>      PnvSBE       sbe;
>      PnvHomer     homer;
> +    PnvNest1     nest1;
> =20
>      uint32_t     nr_quads;
>      PnvQuad      *quads;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0297871bdd..ba3dfab557 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1680,6 +1680,7 @@ static void pnv_chip_power10_instance_init(Object *=
obj)
>      object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
>      object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
>      object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOM=
ER);
> +    object_initialize_child(obj, "nest1", &chip10->nest1, TYPE_PNV_NEST1=
);
> =20
>      chip->num_pecs =3D pcc->num_pecs;
> =20
> @@ -1849,6 +1850,19 @@ static void pnv_chip_power10_realize(DeviceState *=
dev, Error **errp)
>      memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(ch=
ip),
>                                  &chip10->homer.regs);
> =20
> +    /* nest1 chiplet */
> +    if (!qdev_realize(DEVICE(&chip10->nest1), NULL, errp)) {
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE,
> +             &chip10->nest1.perv.xscom_perv_ctrl_regs);
> +
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_PB_SCOM_EQ_BASE,
> +                           &chip10->nest1.xscom_pb_eq_regs);
> +
> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_PB_SCOM_ES_BASE,
> +                           &chip10->nest1.xscom_pb_es_regs);
> +
>      /* PHBs */
>      pnv_chip_power10_phb_realize(chip, &local_err);
>      if (local_err) {


