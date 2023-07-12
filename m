Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0233D75069E
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:47:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJYJM-0007KI-Jy; Wed, 12 Jul 2023 07:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJYJK-0007JX-Cl
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJYJI-0001O5-HP
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689162427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fDqpjDFyxOOSEizJoajCZDkxHavIWA533ohUQUXjDsE=;
 b=MfHs4Syh3tcGEIzJ1UPLGh3pycR3Ve2yztsbTgsBkjr/vw6SAQlt3dhv4dieRe7IKIJeWg
 LmF9UUerS02pusdMPfm1wr4cebPFmMGtFVaAbd2w8SlHBUZGy0YK/lHde0Bcd/x7Vex+re
 U85Yn9o7RwL63XncU9dYl/VeJDYNQNA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-FZts76KaNiulsZ9yvcgKRg-1; Wed, 12 Jul 2023 07:47:05 -0400
X-MC-Unique: FZts76KaNiulsZ9yvcgKRg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbdd5d09b8so46207745e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 04:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689162424; x=1691754424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDqpjDFyxOOSEizJoajCZDkxHavIWA533ohUQUXjDsE=;
 b=fvHTBHj9Tr49zcDNOM6v6Q1yNK+SxBAzMkTTX+vyNafDNT7+TglJF/CvAIvGRAr47l
 jUeJkGFapfNpqCNd528RUSUVzteOvsXV9AkjfQSwJgjGGmLUjWonXP+5XiS07rc6Qp0X
 pLMfps1VIbUs+f7o5kJbO7ULLS2YaNqi43+J0SwwzhzYPSIMqf9kX9b06Kzivl3SekqJ
 fdQfSFwptBlwPTFX6DAIVfYGs7mS//AMtXO9EeJJTZdySVRypuwXF/LzHTvDgT1EbXVj
 740q+NKpQ/M+bnTYscVZBMCyt4Z5+pZ9briqJpgygfv8RajfWqIgELDAL3kwZi+IqLwm
 v/gA==
X-Gm-Message-State: ABy/qLb+MEh+0Ne4/yXuJTlIprJKQ2ofOyW6D4uuX8StDgcFbkRI5fXZ
 gOAEKGDiqZHbJiXx2e4SH05FXLuPUZYq3LEOc81gFBUh5PZ28USHv/WQlbDFFJYE7MqHjQ88ZRw
 IavKkosLBGsHJ+hI=
X-Received: by 2002:a1c:7505:0:b0:3f9:846:d892 with SMTP id
 o5-20020a1c7505000000b003f90846d892mr17784440wmc.9.1689162424299; 
 Wed, 12 Jul 2023 04:47:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGCtN47PkrEnjuVyKvSE7dDyJXArg0Uf0ADxcu/jjOp+FF//UKUht4O+M0s80lZrp2TjYFVCQ==
X-Received: by 2002:a1c:7505:0:b0:3f9:846:d892 with SMTP id
 o5-20020a1c7505000000b003f90846d892mr17784412wmc.9.1689162423908; 
 Wed, 12 Jul 2023 04:47:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f3:f1da:a306:cee7:ddff:8ed0])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a5d5487000000b0030ae901bc54sm4858558wrv.62.2023.07.12.04.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 04:47:03 -0700 (PDT)
Date: Wed, 12 Jul 2023 07:46:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH] hw/pci: Warn when ARI/SR-IOV device has non-zero
 Function number
Message-ID: <20230712073523-mutt-send-email-mst@kernel.org>
References: <20230712112732.18617-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712112732.18617-1-akihiko.odaki@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 12, 2023 at 08:27:32PM +0900, Akihiko Odaki wrote:
> Current SR/IOV implementations assume that hardcoded Function numbers
> are always available and will not conflict. It is somewhat non-trivial
> to make the Function numbers to use controllable to avoid Function
> number conflicts so ensure there is only one PF to make the assumption
> hold true.
> Also warn when non-SR/IOV multifunction was attempted with ARI enabled;
> ARI has the next Function number field register, and currently it's
> hardcoded to 0, which prevents non-SR/IOV multifunction. It is
> certainly possible to add a logic to determine the correct next Function
> number according to the configuration, but it's not worth since all
> ARI-capable devices are also SR/IOV devices, which do not support
> multiple PFs as stated above.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

I am not really interested in adding this stuff.
The real thing to focus on is fixing ARI emulation, not
warning users about ways in which it's broken.

> ---
>  hw/pci/pci.c | 59 +++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 784c02a182..50359a0f3a 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2124,23 +2124,48 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>          }
>      }
>  
> -    /*
> -     * A PCIe Downstream Port that do not have ARI Forwarding enabled must
> -     * associate only Device 0 with the device attached to the bus
> -     * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
> -     * sec 7.3.1).
> -     * With ARI, PCI_SLOT() can return non-zero value as the traditional
> -     * 5-bit Device Number and 3-bit Function Number fields in its associated
> -     * Routing IDs, Requester IDs and Completer IDs are interpreted as a
> -     * single 8-bit Function Number. Hence, ignore ARI capable devices.
> -     */
> -    if (pci_is_express(pci_dev) &&
> -        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
> -        pcie_has_upstream_port(pci_dev) &&
> -        PCI_SLOT(pci_dev->devfn)) {
> -        warn_report("PCI: slot %d is not valid for %s,"
> -                    " parent device only allows plugging into slot 0.",
> -                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
> +    if (pci_is_express(pci_dev)) {
> +        /*
> +         * A PCIe Downstream Port that do not have ARI Forwarding enabled must
> +         * associate only Device 0 with the device attached to the bus
> +         * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
> +         * sec 7.3.1).
> +         * With ARI, PCI_SLOT() can return non-zero value as the traditional
> +         * 5-bit Device Number and 3-bit Function Number fields in its
> +         * associated Routing IDs, Requester IDs and Completer IDs are
> +         * interpreted as a single 8-bit Function Number. Hence, ignore ARI
> +         * capable devices.
> +         */
> +        if (!pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
> +            pcie_has_upstream_port(pci_dev) &&
> +            PCI_SLOT(pci_dev->devfn)) {
> +            warn_report("PCI: slot %d is not valid for %s,"
> +                        " parent device only allows plugging into slot 0.",
> +                        PCI_SLOT(pci_dev->devfn), pci_dev->name);
> +        }
> +
> +        /*
> +         * Current SR/IOV implementations assume that hardcoded Function numbers
> +         * are always available. Ensure there is only one PF to make the
> +         * assumption hold true.
> +         */
> +        if (pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV) &&
> +            PCI_FUNC(pci_dev->devfn)) {
> +            warn_report("PCI: function %d is not valid for %s,"
> +                        " currently PF can only be assigned to function 0.",
> +                        PCI_FUNC(pci_dev->devfn), pci_dev->name);
> +        }
> +
> +        /*
> +         * ARI has the next Function number field register, and currently it's
> +         * hardcoded to 0, which prevents non-SR/IOV multifunction.
> +         */
> +        if (pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
> +            !pci_is_vf(pci_dev) && (pci_dev->devfn & 0xff)) {
> +            warn_report("PCI: function %d is not valid for %s,"
> +                        " non-SR/IOV multifunction is not supported with ARI enabled.",
> +                        pci_dev->devfn & 0xff, pci_dev->name);
> +        }
>      }
>  
>      if (pci_dev->failover_pair_id) {
> -- 
> 2.41.0


