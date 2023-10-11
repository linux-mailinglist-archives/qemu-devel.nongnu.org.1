Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2787C503F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:35:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXN-0001eG-W0; Wed, 11 Oct 2023 06:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX6-0001Ky-Mi
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX4-0005FM-Bz
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-405524e6769so4808975e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020416; x=1697625216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOZHj2WDZdrEovxhRhKdAFEERTpyPMh/xQMpzlYqBTI=;
 b=zTffMfkYEWsiryCv23xGmYen7FK462DMrXCtUUv886xYqsQhFi2j2EiUP8txYU6i47
 1y1nLEpRAdjSmDayJtkikQe4W7ELcQLBWty90xiHa27h6oFjcwBrsjRlkln/8ru+eadC
 ccUZPEVvstGme921XVVuvLynoYz2axWEDMcb+uYNNexnPGzeFkiKtTjNE/WIWdjTztYJ
 b1MERWCxk8OXVt72gyXLaFuUgF/+EBCSjfxrRNpuftEedZP5WkqKU+rZM+WEalQPN0Bd
 pmvjKUwpLBnGN7bf0X0slAMEhm68Jk94xSN7WeF624nkrMSdUPaYdaLOWv125KxBtBlh
 l2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020416; x=1697625216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOZHj2WDZdrEovxhRhKdAFEERTpyPMh/xQMpzlYqBTI=;
 b=mhvxjesjWmHaAT0JacG+z9CosoeZwtNmgjhT5RoNa3iB6mrexuqWoqDUVAr6KmWjNU
 Com/5d5XmKYqoI+Tjy3hUtvwOReVs8K02ZzxVg5jH94hjei2x5Opr5b8TNyP+IMynicm
 crfkzpX4mK5FVxvS6+/6VVQgpW2HHz5rEIjdAjXCUXPuDZsls6CRniF4PP1uRHFraYe4
 QQUK7oquOkt2zlBy5nB8ZQ5JnqvDle9UwDoaWusfZP0RJWSeTrKIw/kN4W1JOKyfv6Mn
 7tyBg47Q0or5qfXLziaMIBGchm3awbghkks36dY39Cin1fUikyGbiher+qBtpTSZZr/9
 orDg==
X-Gm-Message-State: AOJu0YxwBBWcleDMXnuEjT5VpzmhGuspXyx2e6jQYTsIW4z63Vm97Cqw
 mCVK0SPt/9lWrZQEy5vdrNAL1A==
X-Google-Smtp-Source: AGHT+IEaSA2nVY6MikEuO9DzrSFymQ2DRYkAUClH1XBRl6SEGQs/IlFn0aX3Y18Rk+UJKXHzCPogyg==
X-Received: by 2002:a7b:c044:0:b0:3fb:c075:b308 with SMTP id
 u4-20020a7bc044000000b003fbc075b308mr16426874wmc.12.1697020416294; 
 Wed, 11 Oct 2023 03:33:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 ay20-20020a05600c1e1400b0040640073d25sm16646526wmb.16.2023.10.11.03.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:35 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D7821FFC4;
 Wed, 11 Oct 2023 11:33:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 11/25] contrib/plugins: Use GRWLock in execlog
Date: Wed, 11 Oct 2023 11:33:15 +0100
Message-Id: <20231011103329.670525-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

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
Message-Id: <20230912224107.29669-5-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-12-alex.bennee@linaro.org>

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
2.39.2


