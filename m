Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 189787C7F7A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:07:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4d-0001NM-1B; Fri, 13 Oct 2023 03:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD46-0000VW-K5
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:34 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD43-0006rH-TA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40684f53ef3so20881215e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183909; x=1697788709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OEDZHUZlfR06KTYN9H5TjuAUUNx1t85t6hUql+0VCY=;
 b=z8TLUdlIi+Vj/+Nh4qgONS7QIf5RscmrBAvvr9qhErbhs3YYdeSoWuxy6VJtktFfQT
 dtlOsmdhoknexU4sxWdZzEKJjiEaHzD7dh48PEHgA26puqQPB5DkmlEnXsPi92LJmnNr
 ZDg6ES1o8idHjfprFFYKSJJEdGMfznICMEygUvVLz8s4iVZhfHfaFWXmnWJaSFMTYGfX
 EavJzCxtjJL/lnQL/NTGn/vcjY65PIZyGPFkMz59yzSt8GykUwD14kzixAc3ymd+0buJ
 KLS7610uOGg2UHSZmQ4r2kbzNRHBHnBnlahHAYh9X9PralFHiURfLzE0pR3cD5FhtzZ/
 iNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183909; x=1697788709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OEDZHUZlfR06KTYN9H5TjuAUUNx1t85t6hUql+0VCY=;
 b=RfVf87h1fvNQGjh2MXF0Gn1/VWK9PzhQpTnSFirSTJIZK0VqAA3UMiVZA2+LwPPPt0
 1BbkllsMqNMx2R0X+wahrX2E1vj7vO0meiLljRo65uOHNmrnSMTltKGaskR1hV4Z1ADv
 j6ZBZa/tDJ0h8rTvkhhubuOQuVGIVA6EqDJYTWEVK7KRRSizqF4r5uBX6dup4TpROUIK
 +2KQSA9IG/q++c/y7CharCu0PRbz+ekTc4DwCJJlfMJJD8jJ9vPKzPnhmbvFrh7NqAyC
 8yhLQ4PSgzeabyf83d9V/eToJKQblM0RGttZ72xhR5bGZ3gqiFIc3cO2OzumlrK79+HT
 QpWA==
X-Gm-Message-State: AOJu0YylUPGSVU9pGrIIlNDnrvAqfWrOuwFEr1Suoqygxk1c210+qp0/
 OTHztngyoOCj6YUcvNSH6zEUqS6E8T0waaKmDMg=
X-Google-Smtp-Source: AGHT+IHN1tw7TCDCyBgzhJ5f8xk3zqGf4huvUxPbPgVH3Zo3ja24VOL9lKNio80XywdjCTiX2YmxgQ==
X-Received: by 2002:a7b:c8d7:0:b0:405:336b:8307 with SMTP id
 f23-20020a7bc8d7000000b00405336b8307mr22724341wml.7.1697183908999; 
 Fri, 13 Oct 2023 00:58:28 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:28 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Subject: [RFC PATCH v2 18/78] ui/win32-kbd-hook.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:45 +0300
Message-Id: <1fe2aaff40c7debde520690f84032d7767037659.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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
 ui/win32-kbd-hook.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/ui/win32-kbd-hook.c b/ui/win32-kbd-hook.c
index 1ac237db9e..3c5c3fc597 100644
--- a/ui/win32-kbd-hook.c
+++ b/ui/win32-kbd-hook.c
@@ -18,59 +18,52 @@ static DWORD win32_grab;
 static LRESULT CALLBACK keyboard_hook_cb(int code, WPARAM wparam, LPARAM lparam)
 {
     if  (win32_window && code == HC_ACTION && win32_window == GetFocus()) {
         KBDLLHOOKSTRUCT *hooked = (KBDLLHOOKSTRUCT *)lparam;
 
         if (wparam != WM_KEYUP) {
             DWORD dwmsg = (hooked->flags << 24) |
                           ((hooked->scanCode & 0xff) << 16) | 1;
 
             switch (hooked->vkCode) {
             case VK_CAPITAL:
-                /* fall through */
             case VK_SCROLL:
-                /* fall through */
             case VK_NUMLOCK:
-                /* fall through */
             case VK_LSHIFT:
-                /* fall through */
             case VK_RSHIFT:
-                /* fall through */
             case VK_RCONTROL:
-                /* fall through */
             case VK_LMENU:
-                /* fall through */
             case VK_RMENU:
                 break;
 
             case VK_LCONTROL:
                 /*
                  * When pressing AltGr, an extra VK_LCONTROL with a special
                  * scancode with bit 9 set is sent. Let's ignore the extra
                  * VK_LCONTROL, as that will make AltGr misbehave.
                  */
                 if (hooked->scanCode & 0x200) {
                     return 1;
                 }
                 break;
 
             default:
                 if (win32_grab) {
                     SendMessage(win32_window, wparam, hooked->vkCode, dwmsg);
                     return 1;
                 }
                 break;
             }
 
         } else {
             switch (hooked->vkCode) {
             case VK_LCONTROL:
                 if (hooked->scanCode & 0x200) {
                     return 1;
                 }
                 break;
             }
         }
     }
 
     return CallNextHookEx(NULL, code, wparam, lparam);
 }
-- 
2.39.2


