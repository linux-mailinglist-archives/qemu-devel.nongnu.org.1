Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A128AA5966D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Mar 2025 14:33:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdEM-0005Eg-Tf; Mon, 10 Mar 2025 09:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trdEC-0005EE-Sf; Mon, 10 Mar 2025 09:31:32 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trdEA-0007LS-O6; Mon, 10 Mar 2025 09:31:32 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3270C4E6030;
 Mon, 10 Mar 2025 14:31:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id KYwbHkbacqMQ; Mon, 10 Mar 2025 14:31:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 416A24E602E; Mon, 10 Mar 2025 14:31:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3F35D74577C;
 Mon, 10 Mar 2025 14:31:23 +0100 (CET)
Date: Mon, 10 Mar 2025 14:31:23 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-block@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: Re: [PATCH v5 03/14] hw/sd/sdhci: Redefine SDHCI_QUIRK_NO_BUSY_IRQ
 bitmask as bit
In-Reply-To: <20250310000620.70120-4-philmd@linaro.org>
Message-ID: <e9dc5c0f-50ad-e066-a3b0-1d58e8f68062@eik.bme.hu>
References: <20250310000620.70120-1-philmd@linaro.org>
 <20250310000620.70120-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-935087992-1741613483=:72286"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

--3866299591-935087992-1741613483=:72286
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Mar 2025, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/hw/sd/sdhci.h | 8 ++++----
> hw/sd/sdhci.c         | 4 ++--
> 2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 48247e9a20f..096d607f4b7 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -108,13 +108,13 @@ struct SDHCIState {
> typedef struct SDHCIState SDHCIState;
>
> /*
> - * Controller does not provide transfer-complete interrupt when not
> - * busy.
> - *
>  * NOTE: This definition is taken out of Linux kernel and so the
>  * original bit number is preserved
>  */
> -#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
> +enum {
> +    /* Controller does not provide transfer-complete interrupt when not busy. */
> +    SDHCI_QUIRK_NO_BUSY_IRQ                     = 14,
> +};

I think this is better as a define, then you don't have to remember to add 
BIT() on usage and prevent this churn. I'd say drop this patch and adjust 
the comment in next patch but if you're attached to it I don't mind that 
much.

Regards,
BALATON Zoltan

> #define TYPE_PCI_SDHCI "sdhci-pci"
> DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 149b748cbee..1dc942a0e06 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -366,7 +366,7 @@ static void sdhci_send_command(SDHCIState *s)
>             }
>         }
>
> -        if (!(s->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
> +        if (!(s->quirks & BIT(SDHCI_QUIRK_NO_BUSY_IRQ)) &&
>             (s->norintstsen & SDHC_NISEN_TRSCMP) &&
>             (s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY) {
>             s->norintsts |= SDHC_NIS_TRSCMP;
> @@ -1886,7 +1886,7 @@ static void imx_usdhc_init(Object *obj)
>     SDHCIState *s = SYSBUS_SDHCI(obj);
>
>     s->io_ops = &usdhc_mmio_ops;
> -    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
> +    s->quirks = BIT(SDHCI_QUIRK_NO_BUSY_IRQ);
> }
>
> /* --- qdev Samsung s3c --- */
>
--3866299591-935087992-1741613483=:72286--

