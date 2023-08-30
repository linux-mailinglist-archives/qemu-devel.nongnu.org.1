Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D578E116
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 23:00:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbSHd-0002ym-Bf; Wed, 30 Aug 2023 16:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbSHZ-0002xz-UI
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:59:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbSHW-0005Wq-CX
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:59:21 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68a41031768so74378b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693429157; x=1694033957;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wbL1fIbhmTVRk4qojZjcLCl7ayMRcu1GV490/gv6xGE=;
 b=U4mH2kKkvRkYQniJYt/ci4AcFSnj7qhyoCgUvkOrsbv9GmRoJPoWyPEuOCVxEVxfxL
 d+gIt39Dg6BvIxvr9gkXBY3LpnjnqALN3R1IZCmzVfjMdShH3/HgADQdWxKBxZIbijV4
 C3XVMmqMET3bJc6QQtdBxWPcyDRukEQDXrwKG1IhH5js9v5WdffwEgkKQzz3DOYyyrJE
 mLLv7s9sXLXt/vVvplvJ/3ytom93bFTDq5OjPinZY5AGj2vIaoCYsNGyJg/LNScvW6k9
 jaUMulLlf8Pim/sbsoS8GnNE3XVpNNd2wiDzkCH7UxbmBGtHyrrSm3txhp7V398As74z
 kBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693429157; x=1694033957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wbL1fIbhmTVRk4qojZjcLCl7ayMRcu1GV490/gv6xGE=;
 b=dm8x19zdAkg1UDUcUbLLSdofftpPdjufR7of3u9Ltlu2GDhQ4qm7NdEUFEkGn1Ep9p
 76uljZEPGPq5HYCFheBYRV5N5kinqb1dS/ECoeLRYLc9sYidGBwxCdO3E64WLk5pXUTj
 8qSbBm1l+GK8vWqn1LIIj47KaiI1nDgibyrDMrTddJzptOomCyXDs9K53S9dKjV90p5V
 8HIzGhv/qj8r3rt97RP7BU+MpbxPfQU1Z1DY69z9g0Cmg/j1vOKG+B/EmnXwSrJT/SiF
 CRvUdVOXDDqjd/OTmbzWycjgpMmp8XSzAU8gJiDkRQLo/CRLBWpCTziVod5H8qy3PKUY
 +6Sg==
X-Gm-Message-State: AOJu0YyYxK05lUCP9yWOQZ+nEn/ZOKTnzfwE1iL+BENkCfp7c+nTMfo8
 v3ji8a3JOgLPJPyNd368HCtqlw==
X-Google-Smtp-Source: AGHT+IG9M1kS+amkXW/uvuh7FcyMpB+M83JezV8AeMwiM9O7Be7s/ePo37CyX0RqivlywFOrCBg72w==
X-Received: by 2002:a05:6a20:a10f:b0:14d:6309:fc92 with SMTP id
 q15-20020a056a20a10f00b0014d6309fc92mr4100498pzk.46.1693429156827; 
 Wed, 30 Aug 2023 13:59:16 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a170902db0600b001b8b2b95068sm11546942plx.204.2023.08.30.13.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 13:59:16 -0700 (PDT)
Message-ID: <96a49f28-d92c-4910-9f24-b031212ccfc2@daynix.com>
Date: Thu, 31 Aug 2023 05:59:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 45/67] ui/vc: remove kby_put_keysym() and update function
 calls
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-46-marcandre.lureau@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230830093843.3531473-46-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/08/30 18:38, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The function calls to `kbd_put_keysym` have been updated to now call
> `kbd_put_keysym_console` with a NULL console parameter.
> 
> Like most console functions, NULL argument is now for the active console.
> 
> This will allow to rename the text console functions in a consistent manner.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h |  1 -
>   ui/console.c         | 14 ++++++------
>   ui/curses.c          |  2 +-
>   ui/vnc.c             | 54 ++++++++++++++++++++++----------------------
>   ui/cocoa.m           |  2 +-
>   5 files changed, 36 insertions(+), 37 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 1ccd432b4d..9c362f0e87 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -115,7 +115,6 @@ bool qemu_mouse_set(int index, Error **errp);
>   void kbd_put_keysym_console(QemuTextConsole *s, int keysym);
>   bool kbd_put_qcode_console(QemuTextConsole *s, int qcode, bool ctrl);
>   void kbd_put_string_console(QemuTextConsole *s, const char *str, int len);
> -void kbd_put_keysym(int keysym);
>   
>   /* Touch devices */
>   typedef struct touch_slot {
> diff --git a/ui/console.c b/ui/console.c
> index a98adbb1b2..6068e02928 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1141,6 +1141,13 @@ void kbd_put_keysym_console(QemuTextConsole *s, int keysym)
>       int c;
>       uint32_t num_free;
>   
> +    if (!s) {
> +        if (!QEMU_IS_TEXT_CONSOLE(active_console)) {
> +            return;
> +        }
> +        s = QEMU_TEXT_CONSOLE(active_console);
> +    }
> +
>       switch(keysym) {
>       case QEMU_KEY_CTRL_UP:
>           console_scroll(s, -1);
> @@ -1231,13 +1238,6 @@ void kbd_put_string_console(QemuTextConsole *s, const char *str, int len)
>       }
>   }
>   
> -void kbd_put_keysym(int keysym)
> -{
> -    if (QEMU_IS_TEXT_CONSOLE(active_console)) {
> -        kbd_put_keysym_console(QEMU_TEXT_CONSOLE(active_console), keysym);
> -    }
> -}
> -
>   static void text_console_invalidate(void *opaque)
>   {
>       QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
> diff --git a/ui/curses.c b/ui/curses.c
> index de962faa7c..4ddbbae7cd 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -400,7 +400,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
>               if (keysym == -1)
>                   keysym = chr;
>   
> -            kbd_put_keysym(keysym);
> +            kbd_put_keysym_console(NULL, keysym);
>           }
>       }
>   }
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 92964dcc0c..1fa4456744 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1945,88 +1945,88 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
>               case 0xb8:                          /* Right ALT */
>                   break;
>               case 0xc8:
> -                kbd_put_keysym(QEMU_KEY_UP);
> +                kbd_put_keysym_console(NULL, QEMU_KEY_UP);

vs->vd->dcl.con should be used instead. There may be VNC connections for 
consoles other than the "active console" and in such a case 
vs->vd->dcl.con != NULL. Unfortunately it seems that ui/vnc is very 
buggy in such a situation.

>                   break;
>               case 0xd0:
> -                kbd_put_keysym(QEMU_KEY_DOWN);
> +                kbd_put_keysym_console(NULL, QEMU_KEY_DOWN);
>                   break;
>               case 0xcb:
> -                kbd_put_keysym(QEMU_KEY_LEFT);
> +                kbd_put_keysym_console(NULL, QEMU_KEY_LEFT);
>                   break;
>               case 0xcd:
> -                kbd_put_keysym(QEMU_KEY_RIGHT);
> +                kbd_put_keysym_console(NULL, QEMU_KEY_RIGHT);
>                   break;
>               case 0xd3:
> -                kbd_put_keysym(QEMU_KEY_DELETE);
> +                kbd_put_keysym_console(NULL, QEMU_KEY_DELETE);
>                   break;
>               case 0xc7:
> -                kbd_put_keysym(QEMU_KEY_HOME);
> +                kbd_put_keysym_console(NULL, QEMU_KEY_HOME);
>                   break;
>               case 0xcf:
> -                kbd_put_keysym(QEMU_KEY_END);
> +                kbd_put_keysym_console(NULL, QEMU_KEY_END);
>                   break;
>               case 0xc9:
> -                kbd_put_keysym(QEMU_KEY_PAGEUP);
> +                kbd_put_keysym_console(NULL, QEMU_KEY_PAGEUP);
>                   break;
>               case 0xd1:
> -                kbd_put_keysym(QEMU_KEY_PAGEDOWN);
> +                kbd_put_keysym_console(NULL, QEMU_KEY_PAGEDOWN);
>                   break;
>   
>               case 0x47:
> -                kbd_put_keysym(numlock ? '7' : QEMU_KEY_HOME);
> +                kbd_put_keysym_console(NULL, numlock ? '7' : QEMU_KEY_HOME);
>                   break;
>               case 0x48:
> -                kbd_put_keysym(numlock ? '8' : QEMU_KEY_UP);
> +                kbd_put_keysym_console(NULL, numlock ? '8' : QEMU_KEY_UP);
>                   break;
>               case 0x49:
> -                kbd_put_keysym(numlock ? '9' : QEMU_KEY_PAGEUP);
> +                kbd_put_keysym_console(NULL, numlock ? '9' : QEMU_KEY_PAGEUP);
>                   break;
>               case 0x4b:
> -                kbd_put_keysym(numlock ? '4' : QEMU_KEY_LEFT);
> +                kbd_put_keysym_console(NULL, numlock ? '4' : QEMU_KEY_LEFT);
>                   break;
>               case 0x4c:
> -                kbd_put_keysym('5');
> +                kbd_put_keysym_console(NULL, '5');
>                   break;
>               case 0x4d:
> -                kbd_put_keysym(numlock ? '6' : QEMU_KEY_RIGHT);
> +                kbd_put_keysym_console(NULL, numlock ? '6' : QEMU_KEY_RIGHT);
>                   break;
>               case 0x4f:
> -                kbd_put_keysym(numlock ? '1' : QEMU_KEY_END);
> +                kbd_put_keysym_console(NULL, numlock ? '1' : QEMU_KEY_END);
>                   break;
>               case 0x50:
> -                kbd_put_keysym(numlock ? '2' : QEMU_KEY_DOWN);
> +                kbd_put_keysym_console(NULL, numlock ? '2' : QEMU_KEY_DOWN);
>                   break;
>               case 0x51:
> -                kbd_put_keysym(numlock ? '3' : QEMU_KEY_PAGEDOWN);
> +                kbd_put_keysym_console(NULL, numlock ? '3' : QEMU_KEY_PAGEDOWN);
>                   break;
>               case 0x52:
> -                kbd_put_keysym('0');
> +                kbd_put_keysym_console(NULL, '0');
>                   break;
>               case 0x53:
> -                kbd_put_keysym(numlock ? '.' : QEMU_KEY_DELETE);
> +                kbd_put_keysym_console(NULL, numlock ? '.' : QEMU_KEY_DELETE);
>                   break;
>   
>               case 0xb5:
> -                kbd_put_keysym('/');
> +                kbd_put_keysym_console(NULL, '/');
>                   break;
>               case 0x37:
> -                kbd_put_keysym('*');
> +                kbd_put_keysym_console(NULL, '*');
>                   break;
>               case 0x4a:
> -                kbd_put_keysym('-');
> +                kbd_put_keysym_console(NULL, '-');
>                   break;
>               case 0x4e:
> -                kbd_put_keysym('+');
> +                kbd_put_keysym_console(NULL, '+');
>                   break;
>               case 0x9c:
> -                kbd_put_keysym('\n');
> +                kbd_put_keysym_console(NULL, '\n');
>                   break;
>   
>               default:
>                   if (control) {
> -                    kbd_put_keysym(sym & 0x1f);
> +                    kbd_put_keysym_console(NULL, sym & 0x1f);
>                   } else {
> -                    kbd_put_keysym(sym);
> +                    kbd_put_keysym_console(NULL, sym);
>                   }
>                   break;
>               }
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 0c2153d17c..9eb4da7713 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -784,7 +784,7 @@ - (void) handleMonitorInput:(NSEvent *)event
>       }
>   
>       if (keysym) {
> -        kbd_put_keysym(keysym);
> +        kbd_put_keysym_console(NULL, keysym);
>       }
>   }
>   

