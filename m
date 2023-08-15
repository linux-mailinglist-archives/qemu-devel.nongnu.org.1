Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 506EC77CE81
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:53:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvOj-00060H-Sp; Tue, 15 Aug 2023 10:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOe-0005uL-4C
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:49 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOP-0006Hv-Ry
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-319779f0347so1746152f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692111092; x=1692715892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogCxZYZaoEvrj5iiH+2Bm7In/45Ks3iQ2LZbKz8QbrY=;
 b=nS1/AUa7SSvoR5HRTqpZklmBo9ckwFTBprwIE08Zq+51uaCfrjz9YFA6dZedBq8I0w
 yukVKe7HPbXGbYeQd8+2PidtHtqu7O2hzyx0EjB0ld9fn91MWfblvdPd1EPWTcEo6N9L
 YjfBnCxx2CeIrPkDY2V2g5BUHZ48FsWbOSlTlF7cQFOjjYZEJVtvXEKmBzYEq+NSP0su
 7ncXOHB42IEwz4VfaoFnQFSVuufFvYbq43BLwB7Q+PcKlgjZLLrW5O4D9mf2f4SSGN4E
 9EzVsRMt6HKLM8mVn9c2/WdVd4lBH0beVRF+HkDp7hy3CGv4sw1xci8bEyPNPcpX9QlP
 dfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692111092; x=1692715892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogCxZYZaoEvrj5iiH+2Bm7In/45Ks3iQ2LZbKz8QbrY=;
 b=iBH5M1OiOWBSOJvxWAV2N3tXg+lt53Ly+mrRwLf5GmSJrh/HxwpTqnVQni4pGN0Vhw
 Js8UHIrwt3oJDEx4dRNy/7mvzCoPR250kz4oA5ANxVxbFraWjyGOTrORJozsvDqZSl6+
 maMj5Wk1TeF01DEcsv/ROkxWaD5W00BaCSeyAv9pD5HLUrjqTOftATPxuxddDNmWDgKy
 RhiHdcNnq1WXro6pwpMn3rmvtOt0cI1mcOWIsmk4eYSqYC3h7eZOWebms+MQXWl3WwAh
 wWCQt+nsruBD6FI0+2eHbuRQsr1xgj2toBzPp6ogQfFEtZEv2qG7cHzvi3qNR/Ev/z4Z
 9e+w==
X-Gm-Message-State: AOJu0YxtpsSMBp1NK80/o2Ys/Ueq80Nmrckf3kMzDxo0RP+O9/PdH3kP
 hCc8Ft6nrPcwFFglDQ8PKCkUHA==
X-Google-Smtp-Source: AGHT+IGRetNJZeDo34HAmroa89v0f5yP+46F9m1p6VhVuO7FvQx50pFsVSLzBI1RoBfNH9LH3NefUQ==
X-Received: by 2002:adf:f80c:0:b0:319:8979:8fcc with SMTP id
 s12-20020adff80c000000b0031989798fccmr908216wrp.70.1692111091915; 
 Tue, 15 Aug 2023 07:51:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f14-20020adffcce000000b00317a04131c5sm18148968wrs.57.2023.08.15.07.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:51:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ACABC1FFC2;
 Tue, 15 Aug 2023 15:51:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 7/9] gdbstub: remove unused user_ctx field
Date: Tue, 15 Aug 2023 15:51:24 +0100
Message-Id: <20230815145126.3444183-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815145126.3444183-1-alex.bennee@linaro.org>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


