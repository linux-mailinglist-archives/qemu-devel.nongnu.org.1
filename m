Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E4D82BEAC
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 11:37:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOEts-0007D0-HP; Fri, 12 Jan 2024 05:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rOEtn-0007B2-U1
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:36:27 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rOEtk-0001b8-Th
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:36:27 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d40eec5e12so52415525ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 02:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705055783; x=1705660583;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qe4OLsIGeKFGJwe8IszdNyYh8TGkFlF5KI6ZWaBvNWU=;
 b=CB9AXsYJ8TTvu8wCdbsNaFIx2PGmEzrI4cejvwkSfTbyoPKJS7ZuZ6GZhtjdyBPOTL
 s7Hfsuxmx0T0z1A1+yx73xAyruEzexbcovMpvRP/eUYJYEZBWF0qPa8Md6P145hhnbNz
 OIHl7IYAtX5/m3YTDRdAlGTB1qHnB26Rpp537u0vp8dEcoHVtN0nYHRxk9uHseTzeGac
 5sjJsOFa2FJ6uP+9g/61I1XzQcD1djTbqrKf+sLLzm6bzXffU7Aar4CRa5mY1VDLFQuG
 Jr0noRPHzowrcQIdoX2pG/iuWWBnWRhbFsW5x/acpNfncZ9dcK56zKY6FCEdVk7ZXHf2
 RRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705055783; x=1705660583;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qe4OLsIGeKFGJwe8IszdNyYh8TGkFlF5KI6ZWaBvNWU=;
 b=iC+UVWCIG7XBTLt1W1eIYVEAi5IOYcZ0UX8cLR29K7YohdSavVtX9VEBqUTJjzm8Dd
 /2PD58+arN1Jlsr3y3V1SPgslbRzWovo3gjiKfoVB4BK+eHrsXVlZ11cHFbAMn+36wW7
 qW2P6nKmKGRyjCwF1lvCRXPC6/AngGmtC0EPpMp3lKvCr+m5jThIqwp53iNoqFEmh2Af
 F/LUpt68bjLkb3ZxtzbMvMt0wHmlIqQ2LAMjI8zMKdpaTMIDGhnmmFjOnLYePyvAjh0z
 UqQg1lbxT7rTncr28EchefdSh2A8XpNDUY8sYgvrPqLydWNRLwjrwQV6MGkFJZ42R7Qa
 RYVw==
X-Gm-Message-State: AOJu0YwxATGntnGfQWB38RuvGJ4+lYsmUOCyjrA0N15bqK8fhsWr2Oh7
 +k5b/vTpgORqvakMopc0VxkfFW/K4S55GQ==
X-Google-Smtp-Source: AGHT+IGm7mADmjSqNzibd1phhC5blI2dO0CxQFM5jW21QsCRjD+Ip6q1iaOcFOReUkZHJMReTy35gQ==
X-Received: by 2002:a17:903:110e:b0:1d4:4ca8:eef7 with SMTP id
 n14-20020a170903110e00b001d44ca8eef7mr535453plh.103.1705055782970; 
 Fri, 12 Jan 2024 02:36:22 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 t1-20020a170902e84100b001d3fde182e4sm2794633plg.73.2024.01.12.02.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 02:36:22 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 12 Jan 2024 19:36:19 +0900
Subject: [PATCH] coroutine-ucontext: Save fake stack for pooled coroutine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-asan-v1-1-e330f0d0032c@daynix.com>
X-B4-Tracking: v=1; b=H4sIACIWoWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0Mj3cTixDzd1CQzS9NkczPLNBMDJaDSgqLUtMwKsDHRsbW1ALbGZsB
 WAAAA
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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

Coroutine may be pooled even after COROUTINE_TERMINATE if
CONFIG_COROUTINE_POOL is enabled and fake stack should be saved in
such a case to keep AddressSanitizerUseAfterReturn working. Even worse,
I'm seeing stack corruption without fake stack being saved.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 util/coroutine-ucontext.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 7b304c79d942..e62ced5d6779 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -124,8 +124,9 @@ void start_switch_fiber_asan(CoroutineAction action, void **fake_stack_save,
 {
 #ifdef CONFIG_ASAN
     __sanitizer_start_switch_fiber(
-            action == COROUTINE_TERMINATE ? NULL : fake_stack_save,
-            bottom, size);
+        !IS_ENABLED(CONFIG_COROUTINE_POOL) && action == COROUTINE_TERMINATE ?
+            NULL : fake_stack_save,
+        bottom, size);
 #endif
 }
 
@@ -269,10 +270,26 @@ static inline void valgrind_stack_deregister(CoroutineUContext *co)
 #endif
 #endif
 
+#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
+static void coroutine_fn terminate(void *opaque)
+{
+    CoroutineUContext *to = DO_UPCAST(CoroutineUContext, base, opaque);
+
+    __sanitizer_start_switch_fiber(NULL, to->stack, to->stack_size);
+    siglongjmp(to->env, COROUTINE_ENTER);
+}
+#endif
+
 void qemu_coroutine_delete(Coroutine *co_)
 {
     CoroutineUContext *co = DO_UPCAST(CoroutineUContext, base, co_);
 
+#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
+    co_->entry_arg = qemu_coroutine_self();
+    co_->entry = terminate;
+    qemu_coroutine_switch(co_->entry_arg, co_, COROUTINE_ENTER);
+#endif
+
 #ifdef CONFIG_VALGRIND_H
     valgrind_stack_deregister(co);
 #endif

---
base-commit: f614acb7450282a119d85d759f27eae190476058
change-id: 20240112-asan-eb695c769f40

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


