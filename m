Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCBF7E98F7
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 10:31:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2TGP-0006Lf-4q; Mon, 13 Nov 2023 04:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r2TGL-0006LN-3H
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r2TGJ-0000Oh-0T
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699867778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiUpzHnxLAI5dfB2FZ90GiWw1smvGOeVwoZ+VUCBCdE=;
 b=fT181Z46YhfZHo/kSjJBxoNpQfg4zIoYz5M1lydurqStdv3Bb8LmZxYHkC0Re+0yoi06F9
 UKbCpzQIpFMUmFofR21XhwZsDBcRelN7IFUEOkOTnAVCCtZ77VfIC1Zciay1UJiFKdgn1d
 GD8x6JZQ1vzgzyyth+EnzbEhkWaLk50=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-xHvAbUkxOYSyWGKtlRcTKA-1; Mon,
 13 Nov 2023 04:29:36 -0500
X-MC-Unique: xHvAbUkxOYSyWGKtlRcTKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01BAF3815F62;
 Mon, 13 Nov 2023 09:29:36 +0000 (UTC)
Received: from [10.39.192.220] (unknown [10.39.192.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A1838B;
 Mon, 13 Nov 2023 09:29:34 +0000 (UTC)
Message-ID: <794ccd1e-a308-382f-dab7-438e2f62b8b4@redhat.com>
Date: Mon, 13 Nov 2023 10:29:33 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1] target/i386/host-cpu: Use IOMMU addr width for
 passthrough devices on Intel platforms
Content-Language: en-US
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>
References: <20231113073239.270591-1-vivek.kasireddy@intel.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231113073239.270591-1-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> 
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
>  target/i386/host-cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 92ecb7254b..8326ec95bc 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -12,6 +12,8 @@
>  #include "host-cpu.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "qemu/config-file.h"
> +#include "qemu/option.h"
>  #include "sysemu/sysemu.h"
>  
>  /* Note: Only safe for use on x86(-64) hosts */
> @@ -51,11 +53,58 @@ static void host_cpu_enable_cpu_pm(X86CPU *cpu)
>      env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
>  }
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
>  static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>  {
>      uint32_t host_phys_bits = host_cpu_phys_bits();
> +    uint32_t iommu_phys_bits = host_iommu_phys_bits();
>      uint32_t phys_bits = cpu->phys_bits;
> -    static bool warned;
> +    static bool warned, warned2;
>  
>      /*
>       * Print a warning if the user set it to a value that's not the
> @@ -78,6 +127,16 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>          }
>      }
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
>      return phys_bits;
>  }
>  

I only have very superficial comments here (sorry about that -- I find
it too bad that this QEMU source file seems to have no designated
reviewer or maintainer in QEMU, so I don't want to ignore it).

- Terminology: I think we like to call these devices "assigned", and not
"passed through". Also, in noun form, "device assignment" and not
"device passthrough". Sorry about being pedantic.

- As I (may have) mentioned in my OVMF comments, I'm unsure if narrowing
the VCPU "phys address bits" property due to host IOMMU limitations is a
good design. To me it feels like hacking one piece of information into
another (unrelated) piece of information. It vaguely makes me think
we're going to regret this later. But I don't have any specific, current
counter-argument, admittedly.

Laszlo


