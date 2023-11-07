Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969F7E36E0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 09:47:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Hj0-00009w-Ls; Tue, 07 Nov 2023 03:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0Hij-0008Sv-Eg; Tue, 07 Nov 2023 03:46:01 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0Hih-0002ac-4U; Tue, 07 Nov 2023 03:46:01 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AE166756082;
 Tue,  7 Nov 2023 09:46:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A28AD75606C; Tue,  7 Nov 2023 09:46:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A006875607A;
 Tue,  7 Nov 2023 09:46:10 +0100 (CET)
Date: Tue, 7 Nov 2023 09:46:10 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 stefanha@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v8 23/24] hw/display/ati: allow compiling without
 PIXMAN
In-Reply-To: <20231107071915.2459115-24-marcandre.lureau@redhat.com>
Message-ID: <15834680-16c1-6ed2-38fa-403d9bd14242@eik.bme.hu>
References: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
 <20231107071915.2459115-24-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-832536453-1699346770=:66472"
X-Virus-Scanned: ClamAV using ClamSMTP
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

--3866299591-832536453-1699346770=:66472
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 7 Nov 2023, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> Change the "x-pixman" property default value and use the fallback path
> when PIXMAN support is disabled.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> hw/display/ati.c       | 16 +++++++++++++++-
> hw/display/ati_2d.c    | 11 +++++++----
> hw/display/meson.build |  2 +-
> 3 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 9a87a5504a..51a3b156ac 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -32,6 +32,13 @@
>
> #define ATI_DEBUG_HW_CURSOR 0
>
> +#ifdef CONFIG_PIXMAN
> +#define DEFAULT_X_PIXMAN 3
> +#else
> +#define DEFAULT_X_PIXMAN 0
> +#endif
> +
> +

Excess new line.

> static const struct {
>     const char *name;
>     uint16_t dev_id;
> @@ -946,6 +953,12 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
>     ATIVGAState *s = ATI_VGA(dev);
>     VGACommonState *vga = &s->vga;
>
> +#ifndef CONFIG_PIXMAN
> +    if (s->use_pixman != 0) {
> +        warn_report("x-pixman != 0, not effective without PIXMAN");
> +    }
> +#endif
> +
>     if (s->model) {
>         int i;
>         for (i = 0; i < ARRAY_SIZE(ati_model_aliases); i++) {
> @@ -1033,7 +1046,8 @@ static Property ati_vga_properties[] = {
>     DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
>                        PCI_DEVICE_ID_ATI_RAGE128_PF),
>     DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, false),
> -    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, 3),
> +    /* this a debug option, prefer PROP_UINT over PROP_BIT for simplicity */

Comment not needed but if you still want it, should be "this is a debug..."

> +    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, DEFAULT_X_PIXMAN),
>     DEFINE_PROP_END_OF_LIST()
> };
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 0e6b8e4367..e58acd0802 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -92,7 +92,7 @@ void ati_2d_blt(ATIVGAState *s)
>     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
>     case ROP3_SRCCOPY:
>     {
> -        bool fallback = false;
> +        bool fallback = true;
>         unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
>                        s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
>         unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> @@ -119,6 +119,7 @@ void ati_2d_blt(ATIVGAState *s)
>
>         src_stride /= sizeof(uint32_t);
>         dst_stride /= sizeof(uint32_t);
> +#ifdef CONFIG_PIXMAN
>         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
>                 src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
>                 src_x, src_y, dst_x, dst_y,

Keep debug log even without pixman so move ifdef after it (also below) as 
this provides info on the operation even if done by fallback.

> @@ -147,9 +148,8 @@ void ati_2d_blt(ATIVGAState *s)
>                                        s->regs.dst_width, s->regs.dst_height);
>             }
>             g_free(tmp);
> -        } else {
> -            fallback = true;
>         }

If you cahnge default value to true this is not needed any more but for 
consistency with sm501 you could keep default and put this outside of 
#idfef instead so it's the same as sm501 or do the same there.

> +#endif
>         if (fallback) {
>             unsigned int y, i, j, bypp = bpp / 8;
>             unsigned int src_pitch = src_stride * sizeof(uint32_t);
> @@ -203,12 +203,15 @@ void ati_2d_blt(ATIVGAState *s)
>         }
>
>         dst_stride /= sizeof(uint32_t);
> +#ifdef CONFIG_PIXMAN
>         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
>                 dst_bits, dst_stride, bpp, dst_x, dst_y,
>                 s->regs.dst_width, s->regs.dst_height, filler);

Move ifdef here.

With these

Acked-by: BALATON Zoltan <balaton@eik.bme.hu>

Thanks for doing this in last minute.

Regards,
BALATON Zoltan

>         if (!(s->use_pixman & BIT(0)) ||
>             !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
> -                    s->regs.dst_width, s->regs.dst_height, filler)) {
> +                    s->regs.dst_width, s->regs.dst_height, filler))
> +#endif
> +        {
>             /* fallback when pixman failed or we don't want to call it */
>             unsigned int x, y, i, bypp = bpp / 8;
>             unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 9c06aaee20..344dfe3d8c 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -62,7 +62,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_true: files('xlnx_dp.c'))
>
> system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
>
> -system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', 'ati_2d.c', 'ati_dbg.c'))
> +system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
>
>
> if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>
--3866299591-832536453-1699346770=:66472--

