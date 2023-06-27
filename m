Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 482AA73FAC3
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:07:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6Wb-00060d-Cv; Tue, 27 Jun 2023 07:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE6WV-00060F-Lb
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:06:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE6WT-0002Nd-Dp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:06:15 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3112f256941so3970621f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687863960; x=1690455960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7NEGw3MmnLBEc4mR4nWzFGOUShsvbkyyXww1ZRv5cX8=;
 b=LJa+hZNSoL3v4QS/ymLRzswq8+iPvostUBzYICz/WQIcGbGVHBnNpyosMsIh5xkHdN
 grHuhg7V4CqdUGdWRfS9sfIiGBtnpGNOeoUOyNmaJ4DsHemUndklcT3rq36KhDJJDbku
 +Y7zAHEmaPzKcSrau/2Jcb1NpxobDH2RbOCuRVhQoHthTME9Di1O5/46vIPz4AVmnvDr
 JhHRPAUDtOEjB7DVB3PY8vKXG8jX5az1iR2URA17/OcfTF4FVBAD3z8K8ixB9f4EXnp0
 hLWPa5KaQP0kb+BoQpY4Z6rC61gbd2976sb1pZDxc+CxuIJPAaRDh/PvdPEnVMPzFkv3
 umKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687863960; x=1690455960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7NEGw3MmnLBEc4mR4nWzFGOUShsvbkyyXww1ZRv5cX8=;
 b=SlOqYBaRIPajYTYqRZOC0XvYguwy+bGnJ4GjZuVj/FUPXvCFrKGJa3J+W7MHUgMIfc
 eT2lGXG3RXayhY7eZ/cMrLCUDxfGByfF/PDU7Vxyr/jZ2SV5rITn75hhfsVZnnrxDf0o
 /1c4QAZJ4t6xGKBvwvzo/3fTxyt5N0R343N5z/lZ35pB5PakFo1dAP2lWJuUmpVtDRY2
 QtDZJOnYB+Z4/1pUJ2xSdpufrvnTVOwpp8XRkh207aO4YL2alEoJO1uPFzKMillKoj1G
 Q3E/N3tOogbtiqbmbWrjI7J6aBQRL155QjwUu3kboFX2vwWZqJm31gcZfLcRDMdJGxHy
 GGaw==
X-Gm-Message-State: AC+VfDylyGBzYDoJxp6of1WzLHsqaKJEOxaz/FmmOeKguTMFd3Hxd+Vz
 CImUD/YjDGy2PBhc2cY2E/Yu+A==
X-Google-Smtp-Source: ACHHUZ5HMV006CE2N413OQd1ovR6huTKJUPqhe6ZO8FPvRQZ3zSB8FhzToqebAruRw8AVSoUVbNP7g==
X-Received: by 2002:a5d:4447:0:b0:313:fd26:6ff4 with SMTP id
 x7-20020a5d4447000000b00313fd266ff4mr1447217wrr.23.1687863960486; 
 Tue, 27 Jun 2023 04:06:00 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u12-20020adfdd4c000000b0030903d44dbcsm10152261wrm.33.2023.06.27.04.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 04:06:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA09B1FFBB;
 Tue, 27 Jun 2023 12:05:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] gdbstub: clean-up vcont handling to avoid goto
Date: Tue, 27 Jun 2023 12:05:53 +0100
Message-Id: <20230627110553.2697758-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

We can handle all the error exit cases by using g_autofree() for the
one thing that needs cleaning up on the exit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9496d7b175..49143c7d83 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -573,7 +573,6 @@ static int gdb_handle_vcont(const char *p)
 {
     int res, signal = 0;
     char cur_action;
-    char *newstates;
     unsigned long tmp;
     uint32_t pid, tid;
     GDBProcess *process;
@@ -581,7 +580,7 @@ static int gdb_handle_vcont(const char *p)
     GDBThreadIdKind kind;
     unsigned int max_cpus = gdb_get_max_cpus();
     /* uninitialised CPUs stay 0 */
-    newstates = g_new0(char, max_cpus);
+    g_autofree char *newstates = g_new0(char, max_cpus);
 
     /* mark valid CPUs with 1 */
     CPU_FOREACH(cpu) {
@@ -597,8 +596,7 @@ static int gdb_handle_vcont(const char *p)
     res = 0;
     while (*p) {
         if (*p++ != ';') {
-            res = -ENOTSUP;
-            goto out;
+            return -ENOTSUP;
         }
 
         cur_action = *p++;
@@ -606,13 +604,12 @@ static int gdb_handle_vcont(const char *p)
             cur_action = qemu_tolower(cur_action);
             res = qemu_strtoul(p, &p, 16, &tmp);
             if (res) {
-                goto out;
+                return res;
             }
             signal = gdb_signal_to_target(tmp);
         } else if (cur_action != 'c' && cur_action != 's') {
             /* unknown/invalid/unsupported command */
-            res = -ENOTSUP;
-            goto out;
+            return -ENOTSUP;
         }
 
         if (*p == '\0' || *p == ';') {
@@ -625,14 +622,12 @@ static int gdb_handle_vcont(const char *p)
         } else if (*p++ == ':') {
             kind = read_thread_id(p, &p, &pid, &tid);
         } else {
-            res = -ENOTSUP;
-            goto out;
+            return -ENOTSUP;
         }
 
         switch (kind) {
         case GDB_READ_THREAD_ERR:
-            res = -EINVAL;
-            goto out;
+            return -EINVAL;
 
         case GDB_ALL_PROCESSES:
             cpu = gdb_first_attached_cpu();
@@ -649,8 +644,7 @@ static int gdb_handle_vcont(const char *p)
             process = gdb_get_process(pid);
 
             if (!process->attached) {
-                res = -EINVAL;
-                goto out;
+                return -EINVAL;
             }
 
             cpu = get_first_cpu_in_process(process);
@@ -668,8 +662,7 @@ static int gdb_handle_vcont(const char *p)
 
             /* invalid CPU/thread specified */
             if (!cpu) {
-                res = -EINVAL;
-                goto out;
+                return -EINVAL;
             }
 
             /* only use if no previous match occourred */
@@ -679,12 +672,9 @@ static int gdb_handle_vcont(const char *p)
             break;
         }
     }
+
     gdbserver_state.signal = signal;
     gdb_continue_partial(newstates);
-
-out:
-    g_free(newstates);
-
     return res;
 }
 
-- 
2.39.2


