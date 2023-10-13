Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1EF7C7F07
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:55:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCwR-0004x3-Mm; Fri, 13 Oct 2023 03:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwP-0004uN-15
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:37 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwA-0004Um-Vs
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32d834ec222so1725722f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183421; x=1697788221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OEDZHUZlfR06KTYN9H5TjuAUUNx1t85t6hUql+0VCY=;
 b=E0/bjtFfaygL9B2J3RLFLH+RjQm3irXoADTyU+kfN46KvHbUhYsFUwGlnt24eMMSXm
 V+CaxdReYeJTxJJPGwKLAtALsrpPnp+JV99DXoPo1zMvMhl3O3G9PueJUjWlA1SvSGta
 SIyhx451j0CRrbDi8vqxpRd7WOvSpqo8s+PmhyTfiJLGJ6zjilKUl1zM4nGKYVdIffHE
 DXdWo5AawI4Z+b8yMVhWadrjpVtiIITD/j8ulQFS2UsofizE799rySY14XnTChZb6B0u
 cQkwdyVw43GpA2Y4Fkzz6uz5eJju8YgU6viczGqMEHFkp5QdC+1IywDLHfSv3/iAkOvr
 5clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183421; x=1697788221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OEDZHUZlfR06KTYN9H5TjuAUUNx1t85t6hUql+0VCY=;
 b=GP8tucVreN5LVFWtcMbowoBSZ+dM+BVkYVzC0KcEWX8qWZ85kFD0ZYgQq5JSLsA8cD
 yj2mp2lSxJyAVyCJVoiK2PPxpkuMrlhJMUiJcxz9f2yejPopbySAlaJXhn/yeqKB6kNH
 VIfBglSVxbJ0hT0jiduWA3zcxxv9Yv2vZm8JaTHDWezNyZMexahDeL4NvRcRKW4QD/IO
 JW9gxfzzUwbweoD939u+a471WXb/YydIMZNkyFBrCWLuuVtlBx6Sm42hwsf2+69d/VOG
 QODr3ajEJje9tX1iV3b5qWDcxo3UoFORUXV15zWcl7rT5JjwQP0SM+gAnUPSGx3f+feb
 edGQ==
X-Gm-Message-State: AOJu0Yx52DygD6iiwe1yeCdmREAS5SvA8vLrQW+Eir9YEUxcBI0Z3YTt
 qilYg3DuU5DPe0zZtPdvFjgWWbC5Oy3z31Gfv+M=
X-Google-Smtp-Source: AGHT+IH5wwf5hfPEYUQ0vUPbJW3q5auosJAVKa932mS6RTyfWARn5KrzDOO/cIb+wToLuZ26unpgcw==
X-Received: by 2002:adf:fd4f:0:b0:319:7788:5027 with SMTP id
 h15-20020adffd4f000000b0031977885027mr21785663wrs.59.1697183421218; 
 Fri, 13 Oct 2023 00:50:21 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:20 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Subject: [RFC PATCH 18/78] ui/win32-kbd-hook.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:22 +0300
Message-Id: <1fe2aaff40c7debde520690f84032d7767037659.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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


