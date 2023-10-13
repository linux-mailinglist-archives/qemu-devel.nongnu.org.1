Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D577C803D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCwQ-0004w6-Op; Fri, 13 Oct 2023 03:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwN-0004s9-Eu
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCw9-0004Sd-V4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3296b49c546so1516028f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183419; x=1697788219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCbsT6AFnzVYF+57mPlA+zVrTDt7vf1WmOtihfcnrVs=;
 b=H7S6tquuwjkCzzuPEPYJSbAbEg12X1E38/3939iRUkHAGtz88DlLCIdZhi94adbEVv
 su3tDowlPtgNTx/crGcWcu28UvH6tFUwDUBY+vnsOhdOQFSCNv6W9EoS9fvEoBcdmE0/
 0LoWTeUiKq5vEzmtF9rNpae9o90gdd8c3gm+lnnktKiaVePyPZElX0A/fGYxqU+TEwCO
 qpciKIQivLqcMyj8xLTRcR2Z6+c2sCHZJBZT2m+dRX/viTt6rpmUZwQcyrMRNYbx+aiY
 TDM1Q0YraVOn9rHRUgNFvWfxw8GPmXAO9Iw0T/RaNbWnalvOiMJzCMQ5Haim0D5XVjM5
 i7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183419; x=1697788219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nCbsT6AFnzVYF+57mPlA+zVrTDt7vf1WmOtihfcnrVs=;
 b=MCeH914QjcgCqhgfnenWh8c3e/pMjq1Q97voYlKMxnhTz3U+S04HLd0gNZKFuv4B6J
 r829iUg/YCJfIji1qyVPatypHWfrAjLXU4/WqkYPpGJBHCp71ZPC8qI9XLoZprGmIZsV
 CUJJ4qiKGQ3piQzYNdTf0ZvAfPA4qZ2GXoALJ1OxPJRLKfLrQcjQ8qXa3bs5qqzoYrBF
 Y/y0EnctpCSqUXrjR3y8wGW0buobR5V4BY9b6En1R6grQRomZ6ITPXeg2A4qvIYYwf/5
 zzsNon6JFBfYEhDGZOp7HhxsotEJEjWxTbNkAfW5YuFlWFeI3lchJJgvmyz3XP3r0WT3
 6jUw==
X-Gm-Message-State: AOJu0YwWUUrVs3QUYtz6tySkPJuL41tbsM9VDuasyGu+SSi6gnQ4xKpN
 Yg5auQGBkMpsBsQu0VEyCJpd4hh3fg+sy/E1jTQ=
X-Google-Smtp-Source: AGHT+IEZpScgnfa3Dn9OiiQzUuPNL64rVlH/iSLiSmG27EWj4F10hp5VCjwElHCZVa4NDQQnKPVX1w==
X-Received: by 2002:a05:6000:80a:b0:32d:857c:d51c with SMTP id
 bt10-20020a056000080a00b0032d857cd51cmr7214301wrb.43.1697183419373; 
 Fri, 13 Oct 2023 00:50:19 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:18 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC PATCH 17/78] ui/sdl2.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:21 +0300
Message-Id: <b774031635094826bfc5e84f250763e4962683e8.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


