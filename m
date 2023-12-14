Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41830812831
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 07:33:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDfGt-0001sa-V8; Thu, 14 Dec 2023 01:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDfGq-0001sO-Vm
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 01:32:32 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDfGp-00045Y-BE
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 01:32:32 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6d9f9fbfd11so4079656a34.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 22:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702535550; x=1703140350;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ov3rb8PYlRjmKz4KISLbSUYoYrmOEGKl7hkNUEx9++U=;
 b=OK1a3kHqE0yVsRzEEsP6OGPbQhNcdWFqdcyoJB+/IhHCu89ftodb8QQC93CJBaZYIA
 UmZ2/8wJdHSTC3SgS86dHClSw/gA1DZWlzvKXGStwBYEs6jkDKWy/pFgCgtoQSdKqJ4R
 CZqHOWMFTJFahVIxA6V7+pFP++RB4W9BzoAzT14j97QrkVvwrQCXMrae+QKGWAZM0xa+
 Fsnv1cgE1QfATgKgHEBDpFRwueBQbLo9w/IZu696k1bRKMMVhW0pwOTHd12TP5xYFrDu
 WrWwJhA+FcmcEDzvwbvGFcaI0eqJ0b9n6C/ciUhtk0uIf6iUX+Lrd66CpnOwOUvLLGWJ
 WF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702535550; x=1703140350;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ov3rb8PYlRjmKz4KISLbSUYoYrmOEGKl7hkNUEx9++U=;
 b=jSYDvRbI0LwfLpZska/T8JPONZFAaxguInhIedNVvOTkavmgMIqm5b4IWCEtIZ9/o+
 QIlMAutXPEteu8wshV+5dWFLkyeUHtq2KHVNJHgMsF5fyD6um1fuW6e5ewEGLqhxmYDB
 s5MTMt0AduLZ78LT510iv9hKc54hLIORtsV4DBp/wS8uAZ1v6hikJCt6X5gwBybZoKDQ
 Ckc0dDXOpw+3X/k4YcbsXfqpeTtkeu1L+0bMYjXAqbiaAA0Bz5q9ljposz+2SbFg4sc7
 9n3ksISHPwQBkXnbFPOAYsCa2D77Mfi8TVcp0ebZ89TTfIJ5INcmpgG3Bxna1hkNVEYR
 +D/A==
X-Gm-Message-State: AOJu0YzBVE2VKMKEtbJ2jkPXUhMwrFKmPnqbHHLXghE/jD3feOAo+hog
 kqhpPhKVrAdOV4yDCAG3MvKNSQ==
X-Google-Smtp-Source: AGHT+IHegMoC2sYWv0YqGe/MRoO0MjHdlVbcZMVaIzpwEGadPUnyl8xu/VoAIFQQby7rC9DGXzpDxw==
X-Received: by 2002:a05:6358:63a2:b0:172:88c9:6743 with SMTP id
 k34-20020a05635863a200b0017288c96743mr1876578rwh.16.1702535550280; 
 Wed, 13 Dec 2023 22:32:30 -0800 (PST)
Received: from localhost ([157.82.200.183])
 by smtp.gmail.com with UTF8SMTPSA id
 g12-20020a170902c38c00b001d053ec1992sm2311697plg.83.2023.12.13.22.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 22:32:29 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 14 Dec 2023 15:31:36 +0900
Subject: [PATCH 2/2] qemu-options: Tell more for -display cocoa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-options-v1-2-113f347b0e3f@daynix.com>
References: <20231214-options-v1-0-113f347b0e3f@daynix.com>
In-Reply-To: <20231214-options-v1-0-113f347b0e3f@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Carwyn Ellis <carwynellis@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x331.google.com
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

Some options for -display cocoa were not described or not listed at all.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 qemu-options.hx | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 28aa26ceb508..13359d12944a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2088,6 +2088,7 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
 #if defined(CONFIG_COCOA)
     "-display cocoa[,full-grab=on|off][,swap-opt-cmd=on|off]\n"
     "              [,show-cursor=on|off][,left-command-key=on|off]\n"
+    "              [,full-screen=on|off][,zoom-to-fit=on|off]\n"
 #endif
 #if defined(CONFIG_OPENGL)
     "-display egl-headless[,rendernode=<file>]\n"
@@ -2189,10 +2190,26 @@ SRST
         provides drop-down menus and other UI elements to configure and
         control the VM during runtime. Valid parameters are:
 
+        ``full-grab=on|off`` : Capture all key presses, including system combos.
+                               This requires accessibility permissions, since it
+                               performs a global grab on key events.
+                               (default: off) See
+                               https://support.apple.com/en-in/guide/mac-help/mh32356/mac
+
+        ``swap-opt-cmd=on|off`` : Swap the Option and Command keys so that their
+                                  key codes match their position on non-Mac
+                                  keyboards and you can use Meta/Super and Alt
+                                  where you expect them.  (default: off)
+
         ``show-cursor=on|off`` :  Force showing the mouse cursor
 
         ``left-command-key=on|off`` : Disable forwarding left command key to host
 
+        ``full-screen=on|off`` : Start in fullscreen mode
+
+        ``zoom-to-fit=on|off`` : Expand video output to the window size,
+                                 defaults to "off"
+
     ``egl-headless[,rendernode=<file>]``
         Offload all OpenGL operations to a local DRI device. For any
         graphical display, this display needs to be paired with either

-- 
2.43.0


