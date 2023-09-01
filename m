Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4643A7902F0
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:45:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAzD-0007AT-QF; Fri, 01 Sep 2023 16:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyr-0006xh-Bo
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:01 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyn-0001x6-VO
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:01 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a520dba33so2121471b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693600976; x=1694205776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DWAv0bR3QBWPP10gPMl5GXU+szn3XnQPYnLcaRRAHU=;
 b=s8bWWaUUx00gfcYOn0IPaujePZo+lQrnx7nNCUL8FErzjMQds7A4AUfSMGBHR9vF0B
 UPfClH6UMSQwHy1KhLWRuTDKdCZuUXqQNsdGITx2pLfohwLAPAG1FbOc5uduChN8JP/F
 w+Pki2iTykHZR8CQrBOxSw5pYJUJXFDqFrisUa5Hnt8Mv8h59UssIg0cu6BvfrOcW5YA
 DqiHXEbXf4CclZSLP7umy61iqcWjrfK3MVUi0aDUhziAFWVNIyzzHRt8x89E36e4xWbW
 xWiUOImx/8ITs3A0ef2Dlnni9TrUPNnG2Uuw12bRHnoSCFsj1czqDJ5ov71ZAGiXNn//
 gBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600976; x=1694205776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DWAv0bR3QBWPP10gPMl5GXU+szn3XnQPYnLcaRRAHU=;
 b=KjtOTMABsLE6rKsPQi9Azfm8r7rLQh3gesu9Qk2d+QY76YfaeWq97ETuWp6fvuRW06
 x9WzQdayk9HqaBrvPExEH/r3LuSZlby1NOMm5bOOIcUKW6KUw4Z8Jd4hUUy+CaDv65Ar
 uRHpEWMTWSY1F05fXQGaFmr40A8WYw5WlxKtSSGRnr1So5NSOZtDbuGZiUUS168sEQ5I
 2mOzcH3/52IRBR+tLk0H9sozcUAVvgrNIq0pVHMnw3nuc5ft+BDPqF2TKTqI/1AlR/bd
 znkIzXymbU9CZEgUWsFGkj9C93c5LaSOjCMSzk2+csNKINhdV8hf23Nw52svHBJZrTVF
 1V0A==
X-Gm-Message-State: AOJu0YxBq3iEnLt9WC9EwkITQy2guMRAtwZia78D+r6Q4fxsyDBMv1Q/
 G9Yn8Cv8XsR9KACZQwiZjGr25uAAbxnbv6J7qPQ=
X-Google-Smtp-Source: AGHT+IEgK4ZL6Wt/2NrCzHAbeLakUmemzBHoGJPFFlSG3mWbx6hlKvnoWbr3ZHPLJj/uigaAS7fNlg==
X-Received: by 2002:a05:6a20:8f28:b0:135:7975:f55 with SMTP id
 b40-20020a056a208f2800b0013579750f55mr4821957pzk.47.1693600976425; 
 Fri, 01 Sep 2023 13:42:56 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b0068c97a4eb0dsm3320666pfe.191.2023.09.01.13.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:42:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/13] util/selfmap: Use dev_t and ino_t in MapInfo
Date: Fri,  1 Sep 2023 13:42:42 -0700
Message-Id: <20230901204251.137307-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204251.137307-1-richard.henderson@linaro.org>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Use dev_t instead of a string, and ino_t instead of uint64_t.
The latter is likely to be identical on modern systems but is
more type-correct for usage.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/selfmap.h |  4 ++--
 linux-user/syscall.c   |  6 ++++--
 util/selfmap.c         | 12 +++++++-----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/qemu/selfmap.h b/include/qemu/selfmap.h
index 7d938945cb..1690a74f4b 100644
--- a/include/qemu/selfmap.h
+++ b/include/qemu/selfmap.h
@@ -20,10 +20,10 @@ typedef struct {
     bool is_exec;
     bool is_priv;
 
+    dev_t dev;
+    ino_t inode;
     uint64_t offset;
-    uint64_t inode;
     const char *path;
-    char dev[];
 } MapInfo;
 
 /**
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index faad3a56df..a562920a84 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8160,13 +8160,15 @@ static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
             }
 
             count = dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
-                            " %c%c%c%c %08" PRIx64 " %s %"PRId64,
+                            " %c%c%c%c %08" PRIx64 " %02x:%02x %"PRId64,
                             h2g(min), h2g(max - 1) + 1,
                             (flags & PAGE_READ) ? 'r' : '-',
                             (flags & PAGE_WRITE_ORG) ? 'w' : '-',
                             (flags & PAGE_EXEC) ? 'x' : '-',
                             e->is_priv ? 'p' : 's',
-                            (uint64_t) e->offset, e->dev, e->inode);
+                            (uint64_t)e->offset,
+                            major(e->dev), minor(e->dev),
+                            (uint64_t)e->inode);
             if (path) {
                 dprintf(fd, "%*s%s\n", 73 - count, "", path);
             } else {
diff --git a/util/selfmap.c b/util/selfmap.c
index 4db5b42651..483cb617e2 100644
--- a/util/selfmap.c
+++ b/util/selfmap.c
@@ -30,19 +30,21 @@ IntervalTreeRoot *read_self_maps(void)
 
         if (nfields > 4) {
             uint64_t start, end, offset, inode;
+            unsigned dev_maj, dev_min;
             int errors = 0;
             const char *p;
 
             errors |= qemu_strtou64(fields[0], &p, 16, &start);
             errors |= qemu_strtou64(p + 1, NULL, 16, &end);
             errors |= qemu_strtou64(fields[2], NULL, 16, &offset);
+            errors |= qemu_strtoui(fields[3], &p, 16, &dev_maj);
+            errors |= qemu_strtoui(p + 1, NULL, 16, &dev_min);
             errors |= qemu_strtou64(fields[4], NULL, 10, &inode);
 
             if (!errors) {
-                size_t dev_len, path_len;
+                size_t path_len;
                 MapInfo *e;
 
-                dev_len = strlen(fields[3]) + 1;
                 if (nfields == 6) {
                     p = fields[5];
                     p += strspn(p, " ");
@@ -52,11 +54,12 @@ IntervalTreeRoot *read_self_maps(void)
                     path_len = 0;
                 }
 
-                e = g_malloc0(sizeof(*e) + dev_len + path_len);
+                e = g_malloc0(sizeof(*e) + path_len);
 
                 e->itree.start = start;
                 e->itree.last = end - 1;
                 e->offset = offset;
+                e->dev = makedev(dev_maj, dev_min);
                 e->inode = inode;
 
                 e->is_read  = fields[1][0] == 'r';
@@ -64,9 +67,8 @@ IntervalTreeRoot *read_self_maps(void)
                 e->is_exec  = fields[1][2] == 'x';
                 e->is_priv  = fields[1][3] == 'p';
 
-                memcpy(e->dev, fields[3], dev_len);
                 if (path_len) {
-                    e->path = memcpy(e->dev + dev_len, p, path_len);
+                    e->path = memcpy(e + 1, p, path_len);
                 }
 
                 interval_tree_insert(&e->itree, root);
-- 
2.34.1


