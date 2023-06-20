Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A447366D5
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:00:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXDM-0007YD-1F; Tue, 20 Jun 2023 04:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qBXDK-0007Y4-AS
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qBXDI-00065f-DC
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687251587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JpMrstUmfvSiUK9S5irHux0LUlJSlvf950hEb664gA0=;
 b=XOcBYaG+9SapNhpCRLwsq4ycoT3ZjyZ55WnCAG7WVE46hCUitQxZPFhHav9llW4vfIYy9O
 B4DrhZDQ56UWvr2Qx/xsdXhB92MzJTCj/699OdOP0O0fEqOIZlQ4ydeW8WxXTU1m1wABZH
 8niy0t+4kxhUeRqA8oibdp+5FJQ0wxQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-tw7xeEW7PIaOektOx3u-Kw-1; Tue, 20 Jun 2023 04:59:45 -0400
X-MC-Unique: tw7xeEW7PIaOektOx3u-Kw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-513f337d478so2526637a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687251584; x=1689843584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JpMrstUmfvSiUK9S5irHux0LUlJSlvf950hEb664gA0=;
 b=LNg6GEl5YgLjg413Vvh4Lfqyotq5qMqv0OybOoq6W4fMcALF4QksP9+47t/kTEUnB5
 NjTCzbReArkyS9/z+d4wwvWYSKdbgFL3SWBjOBpck2CeCgmBsW2D2mS3es7mnG2f1uR/
 7w6ksoHlbHNUnEyRsLeI0lpcIiodHEpxf0PcyeqT243ocaMe40w9DkHzCSfXq9sas7tk
 8aORTvlkjPLAo1AwHzrVVpYyHqKlK2JxCroWiydHxpzkCp2bQccPDP3J3fd/vCcke3SI
 cgvNHbu881F8jafhsH/9TVHiklV80bbGnCM/a5hLg/HEb4uj7TkQq/oxPn8tR5zHq8nJ
 8ljA==
X-Gm-Message-State: AC+VfDxfTnaVId++Jlnj7mgjoO+0fx3+igrR01GfuZoLvNstHsjbwIQD
 2ziL5FIw53jHm1bbmS68UHFfeajrZXg3opx/R3dXo6Lkm8G3mtGIJJHe0aNOe8Xx2EPIbcztLa5
 4kEKosvaRGFbDjYo=
X-Received: by 2002:a05:6402:74b:b0:51b:ca95:bee0 with SMTP id
 p11-20020a056402074b00b0051bca95bee0mr817029edy.22.1687251584309; 
 Tue, 20 Jun 2023 01:59:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5BEN9jkRoIkDTrRdR6juZH5ilJAR85F6s24ijoISNApV2h/BxbLtAjEDhT5eoSvfMkQEUWCw==
X-Received: by 2002:a05:6402:74b:b0:51b:ca95:bee0 with SMTP id
 p11-20020a056402074b00b0051bca95bee0mr817016edy.22.1687251583974; 
 Tue, 20 Jun 2023 01:59:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 v24-20020a056402185800b0050488d1d376sm851185edy.0.2023.06.20.01.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:59:43 -0700 (PDT)
Date: Tue, 20 Jun 2023 10:59:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, jusual@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4] hw/pci: enforce use of slot only slot 0 when devices
 have an upstream PCIE port
Message-ID: <20230620105942.0e551fe8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230620071805.4400-1-anisinha@redhat.com>
References: <20230620071805.4400-1-anisinha@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Tue, 20 Jun 2023 12:48:05 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> When a device has an upstream PCIE port, we can only use slot 0. Non-zero slots
> are invalid. 
> This change ensures that we throw an error if the user
> tries to hotplug a device with an upstream PCIE port to a non-zero slot.

Isn't the same true for coldplugged devices?
Why you limit it only to hotplug?

> 
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/pci/pci.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> changelog:
> v2: addressed issue with multifunction pcie root ports. Should allow
> hotplug on functions other than function 0.
> v3: improved commit message.
> v4: improve commit message and code comments further. Some more
> improvements might come in v5. No claims made here that this is
> the final one :-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bf38905b7d..30ce6a78cb 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -64,6 +64,7 @@ bool pci_available = true;
>  static char *pcibus_get_dev_path(DeviceState *dev);
>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
>  static void pcibus_reset(BusState *qbus);
> +static bool pcie_has_upstream_port(PCIDevice *dev);
>  
>  static Property pci_props[] = {
>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> @@ -1182,6 +1183,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>      } else if (dev->hotplugged &&
>                 !pci_is_vf(pci_dev) &&
>                 pci_get_function_0(pci_dev)) {
> +        /*
> +         * populating function 0 triggers a bus scan from the guest that
> +         * exposes other non-zero functions. Hence we need to ensure that
> +         * function 0 wasn't added yet.
> +         */
>          error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
>                     " new func %s cannot be exposed to guest.",
>                     PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> @@ -1189,6 +1195,18 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     name);
>  
>         return NULL;
> +    } else if (dev->hotplugged &&
> +               !pci_is_vf(pci_dev) &&
> +               pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> +        /*
> +         * If the device has an upstream PCIE port, like a pcie root port,
> +         * we only support functions on slot 0.
> +         */
> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> +                   " only functions on slot 0 is supported for devices"
> +                   " with an upstream PCIE port.",

upstream port language is confusing here and elsewhere you mention it.
It would be better to use root-port instead.
 
> +                   PCI_SLOT(devfn), name);
> +        return NULL;
>      }
>  
>      pci_dev->devfn = devfn;


