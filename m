Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F311825756
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:59:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmTQ-0002oc-L8; Fri, 05 Jan 2024 10:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmRt-0007kW-3w
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:49:30 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmRq-0008ME-2U
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:49:28 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d2376db79so13010785e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469764; x=1705074564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1UceGM9JMyf+mvn5Vqfm2bFDJfnlw6Hthf90m+0+RM=;
 b=uz3+Keveir5GfCNNPI4bKaz/IJviY0QjaiHfbycrEa3nNitGKCHtXLcEG7wGWqhwWN
 jWYM/6Ziz+NElFCvid4OHeIU70L0VL9A3JHaSiCBE7DXXVC3DmWwJhWf5GCpnj9D3dwO
 BBL/L1aRVNdR6wvDbbHxpFg42BY4BbiUFdQWg+irIS9J/fuMW3kv5DxSxkTegPANxkq9
 +9ofRqjBB4gwTuMFk20jSoXKMZT1dJ28zm0WtVsW8Ku8oaDcNnEGz69xmjn2DJrNXnaG
 /8SsBr2w/p8mxe+lqUP5t3oMs4nEOhUD9DHpNyADmyEybbRJWkThlqOvgDFFYtO98Zu2
 2thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469764; x=1705074564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1UceGM9JMyf+mvn5Vqfm2bFDJfnlw6Hthf90m+0+RM=;
 b=G3g+9malKF6cKP179piJxGw6ZxtYREoYtkxnCM5BmV+FWgmc7xFXnKYe+Bv4W4beTQ
 SfFus5Q7yj8CnZeyIQsxW35aKUoAueHlerDyUBilnL5bZ0sE4x9BZCq/QRVIUKHp9x7R
 S2tRvGL6v+yJk7ZS70qQLwp5+A4+9YgS0n+ouneRWA8ZfK09zw2ecim+FGCNOmE0Mntd
 Ca8GkDkD3+0DsU8Cq3swuCF/hpG3jzSXNHXEDGVGezwFkYhP8D1AhAqBeOpvAOHCF440
 9CLywyx8Sih9wLh7fmdoJ+NAwjoxMMWdUJia0C9tQc18+CDFZ85CEPJGHal7ddEUaBfC
 iCvg==
X-Gm-Message-State: AOJu0YygvahTLq+2UpKmA4U1s8JuOBenp+hyUmemz+Va0lqtzeBGM5nl
 nLt67cB/CK4ZZ8elSi9TvMbt4JB5IKAYSEM8AQQyuqIGsRQ=
X-Google-Smtp-Source: AGHT+IHccUNpKVVjTXlW0mJxNGaQ6Af5HH0OlIBwUtFVNZbg5nXxb16dddyAiKNMmNcnjXOoYKYcLQ==
X-Received: by 2002:adf:e9d2:0:b0:337:39c7:48 with SMTP id
 l18-20020adfe9d2000000b0033739c70048mr1522360wrn.1.1704469764364; 
 Fri, 05 Jan 2024 07:49:24 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 d10-20020a056000114a00b00336710ddea0sm1618390wrx.59.2024.01.05.07.49.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:49:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PULL 61/71] util/oslib: Have qemu_prealloc_mem() handler return a
 boolean
Date: Fri,  5 Jan 2024 16:42:54 +0100
Message-ID: <20240105154307.21385-62-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Following the example documented since commit e3fe3988d7 ("error:
Document Error API usage rules"), have qemu_prealloc_mem()
return a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20231120213301.24349-19-philmd@linaro.org>
---
 include/qemu/osdep.h | 4 +++-
 util/oslib-posix.c   | 7 +++++--
 util/oslib-win32.c   | 4 +++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index d30ba73eda..db366d6796 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -678,8 +678,10 @@ typedef struct ThreadContext ThreadContext;
  * memory area starting at @area with the size of @sz. After a successful call,
  * each page in the area was faulted in writable at least once, for example,
  * after allocating file blocks for mapped files.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
+bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
                        ThreadContext *tc, Error **errp);
 
 /**
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index e86fd64e09..7c297003b9 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -497,7 +497,7 @@ static bool madv_populate_write_possible(char *area, size_t pagesize)
            errno != EINVAL;
 }
 
-void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
+bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
                        ThreadContext *tc, Error **errp)
 {
     static gsize initialized;
@@ -506,6 +506,7 @@ void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
     size_t numpages = DIV_ROUND_UP(sz, hpagesize);
     bool use_madv_populate_write;
     struct sigaction act;
+    bool rv = true;
 
     /*
      * Sense on every invocation, as MADV_POPULATE_WRITE cannot be used for
@@ -534,7 +535,7 @@ void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
             qemu_mutex_unlock(&sigbus_mutex);
             error_setg_errno(errp, errno,
                 "qemu_prealloc_mem: failed to install signal handler");
-            return;
+            return false;
         }
     }
 
@@ -544,6 +545,7 @@ void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
     if (ret) {
         error_setg_errno(errp, -ret,
                          "qemu_prealloc_mem: preallocating memory failed");
+        rv = false;
     }
 
     if (!use_madv_populate_write) {
@@ -555,6 +557,7 @@ void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
         }
         qemu_mutex_unlock(&sigbus_mutex);
     }
+    return rv;
 }
 
 char *qemu_get_pid_name(pid_t pid)
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 55b0189dc3..c4a5f05a49 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -264,7 +264,7 @@ int getpagesize(void)
     return system_info.dwPageSize;
 }
 
-void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
+bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
                        ThreadContext *tc, Error **errp)
 {
     int i;
@@ -274,6 +274,8 @@ void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
     for (i = 0; i < sz / pagesize; i++) {
         memset(area + pagesize * i, 0, 1);
     }
+
+    return true;
 }
 
 char *qemu_get_pid_name(pid_t pid)
-- 
2.41.0


