Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC8C7483BD
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:04:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1Es-0003gQ-O2; Wed, 05 Jul 2023 08:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1Eq-0003ft-8q
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1Eo-0002YT-9G
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688558641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMrwNJVFiqPUNKKxGQF3GZaw9AE8DMvjrxFmykZYZ7I=;
 b=K3Hv3tJSwx6qOUz01fynYNGvEWZwJyE2s9k/I23ugSz7iz1tk60DcG7U1A4il9QMttFeHx
 6A34jQwZofiJ/yrcGsoFXEjEHXqOmO1dhZY27vOZS6rFsZ9AnRrKBR8g7SQMqwb60Tywcp
 9B6uOh4Y/yQ3Y46y5Aok95ZZZeb+30k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-O7Kw4RCmPUGuzM5W2HBDeA-1; Wed, 05 Jul 2023 08:03:53 -0400
X-MC-Unique: O7Kw4RCmPUGuzM5W2HBDeA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1b8b310553bso5462405ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 05:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558617; x=1691150617;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMrwNJVFiqPUNKKxGQF3GZaw9AE8DMvjrxFmykZYZ7I=;
 b=FBn4xgo0IZtDuyyghQx2/FERYtwvBT/qEBStdYVZtg22LvkfgFVBHFpHl4y90fWQdy
 OxExrt20PKe7elCUCMSGNxBbcoStiV2yxomgrAuy+ACbaAAAwZqWKtLrUi3up+9Cqh4h
 Z/6Su3qUzKGkUMeYR2w/CQCIzax4DhgWbkdTByAFGinWzE8OastICUyXPWDQhizxvsGF
 /kMEIEJGk9dFqqYp4C6WZxmpgEDtTm36XU4U0csNsgw/wM5YgDluUxCon7m39f5dS/Tk
 EZdS9KpufmhX081OTBe4kBFJ4ujU9SXDYYZsFlF9GO3iGfrRHvV0vnEoSqLNFj26ZlpU
 p/TA==
X-Gm-Message-State: ABy/qLbMK5kq1RhUcftOd6QKXbkEKvd4qkxGmofWeySWOvyL2wzgtnWl
 aLVUKRpbpc4PKfUmn4t4qV9OZSZ0f5qKPv9b5Qy4NBbQvjgGqtmBXDhj8t+wEwt8KxhVZY5k/Tr
 /KFTAlUurLZCAhbStbgGQjzpOyAKLvH6mEn0+8D+b6k2OHDK09/RZFIHZGUmrOGw13Snx+z2c5g
 U=
X-Received: by 2002:a17:902:db0a:b0:1b8:9ed3:a3fd with SMTP id
 m10-20020a170902db0a00b001b89ed3a3fdmr9090333plx.29.1688558616821; 
 Wed, 05 Jul 2023 05:03:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHsJ+FtR2sRkLqqIr9DLfYXa4iITDi8MmVBtYuQUssmRI6mcLcnwWgxwBkwPcXPwyAGZr7JRA==
X-Received: by 2002:a17:902:db0a:b0:1b8:9ed3:a3fd with SMTP id
 m10-20020a170902db0a00b001b89ed3a3fdmr9090309plx.29.1688558616441; 
 Wed, 05 Jul 2023 05:03:36 -0700 (PDT)
Received: from smtpclient.apple ([115.96.119.220])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a170902694300b001a24cded097sm18808433plt.236.2023.07.05.05.03.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Jul 2023 05:03:36 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v8 6/6] hw/pci: add comment explaining the reason for
 checking function 0 in hotplug
Date: Wed, 5 Jul 2023 17:33:31 +0530
References: <20230705115925.5339-1-anisinha@redhat.com>
 <20230705115925.5339-7-anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
In-Reply-To: <20230705115925.5339-7-anisinha@redhat.com>
Message-Id: <F99D12E7-135A-4A03-8B9D-1FF384FBCA5A@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 05-Jul-2023, at 5:29 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> This change is cosmetic. A comment is added explaining why we need to =
check for
> the availability of function 0 when we hotplug a device.

Please ignore this patch. Its a duplicate of one already sent with an =
updated patch summary.

>=20
> CC: mst@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
> hw/pci/pci.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 62b393dfb7..7aee3a7f12 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1181,9 +1181,14 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>                    PCI_SLOT(devfn), PCI_FUNC(devfn), name,
>                    bus->devices[devfn]->name, =
bus->devices[devfn]->qdev.id);
>         return NULL;
> -    } else if (dev->hotplugged &&
> -               !pci_is_vf(pci_dev) &&
> -               pci_get_function_0(pci_dev)) {
> +    } /*
> +       * Populating function 0 triggers a scan from the guest that
> +       * exposes other non-zero functions. Hence we need to ensure =
that
> +       * function 0 wasn't added yet.
> +       */
> +    else if (dev->hotplugged &&
> +             !pci_is_vf(pci_dev) &&
> +             pci_get_function_0(pci_dev)) {
>         error_setg(errp, "PCI: slot %d function 0 already occupied by =
%s,"
>                    " new func %s cannot be exposed to guest.",
>                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> --=20
> 2.39.1
>=20


