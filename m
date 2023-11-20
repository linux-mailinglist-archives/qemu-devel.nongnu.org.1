Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF98F7F1F5C
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:41:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5BxD-00017O-JX; Mon, 20 Nov 2023 16:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bx8-0000sM-Id
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:37:12 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bx2-0004L4-V5
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:37:08 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32ddfb38c02so3232694f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516208; x=1701121008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQm9clEeaAsqfkXJ+UfY2CLg9Wh2rq/brUmgmj9iQWU=;
 b=pfEXiHS4YcEiTtG6WmG8G0i/yRSMIXVUFjrsh08eOY+l6/rlpbw1h8eLXGwFsFYnMS
 1lzuf8vOtU1h51tijmBUN2WTSHuH18fi9Xhq+yJFs0OLfwIbuITMKlEr/st5M5FYpera
 cBY8hWv+Mt9QBN7UMxF++5tahrB6LH0VH0cxqIXCsW++dy+waB4vaJ+0KdyzBE9e9+TA
 9cbC2ExOm63QLpAXHYFEo0Mr5YxSCHPyyWfOOhJKV9o4D7eL+HSC0r5/e4QMJU7Le81d
 RBu0UDNECc3Zh13Vyn00x5XKQG1yln9bncCP/8MtkR0IXyxOs3HBxsJgEOPIZ//CeZZQ
 76OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516208; x=1701121008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQm9clEeaAsqfkXJ+UfY2CLg9Wh2rq/brUmgmj9iQWU=;
 b=iTsP+GtBS1kn7ChuAtILcpZ+jN35Fr6lDJ1wBGse0NVpTg3Qy4TWrtWh3rBt6+CXb1
 E6Fkwh+mLYgbkouawX+uIzznOc3oJS9fWBMY4MVavB5KrXeQOGVu46hjEngJsnbPRC89
 hncfVNu69UiwwH4NuS84oNf9QCw7fDo1uDQ2ftz6fF6r0jAuoMXXMRqtTac82cYGJagu
 0TUPJ8v4I1IYZX0B6YXUGd0UT+aMMPwf9vAZRY/TKUckwnVueaaN+XFIVdozUspRK54O
 WWh3gV2DN7W/VUJXy6KYsD2QWVHubHiQPxzyk520qG5ARv4E/oIebgfG30n4uUzB7TWK
 oRXg==
X-Gm-Message-State: AOJu0Yxa8IUMeJI9Sdoc2avsIJwub5oSHxmj49fTjH7Fu72VhIcg8nLh
 s4haNQ9vcrxxyl15AFjDBNt/yd3EqRXuOMYy21Y=
X-Google-Smtp-Source: AGHT+IHAKJ7RIB7+H8HQdeo7TpwytD3c234Zuu0bEkvAXHi7McyYwlv9W4jpBdIznNFfXNZ9YgkDWw==
X-Received: by 2002:a05:6000:381:b0:332:c593:16c with SMTP id
 u1-20020a056000038100b00332c593016cmr4272767wrf.45.1700516207758; 
 Mon, 20 Nov 2023 13:36:47 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a5d6c6f000000b00332cb17f87csm2549410wrz.5.2023.11.20.13.36.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:36:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH-for-9.0 18/25] util/oslib: Have qemu_prealloc_mem() handler
 return a boolean
Date: Mon, 20 Nov 2023 22:32:52 +0100
Message-ID: <20231120213301.24349-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Document Error API usage rules"), have cpu_exec_realizefn()
return a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/osdep.h | 4 +++-
 util/oslib-posix.c   | 7 +++++--
 util/oslib-win32.c   | 4 +++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 475a1c62ff..9a405bed89 100644
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


