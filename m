Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7078F71F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpc-0007UO-Vy; Thu, 31 Aug 2023 22:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpZ-0007AW-IM
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:17 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpI-0001Sh-Ty
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:11 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-56f84de64b9so938368a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535034; x=1694139834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWlmLzbT46bw9EM178vXYTWBMPDHKbwER57wNuihdYA=;
 b=kQWkOG2wLtIiIwwLrHar4dkTT8VpAHROrHH9hW/s6RIrJw0NNmJxPU+qwtBbmVWFgr
 okmG40HLi1WdwLN08+TKfkx1mP86dXllV4S0o0ze4dGSLuZzn8iL4y3RDGV31KgoDVUH
 3FrTi6bNnLFU3/+kJWJGObOwqtMRzjPhVoegH02eD95Tzmw1tS4FuO/GtBcI8J7jsMwM
 wjZucH4y4OMqq2ESDDhOf0+s8qwU3k7+Cob2Uw3jsPYpfPFQ/PJJL5llTWzdHNtePYRA
 rhlYbklra8TVsKWAo7LF077YxqS7PftYcrgRj6t790SiKq7LIGETcWcUx6SqvOoqd8cJ
 eKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535034; x=1694139834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWlmLzbT46bw9EM178vXYTWBMPDHKbwER57wNuihdYA=;
 b=gg4zlnBXDGwCtIdqgeOoAIiYdIGhPkExHbgpzOd1TdNGIeTxROLgfuYUiyDNeRxHUG
 +41noovd9oqds4XOvoPJftsnxcuYf/dp5zrI7pdvAQvbdIrIPOwMVOOf7G6iB99JVo+W
 /HZZScKzR8aqh69kv/VMZFHUuGpfbXN/ZO3AXgp8ogaCjlfuwTgwzIriB+4/NwZIX3vL
 yK7V2mlrbyvAESgUEqTwS9h4emnMgAVrJFiI3PAq3M9JPo8IymgcgqYtvgIu8eWoDfqs
 dlmhVUePj5KuXDBrVx/ZFaHRwcpjvGYiB6F/bc23obnuWe+uxxanb6FkUdF737o/F9Wh
 lLmw==
X-Gm-Message-State: AOJu0Ywd1avF/tFvJafu5UeDCUEMaKS7dvMCjl8GnoWdz+rplSwnBiL/
 PCHi25TNH5pXS3c9cZSngPC/+66IN6h9tvU3IQs=
X-Google-Smtp-Source: AGHT+IG859Fs/jE5/vpB4eHKIt/skavzlIAn8xqAVObcdh/Cu57LGpC9mVQZyhmLkNAJ4vQlVtW5Cg==
X-Received: by 2002:a05:6a20:54a2:b0:133:38cb:2b93 with SMTP id
 i34-20020a056a2054a200b0013338cb2b93mr1802534pzk.9.1693535033856; 
 Thu, 31 Aug 2023 19:23:53 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org,
	Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 26/33] *-user: Deprecate and disable -p pagesize
Date: Thu, 31 Aug 2023 19:23:24 -0700
Message-Id: <20230901022331.115247-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

This option controls the host page size.  From the mis-usage in
our own testsuite, this is easily confused with guest page size.

The only thing that occurs when changing the host page size is
that stuff breaks, because one cannot actually change the host
page size.  Therefore reject all but the no-op setting as part
of the deprecation process.

Cc: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/about/deprecated.rst |  7 +++++++
 docs/user/main.rst        |  3 ---
 bsd-user/main.c           |  9 +++++----
 linux-user/main.c         | 11 ++++++-----
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 92a2bafd2b..25f8220449 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -131,6 +131,13 @@ Use ``-accel tcg,one-insn-per-tb=on`` instead.
 User-mode emulator command line arguments
 -----------------------------------------
 
+``-p`` (since 8.2)
+''''''''''''''''''
+
+The ``-p`` option pretends to control the host page size.  However,
+it is not possible to change the host page size, and using the
+option only causes failures.
+
 ``-singlestep`` (since 8.1)
 '''''''''''''''''''''''''''
 
diff --git a/docs/user/main.rst b/docs/user/main.rst
index f478635396..3a07be1278 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -87,9 +87,6 @@ Debug options:
    Activate logging of the specified items (use '-d help' for a list of
    log items)
 
-``-p pagesize``
-   Act as if the host page size was 'pagesize' bytes
-
 ``-g port``
    Wait gdb connection to port
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index f913cb55a7..f227d87834 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -365,10 +365,11 @@ int main(int argc, char **argv)
         } else if (!strcmp(r, "L")) {
             interp_prefix = argv[optind++];
         } else if (!strcmp(r, "p")) {
-            qemu_host_page_size = atoi(argv[optind++]);
-            if (qemu_host_page_size == 0 ||
-                (qemu_host_page_size & (qemu_host_page_size - 1)) != 0) {
-                fprintf(stderr, "page size must be a power of two\n");
+            unsigned size, want = qemu_real_host_page_size();
+
+            if (qemu_strtoui(arg, NULL, 10, &size) || size != want) {
+                error_report("Deprecated page size option cannot "
+                             "change host page size (%u)", want);
                 exit(1);
             }
         } else if (!strcmp(r, "g")) {
diff --git a/linux-user/main.c b/linux-user/main.c
index c1058abc3c..3dd3310331 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -332,10 +332,11 @@ static void handle_arg_ld_prefix(const char *arg)
 
 static void handle_arg_pagesize(const char *arg)
 {
-    qemu_host_page_size = atoi(arg);
-    if (qemu_host_page_size == 0 ||
-        (qemu_host_page_size & (qemu_host_page_size - 1)) != 0) {
-        fprintf(stderr, "page size must be a power of two\n");
+    unsigned size, want = qemu_real_host_page_size();
+
+    if (qemu_strtoui(arg, NULL, 10, &size) || size != want) {
+        error_report("Deprecated page size option cannot "
+                     "change host page size (%u)", want);
         exit(EXIT_FAILURE);
     }
 }
@@ -496,7 +497,7 @@ static const struct qemu_argument arg_table[] = {
     {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
      "logfile",     "write logs to 'logfile' (default stderr)"},
     {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
-     "pagesize",   "set the host page size to 'pagesize'"},
+     "pagesize",   "deprecated change to host page size"},
     {"one-insn-per-tb",
                    "QEMU_ONE_INSN_PER_TB",  false, handle_arg_one_insn_per_tb,
      "",           "run with one guest instruction per emulated TB"},
-- 
2.34.1


