Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0FD7CC8E0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 18:31:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmxu-0003NE-1D; Tue, 17 Oct 2023 12:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsmxg-0003Ly-81
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:30:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsmxc-00038d-L2
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:30:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0C20A7456AC;
 Tue, 17 Oct 2023 18:29:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 573617456AA; Tue, 17 Oct 2023 18:29:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 55BFC7456A7;
 Tue, 17 Oct 2023 18:29:13 +0200 (CEST)
Date: Tue, 17 Oct 2023 18:29:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: deller@kernel.org
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 06/11] pci-host: Wire up new Astro/Elroy PCI bridge
In-Reply-To: <20231017154645.95844-7-deller@kernel.org>
Message-ID: <5ce55b97-b574-cf88-2103-f8b465a403a2@eik.bme.hu>
References: <20231017154645.95844-1-deller@kernel.org>
 <20231017154645.95844-7-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 17 Oct 2023, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
>
> Allow the Astro source to be built.

It was addded 3 patches earlier. Shuold this also be in that patch or at 
least closer to it? If you think that patch is too big (which it maybe is) 
it could help to split up to simpler patches but not sure moving out build 
system and MAINTAINERS changes realy does simplify the patch for review. 
This are trivial even if in the same patch so I would not bother putting 
this in separate patch unless there's some other reason I've missed.

If you want to split that patch up to make it easier to review maybe try 
having one patch adding skeleton or basic device first, then more patches 
adding more functionality to it which may seem to be better than just 
having these in separate patches later in the series.

Regards,
BALATON Zoltan

> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
> hw/hppa/Kconfig         | 1 +
> hw/pci-host/Kconfig     | 4 ++++
> hw/pci-host/meson.build | 1 +
> 3 files changed, 6 insertions(+)
>
> diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
> index 5dd8b5b21e..ff8528aaa8 100644
> --- a/hw/hppa/Kconfig
> +++ b/hw/hppa/Kconfig
> @@ -3,6 +3,7 @@ config HPPA_B160L
>     imply PCI_DEVICES
>     imply E1000_PCI
>     imply VIRTIO_VGA
> +    select ASTRO
>     select DINO
>     select LASI
>     select SERIAL
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index a07070eddf..54a609d2ca 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -82,6 +82,10 @@ config DINO
>     bool
>     select PCI
>
> +config ASTRO
> +    bool
> +    select PCI
> +
> config GT64120
>     bool
>     select PCI
> diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
> index 64eada76fe..f891f026cb 100644
> --- a/hw/pci-host/meson.build
> +++ b/hw/pci-host/meson.build
> @@ -27,6 +27,7 @@ pci_ss.add(when: 'CONFIG_MV64361', if_true: files('mv64361.c'))
> pci_ss.add(when: 'CONFIG_VERSATILE_PCI', if_true: files('versatile.c'))
>
> # HPPA devices
> +pci_ss.add(when: 'CONFIG_ASTRO', if_true: files('astro.c'))
> pci_ss.add(when: 'CONFIG_DINO', if_true: files('dino.c'))
>
> system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
>

