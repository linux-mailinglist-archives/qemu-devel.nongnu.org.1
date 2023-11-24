Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 429B27F6D8B
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 09:01:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6R64-0001qr-P1; Fri, 24 Nov 2023 02:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r6R62-0001qF-Hr
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 02:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r6R60-0005LG-TO
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 02:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700812765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLtARen9NFM5l1dIUoVIYqSxTtITzDBQmerdXhBKSX4=;
 b=ETFXBtN5aG587MN6nhyajzEQP5iGIgWZVcJuJt+1NlciogDILbtZ4JI8tFktG+yk6iPvNY
 Q57hwwBQkf2mmC2u/X3SsDIc1YCFeRity/wmM0F9B913W+3kk0753GU2c/fMIR+g/Hk3ez
 xkG0w7Cscjw6OpGqqCzpJGdtC1pO/g0=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-FVR3mSJCNNafGPH7HJ7oqA-1; Fri, 24 Nov 2023 02:59:24 -0500
X-MC-Unique: FVR3mSJCNNafGPH7HJ7oqA-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-462a9b9b226so555293137.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 23:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700812763; x=1701417563;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gLtARen9NFM5l1dIUoVIYqSxTtITzDBQmerdXhBKSX4=;
 b=hHtXu5+RvqV7vNIveQE9ezLMoiy4DRTKd2HF29OL+r1bbkg+Nv3Fd6I+3xiKfGSnfW
 hJ++o3mZY0PWtk5AZmJ64NLJ50vE04LCyIVYdg/JnNtc3zXQxEQ7NL4Ayy78+YCa+6bv
 l03Tj1jXlsEMkS0cK2d51wD0vO0zTNn+7GVuimB3w9XdmTrI+YFCP1LTC4Iq5wI1OFwP
 Kzw+rlpdGQ4gunjUBI7qTlHfaXVmrdwwF7vDlM+7OL8bH8DoPhuzz0uMCagvsyN+cnzL
 eRUqNorvvLI0LhS6Ds1twe5WSKDlNH/yNaJ8iwclWpYBtcKdBYBJpIor+L0hPyZvl1ws
 dWNA==
X-Gm-Message-State: AOJu0YyWLUaVMSeJY+9siQRHPszZDgonYAYJ0L9lxuOWSCP/To9LY2DJ
 eRY87W0RA5YpXQ81066NWTNptF0OHlRkSC0vL2XkFKoYPceeHyR/ahQidm3cmiImEF5N7jnc59C
 322jDOe9YUeSb/Z4=
X-Received: by 2002:a67:bd12:0:b0:462:8087:6ad7 with SMTP id
 y18-20020a67bd12000000b0046280876ad7mr1851196vsq.17.1700812763696; 
 Thu, 23 Nov 2023 23:59:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ1RaqixTKejvG2Riia4FWzOeryPTtifRsL2yXIM4KgukNSAOlH4/yfB6QI10QS+4ERnw83Q==
X-Received: by 2002:a67:bd12:0:b0:462:8087:6ad7 with SMTP id
 y18-20020a67bd12000000b0046280876ad7mr1851181vsq.17.1700812763481; 
 Thu, 23 Nov 2023 23:59:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 qh1-20020a05620a668100b0077d72279828sm1070957qkn.23.2023.11.23.23.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 23:59:23 -0800 (PST)
Message-ID: <1df63b54-f93f-4f6d-a917-fab25b9f82bc@redhat.com>
Date: Fri, 24 Nov 2023 08:59:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc: Improve build for PPC VFIO
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
References: <20231123060109.131904-1-zhenzhong.duan@intel.com>
 <dd2db398-908a-46a8-b02b-8418956462cb@redhat.com>
 <8a95349c-4005-484f-b623-a1898a224896@linaro.org>
 <95739695-ce1d-458d-802d-91346cf10025@redhat.com>
In-Reply-To: <95739695-ce1d-458d-802d-91346cf10025@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Zhenzhong,

> How about what's below  instead ?
> 
> 
> Thanks,
> 
> C.

I will resend the build fix with the proposal below since it addresses
Phil's concerns.

Thanks,

C.

  
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -26,10 +26,12 @@
>   #include "hw/pci/pci_device.h"
>   #include "hw/vfio/vfio-common.h"
>   #include "qemu/error-report.h"
> +#include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
> 
>   /*
>    * Interfaces for IBM EEH (Enhanced Error Handling)
>    */
> +#ifdef CONFIG_VFIO_PCI
>   static bool vfio_eeh_container_ok(VFIOContainer *container)
>   {
>       /*
> @@ -314,3 +316,37 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
> 
>       return RTAS_OUT_SUCCESS;
>   }
> +
> +#else
> +
> +bool spapr_phb_eeh_available(SpaprPhbState *sphb)
> +{
> +    return false;
> +}
> +
> +void spapr_phb_vfio_reset(DeviceState *qdev)
> +{
> +}
> +
> +int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
> +                                  unsigned int addr, int option)
> +{
> +    return RTAS_OUT_NOT_SUPPORTED;
> +}
> +
> +int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
> +{
> +    return RTAS_OUT_NOT_SUPPORTED;
> +}
> +
> +int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
> +{
> +    return RTAS_OUT_NOT_SUPPORTED;
> +}
> +
> +int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
> +{
> +    return RTAS_OUT_NOT_SUPPORTED;
> +}
> +
> +#endif /* CONFIG_VFIO_PCI */






