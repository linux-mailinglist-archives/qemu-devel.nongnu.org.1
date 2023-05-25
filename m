Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DD97109DB
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:17:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q280N-0003Tb-26; Thu, 25 May 2023 06:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q280L-0003Sz-Tj
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:15:33 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q280J-0005TL-4i
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:15:33 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-970028cfb6cso81522766b.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685009711; x=1687601711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W/kc5TwXbfL7YxMsakEEY5OHPKQY36Pjs54a1ei2hJM=;
 b=H0P4RNxBitBcq5y3MbDQ5xDQ0ixDbxb9p4AED9Tt8zCVLn5BoU8y/gCXKmtlc0t8yV
 gbQCdQJ0x7b4et/7uf9Auwp/mzH6R8kB+R0dFPbX+p1eEA1a6rYs3BoE8orZwWrRokt/
 64VgzvndlRWlB/Av7ENI24LpgTQMuqvu076mZZaUw6i/dHpMUOJJxyYOii7EdNFEsQtW
 Y9ak4I+JUukVrItZ9LOwadHXQJ+Zq91teW6gOL//telceSPEJYOoCpTNY3LXXRHe7lg8
 dvsv34L+b2ot04m98DTh3DK+EYCOR0CLoJVhM+ofwLnLXHSvDIitom14pDgq7aaWiemY
 iqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685009711; x=1687601711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W/kc5TwXbfL7YxMsakEEY5OHPKQY36Pjs54a1ei2hJM=;
 b=LQbcSpivCgvIKll+NL/miFqupQ+dxc2RkIPp0EcZKDgXu1kKEocXVPALnj2OjFks7X
 h3EKC1JSV7uWVeQIVvD7PCMJcUFSWaqHwOsFwa7U+M7KQoiuN62eLavM9uud2tUsTRb3
 ILw5xQqxvJGLYmz+1QCq37QZlYPJqLJAA8VAHupA7q69Za9v/WYIWw3yBHqloCAhHqib
 A+Zu3NT+7nM9DYunp6LAvJHbCOg0HmAP2Fi+rTnFQyNyWIO9zV1E7JggKjWm9XAwJPam
 UJ2foaqn6aFI7wLqWy7LtQlSKu7/sGa36VzMbtIVHC6tXkWN6nKzMyADMliXBUnYf4QU
 FI7g==
X-Gm-Message-State: AC+VfDzy8KgSphgYEf8pmNbRuwYsQTRBJ+lFLyo0EAb2ISvdQ8Dhei8I
 UhEJTHPRj0jlbt9dOrdJEg7vN1oI3nLLarO0XoQUqg==
X-Google-Smtp-Source: ACHHUZ5Z0nJhptusFOI91hWVj71wNc8hrT+ypa5Dz6dogKH9Yq61OM29aBbizKGKnfLeE9NqjsXg+xmY/U1nSVdOLlQ=
X-Received: by 2002:a17:907:940f:b0:973:84af:66e5 with SMTP id
 dk15-20020a170907940f00b0097384af66e5mr951023ejc.40.1685009711402; Thu, 25
 May 2023 03:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230524111413.833912-1-marcin.juszkiewicz@linaro.org>
 <20230524111413.833912-3-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230524111413.833912-3-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 11:15:00 +0100
Message-ID: <CAFEAcA8_f9Vo+i2PfRvMC2+5=omNi+7Z=0K=oRutgsuvNdOUDA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] Add Bochs to list of vga_interfaces
To: marcin.juszkiewicz@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 24 May 2023 at 12:14, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> arm/sbsa-ref uses Bochs-display graphics card and without it being
> present in vga_interfaces "-vga none" argument handling cannot be added.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>  hw/pci/pci.c            | 2 ++
>  include/sysemu/sysemu.h | 2 +-
>  softmmu/vl.c            | 6 ++++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1cc7c89036..edac76ea15 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1937,6 +1937,8 @@ PCIDevice *pci_vga_init(PCIBus *bus)
>          return pci_create_simple(bus, -1, "vmware-svga");
>      case VGA_VIRTIO:
>          return pci_create_simple(bus, -1, "virtio-vga");
> +    case VGA_BOCHS:
> +        return pci_create_simple(bus, -1, "bochs-display");
>      case VGA_NONE:
>      default: /* Other non-PCI types. Checking for unsupported types is already
>                  done in vl.c. */
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 25be2a692e..9713a1b470 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -29,7 +29,7 @@ extern int autostart;
>
>  typedef enum {
>      VGA_NONE, VGA_STD, VGA_CIRRUS, VGA_VMWARE, VGA_XENFB, VGA_QXL,
> -    VGA_TCX, VGA_CG3, VGA_DEVICE, VGA_VIRTIO,
> +    VGA_TCX, VGA_CG3, VGA_DEVICE, VGA_VIRTIO, VGA_BOCHS,
>      VGA_TYPE_MAX,
>  } VGAInterfaceType;

Is it really right that we want to add more support to this
legacy-command-line-option interface? We don't list every
graphics device we support here...

-- PMM

