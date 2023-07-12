Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 130C0750520
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 12:49:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJXOf-0003bU-BH; Wed, 12 Jul 2023 06:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJXOb-0003bF-D3
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 06:48:34 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJXOX-0006NR-SM
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 06:48:32 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fb5bcb9a28so10672327e87.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 03:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689158907; x=1691750907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6URpMR6hAz5HmBG4qanyHjzf2lZTozGc4yZ45ND9Gbs=;
 b=DbUQ6hPg3f708mH7RMdGQ3aZyn2eNIXhsXWcQFlqLCJF5RlMMss8f/eVLsCMwxjdlc
 2EpBn5916xOJz+CvcvZoxd9h0YUdkfMG66UeYKtpZ7GGyIZlTau+//l7htwsAoemMU49
 n45DaERzGwMh3arfl0sgLbHofHORgQbbUKyrh3EuDAcyOir09mJ333qWBLVvSDQKftrM
 oXO2QmIQZilCZ4xDukaqZXPD1Y0yHDgNLVSZyA0QNTSuxjdGMbYBt3eZ5ghG6/sc3UuU
 sQRcI3O5eklQynptGNBYrt7Ce4Sc+29pGcgAPLsYpOr+mT4Wmp/6TQnNpancVn85HZVA
 FCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689158907; x=1691750907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6URpMR6hAz5HmBG4qanyHjzf2lZTozGc4yZ45ND9Gbs=;
 b=RObIPbwjUKK3dHCWYGYKQSdDVg9b+c4vtePZAG4WFQEmNqULQLgLQqFulAAaoPaBm1
 8RKLcjqV9IN2ZTY9xItvZHo5lM1DCFEKKpYt/fOtbjFsURYftim9pDHb7u8JsLFHOR4/
 8cOg4nmkPZ0KKli6+HK9zKuMvs8FNNlmgLfNKW3GLkaZ9F1c44XXLh7j2wBCy+WgfUuT
 /byo+WRbqsd9xb2mabNdnnciRR9HF8VUiOzKx3Mn4FAdZMbcWKiilFdm32Bg3uk/ZvyW
 Fi3kpLtOE8/w1q1mxR6oPvpgrjqlLyc7gDWxvFx3gx0Ed94S3kSOO6WQ6sRT4McyyBYT
 wXYQ==
X-Gm-Message-State: ABy/qLYUqdZyqTnzdD5+Ior+gMjeZBKABI1P5rV5sI/tOpcgBHzMkZcW
 a+EJ2u0IpKZVsPr8Va70kKhc3Q==
X-Google-Smtp-Source: APBJJlEit+1fo64wNwniXNNBeuL+mGz3fTF8r5qCm5xYfipYUu2xTsuIkRkBXNJtsKBLtrJ+kkYhSw==
X-Received: by 2002:a19:435a:0:b0:4fb:752c:3240 with SMTP id
 m26-20020a19435a000000b004fb752c3240mr13870302lfj.68.1689158907483; 
 Wed, 12 Jul 2023 03:48:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.150.242])
 by smtp.gmail.com with ESMTPSA id
 b22-20020aa7dc16000000b0051bed21a635sm2581207edu.74.2023.07.12.03.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 03:48:27 -0700 (PDT)
Message-ID: <007f4ae2-c39b-70ad-9e23-9edd543e393c@linaro.org>
Date: Wed, 12 Jul 2023 12:48:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Sebastian Mitterle <smitterl@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20230712080146.839113-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230712080146.839113-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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

On 12/7/23 10:01, Cédric Le Goater wrote:
> It is useful to extend the number of available PCIe devices to KVM guests
> for passthrough scenarios and also to expose these models to a different
> (big endian) architecture. Introduce a new config PCIE_DEVICES to select
> models, Intel Ethernet adapters and one USB controller. These devices all
> support MSI-X which is a requirement on s390x as legacy INTx are not
> supported.
> 
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   There could be a more general use of PCIE_DEVICES
> 
>   v4: Introduce PCIE_DEVICES
>   v3: PCI -> PCI_EXPRESS
>   v2: select -> imply
>   
>   configs/devices/s390x-softmmu/default.mak | 1 +
>   hw/net/Kconfig                            | 4 ++--
>   hw/pci/Kconfig                            | 3 +++
>   hw/s390x/Kconfig                          | 3 ++-
>   hw/usb/Kconfig                            | 2 +-
>   5 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/configs/devices/s390x-softmmu/default.mak b/configs/devices/s390x-softmmu/default.mak
> index f2287a133f36..2d5ff476e32a 100644
> --- a/configs/devices/s390x-softmmu/default.mak
> +++ b/configs/devices/s390x-softmmu/default.mak
> @@ -7,6 +7,7 @@
>   #CONFIG_VFIO_CCW=n
>   #CONFIG_VIRTIO_PCI=n
>   #CONFIG_WDT_DIAG288=n
> +#CONFIG_PCIE_DEVICE=n
>   
>   # Boards:
>   #
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 98e00be4f937..7fcc0d7faa29 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -41,12 +41,12 @@ config E1000_PCI
>   
>   config E1000E_PCI_EXPRESS
>       bool
> -    default y if PCI_DEVICES
> +    default y if PCI_DEVICES || PCIE_DEVICES

There seems to be a pre-existing bug, shouldn't this be

        default y if PCIE_DEVICES

?

(Cc'ing maintainers)

>       depends on PCI_EXPRESS && MSI_NONBROKEN
>   
>   config IGB_PCI_EXPRESS
>       bool
> -    default y if PCI_DEVICES
> +    default y if PCI_DEVICES || PCIE_DEVICES

Similarly:

        default y if PCIE_DEVICES

>       depends on PCI_EXPRESS && MSI_NONBROKEN
>   
>   config RTL8139_PCI
> diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
> index 77f8b005ffb1..fe70902cd821 100644
> --- a/hw/pci/Kconfig
> +++ b/hw/pci/Kconfig
> @@ -8,6 +8,9 @@ config PCI_EXPRESS
>   config PCI_DEVICES
>       bool
>   
> +config PCIE_DEVICES
> +    bool
> +
>   config MSI_NONBROKEN
>       # selected by interrupt controllers that do not support MSI,
>       # or support it and have a good implementation. See commit
> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
> index 454e0ff4b613..4c068d7960b9 100644
> --- a/hw/s390x/Kconfig
> +++ b/hw/s390x/Kconfig
> @@ -5,7 +5,8 @@ config S390_CCW_VIRTIO
>       imply VFIO_AP
>       imply VFIO_CCW
>       imply WDT_DIAG288
> -    select PCI
> +    imply PCIE_DEVICES
> +    select PCI_EXPRESS

I'm confused, TYPE_S390_PCI_HOST_BRIDGE exposes a PCI bus...
At a minimum you'd need:

-- >8 --
  static const TypeInfo s390_pcihost_info = {
      .name          = TYPE_S390_PCI_HOST_BRIDGE,
-    .parent        = TYPE_PCI_HOST_BRIDGE,
+    .parent        = TYPE_PCIE_HOST_BRIDGE,
      .instance_size = sizeof(S390pciState),
      .class_init    = s390_pcihost_class_init,
      .interfaces = (InterfaceInfo[]) {
---

Actually I can see:

         if (s390_pci_msix_init(pbdev) && !pbdev->interp) {
             error_setg(errp, "MSI-X support is mandatory "
                        "in the S390 architecture");
             return;
         }

So this must be PCIe, not legacy PCI, right?

> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 0ec6def4b8b8..0f486764ed69 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -36,7 +36,7 @@ config USB_XHCI
>   
>   config USB_XHCI_PCI
>       bool
> -    default y if PCI_DEVICES
> +    default y if PCI_DEVICES || PCIE_DEVICES

TYPE_XHCI_PCI inherits TYPE_PCI_DEVICE and implements
INTERFACE_PCIE_DEVICE, so this is OK.

>       depends on PCI
>       select USB_XHCI
>   


