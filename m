Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EBB858F07
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Feb 2024 12:20:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbIip-0007SL-B7; Sat, 17 Feb 2024 06:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIim-0007S4-Rx
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:04 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIil-0002fi-Cq
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:04 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-595d24ad466so1522308eaf.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 03:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708168742; x=1708773542;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yg/3DKi4unIH0TlgItEfPow+9WhqClPSrzvHM4SKIdk=;
 b=QSyLEj5DvF626ZTMwOXnpjVd7RB8+j2dvUi46/2hcpzdq/c9FqQ7m2sUmD0wChgbhR
 zhzxdPbiHmCDFMopQjedHi0McSsYgE2s2RQjNCDj9qkw4/pBr9e6kuEZKNP1hYWOxSh0
 qv8UQTBZFc2xCoVXWRV7rzzJqKoWcB7bRZFI4cS2TfNvP08rjgrMS76NoEdNYh2uroIF
 ajaKgFD7M6+4r7J3EslZrajA2u2AS52u34jezWwkP/uU1ifi7zOFMqGJes2yawTkiDJY
 79G9Pt61WbkLK+Q70wS0yamklLZbOOgdTCRNlv9yeFgrsoAIes2mutFR5faBFh1bClpc
 CIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708168742; x=1708773542;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yg/3DKi4unIH0TlgItEfPow+9WhqClPSrzvHM4SKIdk=;
 b=d6V46tkbDeThptq5T7/ydfKQgYMdp0agCBVWjnHRWfVS3xnfCFe9Owa7veS0KLV23S
 eHBldomGYs4Bgg42voVEf7xH6C8YrwDdfjptEvZAS5mLg8yS66bQq7H1ZYI0qZfRhaKw
 210tdHkbLBh5phHoKyDffjdo1xA/NgWaXqjOieTs/+AlkTvpuEFPloMrwdsy27RViMJ7
 LmWQcTQwHk6qeSiWnQZ3aecYVN6ofZpbQ20yP922jxkqjEva/endGatPPbowUPxH2c+G
 /nKSECA8njuIlTszsTDXFWKpw85eUTG0CGSVCKscvWsDtHWnmhXY+2DIAr2KHzcTlrUU
 Noww==
X-Gm-Message-State: AOJu0YxJ6MVAXydd/rnOpAjqVwCKl8gmNL01yafBe1BAmRu9lWrFEOyi
 4YNiteeQCX6rIGzVmD4NRa5Rm9N5/zanY/Np63hS6iFfh/suwwUw2R+30VTkfNo=
X-Google-Smtp-Source: AGHT+IHee+Bx8Sp5yrDNtZ7fsXUtkYBttm2lGxS4smTuySxEyYgAWt78/re0P0MeKtzw+l7Mrj+5KA==
X-Received: by 2002:a05:6358:78b:b0:178:99cc:e52e with SMTP id
 n11-20020a056358078b00b0017899cce52emr8027763rwj.20.1708168741831; 
 Sat, 17 Feb 2024 03:19:01 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 c7-20020a62f847000000b006e0e35c1e55sm1424561pfm.79.2024.02.17.03.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 03:19:01 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 17 Feb 2024 20:18:48 +0900
Subject: [PATCH v11 2/6] ui/cocoa: Scale with NSView instead of Core Graphics
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-cocoa-v11-2-0a17a7e534d4@daynix.com>
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
In-Reply-To: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2c.google.com
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

Core Graphics is not accelerated and slow.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index fe0eb74b0743..b26669160300 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -496,10 +496,8 @@ - (void) drawRect:(NSRect) rect
 
         [self getRectsBeingDrawn:&rectList count:&rectCount];
         for (i = 0; i < rectCount; i++) {
-            clipRect.origin.x = rectList[i].origin.x / cdx;
-            clipRect.origin.y = (float)h - (rectList[i].origin.y + rectList[i].size.height) / cdy;
-            clipRect.size.width = rectList[i].size.width / cdx;
-            clipRect.size.height = rectList[i].size.height / cdy;
+            clipRect = rectList[i];
+            clipRect.origin.y = (float)h - (clipRect.origin.y + clipRect.size.height);
             clipImageRef = CGImageCreateWithImageInRect(
                                                         imageRef,
                                                         clipRect
@@ -545,6 +543,11 @@ - (void) setContentDimensions
     }
 }
 
+- (void) updateBounds
+{
+    [self setBoundsSize:NSMakeSize(screen.width, screen.height)];
+}
+
 - (void) updateUIInfoLocked
 {
     /* Must be called with the BQL, i.e. via updateUIInfo */
@@ -634,6 +637,7 @@ - (void) switchSurface:(pixman_image_t *)image
         screen.height = h;
         [self setContentDimensions];
         [self setFrame:NSMakeRect(cx, cy, cw, ch)];
+        [self updateBounds];
     }
 
     // update screenBuffer
@@ -1292,6 +1296,7 @@ - (void)windowDidChangeScreen:(NSNotification *)notification
 
 - (void)windowDidResize:(NSNotification *)notification
 {
+    [cocoaView updateBounds];
     [cocoaView updateUIInfo];
 }
 
@@ -1940,16 +1945,7 @@ static void cocoa_update(DisplayChangeListener *dcl,
     COCOA_DEBUG("qemu_cocoa: cocoa_update\n");
 
     dispatch_async(dispatch_get_main_queue(), ^{
-        NSRect rect;
-        if ([cocoaView cdx] == 1.0) {
-            rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
-        } else {
-            rect = NSMakeRect(
-                x * [cocoaView cdx],
-                ([cocoaView gscreen].height - y - h) * [cocoaView cdy],
-                w * [cocoaView cdx],
-                h * [cocoaView cdy]);
-        }
+        NSRect rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
         [cocoaView setNeedsDisplayInRect:rect];
     });
 }

-- 
2.43.1


