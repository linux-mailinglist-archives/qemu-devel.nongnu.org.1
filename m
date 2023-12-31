Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBB3820BEE
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 17:15:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJyRp-0001u0-IE; Sun, 31 Dec 2023 11:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rJyRj-0001tr-8q
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 11:13:51 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rJyRg-00074e-4j
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 11:13:50 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2DC43756094;
 Sun, 31 Dec 2023 17:13:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 3xeAE2LfqGc2; Sun, 31 Dec 2023 17:13:42 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 46FE4756078; Sun, 31 Dec 2023 17:13:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 455F9756066;
 Sun, 31 Dec 2023 17:13:42 +0100 (CET)
Date: Sun, 31 Dec 2023 17:13:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH 3/8] vga: mask addresses in non-VESA modes to 256k
In-Reply-To: <20231231093918.239549-4-pbonzini@redhat.com>
Message-ID: <2e424890-6809-59d2-dd33-e1b4cb1d0057@eik.bme.hu>
References: <20231231093918.239549-1-pbonzini@redhat.com>
 <20231231093918.239549-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Sun, 31 Dec 2023, Paolo Bonzini wrote:
> This allows setting the start address to a high value, and reading the
> bottom of the screen from the beginning of VRAM.  Commander Keen 4
> ("Goodbye, Galaxy!") relies on this behavior.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> hw/display/vga-helpers.h | 9 +++++----
> hw/display/vga.c         | 3 +++
> 2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/vga-helpers.h b/hw/display/vga-helpers.h
> index 10e9cfd40a0..83b9a15604a 100644
> --- a/hw/display/vga-helpers.h
> +++ b/hw/display/vga-helpers.h
> @@ -108,7 +108,7 @@ static void vga_draw_line2(VGACommonState *vga, uint8_t *d,
>     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
>     width >>= 3;
>     for(x = 0; x < width; x++) {
> -        data = vga_read_dword_le(vga, addr);
> +        data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
>         data &= plane_mask;
>         v = expand2[GET_PLANE(data, 0)];
>         v |= expand2[GET_PLANE(data, 2)] << 2;
> @@ -144,7 +144,7 @@ static void vga_draw_line2d2(VGACommonState *vga, uint8_t *d,
>     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
>     width >>= 3;
>     for(x = 0; x < width; x++) {
> -        data = vga_read_dword_le(vga, addr);
> +        data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
>         data &= plane_mask;
>         v = expand2[GET_PLANE(data, 0)];
>         v |= expand2[GET_PLANE(data, 2)] << 2;
> @@ -177,7 +177,7 @@ static void vga_draw_line4(VGACommonState *vga, uint8_t *d,
>     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
>     width >>= 3;
>     for(x = 0; x < width; x++) {
> -        data = vga_read_dword_le(vga, addr);
> +        data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
>         data &= plane_mask;
>         v = expand4[GET_PLANE(data, 0)];
>         v |= expand4[GET_PLANE(data, 1)] << 1;
> @@ -209,7 +209,7 @@ static void vga_draw_line4d2(VGACommonState *vga, uint8_t *d,
>     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
>     width >>= 3;
>     for(x = 0; x < width; x++) {
> -        data = vga_read_dword_le(vga, addr);
> +        data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
>         data &= plane_mask;
>         v = expand4[GET_PLANE(data, 0)];
>         v |= expand4[GET_PLANE(data, 1)] << 1;
> @@ -242,6 +242,7 @@ static void vga_draw_line8d2(VGACommonState *vga, uint8_t *d,
>     palette = vga->last_palette;
>     width >>= 3;
>     for(x = 0; x < width; x++) {
> +        addr &= VGA_VRAM_SIZE - 1;
>         PUT_PIXEL2(d, 0, palette[vga_read_byte(vga, addr + 0)]);
>         PUT_PIXEL2(d, 1, palette[vga_read_byte(vga, addr + 1)]);
>         PUT_PIXEL2(d, 2, palette[vga_read_byte(vga, addr + 2)]);
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 3bd357d72c2..b1660bdde67 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -47,6 +47,9 @@ bool have_vga = true;
> /* 16 state changes per vertical frame @60 Hz */
> #define VGA_TEXT_CURSOR_PERIOD_MS       (1000 * 2 * 16 / 60)
>
> +/* Address mask for non-VESA modes.  */
> +#define VGA_VRAM_SIZE                   262144

(256 * KiB) maybe?

> +
> /*
>  * Video Graphics Array (VGA)
>  *
>

