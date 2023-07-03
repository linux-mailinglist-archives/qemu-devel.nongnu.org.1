Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97773745DBE
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJre-000873-Vu; Mon, 03 Jul 2023 09:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJrA-0007Zw-Lc
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:44 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr4-0005jH-1P
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso4945943f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391877; x=1690983877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmuKSf2VcTxuXRVZK5WsSbiqmIzeKDjZMTTPleVdJHM=;
 b=nAehpB0dqhFbx05sjTAYP9thSJXd5zlPIIXvFyvfHiLHxGSCczf5SR8aoPgCuqMrH8
 GDEdIL1lcXW34BAbDPxztcegZ7dI7hziGuUqDKI3MPTcqMZEbUMvNAdlOAwCFLesbMcK
 rj1NpnVHxRVosPZGJeOaE2HXwv53mMDiNJoyEdGYQ+rTckBXox94+Hqv1EIn4Bimw++g
 dO2fVjf8R2dPk7G5sZ99+K73okjhMBlwjKFSX0n7/QDcXXl7XUZQaLUOSx5Zq1qms6/r
 cAs/UOywjGCQZlzaYr/DIEm2NE/90GONr5IQElDEYCgqBjqmmUJUeB6ay+z9PnCJ7dub
 hb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391877; x=1690983877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmuKSf2VcTxuXRVZK5WsSbiqmIzeKDjZMTTPleVdJHM=;
 b=hldMEwUiIN7jvQg+gzItILOEL5xu9hDLYze/mypbOPv6VTSm3h5j1DUum+hbQDZ44v
 dHHzglIR9LwkThZ2pDvkj7IQ0OIZ+pH3p4SVeS+qY460UqHvPtDgbz6DOSZDsEK6wn2a
 Sx1tLtBEVzI36GJpZR2Gn5YF6N+75+R0fij/hMG/Z546lQa4rxHDLnX11ay8GwmlyjRY
 NrquBlHeImNV5kVOtH3qlX1C2NjsryDuqMjHfRUFg3quxtPzL3cJWm71Tz3E/iJO9k4D
 G9fqL+N8/NUIGE9OfOiz2IA1Gv1hBUTe0bze+NiMPQDAvHEiE0lH8fsWRlfKimHjil6O
 pntg==
X-Gm-Message-State: ABy/qLY6LrbkPGabK793yNa+4lUNAL0n9DdsDHNrx3Cwzl4NZtzGL3mJ
 rWsUgKnzAOKHdIpHtu3/cqB9DQ==
X-Google-Smtp-Source: APBJJlE/pJ0ZU62cDVFDxAtrv+BkgJBQzKkXHMmSU/tgQPyK0lk6pd8xP8t5cpteZP5bcaHXnMOfiA==
X-Received: by 2002:a5d:452f:0:b0:314:35c2:c4aa with SMTP id
 j15-20020a5d452f000000b0031435c2c4aamr3118277wra.8.1688391876848; 
 Mon, 03 Jul 2023 06:44:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a5d6dc1000000b00304adbeeabbsm25621931wrz.99.2023.07.03.06.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1AA8A1FFD2;
 Mon,  3 Jul 2023 14:44:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/38] gdbstub: lightly refactor connection to avoid snprintf
Date: Mon,  3 Jul 2023 14:44:17 +0100
Message-Id: <20230703134427.1389440-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
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

This may be a bit too much to avoid an snprintf and the slightly dodgy
assign to a const variable. But hopefully not.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-29-alex.bennee@linaro.org>

diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index 99d994e6bf..f509b7285d 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -332,11 +332,9 @@ static void create_processes(GDBState *s)
 
 int gdbserver_start(const char *device)
 {
-    trace_gdbstub_op_start(device);
-
-    char gdbstub_device_name[128];
     Chardev *chr = NULL;
     Chardev *mon_chr;
+    g_autoptr(GString) cs = g_string_new(device);
 
     if (!first_cpu) {
         error_report("gdbstub: meaningless to attach gdb to a "
@@ -350,15 +348,16 @@ int gdbserver_start(const char *device)
         return -1;
     }
 
-    if (!device) {
+    if (cs->len == 0) {
         return -1;
     }
-    if (strcmp(device, "none") != 0) {
-        if (strstart(device, "tcp:", NULL)) {
+
+    trace_gdbstub_op_start(cs->str);
+
+    if (g_strcmp0(cs->str, "none") != 0) {
+        if (g_str_has_prefix(cs->str, "tcp:")) {
             /* enforce required TCP attributes */
-            snprintf(gdbstub_device_name, sizeof(gdbstub_device_name),
-                     "%s,wait=off,nodelay=on,server=on", device);
-            device = gdbstub_device_name;
+            g_string_append_printf(cs, ",wait=off,nodelay=on,server=on");
         }
 #ifndef _WIN32
         else if (strcmp(device, "stdio") == 0) {
@@ -373,7 +372,7 @@ int gdbserver_start(const char *device)
          * FIXME: it's a bit weird to allow using a mux chardev here
          * and implicitly setup a monitor. We may want to break this.
          */
-        chr = qemu_chr_new_noreplay("gdb", device, true, NULL);
+        chr = qemu_chr_new_noreplay("gdb", cs->str, true, NULL);
         if (!chr) {
             return -1;
         }
-- 
2.39.2


