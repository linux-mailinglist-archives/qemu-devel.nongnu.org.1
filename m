Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C88167AC
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 08:48:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF8Ld-00082o-Jr; Mon, 18 Dec 2023 02:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF8LX-00082D-FI
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:47:27 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF8LV-00054W-Ul
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:47:27 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b9dbbaa9a9so2890340b6e.2
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 23:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702885644; x=1703490444;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jucccWgk/Kxq2dFCJ5wbzgrcreNTTg8rBfXRP/FGVIo=;
 b=0BlYzSYWdrDISe4qnf8PBS51GHfyQzVvGJK88yTqE808CXmxSEuMLg+amAu0a5IHMt
 ZseMDxBzptOwx2S4Kffl9J882XOeDl0ysrtJZxuvqCpyVZOxpn8R2VHKcmUgquIQp8ar
 WYBH4it6Y/QCSltnEP+5V/I249E1870YemOLrzJC3R5KrrNysvEKesysSTiYR+O/1115
 FVFtAyimaPtKw4/xSZwpSHFEQygD1QaZcjAzJ2fh+QDYQuJNsGEyQze46JrgixwJZ7xr
 7jttqV1tGhXAVu27WPcoWvoDoJabfFsygpFdgUClVaJAaPepfkLu2yQHZAuELrVkByMT
 BkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702885644; x=1703490444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jucccWgk/Kxq2dFCJ5wbzgrcreNTTg8rBfXRP/FGVIo=;
 b=SUVH1jxfGtQ3P5p+c/SFRm8fIPsqHwsQq8I4zTSiU+2k2qsgEJtm4IYWfQa3LNNvo6
 NHfjxQ1drU6eI9DTIfLeK0FAHKnadrBPN83Fh4MHx4K09c7loeX9sSzhAZZd01CsIype
 aVeL34nd7oDK5bKekVNSBEb2ge1wyxRMtRuFQiLPkKMx7fd48JgrrX7gVHVhf7vnZF7S
 YFa6xQEXCV6xg/7bJuD5wMCltYe3GDDYZj3RNnxyt+wxA9e6ZUAtr4jrEau6QUKuVUDm
 sS2/YSrlL/0CrN0CUrn4HpMCeCxop1I6Fw+/x8a8gfFwDW2LG5UuZTNY/TUEO9vb8CZq
 shGw==
X-Gm-Message-State: AOJu0YwmVlyCMgxvWzsuOjJw9mUUACoP6GJD4tTtNtMbwvnMMBlGLcpr
 JLUUk8PEbRkpgDICa3xD3bAG1A==
X-Google-Smtp-Source: AGHT+IEOW7bxlPrkAFna65Hm0qUKW2CUqWQ66zMHq68bjVUKCDd0VRX6O5IH9VmOsPcJYSH53XY5ZQ==
X-Received: by 2002:a05:6808:1509:b0:3b8:5fec:5d6 with SMTP id
 u9-20020a056808150900b003b85fec05d6mr21142581oiw.27.1702885644702; 
 Sun, 17 Dec 2023 23:47:24 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 m18-20020a62f212000000b006ce2e77ec4csm301145pfh.193.2023.12.17.23.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 23:47:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Dec 2023 16:47:03 +0900
Subject: [PATCH v8 3/3] ui/cocoa: Remove stretch_video flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-cocoa-v8-3-d7fad80c7ef6@daynix.com>
References: <20231218-cocoa-v8-0-d7fad80c7ef6@daynix.com>
In-Reply-To: <20231218-cocoa-v8-0-d7fad80c7ef6@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Evaluate [normalWindow styleMask] & NSWindowStyleMaskResizable instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 1357690e50ca..05f7854f9819 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -103,7 +103,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
 
-static bool stretch_video;
 static NSTextField *pauseLabel;
 
 static bool allow_events;
@@ -1374,8 +1373,7 @@ - (void)showQEMUDoc:(id)sender
 /* Stretches video to fit host monitor size */
 - (void)zoomToFit:(id) sender
 {
-    stretch_video = !stretch_video;
-    if (stretch_video == true) {
+    if (([normalWindow styleMask] & NSWindowStyleMaskResizable) == 0) {
         [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
         [sender setState: NSControlStateValueOn];
     } else {
@@ -1647,7 +1645,7 @@ static void create_initial_menus(void)
     menu = [[NSMenu alloc] initWithTitle:@"View"];
     [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
-    [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
+    [menuItem setState: [normalWindow styleMask] & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
     [menu addItem: menuItem];
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
     [menuItem setSubmenu:menu];
@@ -2040,7 +2038,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     }
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
-        stretch_video = true;
         [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
     }
 

-- 
2.43.0


