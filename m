Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B0679DC00
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:42:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgC4V-0002Og-Qf; Tue, 12 Sep 2023 18:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4T-0002OX-9x
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4R-00017M-0u
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68fcb4dc8a9so2257004b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694558482; x=1695163282;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Hs61unU0rT5Xs/IozPbclEmnlWYOJEOWqFw7vuLJvQ=;
 b=QbKTefABaFyK/tgOPQlpymvyIf/yeibV6J82dhhcdR5iiygpp5i5WuXc9Xz9fgfrQ6
 1//LPn9/UgV1PIFzQ7wzrfeonNwxHdq/PAu5pnvKXp+YIGJS27+//stICraoeA8CE3CD
 ui6T9ewYk5T4bRLwUYNC7TldtPWZq9ORMkERlK12VBvYMSxqNiBEI8rj7uOjEQXJ4Pi2
 wdLbE2jRaUs3DKGgFHPtvRwnUh9ALB5PjTCSpcSMlYr7SOOiGE2TpE5b+ufHYjlJBIpY
 OcizLP9O3/C5nV8G83sgrZj9fQW4MCNHjX7vIJnoUOe/nb+jc3q+dly29E5oJJeTgQ1A
 rd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694558482; x=1695163282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Hs61unU0rT5Xs/IozPbclEmnlWYOJEOWqFw7vuLJvQ=;
 b=hLCc4jeQhfKBtzO8H1B2SsU+IyQcYdIQt7YX/YzCHb7Ul03itGSGA3l9ArASplRbTn
 3ZGKbwrS9RFxmmExPT3n9BzYnVcJlaLJdkWTLH6jEUbM0JNHvayNoISgUt/W3JRjHLkr
 jvw8+L1tVYEvFnWOLXYZR2Qr4a7jgBMvWBDy0AYiVjc/nbgZasPPW4M3eQOa3t3sa1h9
 BPMDI1L4b6zBRI+CGq8ZQMtpAkq9NjBM/xgeeZQ9rlcz3zvgc4hc3JsJMSo38pYn/HEE
 djTTn2/xe812eAgUnlga1rtYeA7I6bRJWPW5+QexihuI9+Wut54fMoqw6ZPC+jsXGegR
 JbWw==
X-Gm-Message-State: AOJu0Yz5ZyTxnIcGsgGIB2Xd8f1MHRj+N2ndRkEX+i8nwhc4V/IWzc1L
 2ermFc2+qDIVXzzgACsb70btmQ==
X-Google-Smtp-Source: AGHT+IGENkkdSzk4R+kSR94Tc5R6Dz46kJwj+umtZ23x+JxuZu6I28u/W8ms/Jea7DgZtRGcVWDrUQ==
X-Received: by 2002:a05:6a21:7782:b0:138:60e:9bb with SMTP id
 bd2-20020a056a21778200b00138060e09bbmr585059pzc.28.1694558481776; 
 Tue, 12 Sep 2023 15:41:21 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm8996977plk.219.2023.09.12.15.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:41:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 04/12] contrib/plugins: Use GRWLock in execlog
Date: Wed, 13 Sep 2023 07:40:53 +0900
Message-ID: <20230912224107.29669-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912224107.29669-1-akihiko.odaki@daynix.com>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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

execlog had the following comment:
> As we could have multiple threads trying to do this we need to
> serialise the expansion under a lock. Threads accessing already
> created entries can continue without issue even if the ptr array
> gets reallocated during resize.

However, when the ptr array gets reallocated, the other threads may have
a stale reference to the old buffer. This results in use-after-free.

Use GRWLock to properly fix this issue.

Fixes: 3d7caf145e ("contrib/plugins: add execlog to log instruction execution and memory access")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/execlog.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 7129d526f8..82dc2f584e 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -19,7 +19,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
 /* Store last executed instruction on each vCPU as a GString */
 static GPtrArray *last_exec;
-static GMutex expand_array_lock;
+static GRWLock expand_array_lock;
 
 static GPtrArray *imatches;
 static GArray *amatches;
@@ -28,18 +28,16 @@ static GArray *amatches;
  * Expand last_exec array.
  *
  * As we could have multiple threads trying to do this we need to
- * serialise the expansion under a lock. Threads accessing already
- * created entries can continue without issue even if the ptr array
- * gets reallocated during resize.
+ * serialise the expansion under a lock.
  */
 static void expand_last_exec(int cpu_index)
 {
-    g_mutex_lock(&expand_array_lock);
+    g_rw_lock_writer_lock(&expand_array_lock);
     while (cpu_index >= last_exec->len) {
         GString *s = g_string_new(NULL);
         g_ptr_array_add(last_exec, s);
     }
-    g_mutex_unlock(&expand_array_lock);
+    g_rw_lock_writer_unlock(&expand_array_lock);
 }
 
 /**
@@ -51,8 +49,10 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
     GString *s;
 
     /* Find vCPU in array */
+    g_rw_lock_reader_lock(&expand_array_lock);
     g_assert(cpu_index < last_exec->len);
     s = g_ptr_array_index(last_exec, cpu_index);
+    g_rw_lock_reader_unlock(&expand_array_lock);
 
     /* Indicate type of memory access */
     if (qemu_plugin_mem_is_store(info)) {
@@ -80,10 +80,14 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
     GString *s;
 
     /* Find or create vCPU in array */
+    g_rw_lock_reader_lock(&expand_array_lock);
     if (cpu_index >= last_exec->len) {
+        g_rw_lock_reader_unlock(&expand_array_lock);
         expand_last_exec(cpu_index);
+        g_rw_lock_reader_lock(&expand_array_lock);
     }
     s = g_ptr_array_index(last_exec, cpu_index);
+    g_rw_lock_reader_unlock(&expand_array_lock);
 
     /* Print previous instruction in cache */
     if (s->len) {
-- 
2.42.0


