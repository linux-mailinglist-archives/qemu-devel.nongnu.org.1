Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7059790AD0
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 06:35:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcem3-0002Ec-7Q; Sun, 03 Sep 2023 00:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcelf-0002Ap-HY
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:23 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qceld-0006nx-2Y
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:23 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c0bae4da38so2111675ad.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 21:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693715478; x=1694320278;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Hs61unU0rT5Xs/IozPbclEmnlWYOJEOWqFw7vuLJvQ=;
 b=DOjlg1TBOFZIDvwJEWHFTRR6o4M5Ed67nbauoNcPKe2sbNTJRxQl8g4g1ygqq+WY3a
 N5NUcm+Q61NsVLeWMmV4gZMGublAvBdvg0QV99pGGsUQBTRuwMoyxU7p3RU7ZoNohGxp
 dHu2fHzBCQwGfD8rUIIeeEzfcoX9or0ZcRBDff6ywhDbeH8UPk+M9DDSObtNIV7nDIf/
 KYffO8COlFEEKm40w5PsCmg13o1VZyBJKeP04SXZcZzBix3vpTw8DDSHq+PabuMdJLeZ
 Uopv7U1AUGF3YYqrs9OcPzZL0FaDWOFFWxd/iUiPR4YlFRpGvpo2f7u7ljsAn36qlxWf
 5CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693715478; x=1694320278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Hs61unU0rT5Xs/IozPbclEmnlWYOJEOWqFw7vuLJvQ=;
 b=ORba22sWC65VOfleKUqUUYdMP4AuRuKd6Deu2+kUH/UsfibBnC6TjC8aftGPnDfOm9
 RdvkGGK7wgHas/Fx1laTQYJbUtyiZLrLFRW4MZjamGIF51nqQ7w/acDykGM9+UV6iPYV
 AUP6L5Qc+ubGD4OcXTqGQ+Q8GoT4GH2q+djQ/JpgyIiiqeslZrbq8e7yPRUMsAROY70I
 D0lNaSMIRuPIlX/avKj/iXWTavrOgQ/bT0BHzlkYVlp1kQ2UM/tmYfvfHEmXOwVppRC4
 ZVfJozghQG9/Ywazank20k6zWJHdaxVn/UcT++CXx/pVSqTpAIMjPNZyYVcrqUozi03s
 DkLg==
X-Gm-Message-State: AOJu0YzdC568SwOA7gKtwtlfZ4hdJkR+Ti0Ck7mKeKYEJb3Ha1XnOJ61
 UTAw0fyEKSDI88gkrHHMxJv+Sg==
X-Google-Smtp-Source: AGHT+IH8qzb6UjiEf5BGZdY1AOhxyxpCLqDSifqBg4gw201nEsKgoxM2C5hJnacsoXhsjaS/PWhCTQ==
X-Received: by 2002:a17:902:b782:b0:1b5:674d:2aa5 with SMTP id
 e2-20020a170902b78200b001b5674d2aa5mr7081958pls.13.1693715478525; 
 Sat, 02 Sep 2023 21:31:18 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 iz2-20020a170902ef8200b001bb9f104328sm5295792plb.146.2023.09.02.21.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 21:31:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 1/8] contrib/plugins: Use GRWLock in execlog
Date: Sun,  3 Sep 2023 13:30:11 +0900
Message-ID: <20230903043030.20708-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903043030.20708-1-akihiko.odaki@daynix.com>
References: <20230903043030.20708-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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


