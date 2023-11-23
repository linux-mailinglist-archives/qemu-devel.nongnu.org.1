Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1357F60B5
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 14:47:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6A1e-0005Ta-Vf; Thu, 23 Nov 2023 08:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r6A1c-0005T9-KF
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r6A1a-0005L7-GX
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700747145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCuThtsNr7tflPB5CyB9skz3YE4gb1nXx0L0m7ueqBo=;
 b=Jx1sHMkvJIBuWEm2MbW4AIEX8nBuiovsSsw+DEPD4uTndcvCuJLK5A/Xh4CR/lPRfMsHqT
 nIS5EEERBJEgMX5XVliaU0dS19uaShBdM7FJhiGWLf1YODlcbZH8sC38n2U63xMMbRGXeA
 R84HB5+IFHBUiCXKCwLUvizxGm5e5Dk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-ibv_WfkYNH6tpu0D8akrTQ-1; Thu, 23 Nov 2023 08:45:44 -0500
X-MC-Unique: ibv_WfkYNH6tpu0D8akrTQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6d345756155so843107a34.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 05:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700747143; x=1701351943;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCuThtsNr7tflPB5CyB9skz3YE4gb1nXx0L0m7ueqBo=;
 b=v/UzN1P74JRuB7d6uQ7MAJPmDC8BCLJrFl3lJmbvT8dO/0rETFaBA1AUve/pER0+Qh
 L8P2An4KhsA9cRciyStj+u4In5GjQQyReOL/BHmmsSjh8lMZcWJvhFldazQkwSW/Ctf3
 KvzNKx6zx0b3LQtumCrh9i+ztEdeU6uvHU/0AylK3fl7ZjeZnWsnOLcRqSJn7EchH1//
 Gg0JOgBNFsV6dhm03/CAvnGhTinwib0WjJU0kZn81E85/+kPmD2KTwYgxPPzBUbLkSE5
 lM3sR7cwzAGmRS/NdSFKlzYWw05isZ9H9vly3u2Zb+7MwBhTN12oTY4IrqoVl3m0FDQ7
 3UkQ==
X-Gm-Message-State: AOJu0YxWFakTcudPKGJ/J8dHJCbokmteaJraUEynu0P90vyFuiESkSTB
 BLekiRQhRBhlEMW+oq9T0lTDviuKAiYPHRuQN9wm3b27SjAPRNYVtPAjWNIIv9iIh4Pm9JKdTg6
 v6+FXqHLO53gTqj8=
X-Received: by 2002:a05:6871:a901:b0:1f9:dc00:7caa with SMTP id
 wn1-20020a056871a90100b001f9dc007caamr629210oab.18.1700747143326; 
 Thu, 23 Nov 2023 05:45:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFemMOhQ+LcBr0gU5AFUIQK6HPL9pBok3CUuYe7QXBmXfRbiFbqYuDGGBvIJ0mmfFmyYcvT/A==
X-Received: by 2002:a05:6871:a901:b0:1f9:dc00:7caa with SMTP id
 wn1-20020a056871a90100b001f9dc007caamr629195oab.18.1700747143037; 
 Thu, 23 Nov 2023 05:45:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 l5-20020ac87245000000b0041991642c62sm482960qtp.73.2023.11.23.05.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 05:45:42 -0800 (PST)
Message-ID: <95739695-ce1d-458d-802d-91346cf10025@redhat.com>
Date: Thu, 23 Nov 2023 14:45:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc: Improve build for PPC VFIO
Content-Language: en-US
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
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <8a95349c-4005-484f-b623-a1898a224896@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/23/23 11:19, Philippe Mathieu-Daudé wrote:
> Hi Cédric,
> 
> On 23/11/23 08:33, Cédric Le Goater wrote:
>> On 11/23/23 07:01, Zhenzhong Duan wrote:
>>> VFIO is not a required subsystem for the pseries machine but it's
>>> force enabled currently. When --without-default-devices is used
>>> to drop some default devices including vfio-pci, vfio core code
>>> is still kept which is unnecessary.
>>>
>>> Introduce a stub file to hold stub functions of VFIO EEH hooks,
>>> then vfio core could be compiled out.
>>>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>>
>> Nick,
>>
>> I will take this patch through the vfio tree if that's OK for you.
>>
>>> ---
>>> Based on vfio-next/vfio-8.2
>>>
>>>   hw/ppc/spapr_pci_vfio_stub.c | 33 +++++++++++++++++++++++++++++++++
>>>   hw/ppc/Kconfig               |  2 +-
>>>   hw/ppc/meson.build           |  6 +++---
>>>   3 files changed, 37 insertions(+), 4 deletions(-)
>>>   create mode 100644 hw/ppc/spapr_pci_vfio_stub.c
> 
> We are trying to remove stubs: instead of checking late in the callee,
> we shouldn't let the caller call functions depending on an unavailable
> feature. So I'm a bit reluctant with this patch.
>
> Can we add a simple 'bool pci_vfio_available(void);' helper? Or rework a
> bit. For example looking quickly, we already have:
> 
>      #ifdef CONFIG_LINUX
>      int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
>      #else
>      static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
>      {
>          return false;
>      }
>      #endif
> 
> This should be enough to protect the other calls.

The problem is that CONFIG_VFIO_PCI is not a target option and you can't
use the define as we do with CONFIG_LINUX. The define poisoning does its
job there.


> 
> Maybe we just need:> 
> -- >8 --
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -122,41 +122,20 @@ int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>                             void *fdt, int *fdt_start_offset, Error **errp);
> 
>   /* VFIO EEH hooks */
> -#ifdef CONFIG_LINUX
> +#if defined(CONFIG_LINUX) && defined(CONFIG_VFIO_PCI)
>   bool spapr_phb_eeh_available(SpaprPhbState *sphb);
> +#else
> +static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
> +{
> +    return false;
> +}
> +#endif
>   int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
>                                     unsigned int addr, int option);
>   int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state);
>   int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
>   int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
>   void spapr_phb_vfio_reset(DeviceState *qdev);
> -#else
> -static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
> -{
> -    return false;
> -}
> -static inline int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
> -                                                unsigned int addr, int option)
> -{
> -    return RTAS_OUT_HW_ERROR;
> -}
> -static inline int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb,
> -                                               int *state)
> -{
> -    return RTAS_OUT_HW_ERROR;
> -}
> -static inline int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
> -{
> -    return RTAS_OUT_HW_ERROR;
> -}
> -static inline int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
> -{
> -    return RTAS_OUT_HW_ERROR;
> -}
> -static inline void spapr_phb_vfio_reset(DeviceState *qdev)
> -{
> -}
> -#endif
> 
>   void spapr_phb_dma_reset(SpaprPhbState *sphb);
> ---
> 
> and massage a bit the calls not protected by spapr_phb_eeh_available().

How about what's below  instead ?


Thanks,

C.



--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -26,10 +26,12 @@
  #include "hw/pci/pci_device.h"
  #include "hw/vfio/vfio-common.h"
  #include "qemu/error-report.h"
+#include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
  
  /*
   * Interfaces for IBM EEH (Enhanced Error Handling)
   */
+#ifdef CONFIG_VFIO_PCI
  static bool vfio_eeh_container_ok(VFIOContainer *container)
  {
      /*
@@ -314,3 +316,37 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
  
      return RTAS_OUT_SUCCESS;
  }
+
+#else
+
+bool spapr_phb_eeh_available(SpaprPhbState *sphb)
+{
+    return false;
+}
+
+void spapr_phb_vfio_reset(DeviceState *qdev)
+{
+}
+
+int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
+                                  unsigned int addr, int option)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+#endif /* CONFIG_VFIO_PCI */



