Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D77F7561
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 14:39:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6WOn-0002Wl-Jn; Fri, 24 Nov 2023 08:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6WOk-0002QZ-Ov
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:39:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6WOj-0004tF-EI
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700833148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/S77ocsRszxqUvKliJPi4rxpmztBfwrEn35Dpzti4gU=;
 b=DnccRE1EinilsXNt51elUc5dj1xk3y22x1W+3ylZmiFDIfh5/cy8okz7cB5Y+dHmIRUqRt
 1kMQBIE4dpXcfdFYw+DPgYJ3Mhvh4AGXARy1p8yJ4qFtJ9/qLFAQJlsxV2ZYwsdFHIHayF
 V4m4dkBzyZCMUdYcaihmi/6rj99L2Rc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-2dlk-ON5Pkij5tQzeYn9fQ-1; Fri, 24 Nov 2023 08:39:07 -0500
X-MC-Unique: 2dlk-ON5Pkij5tQzeYn9fQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a01c7b09335so142120766b.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 05:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700833146; x=1701437946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/S77ocsRszxqUvKliJPi4rxpmztBfwrEn35Dpzti4gU=;
 b=UJkpCgajzSwmpyJS+knLPDlcsE3bbBKAc1fvqFWxYzojfRVR7aUacgTdQj1JR2faXA
 O/vzf6RuJtShM6a2GJElORW178HBvOl88fwSgdDC7wyRs5py1CdB+yybHRnTiwfoYZFu
 EYFe1SGM4AAIThE0YDC6/fRoANsQRabxYLKtkmd2+rV0fOmuhvAIp2bVwgtAEMbVGp42
 cnXcbn5KIcmix4yAyaZcyBA7cY3+QT0eKrFgCABesfWADZi9g1RjUZgqtYO1FRHvTvoX
 xghpTCV5mjf10mXIakwd9iMtYyjT73Zw0v+p4H221471p99aHcecwZE5K9I90hXM0Tt2
 x3bA==
X-Gm-Message-State: AOJu0YyrE3Y3FuL+wxcRz8A9wwWAcIbPe9WkPj5QRMxQeC8Jh0vx4VVz
 DEa/cKE2WYGawAOsL1SVzzB9csS0WpsppVI+TS0LOVA2cBevXI0RjicteGgdeyqaFPyE3+FzldD
 c4hB+WDg44QnqQMU=
X-Received: by 2002:a17:906:578d:b0:9bd:b8d0:c096 with SMTP id
 k13-20020a170906578d00b009bdb8d0c096mr2361866ejq.21.1700833146004; 
 Fri, 24 Nov 2023 05:39:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmGkxyoRD/WhdUbugk1xsLhnGiD355akA/6vA9NZOEt++E3P+muZZq+hhAlxiF0fDWKM3veA==
X-Received: by 2002:a17:906:578d:b0:9bd:b8d0:c096 with SMTP id
 k13-20020a170906578d00b009bdb8d0c096mr2361855ejq.21.1700833145727; 
 Fri, 24 Nov 2023 05:39:05 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a170906578900b009fee12d0dcdsm2090981ejq.15.2023.11.24.05.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 05:39:04 -0800 (PST)
Date: Fri, 24 Nov 2023 14:39:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thierry Escande <thierry.escande@vates.tech>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 4/4] ich9: Enable root PCI hotplug by default
Message-ID: <20231124143903.3b7ee3a4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231115171837.18866-5-thierry.escande@vates.tech>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
 <20231115171837.18866-5-thierry.escande@vates.tech>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 15 Nov 2023 17:18:54 +0000
Thierry Escande <thierry.escande@vates.tech> wrote:

> This patch initializes use_acpi_root_pci_hotplug to true and enables
> device PCI hotplug on q35 machine by default.
> 
> Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
> ---
>  hw/acpi/ich9.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index e38c9bb998..ad2c8ad8ed 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -450,6 +450,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
>      pm->disable_s4 = 0;
>      pm->s4_val = 2;
>      pm->acpi_pci_hotplug.use_acpi_hotplug_bridge = true;
> +    pm->acpi_pci_hotplug.use_acpi_root_pci_hotplug = true;
>      pm->keep_pci_slot_hpc = true;
>      pm->enable_tco = true;
>  

PS: also you'd need to add compat logic to preserve
disabled state for already existing machine types


