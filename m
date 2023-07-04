Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784A47470A8
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:16:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGewS-0007h3-2g; Tue, 04 Jul 2023 08:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGewP-0007gn-3q
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGewN-0005gr-6u
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688472930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iN6GXcgwPq6oJY6Tb0/NxaTeMvyHmZm2YtGOdtzxFGc=;
 b=Ov5PLB1oAXhzNLUNndzRTdzWg+LaePEmiVH6+amSOo7HkUxPtTGYide1MjNSoTZAv0y7N8
 PU2gdLHzga8XRuHx8TTnd9lAV0hvaWP0+7F/YHkAe4+eQ7QCo0FrfABIl4xthhxQv8IggA
 BnQZDI6PAHWIgy9jXE2w/b5EPYenpok=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-xf-y2HKMOtqph4TcDxqt-g-1; Tue, 04 Jul 2023 08:15:28 -0400
X-MC-Unique: xf-y2HKMOtqph4TcDxqt-g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-98843cc8980so463122766b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688472927; x=1691064927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iN6GXcgwPq6oJY6Tb0/NxaTeMvyHmZm2YtGOdtzxFGc=;
 b=QIN6DUlwzHDkXxuHr6luF6aExcH2RGS6ULoSDzaVBcMxiLbQEkdhf32a/9jsm8Kj4d
 jZkWzR4NG+/SqqUqlqkd+M9KSkpzzOf8R7tcaQfqj+UVLvx4OoGVlh9YFKI6UD58YoNP
 nPR5WQKm+Qe3ehedQLbcawm3QixwqOzgTK5l3wtgFtPTcRfoYeIJRMfhgVrungtmycnD
 Y2uDPIWA5gEAuxXpu+RDYMoBAa+QNyaIr1FvHJUfMaq2IwOiIn3QFUJC7H6sIBr9oyg5
 gR8wTBBZPaQiSbEJLLHvEDYf9b39jQHNalyiG7NlVp0I18ODQWAwBO/g87PUhmD4s3wG
 fr3A==
X-Gm-Message-State: ABy/qLZyRk9HdLePPVY/j5BQ0d4nzTShQpOj/Udu7rk00omVJM0/lYmt
 K4xXeSfwSWKuwUcJeUL4gDIgrSLdFH1JI206R+zDa81yUdk/yKqy80b99bGhwgswQw8Cyfn0xSp
 bx6vZLwagdY0oL1mTX2k3C38=
X-Received: by 2002:a17:906:29ce:b0:992:b8b6:6bcd with SMTP id
 y14-20020a17090629ce00b00992b8b66bcdmr11657187eje.16.1688472927079; 
 Tue, 04 Jul 2023 05:15:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEy83uXJJTYrMaNyFNU8gKziDQJ2dDJIm5duA61BBqOvlk8Lsb54J01FPBHGueDk3fPRL2cyA==
X-Received: by 2002:a17:906:29ce:b0:992:b8b6:6bcd with SMTP id
 y14-20020a17090629ce00b00992b8b66bcdmr11657175eje.16.1688472926830; 
 Tue, 04 Jul 2023 05:15:26 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 lr26-20020a170906fb9a00b0099207b3bc49sm9606063ejb.30.2023.07.04.05.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 05:15:25 -0700 (PDT)
Date: Tue, 4 Jul 2023 14:15:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v7 6/6] hw/pci: add comment explaining the reason for
 checking function 0 in hotplug
Message-ID: <20230704141524.3ddacd34@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230704112555.5629-7-anisinha@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-7-anisinha@redhat.com>
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

On Tue,  4 Jul 2023 16:55:55 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> This change is cosmetic. A comment is added explaining why we need to check for
> the availability of function 0 when we hotplug a device.
> 
> CC: mst@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/pci/pci.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 47517ba3db..e3ff3808b6 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1181,9 +1181,15 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     PCI_SLOT(devfn), PCI_FUNC(devfn), name,
>                     bus->devices[devfn]->name, bus->devices[devfn]->qdev.id);
>          return NULL;
> -    } else if (dev->hotplugged &&
> -               !pci_is_vf(pci_dev) &&
> -               pci_get_function_0(pci_dev)) {
> +    } /*
> +       * Populating function 0 triggers a scan from the guest that
> +       * exposes other non-zero functions. Hence we need to ensure that
> +       * function 0 wasn't added yet.

> With SRIOV and with or without ARI
> +       * the PF must be hotplugged into function 0 for it to be detected.
Wouldn't the same apply to non-SR-IOV devices as well?

> +       */
> +    else if (dev->hotplugged &&
> +             !pci_is_vf(pci_dev) &&
> +             pci_get_function_0(pci_dev)) {
>          error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
>                     " new func %s cannot be exposed to guest.",
>                     PCI_SLOT(pci_get_function_0(pci_dev)->devfn),


