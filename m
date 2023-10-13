Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EEC7C811B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:58:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqA-0007zU-L2; Fri, 13 Oct 2023 04:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpq-0007fe-7S
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:54 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpm-0000pn-JU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:53 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32d3755214dso1784006f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186863; x=1697791663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kz98sjv7RxsZhX9qqrPoSooYlpCSBVCQ+zMepcbIWF4=;
 b=jNn3LUJJ7VWSJm5lkBdTPQ2JSU8Uoi6RU8H2AhApm54oE4AMlNb47tJP7YsgpWQJk4
 h4R+r5BquEGQ3RT6/DsHS4Dyusy/T7yeNwttLn8UWa4Mfs4rterfLFOofK2jlttbB0JH
 ueO9ztWOsOgyoYJe6XPA5scLwOZ+vq0JpV1zFnJJesoOaEHawKeqsjU06q+/QePehQ+F
 eUGqJSVI2YTTTXzHvuX99AfWR65B9rjuDBr48avu/6Q0d2Ika4p+U+QQPITZP7f1RIGz
 J/EFjN/eLIC8KT5xVnUDnB2fl8J9rX7EmPEtR3wc9DNUuw8zOKrIn1zXmIDw4ge1BIkU
 eltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186863; x=1697791663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kz98sjv7RxsZhX9qqrPoSooYlpCSBVCQ+zMepcbIWF4=;
 b=VJUunggm/u+r2Nmsd6xOdCn42wXEMvaWdRLCE4WUR6jhX4KacDGJk0iTMkWoiK8uSf
 hLgwYZCN12f3qswlbPSv9jhbciaK8iYzmPWwSwmyXFfIU2eNbDcDEmd2tYJ4qtOyO1W+
 P5ow4CcyQDq2Pq/MXc1jZo4xBU6PiYtkrUuGztCZnvzgvdpcDpumexGIB8Ut32yTgntJ
 zv4txLSe8uyX+2yQ0xN2bdorqRxpvDy8v2AM8X0oHxadzeWUkqalohmOqJzrEY2Do+ko
 TzFUpmmQOUgrIKDjJp+vyMxsY5tpcGzGjfX8ZU2v3+NzTDIUCl2/3n/6TNS6KvCwYRbB
 k1Ug==
X-Gm-Message-State: AOJu0Yx8auTZlU7ZlmP1i4pJspMgEciOsqaprShg1YKIw/cFQvcbuHh5
 n4BREFwrGTZN9kj28B3rHByM0pt12LDztwEWsPg=
X-Google-Smtp-Source: AGHT+IEDFxhRo83y+eww+D7PLDLcKXoLSFyfFB1+9lrEkrFUhYhJddbUMLs7OLxVlbxCLf4iXiPvSA==
X-Received: by 2002:a5d:5d0e:0:b0:32d:8830:cda1 with SMTP id
 ch14-20020a5d5d0e000000b0032d8830cda1mr6610148wrb.63.1697186863091; 
 Fri, 13 Oct 2023 01:47:43 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:42 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC PATCH v3 17/78] ui/sdl2.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:45 +0300
Message-Id: <73e889e7bdf2a8dc55a6b4f73080f7f2261fa28e.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
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
@@ -601,7 +601,7 @@ static void handle_windowevent(SDL_Event *ev)
         if (qemu_console_is_graphic(scon->dcl.con)) {
             win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
         }
-        /* fall through */
+        fallthrough;
     case SDL_WINDOWEVENT_ENTER:
         if (!gui_grab && (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled)) {
             absolute_mouse_grab(scon);
-- 
2.39.2


