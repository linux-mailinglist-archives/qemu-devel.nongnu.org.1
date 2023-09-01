Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 775D1790143
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:16:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc7kL-0003Bs-SJ; Fri, 01 Sep 2023 13:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc7kB-00036F-7Q
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc7k4-00064T-1o
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693588530;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYtNwc0zYcQZPgIxMZxR9ZD+r6EOapRaR/V7L6kOcdc=;
 b=N4EmF0YNFJFG0fd5o1DqZZF90xRWLPnCGXOlPqsw78ZVJ9jPzZQyIx0/VOF49P6pkO8Guq
 CehbxL83BZVArXfoxyuG0g30nZxld6Qi/SggGu6GiKEmkgnczpT23zmmkeVeSYDHJROprO
 FdTGBsYvULT+KXnhmLr8teoka5SU98s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-K38DhQOCMf6Ql2v8LxGrow-1; Fri, 01 Sep 2023 13:15:28 -0400
X-MC-Unique: K38DhQOCMf6Ql2v8LxGrow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8210A1817904
 for <qemu-devel@nongnu.org>; Fri,  1 Sep 2023 17:15:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8208049310F;
 Fri,  1 Sep 2023 17:15:26 +0000 (UTC)
Date: Fri, 1 Sep 2023 18:15:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 44/67] ui/vc: change the argument for QemuTextConsole
Message-ID: <ZPIcLeg9gDj4G93p@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-45-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830093843.3531473-45-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Aug 30, 2023 at 01:38:18PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Those functions are specifc to text/vc console, make that explicit from
> the argument type.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/ui/console.h |  6 +++---
>  ui/console.c         | 14 ++++++--------
>  ui/gtk.c             |  2 +-
>  ui/sdl2-input.c      |  5 +++--
>  ui/sdl2.c            |  5 ++---
>  5 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 91d8bbc9dc..1ccd432b4d 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -112,9 +112,9 @@ bool qemu_mouse_set(int index, Error **errp);
>  #define QEMU_KEY_CTRL_PAGEUP     0xe406
>  #define QEMU_KEY_CTRL_PAGEDOWN   0xe407
>  
> -void kbd_put_keysym_console(QemuConsole *s, int keysym);
> -bool kbd_put_qcode_console(QemuConsole *s, int qcode, bool ctrl);
> -void kbd_put_string_console(QemuConsole *s, const char *str, int len);
> +void kbd_put_keysym_console(QemuTextConsole *s, int keysym);
> +bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl);
> +void kbd_put_string_console(QemuTextConsole *s, const char *str, int len);
>  void kbd_put_keysym(int keysym);
>  
>  /* Touch devices */
> diff --git a/ui/console.c b/ui/console.c
> index 9fccecafd7..a98adbb1b2 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1135,16 +1135,12 @@ static void kbd_send_chars(QemuTextConsole *s)
>  }
>  
>  /* called when an ascii key is pressed */
> -void kbd_put_keysym_console(QemuConsole *con, int keysym)
> +void kbd_put_keysym_console(QemuTextConsole *s, int keysym)
>  {
> -    QemuTextConsole *s = (QemuTextConsole *)object_dynamic_cast(OBJECT(con), TYPE_QEMU_TEXT_CONSOLE);
>      uint8_t buf[16], *q;
>      int c;
>      uint32_t num_free;
>  
> -    if (!s)
> -        return;
> -
>      switch(keysym) {
>      case QEMU_KEY_CTRL_UP:
>          console_scroll(s, -1);
> @@ -1214,7 +1210,7 @@ static const int ctrl_qcode_to_keysym[Q_KEY_CODE__MAX] = {
>      [Q_KEY_CODE_PGDN]   = QEMU_KEY_CTRL_PAGEDOWN,
>  };
>  
> -bool kbd_put_qcode_console(QemuConsole *s, int qcode, bool ctrl)
> +bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl)
>  {
>      int keysym;
>  
> @@ -1226,7 +1222,7 @@ bool kbd_put_qcode_console(QemuConsole *s, int qcode, bool ctrl)
>      return true;
>  }
>  
> -void kbd_put_string_console(QemuConsole *s, const char *str, int len)
> +void kbd_put_string_console(QemuTextConsole *s, const char *str, int len)
>  {
>      int i;
>  
> @@ -1237,7 +1233,9 @@ void kbd_put_string_console(QemuConsole *s, const char *str, int len)
>  
>  void kbd_put_keysym(int keysym)
>  {
> -    kbd_put_keysym_console(active_console, keysym);
> +    if (QEMU_IS_TEXT_CONSOLE(active_console)) {
> +        kbd_put_keysym_console(QEMU_TEXT_CONSOLE(active_console), keysym);
> +    }
>  }
>  
>  static void text_console_invalidate(void *opaque)
> diff --git a/ui/gtk.c b/ui/gtk.c
> index ef98bb0648..c34c133550 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1187,7 +1187,7 @@ static gboolean gd_text_key_down(GtkWidget *widget,
>                                   GdkEventKey *key, void *opaque)
>  {
>      VirtualConsole *vc = opaque;
> -    QemuConsole *con = vc->gfx.dcl.con;
> +    QemuTextConsole *con = QEMU_TEXT_CONSOLE(vc->gfx.dcl.con);
>  
>      if (key->keyval == GDK_KEY_Delete) {
>          kbd_put_qcode_console(con, Q_KEY_CODE_DELETE, false);
> diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
> index f068382209..efc0e76e8c 100644
> --- a/ui/sdl2-input.c
> +++ b/ui/sdl2-input.c
> @@ -44,14 +44,15 @@ void sdl2_process_key(struct sdl2_console *scon,
>      qkbd_state_key_event(scon->kbd, qcode, ev->type == SDL_KEYDOWN);
>  
>      if (!qemu_console_is_graphic(con)) {

If i'm nit-picking I'd say change to be

   "if  (QEMU_IS_TEXT_CONSOLE(con)) {"

as you did in the other places in this patch

> +        QemuTextConsole *s = QEMU_TEXT_CONSOLE(con);
>          bool ctrl = qkbd_state_modifier_get(scon->kbd, QKBD_MOD_CTRL);
>          if (ev->type == SDL_KEYDOWN) {
>              switch (qcode) {
>              case Q_KEY_CODE_RET:
> -                kbd_put_keysym_console(con, '\n');
> +                kbd_put_keysym_console(s, '\n');
>                  break;
>              default:
> -                kbd_put_qcode_console(con, qcode, ctrl);
> +                kbd_put_qcode_console(s, qcode, ctrl);
>                  break;
>              }
>          }
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 0d91b555e3..16b515fcf9 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -483,10 +483,9 @@ static void handle_textinput(SDL_Event *ev)
>          return;
>      }
>  
> -    if (qemu_console_is_graphic(con)) {
> -        return;
> +    if (QEMU_IS_TEXT_CONSOLE(con)) {
> +        kbd_put_string_console(QEMU_TEXT_CONSOLE(con), ev->text.text, strlen(ev->text.text));
>      }
> -    kbd_put_string_console(con, ev->text.text, strlen(ev->text.text));
>  }
>  
>  static void handle_mousemotion(SDL_Event *ev)

With or without my suggestion:

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


