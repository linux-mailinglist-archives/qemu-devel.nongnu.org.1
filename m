Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8EB7B70EE
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:33:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkBD-00089E-PA; Tue, 03 Oct 2023 14:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkB0-00088N-GU
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:22 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAp-0001fw-0Z
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:22 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-692ada71d79so967287b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357868; x=1696962668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzdMnZ/qp0IZVfsWupkBnwKkbY4o53yFm+NGR5vmj5I=;
 b=zIhJYxRjwahxpVlq4tEF2wLTtjU78anIkXvVl8oFB2GuvaGdZmh/3VQBRgQ2zFL67R
 /Jv79Qhwnj6hGq2AEOGZF2PDyxjLEG/hulvQ3WpnAPzm6GkInbgC7aQGdtNCqX1wN7t8
 5lOZ2w9kvVR3Envpg84w/lwnWgL6EBt42H8+kYYHw2IPf7YIXajmsKrI+waVZU03ld10
 ooD4BkfcwdftFXTjlsBA+C9szhLXRejmF/tRpQdAOvAUW4Y1miWom9hPRL3z7dgttbqr
 0B67V5bWgiekBRRaNFIoZgDQj7Qd+7o+Tn8ONienSkl/1kEup2jnLZw0nFa/J9Mo7TQH
 Gd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357868; x=1696962668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzdMnZ/qp0IZVfsWupkBnwKkbY4o53yFm+NGR5vmj5I=;
 b=qWZdp7GILw8FqZSdbLte0q6Z/ki0fjEicrK38z8w/jRPJfnEDn84evcCTsPoRYdtvZ
 A9wD6qgHOoXzxyffpPkgxHnQwClZXpbKDK/YXAhkuunnDzx+30vJDKrVuQcNzOSu6maZ
 clAgtsBl1G/KeUjoJD6tmY1JOVAf6/w4H7djLbm1q+aX0x3ziwBAOFh/HlTvtwEfZrsi
 eEppxjV4GNds+C+txcxkVkNKMFJXNBwCXi6UFbQ1VHSfob4+s9mkxBjIdEFa5I1qCKDs
 Vdhqdsfnoxd+eF5cYPSh88MgkPOR+Ygr9tBVoWYrYhetLBdSlqzfsrqM1sN4sIaCHd5G
 U8CQ==
X-Gm-Message-State: AOJu0YxHMJmiabmvsRgD03SU9ict/IVyD6IPi39K9czYYDOYLcP9Y7Bg
 kkMisV7G6N7KSlW4dromOJ1Qfgs4imNoKoRHKUk=
X-Google-Smtp-Source: AGHT+IGdYDITcHIKaZkgdI1lJbM+gT9x898s9U3/+xXYm7Qdv6EH+JaK0Aps6ryTxP//eyH7pqVD7w==
X-Received: by 2002:a05:6a20:9694:b0:15e:707c:904 with SMTP id
 hp20-20020a056a20969400b0015e707c0904mr250590pzc.24.1696357868289; 
 Tue, 03 Oct 2023 11:31:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
Subject: [PATCH v17 09/16] util/log: Add Error argument to qemu_str_to_log_mask
Date: Tue,  3 Oct 2023 11:30:51 -0700
Message-Id: <20231003183058.1639121-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Do not rely on return value of 0 to indicate error,
pass along an Error pointer to be set.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/log.h | 2 +-
 bsd-user/main.c    | 6 ++++--
 linux-user/main.c  | 7 +++++--
 monitor/hmp-cmds.c | 5 +++--
 softmmu/vl.c       | 7 +++++--
 util/log.c         | 5 +++--
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index df59bfabcd..9b92d2663e 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -87,7 +87,7 @@ bool qemu_set_log_filename(const char *filename, Error **errp);
 bool qemu_set_log_filename_flags(const char *name, int flags, Error **errp);
 void qemu_set_dfilter_ranges(const char *ranges, Error **errp);
 bool qemu_log_in_addr_range(uint64_t addr);
-int qemu_str_to_log_mask(const char *str);
+int qemu_str_to_log_mask(const char *str, Error **errp);
 
 /* Print a usage message listing all the valid logging categories
  * to the specified FILE*.
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 703f3e2c41..a981239a0b 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -411,8 +411,10 @@ int main(int argc, char **argv)
     {
         int mask = 0;
         if (log_mask) {
-            mask = qemu_str_to_log_mask(log_mask);
-            if (!mask) {
+            Error *err = NULL;
+            mask = qemu_str_to_log_mask(log_mask, &err);
+            if (err) {
+                error_report_err(err);
                 qemu_print_log_usage(stdout);
                 exit(1);
             }
diff --git a/linux-user/main.c b/linux-user/main.c
index 0c23584a96..d0464736cc 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -264,8 +264,11 @@ static void handle_arg_help(const char *arg)
 
 static void handle_arg_log(const char *arg)
 {
-    last_log_mask = qemu_str_to_log_mask(arg);
-    if (!last_log_mask) {
+    Error *err = NULL;
+
+    last_log_mask = qemu_str_to_log_mask(arg, &err);
+    if (err) {
+        error_report_err(err);
         qemu_print_log_usage(stdout);
         exit(EXIT_FAILURE);
     }
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 6c559b48c8..c4bd97d467 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -291,8 +291,9 @@ void hmp_log(Monitor *mon, const QDict *qdict)
     if (!strcmp(items, "none")) {
         mask = 0;
     } else {
-        mask = qemu_str_to_log_mask(items);
-        if (!mask) {
+        mask = qemu_str_to_log_mask(items, &err);
+        if (err) {
+            error_free(err);
             hmp_help_cmd(mon, "log");
             return;
         }
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 98e071e63b..02193696b9 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2486,8 +2486,11 @@ static void qemu_process_early_options(void)
     {
         int mask = 0;
         if (log_mask) {
-            mask = qemu_str_to_log_mask(log_mask);
-            if (!mask) {
+            Error *err = NULL;
+
+            mask = qemu_str_to_log_mask(log_mask, &err);
+            if (err) {
+                error_report_err(err);
                 qemu_print_log_usage(stdout);
                 exit(1);
             }
diff --git a/util/log.c b/util/log.c
index def88a9402..b5f08db202 100644
--- a/util/log.c
+++ b/util/log.c
@@ -500,8 +500,8 @@ const QEMULogItem qemu_log_items[] = {
     { 0, NULL, NULL },
 };
 
-/* takes a comma separated list of log masks. Return 0 if error. */
-int qemu_str_to_log_mask(const char *str)
+/* Takes a comma separated list of log masks. */
+int qemu_str_to_log_mask(const char *str, Error **errp)
 {
     const QEMULogItem *item;
     int mask = 0;
@@ -524,6 +524,7 @@ int qemu_str_to_log_mask(const char *str)
                     goto found;
                 }
             }
+            error_setg(errp, "Invalid -d option \"%s\"", *tmp);
             goto error;
         found:
             mask |= item->mask;
-- 
2.34.1


