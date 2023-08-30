Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0209A78D5F2
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 14:45:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbKZA-0005To-6H; Wed, 30 Aug 2023 08:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qbKZ8-0005TR-91
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 08:44:58 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qbKZ4-0002QO-VS
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 08:44:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 47C4B7456AC;
 Wed, 30 Aug 2023 14:44:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0C9557456AA; Wed, 30 Aug 2023 14:44:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0A8987456A7;
 Wed, 30 Aug 2023 14:44:42 +0200 (CEST)
Date: Wed, 30 Aug 2023 14:44:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_37=2F67=5D_ui=2Fconsole=3A_rename_vga?=
 =?UTF-8?Q?=5F_functions_=E2=86=92_qemu=5Fconsole=5F?=
In-Reply-To: <20230830093843.3531473-38-marcandre.lureau@redhat.com>
Message-ID: <058a8394-afcd-614e-7848-e3897b2d76ab@eik.bme.hu>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-38-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1001586873-1693399482=:10171"
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

--3866299591-1001586873-1693399482=:10171
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 30 Aug 2023, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>

Maybe refrain from using unicode arrow in Subject: as it may show up 
wrongly with some fonts. Just write "replace ... with" or "rename ... to" 
instead which is also more normal looking sentence than with an arrow.

Regards,
BALATON Zoltan

> They are not specific to VGA. Let's use the object type name as prefix
> instead, to avoid confusion.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> ui/console.c | 25 ++++++++++++-------------
> 1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/ui/console.c b/ui/console.c
> index 88e37eaff3..a157a5b31c 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -331,9 +331,8 @@ void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata)
>     }
> }
>
> -static void vga_fill_rect(QemuConsole *con,
> -                          int posx, int posy, int width, int height,
> -                          pixman_color_t color)
> +static void qemu_console_fill_rect(QemuConsole *con, int posx, int posy,
> +                                   int width, int height, pixman_color_t color)
> {
>     DisplaySurface *surface = qemu_console_surface(con);
>     pixman_rectangle16_t rect = {
> @@ -345,8 +344,8 @@ static void vga_fill_rect(QemuConsole *con,
> }
>
> /* copy from (xs, ys) to (xd, yd) a rectangle of size (w, h) */
> -static void vga_bitblt(QemuConsole *con,
> -                       int xs, int ys, int xd, int yd, int w, int h)
> +static void qemu_console_bitblt(QemuConsole *con,
> +                                int xs, int ys, int xd, int yd, int w, int h)
> {
>     DisplaySurface *surface = qemu_console_surface(con);
>
> @@ -526,8 +525,8 @@ static void console_refresh(QemuTextConsole *s)
>     s->text_y[1] = s->height - 1;
>     s->cursor_invalidate = 1;
>
> -    vga_fill_rect(QEMU_CONSOLE(s), 0, 0, surface_width(surface), surface_height(surface),
> -                  color_table_rgb[0][QEMU_COLOR_BLACK]);
> +    qemu_console_fill_rect(QEMU_CONSOLE(s), 0, 0, surface_width(surface), surface_height(surface),
> +                           color_table_rgb[0][QEMU_COLOR_BLACK]);
>     y1 = s->y_displayed;
>     for (y = 0; y < s->height; y++) {
>         c = s->cells + y1 * s->width;
> @@ -605,12 +604,12 @@ static void vc_put_lf(VCChardev *vc)
>             s->text_x[1] = s->width - 1;
>             s->text_y[1] = s->height - 1;
>
> -            vga_bitblt(QEMU_CONSOLE(s), 0, FONT_HEIGHT, 0, 0,
> -                       s->width * FONT_WIDTH,
> -                       (s->height - 1) * FONT_HEIGHT);
> -            vga_fill_rect(QEMU_CONSOLE(s), 0, (s->height - 1) * FONT_HEIGHT,
> -                          s->width * FONT_WIDTH, FONT_HEIGHT,
> -                          color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
> +            qemu_console_bitblt(QEMU_CONSOLE(s), 0, FONT_HEIGHT, 0, 0,
> +                                s->width * FONT_WIDTH,
> +                                (s->height - 1) * FONT_HEIGHT);
> +            qemu_console_fill_rect(QEMU_CONSOLE(s), 0, (s->height - 1) * FONT_HEIGHT,
> +                                   s->width * FONT_WIDTH, FONT_HEIGHT,
> +                                   color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
>             s->update_x0 = 0;
>             s->update_y0 = 0;
>             s->update_x1 = s->width * FONT_WIDTH;
>
--3866299591-1001586873-1693399482=:10171--

