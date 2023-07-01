Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D8744776
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:56:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVw-0007XI-HL; Sat, 01 Jul 2023 02:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVq-0007U1-Hw
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVo-0007Eh-2e
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fa8cd4a113so28374895e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194514; x=1690786514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcc6HB+1pxARPpW2OAO7nKJmZp3YAW//z7LTAV54n+o=;
 b=DNIRUitmEwiUfctH3PuOlkt/NgWdTE2tOCLlEZS6vLqYFUu007n9j/PxAsEZghwmI9
 IQfQv2Md/2Kd4ouo/CnIxInwhAlCKh2zXaWrwiEB/AovHMoaca6/TMLKmScvKhHcrqNs
 UiLILZ/u0EAjeNOGRCidgxdWhPgTjsKYHjhB4lJkgvvSlSLoF6cTTlefSCJD0o2uGqJM
 dhp0mDZBl4ZlaXXN8EzI+/oi2vJL2ZXcJhL8qWUQnQqrHKGjMM0BhTEDD5ko8srdByJc
 fS1gGz+FVoK3ZcEUCFpP738YcHMccEe2LBIiZ4Dv6+J2ARuqVqSb6dJUDEWe9z+BWV8Y
 J47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194514; x=1690786514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcc6HB+1pxARPpW2OAO7nKJmZp3YAW//z7LTAV54n+o=;
 b=dqVHqTyyYgqA56j7uQktjSLk5AZqiTDKBO5bjV3Nb6IF7CuD4tTLWwy6LGu/xPm+y+
 Zoi08451pHZhVO19hB+NuHsOVN9SzJvxxV2HRecFsjfL+X/oKnbV8wy1n2VI7JFlSnt2
 M92qxtsErouxq6KlTG/Rg/W2VEN1HUqU7xLoyM4cnO22FEGDU12mqNZsFKgV7FCFRaXw
 OMlsLAOuuiQ9EyYe+nTUdAiYZB76wxL+4/TtDxdIPvkUh3uUt6DgCsiyGDciESbn+OrE
 NZ5BuLyIpUmlVhLIZsHBJR2BPHEQ3OLGkF62jYKUlCTlT/ss9YBzcu8BtpZ2727THQ+l
 +s8A==
X-Gm-Message-State: AC+VfDySJpTADslkIp/HN6lFzOqf5c5K1iVQtCbTu8PbykS795xgCdAl
 O32e42Vet697mjgYEwDjwOIq6JsdT9IjDc8E2ekQCg==
X-Google-Smtp-Source: ACHHUZ7UqYfxoc0jbwkBizISEy2ukNMlPxXQNxrtIdEnevcr4laoQ0vGvGvvo/AJvsgd0j8KvpLxow==
X-Received: by 2002:a1c:c90a:0:b0:3f8:c9a4:4998 with SMTP id
 f10-20020a1cc90a000000b003f8c9a44998mr3512777wmb.28.1688194514037; 
 Fri, 30 Jun 2023 23:55:14 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 02/11] audio: dbus requires pixman
Date: Sat,  1 Jul 2023 08:55:01 +0200
Message-Id: <20230701065510.514743-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701065510.514743-1-richard.henderson@linaro.org>
References: <20230701065510.514743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Commit commit 6cc5a615 ("ui/dbus: win32 support") has broken audio/dbus
compilation when pixman is not included.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1739

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230630214156.2181558-1-marcandre.lureau@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 audio/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/meson.build b/audio/meson.build
index e7e95cf751..df4d968c0f 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -31,7 +31,7 @@ endforeach
 
 if dbus_display
     module_ss = ss.source_set()
-    module_ss.add(when: gio, if_true: files('dbusaudio.c'))
+    module_ss.add(when: [gio, pixman], if_true: files('dbusaudio.c'))
     audio_modules += {'dbus': module_ss}
 endif
 
-- 
2.34.1


