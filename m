Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E27307C55C2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZV1-0002xA-MV; Wed, 11 Oct 2023 09:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqZUs-0002uz-20; Wed, 11 Oct 2023 09:43:34 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqZUq-0001Gs-E3; Wed, 11 Oct 2023 09:43:33 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 80FB3748FF4;
 Wed, 11 Oct 2023 15:42:34 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 48DC774632B; Wed, 11 Oct 2023 15:42:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 472E67456AA;
 Wed, 11 Oct 2023 15:42:34 +0200 (CEST)
Date: Wed, 11 Oct 2023 15:42:34 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/5] hw/ppc/ppc4xx_pci: Declare PPC4XX_PCI in Kconfig
In-Reply-To: <20231011132427.65001-4-philmd@linaro.org>
Message-ID: <763c0675-5f72-5b53-0770-dba5f52692d8@eik.bme.hu>
References: <20231011132427.65001-1-philmd@linaro.org>
 <20231011132427.65001-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-357349036-1697031754=:10652"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-357349036-1697031754=:10652
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 11 Oct 2023, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Should this be squashed with next patch? It looks strange to have config 
defined in hw/pci-host/Kconfig but used in hw/ppc/meson.build.

Regards,
BALATON Zoltan

> ---
> hw/pci-host/Kconfig | 4 ++++
> hw/ppc/Kconfig      | 2 +-
> hw/ppc/meson.build  | 2 +-
> 3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index a07070eddf..a9030a433b 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -6,6 +6,10 @@ config XEN_IGD_PASSTHROUGH
>     default y
>     depends on XEN && PCI_I440FX
>
> +config PPC4XX_PCI
> +    bool
> +    select PCI
> +
> config RAVEN_PCI
>     bool
>     select PCI
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 5dfbf47ef5..e4e76e87a2 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -53,7 +53,7 @@ config PPC440
> config PPC4XX
>     bool
>     select BITBANG_I2C
> -    select PCI
> +    select PPC4XX_PCI
>     select PPC_UIC
>
> config SAM460EX
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 7c2c52434a..6931ba88b4 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -60,8 +60,8 @@ ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
>   'ppc440_pcix.c', 'ppc440_uc.c'))
> ppc_ss.add(when: 'CONFIG_PPC4XX', if_true: files(
>   'ppc4xx_devs.c',
> -  'ppc4xx_pci.c',
>   'ppc4xx_sdram.c'))
> +ppc_ss.add(when: 'CONFIG_PPC4XX_PCI', if_true: files('ppc4xx_pci.c'))
> ppc_ss.add(when: 'CONFIG_SAM460EX', if_true: files('sam460ex.c'))
> # PReP
> ppc_ss.add(when: 'CONFIG_PREP', if_true: files('prep.c'))
>
--3866299591-357349036-1697031754=:10652--

