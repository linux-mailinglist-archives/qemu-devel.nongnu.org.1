Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E1473A55E
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 17:50:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMYW-0000EQ-Nv; Thu, 22 Jun 2023 11:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1qCMYV-0000E7-6R
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1qCMYT-0002rD-LS
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687448942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wclAg+vy4266bIR7uN7BxS6xtNG6WGepnyY3DjNrtko=;
 b=Pnro+7MkXhk5+9xx2GQZ6lXhTEw78BvAnjirGKT4/GZMN23mHLvuOcen3fC4L7xvnfnhuZ
 L+8DJjkiFVH/3ZeCxFtCS2w8FTCS+LJFbrr0FbjwA14oUtYu2qyL4IjNZoFBQT5YelrDFh
 E8gsoHx0Yb/bBS8wipOpjn6OmLOCb1g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-6bVZQRe2MC2oNNKtg2h7Aw-1; Thu, 22 Jun 2023 11:47:02 -0400
X-MC-Unique: 6bVZQRe2MC2oNNKtg2h7Aw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f84a8b00e3so5496589e87.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 08:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687448820; x=1690040820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wclAg+vy4266bIR7uN7BxS6xtNG6WGepnyY3DjNrtko=;
 b=cL/KCl4oBprzqC3AwsQkGa1hpxjT7lkKG9PCDDiYnYNkamUCu7gvhwMjh4+WyJslbP
 +1NS+u8XbxiNgc9lPM8Gnda9dkkodaAnREAv4vRRrMBKJ+whtT1LfCfTR3C6wOiGzIFd
 hpk0iVTtT0+/iD5qpn0fPu2LyeepmoIok+lB/ELiNh5D+TAzjMEemlBCEjIO1gGxNMkG
 I+zKhjSGTNLwDIByGjOQqMO78Zts0FSHH9lh81v4UI3jGFTfdskiTEF2onmXEgsY9WjS
 p0a+4a4rzBiqU6J4bbDxotOfJYge4skYHR0iOyVz/W20f/+N7nTeeitp1Zvj+Pg0gZJ2
 RJsw==
X-Gm-Message-State: AC+VfDxvK9/nCWsu+JIQ5BCf4RCQQ+VmSH/0SC1JIsrFn4j38S+3lOtL
 odXHOMGxUHOnWTgS/UrwC96xUT0FaWATVIAdIEB86QqCgq/Kh1CuafbLxJo80CIprGT/fYlMVqo
 93x8q6LC/vSp7kVPLOkeaafPDLikeJoY=
X-Received: by 2002:a05:6512:b08:b0:4f7:6966:36fb with SMTP id
 w8-20020a0565120b0800b004f7696636fbmr12795749lfu.12.1687448819407; 
 Thu, 22 Jun 2023 08:46:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7yx7VPkLvdgZDmiWVvdf08Fkfaj5scqrjQhmPn4cr4b+oEOhKrpH+mVMDFoHBQfwknbUNvqT5iWaFzx8v6bbE=
X-Received: by 2002:a05:6512:b08:b0:4f7:6966:36fb with SMTP id
 w8-20020a0565120b0800b004f7696636fbmr12795614lfu.12.1687448812165; Thu, 22
 Jun 2023 08:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230622103255.267289-1-anisinha@redhat.com>
 <20230622103255.267289-6-anisinha@redhat.com>
In-Reply-To: <20230622103255.267289-6-anisinha@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Thu, 22 Jun 2023 17:46:40 +0200
Message-ID: <CAMDeoFWHJhN3ppAO4XB9jGUg4Yu-zFzzzKwAvDiSJSgjeZH6jg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 22, 2023 at 12:34=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
> PCI Express ports only have one slot, so PCI Express devices can only be
> plugged into slot 0 on a PCIE port. Enforce it.
>
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/pci/pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bf38905b7d..5f25ab9f5e 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -64,6 +64,7 @@ bool pci_available =3D true;
>  static char *pcibus_get_dev_path(DeviceState *dev);
>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
>  static void pcibus_reset(BusState *qbus);
> +static bool pcie_has_upstream_port(PCIDevice *dev);
>
>  static Property pci_props[] =3D {
>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> @@ -1189,6 +1190,11 @@ static PCIDevice *do_pci_register_device(PCIDevice=
 *pci_dev,
>                     name);
>
>         return NULL;
> +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> +                   " PCI express devices can only be plugged into slot 0=
.",

This is not technically correct, because downstream ports and root
ports are also PCIe devices, and they can have different slots under
upstream ports and RC. But this error will never be shown for them, so
it seems fine.

Reviewed-by: Julia Suvorova <jusual@redhat.com>




> +                   PCI_SLOT(devfn), name);
> +        return NULL;
>      }
>
>      pci_dev->devfn =3D devfn;
> --
> 2.39.1
>


