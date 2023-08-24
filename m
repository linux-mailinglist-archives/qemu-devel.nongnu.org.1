Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EF77875B3
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:42:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDMt-0006Sd-Q3; Thu, 24 Aug 2023 12:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMr-0006RS-Lp
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:33 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMc-00088O-N2
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fef34c33d6so37862095e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895157; x=1693499957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJCZgUqtNI+daMdUYjVlrZWwj/un9QkYSZBSgf2eRpg=;
 b=dixA/qfqucwzgavun24v6ADF8thvsjRdd+JTO8IreM+AzsLAuX1UPI9fC/wd+PANMS
 z+RWeneJKxjx05jPHCW4JlNu6zQ7HHCU+4edMLISyCKJhn7+DabMLTeaZh13pqJX+jSJ
 k+pdIg/rwDd9LafBXRZSbwWIdZ8JEWn1AFpi8R1+l9CGsO67nluLGPGU/A56s3UGog4F
 t92HdMTFtFUua+V7OMe2RpAzsXlAKqWdGL4UPsWx/ppJYNaiJBIcqAn6gWzUVr566Jn7
 /YRf6bIbKj8NvDjWjxBcGAMAOCkLs4bm6j4Q+zrJXvORGCwxhV8YOk5BqPe5ZGfTm5Lg
 kl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895157; x=1693499957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJCZgUqtNI+daMdUYjVlrZWwj/un9QkYSZBSgf2eRpg=;
 b=aJQlKN8xsQhDyhz47kCkTadXNLlpBqbnRPHI2wl+XlfKAAwhVKFxe29twajMYX7eZq
 uNJzxsXZg0NcCgfdPHJYmFODyAKxrXq/DWn4NE248fMRKZ1vT2yZJEQnyA/EV+Ua0jbI
 ogVGgeWteZm8dRGO2xd8D/RM/o1i4R/YrlDlfP4tR/E1f59V1D9wimOVu6lkrV7kq7cc
 FN61JAg2nbgrZodidwh5X1/zF/VTqKqINbY/9OKdPCfAcO3EqPByj8M3iJyT2oK3uxoD
 3/aWGvj1MjgMMsjyXTmObfQUqyOrtpjwzTdAOomKsY7wp5ycfjm15tPzwmmjIhi4LpCM
 iGHw==
X-Gm-Message-State: AOJu0YxwhFM8R/FvR12mrJP+uxNNOhTlXdp1tRy38yfZYn75z3s4ibUJ
 BPffUVGETbmp1pC7lkU7WLC+Og==
X-Google-Smtp-Source: AGHT+IGInqOieWcpu6J1Un9vGHkVBc2YG6AipbTFG2naQ2IUhJt2D+T2BCffRRkC1Jua1DrPUmgwFA==
X-Received: by 2002:a1c:4b05:0:b0:3fb:e58c:7758 with SMTP id
 y5-20020a1c4b05000000b003fbe58c7758mr4829516wma.3.1692895157242; 
 Thu, 24 Aug 2023 09:39:17 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n24-20020a7bcbd8000000b003fef6881350sm3141019wmi.25.2023.08.24.09.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:39:15 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4DC8C1FFC4;
 Thu, 24 Aug 2023 17:39:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 09/12] gdbstub: remove unused user_ctx field
Date: Thu, 24 Aug 2023 17:39:07 +0100
Message-Id: <20230824163910.1737079-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824163910.1737079-1-alex.bennee@linaro.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

This was always NULL so drop it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index e7d48fa0d4..8e9bc17e07 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -836,7 +836,7 @@ static inline int startswith(const char *string, const char *pattern)
   return !strncmp(string, pattern, strlen(pattern));
 }
 
-static int process_string_cmd(void *user_ctx, const char *data,
+static int process_string_cmd(const char *data,
                               const GdbCmdParseEntry *cmds, int num_cmds)
 {
     int i;
@@ -863,7 +863,7 @@ static int process_string_cmd(void *user_ctx, const char *data,
         }
 
         gdbserver_state.allow_stop_reply = cmd->allow_stop_reply;
-        cmd->handler(params, user_ctx);
+        cmd->handler(params, NULL);
         return 0;
     }
 
@@ -881,7 +881,7 @@ static void run_cmd_parser(const char *data, const GdbCmdParseEntry *cmd)
 
     /* In case there was an error during the command parsing we must
     * send a NULL packet to indicate the command is not supported */
-    if (process_string_cmd(NULL, data, cmd, 1)) {
+    if (process_string_cmd(data, cmd, 1)) {
         gdb_put_packet("");
     }
 }
@@ -1394,7 +1394,7 @@ static void handle_v_commands(GArray *params, void *user_ctx)
         return;
     }
 
-    if (process_string_cmd(NULL, get_param(params, 0)->data,
+    if (process_string_cmd(get_param(params, 0)->data,
                            gdb_v_commands_table,
                            ARRAY_SIZE(gdb_v_commands_table))) {
         gdb_put_packet("");
@@ -1738,13 +1738,13 @@ static void handle_gen_query(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(NULL, get_param(params, 0)->data,
+    if (!process_string_cmd(get_param(params, 0)->data,
                             gdb_gen_query_set_common_table,
                             ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (process_string_cmd(NULL, get_param(params, 0)->data,
+    if (process_string_cmd(get_param(params, 0)->data,
                            gdb_gen_query_table,
                            ARRAY_SIZE(gdb_gen_query_table))) {
         gdb_put_packet("");
@@ -1757,13 +1757,13 @@ static void handle_gen_set(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(NULL, get_param(params, 0)->data,
+    if (!process_string_cmd(get_param(params, 0)->data,
                             gdb_gen_query_set_common_table,
                             ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (process_string_cmd(NULL, get_param(params, 0)->data,
+    if (process_string_cmd(get_param(params, 0)->data,
                            gdb_gen_set_table,
                            ARRAY_SIZE(gdb_gen_set_table))) {
         gdb_put_packet("");
-- 
2.39.2


