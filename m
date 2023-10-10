Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F77BFAA6
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:03:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBP6-0002Fm-KE; Tue, 10 Oct 2023 08:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqBOt-0002E3-MU; Tue, 10 Oct 2023 07:59:49 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqBOp-0000nc-Uz; Tue, 10 Oct 2023 07:59:47 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8802374632B;
 Tue, 10 Oct 2023 13:58:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 33C057456A7; Tue, 10 Oct 2023 13:58:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 31BFC745681;
 Tue, 10 Oct 2023 13:58:47 +0200 (CEST)
Date: Tue, 10 Oct 2023 13:58:47 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 16/18] hw/sm501: allow compiling without PIXMAN
In-Reply-To: <20231010073830.606570-17-marcandre.lureau@redhat.com>
Message-ID: <6365e1f5-bffe-ef11-7e9e-55077e66c4d0@eik.bme.hu>
References: <20231010073830.606570-1-marcandre.lureau@redhat.com>
 <20231010073830.606570-17-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1834888441-1696939127=:36553"
X-Spam-Probability: 9%
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

--3866299591-1834888441-1696939127=:36553
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 10 Oct 2023, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> Drop the "x-pixman" property and use fallback path in such case.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> hw/display/sm501.c | 46 +++++++++++++++++++++++++++++++++++++---------
> 1 file changed, 37 insertions(+), 9 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 0eecd00701..bc5faa19f0 100644
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
> @@ -894,10 +904,13 @@ static void sm501_2d_operation(SM501State *s)
>             color = cpu_to_le16(color);
>         }
>
> +#ifdef CONFIG_PIXMAN
>         if (!(s->use_pixman & BIT(0)) || (width == 1 && height == 1) ||
>             !pixman_fill((uint32_t *)&s->local_mem[dst_base],
>                          dst_pitch * bypp / sizeof(uint32_t), 8 * bypp,
> -                         dst_x, dst_y, width, height, color)) {
> +                         dst_x, dst_y, width, height, color))
> +#endif
> +        {
>             /* fallback when pixman failed or we don't want to call it */
>             uint8_t *d = s->local_mem + dst_base;
>             unsigned int x, y, i;
> @@ -1875,9 +1888,16 @@ static void sm501_reset(SM501State *s)
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
> +        error_setg(errp, "x-pixman!=0, however PIXMAN is not available");
> +        return false;
> +    }
> +#endif

I think this should be just a warning saying that x-pixman != 0 is not 
effective without pixman and not a hard error. The goal is to keep command 
lines working the same not to annoy users unnecesarily.

> +
>     s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
>
>     /* local memory */
> @@ -1916,6 +1936,7 @@ static void sm501_init(SM501State *s, DeviceState *dev,
>
>     /* create qemu graphic console */
>     s->con = graphic_console_init(dev, 0, &sm501_ops, s);
> +    return true;
> }
>
> static const VMStateDescription vmstate_sm501_state = {
> @@ -2014,7 +2035,9 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
>     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>     MemoryRegion *mr;
>
> -    sm501_init(&s->state, dev, s->vram_size);
> +    if (!sm501_init(&s->state, dev, s->vram_size, errp)) {
> +        return;
> +    }
>     if (get_local_mem_size(&s->state) != s->vram_size) {
>         error_setg(errp, "Invalid VRAM size, nearest valid size is %" PRIu32,
>                    get_local_mem_size(&s->state));
> @@ -2038,7 +2061,8 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
>
> static Property sm501_sysbus_properties[] = {
>     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
> -    DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, 7),
> +    /* TODO: consider PROP_BIT instead */

I don't think a comment is needed here but don't mind it you think it 
helps to note this here too but I'd keep the single value instead of 
separate BIT properties.

> +    DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, DEFAULT_X_PIXMAN),
>     DEFINE_PROP_END_OF_LIST(),
> };
>
> @@ -2112,7 +2136,9 @@ static void sm501_realize_pci(PCIDevice *dev, Error **errp)
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
> @@ -2126,7 +2152,7 @@ static void sm501_realize_pci(PCIDevice *dev, Error **errp)
>
> static Property sm501_pci_properties[] = {
>     DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * MiB),
> -    DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, 7),
> +    DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, DEFAULT_X_PIXMAN),
>     DEFINE_PROP_END_OF_LIST(),
> };
>
> @@ -2169,8 +2195,10 @@ static void sm501_pci_class_init(ObjectClass *klass, void *data)
>
> static void sm501_pci_init(Object *o)
> {
> +#ifdef CONFIG_PIXMAN

Do you still need the ifdef here if we keep the property even with 
!PIXMAN?

Regards,
BALATON Zoltan

>     object_property_set_description(o, "x-pixman", "Use pixman for: "
>                                     "1: fill, 2: blit, 4: overlap blit");
> +#endif
> }
>
> static const TypeInfo sm501_pci_info = {
>
--3866299591-1834888441-1696939127=:36553--

