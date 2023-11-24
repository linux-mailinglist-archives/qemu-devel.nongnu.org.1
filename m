Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A307F74E0
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 14:23:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6W9V-0006Rc-Rv; Fri, 24 Nov 2023 08:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6W9U-0006RT-E3
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:23:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6W9S-0008Lr-NS
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700832201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fjro/qRNUB+q3z/qdRHtjXZ7pHfEmViydpuPWX9jarQ=;
 b=IUQajH13vW93xArc7EkLDx0p47G9goc3RDykfrQZhdHbN3M8jNZcbiYrBEOtThGMS3EK2n
 4vbc+pqK9uCeuhoSgejH/S71af5yD6FrokY735+Mus+4IqCRql6D0G7puYXDkUMH9VyJ8w
 nbvEpGNX//znzLhq/DrdNU7YYEpudA0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-so0BazaWPyKPfRwQQc1NNA-1; Fri, 24 Nov 2023 08:23:20 -0500
X-MC-Unique: so0BazaWPyKPfRwQQc1NNA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a029b93e484so132956766b.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 05:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700832199; x=1701436999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fjro/qRNUB+q3z/qdRHtjXZ7pHfEmViydpuPWX9jarQ=;
 b=qwW1VcMxobH4jcwEStTHwKH8y/6S5iwOIvP2TGw+8VzPKskzNUaxTt+CU5RepQv+pS
 996O/THFc6ubxjq1IGL6eqREu8LCfdouUPG+TBImxNCPW3xXzmUYjmBVtBVGEBHovMjy
 7gFM22U6yyb1yXL+k4G0s3gIEXr7lotP2ZP3mzwkCABwIEWug5n+3BZ+9uUZtWOvkxXJ
 TJegRLqnFwQeYT/6ZRpSZzHkdZvfwMLIVV7Jbzd3gNxbvBZA1EWtpJEpj5K5z8JixCsm
 FYshw2euPwxcEL0FdD9I2Jx6O8kxutaAc8Dm2Ipvrcik5b8JQ3BEK+PSVTkbz4GboQeu
 KI+Q==
X-Gm-Message-State: AOJu0YxfSiR545M3ND5rW/65kKRmnqkXMkyxH0Jziygn4ohV9PvBCLmr
 O8WP1J42p2HwAjABvBs4ttDps0WJp+QoDtDVBWiydME2/XOCVQBm5WcWNYKZ83giY5PjlxI7mhJ
 TJHwdGV9wbpjktqo=
X-Received: by 2002:a17:906:48cc:b0:a00:9860:7fa7 with SMTP id
 d12-20020a17090648cc00b00a0098607fa7mr2015826ejt.68.1700832199301; 
 Fri, 24 Nov 2023 05:23:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEafI2gEC1PkI+kDv+bAkvFiOwFVq2RSV/SU7NksCqHKaxhUqzvRFp/nWVL2F+FDjPDbxoHJA==
X-Received: by 2002:a17:906:48cc:b0:a00:9860:7fa7 with SMTP id
 d12-20020a17090648cc00b00a0098607fa7mr2015811ejt.68.1700832198935; 
 Fri, 24 Nov 2023 05:23:18 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a170906500700b00a0950451affsm680040ejj.67.2023.11.24.05.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 05:23:18 -0800 (PST)
Date: Fri, 24 Nov 2023 14:23:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thierry Escande <thierry.escande@vates.tech>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 1/4] ich9: Remove unused hotplug field from
 ICH9LPCPMRegs struct
Message-ID: <20231124142317.1fdbe16f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231115171837.18866-2-thierry.escande@vates.tech>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
 <20231115171837.18866-2-thierry.escande@vates.tech>
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

On Wed, 15 Nov 2023 17:18:53 +0000
Thierry Escande <thierry.escande@vates.tech> wrote:

> This patch removes the unused field use_acpi_hotplug_bridge from the
> ICH9LPCPMRegs structure as it is now part of AcpiPciHpState.
> 
> Hotplug fields have been removed from piix4 state structure by commit
> 6536e427ce49 (pcihp: move fields enabling hotplug into AcpiPciHpState)
> so do the same for ich9.
> 
> Signed-off-by: Thierry Escande <thierry.escande@vates.tech>

Reviewed-by:Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/ich9.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index 2faf7f0cae..4bc9aa1d11 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -57,7 +57,6 @@ typedef struct ICH9LPCPMRegs {
>      CPUHotplugState cpuhp_state;
>  
>      bool keep_pci_slot_hpc;
> -    bool use_acpi_hotplug_bridge;
>      AcpiPciHpState acpi_pci_hotplug;
>      MemHotplugState acpi_memory_hotplug;
>  


