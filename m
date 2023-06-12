Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A90BA72C6AB
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:56:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8i1s-000446-U5; Mon, 12 Jun 2023 09:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8i1e-00043b-Mw
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8i1d-0000At-5X
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686578164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ML3ryX50G6sXdUeePkfk82IlNockU/pwFeTN9Z4Qm+E=;
 b=hDFSzDFA43NuS3P9SbKp0NeE3Ud5Jv0UCnA1t4tvKN1KrJeTvb2MhBTfy3g5F1hUterVcn
 DX7F5D8GPXSO//CsAZOsIRE0IVzFmDt4E95fl8T/G33TIBtZLKtFOTV/G/6OAxsd7aDuTD
 3noE0EY4pr0/sifsLhFnVwfM4Kiay68=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-w2Fu6l4PMAm-JTaqIk3_MQ-1; Mon, 12 Jun 2023 09:56:03 -0400
X-MC-Unique: w2Fu6l4PMAm-JTaqIk3_MQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-977cf886f17so362832166b.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 06:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686578161; x=1689170161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ML3ryX50G6sXdUeePkfk82IlNockU/pwFeTN9Z4Qm+E=;
 b=UZjreIcyVI4WtbzbNXMEROxQbHGJI+0CGQczbrNJGKzk7j7c/qB6WuD+n4F90TeAXB
 h5nVr3x4paoWYIXqY/DE4OS8FsRkDy0/wvTD0OMSblRZhpaobEVtxWvfdFi+Jg7OfSSt
 Q5hxBdTTDYUvr0igy24VNF5WqOcnKLRfL5qUdOGX1dmd75/DPnMYIQe+s9Me812F/Yze
 tDxlj0UWfkVhbbRqgN5wFavIGxmk6zCIURaHRo1wqTgjSQYCReh5FDeaIcNEP8Wgmwg5
 3WHbmTo5c4Ow9LlSpb3MXwyaqo5c2Zl/35cGRvg4Uh5IwAnpxl96wSewcT9qjZ9IDAib
 xQCw==
X-Gm-Message-State: AC+VfDy2ZBqkh9EAdVxFhATS3eJUmWXUjR0P4qWPWu9wlrxTLRnkTrrz
 5JKRoBTfrA0c6AlpJHNTbm4MRsvCQ7iWiokUwo70q45y5pOTHN5a5B7yIPv17fPLtbdJ7oLPWc5
 QhuvM03nSyiywp44=
X-Received: by 2002:a17:907:5cc:b0:96a:9467:1dc7 with SMTP id
 wg12-20020a17090705cc00b0096a94671dc7mr8347880ejb.25.1686578161043; 
 Mon, 12 Jun 2023 06:56:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RUi5ywSb4J3EMgHX5mXaDY7Li9e3zbmZVE5F5+tG1hNRy3T8jaF/Aj7ah7pyVZkuN641ZCw==
X-Received: by 2002:a17:907:5cc:b0:96a:9467:1dc7 with SMTP id
 wg12-20020a17090705cc00b0096a94671dc7mr8347873ejb.25.1686578160817; 
 Mon, 12 Jun 2023 06:56:00 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 lw4-20020a170906bcc400b009787209732esm5309936ejb.143.2023.06.12.06.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 06:56:00 -0700 (PDT)
Date: Mon, 12 Jun 2023 15:55:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 07/15] hw/pci-host/i440fx: Replace magic values by
 existing constants
Message-ID: <20230612155559.53f27069@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230611103412.12109-8-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-8-shentey@gmail.com>
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

On Sun, 11 Jun 2023 12:34:04 +0200
Bernhard Beschow <shentey@gmail.com> wrote:

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/pci-host/i440fx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index 61e7b97ff4..daa4d11104 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -277,8 +277,8 @@ PCIBus *i440fx_init(const char *pci_type,
>  
>      /* if *disabled* show SMRAM to all CPUs */
>      memory_region_init_alias(&f->smram_region, OBJECT(d), "smram-region",
> -                             f->pci_address_space, 0xa0000, 0x20000);
> -    memory_region_add_subregion_overlap(f->system_memory, 0xa0000,
> +                             f->pci_address_space, SMRAM_C_BASE, SMRAM_C_SIZE);
> +    memory_region_add_subregion_overlap(f->system_memory, SMRAM_C_BASE,
>                                          &f->smram_region, 1);
>      memory_region_set_enabled(&f->smram_region, true);
>  
> @@ -286,9 +286,9 @@ PCIBus *i440fx_init(const char *pci_type,
>      memory_region_init(&f->smram, OBJECT(d), "smram", 4 * GiB);
>      memory_region_set_enabled(&f->smram, true);
>      memory_region_init_alias(&f->low_smram, OBJECT(d), "smram-low",
> -                             f->ram_memory, 0xa0000, 0x20000);
> +                             f->ram_memory, SMRAM_C_BASE, SMRAM_C_SIZE);
>      memory_region_set_enabled(&f->low_smram, true);
> -    memory_region_add_subregion(&f->smram, 0xa0000, &f->low_smram);
> +    memory_region_add_subregion(&f->smram, SMRAM_C_BASE, &f->low_smram);
>      object_property_add_const_link(qdev_get_machine(), "smram",
>                                     OBJECT(&f->smram));
>  


