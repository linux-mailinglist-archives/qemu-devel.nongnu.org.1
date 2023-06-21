Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83459738253
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:35:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBw69-0006FQ-AF; Wed, 21 Jun 2023 07:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBw5z-0006FA-Sh
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:33:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBw5x-0005h2-St
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:33:55 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A2EDF748A62;
 Wed, 21 Jun 2023 13:33:39 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 67C81748A5D; Wed, 21 Jun 2023 13:33:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 65AED748A61;
 Wed, 21 Jun 2023 13:33:39 +0200 (CEST)
Date: Wed, 21 Jun 2023 13:33:39 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 03/24] q800: introduce Q800MachineState
In-Reply-To: <20230621085353.113233-4-mark.cave-ayland@ilande.co.uk>
Message-ID: <3ffba6ed-4213-2e57-dcd1-ba1315f2df31@eik.bme.hu>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-4-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1190823114-1687347219=:25233"
X-Spam-Probability: 10%
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

--3866299591-1190823114-1687347219=:25233
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 21 Jun 2023, Mark Cave-Ayland wrote:
> This provides an overall container and owner for Machine-related objects such
> as MemoryRegions.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> MAINTAINERS            |  1 +
> hw/m68k/q800.c         |  2 ++
> include/hw/m68k/q800.h | 40 ++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 43 insertions(+)
> create mode 100644 include/hw/m68k/q800.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 88b5a7ee0a..748a66fbaa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1236,6 +1236,7 @@ F: include/hw/misc/mac_via.h
> F: include/hw/nubus/*
> F: include/hw/display/macfb.h
> F: include/hw/block/swim.h
> +F: include/hw/m68k/q800.h
>
> virt
> M: Laurent Vivier <laurent@vivier.eu>
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 465c510c18..c0256c8a90 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -38,6 +38,7 @@
> #include "standard-headers/asm-m68k/bootinfo.h"
> #include "standard-headers/asm-m68k/bootinfo-mac.h"
> #include "bootinfo.h"
> +#include "hw/m68k/q800.h"
> #include "hw/misc/mac_via.h"
> #include "hw/input/adb.h"
> #include "hw/nubus/mac-nubus-bridge.h"
> @@ -749,6 +750,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
> static const TypeInfo q800_machine_typeinfo = {
>     .name       = MACHINE_TYPE_NAME("q800"),
>     .parent     = TYPE_MACHINE,
> +    .instance_size = sizeof(Q800MachineState),
>     .class_init = q800_machine_class_init,
> };
>
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> new file mode 100644
> index 0000000000..f3bc17aa1b
> --- /dev/null
> +++ b/include/hw/m68k/q800.h

Why is this defined in a public header? Moving struct definitions of 
devices to allow them to be embedded in other structs makes sense but is 
there ever a reason to embed a machine state anywhere else than using it 
in q800.c? I don't think so, thus to preserve locality and save some lines 
in this series I think this machine state should just be in q800.c like I 
have similar struct in pegasos2.c. It may only make sense to put it in a 
header if q800.c was split up to multiple files but even then it should be 
a local header in hw/m68k and not a public header in my opinion.

Regards,
BALATON Zoltan

> @@ -0,0 +1,40 @@
> +/*
> + * QEMU Motorla 680x0 Macintosh hardware System Emulator
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_Q800_H
> +#define HW_Q800_H
> +
> +#include "hw/boards.h"
> +#include "qom/object.h"
> +
> +/*
> + * The main Q800 machine
> + */
> +
> +struct Q800MachineState {
> +    MachineState parent_obj;
> +};
> +
> +#define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
> +OBJECT_DECLARE_SIMPLE_TYPE(Q800MachineState, Q800_MACHINE)
> +
> +#endif
>
--3866299591-1190823114-1687347219=:25233--

