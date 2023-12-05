Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BAE805B43
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 18:44:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAZS2-00087p-CF; Tue, 05 Dec 2023 12:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rAZRz-00086x-KU
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rAZRx-0000Pv-0h
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701798188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhPK9lPuEu1Tjk9dz8JEVxTHlnsUJEkABxPYnbpOYRQ=;
 b=B2lRNVVb/CSxnVmdKF+xg98wh4TQBgm1v5A3QtCxUaRuOFy8j/4gW17NJYCGtCC1iRSOEW
 IikcqGB6LTE9I/lTssQBsZutyfS0GJLsUHMwRe3AjEGpus6wpAkppd1yMUxgyLuDOx0j2v
 IcHZIsp4NGAAqrbZCT2CaP8KhayfRe0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-QToKnJDNMgy_EuyK1k-gzw-1; Tue, 05 Dec 2023 12:42:57 -0500
X-MC-Unique: QToKnJDNMgy_EuyK1k-gzw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3333aaf02b0so3187863f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 09:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701798176; x=1702402976;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BhPK9lPuEu1Tjk9dz8JEVxTHlnsUJEkABxPYnbpOYRQ=;
 b=nx8A9TzS2jY0x83YG/YuI4Ons4ya3Zn1nF3jMVz3/Xfm3BRWSXyfrm/AddvVs03YCe
 CyYtVLicI9RbSvv4PRiKffhVZr9yKrppAbrdZGIipt0qI6ogfkXXCb3+w40zY9JLwssp
 KQUKC/rS1g7kXpZFR2zRi2x/fQbLmvN0x6+Ejp2+1r8fSHow94fNtamUnTy7RUxjhGW7
 J39cE0PtGmIyfqKj9iQBjq3MLr/0RxK+/A3kOt8ip/yrVVcOkMqQMlw8a13qXFEsFYQ4
 pYBt9iqPQJQOwDEB3obJ84+q/Zw5GY+4ymfV0fCGBBUgC2I8IuCKKqTDoVslZA5PiCfV
 ov7g==
X-Gm-Message-State: AOJu0Yzj9XETKppw7D0wz1AeMTAER/YxrYSrfOybANpQIygYoO0fPXL6
 K2Rda8xT2/gSkiEh/JC7NenkRfAZfN/MMDy3Y+0mWsTmhebYa07nUPdhMuvIuBKMAW0pTsb2AkG
 tjzIZ+p1SOoMinUg=
X-Received: by 2002:a05:600c:1f88:b0:40b:5e4a:4073 with SMTP id
 je8-20020a05600c1f8800b0040b5e4a4073mr748755wmb.147.1701798176293; 
 Tue, 05 Dec 2023 09:42:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+FJ/LzShh/0WO2SV7dJ74dDQuCvaU+6w/IrM2aknFdX4ulHxUM/yKYdBfY1mTx1A/yY7WOA==
X-Received: by 2002:a05:600c:1f88:b0:40b:5e4a:4073 with SMTP id
 je8-20020a05600c1f8800b0040b5e4a4073mr748740wmb.147.1701798175928; 
 Tue, 05 Dec 2023 09:42:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a05600c155100b004083729fc14sm23055664wmg.20.2023.12.05.09.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Dec 2023 09:42:55 -0800 (PST)
Message-ID: <0e8ee2a6-c0b5-4edc-a616-1f6c3f00beaf@redhat.com>
Date: Tue, 5 Dec 2023 18:42:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386/host-cpu: Use IOMMU addr width for
 passthrough devices on Intel platforms
Content-Language: en-US
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>
References: <20231113073239.270591-1-vivek.kasireddy@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231113073239.270591-1-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
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

On 11/13/23 08:32, Vivek Kasireddy wrote:
> A recent OVMF update has resulted in MMIO regions being placed at
> the upper end of the physical address space. As a result, when a
> Host device is passthrough'd to the Guest via VFIO, the following
> mapping failures occur when VFIO tries to map the MMIO regions of
> the device:
> VFIO_MAP_DMA failed: Invalid argument
> vfio_dma_map(0x557b2f2736d0, 0x380000000000, 0x1000000, 0x7f98ac400000) = -22 (Invalid argument)

OVMF and Seabios guests are impacted. Seabios 1.16.3 introduced
the same change of the pci window placement.

C.

> The above failures are mainly seen on some Intel platforms where
> the physical address width is larger than the Host's IOMMU
> address width. In these cases, VFIO fails to map the MMIO regions
> because the IOVAs would be larger than the IOMMU aperture regions.
> 
> Therefore, one way to solve this problem would be to ensure that
> cpu->phys_bits = <IOMMU phys_bits>
> This can be done by parsing the IOMMU caps value from sysfs and
> extracting the address width and using it to override the
> phys_bits value as shown in this patch.
> 
> Previous attempt at solving this issue in OVMF:
> https://edk2.groups.io/g/devel/topic/102359124
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   target/i386/host-cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 92ecb7254b..8326ec95bc 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -12,6 +12,8 @@
>   #include "host-cpu.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> +#include "qemu/config-file.h"
> +#include "qemu/option.h"
>   #include "sysemu/sysemu.h"
>   
>   /* Note: Only safe for use on x86(-64) hosts */
> @@ -51,11 +53,58 @@ static void host_cpu_enable_cpu_pm(X86CPU *cpu)
>       env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
>   }
>   
> +static int intel_iommu_check(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    g_autofree char *dev_path = NULL, *iommu_path = NULL, *caps = NULL;
> +    const char *driver = qemu_opt_get(opts, "driver");
> +    const char *device = qemu_opt_get(opts, "host");
> +    uint32_t *iommu_phys_bits = opaque;
> +    struct stat st;
> +    uint64_t iommu_caps;
> +
> +    /*
> +     * Check if the user is passthroughing any devices via VFIO. We don't
> +     * have to limit phys_bits if there are no valid passthrough devices.
> +     */
> +    if (g_strcmp0(driver, "vfio-pci") || !device) {
> +        return 0;
> +    }
> +
> +    dev_path = g_strdup_printf("/sys/bus/pci/devices/%s", device);
> +    if (stat(dev_path, &st) < 0) {
> +        return 0;
> +    }
> +
> +    iommu_path = g_strdup_printf("%s/iommu/intel-iommu/cap", dev_path);
> +    if (stat(iommu_path, &st) < 0) {
> +        return 0;
> +    }
> +
> +    if (g_file_get_contents(iommu_path, &caps, NULL, NULL)) {
> +        if (sscanf(caps, "%lx", &iommu_caps) != 1) {
> +            return 0;
> +        }
> +        *iommu_phys_bits = ((iommu_caps >> 16) & 0x3f) + 1;
> +    }
> +
> +    return 0;
> +}
> +
> +static uint32_t host_iommu_phys_bits(void)
> +{
> +    uint32_t iommu_phys_bits = 0;
> +
> +    qemu_opts_foreach(qemu_find_opts("device"),
> +                      intel_iommu_check, &iommu_phys_bits, NULL);
> +    return iommu_phys_bits;
> +}
> +
>   static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>   {
>       uint32_t host_phys_bits = host_cpu_phys_bits();
> +    uint32_t iommu_phys_bits = host_iommu_phys_bits();
>       uint32_t phys_bits = cpu->phys_bits;
> -    static bool warned;
> +    static bool warned, warned2;
>   
>       /*
>        * Print a warning if the user set it to a value that's not the
> @@ -78,6 +127,16 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>           }
>       }
>   
> +    if (iommu_phys_bits && phys_bits > iommu_phys_bits) {
> +        phys_bits = iommu_phys_bits;
> +        if (!warned2) {
> +            warn_report("Using physical bits (%u)"
> +                        " to prevent VFIO mapping failures",
> +                        iommu_phys_bits);
> +            warned2 = true;
> +        }
> +    }
> +
>       return phys_bits;
>   }
>   


