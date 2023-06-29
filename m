Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5553742840
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 16:26:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEsa2-00030y-Al; Thu, 29 Jun 2023 10:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qEsZz-00030S-GZ
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 10:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qEsZx-0001jk-9J
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 10:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688048700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPQw3ZhGTRfLx8UdQ/swj/d/iYxKgKyHTG30ZcKQ9j0=;
 b=fjAw/OXJLk64CACEVNIoYKv1OSizDxDxXQtDJ0++sUzJsfDI+jQK6FFJGHKKa+R+Jr/a5B
 kyxLuVxqSUJXtX5BAjGg4EPLQLRW1PzHToeLZkEg5N5vfEBWiohvoumO0EusadSMx/Us03
 T4olQKyigkqGn90ke1SgvhdCqGZLlF4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-Pcxjhq08OyytsCdKtII03g-1; Thu, 29 Jun 2023 10:24:58 -0400
X-MC-Unique: Pcxjhq08OyytsCdKtII03g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fa871e1eaaso10739675e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 07:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688048697; x=1690640697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPQw3ZhGTRfLx8UdQ/swj/d/iYxKgKyHTG30ZcKQ9j0=;
 b=JLAsD2MoxHabB8NQc4WJGivUBGF5w08zdDhyHtkoFSGFaAcQlzMZwDhFQaFxg7wVrV
 /zBdsl0Mw9tlmkgDIEowf0QfqDrI2WzoiAE3+EiNSx/+szai6Aye5i7GLBoeCUQuDn/I
 BYWx2CYjtsY5oGz0eX1vx+tMBYkRKBr03yP1DMuKHiX/g523BRncP87f/89ZDwvuGdEU
 WxJm22pGTeWAM1/za7ZUOcl1nA6iNVl7AGEBXvnk8kVSFVQofj3hYVh5UoYQe6gY3dsf
 7CdcahwyGNiYr0PycC8uwXVjsu8SstwXIgrhhHBmQwfjQCsHThpmtQfhYyvaBbmkYToY
 YGuw==
X-Gm-Message-State: AC+VfDwUptfLx2MupXkjCX2qF5QIQvsg0eqZ7Clvem+9r3kDz+x9U8OE
 bE/8KQ6WpS8AdpJiT13M6AVU2Wt0oK6FjYU0gQ6MoKAEv/WmalDOoJ5/Ej68+U2+KuRS6YoC5cj
 svlaviFbCpCadoYQ=
X-Received: by 2002:a7b:ce19:0:b0:3fb:adc0:c37d with SMTP id
 m25-20020a7bce19000000b003fbadc0c37dmr6296465wmc.38.1688048697208; 
 Thu, 29 Jun 2023 07:24:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64vxg2YP096MdbkTTllwdvTR4NPLfi0O3es499FGICJvUj7sEKrC+ONTlARxk2uBWw/j4F/g==
X-Received: by 2002:a7b:ce19:0:b0:3fb:adc0:c37d with SMTP id
 m25-20020a7bce19000000b003fbadc0c37dmr6296444wmc.38.1688048696857; 
 Thu, 29 Jun 2023 07:24:56 -0700 (PDT)
Received: from redhat.com ([2.52.154.169]) by smtp.gmail.com with ESMTPSA id
 q20-20020a1cf314000000b003f90b9b2c31sm19793970wmq.28.2023.06.29.07.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 07:24:56 -0700 (PDT)
Date: Thu, 29 Jun 2023 10:24:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 jusual@redhat.com, imammedo@redhat.com, akihiko.odaki@daynix.com
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230629102421-mutt-send-email-mst@kernel.org>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629040707.115656-6-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Thu, Jun 29, 2023 at 09:37:07AM +0530, Ani Sinha wrote:
> PCI Express ports only have one slot, so PCI Express devices can only be
> plugged into slot 0 on a PCIE port. Enforce it.
> 
> The change has been tested to not break ARI by instantiating seven vfs on an
> emulated igb device (the maximum number of vfs the linux igb driver supports).

I guess we need to test with some other device then? 7 VFs is same
slot so hardly a good test.

> The vfs are seen to have non-zero device/slot numbers in the conventional
> PCI BDF representation.
> 
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> CC: akihiko.odaki@daynix.com
> 
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> ---
>  hw/pci/pci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e2eb4c3b4a..0320ac2bb3 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -65,6 +65,7 @@ bool pci_available = true;
>  static char *pcibus_get_dev_path(DeviceState *dev);
>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
>  static void pcibus_reset(BusState *qbus);
> +static bool pcie_has_upstream_port(PCIDevice *dev);
>  
>  static Property pci_props[] = {
>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> @@ -1190,6 +1191,20 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     name);
>  
>         return NULL;
> +    } /*
> +       * With SRIOV and ARI, vfs can have non-zero slot in the conventional
> +       * PCI interpretation as all five bits reserved for slot addresses are
> +       * also used for function bits for the various vfs. Ignore that case.
> +       * It is too early here to check for ARI capabilities in the PCI config
> +       * space. Hence, we check for a vf device instead.
> +       */
> +    else if (!pci_is_vf(pci_dev) &&
> +             pcie_has_upstream_port(pci_dev) &&
> +             PCI_SLOT(devfn)) {
> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> +                   " parent device only allows plugging into slot 0.",
> +                   PCI_SLOT(devfn), name);
> +        return NULL;
>      }
>  
>      pci_dev->devfn = devfn;
> -- 
> 2.39.1


