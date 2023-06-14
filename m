Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6DF7301AE
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 16:23:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9ROD-0005sX-3T; Wed, 14 Jun 2023 10:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q9ROB-0005sK-50
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 10:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q9RO9-0007ES-9K
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 10:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686752539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=01CIeBzKp9y8I9726vxtFEtqRH53zZUmzCC6k7gfhtE=;
 b=TOcLdjIW2H2jrDEEUNMAHtclK1aP6LIJHJxnG5NAPjAc0dOvqqIW4JbTBWGEaXhIJInCWp
 ITQ4VD8mCRvqe+9GFib17pQ5q9skBRn+wfxx9FMa2z1P5xgegJgFbBpbPj3dDjYKrWKLUK
 JGHDPX8LYtQF8sVqzQumBt9+62DiqR8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-Nj2JyXHtOLazkX67nQG5fw-1; Wed, 14 Jun 2023 10:22:18 -0400
X-MC-Unique: Nj2JyXHtOLazkX67nQG5fw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-bb2202e0108so768479276.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 07:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686752537; x=1689344537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01CIeBzKp9y8I9726vxtFEtqRH53zZUmzCC6k7gfhtE=;
 b=PCVw1K3ux7FI2Aq0X5R39OBv0bvIOfyA8+6HPZTK5VD13Vv2H/TW2f50KAGmMM8Yoy
 q7Y8QL3emPzOswvM1HCrpJgicG3Nyrp+380HkK6C3pf9GQNxljKWwObhL8DFbMox97Zw
 yVaL5EfsR6nMyOQL3ZgDaiRgQh6BJcABLHZx5pwjZTf2nP5rpRKT9zTK4nFan5/2fU14
 GA7G95qTrfgxB2r7i3JC50VrdMJM2ndf2aO+PRhAPQho2v3BJ5oTk17Dzn7gi3lONfk9
 pN5A5JKESPqoI7/cOtw+Ij4vKBIGB4HT5stfIidbs8MCQFJVmIdMfFvY19uZIUSr/c3Q
 Ujiw==
X-Gm-Message-State: AC+VfDxhIUl2blY1J0XkMCrx4vEXpwwz6k3+z5WCAytqosFuU03fDKWY
 6Vqo6hH56KCnDQneEQbETXJD+h/XLCxyAcrSIi8y9bg3j8jXScLA6C2zgSef0IPqHfAx+Quo/Lo
 KsiEt3LOR4ZTLR6g=
X-Received: by 2002:a25:d0d2:0:b0:bc6:c22f:581a with SMTP id
 h201-20020a25d0d2000000b00bc6c22f581amr2114466ybg.38.1686752537316; 
 Wed, 14 Jun 2023 07:22:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nZVEcJegjNMx++1Ourh9uxN3YnNINjJmhOPlARdoKvjwKPMZ59iPZ3F6nbm/QPxu6kdR/fQ==
X-Received: by 2002:a25:d0d2:0:b0:bc6:c22f:581a with SMTP id
 h201-20020a25d0d2000000b00bc6c22f581amr2114447ybg.38.1686752537042; 
 Wed, 14 Jun 2023 07:22:17 -0700 (PDT)
Received: from redhat.com ([172.58.139.140]) by smtp.gmail.com with ESMTPSA id
 y14-20020a25ad0e000000b00bc6a712c523sm2198378ybi.64.2023.06.14.07.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 07:22:16 -0700 (PDT)
Date: Wed, 14 Jun 2023 10:22:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com,
 imammedo@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/pci: prevent hotplug of devices on pcie-root-ports
 with wrong devfn address
Message-ID: <20230614102137-mutt-send-email-mst@kernel.org>
References: <20230614123150.7077-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614123150.7077-1-anisinha@redhat.com>
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

On Wed, Jun 14, 2023 at 06:01:50PM +0530, Ani Sinha wrote:
> PCIE root ports only allow one device on slot 0/function 0.


Why do you say this? PCI devices can be multifunction.

> When hotplugging a
> device on a pcie root port, make sure that the device address passed is
> always 0x00 that represents slot 0 and function 0. Any other slot value and
> function value would be illegal on a root port.
> 
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/pci/pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Note:
> I tested this with both native and acpi hotplug enabled on pcie. The
> check seems to work on both.
> 
> (qemu)  netdev_add socket,id=hostnet1,listen=:1234
> (qemu) device_add e1000e,netdev=hostnet1,mac=00:11:22:33:44:03,id=net1,bus=pci.6,addr=0x2.0x5
> Error: PCI: slot 2 function 5 is not valid for e1000e
> (qemu) device_add e1000e,netdev=hostnet1,mac=00:11:22:33:44:03,id=net1,bus=pci.6,addr=0x0.0
> (qemu) info network
> net1: index=0,type=nic,model=e1000e,macaddr=00:11:22:33:44:03
>  \ hostnet1: index=0,type=socket,
> (qemu) device_del net1
> (qemu) info network
> hostnet1: index=0,type=socket,
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bf38905b7d..bc39322dfd 100644
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
> @@ -1189,6 +1190,14 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     name);
>  
>         return NULL;
> +    } else if (dev->hotplugged &&
> +               !pci_is_vf(pci_dev) &&
> +               pcie_has_upstream_port(pci_dev) && devfn) {
> +        /* For an upstream PCIE port, we only support one device at slot 0 */
> +        error_setg(errp, "PCI: slot %d function %d is not valid for %s",
> +                   PCI_SLOT(devfn), PCI_FUNC(devfn), name);
> +        return NULL;
> +
>      }
>  
>      pci_dev->devfn = devfn;
> -- 
> 2.39.1


