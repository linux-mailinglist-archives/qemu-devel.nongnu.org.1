Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC7821649
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:02:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3p-0003ms-KJ; Mon, 01 Jan 2024 20:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3i-0003j9-Lg
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:10 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3g-00075j-Ed
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:09 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6dc076e9e59so2729515a34.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160747; x=1704765547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LV9BWeIPWKBGrvgXFvetwVNAgJ38p+dzeW1kf+TIio=;
 b=SG/N1pj7BXKzF/Ss96QBChs2jsUHiYT36UCi15Nq2XipIoKNbt/2YezgIJaPfw0bra
 BlP1EmDs8zROAWZ1roYgjjN+YMQ0aS1hRS+3uFNirjnRsN9hd3QM+36AGx3b5SObvs9a
 BHafrX1wr0VeF3UI5P83Wo8LrhH4uoKk/zDCl+AhM9ns+Gk9+0gOkECD83cmYOM74O1H
 0n2RwdDzLpSwU0c7ratI9DEYP6bfWGwwMhR6sklbg6VR3n4HLEy/FH0PcqoAbmokE2xQ
 4B1acsgztcpxXplbMDhzFi1/TADHZbe5oWkb2QM1vIUyPuYDmGjGOI5hX6JsHrDmtseQ
 ROXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160747; x=1704765547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/LV9BWeIPWKBGrvgXFvetwVNAgJ38p+dzeW1kf+TIio=;
 b=A5CEy12flEhTOAG529tvN+CKFBoAbv5Hll6h5iF5otvkuSv3QPVmVSBiF5yAKAMVUr
 i9rXjTz/eVy+iiJDNQmUS/WDQd6ZWaDQ/9vKMbmYnoiAeTTAQ6Pk7b8XQEf40kb3htzW
 +TxjP8adzMyHRRnkKTQ9atVtBYpGtujmcQgX8unceYnq29GCSZaV59MJ9WENMa1tf1/T
 pAOY7AOWOECOLteFE1foj+OEtzVRBQhQIjmtwfwWMxwa+ICIt61rkOUsOmby/n/ocjSL
 Gv/DC/8iJP7+EU8JwQciRUF1VHiHrZGNF13R8G5Ejqnb58xg7ko1q2c5guH8oCHFDL6q
 hGtg==
X-Gm-Message-State: AOJu0YxoCBpqI5j2OOR8M/4bqQS7u5qo15XGKprR2aNzccKwEVC1+Yqg
 MEVkzavcYDWQfhSIGS62q8OZNqLdKe06J3zmrb7qutoy9rg=
X-Google-Smtp-Source: AGHT+IEYU0ikW+j+V1JZPhxVm/73oA5fxUtqhtTGcbdV1s3BKxrC+q7yu0IeqU0GKAbfqlvT8igRCg==
X-Received: by 2002:a9d:7659:0:b0:6dc:48c1:3e4c with SMTP id
 o25-20020a9d7659000000b006dc48c13e4cmr1888122otl.57.1704160746868; 
 Mon, 01 Jan 2024 17:59:06 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:59:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 26/33] *-user: Deprecate and disable -p pagesize
Date: Tue,  2 Jan 2024 12:58:01 +1100
Message-Id: <20240102015808.132373-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/about/deprecated.rst |  7 +++++++
 docs/user/main.rst        |  3 ---
 bsd-user/main.c           |  9 +++++----
 linux-user/main.c         | 11 ++++++-----
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2e15040246..a499583a62 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -95,6 +95,13 @@ Use ``-accel tcg,one-insn-per-tb=on`` instead.
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
index e6014f517e..ba159d2984 100644
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
index 5f217cc2a8..9ba4dc5872 100644
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


