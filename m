Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C389735D52
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 20:09:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBJIy-0001tZ-M0; Mon, 19 Jun 2023 14:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBJIx-0001tQ-AN
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 14:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBJIv-0007Yc-Gh
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 14:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687198119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aQe4oRDZn/t3aQ0idQXzBJWZIBqM5Gm4BDURwo9NwX0=;
 b=iHb4OQ0kiqmpCYa0pAbDfYhOEpsY+oeEUN3fvm/cYyDDM6BNxn7nGGxB35Yp+KCwgHa7b+
 DbDZMwDJpruL8R95tPSgg6SNCr6SABExxO2mVUwoa+nooN/9K7n/WwFGo/gI6sAvfrhzCN
 nR8R/WeFkBwdTJLxGULizM0prqEQSpA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-Uz4EN3YbNQSCEEsE6cCTZw-1; Mon, 19 Jun 2023 14:08:38 -0400
X-MC-Unique: Uz4EN3YbNQSCEEsE6cCTZw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f7e4dc0fe5so20276055e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 11:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687198117; x=1689790117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQe4oRDZn/t3aQ0idQXzBJWZIBqM5Gm4BDURwo9NwX0=;
 b=Lm+pKel4BLmKhc3KhNOaN8r4Bd2XySG96ISb6V15PNo40YdUez+Jm2kDSFwHTTGRoH
 gtRu/vSq1Mmoqo07LdP/23IRMZ5528sVch0FY1Ivjj0nrJaGRdBg177Hl3LjFr4HZYDK
 uw04g9rTUBeqLsPRekFZOl2HH3+VARhL8DmmQhv2zv8GFdrUeW5zBeAkVLq18QeHbHvI
 fqY11iyuuYMz8ja9z4O1/9+BpqI63ZJ6FuOPaqXNYtYkgQFQ+eglkbVDoYE4V/ZE70aU
 Q9XOghCKucqj2tQUQFOlfHByN52ErwYJFIod/pe83gPYAoMcC9le72hmOfK2iX0QkrNl
 3PYg==
X-Gm-Message-State: AC+VfDyr5Ho8Ui4yy+kR6Xn1mfP7j1gWq4pnguHKUdpFCCKkeRDLa5dE
 FAighbKnqFDsi/XIcO6jM3HFpl16CeuYtg/wdUI20B4foG3OTVrJVcWYzFElNJJJB3GXmIuEAhG
 OXsnhW8WQYcXJDi8=
X-Received: by 2002:a05:600c:214d:b0:3f9:b6d5:5bd6 with SMTP id
 v13-20020a05600c214d00b003f9b6d55bd6mr152642wml.13.1687198117321; 
 Mon, 19 Jun 2023 11:08:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rWmM05FXhaRAii+yZbXbRzx6jYP0lC3AmTdFmddQu7wlkl2HcbVTwZvA0dOu/RiiK9u2wjg==
X-Received: by 2002:a05:600c:214d:b0:3f9:b6d5:5bd6 with SMTP id
 v13-20020a05600c214d00b003f9b6d55bd6mr152628wml.13.1687198117016; 
 Mon, 19 Jun 2023 11:08:37 -0700 (PDT)
Received: from redhat.com ([2.52.15.156]) by smtp.gmail.com with ESMTPSA id
 h9-20020a5d4fc9000000b0031134bcdacdsm152725wrw.42.2023.06.19.11.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 11:08:36 -0700 (PDT)
Date: Mon, 19 Jun 2023 14:08:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com,
 imammedo@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] hw/pci: prevent hotplug of devices on pcie-root-ports
 on the wrong slot
Message-ID: <20230619140151-mutt-send-email-mst@kernel.org>
References: <20230619155926.443668-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619155926.443668-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jun 19, 2023 at 09:29:26PM +0530, Ani Sinha wrote:
> When a device is plugged into a PCIE root port, it can only be plugged into slot
> 0. Hotplugging a device into a slot other than slot 0 is invalid and should be
> prevented. This change ensures that we throw an error if the user tries to plug
> a device into a pcie root port on any slot other than slot 0.
> 
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/pci/pci.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> changelog:
> v2: addressed issue with multifunction pcie root ports. Should allow
> hotplug on functions other than function 0.
> v3: improved commit message.

Weird. You say you improved it but it still only mentions
root port while code works for downstream ports too.
Improve it some more please I guess ;)


> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bf38905b7d..66999352cc 100644
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
> +         * function 0 is available.

available -> wasn't added yet

> +         */
>          error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
>                     " new func %s cannot be exposed to guest.",
>                     PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> @@ -1189,6 +1195,16 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     name);
>  
>         return NULL;
> +    } else if (dev->hotplugged &&
> +               !pci_is_vf(pci_dev) &&
> +               pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> +        /*
> +         * If the device is being plugged into an upstream PCIE port,

No, it's not plugged into an upstream port. It *has* an upstream port.


> +         * like a pcie root port, we only support one device at slot 0

this is wrong too, in that "device" here is a pci function, we
support only slot 0, but many functions.

> +         */
> +        error_setg(errp, "PCI: slot %d is not valid for %s",


Let's not just complain, explain why ;)

> +                   PCI_SLOT(devfn), name);
> +        return NULL;
>      }
>  
>      pci_dev->devfn = devfn;
> -- 
> 2.39.1


