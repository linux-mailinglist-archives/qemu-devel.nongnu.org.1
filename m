Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D252872C64E
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:47:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hsU-00006F-Oa; Mon, 12 Jun 2023 09:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8hrW-0008VA-H7
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8hrR-0006z0-Cc
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686577531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCmA5L07Y6+781F4F9O7pYROg65lDkmg4bxgvHcD94I=;
 b=Vm2Y9jgE8GjL82Z+fKMyQ8R+IJqrtCFV7BIBvHJg30xuQ/c9chEdq16/QvCHPcrmRX49NR
 pYSk7y1VSNRkoz8oArk3C/63s2kLvTntrh2zCMhnjIoo2dIJJOQd1KH4QSBb0l//UaK/YT
 SlfATe74RsbTs3/aMSKOErtPwhXVPKM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-LmNT_43KNi-zoh9cOg2Q_Q-1; Mon, 12 Jun 2023 09:45:30 -0400
X-MC-Unique: LmNT_43KNi-zoh9cOg2Q_Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9745c72d99cso512804066b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 06:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686577529; x=1689169529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCmA5L07Y6+781F4F9O7pYROg65lDkmg4bxgvHcD94I=;
 b=Czr5CUrNZWHCMvwTdKzk6TQ/dROXR5oP78fNxdewJs5/tzyV0Sig0Mevv7pV6LLYpj
 WfOqcFtLYyWh3tFfgoR8yclhxuqiPSRsGTqqFZYnBmyB2nt/AIOjv5yPl+pc759DWhDz
 MCk7dj53HSMtv0LC/qwfWit8CXLiJiTrTPJ/Iou64CXjsStdQajgBSRwNryP+1eay0Xc
 PWCCFsmcswEIaR72HDe7E8Qf9pl8t+4vYkYu+yAXqOVRHJ1CbR0WXvrojySeHNyK0bTT
 vyAK+C6YfglKv+cSMsSrtITGLzj+ON3BietSspGSpDSKkCucq6tPf7aSua5R1pR1R3aF
 r9KQ==
X-Gm-Message-State: AC+VfDxztnoq3XmBDNIumfNRIXru/H+WokoULlePQ3lJ7ogGGwXPaw8p
 n+rIGqbUfzSQNQ3DiHN5nKHUfMed7QNvAmpLjlF6ozjRf26iE/zx6Mai0HF9mgiNCoOCeAGfm2R
 gdGkr+cX4Y1A8t1M=
X-Received: by 2002:a17:907:9811:b0:97e:aace:b6bc with SMTP id
 ji17-20020a170907981100b0097eaaceb6bcmr5481025ejc.53.1686577529058; 
 Mon, 12 Jun 2023 06:45:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4sFgWbEFK2s/G8KWFQnkgbDySeS+WY10I65lZy2lEKAEo30tOY7NY6+1w30nlfFex4+pgzKQ==
X-Received: by 2002:a17:907:9811:b0:97e:aace:b6bc with SMTP id
 ji17-20020a170907981100b0097eaaceb6bcmr5481008ejc.53.1686577528807; 
 Mon, 12 Jun 2023 06:45:28 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 lo27-20020a170906fa1b00b0096f803afbe3sm5246643ejb.66.2023.06.12.06.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 06:45:28 -0700 (PDT)
Date: Mon, 12 Jun 2023 15:45:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 04/15] hw/pci/pci_host: Introduce PCI_HOST_BYPASS_IOMMU
 macro
Message-ID: <20230612154527.52e3fdf7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230611103412.12109-5-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-5-shentey@gmail.com>
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

On Sun, 11 Jun 2023 12:34:01 +0200
Bernhard Beschow <shentey@gmail.com> wrote:

> Introduce a macro to avoid copy and pasting strings which can easily
> cause typos.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/pci/pci_host.h | 2 ++
>  hw/pci/pci_host.c         | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> index c6f4eb4585..e52d8ec2cd 100644
> --- a/include/hw/pci/pci_host.h
> +++ b/include/hw/pci/pci_host.h
> @@ -31,6 +31,8 @@
>  #include "hw/sysbus.h"
>  #include "qom/object.h"
>  
> +#define PCI_HOST_BYPASS_IOMMU "bypass-iommu"
> +
>  #define TYPE_PCI_HOST_BRIDGE "pci-host-bridge"
>  OBJECT_DECLARE_TYPE(PCIHostState, PCIHostBridgeClass, PCI_HOST_BRIDGE)
>  
> diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> index dfd185bbb4..7af8afdcbe 100644
> --- a/hw/pci/pci_host.c
> +++ b/hw/pci/pci_host.c
> @@ -232,7 +232,7 @@ const VMStateDescription vmstate_pcihost = {
>  static Property pci_host_properties_common[] = {
>      DEFINE_PROP_BOOL("x-config-reg-migration-enabled", PCIHostState,
>                       mig_enabled, true),
> -    DEFINE_PROP_BOOL("bypass-iommu", PCIHostState, bypass_iommu, false),
> +    DEFINE_PROP_BOOL(PCI_HOST_BYPASS_IOMMU, PCIHostState, bypass_iommu, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  


