Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 008F88146E8
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:29:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6NJ-0002n1-Oy; Fri, 15 Dec 2023 06:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6NA-0002m3-CZ
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:28:58 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6N4-000816-MP
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:28:48 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d099d316a8so485616b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702639725; x=1703244525;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zM+oiGzxg7EKd7lE0tQu0q7ghD+aa2QZNrxY4fYz6OM=;
 b=NcrszIdZTVsQkzY4zN3h7BG0KslNFRPhGbtxEArmqsHTku7nt0bYLfaC8TB4kfaDgM
 XFjW/9Pw2nKcP5sYB1ZGzB2nheU8k8n6xluJOk2wiTJEXmK338HmnDnMT6oWukw851C4
 TQCvWRnrK2fTb+yqCfqiJQnzgvWvvYuUKwYiAo4lMwQvxYo2d/1mE+MJaUPWeNPJj8iu
 D51P8JKBQYg3iUr6YASR5e/w89SYlEceTX2Ph8gCVWadzs1dtqlxbbgn18K/o3tivsb/
 IVu79dD34HiC4xL0JYMTGtwE4wWDFVFa98ZeI/YjvXbS+qZxomD8xfIuOCd76gyn2OlS
 QX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702639725; x=1703244525;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zM+oiGzxg7EKd7lE0tQu0q7ghD+aa2QZNrxY4fYz6OM=;
 b=MSvsToUb2qrZ6Wg7hkQJAnAyHrL4LSY1byEIdVPLs/V+tbiIGvcIwx3zgg+v15bgjM
 Zp81yZxB/I+ZrPwD+TPV6dGxZ/VWrgNXrAneYz3h+8n2AUKjTZDSYSZs4ILlxm6ONs92
 barbn6yHru0iHDIRlLangiT7V/wZr3jCUUhZH3v4iaw4XDSZy+AO/8DlA/k6vwUl9Z2b
 NQH8fT1XL+IgLrMkl41A5y+85vUBHT3jq1vSt/IzG6SfUFhqCDPzejY5nmGK3bYux5D1
 3PEC5chFEJ+Uy0RStvN2cuCpM+ZED0IOOhtCv+n64Wa9VwD1kOI5Dt9OJLNTvu6AwkRs
 fNrw==
X-Gm-Message-State: AOJu0YzgR31z7JMNZZ/n6NM7MduAojqMzAO/GVqvDMCAL6JuUEZho3kR
 mLlrMQ9f+cs+Kd0LLRtlHeEPzi43iXvngajzWHZobA==
X-Google-Smtp-Source: AGHT+IGZGWK38ebpT2e4v8XCMZGbrkEtjRcjumP00Fk7kIOA59ejXg/CCo624Y6x0Jv9iNKdI1q/TQ==
X-Received: by 2002:a05:6a00:14cb:b0:6d0:d864:219d with SMTP id
 w11-20020a056a0014cb00b006d0d864219dmr4942670pfu.3.1702639725511; 
 Fri, 15 Dec 2023 03:28:45 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 g16-20020aa78750000000b006c4d47a7668sm13371429pfo.127.2023.12.15.03.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:28:45 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Dec 2023 20:28:34 +0900
Subject: [PATCH v2 2/4] audio: Depend on dbus_display1_dep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-dbus-v2-2-1e2e6aa02115@daynix.com>
References: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
In-Reply-To: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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


