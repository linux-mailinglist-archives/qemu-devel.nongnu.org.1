Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D076573167F
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 13:28:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9l88-000432-JC; Thu, 15 Jun 2023 07:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q9l86-00042J-Em
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 07:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q9l84-0003B5-7o
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 07:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686828423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Opmwl//46cLVT8PN/erLdIJUFxqmb0ZRfFQgoDtpbbo=;
 b=A7EC9Jj+CMCPWa84K41+Lt63ZLpGjuF5amzFY+EpAuQyOxy2h+Dccj63cmVVXyYCGzaVvZ
 IcBkhj0Fgim5xUwhj/qq1kH/gL34DutunRDp7T113cbMjAVnBUlNRBWh5zZNvCNP1zLNeg
 aJu/bhXOJ3+kW6SHyqDi39iV4Ydk9D4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-eNuJ8UnXOL2E_DtOvx2cag-1; Thu, 15 Jun 2023 07:27:01 -0400
X-MC-Unique: eNuJ8UnXOL2E_DtOvx2cag-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30fbb0ac191so316674f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 04:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686828420; x=1689420420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Opmwl//46cLVT8PN/erLdIJUFxqmb0ZRfFQgoDtpbbo=;
 b=RDkvc9AYMkHgCZeTax3oyX4yaYP3j/8eElJ8GaHebHhLpvAz7wAfwqpHjnINbf19H+
 LxP9I6wrT9vVlQ2pMxCHIAHlmetOfNZvoGSmruJs/TRip6cHaHDN7JjTzL4Yl9X6CtCA
 vo2ULvKg7km8k86O5M6FBSGREtKslhf4duF05/C0l6ukU1QnZtvamTgNJ0OmvD9OZBV2
 3ibMCcrbG2KDwzwg+h7B35m3auJ8FiNarg63+0ofeM0p6Na6qwhIQv3ap4yd2+e4YMCg
 0x+8GVilmegrbtfZ90HPDTekj//YVr59mno2mA7pFffdXbS8ziarpaUiKk2oPBMYy1oN
 xvkg==
X-Gm-Message-State: AC+VfDx4aBLr7ekBnlv+sBi9+zcSjh0h9lJnC/AohCxaSHfagLivTiOe
 QWafjHzWLE3C6gRGsxEw0MlKiw6m4HugDbD4JnKuZ2oKatKIINyUf4/t96mc1sDLwUvsxXcmoq7
 NVX5zeHfNNrWoJCM=
X-Received: by 2002:a5d:6948:0:b0:30f:cb07:9d7f with SMTP id
 r8-20020a5d6948000000b0030fcb079d7fmr3869539wrw.23.1686828420529; 
 Thu, 15 Jun 2023 04:27:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OzXhp0+rOn63hbRj0aPc7SG0ez1x9Mv5qk/Am0Wl2Isx1KbFek0ALdndTIxWDhtGysIeznQ==
X-Received: by 2002:a5d:6948:0:b0:30f:cb07:9d7f with SMTP id
 r8-20020a5d6948000000b0030fcb079d7fmr3869521wrw.23.1686828420176; 
 Thu, 15 Jun 2023 04:27:00 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 a11-20020a05600c224b00b003f8126bcf34sm15870471wmm.48.2023.06.15.04.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jun 2023 04:26:59 -0700 (PDT)
Date: Thu, 15 Jun 2023 13:26:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, jusual@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/pci: prevent hotplug of devices on
 pcie-root-ports on the wrong slot
Message-ID: <20230615132659.6bcfcf0c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230615051645.4798-1-anisinha@redhat.com>
References: <20230615051645.4798-1-anisinha@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Thu, 15 Jun 2023 10:46:45 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> PCIE root ports and other upstream ports only allow one device on slot 0.
> When hotplugging a device on a pcie root port, make sure that the device
> address passed always represents slot 0. Any other slot value would be
> illegal on a root port.
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
> v2: feedback from mst included.
> 
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

you probably mixing up downstream port with upstream one,
the only thing that could be plugged into upstream port
is PCIE switch.

Also I'm not sure that we should do this at all.
Looking at BZ it seems that QEMU crashes inside backend
and tear down/cleanup sequence is broken somewhere.
And that is the root cause, so I'd rather fix that 1st
and only after that consider adding workarounds if any
were necessary.


> +         * like a pcie root port, we only support one device at slot 0
> +         */
> +        error_setg(errp, "PCI: slot %d is not valid for %s",
> +                   PCI_SLOT(devfn), name);
> +        return NULL;
>      }
>  
>      pci_dev->devfn = devfn;


