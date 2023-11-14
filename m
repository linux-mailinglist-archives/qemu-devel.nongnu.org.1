Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD07EB30B
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:09:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2v1C-0005CA-NU; Tue, 14 Nov 2023 10:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r2v15-0005Bu-KX
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r2v0z-0005TF-Ru
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699974457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LB/JJQh9V14pijbW9fJ8JTrxjuuQoG1vCBysFfGnU44=;
 b=LQ1XUo2BxA/Afn4sq/pUu/kHIocW2deb8OXc0mH+JNrgbJpK/ltfuYjeVCwHfHZ7nqwr7V
 pqbGiEYReKEaJ/ehcE/mjz4BCHWZoEUcjwTE6KyrbufMZL4q2WbJt4GV/saAx2Cq5v1nHj
 360n7Ybs/rtrK8trCWvIo1Wi+RrOB2k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-NHF1Eb_IOCCd5LYlhht3cA-1; Tue,
 14 Nov 2023 10:07:35 -0500
X-MC-Unique: NHF1Eb_IOCCd5LYlhht3cA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE1732815E2B;
 Tue, 14 Nov 2023 15:07:33 +0000 (UTC)
Received: from [10.39.194.106] (unknown [10.39.194.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9B4E1C060B0;
 Tue, 14 Nov 2023 15:07:32 +0000 (UTC)
Message-ID: <1c0a094d-d2dd-9e93-8ef3-fdd0802c77cc@redhat.com>
Date: Tue, 14 Nov 2023 16:07:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1] target/i386/host-cpu: Use IOMMU addr width for
 passthrough devices on Intel platforms
Content-Language: en-US
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>
References: <20231113073239.270591-1-vivek.kasireddy@intel.com>
 <794ccd1e-a308-382f-dab7-438e2f62b8b4@redhat.com>
 <IA0PR11MB7185A5D525E42BEF95F6FEE8F8B2A@IA0PR11MB7185.namprd11.prod.outlook.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <IA0PR11MB7185A5D525E42BEF95F6FEE8F8B2A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/14/23 07:38, Kasireddy, Vivek wrote:
> Hi Laszlo,
> 
>>
>> On 11/13/23 08:32, Vivek Kasireddy wrote:
>>> A recent OVMF update has resulted in MMIO regions being placed at
>>> the upper end of the physical address space. As a result, when a
>>> Host device is passthrough'd to the Guest via VFIO, the following
>>> mapping failures occur when VFIO tries to map the MMIO regions of
>>> the device:
>>> VFIO_MAP_DMA failed: Invalid argument
>>> vfio_dma_map(0x557b2f2736d0, 0x380000000000, 0x1000000,
>> 0x7f98ac400000) = -22 (Invalid argument)
>>>
>>> The above failures are mainly seen on some Intel platforms where
>>> the physical address width is larger than the Host's IOMMU
>>> address width. In these cases, VFIO fails to map the MMIO regions
>>> because the IOVAs would be larger than the IOMMU aperture regions.
>>>
>>> Therefore, one way to solve this problem would be to ensure that
>>> cpu->phys_bits = <IOMMU phys_bits>
>>> This can be done by parsing the IOMMU caps value from sysfs and
>>> extracting the address width and using it to override the
>>> phys_bits value as shown in this patch.
>>>
>>> Previous attempt at solving this issue in OVMF:
>>> https://edk2.groups.io/g/devel/topic/102359124
>>>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>> Cc: Dongwon Kim <dongwon.kim@intel.com>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>  target/i386/host-cpu.c | 61
>> +++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 60 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
>>> index 92ecb7254b..8326ec95bc 100644
>>> --- a/target/i386/host-cpu.c
>>> +++ b/target/i386/host-cpu.c
>>> @@ -12,6 +12,8 @@
>>>  #include "host-cpu.h"
>>>  #include "qapi/error.h"
>>>  #include "qemu/error-report.h"
>>> +#include "qemu/config-file.h"
>>> +#include "qemu/option.h"
>>>  #include "sysemu/sysemu.h"
>>>
>>>  /* Note: Only safe for use on x86(-64) hosts */
>>> @@ -51,11 +53,58 @@ static void host_cpu_enable_cpu_pm(X86CPU
>> *cpu)
>>>      env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
>>>  }
>>>
>>> +static int intel_iommu_check(void *opaque, QemuOpts *opts, Error
>> **errp)
>>> +{
>>> +    g_autofree char *dev_path = NULL, *iommu_path = NULL, *caps = NULL;
>>> +    const char *driver = qemu_opt_get(opts, "driver");
>>> +    const char *device = qemu_opt_get(opts, "host");
>>> +    uint32_t *iommu_phys_bits = opaque;
>>> +    struct stat st;
>>> +    uint64_t iommu_caps;
>>> +
>>> +    /*
>>> +     * Check if the user is passthroughing any devices via VFIO. We don't
>>> +     * have to limit phys_bits if there are no valid passthrough devices.
>>> +     */
>>> +    if (g_strcmp0(driver, "vfio-pci") || !device) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    dev_path = g_strdup_printf("/sys/bus/pci/devices/%s", device);
>>> +    if (stat(dev_path, &st) < 0) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    iommu_path = g_strdup_printf("%s/iommu/intel-iommu/cap",
>> dev_path);
>>> +    if (stat(iommu_path, &st) < 0) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (g_file_get_contents(iommu_path, &caps, NULL, NULL)) {
>>> +        if (sscanf(caps, "%lx", &iommu_caps) != 1) {
>>> +            return 0;
>>> +        }
>>> +        *iommu_phys_bits = ((iommu_caps >> 16) & 0x3f) + 1;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static uint32_t host_iommu_phys_bits(void)
>>> +{
>>> +    uint32_t iommu_phys_bits = 0;
>>> +
>>> +    qemu_opts_foreach(qemu_find_opts("device"),
>>> +                      intel_iommu_check, &iommu_phys_bits, NULL);
>>> +    return iommu_phys_bits;
>>> +}
>>> +
>>>  static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>>>  {
>>>      uint32_t host_phys_bits = host_cpu_phys_bits();
>>> +    uint32_t iommu_phys_bits = host_iommu_phys_bits();
>>>      uint32_t phys_bits = cpu->phys_bits;
>>> -    static bool warned;
>>> +    static bool warned, warned2;
>>>
>>>      /*
>>>       * Print a warning if the user set it to a value that's not the
>>> @@ -78,6 +127,16 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU
>> *cpu)
>>>          }
>>>      }
>>>
>>> +    if (iommu_phys_bits && phys_bits > iommu_phys_bits) {
>>> +        phys_bits = iommu_phys_bits;
>>> +        if (!warned2) {
>>> +            warn_report("Using physical bits (%u)"
>>> +                        " to prevent VFIO mapping failures",
>>> +                        iommu_phys_bits);
>>> +            warned2 = true;
>>> +        }
>>> +    }
>>> +
>>>      return phys_bits;
>>>  }
>>>
>>
>> I only have very superficial comments here (sorry about that -- I find
>> it too bad that this QEMU source file seems to have no designated
>> reviewer or maintainer in QEMU, so I don't want to ignore it).
>>
>> - Terminology: I think we like to call these devices "assigned", and not
>> "passed through". Also, in noun form, "device assignment" and not
>> "device passthrough". Sorry about being pedantic.
> No problem; I'll try to start using the right terminology.
> 
>>
>> - As I (may have) mentioned in my OVMF comments, I'm unsure if narrowing
>> the VCPU "phys address bits" property due to host IOMMU limitations is a
>> good design. To me it feels like hacking one piece of information into
>> another (unrelated) piece of information. It vaguely makes me think
>> we're going to regret this later. But I don't have any specific, current
>> counter-argument, admittedly.
> The physical address space restriction is only applied if the user requests a VFIO
> assigned device but not in other general cases; which I think is somewhat
> reasonable. However, I do agree with you that this solution feels a bit lackluster.
> 
> AFAICS, since the main issue here is the placement of the MMIO window, I
> am wondering if we can address this specific issue. IIRC, prior to Gerd's patch,
> the MMIO base and size were both 32 GB and this seemed to have worked
> fine with VFIO-assigned devices.

This (default) placement and size were the consequence of the default
VCPU phys address width (allowing for a 64GB phys address space) and
that in most cases one wouldn't have large enough guest RAM (or a large
enough guest RAM hotplug range) to disturb this default.

In general, yes, it worked fine, but there were numerous exceptions too
where it didn't work. Especially GPU cards with huge BARs.

> So, I am wondering what are the pros and
> cons of keeping this behavior vs the new one.

The only motivation is user convenience. The explicit (albeit
experimental) fw_cfg works 100% well if we're willing to expose users to
manual tweaking. The alternative is to automate the calculations
*fully*. (It makes no sense, IMO, to unburden users "somewhat", in this
regard.)

In that sense, considering user experience, your patch is actually
great. On the other hand, it's not entirely sound from an engineering
perspective (IMO). I do feel we need a new information channel for this.

Laszlo


