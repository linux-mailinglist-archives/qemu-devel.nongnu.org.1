Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8B74705A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:03:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGekq-0001tj-0n; Tue, 04 Jul 2023 08:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGeko-0001tX-6E
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGekm-0002qj-Lu
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688472211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGcso718aQ2HnLIgK3qFXXmi6OuKnRgn14jeJtFqyYY=;
 b=Y8Sd0EThBp4k1nhmoxEhdA/LkQSeX4HNeISDNumi//i7bnLcZW7tDwZYcT1inDprtq2UoS
 HH7fd4dRHqSAihWO6amZDRYr3cSExziambppMz6S6bNMY0Uw82wbzQCUcWKdqJgPqqVQkQ
 JTLMtel8/zHagsBODKErqPfMneyXHhw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-5XUTHWvyNRKujXlIqhkcow-1; Tue, 04 Jul 2023 08:03:30 -0400
X-MC-Unique: 5XUTHWvyNRKujXlIqhkcow-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a348facbbso382117166b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688472204; x=1691064204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGcso718aQ2HnLIgK3qFXXmi6OuKnRgn14jeJtFqyYY=;
 b=eUbMvTKa+ZUxlGqgakbFx4UrQaSMlu3PklscnK7SZ/bNQqiTy6ip1HqAG2lV74jlbW
 tSOTrJxRcriNOKQpD8co42tRfQgD5HHKLKYeoLS24SA+n1A4j4RifwuO6yc/PqOos0YA
 WOSMHF+qHAEC2+U6KRaZ732Ap07lpw9uD0DHxNTC5bkRyoYcvd+Rz1ik5WMaq93+rjo2
 eKPYdIcElRIsF7qZe8UznV7tiIzNzg+w9sxQMAe8Fmp2CTne1V+x1mdZWVf+UO2rr8vA
 u+hk6BqzVs4gznLOyHrtP31A4XRy7DvCzujeAb6mGm6nBKlGdDyf8EC/nX4eaJpgteLB
 gu7A==
X-Gm-Message-State: ABy/qLaK7693xF5tq6B919409XSgZuKpGJsSyjo2QgZvFpXpRVfay0wF
 jylnaRPRH25+i2NWYiiXlfOkLE1qdsBJ4NJTYQpE0P6Qad5dzT/6PPS6xQgtB9TU073k2xBHCaq
 NbBqfDpmFC6XBsKI=
X-Received: by 2002:a17:906:4f0a:b0:992:ba2c:2e0c with SMTP id
 t10-20020a1709064f0a00b00992ba2c2e0cmr10822324eju.36.1688472204628; 
 Tue, 04 Jul 2023 05:03:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFXoJ+P7u6/LK4L3Mwzb3pxQKydnD6tbUnLkPl6BA02bf+qQV4nTVurKdRWcBXqi/i9m5fVAw==
X-Received: by 2002:a17:906:4f0a:b0:992:ba2c:2e0c with SMTP id
 t10-20020a1709064f0a00b00992ba2c2e0cmr10822302eju.36.1688472204298; 
 Tue, 04 Jul 2023 05:03:24 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 kd9-20020a17090798c900b00992d70cc8acsm6141465ejc.112.2023.07.04.05.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 05:03:23 -0700 (PDT)
Date: Tue, 4 Jul 2023 14:03:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, Jason Wang <jasowang@redhat.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v3 2/2] pcie: Specify 0 for ARI next function numbers
Message-ID: <20230704140323.013c2dda@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230702120229.66978-3-akihiko.odaki@daynix.com>
References: <20230702120229.66978-1-akihiko.odaki@daynix.com>
 <20230702120229.66978-3-akihiko.odaki@daynix.com>
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

On Sun,  2 Jul 2023 21:02:27 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> The current implementers of ARI are all SR-IOV devices. The ARI next
> function number field is undefined for VF. The PF should end the linked
> list formed with the field by specifying 0.

this should also describe compat behavior changes.


> Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
> Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
> Fixes: 3a977deebe ("Intrdocue igb device emulation")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/pci/pci.h | 2 ++
>  hw/core/machine.c    | 1 +
>  hw/pci/pci.c         | 2 ++
>  hw/pci/pcie.c        | 2 +-
>  4 files changed, 6 insertions(+), 1 deletion(-)
> 

>  GlobalProperty hw_compat_8_0[] = {
>      { "migration", "multifd-flush-after-each-section", "on"},
> +    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
>  };

[...]

> +    DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> +                    QEMU_PCIE_ARI_NEXTFN_1_BITNR, true),

now, I'm confused a bit. So above line says that default
x-pcie-ari-nextfn-1=on

then compat also sets it to 'on', so question is why do
we have compat entry at all?
If default state doesn't change why do we need involve compat
machinery and add "x-pcie-ari-nextfn-1" property?

>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 9a3f6430e8..cf09e03a10 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1030,7 +1030,7 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
>  /* ARI */
>  void pcie_ari_init(PCIDevice *dev, uint16_t offset)
>  {
> -    uint16_t nextfn = 1;
> +    uint16_t nextfn = dev->cap_present & QEMU_PCIE_ARI_NEXTFN_1 ? 1 : 0;
>  
>      pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
>                          offset, PCI_ARI_SIZEOF);


