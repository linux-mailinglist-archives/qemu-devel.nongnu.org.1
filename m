Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E6578D5EF
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 14:43:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbKVo-0008JL-G7; Wed, 30 Aug 2023 08:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qbKUg-0008F2-Nc
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 08:40:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qbKUY-0000CM-TX
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 08:40:22 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AD1C6756A30;
 Wed, 30 Aug 2023 14:39:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 79731756201; Wed, 30 Aug 2023 14:39:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 77B7B748FF4;
 Wed, 30 Aug 2023 14:39:48 +0200 (CEST)
Date: Wed, 30 Aug 2023 14:39:48 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 09/67] ui/console: get the DisplayState from new_console()
In-Reply-To: <20230830093843.3531473-10-marcandre.lureau@redhat.com>
Message-ID: <5d9e1a88-2808-dc08-a50c-128e0d2d9fcc@eik.bme.hu>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1722485881-1693399188=:10171"
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

--3866299591-1722485881-1693399188=:10171
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 30 Aug 2023, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> There is no obvious reason to defer text console initialization. We can
> simply take the global display state in new_console().
>
> This simplify somewhat the code to allow moving the VC to a separate unit.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> ui/console.c | 26 ++++++++------------------
> 1 file changed, 8 insertions(+), 18 deletions(-)
>
> diff --git a/ui/console.c b/ui/console.c
> index fc1836782d..ba79c735b7 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -143,7 +143,7 @@ static QTAILQ_HEAD(, QemuConsole) consoles =
> static bool cursor_visible_phase;
> static QEMUTimer *cursor_timer;
>
> -static void text_console_do_init(Chardev *chr, DisplayState *ds);
> +static void text_console_do_init(Chardev *chr);
> static void dpy_refresh(DisplayState *s);
> static DisplayState *get_alloc_displaystate(void);
> static void text_console_update_cursor_timer(void);
> @@ -1249,9 +1249,10 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
>     }
> }
>
> -static QemuConsole *new_console(DisplayState *ds, console_type_t console_type,
> +static QemuConsole *new_console(console_type_t console_type,
>                                 uint32_t head)

It should be possible to remove the new line and fit it in one line now 
too.

Regards,
BALATON Zoltan
--3866299591-1722485881-1693399188=:10171--

