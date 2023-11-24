Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA58B7F755F
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 14:39:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6WNb-0001BM-Qv; Fri, 24 Nov 2023 08:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6WNQ-0001Az-79
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:37:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6WNN-0004gz-JS
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700833064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZmoVROR/SfRtLXWrTRIIUhYAV2eKL110w8TRb/3ksU=;
 b=NtsODUDtEIIbAxhdr1hnX+JrtVPG/hDxh5c1SJrC3pBMhFjoummhd5Fn+L7IWXJvFU867S
 E97n2sOjPZ4EZrX5R2Ws9CpVPWql+OouXqcL/PH6FkKvG69pj2Voi6ASmmU89UWmNf8xGZ
 bERuAEgfb2Xy7NdSRee/JiMtqA7fUpk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-kHfx3wc0NgmxvFMQ4hE9JQ-1; Fri, 24 Nov 2023 08:37:43 -0500
X-MC-Unique: kHfx3wc0NgmxvFMQ4hE9JQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a00dd93a5f1so140855466b.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 05:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700833062; x=1701437862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZmoVROR/SfRtLXWrTRIIUhYAV2eKL110w8TRb/3ksU=;
 b=VSK8rFp7LgfqaSOB33ggKDwfVkAYZz0l17qyK2QsIrOi8HCECPoY2OQgr7E+/FzqNc
 iyrL+oem+V5c8MQQhnFoev7dn4jhPC2UJjvyVT2/hN7RA9d4KLzkWUr72AuL7TjX7JfV
 yueKNGTMGjla6jcKBzw8pxdoY412G55GoBE2oqw2w+an1Ayp9l1u2OVZ9i4Pm1jtH8Vb
 8qxg9Qu1u2fajJ4OY2+5+R1ZW98kKskoiEZRvJthIu3sPWZpRamYuSu+GqKfKN1z6+cS
 npjJI+gcems0p3SrRDt8ZJjgXewgy6hR9HJBNQkjjoWgwtpRR9Ks431indo+UnN2k1tw
 DP2Q==
X-Gm-Message-State: AOJu0YyT9tsonTCfeRnuzsxXCQnoL9eyfRQi3n11JfkLtRMV85VoX3qJ
 zEpnn9pcYv9zWnIKhMG6YLmUx9p0h7EHlLpmmb1So1mwItCSDiS313lRb6Vv/vydY6l34BdAxXV
 ludwrzm7nEj17jmo=
X-Received: by 2002:a17:906:5349:b0:a04:9655:e15b with SMTP id
 j9-20020a170906534900b00a049655e15bmr2594097ejo.49.1700833061936; 
 Fri, 24 Nov 2023 05:37:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8YRiUQEEYtJom1zjO+XNOQCew1hfHVei26ov0E26iWhzacdzw6O3ztkuKPWr24gF2rqaLCA==
X-Received: by 2002:a17:906:5349:b0:a04:9655:e15b with SMTP id
 j9-20020a170906534900b00a049655e15bmr2594087ejo.49.1700833061682; 
 Fri, 24 Nov 2023 05:37:41 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a170906358400b009a19701e7b5sm2081475ejb.96.2023.11.24.05.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 05:37:41 -0800 (PST)
Date: Fri, 24 Nov 2023 14:37:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thierry Escande <thierry.escande@vates.tech>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 4/4] ich9: Enable root PCI hotplug by default
Message-ID: <20231124143740.2585607c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231115171837.18866-5-thierry.escande@vates.tech>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
 <20231115171837.18866-5-thierry.escande@vates.tech>
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

That probably is not enough,
due to:
        if (pm->pcihp_bridge_en) {                                               
            build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);                 
        }                                                                        
        build_q35_pci0_int(dsdt);  


