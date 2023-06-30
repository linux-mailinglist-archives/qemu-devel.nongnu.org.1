Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87116744561
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 01:49:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFNrK-0003oQ-Ed; Fri, 30 Jun 2023 19:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNr6-0003mz-WA
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:48:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNr3-00011A-GU
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:48:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso16206755e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 16:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688168923; x=1690760923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lQFrS7Ghz3cV6Cm75wEKGdAk0LVI4QwFlhuNPN5Qtm8=;
 b=hIsHFxGvy5jLrfGRwSJCl4b2HyBNOP2n2/sspevLTHFC+f8XfefNT4o9isON4L8ly3
 UQMA79rSE5YKgmg00CQhcxU2HGM8OdqTXmTywqBpz62xpo/tzmN0ip3eFl+XpQI7I8YQ
 mwhCzZk8vv8iAseIX+nb7KZSwn0YlXHg0SvDleSeRVgMNu32sA8C1GQqvTdQBCPnJGNF
 b/nO4Zl4YUVeXVc2jxpFBaDA32SPnsUrM27lX5rGwPyEQQeY5uwWbT/m9PJ3qPl9Yjn6
 bJXqpicuVccgVuUeUq/Mrz9f3mxPAXbjTNvbdy+WObxnhqags4F4lBz2q6Z0hUL9U00B
 Ccmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688168923; x=1690760923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lQFrS7Ghz3cV6Cm75wEKGdAk0LVI4QwFlhuNPN5Qtm8=;
 b=g305QiWmNudEAnBUS3J00IzgoiGbHUJu6HR/5sMIpgwCsKLNXdt1r3Doi6lW/01Fhj
 oBsV00JOYg3aP7Z7oI55EjyQoyJ34vcbqg26tSIVZ/mCmCViMgauGRP5r5Kj/BBYHNiD
 AFDIb2ZXU0QbR0J4JpXEcLU4zX93tAxO0ocW0xVVY5LWa+nIPMj5tv2RZz2fuH0H+7Os
 qPVOpUcvWhcddKhfwiTbdC2XRB6+go+mUJzjK2Z0eOnb/Jtt8Cr+k75qkcPJ14t8HisD
 yh/zmTetEtz2a2evAiPft3nNFhDDijLO5xUpQhdAY3wIyH3ZH3oX1Lo9a385tKMfVXo3
 UETA==
X-Gm-Message-State: AC+VfDzrOuXhybb6meJv4ODzReqntI9xEMK5BGAg06AGBYQjGrcM+r8s
 uKX8mMsBywZDSQ2HCQbLBbHaMGrc0vmiUccTwg8=
X-Google-Smtp-Source: ACHHUZ7KPHLu9FXz5acTe8MOCiaCzYawKv2bQ0dDwRjbl8RVXkZjzsyMvEcJCz7BHqdz6exdHj0BLg==
X-Received: by 2002:a7b:cd13:0:b0:3fb:4053:a9d5 with SMTP id
 f19-20020a7bcd13000000b003fb4053a9d5mr3926502wmj.25.1688168922780; 
 Fri, 30 Jun 2023 16:48:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.104])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c294200b003fa78d1055esm20175544wmd.21.2023.06.30.16.48.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Jun 2023 16:48:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Frederic Bezies <fredbezies@gmail.com>
Subject: [PATCH] ui: Link dbus-display with pixman again
Date: Sat,  1 Jul 2023 01:48:39 +0200
Message-Id: <20230630234839.14716-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since its introduction in commit 142ca628a7 ("ui: add a D-Bus
display backend"), dbus_display1 depends on pixman.
Unfortunatly the refactor commit 1222070e77 ("meson: ensure
dbus-display generated code is built before other units")
dropped that dependency. Recently commit 6cc5a6159a ("ui/dbus:
win32 support") expose this problem:

  In file included from include/ui/console.h:4,
                   from ui/dbus.h:31,
                   from ../audio/dbusaudio.c:36:
  include/ui/qemu-pixman.h:12:10: fatal error: pixman.h: No such file or directory
     12 | #include <pixman.h>
        |          ^~~~~~~~~~

Restore the missing dependency on pixman.

Reported-by: Frederic Bezies <fredbezies@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1739
Fixes: 1222070e77 ("meson: ensure dbus-display generated code is built before other units")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/meson.build b/ui/meson.build
index d81609fb0e..cb178dd095 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -90,7 +90,7 @@ if dbus_display
                                           '--interface-prefix', 'org.qemu.',
                                           '--c-namespace', 'QemuDBus',
                                           '--generate-c-code', '@BASENAME@'])
-  dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
+  dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: [gio, pixman])
   dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, include_directories: include_directories('.'))
   dbus_ss.add(when: [gio, pixman, dbus_display1_dep],
               if_true: [files(
-- 
2.38.1


