Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D857EAFD5
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 13:28:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2sWB-00034w-Dt; Tue, 14 Nov 2023 07:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r2sW8-00034l-Rv
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 07:27:44 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r2sW6-0006ka-A3
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 07:27:44 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2075E75A4B9;
 Tue, 14 Nov 2023 13:28:07 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 13BA675A4B7; Tue, 14 Nov 2023 13:28:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 10E5575A406;
 Tue, 14 Nov 2023 13:28:07 +0100 (CET)
Date: Tue, 14 Nov 2023 13:28:07 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
cc: Kamay Xutax <admin@xutaxkamay.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC v1 1/1] ui/sdl2: clipboard sharing implementation
 for SDL
In-Reply-To: <CAJ+F1CL=+Lwykncp83dh7SfJqB9vniAU6pKoyzLhahkaKJX01Q@mail.gmail.com>
Message-ID: <5c80a8c7-7a1d-d23d-c0c0-829e99f750e1@eik.bme.hu>
References: <20231108022139.12503-1-admin@xutaxkamay.com>
 <20231108022139.12503-2-admin@xutaxkamay.com>
 <CAJ+F1CL=+Lwykncp83dh7SfJqB9vniAU6pKoyzLhahkaKJX01Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-79477498-1699964887=:47195"
X-Virus-Scanned: ClamAV using ClamSMTP
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-79477498-1699964887=:47195
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 14 Nov 2023, Marc-André Lureau wrote:
> Hi
>
> On Wed, Nov 8, 2023 at 7:56 PM Kamay Xutax <admin@xutaxkamay.com> wrote:
>>
>> Signed-off-by: Kamay Xutax <admin@xutaxkamay.com>
>> ---
>>  include/ui/sdl2.h   |   5 ++
>>  meson.build         |   1 +
>>  ui/meson.build      |   1 +
>>  ui/sdl2-clipboard.c | 147 ++++++++++++++++++++++++++++++++++++++++++++
>>  ui/sdl2.c           |   8 +++
>>  5 files changed, 162 insertions(+)
>>  create mode 100644 ui/sdl2-clipboard.c
>>
>> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
>> index e3acc7c82a..120fe6f856 100644
>> --- a/include/ui/sdl2.h
>> +++ b/include/ui/sdl2.h
>> @@ -21,6 +21,7 @@
>>  # include <SDL_image.h>
>>  #endif
>>
>> +#include "ui/clipboard.h"
>>  #include "ui/kbd-state.h"
>>  #ifdef CONFIG_OPENGL
>>  # include "ui/egl-helpers.h"
>> @@ -51,6 +52,7 @@ struct sdl2_console {
>>      bool y0_top;
>>      bool scanout_mode;
>>  #endif
>> +    QemuClipboardPeer cbpeer;
>>  };
>>
>>  void sdl2_window_create(struct sdl2_console *scon);
>> @@ -70,6 +72,9 @@ void sdl2_2d_redraw(struct sdl2_console *scon);
>>  bool sdl2_2d_check_format(DisplayChangeListener *dcl,
>>                            pixman_format_code_t format);
>>
>> +void sdl2_clipboard_handle_request(struct sdl2_console *scon);
>> +void sdl2_clipboard_init(struct sdl2_console *scon);
>> +
>>  void sdl2_gl_update(DisplayChangeListener *dcl,
>>                      int x, int y, int w, int h);
>>  void sdl2_gl_switch(DisplayChangeListener *dcl,
>> diff --git a/meson.build b/meson.build
>> index 4848930680..1358d14b2e 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2157,6 +2157,7 @@ config_host_data.set('CONFIG_RDMA', rdma.found())
>>  config_host_data.set('CONFIG_RELOCATABLE', get_option('relocatable'))
>>  config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
>>  config_host_data.set('CONFIG_SDL', sdl.found())
>> +config_host_data.set('CONFIG_SDL_CLIPBOARD', sdl.found())
>
> 'gtk_clipboard' option is there because it has some issues with the
> glib loop - see https://gitlab.com/qemu-project/qemu/-/issues/1150.
>
> Apparently this code could have similar kind of issues, since it's
> reentering the main loop too.  it might be worth to have a similar
> option and disclaimer...
>
>
>>  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
>>  config_host_data.set('CONFIG_SECCOMP', seccomp.found())
>>  if seccomp.found()
>> diff --git a/ui/meson.build b/ui/meson.build
>> index 0ccb3387ee..0cadd1a18f 100644
>> --- a/ui/meson.build
>> +++ b/ui/meson.build
>> @@ -125,6 +125,7 @@ if sdl.found()
>>    sdl_ss = ss.source_set()
>>    sdl_ss.add(sdl, sdl_image, pixman, glib, files(
>>      'sdl2-2d.c',
>> +    'sdl2-clipboard.c',
>>      'sdl2-input.c',
>>      'sdl2.c',
>>    ))
>> diff --git a/ui/sdl2-clipboard.c b/ui/sdl2-clipboard.c
>> new file mode 100644
>> index 0000000000..405bb9ea8b
>> --- /dev/null
>> +++ b/ui/sdl2-clipboard.c
>> @@ -0,0 +1,147 @@
>> +/*
>> + * SDL UI -- clipboard support
>> + *
>> + * Copyright (C) 2023 Kamay Xutax <admin@xutaxkamay.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/main-loop.h"
>> +#include "ui/sdl2.h"
>> +
>> +static void sdl2_clipboard_update(struct sdl2_console *scon,
>> +                                  QemuClipboardInfo *info)
>> +{
>> +    bool self_update = info->owner == &scon->cbpeer;
>> +    char *text;
>> +    size_t text_size;
>> +
>> +    /*
>> +     * In case of a self update,
>> +     * set again the text in SDL
>> +     *
>> +     * This is a workaround for hosts that have clipboard history
>> +     * or when they're copying again something,
>> +     * so that SDL can accept a new request from the host
>> +     * and make a new SDL_CLIPBOARDUPDATE event
>> +     */
>> +
>> +    if (self_update) {
>> +        text = SDL_GetClipboardText();
>> +        SDL_SetClipboardText(text);
>> +        SDL_free(text);
>> +        return;
>> +    }
>
> Isn't this basically doing the work of a clipboard manager? it takes
> the current clipboard data and makes qemu the new owner. It looks like
> it could also run in a loop quite easily if it fights with a manager.
>
>> +
>> +    if (!info->types[QEMU_CLIPBOARD_TYPE_TEXT].available) {
>> +        return;
>> +    }
>> +
>> +    info = qemu_clipboard_info_ref(info);
>> +    qemu_clipboard_request(info, QEMU_CLIPBOARD_TYPE_TEXT);
>> +
>> +    while (info == qemu_clipboard_info(info->selection) &&
>> +           info->types[QEMU_CLIPBOARD_TYPE_TEXT].available &&
>> +           info->types[QEMU_CLIPBOARD_TYPE_TEXT].data == NULL) {
>> +        main_loop_wait(false);
>
> Reentering the loop, that's annoying... same as gtk-clipboard.c..
>
> Have you tried to defer the handling of the update? That will add
> extra state & logic though.
>
>> +    }
>> +
>> +    /* clipboard info changed while waiting for data */
>> +    if (info != qemu_clipboard_info(info->selection)) {
>> +        qemu_clipboard_info_unref(info);
>> +        return;
>> +    }
>> +
>> +    /* text is not null terminated in cb info, so we need to copy it */
>> +    text_size = info->types[QEMU_CLIPBOARD_TYPE_TEXT].size;
>
> hmm, I wonder why.. isn't it something we could fix from
> qemu_clipboard_set_data() callers?
>
> (gtk_selection_data_set_text() doc says it should be \0 terminated,
> although it seems not required when len is given).
>
> I am not sure if the spice/vdagent ensures \0 terminated strings, but
> the qemu code could adjust it as necessary.

What if copied text contains \0?

Regards,
BALATON Zoltan

>> +    if (!text_size) {
>> +        qemu_clipboard_info_unref(info);
>> +        return;
>> +    }
>> +
>> +    text = malloc(text_size + 1);
>
> We use g_malloc() and g_free() (even better with g_autofree).
>
>> +
>> +    if (!text) {
>
> Then, no need to check for NULL results (it aborts on OOM).
>
>> +        qemu_clipboard_info_unref(info);
>> +        return;
>> +    }
>> +
>> +    text[text_size] = 0;
>> +    memcpy(text, info->types[QEMU_CLIPBOARD_TYPE_TEXT].data, text_size);
>> +    /* unref as soon we copied the text */
>> +    qemu_clipboard_info_unref(info);
>> +    SDL_SetClipboardText(text);
>> +
>> +    free(text);
>> +}
>> +
>> +static void sdl2_clipboard_notify(Notifier *notifier,
>> +                                  void *data)
>> +{
>> +    QemuClipboardNotify *notify = data;
>> +    struct sdl2_console *scon =
>> +        container_of(notifier, struct sdl2_console, cbpeer.notifier);
>> +
>> +    switch (notify->type) {
>> +    case QEMU_CLIPBOARD_UPDATE_INFO:
>> +        sdl2_clipboard_update(scon, notify->info);
>> +        break;
>> +    case QEMU_CLIPBOARD_RESET_SERIAL:
>> +        break;
>> +    }
>> +}
>> +
>> +static void sdl2_clipboard_request(QemuClipboardInfo *info,
>> +                                   QemuClipboardType type)
>> +{
>> +    struct sdl2_console *scon =
>> +        container_of(info->owner, struct sdl2_console, cbpeer);
>> +    char *text;
>> +
>> +    switch (type) {
>> +    case QEMU_CLIPBOARD_TYPE_TEXT:
>> +        if (!SDL_HasClipboardText()) {
>> +            return;
>> +        }
>> +
>> +        text = SDL_GetClipboardText();
>> +        qemu_clipboard_set_data(&scon->cbpeer, info, type,
>> +                                strlen(text), text, true);
>
> strlen() + 1  to have \0 then? (other backends would need similar fix)
>
>> +
>> +        SDL_free(text);
>> +        break;
>> +    default:
>> +        return;
>> +    }
>> +}
>> +
>> +void sdl2_clipboard_handle_request(struct sdl2_console *scon)
>> +{
>> +    g_autoptr(QemuClipboardInfo) info =
>> +        qemu_clipboard_info_new(&scon->cbpeer,
>> +                                QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
>> +
>> +    sdl2_clipboard_request(info, QEMU_CLIPBOARD_TYPE_TEXT);
>> +}
>> +
>> +void sdl2_clipboard_init(struct sdl2_console *scon)
>> +{
>> +    scon->cbpeer.name = "sdl2";
>> +    scon->cbpeer.notifier.notify = sdl2_clipboard_notify;
>> +    /* requests will be handled from the SDL event loop */
>> +    qemu_clipboard_peer_register(&scon->cbpeer);
>> +}
>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>> index fbfdb64e90..d674add7c5 100644
>> --- a/ui/sdl2.c
>> +++ b/ui/sdl2.c
>> @@ -702,6 +702,11 @@ void sdl2_poll_events(struct sdl2_console *scon)
>>          case SDL_WINDOWEVENT:
>>              handle_windowevent(ev);
>>              break;
>> +#if defined(CONFIG_SDL_CLIPBOARD)
>> +        case SDL_CLIPBOARDUPDATE:
>> +            sdl2_clipboard_handle_request(scon);
>> +            break;
>> +#endif
>>          default:
>>              break;
>>          }
>> @@ -922,6 +927,9 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>>              qemu_console_set_window_id(con, info.info.x11.window);
>>  #endif
>>          }
>> +#endif
>> +#if defined(CONFIG_SDL_CLIPBOARD)
>> +        sdl2_clipboard_init(&sdl2_console[i]);
>>  #endif
>>      }
>>
>> --
>> 2.41.0
>>
>>
>
>
>
--3866299591-79477498-1699964887=:47195--

