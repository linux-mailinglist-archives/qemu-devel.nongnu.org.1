Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0762E724317
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6W9J-0003RQ-I7; Tue, 06 Jun 2023 08:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6W9F-0003Qk-Id
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6W9D-0004Tb-Ip
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686055849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HoHl1voG93Cd0LRIgaaGA4MbK2nauNihfP23hJqlKA=;
 b=f+ekDcylHCMYYjOfzXHUTNOcIliK7QAE5l69b78XTnhZ8Td8yXn9cwgVYbz9zJ4sAp7lr3
 l4NALtrrJiF3fdV8QtX1cA36tHxnmUNzb97KtXKkthjI9YfbJAQTGYJxOWtCs2t3hJ45Y9
 RPOUHy4zBigNG0zoRSS7IwUZTYO3jdg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-FLZ7EWSxOF2ehvUUEjQvjA-1; Tue, 06 Jun 2023 08:50:48 -0400
X-MC-Unique: FLZ7EWSxOF2ehvUUEjQvjA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-974566553ccso453292066b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 05:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686055847; x=1688647847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7HoHl1voG93Cd0LRIgaaGA4MbK2nauNihfP23hJqlKA=;
 b=QbWr4OjoZxmIaWxgBVWSySPPNOm5sziXw2eicfwRponDrlnlmUIR54XghyQThrpXH4
 a/amhu8DjXN0FfVBpCnhHTXXlZAdD6UZeif+SU6jeEMioycFE0hk11isidPqSGF63KpW
 AI+QTRzJsQ7MLzY18yegg7zscTXQCaapxjKILG7oDEZir5d9vK8vKC9TVwHsypp8iTzA
 Hm/wqukjBunN5jGNWj1bY0srGNuWZtg/r3X6xOpj+GuqHLPQJxg17vN0yQnEV5+Knc5q
 pzsMi2xHRXZBTNI9e0wjQwl6tngE/90UAECDIHH/MAazLsCNaBmLn26muquNyer/NWRC
 /LhQ==
X-Gm-Message-State: AC+VfDxD+e9XHCRnfgF9iF6X2RWnef2ABz7E0Mao8rpYFSRpo+gAIxBN
 ZDxuSOexO77TVx6qo4R/jgn+YEcqBuvL9LAiSyo5tI2zWMJO3gX6lrvpp5SI7I/84Gt6QxQny5D
 oVpwPkXjGyOeIaZU=
X-Received: by 2002:a17:907:2d94:b0:970:e010:3bb2 with SMTP id
 gt20-20020a1709072d9400b00970e0103bb2mr2681402ejc.35.1686055847532; 
 Tue, 06 Jun 2023 05:50:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RsgSme96BOqv6YkCrA65PpBf8UNKzkBJcBHX9m41nhnBRPZuAt5MR7fZPOtLARTNk6b9UlQ==
X-Received: by 2002:a17:907:2d94:b0:970:e010:3bb2 with SMTP id
 gt20-20020a1709072d9400b00970e0103bb2mr2681384ejc.35.1686055847269; 
 Tue, 06 Jun 2023 05:50:47 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 n19-20020a17090625d300b009662b4230cesm5638417ejb.148.2023.06.06.05.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 05:50:46 -0700 (PDT)
Date: Tue, 6 Jun 2023 14:50:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH] hw/acpi: Fix PM control register access
Message-ID: <20230606145046.159b6bba@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230528135750.4145574633D@zero.eik.bme.hu>
References: <20230528135750.4145574633D@zero.eik.bme.hu>
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

On Sun, 28 May 2023 15:57:50 +0200 (CEST)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On pegasos2 which has ACPI as part of VT8231 south bridge the board
> firmware writes PM control register by accessing the second byte so
> addr will be 1. This wasn't handled correctly and the write went to
> addr 0 instead. This fixes ACPI shutdown with pegasos2 firmware.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> This is replacing the previous attempt which changed enduanness to
> NATIVE_ENDIAN that was found to be wrong. I'm still not sure what's
> happening as these functions are called with addr = 1 and size = 2 but
> maybe the guest really does word access to addr 1 when wanting to
> write 1 byte. This fixes the problem and should not break anything
> else but please review.
> 
>  hw/acpi/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 6da275c599..bbc599a252 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -593,13 +593,13 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
>  static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
>  {
>      ACPIREGS *ar = opaque;
> -    return ar->pm1.cnt.cnt;
> +    return ar->pm1.cnt.cnt >> addr * 8;
>  }
that looks fine

>  
>  static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
>                                unsigned width)
>  {
> -    acpi_pm1_cnt_write(opaque, val);
> +    acpi_pm1_cnt_write(opaque, val << addr * 8);
>  }
however, if this is 1 byte write at offset 1,
wouldn't this wipe out lower byte
(aka:
#define ACPI_BITMASK_SCI_ENABLE                 0x0001                           
#define ACPI_BITMASK_BUS_MASTER_RLD             0x0002                           
#define ACPI_BITMASK_GLOBAL_LOCK_RELEASE        0x0004
)? 


>  
>  static const MemoryRegionOps acpi_pm_cnt_ops = {


