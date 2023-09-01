Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A2790145
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:18:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc7m9-0003yt-Jy; Fri, 01 Sep 2023 13:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc7m7-0003yU-95
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc7m4-0006RL-SY
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693588655;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IIlGVxLVvCF8sWnGbpDDipgOc+E051rAThpWzgNTbZw=;
 b=Zrp1/O0LDxWcfqOlSadHy0JXZ78bynBb/nRq4952mbabF66p2EOuOvrO3vcMY9+zzI0Cuy
 4Y8wN8GjHm9UZMWmeGu85wC17832Q7608sDFV1VPvoB+PIKTA72OujJrLzGv+usoyXmsMX
 /tgt0tFGNwOMfzcujfcIk4yjBSDelo4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-iEUYDWWCM3ekf91FLU7nWw-1; Fri, 01 Sep 2023 13:17:32 -0400
X-MC-Unique: iEUYDWWCM3ekf91FLU7nWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36BEB90A7E1;
 Fri,  1 Sep 2023 17:17:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 254FE6B5AA;
 Fri,  1 Sep 2023 17:17:31 +0000 (UTC)
Date: Fri, 1 Sep 2023 18:17:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH 46/67] ui/vc: =?utf-8?Q?rename_?=
 =?utf-8?B?a2JkX3B1dCDihpI=?= qemu_text_console functions
Message-ID: <ZPIcqZLTm4j4Yh3O@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-47-marcandre.lureau@redhat.com>
 <67a794e5-4208-b413-c274-03bad36e3c24@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67a794e5-4208-b413-c274-03bad36e3c24@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On Wed, Aug 30, 2023 at 05:41:51PM +0200, Philippe Mathieu-Daudé wrote:
> On 30/8/23 11:38, marcandre.lureau@redhat.com wrote:
> > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > 
> > They are QemuTextConsole functions, let's make it clear.
> > 
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/ui/console.h |  6 ++---
> >   ui/console.c         | 10 ++++----
> >   ui/curses.c          |  2 +-
> >   ui/gtk.c             |  6 ++---
> >   ui/sdl2-input.c      |  4 ++--
> >   ui/sdl2.c            |  2 +-
> >   ui/vnc.c             | 54 ++++++++++++++++++++++----------------------
> >   ui/cocoa.m           |  2 +-
> >   8 files changed, 43 insertions(+), 43 deletions(-)
> > 
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index 9c362f0e87..26d63d17a2 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -112,9 +112,9 @@ bool qemu_mouse_set(int index, Error **errp);
> >   #define QEMU_KEY_CTRL_PAGEUP     0xe406
> >   #define QEMU_KEY_CTRL_PAGEDOWN   0xe407
> > -void kbd_put_keysym_console(QemuTextConsole *s, int keysym);
> > -bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl);
> > -void kbd_put_string_console(QemuTextConsole *s, const char *str, int len);
> > +void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym);
> > +bool qemu_text_console_put_qcode(QemuTextConsole *s, int qcode, bool ctrl);
> > +void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len);
> 
> 
> > diff --git a/ui/cocoa.m b/ui/cocoa.m
> > index 9eb4da7713..8b97319587 100644
> > --- a/ui/cocoa.m
> > +++ b/ui/cocoa.m
> > @@ -784,7 +784,7 @@ - (void) handleMonitorInput:(NSEvent *)event
> >       }
> >       if (keysym) {
> > -        kbd_put_keysym_console(NULL, keysym);
> > +        qemu_text_console_keysym(NULL, keysym);
> >       }
> >   }
> 
> ../../ui/cocoa.m:787:9: error: call to undeclared function
> 'qemu_text_console_keysym'; ISO C99 and later do not support implicit
> function declarations [-Wimplicit-function-declaration]
>         qemu_text_console_keysym(NULL, keysym);
>         ^
> 
> I can compile using:
> 
> -- >8 --
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 8b97319587..b886db7510 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -784,7 +784,7 @@ - (void) handleMonitorInput:(NSEvent *)event
>      }
> 
>      if (keysym) {
> -        qemu_text_console_keysym(NULL, keysym);
> +        qemu_text_console_put_keysym(NULL, keysym);
>      }
>  }

With that change added

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


