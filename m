Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F40736998
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:41:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYnj-0007f2-Js; Tue, 20 Jun 2023 06:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBYng-0007VV-Bm; Tue, 20 Jun 2023 06:41:28 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBYne-0004rk-4p; Tue, 20 Jun 2023 06:41:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D20D5746377;
 Tue, 20 Jun 2023 12:41:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9EE9C746335; Tue, 20 Jun 2023 12:41:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9CF8A745720;
 Tue, 20 Jun 2023 12:41:13 +0200 (CEST)
Date: Tue, 20 Jun 2023 12:41:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 5/9] ppc/pegasos2: Report an error when run with KVM
In-Reply-To: <20230620055911.187065-6-clg@kaod.org>
Message-ID: <614aa943-1d0d-81ae-f7b0-298e1a19cc81@eik.bme.hu>
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1767328446-1687257673=:73461"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--3866299591-1767328446-1687257673=:73461
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 20 Jun 2023, Cédric Le Goater wrote:
> The 'pegasos2' machine never supported KVM. This piece of code was
> inherited from another model.

Why? These machines are supposed to run with KVM they were just not tested 
yet. I think pegasos2 should work on a G4 host with KVM-PR but you need to 
use the firmware rom for -bios now because VOF uses sc 1 which will not 
work with KVM on G4, it's only supported with TCG. (I plan to solve this 
eventually when needed by replacing that with another hypercall method 
such as OSI used by MOL but that would need two vof binaries or carry 
some unneeded code if using single binary.)

So please drop this patch.

Regards,
BALATON Zoltan

> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
> hw/ppc/pegasos2.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index af5489de26ed..830323cc7849 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -29,7 +29,6 @@
> #include "qemu/log.h"
> #include "qemu/error-report.h"
> #include "sysemu/kvm.h"
> -#include "kvm_ppc.h"
> #include "exec/address-spaces.h"
> #include "qom/qom-qobject.h"
> #include "qapi/qmp/qdict.h"
> @@ -120,6 +119,12 @@ static void pegasos2_init(MachineState *machine)
>     int i, sz;
>     uint8_t *spd_data;
>
> +    if (kvm_enabled()) {
> +        error_report("machine %s does not support the KVM accelerator",
> +                     MACHINE_GET_CLASS(machine)->name);
> +        exit(EXIT_FAILURE);
> +    }
> +
>     /* init CPU */
>     pm->cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
>     env = &pm->cpu->env;
>
--3866299591-1767328446-1687257673=:73461--

