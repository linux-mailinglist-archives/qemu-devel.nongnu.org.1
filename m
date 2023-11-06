Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F23D27E2B0A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:38:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03XY-00036D-5w; Mon, 06 Nov 2023 12:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03XW-00035b-Er
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:37:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03XU-0004nO-6X
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699292247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Yc7PeFCU0CsA+AOy0eU/7WBanKWsxZ4xWf9S01nHrs=;
 b=ii7dRpMzPTTEpbtbjNIfo8Gg4/dCRgEQ9HeYlWrSTIc2Lai3dGaQQq0FNRkIqTgc4g6vh+
 Nylzp73sRKysBx90ZhdJR00k20PcmhXVDY50b1wZAuJ5qkqw6otX2yOkaaJCrBIP8tV66L
 B8g1zmCifwYJfi9b881Zg/Yq3+SWRzE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-eu9C-cJNPWO0eMLcBj-sWQ-1; Mon, 06 Nov 2023 12:37:16 -0500
X-MC-Unique: eu9C-cJNPWO0eMLcBj-sWQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4090181eec2so29937845e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699292235; x=1699897035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Yc7PeFCU0CsA+AOy0eU/7WBanKWsxZ4xWf9S01nHrs=;
 b=jBlI+jQzvMw8EqsdsGiZJCJqork9rxP84rzQYg2jx79rkxgnabwpiKzAYMrCXhSDCJ
 afLLCxOj9MZLzN21PqFwip2ZDkb2ef8SXD9ozkHpunOfQAAFSAu+bX7o1HtjcPWenqmA
 WVUI3beSHw4Vi6dScdYZS/RtuyagqwTO/bCBtaqAEDV4XTTurr03SxDVQk0zAwkZ3RIv
 acWGVxtixDOIPKPM7HCwlrMbZ6731FlrGayOSpYhVxTaqbEwph0fsyjbyocU/12eHkXX
 DW2OI0S6yrfAAtqdye939jgyPSCdMi2H7XiwtV1Ur8pU+BjDbe8o1lasKak/CeXsYYUL
 XYWA==
X-Gm-Message-State: AOJu0YzoSRngmsTIrCVQnEQYZ4MZFd+S5YavPG58ml6jaLDi2s5VWDyW
 rZGD4IZb4xEZss6RLXOEFxu+JX7o5Ft83e/USYnG3HG0bscKhJCTht2cSmXT5TUOr+oSSQxuC/h
 vasOhaUUlV4KO+KQ=
X-Received: by 2002:a05:600c:458f:b0:409:136:469f with SMTP id
 r15-20020a05600c458f00b004090136469fmr324869wmo.38.1699292235084; 
 Mon, 06 Nov 2023 09:37:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHdxUlE7xACG9wivuVjItA2jDc4nUuugk+E6Dw0ezUTl90BQfT35vT1iylr9lBahHyKyboxg==
X-Received: by 2002:a05:600c:458f:b0:409:136:469f with SMTP id
 r15-20020a05600c458f00b004090136469fmr324822wmo.38.1699292234614; 
 Mon, 06 Nov 2023 09:37:14 -0800 (PST)
Received: from redhat.com ([5.102.242.158]) by smtp.gmail.com with ESMTPSA id
 a11-20020a05600c348b00b0040813e14b49sm13297482wmq.30.2023.11.06.09.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 09:37:14 -0800 (PST)
Date: Mon, 6 Nov 2023 12:37:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [PATCH v7 10/13] hw/pci-host/gpex: Define properties for MMIO
 ranges
Message-ID: <20231106123605-mutt-send-email-mst@kernel.org>
References: <20231103031649.2769834-1-sunilvl@ventanamicro.com>
 <20231103031649.2769834-11-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103031649.2769834-11-sunilvl@ventanamicro.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Nov 03, 2023 at 08:46:46AM +0530, Sunil V L wrote:
> ACPI DSDT generator needs information like ECAM range, PIO range, 32-bit
> and 64-bit PCI MMIO range etc related to the PCI host bridge. Instead of
> making these values machine specific, create properties for the GPEX
> host bridge with default value 0. During initialization, the firmware
> can initialize these properties with correct values for the platform.
> This basically allows DSDT generator code independent of the machine
> specific memory map accesses.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/pci-host/gpex-acpi.c    | 13 +++++++++++++
>  hw/pci-host/gpex.c         | 12 ++++++++++++
>  include/hw/pci-host/gpex.h | 28 ++++++++++++++++++++--------
>  3 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 1092dc3b70..f69413ea2c 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -281,3 +281,16 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>  
>      crs_range_set_free(&crs_range_set);
>  }
> +
> +void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq)
> +{
> +    bool ambig;
> +    Object *obj = object_resolve_path_type("", TYPE_GPEX_HOST, &ambig);
> +
> +    if (!obj || ambig) {
> +        return;
> +    }
> +
> +    GPEX_HOST(obj)->gpex_cfg.irq = irq;
> +    acpi_dsdt_add_gpex(scope, &GPEX_HOST(obj)->gpex_cfg);
> +}
> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index a6752fac5e..41f4e73f6e 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -154,6 +154,18 @@ static Property gpex_host_properties[] = {
>       */
>      DEFINE_PROP_BOOL("allow-unmapped-accesses", GPEXHost,
>                       allow_unmapped_accesses, true),
> +    DEFINE_PROP_UINT64(PCI_HOST_ECAM_BASE, GPEXHost, gpex_cfg.ecam.base, 0),
> +    DEFINE_PROP_SIZE(PCI_HOST_ECAM_SIZE, GPEXHost, gpex_cfg.ecam.size, 0),
> +    DEFINE_PROP_UINT64(PCI_HOST_PIO_BASE, GPEXHost, gpex_cfg.pio.base, 0),
> +    DEFINE_PROP_SIZE(PCI_HOST_PIO_SIZE, GPEXHost, gpex_cfg.pio.size, 0),
> +    DEFINE_PROP_UINT64(PCI_HOST_BELOW_4G_MMIO_BASE, GPEXHost,
> +                       gpex_cfg.mmio32.base, 0),
> +    DEFINE_PROP_SIZE(PCI_HOST_BELOW_4G_MMIO_SIZE, GPEXHost,
> +                     gpex_cfg.mmio32.size, 0),
> +    DEFINE_PROP_UINT64(PCI_HOST_ABOVE_4G_MMIO_BASE, GPEXHost,
> +                       gpex_cfg.mmio64.base, 0),
> +    DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MMIO_SIZE, GPEXHost,
> +                     gpex_cfg.mmio64.size, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index b0240bd768..441c6b8b20 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -40,6 +40,15 @@ struct GPEXRootState {
>      /*< public >*/
>  };
>  
> +struct GPEXConfig {
> +    MemMapEntry ecam;
> +    MemMapEntry mmio32;
> +    MemMapEntry mmio64;
> +    MemMapEntry pio;
> +    int         irq;
> +    PCIBus      *bus;
> +};
> +
>  struct GPEXHost {
>      /*< private >*/
>      PCIExpressHost parent_obj;
> @@ -55,19 +64,22 @@ struct GPEXHost {
>      int irq_num[GPEX_NUM_IRQS];
>  
>      bool allow_unmapped_accesses;
> -};
>  
> -struct GPEXConfig {
> -    MemMapEntry ecam;
> -    MemMapEntry mmio32;
> -    MemMapEntry mmio64;
> -    MemMapEntry pio;
> -    int         irq;
> -    PCIBus      *bus;
> +    struct GPEXConfig gpex_cfg;
>  };
>  
>  int gpex_set_irq_num(GPEXHost *s, int index, int gsi);
>  
>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg);
> +void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq);
> +
> +#define PCI_HOST_PIO_BASE               "pio-base"
> +#define PCI_HOST_PIO_SIZE               "pio-size"
> +#define PCI_HOST_ECAM_BASE              "ecam-base"
> +#define PCI_HOST_ECAM_SIZE              "ecam-size"
> +#define PCI_HOST_BELOW_4G_MMIO_BASE     "below-4g-mmio-base"
> +#define PCI_HOST_BELOW_4G_MMIO_SIZE     "below-4g-mmio-size"
> +#define PCI_HOST_ABOVE_4G_MMIO_BASE     "above-4g-mmio-base"
> +#define PCI_HOST_ABOVE_4G_MMIO_SIZE     "above-4g-mmio-size"

If there's no reason to allow users to tweak these directly
then I think we should prefix these with "x-" so users know
we don't commit to these as a stable API. Right?


>  #endif /* HW_GPEX_H */
> -- 
> 2.39.2


