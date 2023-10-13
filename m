Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7917C7F8D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:09:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4X-0000dm-Gs; Fri, 13 Oct 2023 03:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD42-0000Az-ST
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:30 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD41-0006qz-4o
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:30 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c501bd6ff1so11698041fa.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183907; x=1697788707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCbsT6AFnzVYF+57mPlA+zVrTDt7vf1WmOtihfcnrVs=;
 b=ZLEtmxGAW4tWlq86KX2iNJParpZZJDHdY1RCCy493K0fq7K5J28IiHkFE8/D3yamG7
 RVexOPjNtSBRjWiSDYNrUowKahQdzKRIWnEqxZs0y3tI0EXfoIQXAGq3RJjGKZI2d9G4
 eCjrGJuSDI3MINeuE8r+ZGut9eDgjOy0gVhGxx08qkEKP+30qCEqHsmlwcx36WjX5q1n
 3oKGsmprLl541jpjmIGbLAo1M854w2PB4FaE+zlnAV1HysEzQx6SXLIvaxSoEaCAbtKZ
 barJXSEQX17JjjLQFANLd7uaCg4RSona2ipUZWXLyqnyc39XwUsdvC7W9xWci4C+UR3h
 xtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183907; x=1697788707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nCbsT6AFnzVYF+57mPlA+zVrTDt7vf1WmOtihfcnrVs=;
 b=YejU/szKvedxRU+KE8THUEeiKwruAzKpazBsSPH2TO9XHhwTM7yF6brq6NIpQGZe32
 V3T6T+YAAuJKuW+44ZgaXOwRYx3W72HmJIAOKTSDRjkuJG8hW9ucC8tWKZubZ+TzeB6t
 grl7hhFieBNtB2s1n0bYyxuOeZPbm2B0pFfVBJJkwbEi8Pf1HficHdowcON2pOYmpSJz
 WKO6Xhjiq5ifFihoED4NbQV1ABAZy6DNNKqFLrX+c6IXlaWesh4w5z2eJcqn0vCCUdzL
 vMcbKRoMt9tT07DmdUD6OoXuoVwTd9Vm3ilG7pW+sd0P99gEpgtK0o1Nh7SmniO+5FGv
 NrUA==
X-Gm-Message-State: AOJu0YwRHDH+mWWD/McJuw5Hly/hcrM6kaDXTaZ3FcUq28tNEqYvNCRr
 YklRw6ed89CHDQLiZ5GMsSwmW2zAUUt39dvcXC4=
X-Google-Smtp-Source: AGHT+IEaoD1HO+Rgd0qAvo6nimIOjJgaWNrY3XVaVj/nBGwgMRIlLlI2nR+4oDSJz1osWhb/ZlK2Lg==
X-Received: by 2002:a2e:801a:0:b0:2c0:c6a:d477 with SMTP id
 j26-20020a2e801a000000b002c00c6ad477mr24383014ljg.18.1697183907399; 
 Fri, 13 Oct 2023 00:58:27 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:26 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC PATCH v2 17/78] ui/sdl2.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:44 +0300
Message-Id: <b774031635094826bfc5e84f250763e4962683e8.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 ui/sdl2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index fbfdb64e90..3d157a14aa 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -576,78 +576,78 @@ static void handle_mousewheel(SDL_Event *ev)
 static void handle_windowevent(SDL_Event *ev)
 {
     struct sdl2_console *scon = get_scon_from_window(ev->window.windowID);
     bool allow_close = true;
 
     if (!scon) {
         return;
     }
 
     switch (ev->window.event) {
     case SDL_WINDOWEVENT_RESIZED:
         {
             QemuUIInfo info;
             memset(&info, 0, sizeof(info));
             info.width = ev->window.data1;
             info.height = ev->window.data2;
             dpy_set_ui_info(scon->dcl.con, &info, true);
         }
         sdl2_redraw(scon);
         break;
     case SDL_WINDOWEVENT_EXPOSED:
         sdl2_redraw(scon);
         break;
     case SDL_WINDOWEVENT_FOCUS_GAINED:
         win32_kbd_set_grab(gui_grab);
         if (qemu_console_is_graphic(scon->dcl.con)) {
             win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
         }
-        /* fall through */
+        fallthrough;
     case SDL_WINDOWEVENT_ENTER:
         if (!gui_grab && (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled)) {
             absolute_mouse_grab(scon);
         }
         /* If a new console window opened using a hotkey receives the
          * focus, SDL sends another KEYDOWN event to the new window,
          * closing the console window immediately after.
          *
          * Work around this by ignoring further hotkey events until a
          * key is released.
          */
         scon->ignore_hotkeys = get_mod_state();
         break;
     case SDL_WINDOWEVENT_FOCUS_LOST:
         if (qemu_console_is_graphic(scon->dcl.con)) {
             win32_kbd_set_window(NULL);
         }
         if (gui_grab && !gui_fullscreen) {
             sdl_grab_end(scon);
         }
         break;
     case SDL_WINDOWEVENT_RESTORED:
         update_displaychangelistener(&scon->dcl, GUI_REFRESH_INTERVAL_DEFAULT);
         break;
     case SDL_WINDOWEVENT_MINIMIZED:
         update_displaychangelistener(&scon->dcl, 500);
         break;
     case SDL_WINDOWEVENT_CLOSE:
         if (qemu_console_is_graphic(scon->dcl.con)) {
             if (scon->opts->has_window_close && !scon->opts->window_close) {
                 allow_close = false;
             }
             if (allow_close) {
                 shutdown_action = SHUTDOWN_ACTION_POWEROFF;
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
             }
         } else {
             SDL_HideWindow(scon->real_window);
             scon->hidden = true;
         }
         break;
     case SDL_WINDOWEVENT_SHOWN:
         scon->hidden = false;
         break;
     case SDL_WINDOWEVENT_HIDDEN:
         scon->hidden = true;
         break;
     }
 }
-- 
2.39.2


