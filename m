Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F9F81603E
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 16:49:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEtMz-0001bC-Qf; Sun, 17 Dec 2023 10:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rEtMw-0001au-DX; Sun, 17 Dec 2023 10:47:55 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rEtMf-00017W-OD; Sun, 17 Dec 2023 10:47:54 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 670CA75A4C6;
 Sun, 17 Dec 2023 16:47:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id EPQ3JnD1R225; Sun, 17 Dec 2023 16:47:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3933775A4CD; Sun, 17 Dec 2023 16:47:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 372AD75A4C8;
 Sun, 17 Dec 2023 16:47:33 +0100 (CET)
Date: Sun, 17 Dec 2023 16:47:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 David Hildenbrand <david@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Sergio Lopez <slp@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Juan Quintela <quintela@redhat.com>, 
 =?ISO-8859-15?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>, 
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 04/12] hw/block/fdc: Expose internal header
In-Reply-To: <20231217144148.15511-5-shentey@gmail.com>
Message-ID: <b4b1d529-f368-4f8f-b357-4ad5177a2951@eik.bme.hu>
References: <20231217144148.15511-1-shentey@gmail.com>
 <20231217144148.15511-5-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Sun, 17 Dec 2023, Bernhard Beschow wrote:
> Exposing the internal header allows for exposing struct FDCtrlISABus which is
> encuraged by qdev guidelines.

Hopefully the guidelines don't encourage this as object orientation indeed 
encourages object encapsulation so only the object itseld should poke its 
internals and other objects should use methods the change object state. In 
QOM some object states were exposed in public headers to allow embedding 
those objects in other objects becuase C needs the struct size to allow 
that. This was to simplify memory management so the embedded objects don't 
need to be tracked and freed but would be created and freed with the other 
object embedding it but this does not mean the other object should poke 
into these object or that this is a general guideline to expose internal 
object state. I'd say the exposed objects are an exception instead of 
recommended guideline and only allowed for objects that need to be embeded 
in others but generally object encapsulation would be better to preserve 
where possible. This patch exposes objects so others can poke into them 
which would make those other objects dependent on the implementation of 
these objects making these harder to chnage in the future so a better way 
may be to add methods to fdc and serial to allow changing their base 
address and map/unmap their ports and keep their internals unexposed.

Regards,
BALATON Zoltan

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> MAINTAINERS                                       | 2 +-
> hw/block/fdc-internal.h => include/hw/block/fdc.h | 4 ++--
> hw/block/fdc-isa.c                                | 2 +-
> hw/block/fdc-sysbus.c                             | 2 +-
> hw/block/fdc.c                                    | 2 +-
> 5 files changed, 6 insertions(+), 6 deletions(-)
> rename hw/block/fdc-internal.h => include/hw/block/fdc.h (98%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b4718fcf59..939f518701 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1945,9 +1945,9 @@ M: John Snow <jsnow@redhat.com>
> L: qemu-block@nongnu.org
> S: Odd Fixes
> F: hw/block/fdc.c
> -F: hw/block/fdc-internal.h
> F: hw/block/fdc-isa.c
> F: hw/block/fdc-sysbus.c
> +F: include/hw/block/fdc.h
> F: include/hw/block/fdc-isa.h
> F: tests/qtest/fdc-test.c
> T: git https://gitlab.com/jsnow/qemu.git ide
> diff --git a/hw/block/fdc-internal.h b/include/hw/block/fdc.h
> similarity index 98%
> rename from hw/block/fdc-internal.h
> rename to include/hw/block/fdc.h
> index 1728231a26..acca7e0d0e 100644
> --- a/hw/block/fdc-internal.h
> +++ b/include/hw/block/fdc.h
> @@ -22,8 +22,8 @@
>  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>  * THE SOFTWARE.
>  */
> -#ifndef HW_BLOCK_FDC_INTERNAL_H
> -#define HW_BLOCK_FDC_INTERNAL_H
> +#ifndef HW_BLOCK_FDC_H
> +#define HW_BLOCK_FDC_H
>
> #include "exec/memory.h"
> #include "exec/ioport.h"
> diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
> index 6387dc94fa..7058d4118f 100644
> --- a/hw/block/fdc-isa.c
> +++ b/hw/block/fdc-isa.c
> @@ -39,6 +39,7 @@
> #include "hw/qdev-properties-system.h"
> #include "migration/vmstate.h"
> #include "hw/block/block.h"
> +#include "hw/block/fdc.h"
> #include "sysemu/block-backend.h"
> #include "sysemu/blockdev.h"
> #include "sysemu/sysemu.h"
> @@ -47,7 +48,6 @@
> #include "qemu/module.h"
> #include "trace.h"
> #include "qom/object.h"
> -#include "fdc-internal.h"
>
> OBJECT_DECLARE_SIMPLE_TYPE(FDCtrlISABus, ISA_FDC)
>
> diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
> index f18f0d19b0..cff21c02b3 100644
> --- a/hw/block/fdc-sysbus.c
> +++ b/hw/block/fdc-sysbus.c
> @@ -28,8 +28,8 @@
> #include "qom/object.h"
> #include "hw/sysbus.h"
> #include "hw/block/fdc-isa.h"
> +#include "hw/block/fdc.h"
> #include "migration/vmstate.h"
> -#include "fdc-internal.h"
> #include "trace.h"
>
> #define TYPE_SYSBUS_FDC "base-sysbus-fdc"
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 2bd6d925b5..0e2fa527f9 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -39,6 +39,7 @@
> #include "hw/qdev-properties-system.h"
> #include "migration/vmstate.h"
> #include "hw/block/block.h"
> +#include "hw/block/fdc.h"
> #include "sysemu/block-backend.h"
> #include "sysemu/blockdev.h"
> #include "sysemu/sysemu.h"
> @@ -47,7 +48,6 @@
> #include "qemu/module.h"
> #include "trace.h"
> #include "qom/object.h"
> -#include "fdc-internal.h"
>
> /********************************************************/
> /* debug Floppy devices */
>

