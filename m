Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAED8146C4
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:23:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6Gd-0005ZH-Qr; Fri, 15 Dec 2023 06:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6GZ-0005Z9-Kp
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:22:05 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6GY-0001CR-7U
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:22:03 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d359f04514so1506815ad.2
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702639321; x=1703244121;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zM+oiGzxg7EKd7lE0tQu0q7ghD+aa2QZNrxY4fYz6OM=;
 b=tHWYy8XxOPbMBWsysyG5+1rANkaU4XSrv+wNkMbm33k9yqrr9QMOTlMxjoWJpAug7f
 aNn2SaLh6o7ZYOs0GqXxMjwy22Do39UM5Q8xkMENvJrAik8SCEpB0FtMf0j6ejnqAs6E
 OOGogbl3pXKrfLcPgVV/ZQ9OazAie1oCu+SQlfn8ach2qlcIcdEI5zVt/U/zNqqK2lkc
 xVXbXknnZtCk5FVHdxRZeo4jrdujrAP6EO2lnuWk5PLn8zCg0gQTfT0qIRnNMLQj5J14
 0Mgt+F9EEwYWXUc6Rrep777E/K0HQPb8JRsgmTo02bswenQ5WGHKj67N0fJjjZssufpF
 FYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702639321; x=1703244121;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zM+oiGzxg7EKd7lE0tQu0q7ghD+aa2QZNrxY4fYz6OM=;
 b=Nm8U0ZWJDw6VpZNYMczQrXkvUilQfBzi/b5kgOcNAHChH2h+r7Yq571nrGQ8yfas3t
 qTzeoemsCim239ONQ7Dk/dPcZTg7KwB9Cbh+xWQdyoHKQUosb1/wEBje8ED5YhPhs9Pw
 JnJGmyEcwxcjQCsQvX1VePAyy0OuYtgvWb29Y/rONVujhcPZa3P7gzkxZy6nRYffaI41
 YV9bZeJAJZVQkR1Vom9nykZr8ETC+PFrWtR1vQY25Rw0rpTmJd5n2QbunLCpDiamiOPb
 Xpn2hnxXdh8CK8U7CkQCiZ3s1avXgDf3RuLPtui/XreI/K425EXIF1REG06pfqNmhUQg
 ohHg==
X-Gm-Message-State: AOJu0Yy5dmtxM5Cg8XVgIHZNn30xz9V/KAxlk7PAR7AVfvsabduA3+Qd
 OfO03snGVXNo+Ik/qM+lIoS2nQ==
X-Google-Smtp-Source: AGHT+IHCu/kz2aG0GK8gnYoo7+FFknaYBPreUsIIuVoRcCF1yBC84ikxcU9FO8lx1/9bMpcgf627LA==
X-Received: by 2002:a17:903:644:b0:1d3:8fb9:f2 with SMTP id
 kh4-20020a170903064400b001d38fb900f2mr155452plb.15.1702639321013; 
 Fri, 15 Dec 2023 03:22:01 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 h2-20020a170902704200b001d06b63bb98sm13994883plt.71.2023.12.15.03.21.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:22:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Dec 2023 20:21:37 +0900
Subject: [PATCH 2/4] audio: Depend on dbus_display1_dep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-dbus-v1-2-349e059ac5b2@daynix.com>
References: <20231215-dbus-v1-0-349e059ac5b2@daynix.com>
In-Reply-To: <20231215-dbus-v1-0-349e059ac5b2@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

dbusaudio needs dbus_display1_dep.

Fixes: 739362d4205c ("audio: add "dbus" audio backend")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/audio/meson.build b/audio/meson.build
index c8f658611f42..608f35e6af78 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -30,7 +30,8 @@ endforeach
 
 if dbus_display
     module_ss = ss.source_set()
-    module_ss.add(when: [gio, pixman], if_true: files('dbusaudio.c'))
+    module_ss.add(when: [gio, dbus_display1_dep, pixman],
+                  if_true: files('dbusaudio.c'))
     audio_modules += {'dbus': module_ss}
 endif
 

-- 
2.43.0


