Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57D74D403
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIoYK-0005BY-0D; Mon, 10 Jul 2023 06:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qIoYF-0005AW-0N
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qIoYA-0003xP-5r
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688986524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qY7sBKnOc+actgyu1jsHuRdGP13PtSdbqhIoRjPxXvM=;
 b=XSP5U7G3A64aX0mqQlgeK5kL5UsaxurFIuE6LvYNKUdd66nbcwxmaWW6rpdNbq7ZGLOiwL
 DL9BXvA22nAXB50qPOqgtR8O+YX9ImD7AhD6SzbReJEI0cooCqUa6yxPkU2qyIj46CNO/d
 sbMX5p3vllZH//iLpEFHk7bNXVbyzJg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-rv-lTBcANNuo6rIl6TOxUQ-1; Mon, 10 Jul 2023 06:55:23 -0400
X-MC-Unique: rv-lTBcANNuo6rIl6TOxUQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5667afccc45so2892812eaf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 03:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688986522; x=1691578522;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qY7sBKnOc+actgyu1jsHuRdGP13PtSdbqhIoRjPxXvM=;
 b=Z6Ue5s8dzfyhnQJjnS8zFUOgjP9jtpbri6pzafgcRFEDbp8mTK52vbkeThpMh8pmzb
 GBp8yrDZVRAlQMjws6YRggvpXDKjN4Er4rmoVBIStV2k/oWT2EMGc4SnPnltGv9uWuCf
 OEl4RoCYZSttEsm39tf4REuf8YWyNEaxdIOpKjUs+wJSZsO6aqxikPIPMQJ9HGfVgUO/
 ZqHgOL3Pq+pXD2y6+dKysXgoiap47oFcwOMMaQ1Uqz3kXDTsoqjC9ZG+Ryz4LcR5NAlj
 /ED8Ji/VWU5rcjMSodSNNXof3p7xmoK5hZydlJBDKChpfPQuRqndNUY1uJuqwcyK3TGx
 Ya+Q==
X-Gm-Message-State: ABy/qLaVaZabokqaemdH3S56I1GBCXB7f1LS/z6lYtVK30P90ICVmzWa
 peHVcdrzHZcch9F6D714c+/2gUUK16KG9Xf/eIomWQfQCNnI1tdXK43QcZmFKGAy7Kc9F8nrYMO
 3wmkXvWoPuLYIAb8=
X-Received: by 2002:a05:6358:4198:b0:132:7a2e:87bc with SMTP id
 w24-20020a056358419800b001327a2e87bcmr9048026rwc.5.1688986522550; 
 Mon, 10 Jul 2023 03:55:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE2WfSbKFdE0P1zsCH0Ex8JaLTppDPGBHeWhJ+bgO2Z8R++1RrH23qyNAtmAHr+fjWMYTAhCA==
X-Received: by 2002:a05:6358:4198:b0:132:7a2e:87bc with SMTP id
 w24-20020a056358419800b001327a2e87bcmr9048013rwc.5.1688986522248; 
 Mon, 10 Jul 2023 03:55:22 -0700 (PDT)
Received: from smtpclient.apple ([203.212.247.118])
 by smtp.gmail.com with ESMTPSA id
 24-20020aa79158000000b00668738796b6sm6924447pfi.52.2023.07.10.03.55.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jul 2023 03:55:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 1/2] pcie: Use common ARI next function number
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230710080830.19053-2-akihiko.odaki@daynix.com>
Date: Mon, 10 Jul 2023 16:25:16 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <80447EC1-90A8-43AF-ACAE-61633575D667@redhat.com>
References: <20230710080830.19053-1-akihiko.odaki@daynix.com>
 <20230710080830.19053-2-akihiko.odaki@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 10-Jul-2023, at 1:38 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> Currently the only implementers of ARI is SR-IOV devices, and they
> behave similar. Share the ARI next function number.
>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> docs/pcie_sriov.txt   | 4 ++--
> include/hw/pci/pcie.h | 2 +-
> hw/net/igb.c          | 2 +-
> hw/net/igbvf.c        | 2 +-
> hw/nvme/ctrl.c        | 2 +-
> hw/pci/pcie.c         | 4 +++-
> 6 files changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
> index 7eff7f2703..a47aad0bfa 100644
> --- a/docs/pcie_sriov.txt
> +++ b/docs/pcie_sriov.txt
> @@ -48,7 +48,7 @@ setting up a BAR for a VF.
>       ...
>       int ret =3D pcie_endpoint_cap_init(d, 0x70);
>       ...
> -      pcie_ari_init(d, 0x100, 1);
> +      pcie_ari_init(d, 0x100);
>       ...
>=20
>       /* Add and initialize the SR/IOV capability */
> @@ -78,7 +78,7 @@ setting up a BAR for a VF.
>       ...
>       int ret =3D pcie_endpoint_cap_init(d, 0x60);
>       ...
> -      pcie_ari_init(d, 0x100, 1);
> +      pcie_ari_init(d, 0x100);
>       ...
>       memory_region_init(mr, ... )
>       pcie_sriov_vf_register_bar(d, bar_nr, mr);
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 3cc2b15957..bf7dc5d685 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -134,7 +134,7 @@ void pcie_sync_bridge_lnk(PCIDevice *dev);
> void pcie_acs_init(PCIDevice *dev, uint16_t offset);
> void pcie_acs_reset(PCIDevice *dev);
>=20
> -void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
> +void pcie_ari_init(PCIDevice *dev, uint16_t offset);
> void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t =
ser_num);
> void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
>=20
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index 1c989d7677..8ff832acfc 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -431,7 +431,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, =
Error **errp)
>         hw_error("Failed to initialize AER capability");
>     }
>=20
> -    pcie_ari_init(pci_dev, 0x150, 1);
> +    pcie_ari_init(pci_dev, 0x150);
>=20
>     pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
>         IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, =
IGB_MAX_VF_FUNCTIONS,
> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
> index 284ea61184..d55e1e8a6a 100644
> --- a/hw/net/igbvf.c
> +++ b/hw/net/igbvf.c
> @@ -270,7 +270,7 @@ static void igbvf_pci_realize(PCIDevice *dev, =
Error **errp)
>         hw_error("Failed to initialize AER capability");
>     }
>=20
> -    pcie_ari_init(dev, 0x150, 1);
> +    pcie_ari_init(dev, 0x150);
> }
>=20
> static void igbvf_pci_uninit(PCIDevice *dev)
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index fd917fcda1..8b7168a266 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8088,7 +8088,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice =
*pci_dev, Error **errp)
>     pcie_endpoint_cap_init(pci_dev, 0x80);
>     pcie_cap_flr_init(pci_dev);
>     if (n->params.sriov_max_vfs) {
> -        pcie_ari_init(pci_dev, 0x100, 1);
> +        pcie_ari_init(pci_dev, 0x100);
>     }
>=20
>     /* add one to max_ioqpairs to account for the admin queue pair */
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index b8c24cf45f..9a3f6430e8 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1028,8 +1028,10 @@ void pcie_sync_bridge_lnk(PCIDevice =
*bridge_dev)
>  */
>=20
> /* ARI */
> -void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn)
> +void pcie_ari_init(PCIDevice *dev, uint16_t offset)
> {
> +    uint16_t nextfn =3D 1;
> +
>     pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
>                         offset, PCI_ARI_SIZEOF);
>     pci_set_long(dev->config + offset + PCI_ARI_CAP, (nextfn & 0xff) =
<< 8);
> --=20
> 2.41.0
>=20


