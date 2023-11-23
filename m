Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBFD7F5C25
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:19:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66nm-0001Uw-SN; Thu, 23 Nov 2023 05:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r66nk-0001U5-4J
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:19:16 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r66nh-0001Tw-7b
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:19:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso4426335e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 02:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700734751; x=1701339551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oiuhAmiPCNPLAl6SV6fWJ1l3AmCIo+nRAa7ovVZMvIM=;
 b=A3qzDpax5vqi5ti5u/6pz1ERFzivzpd6ZJLfZb+CHQK1k4b3PkURGbz4jq6KVE1CNj
 8m7Cqu5+63WlniXvSzYpf+U0yno2tAnd4v9nhOzAilYiwDJ4Vie5UQiLdlM8zKi8JlmU
 cwlB1/2rEB8URJ45tzY/HcKajDTvtJinvh9EfHNS0wB1uVO7m/I+FO1/NNURvzmwg43L
 MaHf0SpTEHzXSiCVmywvMfo0HTE5cy5lhQqFvoEp0phsMtP+K9Kb577QWWazEJ1H9LoN
 LdeCEZyhcg6892GyErZzm+Fln6jSAuH9Vm1tj/Ok9Z45Q4l/JYBSuOmuHXMy4OFyrs3G
 7TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700734751; x=1701339551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oiuhAmiPCNPLAl6SV6fWJ1l3AmCIo+nRAa7ovVZMvIM=;
 b=XitN9F7nororrKJTYzfFIz8Qda1t6LT9mE+qPak2d0HRQ4fpABM/EgfhFcrjoauf2V
 JFqKBOq4mvMqmmPf7UqOXIwqOCX2X0sLMIEuCTw/jtdjam8MRRKaIoJ+150NcDIiIF+l
 O3DMNf02R8vi8pXYDwN6B61S8D4rKdi+pP5UFFLp6f7Pl5yj/J3ERP+vC7JMP2dRv0WG
 Stwev6hDfrbC3q4ERXg7WswKBgeXlZch9ETX9Eg3v9pEBYsFIaVOUZ0Ixs/Y7/TugMQy
 0rF/PJ23WfNrgkFf/wHMG0AK0gs6Xw3fp5Pjy8Cd8Tf1sVJmxgL0LEMpbIM/Y1jv8hde
 NqXg==
X-Gm-Message-State: AOJu0YwW2nUEHpPtYQhCCgmWOPzP6NSutw3+ihaYpjMG4g3FwQ+LoDey
 AhVb2cA9RKhqw31KMlZP5CfArQ==
X-Google-Smtp-Source: AGHT+IEe1LdxD6bwxdF0MBoQibjI6caPLTpWt0N806V1QbwKGHmMMNpjvl4CZTP6j4E4U4G1KLw6Ow==
X-Received: by 2002:a05:600c:310d:b0:405:40c6:2ba4 with SMTP id
 g13-20020a05600c310d00b0040540c62ba4mr3660744wmo.5.1700734750967; 
 Thu, 23 Nov 2023 02:19:10 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c358c00b0040b338b055fsm2170664wmq.18.2023.11.23.02.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 02:19:10 -0800 (PST)
Message-ID: <8a95349c-4005-484f-b623-a1898a224896@linaro.org>
Date: Thu, 23 Nov 2023 11:19:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc: Improve build for PPC VFIO
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
References: <20231123060109.131904-1-zhenzhong.duan@intel.com>
 <dd2db398-908a-46a8-b02b-8418956462cb@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dd2db398-908a-46a8-b02b-8418956462cb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Cédric,

On 23/11/23 08:33, Cédric Le Goater wrote:
> On 11/23/23 07:01, Zhenzhong Duan wrote:
>> VFIO is not a required subsystem for the pseries machine but it's
>> force enabled currently. When --without-default-devices is used
>> to drop some default devices including vfio-pci, vfio core code
>> is still kept which is unnecessary.
>>
>> Introduce a stub file to hold stub functions of VFIO EEH hooks,
>> then vfio core could be compiled out.
>>
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> 
> Nick,
> 
> I will take this patch through the vfio tree if that's OK for you.
> 
>> ---
>> Based on vfio-next/vfio-8.2
>>
>>   hw/ppc/spapr_pci_vfio_stub.c | 33 +++++++++++++++++++++++++++++++++
>>   hw/ppc/Kconfig               |  2 +-
>>   hw/ppc/meson.build           |  6 +++---
>>   3 files changed, 37 insertions(+), 4 deletions(-)
>>   create mode 100644 hw/ppc/spapr_pci_vfio_stub.c

We are trying to remove stubs: instead of checking late in the callee,
we shouldn't let the caller call functions depending on an unavailable
feature. So I'm a bit reluctant with this patch.

Can we add a simple 'bool pci_vfio_available(void);' helper? Or rework a
bit. For example looking quickly, we already have:

     #ifdef CONFIG_LINUX
     int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
     #else
     static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
     {
         return false;
     }
     #endif

This should be enough to protect the other calls.

Maybe we just need:

-- >8 --
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -122,41 +122,20 @@ int spapr_pci_dt_populate(SpaprDrc *drc, 
SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **errp);

  /* VFIO EEH hooks */
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_LINUX) && defined(CONFIG_VFIO_PCI)
  bool spapr_phb_eeh_available(SpaprPhbState *sphb);
+#else
+static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
+{
+    return false;
+}
+#endif
  int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
                                    unsigned int addr, int option);
  int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state);
  int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
  int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
  void spapr_phb_vfio_reset(DeviceState *qdev);
-#else
-static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
-{
-    return false;
-}
-static inline int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
-                                                unsigned int addr, int 
option)
-{
-    return RTAS_OUT_HW_ERROR;
-}
-static inline int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb,
-                                               int *state)
-{
-    return RTAS_OUT_HW_ERROR;
-}
-static inline int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
-{
-    return RTAS_OUT_HW_ERROR;
-}
-static inline int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
-{
-    return RTAS_OUT_HW_ERROR;
-}
-static inline void spapr_phb_vfio_reset(DeviceState *qdev)
-{
-}
-#endif

  void spapr_phb_dma_reset(SpaprPhbState *sphb);
---

and massage a bit the calls not protected by spapr_phb_eeh_available().

>> diff --git a/hw/ppc/spapr_pci_vfio_stub.c b/hw/ppc/spapr_pci_vfio_stub.c
>> new file mode 100644
>> index 0000000000..adb3fb5e35
>> --- /dev/null
>> +++ b/hw/ppc/spapr_pci_vfio_stub.c
>> @@ -0,0 +1,33 @@
>> +#include "qemu/osdep.h"
>> +#include "hw/pci-host/spapr.h"
>> +
>> +bool spapr_phb_eeh_available(SpaprPhbState *sphb)
>> +{
>> +    return false;
>> +}
>> +
>> +void spapr_phb_vfio_reset(DeviceState *qdev)
>> +{
>> +}
>> +
>> +int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
>> +                                  unsigned int addr, int option)
>> +{
>> +    return RTAS_OUT_NOT_SUPPORTED;
>> +}
>> +
>> +int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
>> +{
>> +    return RTAS_OUT_NOT_SUPPORTED;
>> +}
>> +
>> +int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
>> +{
>> +    return RTAS_OUT_NOT_SUPPORTED;
>> +}
>> +
>> +int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
>> +{
>> +    return RTAS_OUT_NOT_SUPPORTED;
>> +}
>> +
>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>> index edc6d2d139..b8dabdbfbe 100644
>> --- a/hw/ppc/Kconfig
>> +++ b/hw/ppc/Kconfig
>> @@ -3,11 +3,11 @@ config PSERIES
>>       imply PCI_DEVICES
>>       imply TEST_DEVICES
>>       imply VIRTIO_VGA
>> +    imply VFIO if LINUX   # needed by spapr_pci_vfio.c
> 
> Zhenzhong,
> 
> I changed VFIO to VFIO_PCI because PPC only supports this type
> of passthrough devices.
> 
> With that,
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks,
> 
> C.
> 
> 
> 
>>       select NVDIMM
>>       select DIMM
>>       select PCI
>>       select SPAPR_VSCSI
>> -    select VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c
>>       select XICS
>>       select XIVE
>>       select MSI_NONBROKEN
>> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
>> index ea44856d43..2df5db2eef 100644
>> --- a/hw/ppc/meson.build
>> +++ b/hw/ppc/meson.build
>> @@ -34,9 +34,9 @@ ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], 
>> if_true: files(
>>     'spapr_softmmu.c',
>>   ))
>>   ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
>> -ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_LINUX'], if_true: files(
>> -  'spapr_pci_vfio.c',
>> -))
>> +ppc_ss.add(when: [ 'CONFIG_VFIO_PCI', 'CONFIG_PSERIES', 'CONFIG_LINUX'],
>> +           if_true: files('spapr_pci_vfio.c'),
>> +           if_false: files('spapr_pci_vfio_stub.c'))
>>   # IBM PowerNV
>>   ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
> 
> 


