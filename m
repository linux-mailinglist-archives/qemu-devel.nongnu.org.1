Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E88CE0A4
	for <lists+qemu-devel@lfdr.de>; Fri, 24 May 2024 07:37:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sANbR-0008Bj-7c; Fri, 24 May 2024 01:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sANbO-0008BH-FA
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:36:26 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sANbM-00014N-PK
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:36:26 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5b3241373adso4518698eaf.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 22:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716528983; x=1717133783;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CxG2P76G/OTNBVGMvRYEe0TWmwUTzdWD9903oTGfTEk=;
 b=W+FCOAoFxxhMUFcfboQG62XZcBAcTe0Fkldy2VZSatsziKj2oVcGjOWbcdwoJ/t39j
 4mIg7bcNGVwRLRUx1upToSciJSWIFzOEDz4AyMmCtiVpa0YIswZ0GC9YFJkpsj2Ynbc7
 OF/54caG10Hq0OhLg/PCHbHHQFiWCX9HCVdWEtp2ai0b+1o0uUTavOPk2zdSq+9w4mJd
 9BkSTsJPsqiBcBhvyzvRaATL7HDUZ+rytQKX6DmxfBTDTBKaO9skEvfJ/qGesepmJqBZ
 OOVnUjolfRS6w4UvuONhzLm07hnkltUPOjWz38zcctEaezzmLvBuVroLK0eKgxPdEhcj
 8mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716528983; x=1717133783;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CxG2P76G/OTNBVGMvRYEe0TWmwUTzdWD9903oTGfTEk=;
 b=t7PkyznetgexpKAu2qFWFBeuUFWAnC4AmA+m76h76BsT+jy0WPl+vxGXaci+JVdldV
 gm/aJ8ii4uIR6hKka3eNWCj+4uvuPAlmkWZgHDNLGGWI+FZ4ggNeJHrYPdA5dOjOW27l
 XDlK35HHZXO3uOQGKfCtNRfNrLNxRGOCVL3hq69IVbjJTSru+uOXrybAOxSactTjV4pl
 LVHlZQ9rXUvVdQ67vLOheYOSj4BlnSM+8ArUl/61zH5h43ov9tNyna+bDQdc1/X+Z8n5
 RyX1y+6scYmDzqJBR8EAWvegf1hlk+ZXyO68Hjec2QU0ZjqYkZe0Pv4tor7PqzOc2GuQ
 atfA==
X-Gm-Message-State: AOJu0Yw3eQWji5SrMoAoF0b4CGtxrPukVzbz4B3NVlWcOPqP/zV8aIy3
 iQojjThO+9CvrBrmG7jlciGmKt+myRvkmSrrJ0OkCEGuBD0rz4S2Iiza/Drd8S8=
X-Google-Smtp-Source: AGHT+IFsw4QyiPf3QWmoQjeuyrwFeeTtZc8mctLSqR0Z0OD+5fjSM0qBmgC05URQNg012oPnQNcaBQ==
X-Received: by 2002:a05:6359:4c12:b0:189:9aa2:c25d with SMTP id
 e5c5f4694b2df-197e565ff65mr179330355d.20.1716528982658; 
 Thu, 23 May 2024 22:36:22 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-682274bbd96sm427042a12.87.2024.05.23.22.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 22:36:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 May 2024 14:35:48 +0900
Subject: [PATCH v4 2/4] lockable: Do not cast function pointers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-xkb-v4-2-2de564e5c859@daynix.com>
References: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
In-Reply-To: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::c31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

-fsanitize=undefined complains if function pointers are casted. It
also prevents enabling teh strict mode of CFI which is currently
disabled with -fsanitize-cfi-icall-generalize-pointers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2345
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/lockable.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 9823220446d9..c1b097c44879 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -43,15 +43,30 @@ qemu_null_lockable(void *x)
     return NULL;
 }
 
+#define QML_FUNC_(name)                                           \
+    static inline void qemu_lockable_ ## name ## _lock(void *x)   \
+    {                                                             \
+        qemu_ ## name ## _lock(x);                                \
+    }                                                             \
+    static inline void qemu_lockable_ ## name ## _unlock(void *x) \
+    {                                                             \
+        qemu_ ## name ## _unlock(x);                              \
+    }
+
+QML_FUNC_(mutex)
+QML_FUNC_(rec_mutex)
+QML_FUNC_(co_mutex)
+QML_FUNC_(spin)
+
 /*
  * In C, compound literals have the lifetime of an automatic variable.
  * In C++ it would be different, but then C++ wouldn't need QemuLockable
  * either...
  */
-#define QML_OBJ_(x, name) (&(QemuLockable) {                            \
-        .object = (x),                                                  \
-        .lock = (QemuLockUnlockFunc *) qemu_ ## name ## _lock,          \
-        .unlock = (QemuLockUnlockFunc *) qemu_ ## name ## _unlock       \
+#define QML_OBJ_(x, name) (&(QemuLockable) {        \
+        .object = (x),                              \
+        .lock = qemu_lockable_ ## name ## _lock,    \
+        .unlock = qemu_lockable_ ## name ## _unlock \
     })
 
 /**

-- 
2.45.1


