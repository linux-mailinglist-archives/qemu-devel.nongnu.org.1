Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E7E78D6AF
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaL-0001EF-Mn; Wed, 30 Aug 2023 10:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaH-0001BE-QZ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaD-0000kB-Sy
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:17 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-313e742a787so634726f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407252; x=1694012052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+4c/0Q7/eLM71cRhHLrdgn3bw80ZIKHk11jFduNmfQ=;
 b=fDVWffmNd2+y6E8EFV4pwLMM7WD8JINn39nRkXhuZ7l0KVfuV1XUP/tcowZPnbob7L
 D6q5PmhiXYScCxyvOtv9IM/kiFDecxewREfaWkGte9aceamZiUGlV24TOwtOu6b1mMWd
 bJklnYTCJ6aabolLqPGrEjEsVjO/zDoLQNZVsQJqscH9+A3gR0wW/jkB3P9WJgekzg8s
 izQkiYew+eiVTwMdlIq75O0BYJzHWGi/EG3fB/qAn4N43C24amP/tbx7gbefa5sgCbBM
 2c1BXR0DAEJ2y4Hdwrxb8Wac5wA8h25GVFaBT9m7yd++AfG8Nv8RLVPvSccBHg/cILOj
 m+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407252; x=1694012052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+4c/0Q7/eLM71cRhHLrdgn3bw80ZIKHk11jFduNmfQ=;
 b=MpRVrCPcbiGDNUvupaOid47WEa/Ez1/9a/5vG1zMpUoAqnPizY/lOwX4gL3od33uCg
 DtChPZUxNycQLggTKBQwwn8ZKSsR44nVbjmret74/Q2F70RUqpuNAUvruaUiGndjMV9v
 UZ9eSqmOwJQQUeUaTn3UKoeuG1jtWtlPKL4O7ztOCnJvFRd/VSC/4dzCLM9LB87E5p0n
 IrOSeUTCWq6l4HDHzdBz6fVpGmRy/ZCLmp7ILG9mcUTDE+DI6v9XJ58TPkYJCApJFz7L
 7U3zWbTtSYQ4bdCcfWUZaXht0ty566EfuCLp3sf3ZPeJKAcJz1uPjfBRDWNSmBlMwzUf
 ifHQ==
X-Gm-Message-State: AOJu0YwtueGgI72CgbTx4dOMXVm+lJ7gCiOKBXpFhCklHNVl371qUp22
 rERBXy0KOf7ronj+0wtAR1NaSA==
X-Google-Smtp-Source: AGHT+IFR6j2JNVE1HL1ChcVANUFaE0M2qCwm6RAK8ebr479Lnvj8b4HoPOAObavsYqsg8OXWgp1qKw==
X-Received: by 2002:adf:e54f:0:b0:319:7ec8:53ba with SMTP id
 z15-20020adfe54f000000b003197ec853bamr1938558wrm.14.1693407252565; 
 Wed, 30 Aug 2023 07:54:12 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a5d5709000000b00317b5c8a4f1sm16858004wrv.60.2023.08.30.07.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9E5141FFC3;
 Wed, 30 Aug 2023 15:54:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 09/12] gdbstub: remove unused user_ctx field
Date: Wed, 30 Aug 2023 15:54:04 +0100
Message-Id: <20230830145407.3064249-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830145407.3064249-1-alex.bennee@linaro.org>
References: <20230830145407.3064249-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230829161528.2707696-10-alex.bennee@linaro.org>

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


