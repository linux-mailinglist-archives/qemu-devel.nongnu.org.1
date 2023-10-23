Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A58A7D378B
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quulz-000156-Am; Mon, 23 Oct 2023 09:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1quulp-00011f-Gq; Mon, 23 Oct 2023 09:15:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1quulm-0001bL-By; Mon, 23 Oct 2023 09:15:01 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 53E1675606C;
 Mon, 23 Oct 2023 15:14:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 074FF74705E; Mon, 23 Oct 2023 15:14:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 04227745681;
 Mon, 23 Oct 2023 15:14:54 +0200 (CEST)
Date: Mon, 23 Oct 2023 15:14:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 17/19] hw/sm501: allow compiling without PIXMAN
In-Reply-To: <20231023113047.2572137-18-marcandre.lureau@redhat.com>
Message-ID: <1bb1f023-0618-5dad-c269-07bb010f5a14@eik.bme.hu>
References: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
 <20231023113047.2572137-18-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-798776552-1698066894=:423"
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

--3866299591-798776552-1698066894=:423
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 23 Oct 2023, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> Drop the "x-pixman" property and use fallback path in such case.

Patch diverged from commit message, the x-pixman property is not dropped 
just the default changed. Needs updated commit message to reflect that.

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> hw/display/sm501.c | 59 +++++++++++++++++++++++++++++++++-------------
> 1 file changed, 42 insertions(+), 17 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 0eecd00701..282671d1b3 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -438,6 +438,12 @@
> #define SM501_HWC_WIDTH                 64
> #define SM501_HWC_HEIGHT                64
>
> +#ifdef CONFIG_PIXMAN
> +#define DEFAULT_X_PIXMAN 7
> +#else
> +#define DEFAULT_X_PIXMAN 0
> +#endif
> +
> /* SM501 local memory size taken from "linux/drivers/mfd/sm501.c" */
> static const uint32_t sm501_mem_local_size[] = {
>     [0] = 4 * MiB,
> @@ -730,7 +736,6 @@ static void sm501_2d_operation(SM501State *s)
>     switch (cmd) {
>     case 0: /* BitBlt */
>     {
> -        static uint32_t tmp_buf[16384];
>         unsigned int src_x = (s->twoD_source >> 16) & 0x01FFF;
>         unsigned int src_y = s->twoD_source & 0xFFFF;
>         uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
> @@ -828,9 +833,11 @@ static void sm501_2d_operation(SM501State *s)
>                 de = db + (width + (height - 1) * dst_pitch) * bypp;
>                 overlap = (db < se && sb < de);
>             }
> +#ifdef CONFIG_PIXMAN
>             if (overlap && (s->use_pixman & BIT(2))) {
>                 /* pixman can't do reverse blit: copy via temporary */
>                 int tmp_stride = DIV_ROUND_UP(width * bypp, sizeof(uint32_t));
> +                static uint32_t tmp_buf[16384];
>                 uint32_t *tmp = tmp_buf;
>
>                 if (tmp_stride * sizeof(uint32_t) * height > sizeof(tmp_buf)) {
> @@ -860,9 +867,12 @@ static void sm501_2d_operation(SM501State *s)
>                                        dst_pitch * bypp / sizeof(uint32_t),
>                                        8 * bypp, 8 * bypp, src_x, src_y,
>                                        dst_x, dst_y, width, height);
> -            } else {
> +            } else
> +#else
> +            {
>                 fallback = true;
>             }
> +#endif
>             if (fallback) {
>                 uint8_t *sp = s->local_mem + src_base;
>                 uint8_t *d = s->local_mem + dst_base;
> @@ -894,20 +904,23 @@ static void sm501_2d_operation(SM501State *s)
>             color = cpu_to_le16(color);
>         }
>
> +#ifdef CONFIG_PIXMAN
>         if (!(s->use_pixman & BIT(0)) || (width == 1 && height == 1) ||
>             !pixman_fill((uint32_t *)&s->local_mem[dst_base],
>                          dst_pitch * bypp / sizeof(uint32_t), 8 * bypp,
> -                         dst_x, dst_y, width, height, color)) {
> -            /* fallback when pixman failed or we don't want to call it */
> -            uint8_t *d = s->local_mem + dst_base;
> -            unsigned int x, y, i;
> -            for (y = 0; y < height; y++) {
> -                i = (dst_x + (dst_y + y) * dst_pitch) * bypp;
> -                for (x = 0; x < width; x++, i += bypp) {
> -                    stn_he_p(&d[i], bypp, color);
> +                         dst_x, dst_y, width, height, color))
> +#endif
> +            {
> +                /* fallback when pixman failed or we don't want to call it */
> +                uint8_t *d = s->local_mem + dst_base;
> +                unsigned int x, y, i;
> +                for (y = 0; y < height; y++) {
> +                    i = (dst_x + (dst_y + y) * dst_pitch) * bypp;
> +                    for (x = 0; x < width; x++, i += bypp) {
> +                        stn_he_p(&d[i], bypp, color);
> +                    }
>                 }
>             }
> -        }
>         break;
>     }
>     default:
> @@ -1875,9 +1888,15 @@ static void sm501_reset(SM501State *s)
>     s->twoD_wrap = 0;
> }
>
> -static void sm501_init(SM501State *s, DeviceState *dev,
> -                       uint32_t local_mem_bytes)
> +static bool sm501_init(SM501State *s, DeviceState *dev,
> +                       uint32_t local_mem_bytes, Error **errp)
> {
> +#ifndef CONFIG_PIXMAN
> +    if (s->use_pixman != 0) {
> +        error_setg(&error_warn, "x-pixman != 0, not effective without PIXMAN");

I think this should just be warn_report not an error

> +    }
> +#endif
> +
>     s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
>
>     /* local memory */
> @@ -1916,6 +1935,7 @@ static void sm501_init(SM501State *s, DeviceState *dev,
>
>     /* create qemu graphic console */
>     s->con = graphic_console_init(dev, 0, &sm501_ops, s);
> +    return true;

and no need to add errp as we never return false so it won't be printed 
anyway.

> }
>
> static const VMStateDescription vmstate_sm501_state = {
> @@ -2014,7 +2034,9 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
>     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>     MemoryRegion *mr;
>
> -    sm501_init(&s->state, dev, s->vram_size);
> +    if (!sm501_init(&s->state, dev, s->vram_size, errp)) {
> +        return;
> +    }

This could be left alone too, just issuing a warning above should be 
enough, no other cahnges are needed.

Regards,
BALATON Zoltan

>     if (get_local_mem_size(&s->state) != s->vram_size) {
>         error_setg(errp, "Invalid VRAM size, nearest valid size is %" PRIu32,
>                    get_local_mem_size(&s->state));
> @@ -2038,7 +2060,8 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
>
> static Property sm501_sysbus_properties[] = {
>     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
> -    DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, 7),
> +    /* this a debug option, prefer PROP_UINT over PROP_BIT for simplicity */
> +    DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, DEFAULT_X_PIXMAN),
>     DEFINE_PROP_END_OF_LIST(),
> };
>
> @@ -2112,7 +2135,9 @@ static void sm501_realize_pci(PCIDevice *dev, Error **errp)
> {
>     SM501PCIState *s = PCI_SM501(dev);
>
> -    sm501_init(&s->state, DEVICE(dev), s->vram_size);
> +    if (!sm501_init(&s->state, DEVICE(dev), s->vram_size, errp)) {
> +        return;
> +    }
>     if (get_local_mem_size(&s->state) != s->vram_size) {
>         error_setg(errp, "Invalid VRAM size, nearest valid size is %" PRIu32,
>                    get_local_mem_size(&s->state));
> @@ -2126,7 +2151,7 @@ static void sm501_realize_pci(PCIDevice *dev, Error **errp)
>
> static Property sm501_pci_properties[] = {
>     DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * MiB),
> -    DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, 7),
> +    DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, DEFAULT_X_PIXMAN),
>     DEFINE_PROP_END_OF_LIST(),
> };
>
>
--3866299591-798776552-1698066894=:423--

