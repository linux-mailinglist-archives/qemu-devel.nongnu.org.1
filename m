Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F17A516E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:59:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiIWD-0005Er-US; Mon, 18 Sep 2023 13:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qiIW9-0005E3-UG; Mon, 18 Sep 2023 13:58:42 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qiIW7-0002Yk-II; Mon, 18 Sep 2023 13:58:41 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9A6577456AA;
 Mon, 18 Sep 2023 19:58:25 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1651C7456AC; Mon, 18 Sep 2023 19:58:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 12D32745681;
 Mon, 18 Sep 2023 19:58:25 +0200 (CEST)
Date: Mon, 18 Sep 2023 19:58:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "open list:sam460ex" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 16/18] hw/sm501: allow compiling without PIXMAN
In-Reply-To: <20230918135206.2739222-17-marcandre.lureau@redhat.com>
Message-ID: <433e2db8-e85e-d1ce-e54f-80edadd71643@eik.bme.hu>
References: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
 <20230918135206.2739222-17-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-452536757-1695059905=:50197"
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

--3866299591-452536757-1695059905=:50197
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 18 Sep 2023, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> Drop the "x-pixman" property and use fallback path in such case.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> hw/display/sm501.c | 19 ++++++++++++++++---
> 1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 0eecd00701..a897c82f04 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -730,7 +730,6 @@ static void sm501_2d_operation(SM501State *s)
>     switch (cmd) {
>     case 0: /* BitBlt */
>     {
> -        static uint32_t tmp_buf[16384];
>         unsigned int src_x = (s->twoD_source >> 16) & 0x01FFF;
>         unsigned int src_y = s->twoD_source & 0xFFFF;
>         uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
> @@ -828,9 +827,11 @@ static void sm501_2d_operation(SM501State *s)
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
> @@ -860,9 +861,12 @@ static void sm501_2d_operation(SM501State *s)
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
> @@ -894,10 +898,13 @@ static void sm501_2d_operation(SM501State *s)
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
> @@ -2038,7 +2045,9 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
>
> static Property sm501_sysbus_properties[] = {
>     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
> +#ifdef CONFIG_PIXMAN
>     DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, 7),
> +#endif

Do we want to omit the property when compiled without pixman? I think we 
could leave it there and it would just be ignored without pixman but the 
same command line would still work and need less ifdefs in code.

Otherwise:

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

>     DEFINE_PROP_END_OF_LIST(),
> };
>
> @@ -2126,7 +2135,9 @@ static void sm501_realize_pci(PCIDevice *dev, Error **errp)
>
> static Property sm501_pci_properties[] = {
>     DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * MiB),
> +#ifdef CONFIG_PIXMAN
>     DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, 7),
> +#endif
>     DEFINE_PROP_END_OF_LIST(),
> };
>
> @@ -2169,8 +2180,10 @@ static void sm501_pci_class_init(ObjectClass *klass, void *data)
>
> static void sm501_pci_init(Object *o)
> {
> +#ifdef CONFIG_PIXMAN
>     object_property_set_description(o, "x-pixman", "Use pixman for: "
>                                     "1: fill, 2: blit, 4: overlap blit");
> +#endif
> }
>
> static const TypeInfo sm501_pci_info = {
>
--3866299591-452536757-1695059905=:50197--

